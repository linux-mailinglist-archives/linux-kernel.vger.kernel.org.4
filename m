Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBBF6099ED
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 07:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJXFms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 01:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiJXFml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 01:42:41 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2603A74E0A;
        Sun, 23 Oct 2022 22:42:40 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 302A51E80D74;
        Mon, 24 Oct 2022 13:41:11 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yJ82tyFT3FOp; Mon, 24 Oct 2022 13:41:08 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 7CE4B1E80CA5;
        Mon, 24 Oct 2022 13:41:08 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     masahiroy@kernel.org
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] lxdialog: checklist: Add malloc allocation judgment
Date:   Mon, 24 Oct 2022 13:42:22 +0800
Message-Id: <20221024054222.177899-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add  list_item Only when the pointer judges that the pointer is valid
can function code be executed.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 scripts/kconfig/lxdialog/checklist.c | 45 ++++++++++++++--------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
index fd161cfff121..61a8f86fe467 100644
--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -19,29 +19,30 @@ static void print_item(WINDOW * win, int choice, int selected)
 {
 	int i;
 	char *list_item = malloc(list_width + 1);
+	if (list_item) {
+		strncpy(list_item, item_str(), list_width - item_x);
+		list_item[list_width - item_x] = '\0';
 
-	strncpy(list_item, item_str(), list_width - item_x);
-	list_item[list_width - item_x] = '\0';
-
-	/* Clear 'residue' of last item */
-	wattrset(win, dlg.menubox.atr);
-	wmove(win, choice, 0);
-	for (i = 0; i < list_width; i++)
-		waddch(win, ' ');
-
-	wmove(win, choice, check_x);
-	wattrset(win, selected ? dlg.check_selected.atr
-		 : dlg.check.atr);
-	if (!item_is_tag(':'))
-		wprintw(win, "(%c)", item_is_tag('X') ? 'X' : ' ');
-
-	wattrset(win, selected ? dlg.tag_selected.atr : dlg.tag.atr);
-	mvwaddch(win, choice, item_x, list_item[0]);
-	wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
-	waddstr(win, list_item + 1);
-	if (selected) {
-		wmove(win, choice, check_x + 1);
-		wrefresh(win);
+		/* Clear 'residue' of last item */
+		wattrset(win, dlg.menubox.atr);
+		wmove(win, choice, 0);
+		for (i = 0; i < list_width; i++)
+			waddch(win, ' ');
+
+		wmove(win, choice, check_x);
+		wattrset(win, selected ? dlg.check_selected.atr
+			 : dlg.check.atr);
+		if (!item_is_tag(':'))
+			wprintw(win, "(%c)", item_is_tag('X') ? 'X' : ' ');
+
+		wattrset(win, selected ? dlg.tag_selected.atr : dlg.tag.atr);
+		mvwaddch(win, choice, item_x, list_item[0]);
+		wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
+		waddstr(win, list_item + 1);
+		if (selected) {
+			wmove(win, choice, check_x + 1);
+			wrefresh(win);
+		}
 	}
 	free(list_item);
 }
-- 
2.18.2

