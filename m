Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147496C8EFA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 16:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjCYPSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 11:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYPS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 11:18:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D21EC53;
        Sat, 25 Mar 2023 08:18:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B75BB80522;
        Sat, 25 Mar 2023 15:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9732C433D2;
        Sat, 25 Mar 2023 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679757503;
        bh=oo6E+Xz8WFT652hkrNiEygyhzHj1OHj9IRZztciFppk=;
        h=From:To:Cc:Subject:Date:From;
        b=onmPrt8ec/AGWTGDj9ryBF+U6FpJsvIcOREfG46slzOQOFZtIMETjQcG/SDa2q+dC
         MIyU1RhJ6yBtFUAe3dq4TvKIOj8lNuYq3BnG31smGU9IcmqwhzTApgwZ0sEsIaMq/s
         vQUcBRI3Cek6rzhdUsXNJZApWz5dg1T2gAC9RhrA9aNvmp7wex7aVD+/6VwS9KzCT1
         WydeXFSqa8VwlonS3CCPyzkgi/knIXYq5HN812MkIj1JgypxXGokc+/YpjeVu3dWXV
         Wb4LdkuHo/PpWLTPfYQmQ3E4rFCJ7vaf/XccIS61GmGl6Ov+VZC2vSIMIqaI4t1q1B
         OzSC1FgonV0qg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/3] kconfig: menuconfig: remove OLD_NCURSES macro
Date:   Sun, 26 Mar 2023 00:18:15 +0900
Message-Id: <20230325151817.2651544-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code has been here for more than 20 years. The bug in the old days
no longer matters.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lxdialog/dialog.h  | 16 ----------------
 scripts/kconfig/lxdialog/menubox.c |  8 --------
 scripts/kconfig/lxdialog/textbox.c |  9 ---------
 3 files changed, 33 deletions(-)

diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index 68b565e3c495..bd2da3a928a7 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -18,22 +18,6 @@
 #endif
 #include <ncurses.h>
 
-/*
- * Colors in ncurses 1.9.9e do not work properly since foreground and
- * background colors are OR'd rather than separately masked.  This version
- * of dialog was hacked to work with ncurses 1.9.9e, making it incompatible
- * with standard curses.  The simplest fix (to make this work with standard
- * curses) uses the wbkgdset() function, not used in the original hack.
- * Turn it off if we're building with 1.9.9e, since it just confuses things.
- */
-#if defined(NCURSES_VERSION) && defined(_NEED_WRAP) && !defined(GCC_PRINTFLIKE)
-#define OLD_NCURSES 1
-#undef  wbkgdset
-#define wbkgdset(w,p)		/*nothing */
-#else
-#define OLD_NCURSES 0
-#endif
-
 #define TR(params) _tracef params
 
 #define KEY_ESC 27
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index 58c2f8afe59b..0e333284e947 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -63,15 +63,7 @@ static void do_print_item(WINDOW * win, const char *item, int line_y,
 	/* Clear 'residue' of last item */
 	wattrset(win, dlg.menubox.atr);
 	wmove(win, line_y, 0);
-#if OLD_NCURSES
-	{
-		int i;
-		for (i = 0; i < menu_width; i++)
-			waddch(win, ' ');
-	}
-#else
 	wclrtoeol(win);
-#endif
 	wattrset(win, selected ? dlg.item_selected.atr : dlg.item.atr);
 	mvwaddstr(win, line_y, item_x, menu_item);
 	if (hotkey) {
diff --git a/scripts/kconfig/lxdialog/textbox.c b/scripts/kconfig/lxdialog/textbox.c
index 4e339b12664e..4a6ff9de45b9 100644
--- a/scripts/kconfig/lxdialog/textbox.c
+++ b/scripts/kconfig/lxdialog/textbox.c
@@ -336,16 +336,7 @@ static void print_line(WINDOW * win, int row, int width)
 	waddnstr(win, line, MIN(strlen(line), width - 2));
 
 	/* Clear 'residue' of previous line */
-#if OLD_NCURSES
-	{
-		int x = getcurx(win);
-		int i;
-		for (i = 0; i < width - x; i++)
-			waddch(win, ' ');
-	}
-#else
 	wclrtoeol(win);
-#endif
 }
 
 /*
-- 
2.34.1

