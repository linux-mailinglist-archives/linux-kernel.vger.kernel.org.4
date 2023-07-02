Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70485744E43
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 17:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjGBPJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 11:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGBPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 11:09:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01C3E67;
        Sun,  2 Jul 2023 08:09:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D66A60C23;
        Sun,  2 Jul 2023 15:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D361C433C8;
        Sun,  2 Jul 2023 15:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688310582;
        bh=qYxj8FKfyA8BqS7gNXhxOkvG6rseYZjPp8at5kUg6i8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k/E3kpP3brDnwOLzcQB/glehVf910J9kZBduzkziouCApRzWe8sIVg9Jzr2Pn9o6v
         5DIHykwGgSgW3odLVCt0CBx1W7GecvRkzpHFEHGHIjuWVfOFVpyBcUFFT11w/hp//J
         zN5p3dgGPW/Joq2VI9/wpvEaD9NEGYKLXBPrOl3O1XmTHNwCfphubQzYFy+qn8wSYV
         Jm0M8KgOBLM4XnHjwIgvJW2jCtlxhPYmLIy+TIjfdcCTejkgmHPLoSpjF1U2o5TZME
         CRdXv7SHclHEiuG7Zjs4oZH0g2OaSO7eSagu0D1aRSnw+xucXGnehisxHx4GbSgq6f
         nzg7O7cGyZ3fg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-558a79941c6so2188969eaf.3;
        Sun, 02 Jul 2023 08:09:42 -0700 (PDT)
X-Gm-Message-State: AC+VfDz3NSpfcKy20qGsRQEMm+maK4QZCpzx2hy3fjBmOvZSDkdZlBgu
        7QmoFfH/Lm49ipHbDNgXQK262n6aPAeJ2Q8vxeU=
X-Google-Smtp-Source: ACHHUZ6n1ermOSxbljVqr3hVEwhRKvJS33Dp2Z4Y1CWhUSGNXZ0dMcsgPlHYAgAJMl6OCg1henpeTUHlMbyt8aA93RY=
X-Received: by 2002:a4a:3307:0:b0:565:afcf:fd9c with SMTP id
 q7-20020a4a3307000000b00565afcffd9cmr5842787ooq.3.1688310581745; Sun, 02 Jul
 2023 08:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230629160351.2996541-1-masahiroy@kernel.org> <CAJFTR8QzTPzyuKfEpkBP-2f3o5zPCLHvALWk2RFfAfXeiK10Yw@mail.gmail.com>
In-Reply-To: <CAJFTR8QzTPzyuKfEpkBP-2f3o5zPCLHvALWk2RFfAfXeiK10Yw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 3 Jul 2023 00:09:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNASU5m9P7G3zwWdrFydxk-GZq2uKZ2HOfFncB_4AXN+isQ@mail.gmail.com>
Message-ID: <CAK7LNASU5m9P7G3zwWdrFydxk-GZq2uKZ2HOfFncB_4AXN+isQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: menuconfig: simplify global jump key assignment
To:     Jesse T <mr.bossman075@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 1, 2023 at 12:58=E2=80=AFPM Jesse T <mr.bossman075@gmail.com> w=
rote:
>
> On Thu, Jun 29, 2023 at 12:03=E2=80=AFPM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> >
> > Commit 95ac9b3b585d ("menuconfig: Assign jump keys per-page instead
> > of globally") injects a lot of hacks to the bottom of the textbox
> > infrastructure.
> >
> > I reverted many of them without changing the behavior. (almost)
> > Now, the key markers are inserted when constructing the search result
> > instead of updating the text buffer on-the-fly.
> >
> > The buffer passed to the textbox got back to a constant string.
> > The ugly casts from (const char *) to (char *) went away.
> >
> > A disadvantage is that the same key numbers might be diplayed multiple
> > times in the dialog if you use a huge window (but I believe it is
> > unlikely to happen).
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/kconfig/lkc.h              |  1 +
> >  scripts/kconfig/lxdialog/dialog.h  | 10 ++--
> >  scripts/kconfig/lxdialog/textbox.c | 68 +++++++++--------------
> >  scripts/kconfig/mconf.c            | 86 +++++++++++++++++-------------
> >  scripts/kconfig/menu.c             | 22 ++++++--
> >  5 files changed, 97 insertions(+), 90 deletions(-)
> >
> > diff --git a/scripts/kconfig/lkc.h b/scripts/kconfig/lkc.h
> > index e7118d62a45f..d5c27180ce91 100644
> > --- a/scripts/kconfig/lkc.h
> > +++ b/scripts/kconfig/lkc.h
> > @@ -101,6 +101,7 @@ const char *menu_get_prompt(struct menu *menu);
> >  struct menu *menu_get_parent_menu(struct menu *menu);
> >  bool menu_has_help(struct menu *menu);
> >  const char *menu_get_help(struct menu *menu);
> > +int get_jump_key(void);
> >  struct gstr get_relations_str(struct symbol **sym_arr, struct list_hea=
d *head);
> >  void menu_get_ext_help(struct menu *menu, struct gstr *help);
> >
> > diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdial=
og/dialog.h
> > index 347daf25fdc8..cd1b59c24b21 100644
> > --- a/scripts/kconfig/lxdialog/dialog.h
> > +++ b/scripts/kconfig/lxdialog/dialog.h
> > @@ -196,13 +196,9 @@ int first_alpha(const char *string, const char *ex=
empt);
> >  int dialog_yesno(const char *title, const char *prompt, int height, in=
t width);
> >  int dialog_msgbox(const char *title, const char *prompt, int height,
> >                   int width, int pause);
> > -
> > -
> > -typedef void (*update_text_fn)(char *buf, size_t start, size_t end, vo=
id
> > -                              *_data);
> > -int dialog_textbox(const char *title, char *tbuf, int initial_height,
> > -                  int initial_width, int *keys, int *_vscroll, int *_h=
scroll,
> > -                  update_text_fn update_text, void *data);
> > +int dialog_textbox(const char *title, const char *tbuf, int initial_he=
ight,
> > +                  int initial_width, int *_vscroll, int *_hscroll,
> > +                  int (*extra_key_cb)(int, int, int, void *), void *da=
ta);
> >  int dialog_menu(const char *title, const char *prompt,
> >                 const void *selected, int *s_scroll);
> >  int dialog_checklist(const char *title, const char *prompt, int height=
,
> > diff --git a/scripts/kconfig/lxdialog/textbox.c b/scripts/kconfig/lxdia=
log/textbox.c
> > index bc4d4fb1dc75..e6cd7bb83746 100644
> > --- a/scripts/kconfig/lxdialog/textbox.c
> > +++ b/scripts/kconfig/lxdialog/textbox.c
> > @@ -10,8 +10,8 @@
> >
> >  static int hscroll;
> >  static int begin_reached, end_reached, page_length;
> > -static char *buf;
> > -static char *page;
> > +static const char *buf, *page;
> > +static int start, end;
> >
> >  /*
> >   * Go back 'n' lines in text. Called by dialog_textbox().
> > @@ -98,21 +98,10 @@ static void print_line(WINDOW *win, int row, int wi=
dth)
> >  /*
> >   * Print a new page of text.
> >   */
> > -static void print_page(WINDOW *win, int height, int width, update_text=
_fn
> > -                      update_text, void *data)
> > +static void print_page(WINDOW *win, int height, int width)
> >  {
> >         int i, passed_end =3D 0;
> >
> > -       if (update_text) {
> > -               char *end;
> > -
> > -               for (i =3D 0; i < height; i++)
> > -                       get_line();
> > -               end =3D page;
> > -               back_lines(height);
> > -               update_text(buf, page - buf, end - buf, data);
> > -       }
> > -
> >         page_length =3D 0;
> >         for (i =3D 0; i < height; i++) {
> >                 print_line(win, i, width);
> > @@ -142,24 +131,26 @@ static void print_position(WINDOW *win)
> >   * refresh window content
> >   */
> >  static void refresh_text_box(WINDOW *dialog, WINDOW *box, int boxh, in=
t boxw,
> > -                            int cur_y, int cur_x, update_text_fn updat=
e_text,
> > -                            void *data)
> > +                            int cur_y, int cur_x)
>
> The change for refresh_text_box is very large.
> Is there an easy way to split the change of `refresh_text_box` and
> everything else
> while still maintaining bisectability?


I do not think the change is large or complicated.

It just stopped passing down 'update_text' and 'data'.
The same pattern.

The point is this is revert of 95ac9b3b585d

The revert should not be split.


> > @@ -351,11 +333,9 @@ int dialog_textbox(const char *title, char *tbuf, =
int initial_height,
> >                         on_key_resize();
> >                         goto do_resize;
> >                 default:
> > -                       for (i =3D 0; keys[i]; i++) {
> > -                               if (key =3D=3D keys[i]) {
> > -                                       done =3D true;
> > -                                       break;
> > -                               }
> > +                       if (extra_key_cb(key, start, end, data)) {
>
> `extra_key_cb` is null when not used, on the help page this will segfault=
.


Thanks.
I will fix it.




> > diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
> > index b90fff833588..5578b8bc8a23 100644
> > --- a/scripts/kconfig/menu.c
> > +++ b/scripts/kconfig/menu.c
> > @@ -701,6 +701,11 @@ static void get_dep_str(struct gstr *r, struct exp=
r *expr, const char *prefix)
> >         }
> >  }
> >
> > +int __attribute__((weak)) get_jump_key(void)
>
> This seems like a non-optimal solution, otherwise fine.


Do you have a better idea?





--=20
Best Regards
Masahiro Yamada
