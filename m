Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BB16AAB46
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 17:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCDQzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 11:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDQzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 11:55:31 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4E11167A;
        Sat,  4 Mar 2023 08:55:30 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso5712662wmq.1;
        Sat, 04 Mar 2023 08:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677948928;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9KOfWjloE4YaCN5sz26paM0Qiekh/0t9UUnTSBIVRGA=;
        b=qEEJV//FrWGFPvMkjqXVm8a+6JQO+uVUggaBpZcEO3u6NU5NCk6cWs2aO2oyHEKKZ2
         jdjlQqeGP+WvnqUPim1mINXNTqdnMG9C+qqs7avxBtoYtJ6KglRlc5t9t4nAZA5+54JH
         KZoAMk/R8mgU4buEPf2Pt02roTLoLjt8/lyjDz2aSfg32D6Wt7xkS7lJxYD59glAuMbe
         EnCauEzTgQFfeRYbw3XjLfA63XWn6irzKXKoTBlOENMiYLKBeCdwgEEKXv9BL9L03fEA
         COEm3SbycqPL1Asy/cAk1pIPScR6gaSZr3R36t5CJSEw76JLKdzMNssPwlWM+PbHG+Jm
         DYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677948928;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KOfWjloE4YaCN5sz26paM0Qiekh/0t9UUnTSBIVRGA=;
        b=nRUC8EEcCWs2Z8myxRkZ3MWgrN1iWKNw/Nl8vMiiW3Ns69/V/lPE3ubMwFe0ljxy1r
         wDbRlFj53KuSiLSX15XXJw7PldSgHvkemN0ztSZCCQy/pdNuzIqiaeDvoiqexf7WFyCK
         IeK+TEM2jSuRg62l0m7Ynpbo4iypkQhWn0Mc0moIWjPuvHdpBUpD8/3HCnQ4L4CQv1X+
         SicbbJ+vvhwHbV2H5wnvwrtB4RIObrNXt+BHRDUiqgYxSZYkvJLap7tstBVj2qVlADuL
         c1uIjWKOXQNg9RMkoKTej4pJ+8T7hRy271aUUy1YzdtXiwo62JEaQuDg9tVBDdJseeMa
         DZ7w==
X-Gm-Message-State: AO0yUKUbGG/+BKyghOvj7KpdVZRxto79LzwIC5yNHljf16JK0fTu6dO+
        YFPwpgxWYbFfG1f5whBRYQ==
X-Google-Smtp-Source: AK7set8MasGT0Y3ri9vLfjH81FaQyxs/mmxEAgbb7b4rjqJOLhkrtZuF33Hnen5nc3faH2Q/GS1Ejw==
X-Received: by 2002:a05:600c:5247:b0:3e9:b2f2:27a9 with SMTP id fc7-20020a05600c524700b003e9b2f227a9mr5160268wmb.14.1677948928372;
        Sat, 04 Mar 2023 08:55:28 -0800 (PST)
Received: from p183 ([46.53.251.240])
        by smtp.gmail.com with ESMTPSA id j21-20020a05600c075500b003e0238d9101sm5518878wmn.31.2023.03.04.08.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 08:55:27 -0800 (PST)
Date:   Sat, 4 Mar 2023 19:55:25 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        adobriyan@gmail.com
Subject: [PATCH 1/2] menuconfig: delete shadows, reclaim vertical space
Message-ID: <94a94ef4-9d55-4293-8363-3c0243eceae1@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Menuconfig has lots of vertical space wasted: on my system there are
17 lines of useful information about config options and 14 lines of
useless fluff: legend, horizontal separators and shadows.

Sitation is even worse on smaller terminals because fixed vertical lines
do not go away, but config option lines do decreasing informational
density even more.

Delete shadows and increase menu size to reclaim vertical space.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 scripts/kconfig/lxdialog/checklist.c |    2 --
 scripts/kconfig/lxdialog/dialog.h    |    1 -
 scripts/kconfig/lxdialog/inputbox.c  |    2 --
 scripts/kconfig/lxdialog/menubox.c   |    6 ++----
 scripts/kconfig/lxdialog/textbox.c   |    2 --
 scripts/kconfig/lxdialog/util.c      |   22 ----------------------
 scripts/kconfig/lxdialog/yesno.c     |    2 --
 7 files changed, 2 insertions(+), 35 deletions(-)

--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -130,8 +130,6 @@ int dialog_checklist(const char *title, const char *prompt, int height,
 	x = (getmaxx(stdscr) - width) / 2;
 	y = (getmaxy(stdscr) - height) / 2;
 
-	draw_shadow(stdscr, y, x, height, width);
-
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
 
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -206,7 +206,6 @@ void print_button(WINDOW * win, const char *label, int y, int x, int selected);
 void print_title(WINDOW *dialog, const char *title, int width);
 void draw_box(WINDOW * win, int y, int x, int height, int width, chtype box,
 	      chtype border);
-void draw_shadow(WINDOW * win, int y, int x, int height, int width);
 
 int first_alpha(const char *string, const char *exempt);
 int dialog_yesno(const char *title, const char *prompt, int height, int width);
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -52,8 +52,6 @@ int dialog_inputbox(const char *title, const char *prompt, int height, int width
 	x = (getmaxx(stdscr) - width) / 2;
 	y = (getmaxy(stdscr) - height) / 2;
 
-	draw_shadow(stdscr, y, x, height, width);
-
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
 
--- a/scripts/kconfig/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -183,7 +183,7 @@ int dialog_menu(const char *title, const char *prompt,
 	if (height < MENUBOX_HEIGTH_MIN || width < MENUBOX_WIDTH_MIN)
 		return -ERRDISPLAYTOOSMALL;
 
-	height -= 4;
+	height -= 2;
 	width  -= 5;
 	menu_height = height - 10;
 
@@ -191,9 +191,7 @@ int dialog_menu(const char *title, const char *prompt,
 
 	/* center dialog box on screen */
 	x = (getmaxx(stdscr) - width) / 2;
-	y = (getmaxy(stdscr) - height) / 2;
-
-	draw_shadow(stdscr, y, x, height, width);
+	y = 2;
 
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
--- a/scripts/kconfig/lxdialog/textbox.c
+++ b/scripts/kconfig/lxdialog/textbox.c
@@ -88,8 +88,6 @@ int dialog_textbox(const char *title, char *tbuf, int initial_height,
 	x = (getmaxx(stdscr) - width) / 2;
 	y = (getmaxy(stdscr) - height) / 2;
 
-	draw_shadow(stdscr, y, x, height, width);
-
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
 
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
--- a/scripts/kconfig/lxdialog/yesno.c
+++ b/scripts/kconfig/lxdialog/yesno.c
@@ -41,8 +41,6 @@ int dialog_yesno(const char *title, const char *prompt, int height, int width)
 	x = (getmaxx(stdscr) - width) / 2;
 	y = (getmaxy(stdscr) - height) / 2;
 
-	draw_shadow(stdscr, y, x, height, width);
-
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
 
