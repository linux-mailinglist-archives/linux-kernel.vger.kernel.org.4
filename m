Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C317D6B5B44
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCKLnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjCKLnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:43:12 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5274A196A0;
        Sat, 11 Mar 2023 03:43:07 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id g10so2019609eda.1;
        Sat, 11 Mar 2023 03:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678534986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r5l8Vloh1WtxxZ7hjoUpeR2cdX5vK/Amr5YfCGK/bTg=;
        b=XyJyjep1502rKoHisv84RKSxorpOwvMZE64X1+drFByHBsAgZSx5HFVFqH5yRO8d0F
         Z0NRE8S9eZ6eNGDRMxLD8bqJBZoxxdcxsM8t3AtYtuJKtx0IqMegdqcJm8msbRTuP3ko
         IW0IIfkHBMQxDC/ndPw8yy5+xTVxT6yKE0Q3JArEZHwBO4Fe5UzTAfnUY/FLDQGtGYXZ
         POpgV9Sv2rTmc1zmjxznopZGrM+kqO2+CJKz0rgT66N4jMenRxj/sR3xle4yclpvwtA4
         6+vH2Z1TrMnDCHYqI9lrSd6eJ5b4U/TgOZrga4DGQm1/UXdiNJqwIqYnq3iZnW5Q6npI
         mVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678534986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5l8Vloh1WtxxZ7hjoUpeR2cdX5vK/Amr5YfCGK/bTg=;
        b=p6GFMYg00lFLUiCY1WdS9RyMp6vqOZ2ReicF4zcbaJrgda81KIt6MRAH7jmNlYOOlZ
         FX1qVnzlpPmzIAg8lvOxsBD2e/Mnyh/dgkPyKzWJR3N71pzC1M/HnbSySxHW8HTzTo66
         dY1Q9BFBfGI/9VPAzm/VQdbO2wgPXxj7Jyqu9NU6LKPH3GszgNbe3p9EfMHYDDAoJqWW
         4cQ6UIWFoP/4LMcftZD2o/22SqKow3BVzc18R3Ji++oGyovBM0j9knD1tYDRRKRp0fP8
         Uo+D3p30y79hayy9qOIXAX/IN/aT370c0fmOctx1DRw3mDP5IVZ1FRQauZwlizq6pHMH
         KvkA==
X-Gm-Message-State: AO0yUKXuIonH35W2Isc/3MJXFOfWwvz6Y2n7a8RSGjfWRcgg+y1o7Wf6
        TLCqcrxE6mbBJIPG6Fv5ow==
X-Google-Smtp-Source: AK7set8+2vcluoCVdshE9cT3UnHxpSeCzuDmB+6H4sacXSgBeEyBTo3LOgph93jbiKOR7Vxjznia+w==
X-Received: by 2002:a17:907:7b8d:b0:8b2:c26c:369e with SMTP id ne13-20020a1709077b8d00b008b2c26c369emr32198281ejc.76.1678534985739;
        Sat, 11 Mar 2023 03:43:05 -0800 (PST)
Received: from localhost.localdomain ([46.53.248.97])
        by smtp.gmail.com with ESMTPSA id x101-20020a50baee000000b004aeeb476c5bsm1088440ede.24.2023.03.11.03.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:43:05 -0800 (PST)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     masahiroy@kernel.org
Cc:     adobriyan@gmail.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] menuconfig: delete shadows, prepare for vertical space reclaim
Date:   Sat, 11 Mar 2023 14:42:46 +0300
Message-Id: <20230311114248.36587-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shadows consumes precious vertical lines, simply delete them.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 scripts/kconfig/lxdialog/checklist.c |  2 --
 scripts/kconfig/lxdialog/dialog.h    |  1 -
 scripts/kconfig/lxdialog/inputbox.c  |  2 --
 scripts/kconfig/lxdialog/menubox.c   |  2 --
 scripts/kconfig/lxdialog/textbox.c   |  2 --
 scripts/kconfig/lxdialog/util.c      | 22 ----------------------
 scripts/kconfig/lxdialog/yesno.c     |  2 --
 7 files changed, 33 deletions(-)

diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
index fd161cfff121..7ce5233afaca 100644
--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -130,8 +130,6 @@ int dialog_checklist(const char *title, const char *prompt, int height,
 	x = (getmaxx(stdscr) - width) / 2;
 	y = (getmaxy(stdscr) - height) / 2;
 
-	draw_shadow(stdscr, y, x, height, width);
-
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
 
diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index 68b565e3c495..50b2674b734d 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -206,7 +206,6 @@ void print_button(WINDOW * win, const char *label, int y, int x, int selected);
 void print_title(WINDOW *dialog, const char *title, int width);
 void draw_box(WINDOW * win, int y, int x, int height, int width, chtype box,
 	      chtype border);
-void draw_shadow(WINDOW * win, int y, int x, int height, int width);
 
 int first_alpha(const char *string, const char *exempt);
 int dialog_yesno(const char *title, const char *prompt, int height, int width);
diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
index 1dcfb288ee63..0bda6186a599 100644
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -52,8 +52,6 @@ int dialog_inputbox(const char *title, const char *prompt, int height, int width
 	x = (getmaxx(stdscr) - width) / 2;
 	y = (getmaxy(stdscr) - height) / 2;
 
-	draw_shadow(stdscr, y, x, height, width);
-
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
 
diff --git a/scripts/kconfig/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
index 58c2f8afe59b..5c3addad89b0 100644
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -193,8 +193,6 @@ int dialog_menu(const char *title, const char *prompt,
 	x = (getmaxx(stdscr) - width) / 2;
 	y = (getmaxy(stdscr) - height) / 2;
 
-	draw_shadow(stdscr, y, x, height, width);
-
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
 
diff --git a/scripts/kconfig/lxdialog/textbox.c b/scripts/kconfig/lxdialog/textbox.c
index 4e339b12664e..de965d0770e2 100644
--- a/scripts/kconfig/lxdialog/textbox.c
+++ b/scripts/kconfig/lxdialog/textbox.c
@@ -88,8 +88,6 @@ int dialog_textbox(const char *title, char *tbuf, int initial_height,
 	x = (getmaxx(stdscr) - width) / 2;
 	y = (getmaxy(stdscr) - height) / 2;
 
-	draw_shadow(stdscr, y, x, height, width);
-
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
 
diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index 3f78fb265136..72dc30e3322d 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -491,28 +491,6 @@ draw_box(WINDOW * win, int y, int x, int height, int width,
 	}
 }
 
-/*
- * Draw shadows along the right and bottom edge to give a more 3D look
- * to the boxes
- */
-void draw_shadow(WINDOW * win, int y, int x, int height, int width)
-{
-	int i;
-
-	if (has_colors()) {	/* Whether terminal supports color? */
-		wattrset(win, dlg.shadow.atr);
-		wmove(win, y + height, x + 2);
-		for (i = 0; i < width; i++)
-			waddch(win, winch(win) & A_CHARTEXT);
-		for (i = y + 1; i < y + height + 1; i++) {
-			wmove(win, i, x + width);
-			waddch(win, winch(win) & A_CHARTEXT);
-			waddch(win, winch(win) & A_CHARTEXT);
-		}
-		wnoutrefresh(win);
-	}
-}
-
 /*
  *  Return the position of the first alphabetic character in a string.
  */
diff --git a/scripts/kconfig/lxdialog/yesno.c b/scripts/kconfig/lxdialog/yesno.c
index bcaac9b7bab2..25e4f10e0e6a 100644
--- a/scripts/kconfig/lxdialog/yesno.c
+++ b/scripts/kconfig/lxdialog/yesno.c
@@ -41,8 +41,6 @@ int dialog_yesno(const char *title, const char *prompt, int height, int width)
 	x = (getmaxx(stdscr) - width) / 2;
 	y = (getmaxy(stdscr) - height) / 2;
 
-	draw_shadow(stdscr, y, x, height, width);
-
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
 
-- 
2.39.2

