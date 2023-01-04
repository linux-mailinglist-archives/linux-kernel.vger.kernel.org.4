Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5687D65CC0F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 04:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbjADDBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 22:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjADDB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 22:01:28 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B443E0A0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 19:01:27 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id j130so22994621oif.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 19:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tXByn+ACuglAkHudoIgfKGJhzxKIbiM9K1erxGhIcNA=;
        b=ErKhEwszuKNipZkCwv1KMipcE6tY/azpRjAGmdbpKY7Lg58pfh6HnyNcAREc5lTbP1
         /HHfE2BsVnonfOrf7Chf4/QCU1W4yVWHDX7FUjwzWOwCC4FrdWqVmtk4xTlBUy1FJ2Hf
         MCBf2g/4InAmkpmqwZBv1cI9wR45AYLPoE+Njtu/klZ3/rvC4MZoD6PHPBew9tiD9QRe
         i9/ESLHoOSMe+fMH3lAvLXEEFavNdC6Rtk3h8NKnSogyzfq+M5EJWTDNBfWd+c4QnAdz
         SXxqysUkNZuLlz+w7zowJuivNcYwZqxLqYRoA2z+YCJtVS117W6qEWxOtx7RPbBTjZxF
         OWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXByn+ACuglAkHudoIgfKGJhzxKIbiM9K1erxGhIcNA=;
        b=dS0AEXGSh7ZxIq1WtYq0Wry9bj93qFar9Ajh7K+VrU4KkNz59bgWINUjzJHOTzl1Gw
         vFgv3rSLJAuuN9niGTo8Uwc/gdfgo39O7dtRuEiik/E+zFN8gBv+OWO2J3EW7SXlH/1W
         3zpNHapm7qUeOldKTU7Yq7QQ3SYb+JetptpgGCOLi539JtPk3QZFkZ/LA7csOoobJuzp
         VBGnm3zINFBEUFsJQnyhYBDY5Q56+x17u/NE8/i/7ZKQSdbhsm96JCfZfjgRm/Jb5t2G
         VCpd9qCjOvgXoaDYAqkInnLdQCKlHdYb0tWpDuE+u8NbNKlF8cX7Zx4vNbNZUAQvAYa0
         eMOQ==
X-Gm-Message-State: AFqh2kqHZITkxo1iKNhsEnZ+t4qlfqT7/WPAqPJsahDp5RBtmsvJpizv
        pLZxHBQAcFS9Lzf81bO7cwaIILl1GWve6KE93Jg=
X-Google-Smtp-Source: AMrXdXsty4xiKDcJpM/qWVKzWMjWoaJW7DfG+GiRnj2HqGfJSwTqeah5aJ4GAV6fnKI/57kVeEo8v/Iwxv7BjiJZXaE=
X-Received: by 2002:a05:6808:c:b0:35d:ff69:49c0 with SMTP id
 u12-20020a056808000c00b0035dff6949c0mr2945782oic.146.1672801286576; Tue, 03
 Jan 2023 19:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20221229064153.23511-1-zh.nvgt@gmail.com> <182d36d5-df77-2479-882a-5bb588c5f170@kernel.org>
In-Reply-To: <182d36d5-df77-2479-882a-5bb588c5f170@kernel.org>
From:   Hang Zhang <zh.nvgt@gmail.com>
Date:   Tue, 3 Jan 2023 22:01:15 -0500
Message-ID: <CAO2zrtaGnfH2yYttq4WqeD40Gt9_gerR7sy1szZotbOP+muW5A@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: add some NULL checks for vc_data
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>,
        Helge Deller <deller@gmx.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 4:24 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 29. 12. 22, 7:41, Hang Zhang wrote:
> > vc_selection(), do_blank_screen() and scrollfront() all access "vc_data"
> > structures obtained from the global "vc_cons[fg_console].d", which can
> > be freed and nullified (e.g., in the error path of vc_allocate()). But
> > these functions don't have any NULL checks against the pointers before
> > dereferencing them, causing potentially use-after-free or null pointer
> > dereference.
>
> Could you elaborate under what circumstances is fg_console set to a
> non-allocated console?

Hi, Jiri, thank you for your reply! I am not a developer for tty
subsystem, so the reasoning here is based on my best-effort code
reading. Please correct me if I am wrong.

This patch is based on several observations:

(1) at the beginning of vc_selection() (where one NULL check is
inserted in this patch), poke_blanked_console() is invoked, which
explicitly checks whether "vc_cons[fg_console].d" is NULL, suggesting
the possibility of "fg_console" associated with an unallocated console
at this point. However, poke_blanked_console() returns "void", so
even if "fg_console" is NULL, after returning to vc_selection(),
it will just keep executing, resulting in the possible NULL pointer
dereference later ("vc" in vc_selection() can be "vc_cons[fg_console].d"
if called from set_selection_kernel()). So this patch actually tries
to make the already existing NULL check take effect on the control
flow (e.g., early return if NULL).

(2) a similar NULL check for "vc_cons[fg_console].d" can also be found
in do_unblank_screen() ("if (!vc_cons_allocated(fg_console))") before
accessing the corresponding "vc_data". I do notice that the NULL check
has a comment "/* impossible */", but the check has not been removed so
far. My guess is that there might still be a chance that it can be
unallocated at that point.

(3) regarding how "fg_console" can be unallocated, one place I noticed
is vc_allocate() (invoked from vt_ioctl$VT_ACTIVATE), where the user
can specify the index of "vc_cons" to be activated (can be "fg_console"
in theory). If any error happens and the code under the label "err_free"
is executed, then "vc_cons[fg_console].d" can be freed and nullified.
But I am not sure about the exact scenario/flow to make "fg_console"
unallocated, as this seems to need a thorough understanding of all places
manipulating "fg_console" across the whole subsystem (including the
synchronization between them).

So, in conclusion, I cannot exclude the possibility of potential
NULL dereference/use-after-free issues with my limited domain
knowledge. Inspired by existing checks in the code as aforementioned,
I think it's safer to add some additional NULL checks. If the developers
finally decide that "fg_console" cannot be unallocated in reality,
then maybe we should also consider removing some unnecessary checks.

>
> > Prevent these potential issues by placing NULL checks in these functions
> > before accessing "vc_data" structures. Similar checks can be found in
> > other functions like vt_console_print() and poke_blanked_console().
> >
> > Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
> > ---
> >   drivers/tty/vt/selection.c | 3 +++
> >   drivers/tty/vt/vt.c        | 5 +++++
> >   2 files changed, 8 insertions(+)
> >
> > diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> > index 6ef22f01cc51..c727fd947683 100644
> > --- a/drivers/tty/vt/selection.c
> > +++ b/drivers/tty/vt/selection.c
> > @@ -319,6 +319,9 @@ static int vc_selection(struct vc_data *vc, struct tiocl_selection *v,
> >   {
> >       int ps, pe;
> >
> > +     if (!vc)
> > +             return 0;
> > +
> >       poke_blanked_console();
> >
> >       if (v->sel_mode == TIOCL_SELCLEAR) {
> > diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> > index 981d2bfcf9a5..00f8fdc61e9f 100644
> > --- a/drivers/tty/vt/vt.c
> > +++ b/drivers/tty/vt/vt.c
> > @@ -1493,6 +1493,8 @@ void scrollback(struct vc_data *vc)
> >
> >   void scrollfront(struct vc_data *vc, int lines)
> >   {
> > +     if (!vc)
> > +             return;
> >       if (!lines)
> >               lines = vc->vc_rows / 2;
> >       scrolldelta(lines);
> > @@ -4346,6 +4348,9 @@ void do_blank_screen(int entering_gfx)
> >       struct vc_data *vc = vc_cons[fg_console].d;
> >       int i;
> >
> > +     if (!vc)
> > +             return;
> > +
> >       might_sleep();
> >
> >       WARN_CONSOLE_UNLOCKED();
>
> thanks,
> --
> js
> suse labs
>
