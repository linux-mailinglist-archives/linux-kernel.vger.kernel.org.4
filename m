Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF48666C03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbjALICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbjALICE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:02:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B1BD130;
        Thu, 12 Jan 2023 00:01:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9159360EDF;
        Thu, 12 Jan 2023 08:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7A6C433F1;
        Thu, 12 Jan 2023 08:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673510508;
        bh=K9ZpncaVm29XVYgkWx4xlxXu4NCBqD+F2eM1zD64Wzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ax6EkEn8PEhwMkYjKdr9hlLpHYABMp7erceXG/z0tsO8nBcJh6z1wAwwkymd3wTXO
         d/Z67ZCwB8w+MaMpTbHvyZALThuFX7JZGoAaKCshz6MTzrQ9BzQdjaXInkBv4fRA1D
         wkYU8rcLuzMc8qEDzH60K/bv3xTuPri/460onlAIu1wo3cjgBb6qnqClRElTruYPco
         6FpLdHLzTTqhAWLmc6wXMK3dNLpQEG90GkDrforj7MNfl0tBjkQnfAxyAJDfwe3kHY
         KnURECDIZYkPG2KWanFvwCZKbz09YoekJbcmO4RHEjwTsCFunF2YReY1K35aODkHR/
         0M4hUt2YPusvg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     Kees Cook <keescook@chromium.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 06/11] tty: vt: remove struct uni_screen
Date:   Thu, 12 Jan 2023 09:01:31 +0100
Message-Id: <20230112080136.4929-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230112080136.4929-1-jirislaby@kernel.org>
References: <20230112080136.4929-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It contains only lines with pointers to characters (u32s). So use
simple clear 'u32 **lines' all over the code.

This avoids zero-length arrays. It also makes the allocation less
error-prone (size of the struct wasn't taken into account at all).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c            | 117 ++++++++++++++++-----------------
 include/linux/console_struct.h |   3 +-
 2 files changed, 59 insertions(+), 61 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 86c18522231b..119b3eafef59 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -320,58 +320,55 @@ void schedule_console_callback(void)
  * Our screen buffer is preceded by an array of line pointers so that
  * scrolling only implies some pointer shuffling.
  */
-struct uni_screen {
-	u32 *lines[0];
-};
 
-static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
+static u32 **vc_uniscr_alloc(unsigned int cols, unsigned int rows)
 {
-	struct uni_screen *uniscr;
+	u32 **uni_lines;
 	void *p;
-	unsigned int memsize, i, col_size = cols * sizeof(**uniscr->lines);
+	unsigned int memsize, i, col_size = cols * sizeof(**uni_lines);
 
 	/* allocate everything in one go */
 	memsize = col_size * rows;
-	memsize += rows * sizeof(*uniscr->lines);
-	p = vzalloc(memsize);
-	if (!p)
+	memsize += rows * sizeof(*uni_lines);
+	uni_lines = vzalloc(memsize);
+	if (!uni_lines)
 		return NULL;
 
 	/* initial line pointers */
-	uniscr = p;
-	p = uniscr->lines + rows;
+	p = uni_lines + rows;
 	for (i = 0; i < rows; i++) {
-		uniscr->lines[i] = p;
+		uni_lines[i] = p;
 		p += col_size;
 	}
-	return uniscr;
+
+	return uni_lines;
 }
 
-static void vc_uniscr_free(struct uni_screen *uniscr)
+static void vc_uniscr_free(u32 **uni_lines)
 {
-	vfree(uniscr);
+	vfree(uni_lines);
 }
 
-static void vc_uniscr_set(struct vc_data *vc, struct uni_screen *new_uniscr)
+static void vc_uniscr_set(struct vc_data *vc, u32 **new_uni_lines)
 {
-	vc_uniscr_free(vc->vc_uni_screen);
-	vc->vc_uni_screen = new_uniscr;
+	vc_uniscr_free(vc->vc_uni_lines);
+	vc->vc_uni_lines = new_uni_lines;
 }
 
 static void vc_uniscr_putc(struct vc_data *vc, u32 uc)
 {
-	struct uni_screen *uniscr = vc->vc_uni_screen;
+	u32 **uni_lines = vc->vc_uni_lines;
 
-	if (uniscr)
-		uniscr->lines[vc->state.y][vc->state.x] = uc;
+	if (uni_lines)
+		uni_lines[vc->state.y][vc->state.x] = uc;
 }
 
 static void vc_uniscr_insert(struct vc_data *vc, unsigned int nr)
 {
-	struct uni_screen *uniscr = vc->vc_uni_screen;
+	u32 **uni_lines = vc->vc_uni_lines;
 
-	if (uniscr) {
-		u32 *ln = uniscr->lines[vc->state.y];
+	if (uni_lines) {
+		u32 *ln = uni_lines[vc->state.y];
 		unsigned int x = vc->state.x, cols = vc->vc_cols;
 
 		memmove(&ln[x + nr], &ln[x], (cols - x - nr) * sizeof(*ln));
@@ -381,10 +378,10 @@ static void vc_uniscr_insert(struct vc_data *vc, unsigned int nr)
 
 static void vc_uniscr_delete(struct vc_data *vc, unsigned int nr)
 {
-	struct uni_screen *uniscr = vc->vc_uni_screen;
+	u32 **uni_lines = vc->vc_uni_lines;
 
-	if (uniscr) {
-		u32 *ln = uniscr->lines[vc->state.y];
+	if (uni_lines) {
+		u32 *ln = uni_lines[vc->state.y];
 		unsigned int x = vc->state.x, cols = vc->vc_cols;
 
 		memcpy(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
@@ -395,10 +392,10 @@ static void vc_uniscr_delete(struct vc_data *vc, unsigned int nr)
 static void vc_uniscr_clear_line(struct vc_data *vc, unsigned int x,
 				 unsigned int nr)
 {
-	struct uni_screen *uniscr = vc->vc_uni_screen;
+	u32 **uni_lines = vc->vc_uni_lines;
 
-	if (uniscr) {
-		u32 *ln = uniscr->lines[vc->state.y];
+	if (uni_lines) {
+		u32 *ln = uni_lines[vc->state.y];
 
 		memset32(&ln[x], ' ', nr);
 	}
@@ -407,22 +404,22 @@ static void vc_uniscr_clear_line(struct vc_data *vc, unsigned int x,
 static void vc_uniscr_clear_lines(struct vc_data *vc, unsigned int y,
 				  unsigned int nr)
 {
-	struct uni_screen *uniscr = vc->vc_uni_screen;
+	u32 **uni_lines = vc->vc_uni_lines;
 
-	if (uniscr) {
+	if (uni_lines) {
 		unsigned int cols = vc->vc_cols;
 
 		while (nr--)
-			memset32(uniscr->lines[y++], ' ', cols);
+			memset32(uni_lines[y++], ' ', cols);
 	}
 }
 
 static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 			     enum con_scroll dir, unsigned int nr)
 {
-	struct uni_screen *uniscr = vc->vc_uni_screen;
+	u32 **uni_lines = vc->vc_uni_lines;
 
-	if (uniscr) {
+	if (uni_lines) {
 		unsigned int i, j, k, sz, d, clear;
 
 		sz = b - t;
@@ -433,7 +430,7 @@ static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 			d = sz - nr;
 		}
 		for (i = 0; i < gcd(d, sz); i++) {
-			u32 *tmp = uniscr->lines[t + i];
+			u32 *tmp = uni_lines[t + i];
 			j = i;
 			while (1) {
 				k = j + d;
@@ -441,31 +438,31 @@ static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 					k -= sz;
 				if (k == i)
 					break;
-				uniscr->lines[t + j] = uniscr->lines[t + k];
+				uni_lines[t + j] = uni_lines[t + k];
 				j = k;
 			}
-			uniscr->lines[t + j] = tmp;
+			uni_lines[t + j] = tmp;
 		}
 		vc_uniscr_clear_lines(vc, clear, nr);
 	}
 }
 
-static void vc_uniscr_copy_area(struct uni_screen *dst,
+static void vc_uniscr_copy_area(u32 **dst_lines,
 				unsigned int dst_cols,
 				unsigned int dst_rows,
-				struct uni_screen *src,
+				u32 **src_lines,
 				unsigned int src_cols,
 				unsigned int src_top_row,
 				unsigned int src_bot_row)
 {
 	unsigned int dst_row = 0;
 
-	if (!dst)
+	if (!dst_lines)
 		return;
 
 	while (src_top_row < src_bot_row) {
-		u32 *src_line = src->lines[src_top_row];
-		u32 *dst_line = dst->lines[dst_row];
+		u32 *src_line = src_lines[src_top_row];
+		u32 *dst_line = dst_lines[dst_row];
 
 		memcpy(dst_line, src_line, src_cols * sizeof(*src_line));
 		if (dst_cols - src_cols)
@@ -474,7 +471,7 @@ static void vc_uniscr_copy_area(struct uni_screen *dst,
 		dst_row++;
 	}
 	while (dst_row < dst_rows) {
-		u32 *dst_line = dst->lines[dst_row];
+		u32 *dst_line = dst_lines[dst_row];
 
 		memset32(dst_line, ' ', dst_cols);
 		dst_row++;
@@ -489,7 +486,7 @@ static void vc_uniscr_copy_area(struct uni_screen *dst,
  */
 int vc_uniscr_check(struct vc_data *vc)
 {
-	struct uni_screen *uniscr;
+	u32 **uni_lines;
 	unsigned short *p;
 	int x, y, mask;
 
@@ -498,11 +495,11 @@ int vc_uniscr_check(struct vc_data *vc)
 	if (!vc->vc_utf)
 		return -ENODATA;
 
-	if (vc->vc_uni_screen)
+	if (vc->vc_uni_lines)
 		return 0;
 
-	uniscr = vc_uniscr_alloc(vc->vc_cols, vc->vc_rows);
-	if (!uniscr)
+	uni_lines = vc_uniscr_alloc(vc->vc_cols, vc->vc_rows);
+	if (!uni_lines)
 		return -ENOMEM;
 
 	/*
@@ -514,14 +511,15 @@ int vc_uniscr_check(struct vc_data *vc)
 	p = (unsigned short *)vc->vc_origin;
 	mask = vc->vc_hi_font_mask | 0xff;
 	for (y = 0; y < vc->vc_rows; y++) {
-		u32 *line = uniscr->lines[y];
+		u32 *line = uni_lines[y];
 		for (x = 0; x < vc->vc_cols; x++) {
 			u16 glyph = scr_readw(p++) & mask;
 			line[x] = inverse_translate(vc, glyph, true);
 		}
 	}
 
-	vc->vc_uni_screen = uniscr;
+	vc->vc_uni_lines = uni_lines;
+
 	return 0;
 }
 
@@ -533,11 +531,11 @@ int vc_uniscr_check(struct vc_data *vc)
 void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
 			 unsigned int row, unsigned int col, unsigned int nr)
 {
-	struct uni_screen *uniscr = vc->vc_uni_screen;
+	u32 **uni_lines = vc->vc_uni_lines;
 	int offset = row * vc->vc_size_row + col * 2;
 	unsigned long pos;
 
-	BUG_ON(!uniscr);
+	BUG_ON(!uni_lines);
 
 	pos = (unsigned long)screenpos(vc, offset, viewed);
 	if (pos >= vc->vc_origin && pos < vc->vc_scr_end) {
@@ -548,7 +546,7 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
 		 */
 		row = (pos - vc->vc_origin) / vc->vc_size_row;
 		col = ((pos - vc->vc_origin) % vc->vc_size_row) / 2;
-		memcpy(dest, &uniscr->lines[row][col], nr * sizeof(u32));
+		memcpy(dest, &uni_lines[row][col], nr * sizeof(u32));
 	} else {
 		/*
 		 * Scrollback is active. For now let's simply backtranslate
@@ -1150,7 +1148,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	unsigned int new_cols, new_rows, new_row_size, new_screen_size;
 	unsigned int user;
 	unsigned short *oldscreen, *newscreen;
-	struct uni_screen *new_uniscr = NULL;
+	u32 **new_uniscr = NULL;
 
 	WARN_CONSOLE_UNLOCKED();
 
@@ -1194,7 +1192,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	if (!newscreen)
 		return -ENOMEM;
 
-	if (vc->vc_uni_screen) {
+	if (vc->vc_uni_lines) {
 		new_uniscr = vc_uniscr_alloc(new_cols, new_rows);
 		if (!new_uniscr) {
 			kfree(newscreen);
@@ -1246,7 +1244,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	end = old_origin + old_row_size * min(old_rows, new_rows);
 
 	vc_uniscr_copy_area(new_uniscr, new_cols, new_rows,
-			    vc->vc_uni_screen, rlth/2, first_copied_row,
+			    vc->vc_uni_lines, rlth/2, first_copied_row,
 			    min(old_rows, new_rows));
 	vc_uniscr_set(vc, new_uniscr);
 
@@ -4688,10 +4686,11 @@ EXPORT_SYMBOL_GPL(screen_glyph);
 
 u32 screen_glyph_unicode(const struct vc_data *vc, int n)
 {
-	struct uni_screen *uniscr = vc->vc_uni_screen;
+	u32 **uni_lines = vc->vc_uni_lines;
+
+	if (uni_lines)
+		return uni_lines[n / vc->vc_cols][n % vc->vc_cols];
 
-	if (uniscr)
-		return uniscr->lines[n / vc->vc_cols][n % vc->vc_cols];
 	return inverse_translate(vc, screen_glyph(vc, n * 2), true);
 }
 EXPORT_SYMBOL_GPL(screen_glyph_unicode);
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index 1518568aaf0f..539f1cd45309 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -18,7 +18,6 @@
 #include <linux/workqueue.h>
 
 struct uni_pagedict;
-struct uni_screen;
 
 #define NPAR 16
 #define VC_TABSTOPS_COUNT	256U
@@ -159,7 +158,7 @@ struct vc_data {
 	struct vc_data **vc_display_fg;		/* [!] Ptr to var holding fg console for this display */
 	struct uni_pagedict *uni_pagedict;
 	struct uni_pagedict **uni_pagedict_loc; /* [!] Location of uni_pagedict variable for this console */
-	struct uni_screen *vc_uni_screen;	/* unicode screen content */
+	u32 **vc_uni_lines;			/* unicode screen content */
 	/* additional information is in vt_kern.h */
 };
 
-- 
2.39.0

