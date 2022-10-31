Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB86613C32
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiJaRbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJaRbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:31:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927E7DF31
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:31:30 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=irc.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1opYdB-00006r-LR; Mon, 31 Oct 2022 18:31:25 +0100
Message-ID: <8c04e9bbc8d48946c60ff56ef7f20bef74e3c401.camel@pengutronix.de>
Subject: Re: [PATCH] kconfig: fix segmentation fault in menuconfig search
From:   Johannes Zink <j.zink@pengutronix.de>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Ariel Marcovitch <arielmarcovitch@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 31 Oct 2022 18:31:20 +0100
In-Reply-To: <20221023191055.85098-1-masahiroy@kernel.org>
References: <20221023191055.85098-1-masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Mon, 2022-10-24 at 04:10 +0900, Masahiro Yamada wrote:
> Since commit d05377e184fc ("kconfig: Create links to main menu items
> in search"), menuconfig shows a jump key next to "Main menu" if the
> nearest visible parent is the rootmenu. If you press that jump key,
> menuconfig crashes with a segmentation fault.
> 
> For example, do this:
> 
>   $ make ARCH=arm64 allnoconfig menuconfig
> 
> Press '/' to search for the string "ACPI". Press '1' to choose
> "(1) Main menu". Then, menuconfig crashed with a segmentation fault.
> 
> The following code in search_conf()
> 
>     conf(targets[i]->parent, targets[i]);
> 
> results in NULL pointer dereference because targets[i] is the
> rootmenu,
> which does not have a parent.
> 
> Commit d05377e184fc tried to fix the issue of top-level items not
> having
> a jump key, but adding the "Main menu" was not the right fix.
> 
> The correct fix is to show the searched item itself. This fixes
> another
> weird behavior described in the comment block.
> 
> Fixes: d05377e184fc ("kconfig: Create links to main menu items in
> search")
> Reported-by: Johannes Zink <j.zink@pengutronix.de>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Sorry for the delay, I eventually found time to test your patch, and it
fixes the issue I reported. Thank you for helping out, feel free to add
my

Tested-by: Johannes Zink <j.zink@pengutronix.de>

> ---
> 
>  scripts/kconfig/menu.c | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
> index 62b6313f51c8..109325f31bef 100644
> --- a/scripts/kconfig/menu.c
> +++ b/scripts/kconfig/menu.c
> @@ -722,8 +722,8 @@ static void get_prompt_str(struct gstr *r, struct
> property *prop,
>         if (!expr_eq(prop->menu->dep, prop->visible.expr))
>                 get_dep_str(r, prop->visible.expr, "  Visible if: ");
>  
> -       menu = prop->menu->parent;
> -       for (i = 0; menu && i < 8; menu = menu->parent) {
> +       menu = prop->menu;
> +       for (i = 0; menu != &rootmenu && i < 8; menu = menu->parent)
> {
>                 bool accessible = menu_is_visible(menu);
>  
>                 submenu[i++] = menu;
> @@ -733,16 +733,7 @@ static void get_prompt_str(struct gstr *r,
> struct property *prop,
>         if (head && location) {
>                 jump = xmalloc(sizeof(struct jump_key));
>  
> -               if (menu_is_visible(prop->menu)) {
> -                       /*
> -                        * There is not enough room to put the hint
> at the
> -                        * beginning of the "Prompt" line. Put the
> hint on the
> -                        * last "Location" line even when it would
> belong on
> -                        * the former.
> -                        */
> -                       jump->target = prop->menu;
> -               } else
> -                       jump->target = location;
> +               jump->target = location;
>  
>                 if (list_empty(head))
>                         jump->index = 0;
> @@ -758,13 +749,7 @@ static void get_prompt_str(struct gstr *r,
> struct property *prop,
>                 menu = submenu[i];
>                 if (jump && menu == location)
>                         jump->offset = strlen(r->s);
> -
> -               if (menu == &rootmenu)
> -                       /* The real rootmenu prompt is ugly */
> -                       str_printf(r, "%*cMain menu", j, ' ');
> -               else
> -                       str_printf(r, "%*c-> %s", j, ' ',
> menu_get_prompt(menu));
> -
> +               str_printf(r, "%*c-> %s", j, ' ',
> menu_get_prompt(menu));
>                 if (menu->sym) {
>                         str_printf(r, " (%s [=%s])", menu->sym->name
> ?
>                                 menu->sym->name : "<choice>",

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

