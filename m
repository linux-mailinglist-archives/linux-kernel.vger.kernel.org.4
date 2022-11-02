Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3375B615DE0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiKBIgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKBIgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:36:32 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F181A19C;
        Wed,  2 Nov 2022 01:36:31 -0700 (PDT)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2A28aEJ8031478;
        Wed, 2 Nov 2022 17:36:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2A28aEJ8031478
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1667378175;
        bh=dDwYrbtyAzndbrpCPMQ4b/+qE79Xq0pwlBypNXvEf3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hOiuqSR/T/VgZje1tOrN54QWDUjrUnwK7i0VH4Dn58fTfeskL0xqmHUU+sxeap0vg
         hQpcvuvxoTaHcXsKSZELTb+wts+8t4i5vNZvPchML3PlPfoYtdwhJ73cWoQAjVYzbn
         +ckPsMAc90obxKLGkhfble2BYlZ/KK56u86OQMliiyYkayy7+ZDTqJ4+N40quGfbY+
         aNUlk6muhgm8QeAVx0TlxOy7d4a2usyjDkljMi1QpzZmvICXqcNiQIl3XpFK/UpNxt
         ykFm/j/F/V/a5d5N3t4bc4mrrkcRu6PIrQL64LmvzVadCUrAZyNV1sE3lKaejCSM3C
         huEWXbEPO3Oqg==
X-Nifty-SrcIP: [209.85.167.175]
Received: by mail-oi1-f175.google.com with SMTP id s206so18533463oie.3;
        Wed, 02 Nov 2022 01:36:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf15/rspUDvsD5fZCd3K9/AJZrQi3ggDXluLhUlpWVLvDY1ypJRb
        +aAZD2tWGxuML7FMDJabcEamhRzHiKuoXl+uzEs=
X-Google-Smtp-Source: AMsMyM7MA9H+75leTUw+wTyqhbVuf/JWA9dHb0mF86T4B0fWwDRVUst3soNL69NFhihQMYFJp/3Sc3kgaa95UX0Mq0U=
X-Received: by 2002:a05:6808:13cf:b0:35a:3617:d5da with SMTP id
 d15-20020a05680813cf00b0035a3617d5damr2199262oiw.287.1667378174040; Wed, 02
 Nov 2022 01:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221023191055.85098-1-masahiroy@kernel.org> <8c04e9bbc8d48946c60ff56ef7f20bef74e3c401.camel@pengutronix.de>
In-Reply-To: <8c04e9bbc8d48946c60ff56ef7f20bef74e3c401.camel@pengutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 2 Nov 2022 17:35:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNATzANbYu9E1w5k0BxG_R8TpuZvxUv==T32iiRcfdNrxVA@mail.gmail.com>
Message-ID: <CAK7LNATzANbYu9E1w5k0BxG_R8TpuZvxUv==T32iiRcfdNrxVA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: fix segmentation fault in menuconfig search
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     linux-kbuild@vger.kernel.org,
        Ariel Marcovitch <arielmarcovitch@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 2:31 AM Johannes Zink <j.zink@pengutronix.de> wrote:
>
> Hi Masahiro,
>
> On Mon, 2022-10-24 at 04:10 +0900, Masahiro Yamada wrote:
> > Since commit d05377e184fc ("kconfig: Create links to main menu items
> > in search"), menuconfig shows a jump key next to "Main menu" if the
> > nearest visible parent is the rootmenu. If you press that jump key,
> > menuconfig crashes with a segmentation fault.
> >
> > For example, do this:
> >
> >   $ make ARCH=arm64 allnoconfig menuconfig
> >
> > Press '/' to search for the string "ACPI". Press '1' to choose
> > "(1) Main menu". Then, menuconfig crashed with a segmentation fault.
> >
> > The following code in search_conf()
> >
> >     conf(targets[i]->parent, targets[i]);
> >
> > results in NULL pointer dereference because targets[i] is the
> > rootmenu,
> > which does not have a parent.
> >
> > Commit d05377e184fc tried to fix the issue of top-level items not
> > having
> > a jump key, but adding the "Main menu" was not the right fix.
> >
> > The correct fix is to show the searched item itself. This fixes
> > another
> > weird behavior described in the comment block.
> >
> > Fixes: d05377e184fc ("kconfig: Create links to main menu items in
> > search")
> > Reported-by: Johannes Zink <j.zink@pengutronix.de>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Sorry for the delay, I eventually found time to test your patch, and it
> fixes the issue I reported. Thank you for helping out, feel free to add
> my
>
> Tested-by: Johannes Zink <j.zink@pengutronix.de>


Applied to linux-kbuild/fixes.



> > ---
> >
> >  scripts/kconfig/menu.c | 23 ++++-------------------
> >  1 file changed, 4 insertions(+), 19 deletions(-)
> >
> > diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
> > index 62b6313f51c8..109325f31bef 100644
> > --- a/scripts/kconfig/menu.c
> > +++ b/scripts/kconfig/menu.c
> > @@ -722,8 +722,8 @@ static void get_prompt_str(struct gstr *r, struct
> > property *prop,
> >         if (!expr_eq(prop->menu->dep, prop->visible.expr))
> >                 get_dep_str(r, prop->visible.expr, "  Visible if: ");
> >
> > -       menu = prop->menu->parent;
> > -       for (i = 0; menu && i < 8; menu = menu->parent) {
> > +       menu = prop->menu;
> > +       for (i = 0; menu != &rootmenu && i < 8; menu = menu->parent)
> > {
> >                 bool accessible = menu_is_visible(menu);
> >
> >                 submenu[i++] = menu;
> > @@ -733,16 +733,7 @@ static void get_prompt_str(struct gstr *r,
> > struct property *prop,
> >         if (head && location) {
> >                 jump = xmalloc(sizeof(struct jump_key));
> >
> > -               if (menu_is_visible(prop->menu)) {
> > -                       /*
> > -                        * There is not enough room to put the hint
> > at the
> > -                        * beginning of the "Prompt" line. Put the
> > hint on the
> > -                        * last "Location" line even when it would
> > belong on
> > -                        * the former.
> > -                        */
> > -                       jump->target = prop->menu;
> > -               } else
> > -                       jump->target = location;
> > +               jump->target = location;
> >
> >                 if (list_empty(head))
> >                         jump->index = 0;
> > @@ -758,13 +749,7 @@ static void get_prompt_str(struct gstr *r,
> > struct property *prop,
> >                 menu = submenu[i];
> >                 if (jump && menu == location)
> >                         jump->offset = strlen(r->s);
> > -
> > -               if (menu == &rootmenu)
> > -                       /* The real rootmenu prompt is ugly */
> > -                       str_printf(r, "%*cMain menu", j, ' ');
> > -               else
> > -                       str_printf(r, "%*c-> %s", j, ' ',
> > menu_get_prompt(menu));
> > -
> > +               str_printf(r, "%*c-> %s", j, ' ',
> > menu_get_prompt(menu));
> >                 if (menu->sym) {
> >                         str_printf(r, " (%s [=%s])", menu->sym->name
> > ?
> >                                 menu->sym->name : "<choice>",
>
> --
> Pengutronix e.K.                | Johannes Zink                  |
> Steuerwalder Str. 21            | https://www.pengutronix.de/    |
> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
>


-- 
Best Regards
Masahiro Yamada
