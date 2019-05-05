(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (adwaita)))
 '(package-selected-packages (quote (poly-markdown polymode poly-org poly-R auto-complete ess))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "unknown" :slant normal :weight normal :height 130 :width normal)))))

;; Initializing message
(setq initial-scratch-message "")


;; ESS disable indent automation.----------------------------------------------
(setq ess-indent-with-fancy-comments nil)

;; ESS smart underscore -------------------------------------------------------
(setq ess-toggle-underscore nil)
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/ess-su"))
;;(require 'ess-smart-underscore)

;; Package Repositories --------------------------------------------------------
(require 'package)

(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)


;; Auto-complete in ESS -------------------------------------------------------


(defun my-auto-hook ()
  (auto-complete-mode 1)
  ;; Colors
  (set-face-attribute 'popup-tip-face nil :background "#bfbaac" :foreground "black")
  (define-key ac-completing-map [return] nil)
  (define-key ac-completing-map "\r" nil)
  )
(add-hook 'ess-mode-hook 'my-auto-hook)
(add-hook 'inferior-ess-mode-hook 'my-auto-hook)

(ac-config-default)
(setq ess-use-auto-complete t)

;; Poly-mode in Emacs --------------------------------------------------------

(defun rmd-mode ()
  "ESS Markdown mode for rmd files"
  (interactive)
  ;; (setq load-path
  ;; 	(append (list "path/to/polymode/" "path/to/polymode/modes/")
  ;; 		load-path))
  (require 'poly-R)
  (require 'poly-markdown)
  (poly-markdown+r-mode))

;; Enable transient mark mode
(transient-mark-mode 1)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen

;; Split window upon start. ----------------------------------------------------
(split-window-right)


;; Define custom code chunks.

;; This function will allow conveniently adding a section header in the format as below:
;; #---------------------
;; # Function section
;; #---------------------
(defun tws-insert-r-section-header (header) 
  "Insert an r-chunk in markdown mode. Necessary due to interactions between polymode and yas snippet" 
  (interactive "sHeader: ") 
  (insert (concat "#--------------------------------------------------------------------------------"
		  "\n#" header "\n"
		  "#--------------------------------------------------------------------------------"
		  "\n")) 
  (forward-line -1))
