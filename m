Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E7D6C8EFB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 16:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjCYPSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 11:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCYPS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 11:18:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8607FEC64;
        Sat, 25 Mar 2023 08:18:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BD6B60C61;
        Sat, 25 Mar 2023 15:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B93CC433D2;
        Sat, 25 Mar 2023 15:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679757506;
        bh=AskvAMkTh+EjFF8t4nxyKf0j06zonlQ6BxVR7L0hYoU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FBIumgan2CkwUd+7BSNElfUBVcn/rYKIlT8Rmt3lkqzPbi8qOzqSqXXdvufxyOLkE
         +GQHshCDugfIHdOtGWip1WRJEg+BjRZHbJ/RiZFOdM/anJpUk9W8pmvtzQKfFcOlM5
         gJEADmHgbvvZ/CgL1R/l5EDcL+Fyk/PNMbRuAXqgVoHsV9idiS5YOh8OiicRjSiLuw
         eYPEwQqit5lvUVMVj4HmKnR3/4T3BIAcpKg4un/n54XVblk+YejzT6LNKCXroCfxnX
         TlnJHY2aVNVnDL7XQ/sePVCSeqMZeaYtHiIM2efxVrQOGiiSgORO2M+2WGz9YIYFeU
         r7fA1/J08WCyg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/3] kconfig: menuconfig: reorder functions to remove forward declarations
Date:   Sun, 26 Mar 2023 00:18:17 +0900
Message-Id: <20230325151817.2651544-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230325151817.2651544-1-masahiroy@kernel.org>
References: <20230325151817.2651544-1-masahiroy@kernel.org>
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

Define helper functions before the callers so that forward
declarations can go away.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lxdialog/textbox.c | 258 ++++++++++++------------
 scripts/kconfig/mconf.c            | 314 ++++++++++++++---------------
 2 files changed, 277 insertions(+), 295 deletions(-)

diff --git a/scripts/kconfig/lxdialog/textbox.c b/scripts/kconfig/lxdialog/textbox.c
index 4a6ff9de45b9..bc4d4fb1dc75 100644
--- a/scripts/kconfig/lxdialog/textbox.c
+++ b/scripts/kconfig/lxdialog/textbox.c
@@ -8,18 +8,136 @@
 
 #include "dialog.h"
 
-static void back_lines(int n);
-static void print_page(WINDOW *win, int height, int width, update_text_fn
-		       update_text, void *data);
-static void print_line(WINDOW *win, int row, int width);
-static char *get_line(void);
-static void print_position(WINDOW * win);
-
 static int hscroll;
 static int begin_reached, end_reached, page_length;
 static char *buf;
 static char *page;
 
+/*
+ * Go back 'n' lines in text. Called by dialog_textbox().
+ * 'page' will be updated to point to the desired line in 'buf'.
+ */
+static void back_lines(int n)
+{
+	int i;
+
+	begin_reached = 0;
+	/* Go back 'n' lines */
+	for (i = 0; i < n; i++) {
+		if (*page == '\0') {
+			if (end_reached) {
+				end_reached = 0;
+				continue;
+			}
+		}
+		if (page == buf) {
+			begin_reached = 1;
+			return;
+		}
+		page--;
+		do {
+			if (page == buf) {
+				begin_reached = 1;
+				return;
+			}
+			page--;
+		} while (*page != '\n');
+		page++;
+	}
+}
+
+/*
+ * Return current line of text. Called by dialog_textbox() and print_line().
+ * 'page' should point to start of current line before calling, and will be
+ * updated to point to start of next line.
+ */
+static char *get_line(void)
+{
+	int i = 0;
+	static char line[MAX_LEN + 1];
+
+	end_reached = 0;
+	while (*page != '\n') {
+		if (*page == '\0') {
+			end_reached = 1;
+			break;
+		} else if (i < MAX_LEN)
+			line[i++] = *(page++);
+		else {
+			/* Truncate lines longer than MAX_LEN characters */
+			if (i == MAX_LEN)
+				line[i++] = '\0';
+			page++;
+		}
+	}
+	if (i <= MAX_LEN)
+		line[i] = '\0';
+	if (!end_reached)
+		page++;		/* move past '\n' */
+
+	return line;
+}
+
+/*
+ * Print a new line of text.
+ */
+static void print_line(WINDOW *win, int row, int width)
+{
+	char *line;
+
+	line = get_line();
+	line += MIN(strlen(line), hscroll);	/* Scroll horizontally */
+	wmove(win, row, 0);	/* move cursor to correct line */
+	waddch(win, ' ');
+	waddnstr(win, line, MIN(strlen(line), width - 2));
+
+	/* Clear 'residue' of previous line */
+	wclrtoeol(win);
+}
+
+/*
+ * Print a new page of text.
+ */
+static void print_page(WINDOW *win, int height, int width, update_text_fn
+		       update_text, void *data)
+{
+	int i, passed_end = 0;
+
+	if (update_text) {
+		char *end;
+
+		for (i = 0; i < height; i++)
+			get_line();
+		end = page;
+		back_lines(height);
+		update_text(buf, page - buf, end - buf, data);
+	}
+
+	page_length = 0;
+	for (i = 0; i < height; i++) {
+		print_line(win, i, width);
+		if (!passed_end)
+			page_length++;
+		if (end_reached && !passed_end)
+			passed_end = 1;
+	}
+	wnoutrefresh(win);
+}
+
+/*
+ * Print current position
+ */
+static void print_position(WINDOW *win)
+{
+	int percent;
+
+	wattrset(win, dlg.position_indicator.atr);
+	wbkgdset(win, dlg.position_indicator.atr & A_COLOR);
+	percent = (page - buf) * 100 / strlen(buf);
+	wmove(win, getmaxy(win) - 3, getmaxx(win) - 9);
+	wprintw(win, "(%3d%%)", percent);
+}
+
 /*
  * refresh window content
  */
@@ -33,7 +151,6 @@ static void refresh_text_box(WINDOW *dialog, WINDOW *box, int boxh, int boxw,
 	wrefresh(dialog);
 }
 
-
 /*
  * Display text from a file in a dialog box.
  *
@@ -259,128 +376,3 @@ int dialog_textbox(const char *title, char *tbuf, int initial_height,
 		*_hscroll = hscroll;
 	return key;
 }
-
-/*
- * Go back 'n' lines in text. Called by dialog_textbox().
- * 'page' will be updated to point to the desired line in 'buf'.
- */
-static void back_lines(int n)
-{
-	int i;
-
-	begin_reached = 0;
-	/* Go back 'n' lines */
-	for (i = 0; i < n; i++) {
-		if (*page == '\0') {
-			if (end_reached) {
-				end_reached = 0;
-				continue;
-			}
-		}
-		if (page == buf) {
-			begin_reached = 1;
-			return;
-		}
-		page--;
-		do {
-			if (page == buf) {
-				begin_reached = 1;
-				return;
-			}
-			page--;
-		} while (*page != '\n');
-		page++;
-	}
-}
-
-/*
- * Print a new page of text.
- */
-static void print_page(WINDOW *win, int height, int width, update_text_fn
-		       update_text, void *data)
-{
-	int i, passed_end = 0;
-
-	if (update_text) {
-		char *end;
-
-		for (i = 0; i < height; i++)
-			get_line();
-		end = page;
-		back_lines(height);
-		update_text(buf, page - buf, end - buf, data);
-	}
-
-	page_length = 0;
-	for (i = 0; i < height; i++) {
-		print_line(win, i, width);
-		if (!passed_end)
-			page_length++;
-		if (end_reached && !passed_end)
-			passed_end = 1;
-	}
-	wnoutrefresh(win);
-}
-
-/*
- * Print a new line of text.
- */
-static void print_line(WINDOW * win, int row, int width)
-{
-	char *line;
-
-	line = get_line();
-	line += MIN(strlen(line), hscroll);	/* Scroll horizontally */
-	wmove(win, row, 0);	/* move cursor to correct line */
-	waddch(win, ' ');
-	waddnstr(win, line, MIN(strlen(line), width - 2));
-
-	/* Clear 'residue' of previous line */
-	wclrtoeol(win);
-}
-
-/*
- * Return current line of text. Called by dialog_textbox() and print_line().
- * 'page' should point to start of current line before calling, and will be
- * updated to point to start of next line.
- */
-static char *get_line(void)
-{
-	int i = 0;
-	static char line[MAX_LEN + 1];
-
-	end_reached = 0;
-	while (*page != '\n') {
-		if (*page == '\0') {
-			end_reached = 1;
-			break;
-		} else if (i < MAX_LEN)
-			line[i++] = *(page++);
-		else {
-			/* Truncate lines longer than MAX_LEN characters */
-			if (i == MAX_LEN)
-				line[i++] = '\0';
-			page++;
-		}
-	}
-	if (i <= MAX_LEN)
-		line[i] = '\0';
-	if (!end_reached)
-		page++;		/* move past '\n' */
-
-	return line;
-}
-
-/*
- * Print current position
- */
-static void print_position(WINDOW * win)
-{
-	int percent;
-
-	wattrset(win, dlg.position_indicator.atr);
-	wbkgdset(win, dlg.position_indicator.atr & A_COLOR);
-	percent = (page - buf) * 100 / strlen(buf);
-	wmove(win, getmaxy(win) - 3, getmaxx(win) - 9);
-	wprintw(win, "(%3d%%)", percent);
-}
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index e67e0db50b2e..53d8834d12fe 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -290,16 +290,6 @@ static int save_and_exit;
 static int silent;
 
 static void conf(struct menu *menu, struct menu *active_menu);
-static void conf_choice(struct menu *menu);
-static void conf_string(struct menu *menu);
-static void conf_load(void);
-static void conf_save(void);
-static int show_textbox_ext(const char *title, char *text, int r, int c,
-			    int *keys, int *vscroll, int *hscroll,
-			    update_text_fn update_text, void *data);
-static void show_textbox(const char *title, const char *text, int r, int c);
-static void show_helptext(const char *title, const char *text);
-static void show_help(struct menu *menu);
 
 static char filename[PATH_MAX+1];
 static void set_config_filename(const char *config_filename)
@@ -358,6 +348,37 @@ static void reset_subtitle(void)
 	set_dialog_subtitles(subtitles);
 }
 
+static int show_textbox_ext(const char *title, char *text, int r, int c, int
+			    *keys, int *vscroll, int *hscroll, update_text_fn
+			    update_text, void *data)
+{
+	dialog_clear();
+	return dialog_textbox(title, text, r, c, keys, vscroll, hscroll,
+			      update_text, data);
+}
+
+static void show_textbox(const char *title, const char *text, int r, int c)
+{
+	show_textbox_ext(title, (char *) text, r, c, (int []) {0}, NULL, NULL,
+			 NULL, NULL);
+}
+
+static void show_helptext(const char *title, const char *text)
+{
+	show_textbox(title, text, 0, 0);
+}
+
+static void show_help(struct menu *menu)
+{
+	struct gstr help = str_new();
+
+	help.max_width = getmaxx(stdscr) - 10;
+	menu_get_ext_help(menu, &help);
+
+	show_helptext(menu_get_prompt(menu), str_get(&help));
+	str_free(&help);
+}
+
 struct search_data {
 	struct list_head *head;
 	struct menu **targets;
@@ -643,158 +664,6 @@ static void build_conf(struct menu *menu)
 	indent -= doint;
 }
 
-static void conf(struct menu *menu, struct menu *active_menu)
-{
-	struct menu *submenu;
-	const char *prompt = menu_get_prompt(menu);
-	struct subtitle_part stpart;
-	struct symbol *sym;
-	int res;
-	int s_scroll = 0;
-
-	if (menu != &rootmenu)
-		stpart.text = menu_get_prompt(menu);
-	else
-		stpart.text = NULL;
-	list_add_tail(&stpart.entries, &trail);
-
-	while (1) {
-		item_reset();
-		current_menu = menu;
-		build_conf(menu);
-		if (!child_count)
-			break;
-		set_subtitle();
-		dialog_clear();
-		res = dialog_menu(prompt ? prompt : "Main Menu",
-				  menu_instructions,
-				  active_menu, &s_scroll);
-		if (res == 1 || res == KEY_ESC || res == -ERRDISPLAYTOOSMALL)
-			break;
-		if (item_count() != 0) {
-			if (!item_activate_selected())
-				continue;
-			if (!item_tag())
-				continue;
-		}
-		submenu = item_data();
-		active_menu = item_data();
-		if (submenu)
-			sym = submenu->sym;
-		else
-			sym = NULL;
-
-		switch (res) {
-		case 0:
-			switch (item_tag()) {
-			case 'm':
-				if (single_menu_mode)
-					submenu->data = (void *) (long) !submenu->data;
-				else
-					conf(submenu, NULL);
-				break;
-			case 't':
-				if (sym_is_choice(sym) && sym_get_tristate_value(sym) == yes)
-					conf_choice(submenu);
-				else if (submenu->prompt->type == P_MENU)
-					conf(submenu, NULL);
-				break;
-			case 's':
-				conf_string(submenu);
-				break;
-			}
-			break;
-		case 2:
-			if (sym)
-				show_help(submenu);
-			else {
-				reset_subtitle();
-				show_helptext("README", mconf_readme);
-			}
-			break;
-		case 3:
-			reset_subtitle();
-			conf_save();
-			break;
-		case 4:
-			reset_subtitle();
-			conf_load();
-			break;
-		case 5:
-			if (item_is_tag('t')) {
-				if (sym_set_tristate_value(sym, yes))
-					break;
-				if (sym_set_tristate_value(sym, mod))
-					show_textbox(NULL, setmod_text, 6, 74);
-			}
-			break;
-		case 6:
-			if (item_is_tag('t'))
-				sym_set_tristate_value(sym, no);
-			break;
-		case 7:
-			if (item_is_tag('t'))
-				sym_set_tristate_value(sym, mod);
-			break;
-		case 8:
-			if (item_is_tag('t'))
-				sym_toggle_tristate_value(sym);
-			else if (item_is_tag('m'))
-				conf(submenu, NULL);
-			break;
-		case 9:
-			search_conf();
-			break;
-		case 10:
-			show_all_options = !show_all_options;
-			break;
-		}
-	}
-
-	list_del(trail.prev);
-}
-
-static int show_textbox_ext(const char *title, char *text, int r, int c, int
-			    *keys, int *vscroll, int *hscroll, update_text_fn
-			    update_text, void *data)
-{
-	dialog_clear();
-	return dialog_textbox(title, text, r, c, keys, vscroll, hscroll,
-			      update_text, data);
-}
-
-static void show_textbox(const char *title, const char *text, int r, int c)
-{
-	show_textbox_ext(title, (char *) text, r, c, (int []) {0}, NULL, NULL,
-			 NULL, NULL);
-}
-
-static void show_helptext(const char *title, const char *text)
-{
-	show_textbox(title, text, 0, 0);
-}
-
-static void conf_message_callback(const char *s)
-{
-	if (save_and_exit) {
-		if (!silent)
-			printf("%s", s);
-	} else {
-		show_textbox(NULL, s, 6, 60);
-	}
-}
-
-static void show_help(struct menu *menu)
-{
-	struct gstr help = str_new();
-
-	help.max_width = getmaxx(stdscr) - 10;
-	menu_get_ext_help(menu, &help);
-
-	show_helptext(menu_get_prompt(menu), str_get(&help));
-	str_free(&help);
-}
-
 static void conf_choice(struct menu *menu)
 {
 	const char *prompt = menu_get_prompt(menu);
@@ -950,6 +819,127 @@ static void conf_save(void)
 	}
 }
 
+static void conf(struct menu *menu, struct menu *active_menu)
+{
+	struct menu *submenu;
+	const char *prompt = menu_get_prompt(menu);
+	struct subtitle_part stpart;
+	struct symbol *sym;
+	int res;
+	int s_scroll = 0;
+
+	if (menu != &rootmenu)
+		stpart.text = menu_get_prompt(menu);
+	else
+		stpart.text = NULL;
+	list_add_tail(&stpart.entries, &trail);
+
+	while (1) {
+		item_reset();
+		current_menu = menu;
+		build_conf(menu);
+		if (!child_count)
+			break;
+		set_subtitle();
+		dialog_clear();
+		res = dialog_menu(prompt ? prompt : "Main Menu",
+				  menu_instructions,
+				  active_menu, &s_scroll);
+		if (res == 1 || res == KEY_ESC || res == -ERRDISPLAYTOOSMALL)
+			break;
+		if (item_count() != 0) {
+			if (!item_activate_selected())
+				continue;
+			if (!item_tag())
+				continue;
+		}
+		submenu = item_data();
+		active_menu = item_data();
+		if (submenu)
+			sym = submenu->sym;
+		else
+			sym = NULL;
+
+		switch (res) {
+		case 0:
+			switch (item_tag()) {
+			case 'm':
+				if (single_menu_mode)
+					submenu->data = (void *) (long) !submenu->data;
+				else
+					conf(submenu, NULL);
+				break;
+			case 't':
+				if (sym_is_choice(sym) && sym_get_tristate_value(sym) == yes)
+					conf_choice(submenu);
+				else if (submenu->prompt->type == P_MENU)
+					conf(submenu, NULL);
+				break;
+			case 's':
+				conf_string(submenu);
+				break;
+			}
+			break;
+		case 2:
+			if (sym)
+				show_help(submenu);
+			else {
+				reset_subtitle();
+				show_helptext("README", mconf_readme);
+			}
+			break;
+		case 3:
+			reset_subtitle();
+			conf_save();
+			break;
+		case 4:
+			reset_subtitle();
+			conf_load();
+			break;
+		case 5:
+			if (item_is_tag('t')) {
+				if (sym_set_tristate_value(sym, yes))
+					break;
+				if (sym_set_tristate_value(sym, mod))
+					show_textbox(NULL, setmod_text, 6, 74);
+			}
+			break;
+		case 6:
+			if (item_is_tag('t'))
+				sym_set_tristate_value(sym, no);
+			break;
+		case 7:
+			if (item_is_tag('t'))
+				sym_set_tristate_value(sym, mod);
+			break;
+		case 8:
+			if (item_is_tag('t'))
+				sym_toggle_tristate_value(sym);
+			else if (item_is_tag('m'))
+				conf(submenu, NULL);
+			break;
+		case 9:
+			search_conf();
+			break;
+		case 10:
+			show_all_options = !show_all_options;
+			break;
+		}
+	}
+
+	list_del(trail.prev);
+}
+
+static void conf_message_callback(const char *s)
+{
+	if (save_and_exit) {
+		if (!silent)
+			printf("%s", s);
+	} else {
+		show_textbox(NULL, s, 6, 60);
+	}
+}
+
 static int handle_exit(void)
 {
 	int res;
-- 
2.34.1

