Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43F9609A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 07:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiJXF4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 01:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJXF4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 01:56:36 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0452056002;
        Sun, 23 Oct 2022 22:56:34 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 219CF1E80D74;
        Mon, 24 Oct 2022 13:55:18 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1Tfw875md579; Mon, 24 Oct 2022 13:55:15 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 427D91E80CA5;
        Mon, 24 Oct 2022 13:55:15 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] lxdialog: menubox: Add malloc allocation judgment
Date:   Mon, 24 Oct 2022 13:56:29 +0800
Message-Id: <20221024055629.178198-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add menu_item Only when the pointer judges that the pointer is valid
can function code be executed.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 scripts/kconfig/lxdialog/menubox.c | 53 +++++++++++++++---------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index 58c2f8afe59b..2ae263ad477e 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -55,34 +55,35 @@ static void do_print_item(WINDOW * win, const char *item, int line_y,
 {
 	int j;
 	char *menu_item = malloc(menu_width + 1);
+	if (menu_item) {
+		strncpy(menu_item, item, menu_width - item_x);
+		menu_item[menu_width - item_x] = '\0';
+		j = first_alpha(menu_item, "YyNnMmHh");
 
-	strncpy(menu_item, item, menu_width - item_x);
-	menu_item[menu_width - item_x] = '\0';
-	j = first_alpha(menu_item, "YyNnMmHh");
-
-	/* Clear 'residue' of last item */
-	wattrset(win, dlg.menubox.atr);
-	wmove(win, line_y, 0);
-#if OLD_NCURSES
-	{
-		int i;
-		for (i = 0; i < menu_width; i++)
-			waddch(win, ' ');
-	}
-#else
-	wclrtoeol(win);
-#endif
-	wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
-	mvwaddstr(win, line_y, item_x, menu_item);
-	if (hotkey) {
-		wattrset(win, selected ? dlg.tag_key_selected.atr
-			 : dlg.tag_key.atr);
-		mvwaddch(win, line_y, item_x + j, menu_item[j]);
-	}
-	if (selected) {
-		wmove(win, line_y, item_x + 1);
+		/* Clear 'residue' of last item */
+		wattrset(win, dlg.menubox.atr);
+		wmove(win, line_y, 0);
+	#if OLD_NCURSES
+		{
+			int i;
+			for (i = 0; i < menu_width; i++)
+				waddch(win, ' ');
+		}
+	#else
+		wclrtoeol(win);
+	#endif
+		wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
+		mvwaddstr(win, line_y, item_x, menu_item);
+		if (hotkey) {
+			wattrset(win, selected ? dlg.tag_key_selected.atr
+				 : dlg.tag_key.atr);
+			mvwaddch(win, line_y, item_x + j, menu_item[j]);
+		}
+		if (selected) {
+			wmove(win, line_y, item_x + 1);
+		}
+		free(menu_item);
 	}
-	free(menu_item);
 	wrefresh(win);
 }
 
-- 
2.18.2

