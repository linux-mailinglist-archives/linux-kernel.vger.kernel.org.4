Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F906095C3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 21:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiJWTLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 15:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiJWTLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 15:11:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302585E315;
        Sun, 23 Oct 2022 12:11:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE83260F13;
        Sun, 23 Oct 2022 19:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA70C433D6;
        Sun, 23 Oct 2022 19:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666552266;
        bh=QXMXZXfUd2He0sZ86vmXuZdVlINZFlf8nls9igCZXrs=;
        h=From:To:Cc:Subject:Date:From;
        b=oEZMesga1zur/XSb+z97i5myMe8rcjp1vTVwVy3hCkhdlN/7Fo2QTpx5xjfWs2Brn
         PYhL/GNlhbjQU3nnhlqBV4qIlzXiNI5WZ7A5THR06H43dsIWIHZgnxBH5RcI4jp6XN
         F81BGm+Yx640l0HtNjgXKHudewVcSvtdtzk6KifxOmGqomYp40TaFWwmxw9UDAXiUy
         CUj0/U8tGOpQ62qvonM5v7GSE8L+2g/VYaeXbeJtypbaPLhTx5jG1ZXM1QtAlBDtcZ
         apjMpjcjfalYhj916E/+bvvKHN6yUZ1zFH92e7A37613L7HzIA5PZBV+zSVCfw5OlL
         TmJEHVrbVUXFg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Johannes Zink <j.zink@pengutronix.de>,
        Ariel Marcovitch <arielmarcovitch@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: fix segmentation fault in menuconfig search
Date:   Mon, 24 Oct 2022 04:10:55 +0900
Message-Id: <20221023191055.85098-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d05377e184fc ("kconfig: Create links to main menu items
in search"), menuconfig shows a jump key next to "Main menu" if the
nearest visible parent is the rootmenu. If you press that jump key,
menuconfig crashes with a segmentation fault.

For example, do this:

  $ make ARCH=arm64 allnoconfig menuconfig

Press '/' to search for the string "ACPI". Press '1' to choose
"(1) Main menu". Then, menuconfig crashed with a segmentation fault.

The following code in search_conf()

    conf(targets[i]->parent, targets[i]);

results in NULL pointer dereference because targets[i] is the rootmenu,
which does not have a parent.

Commit d05377e184fc tried to fix the issue of top-level items not having
a jump key, but adding the "Main menu" was not the right fix.

The correct fix is to show the searched item itself. This fixes another
weird behavior described in the comment block.

Fixes: d05377e184fc ("kconfig: Create links to main menu items in search")
Reported-by: Johannes Zink <j.zink@pengutronix.de>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/menu.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
index 62b6313f51c8..109325f31bef 100644
--- a/scripts/kconfig/menu.c
+++ b/scripts/kconfig/menu.c
@@ -722,8 +722,8 @@ static void get_prompt_str(struct gstr *r, struct property *prop,
 	if (!expr_eq(prop->menu->dep, prop->visible.expr))
 		get_dep_str(r, prop->visible.expr, "  Visible if: ");
 
-	menu = prop->menu->parent;
-	for (i = 0; menu && i < 8; menu = menu->parent) {
+	menu = prop->menu;
+	for (i = 0; menu != &rootmenu && i < 8; menu = menu->parent) {
 		bool accessible = menu_is_visible(menu);
 
 		submenu[i++] = menu;
@@ -733,16 +733,7 @@ static void get_prompt_str(struct gstr *r, struct property *prop,
 	if (head && location) {
 		jump = xmalloc(sizeof(struct jump_key));
 
-		if (menu_is_visible(prop->menu)) {
-			/*
-			 * There is not enough room to put the hint at the
-			 * beginning of the "Prompt" line. Put the hint on the
-			 * last "Location" line even when it would belong on
-			 * the former.
-			 */
-			jump->target = prop->menu;
-		} else
-			jump->target = location;
+		jump->target = location;
 
 		if (list_empty(head))
 			jump->index = 0;
@@ -758,13 +749,7 @@ static void get_prompt_str(struct gstr *r, struct property *prop,
 		menu = submenu[i];
 		if (jump && menu == location)
 			jump->offset = strlen(r->s);
-
-		if (menu == &rootmenu)
-			/* The real rootmenu prompt is ugly */
-			str_printf(r, "%*cMain menu", j, ' ');
-		else
-			str_printf(r, "%*c-> %s", j, ' ', menu_get_prompt(menu));
-
+		str_printf(r, "%*c-> %s", j, ' ', menu_get_prompt(menu));
 		if (menu->sym) {
 			str_printf(r, " (%s [=%s])", menu->sym->name ?
 				menu->sym->name : "<choice>",
-- 
2.34.1

