Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95EBD74466F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 05:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjGAD6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 23:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGAD6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 23:58:11 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875D292;
        Fri, 30 Jun 2023 20:58:09 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b80ba9326bso18909925ad.1;
        Fri, 30 Jun 2023 20:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688183889; x=1690775889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqWhliuWhy2dcB6TcZx6uSuqrQH/iW5vfhnwx4SeQhM=;
        b=VDhFoVCK8LxUPP/GeGyx5LwzhBowVm99a22RUEaky4D4X3OTHNaVLdCqJ3PQVQ6fz7
         3kOee+lSMJXBlAu52U6vgo/2aMhzjReZACck866icMIt+VW2IAgeVCnVymg3qVqWh/C3
         f/zoyGQt09yvzI2qAFTZ1BonRJGVoZKWueDEP4gOGlWi0vxXnN648tBvCDzWq0bCdoxe
         3NaA12RD74p/Rjh8gTZqsYcjeFsVK7i7TL1IO/J3iA3IYR5Lsuu7POeE40ENkoYEmq6t
         zWF2rm5GwLYKADljTA6I3e1oH6yXFklAshdWbGAokmAEQMvRWRzOML8egB/mfqIx8U7i
         g+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688183889; x=1690775889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqWhliuWhy2dcB6TcZx6uSuqrQH/iW5vfhnwx4SeQhM=;
        b=c9YKzLsQ5WfZ0JfuQurSGWM0WxBjfprTryGKRFmfsbJyQDZ4S2yFrPRH7CCXAXzuok
         G3mF4tb5MBzX0Z6TIkcwKXOtLlXAEUjepQOZi3MVJDAHUnWol6ltUMtZHTZDnpCTmmf6
         4PPMyoSaDEnO4IXJoo2DzijJDv6ZGV+NnXTJBGpn9nIPaGE5lP29g7CE5XL0auOCzZbc
         dd+MOVjcNnULTAd7XpauP5w+8luxvJ9Das0wBWXgl93sgZqUq3SLj1ub8ND4OBXUKjGu
         FVvZvh0JLbP16bQm6LnKNzk+Z9QCJ94M02zOqcRiJRmEPdPhylgOdrLE5sp7ESgNu7P0
         CxZw==
X-Gm-Message-State: ABy/qLaZnE7yOx0zPaGs578nF0vxvhImzvqwTN6XW66lb6eo6HwHs1N3
        hc3mtQeBBMjkIttJ/CcjbhcnWRjwBBCDXDgSqwFsElHPtqw=
X-Google-Smtp-Source: APBJJlHDcyDwibcRirS1RWIEUCRmacHhL7N3UkEF98/MNGBZHPYsSa9QjUE2XF/b0i0HBzeOacfB32b8iTpPWK/8UsA=
X-Received: by 2002:a17:902:c10c:b0:1a5:150f:8558 with SMTP id
 12-20020a170902c10c00b001a5150f8558mr3824926pli.17.1688183888743; Fri, 30 Jun
 2023 20:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230629160351.2996541-1-masahiroy@kernel.org>
In-Reply-To: <20230629160351.2996541-1-masahiroy@kernel.org>
From:   Jesse T <mr.bossman075@gmail.com>
Date:   Fri, 30 Jun 2023 23:57:57 -0400
Message-ID: <CAJFTR8QzTPzyuKfEpkBP-2f3o5zPCLHvALWk2RFfAfXeiK10Yw@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: menuconfig: simplify global jump key assignment
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 12:03=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> Commit 95ac9b3b585d ("menuconfig: Assign jump keys per-page instead
> of globally") injects a lot of hacks to the bottom of the textbox
> infrastructure.
>
> I reverted many of them without changing the behavior. (almost)
> Now, the key markers are inserted when constructing the search result
> instead of updating the text buffer on-the-fly.
>
> The buffer passed to the textbox got back to a constant string.
> The ugly casts from (const char *) to (char *) went away.
>
> A disadvantage is that the same key numbers might be diplayed multiple
> times in the dialog if you use a huge window (but I believe it is
> unlikely to happen).
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/kconfig/lkc.h              |  1 +
>  scripts/kconfig/lxdialog/dialog.h  | 10 ++--
>  scripts/kconfig/lxdialog/textbox.c | 68 +++++++++--------------
>  scripts/kconfig/mconf.c            | 86 +++++++++++++++++-------------
>  scripts/kconfig/menu.c             | 22 ++++++--
>  5 files changed, 97 insertions(+), 90 deletions(-)
>
> diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
> index e7118d62a45f..d5c27180ce91 100644
> --- a/scripts/kconfig/lkc.h
> +++ b/scripts/kconfig/lkc.h
> @@ -101,6 +101,7 @@ const char *menu_get_prompt(struct menu *menu);
>  struct menu *menu_get_parent_menu(struct menu *menu);
>  bool menu_has_help(struct menu *menu);
>  const char *menu_get_help(struct menu *menu);
> +int get_jump_key(void);
>  struct gstr get_relations_str(struct symbol **sym_arr, struct list_head =
*head);
>  void menu_get_ext_help(struct menu *menu, struct gstr *help);
>
> diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog=
/dialog.h
> index 347daf25fdc8..cd1b59c24b21 100644
> --- a/scripts/kconfig/lxdialog/dialog.h
> +++ b/scripts/kconfig/lxdialog/dialog.h
> @@ -196,13 +196,9 @@ int first_alpha(const char *string, const char *exem=
pt);
>  int dialog_yesno(const char *title, const char *prompt, int height, int =
width);
>  int dialog_msgbox(const char *title, const char *prompt, int height,
>                   int width, int pause);
> -
> -
> -typedef void (*update_text_fn)(char *buf, size_t start, size_t end, void
> -                              *_data);
> -int dialog_textbox(const char *title, char *tbuf, int initial_height,
> -                  int initial_width, int *keys, int *_vscroll, int *_hsc=
roll,
> -                  update_text_fn update_text, void *data);
> +int dialog_textbox(const char *title, const char *tbuf, int initial_heig=
ht,
> +                  int initial_width, int *_vscroll, int *_hscroll,
> +                  int (*extra_key_cb)(int, int, int, void *), void *data=
);
>  int dialog_menu(const char *title, const char *prompt,
>                 const void *selected, int *s_scroll);
>  int dialog_checklist(const char *title, const char *prompt, int height,
> diff --git a/scripts/kconfig/lxdialog/textbox.c b/scripts/kconfig/lxdialo=
g/textbox.c
> index bc4d4fb1dc75..e6cd7bb83746 100644
> --- a/scripts/kconfig/lxdialog/textbox.c
> +++ b/scripts/kconfig/lxdialog/textbox.c
> @@ -10,8 +10,8 @@
>
>  static int hscroll;
>  static int begin_reached, end_reached, page_length;
> -static char *buf;
> -static char *page;
> +static const char *buf, *page;
> +static int start, end;
>
>  /*
>   * Go back 'n' lines in text. Called by dialog_textbox().
> @@ -98,21 +98,10 @@ static void print_line(WINDOW *win, int row, int widt=
h)
>  /*
>   * Print a new page of text.
>   */
> -static void print_page(WINDOW *win, int height, int width, update_text_f=
n
> -                      update_text, void *data)
> +static void print_page(WINDOW *win, int height, int width)
>  {
>         int i, passed_end =3D 0;
>
> -       if (update_text) {
> -               char *end;
> -
> -               for (i =3D 0; i < height; i++)
> -                       get_line();
> -               end =3D page;
> -               back_lines(height);
> -               update_text(buf, page - buf, end - buf, data);
> -       }
> -
>         page_length =3D 0;
>         for (i =3D 0; i < height; i++) {
>                 print_line(win, i, width);
> @@ -142,24 +131,26 @@ static void print_position(WINDOW *win)
>   * refresh window content
>   */
>  static void refresh_text_box(WINDOW *dialog, WINDOW *box, int boxh, int =
boxw,
> -                            int cur_y, int cur_x, update_text_fn update_=
text,
> -                            void *data)
> +                            int cur_y, int cur_x)

The change for refresh_text_box is very large.
Is there an easy way to split the change of `refresh_text_box` and
everything else
while still maintaining bisectability?

>  {
> -       print_page(box, boxh, boxw, update_text, data);
> +       start =3D page - buf;
> +
> +       print_page(box, boxh, boxw);
>         print_position(dialog);
>         wmove(dialog, cur_y, cur_x);    /* Restore cursor position */
>         wrefresh(dialog);
> +
> +       end =3D page - buf;
>  }
>
>  /*
>   * Display text from a file in a dialog box.
>   *
>   * keys is a null-terminated array
> - * update_text() may not add or remove any '\n' or '\0' in tbuf
>   */
> -int dialog_textbox(const char *title, char *tbuf, int initial_height,
> -                  int initial_width, int *keys, int *_vscroll, int *_hsc=
roll,
> -                  update_text_fn update_text, void *data)
> +int dialog_textbox(const char *title, const char *tbuf, int initial_heig=
ht,
> +                  int initial_width, int *_vscroll, int *_hscroll,
> +                  int (*extra_key_cb)(int, int, int, void *), void *data=
)
>  {
>         int i, x, y, cur_x, cur_y, key =3D 0;
>         int height, width, boxh, boxw;
> @@ -239,8 +230,7 @@ int dialog_textbox(const char *title, char *tbuf, int=
 initial_height,
>
>         /* Print first page of text */
>         attr_clear(box, boxh, boxw, dlg.dialog.atr);
> -       refresh_text_box(dialog, box, boxh, boxw, cur_y, cur_x, update_te=
xt,
> -                        data);
> +       refresh_text_box(dialog, box, boxh, boxw, cur_y, cur_x);
>
>         while (!done) {
>                 key =3D wgetch(dialog);
> @@ -259,8 +249,7 @@ int dialog_textbox(const char *title, char *tbuf, int=
 initial_height,
>                                 begin_reached =3D 1;
>                                 page =3D buf;
>                                 refresh_text_box(dialog, box, boxh, boxw,
> -                                                cur_y, cur_x, update_tex=
t,
> -                                                data);
> +                                                cur_y, cur_x);
>                         }
>                         break;
>                 case 'G':       /* Last page */
> @@ -270,8 +259,7 @@ int dialog_textbox(const char *title, char *tbuf, int=
 initial_height,
>                         /* point to last char in buf */
>                         page =3D buf + strlen(buf);
>                         back_lines(boxh);
> -                       refresh_text_box(dialog, box, boxh, boxw, cur_y,
> -                                        cur_x, update_text, data);
> +                       refresh_text_box(dialog, box, boxh, boxw, cur_y, =
cur_x);
>                         break;
>                 case 'K':       /* Previous line */
>                 case 'k':
> @@ -280,8 +268,7 @@ int dialog_textbox(const char *title, char *tbuf, int=
 initial_height,
>                                 break;
>
>                         back_lines(page_length + 1);
> -                       refresh_text_box(dialog, box, boxh, boxw, cur_y,
> -                                        cur_x, update_text, data);
> +                       refresh_text_box(dialog, box, boxh, boxw, cur_y, =
cur_x);
>                         break;
>                 case 'B':       /* Previous page */
>                 case 'b':
> @@ -290,8 +277,7 @@ int dialog_textbox(const char *title, char *tbuf, int=
 initial_height,
>                         if (begin_reached)
>                                 break;
>                         back_lines(page_length + boxh);
> -                       refresh_text_box(dialog, box, boxh, boxw, cur_y,
> -                                        cur_x, update_text, data);
> +                       refresh_text_box(dialog, box, boxh, boxw, cur_y, =
cur_x);
>                         break;
>                 case 'J':       /* Next line */
>                 case 'j':
> @@ -300,8 +286,7 @@ int dialog_textbox(const char *title, char *tbuf, int=
 initial_height,
>                                 break;
>
>                         back_lines(page_length - 1);
> -                       refresh_text_box(dialog, box, boxh, boxw, cur_y,
> -                                        cur_x, update_text, data);
> +                       refresh_text_box(dialog, box, boxh, boxw, cur_y, =
cur_x);
>                         break;
>                 case KEY_NPAGE: /* Next page */
>                 case ' ':
> @@ -310,8 +295,7 @@ int dialog_textbox(const char *title, char *tbuf, int=
 initial_height,
>                                 break;
>
>                         begin_reached =3D 0;
> -                       refresh_text_box(dialog, box, boxh, boxw, cur_y,
> -                                        cur_x, update_text, data);
> +                       refresh_text_box(dialog, box, boxh, boxw, cur_y, =
cur_x);
>                         break;
>                 case '0':       /* Beginning of line */
>                 case 'H':       /* Scroll left */
> @@ -326,8 +310,7 @@ int dialog_textbox(const char *title, char *tbuf, int=
 initial_height,
>                                 hscroll--;
>                         /* Reprint current page to scroll horizontally */
>                         back_lines(page_length);
> -                       refresh_text_box(dialog, box, boxh, boxw, cur_y,
> -                                        cur_x, update_text, data);
> +                       refresh_text_box(dialog, box, boxh, boxw, cur_y, =
cur_x);
>                         break;
>                 case 'L':       /* Scroll right */
>                 case 'l':
> @@ -337,8 +320,7 @@ int dialog_textbox(const char *title, char *tbuf, int=
 initial_height,
>                         hscroll++;
>                         /* Reprint current page to scroll horizontally */
>                         back_lines(page_length);
> -                       refresh_text_box(dialog, box, boxh, boxw, cur_y,
> -                                        cur_x, update_text, data);
> +                       refresh_text_box(dialog, box, boxh, boxw, cur_y, =
cur_x);
>                         break;
>                 case KEY_ESC:
>                         if (on_key_esc(dialog) =3D=3D KEY_ESC)
> @@ -351,11 +333,9 @@ int dialog_textbox(const char *title, char *tbuf, in=
t initial_height,
>                         on_key_resize();
>                         goto do_resize;
>                 default:
> -                       for (i =3D 0; keys[i]; i++) {
> -                               if (key =3D=3D keys[i]) {
> -                                       done =3D true;
> -                                       break;
> -                               }
> +                       if (extra_key_cb(key, start, end, data)) {

`extra_key_cb` is null when not used, on the help page this will segfault.

if (extra_key_cb && extra_key_cb(key, start, end, data)) {

> +                               done =3D true;
> +                               break;
>                         }
>                 }
>         }
> diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
> index 53d8834d12fe..7adfd6537279 100644
> --- a/scripts/kconfig/mconf.c
> +++ b/scripts/kconfig/mconf.c
> @@ -288,6 +288,7 @@ static int single_menu_mode;
>  static int show_all_options;
>  static int save_and_exit;
>  static int silent;
> +static int jump_key;
>
>  static void conf(struct menu *menu, struct menu *active_menu);
>
> @@ -348,19 +349,19 @@ static void reset_subtitle(void)
>         set_dialog_subtitles(subtitles);
>  }
>
> -static int show_textbox_ext(const char *title, char *text, int r, int c,=
 int
> -                           *keys, int *vscroll, int *hscroll, update_tex=
t_fn
> -                           update_text, void *data)
> +static int show_textbox_ext(const char *title, const char *text, int r, =
int c,
> +                           int *vscroll, int *hscroll,
> +                           int (*extra_key_cb)(int, int, int, void *),
> +                           void *data)
>  {
>         dialog_clear();
> -       return dialog_textbox(title, text, r, c, keys, vscroll, hscroll,
> -                             update_text, data);
> +       return dialog_textbox(title, text, r, c, vscroll, hscroll,
> +                             extra_key_cb, data);
>  }
>
>  static void show_textbox(const char *title, const char *text, int r, int=
 c)
>  {
> -       show_textbox_ext(title, (char *) text, r, c, (int []) {0}, NULL, =
NULL,
> -                        NULL, NULL);
> +       show_textbox_ext(title, text, r, c, NULL, NULL, NULL, NULL);
>  }
>
>  static void show_helptext(const char *title, const char *text)
> @@ -381,35 +382,51 @@ static void show_help(struct menu *menu)
>
>  struct search_data {
>         struct list_head *head;
> -       struct menu **targets;
> -       int *keys;
> +       struct menu *target;
>  };
>
> -static void update_text(char *buf, size_t start, size_t end, void *_data=
)
> +static int next_key(int key)
> +{
> +       key++;
> +
> +       if (key > '9')
> +               key =3D '1';
> +
> +       return key;
> +}
> +
> +static int handle_search_keys(int key, int start, int end, void *_data)
>  {
>         struct search_data *data =3D _data;
>         struct jump_key *pos;
> -       int k =3D 0;
> +
> +       if (key < '1' || key > '9')
> +               return 0;
>
>         list_for_each_entry(pos, data->head, entries) {
> -               if (pos->offset >=3D start && pos->offset < end) {
> -                       char header[4];
> +               if (pos->offset >=3D start) {
> +                       if (pos->offset >=3D end)
> +                               break;
>
> -                       if (k < JUMP_NB) {
> -                               int key =3D '0' + (pos->index % JUMP_NB) =
+ 1;
> -
> -                               sprintf(header, "(%c)", key);
> -                               data->keys[k] =3D key;
> -                               data->targets[k] =3D pos->target;
> -                               k++;
> -                       } else {
> -                               sprintf(header, "   ");
> +                       if (key =3D=3D '1' + (pos->index % JUMP_NB)) {
> +                               data->target =3D pos->target;
> +                               return 1;
>                         }
> -
> -                       memcpy(buf + pos->offset, header, sizeof(header) =
- 1);
>                 }
>         }
> -       data->keys[k] =3D 0;
> +
> +       return 0;
> +}
> +
> +int get_jump_key(void)
> +{
> +       int cur_key;
> +
> +       cur_key =3D jump_key;
> +
> +       jump_key =3D next_key(cur_key);
> +
> +       return cur_key;
>  }
>
>  static void search_conf(void)
> @@ -456,26 +473,23 @@ static void search_conf(void)
>         sym_arr =3D sym_re_search(dialog_input);
>         do {
>                 LIST_HEAD(head);
> -               struct menu *targets[JUMP_NB];
> -               int keys[JUMP_NB + 1], i;
>                 struct search_data data =3D {
>                         .head =3D &head,
> -                       .targets =3D targets,
> -                       .keys =3D keys,
>                 };
>                 struct jump_key *pos, *tmp;
>
> +               jump_key =3D '1';
>                 res =3D get_relations_str(sym_arr, &head);
>                 set_subtitle();
>                 dres =3D show_textbox_ext("Search Results", str_get(&res)=
, 0, 0,
> -                                       keys, &vscroll, &hscroll, &update=
_text,
> -                                       &data);
> +                                       &vscroll, &hscroll,
> +                                       handle_search_keys, &data);
>                 again =3D false;
> -               for (i =3D 0; i < JUMP_NB && keys[i]; i++)
> -                       if (dres =3D=3D keys[i]) {
> -                               conf(targets[i]->parent, targets[i]);
> -                               again =3D true;
> -                       }
> +               if (dres >=3D '1' && dres <=3D '9') {
> +                       assert(data.target !=3D NULL);
> +                       conf(data.target->parent, data.target);
> +                       again =3D true;
> +               }
>                 str_free(&res);
>                 list_for_each_entry_safe(pos, tmp, &head, entries)
>                         free(pos);
> diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
> index b90fff833588..5578b8bc8a23 100644
> --- a/scripts/kconfig/menu.c
> +++ b/scripts/kconfig/menu.c
> @@ -701,6 +701,11 @@ static void get_dep_str(struct gstr *r, struct expr =
*expr, const char *prefix)
>         }
>  }
>
> +int __attribute__((weak)) get_jump_key(void)

This seems like a non-optimal solution, otherwise fine.

Other than the call to null, looks good. After that change.

Reviewed-by: Jesse Taube <Mr.Bossman075@gmail.com>

Thanks,
Jesse Taube

> +{
> +       return -1;
> +}
> +
>  static void get_prompt_str(struct gstr *r, struct property *prop,
>                            struct list_head *head)
>  {
> @@ -743,11 +748,22 @@ static void get_prompt_str(struct gstr *r, struct p=
roperty *prop,
>         }
>
>         str_printf(r, "  Location:\n");
> -       for (j =3D 4; --i >=3D 0; j +=3D 2) {
> +       for (j =3D 0; --i >=3D 0; j++) {
> +               int jk =3D -1;
> +               int indent =3D 2 * j + 4;
> +
>                 menu =3D submenu[i];
> -               if (jump && menu =3D=3D location)
> +               if (jump && menu =3D=3D location) {
>                         jump->offset =3D strlen(r->s);
> -               str_printf(r, "%*c-> %s", j, ' ', menu_get_prompt(menu));
> +                       jk =3D get_jump_key();
> +               }
> +
> +               if (jk >=3D 0) {
> +                       str_printf(r, "(%c)", jk);
> +                       indent -=3D 3;
> +               }
> +
> +               str_printf(r, "%*c-> %s", indent, ' ', menu_get_prompt(me=
nu));
>                 if (menu->sym) {
>                         str_printf(r, " (%s [=3D%s])", menu->sym->name ?
>                                 menu->sym->name : "<choice>",
> --
> 2.39.2
>
