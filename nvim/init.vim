" todo sobre vim plug {{{
let mapleader = " "
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif

" vim plug es un package manager esencialmente
call plug#begin('~/.vim/plugged')
Plug 'plasticboy/vim-markdown' " markdown
Plug 'chrisbra/csv.vim' " comandos para el csv
Plug 'rafi/awesome-vim-colorschemes' " colorscheme
Plug 'vim-airline/vim-airline' " airline
Plug 'vim-airline/vim-airline-themes' " themes para airline
Plug 'ferrine/md-img-paste.vim'
"Plug 'preservim/nerdtree'
Plug 'vim-python/python-syntax' " syntax python
Plug 'tmhedberg/SimpylFold' " foldea python bien
Plug 'scrooloose/nerdcommenter' " plugin para comentar
Plug 'Raimondi/delimitMate' " auto-paréntesis
"Plug 'godlygeek/tabular' " plugin para pandoc y csv no lo uso nunca
"Plug 'tpope/vim-surround' " surround no lo uso nunca
Plug 'sirver/ultisnips' " better snippets (suscribe Tab)
Plug 'lilydjwg/colorizer' " colors on files
Plug 'lervag/vimtex' "vimtex
Plug 'aserebryakov/vim-todo-lists'
Plug 'dhruvasagar/vim-table-mode' " hay tabla
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'
"Plug 'ncm2/ncm2-bufword'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'hkupty/iron.nvim'
Plug 'szw/vim-maximizer'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'lervag/wiki.vim'
call plug#end()

"}}}

" basic config {{{
	set foldmethod=marker
	colorscheme nord
	set termguicolors " No tener colores chotos
	set bg=dark
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
	set foldlevel=99
	"set nohlsearch
	set path +=**
	set mouse=a
	set tabstop=4
	set shiftwidth=4
	set gdefault
	set inccommand=nosplit
	let g:netrw_dirhistmax = 0
	set splitbelow splitright
	set linebreak
	set pumblend=40
	set cursorline
	set clipboard+=unnamedplus
	se go=a
	set foldmethod=marker
	set shell=/bin/zsh

" }}}

" Relevant config {{{
" Return to last edit position when opening files
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" set n lines to the cursor n=7
  set so=7

" Ignore compiled files
  set wildignore=*.o,*~,*.pyc

" Smartcase
  set ignorecase
  set smartcase

" Automatically deletes all trailing whitespace on save.
  autocmd BufWritePre * %s/\s\+$//e

  " Set undodir persist
  if !isdirectory("/tmp/undo-dir")
    call mkdir("/tmp/undo-dir", "", 0700)
  endif
  set undodir=/tmp/.vim-undo-dir
  set undofile

"cada vez que guardo con vim se actualiza el soruceo de X
autocmd BufWritePost *Xresources,*Xdefaults !xrdb %
"}}}

"  general mappings{{{
nnoremap <s-tab> gt
nmap B :bnext<cr>
nmap <leader>b :buffer


nmap <leader>z Vy:!zathura <C-R>"<cr><cr>
" }}}

"ultisnips{{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/my-snippets/UltiSnips']
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"}}}

" Ale linting con flake8{{{
let g:ale_sign_column_always=1
let g:ale_lint_on_enter=1
let g:ale_lint_on_text_changed='always'
let g:ale_echo_msg_error_str='E'
let g:ale_echo_msg_warning_str='W'
let g:ale_echo_msg_format='[%linter%] %s [%severity%]: [%...code...%]'
let g:ale_linters={'python': ['flake8'], 'r': ['lintr']}
let g:ale_fixers={'python': ['black']}
"}}}

" gitgutter{{{
let g:gitgutter_async=0"
set updatetime=100

" para evitar el overriding de ale/flake8 vs gitgutter
let g:ale_sign_priority=8
let g:gitgutter_sign_priority=9
" }}}

" no uso el default e para end of word así que lo mapeo a easymotion -s{{{
nmap <leader>s <Plug>(easymotion-s)
" }}}

" ncm2{{{
autocmd BufEnter * call ncm2#enable_for_buffer()      " enable ncm2 for all buffers
set completeopt=noinsert,menuone,noselect             " IMPORTANT: :help Ncm2PopupOpen for more information
let g:python3_host_prog='/usr/bin/python3'            " ncm2-jedi}}}

" navegación y resizing windows y terminal{{{
"la i es para llegar a la terminal y estar en insert mode
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>ji
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>li
tmap <C-h> <esc><C-h>
inoremap <C-j> <esc><C-j>
tmap <C-k> <esc><C-k>

" voy a cancelar el resizing gradual porque es muy falopa mapear J y K, y no lo uso anyways.
"noremap <silent> <S-k> :resize -3<CR>
"noremap <silent> <S-j> :resize +3<CR>

" Change 2 split windows from vert to horiz or horiz to vert
map <Leader>h <C-w>t<C-w>H
map <Leader>k <C-w>t<C-w>K

" }}}

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" csv{{{

autocmd FileType csv nmap <buffer> <Leader><Leader> :Tabularize /,<CR>
"}}}

"markdown {{{
autocmd FileType markdown nmap <buffer> <Leader><Leader><CR> :! pandoc % -o %:r.pdf; zathura --fork %:r.pdf<CR><CR>
autocmd FileType markdown nmap <buffer> <Leader><CR> :w<CR>
autocmd FileType markdown nmap <buffer><silent> <Leader>p :call mdip#MarkdownClipboardImage()<CR>


" comento esto para que se me genere un pdf a partir de un .md solo si hago o de arroba y no simpre que guardo un .md
"aug MD2PDF
    "au!
    "au BufWritePost *.md silent !pandoc % -o %:r.pdf
"aug END
"}}}

" python + terminal {{{

" terminal en general {{{

"salir de insert mode en terminal de neovim
tnoremap <esc> <c-\><c-n>

nmap <c-w><c-l> :set scrollback=1 \| sleep 100m \| set scrollback=10000<CR>
tmap <c-w><c-l> <c-\><c-n><c-w><c-l>i<c-l>


" maximizar o poner mitad-mitad
"map <C-m> <C-w>_
"map <C-n> <C-w>=
map <Leader>m :MaximizerToggle<CR>
map <Leader><Leader>m <C-w>=<esc>
"tmap <C-m> :MaximizerToggle<CR>

" no poner line numbers
autocmd TermOpen * setlocal nonumber norelativenumber
" }}}

autocmd FileType python setlocal textwidth=79 colorcolumn=80

"nueva terminal de python
map <Leader>p :new term://zsh<CR>iipython --matplotlib<CR><C-\><C-n><C-w>k"<CR>

" lead-enter {{{
autocmd Filetype python nmap <buffer> <Leader><CR> :update<bar>!python3 %<CR>

"dato: esto de aca arriba genera el mismo resultado que esto:
"nmap <Leader><CR> :w<CR>:!python3 %<CR>
" }}}

" lead-lead-enter {{{
"autocmd FileType python nmap <buffer> <Leader><Leader><CR> :update<bar>vs<Space>\|<Space>terminal ipython -i -c "\%run %"<CR>i

autocmd FileType python nmap <buffer> <Leader><Leader><CR> :update<bar>vs<Space>\|<Space>terminal ipython -i -c "\%run %"<CR>\|:let t:term_id = b:terminal_job_id<CR>\|:execute 'let b:slime_config = {"jobid": "'.t:term_id . '"}'<CR>i
" }}}

"slime {{{
let g:slime_target = 'neovim'

"con solo esa linea slime anda bien con binds default.
" let g:slime_dont_ask_default = 1 si agrego esto tira error

let g:slime_no_mappings = 1
nmap <c-c>v     <Plug>SlimeConfig
xmap <Leader>s <Plug>SlimeRegionSend<CR>
" }}}

" cell {{{
"el segundo CR es para hacer enter luego de que me pregunte por el job id
nmap <Leader><Leader>r :IPythonCellRun<CR><CR>

nmap <Leader>r :IPythonCellExecuteCell<CR><CR>

let g:ipython_cell_tag = ['{{{','}}}']
let g:ipython_cell_send_cell_headers = 1
" }}}

" }}}

" vimwiki "{{{

"let g:vimwiki_list = [{'path': '~/vimwiki/',
                      "\ 'syntax': 'markdown', 'ext': '.md'}]

" en vez de list and select available wikis:
"nmap <Leader>wl <Plug>VimwikiSplitLink

"nmap <Leader><Leader>wl <Plug>VimwikiTabnewLink
"}}}

" wiki.vim {{{
let g:wiki_root = '~/zettelkasten'
let g:wiki_filetypes = ['md', 'wiki']
let g:wiki_link_extension = '.md'


let g:wiki_link_target_type = 'md'

" ver WikiTagList para las opciones; el default era loclist que te deja el titulo de la nota en la que estas, pero echo te da las notas taggeadas mas ordenadas.
" esto es con <leader>wsl
let g:wiki_tag_list = {'output' : 'echo'}

" reminder de los mappings que quiero usar:
" <leader>wb, wg, wG, wd, wr, wsl, wsr, wss
" mas sin <leader>:
"tab para ir al siguiente link en normal mode,
"nmap <c-cr> <plug>(wiki-link-follow)
"cr para crear y/o seguir link (lo remapeo a split window):
"nmap <cr> <plug>(wiki-link-follow-split)
" al final lo deje comentado; hagamos normal que abrir en split sea <c-w><cr?
"pero ojo con esto: si en el link abierto en nuevo split apretás backspace terminás teniendo el archivo original abierto en los dos splits. (esto pasa abriéndolo en otro tab tmb).
nmap \<cr> <plug>(wiki-link-follow-vsplit)
" reemplazo <c-w>u por t<cr> para abrir link en new tab
nmap t<cr> <plug>(wiki-link-follow-tab)

" esto lo quiero usar pero me dice que no tengo fzf
nmap <leader>wfp <plug>(wiki-fzf-pages)
nmap <leader>wft <plug>(wiki-fzf-tags)



"let g:wiki_viewer = {'pdf': 'zathura'}

" para pdfs, lo de netrw me lo paso agus{{{
let g:wiki_file_handler = 'WikiFileHandler'
function! WikiFileHandler(...) abort dict
  if self.path =~# 'pdf$'
    silent execute '!zathura' fnameescape(self.path) '&'
    return 1
  endif

  return 0
endfunction
""""""""""""""""""""""
let g:netrw_browsex_viewer="-"
" functions for file extension '.pdf'.
function! NFH_pdf(f)
	execute '!zathura' a:f
endfunction


" situación: quiero tener un zettelkasten del cual estudiar para un parcial de una materia específica, pero no quiero una wiki para esa materia únicamente, dado que haciendo pages de nam voy a querer linkear a pages que estarán ya en mi zet general. el tema es que desde esa page de zet general seguramente linkeo a cosas que ya se van de lo dictado en la materia; yo quiero estudiar solo lo que me estén tomando; meterme solo en links de la materia. entonces quiero, cuando pongo el cursor en un link, que me diga los tags que tiene. así sé si seguir metiéndome o no.

" otra situación: decidí que quiero tener más de un zettelkasten. lo siento pero si estoy leyendo un paper quiero relacionar los temas del paper primero.


" }}}



" }}}

"luafile $HOME/.config/nvim/lua/plugins.lua

