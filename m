Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2344666BFF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbjALICd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjALICE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:02:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D5DD124;
        Thu, 12 Jan 2023 00:01:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC4C0B81D93;
        Thu, 12 Jan 2023 08:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D07C433D2;
        Thu, 12 Jan 2023 08:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673510506;
        bh=Wxbvj3hbG0ATR5isDZ8ZlOPlqIrVAdBRgAIfL8flDxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2luE/N0OBtP840BJSQ0bBUdYE7cZYiyO5EuEMdxryqhYA8V6bQ4RbyW7htktFNx7
         aGOKM1ieptlLg01deujIMQSqpZe5oJw/Qu4RAzfADKLT4OxImfmENGs8O4CJ+yZdmi
         ko+wO8Hnr/rtyhIJXvhd9nhwie1MDqqWwXOijRc7bTgzsNwTAUO0FFGr/gxMFYHeS0
         PYDofOXY+dSv3sSRe7SFNV17V7EJ8/SSxAIiTeWi25GehiI1vYfhApRHQw0vBgSIEM
         FnosRyx4Eoq1AFAsiADES7UZgNc1mdZ5Pz1hSY/VDfWWddQtCg6O9NmtVng0PdOoEu
         t2yuZnjhBxUpQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     Kees Cook <keescook@chromium.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 05/11] tty: vt: remove char32_t typedef
Date:   Thu, 12 Jan 2023 09:01:30 +0100
Message-Id: <20230112080136.4929-5-jirislaby@kernel.org>
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

It boils down to uint32_t, so use u32 directly, instead. This makes the
code more obvious.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 3ae0212f1aa7..86c18522231b 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -316,14 +316,12 @@ void schedule_console_callback(void)
  * Code to manage unicode-based screen buffers
  */
 
-typedef uint32_t char32_t;
-
 /*
  * Our screen buffer is preceded by an array of line pointers so that
  * scrolling only implies some pointer shuffling.
  */
 struct uni_screen {
-	char32_t *lines[0];
+	u32 *lines[0];
 };
 
 static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
@@ -360,7 +358,7 @@ static void vc_uniscr_set(struct vc_data *vc, struct uni_screen *new_uniscr)
 	vc->vc_uni_screen = new_uniscr;
 }
 
-static void vc_uniscr_putc(struct vc_data *vc, char32_t uc)
+static void vc_uniscr_putc(struct vc_data *vc, u32 uc)
 {
 	struct uni_screen *uniscr = vc->vc_uni_screen;
 
@@ -373,7 +371,7 @@ static void vc_uniscr_insert(struct vc_data *vc, unsigned int nr)
 	struct uni_screen *uniscr = vc->vc_uni_screen;
 
 	if (uniscr) {
-		char32_t *ln = uniscr->lines[vc->state.y];
+		u32 *ln = uniscr->lines[vc->state.y];
 		unsigned int x = vc->state.x, cols = vc->vc_cols;
 
 		memmove(&ln[x + nr], &ln[x], (cols - x - nr) * sizeof(*ln));
@@ -386,7 +384,7 @@ static void vc_uniscr_delete(struct vc_data *vc, unsigned int nr)
 	struct uni_screen *uniscr = vc->vc_uni_screen;
 
 	if (uniscr) {
-		char32_t *ln = uniscr->lines[vc->state.y];
+		u32 *ln = uniscr->lines[vc->state.y];
 		unsigned int x = vc->state.x, cols = vc->vc_cols;
 
 		memcpy(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
@@ -400,7 +398,7 @@ static void vc_uniscr_clear_line(struct vc_data *vc, unsigned int x,
 	struct uni_screen *uniscr = vc->vc_uni_screen;
 
 	if (uniscr) {
-		char32_t *ln = uniscr->lines[vc->state.y];
+		u32 *ln = uniscr->lines[vc->state.y];
 
 		memset32(&ln[x], ' ', nr);
 	}
@@ -435,7 +433,7 @@ static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 			d = sz - nr;
 		}
 		for (i = 0; i < gcd(d, sz); i++) {
-			char32_t *tmp = uniscr->lines[t + i];
+			u32 *tmp = uniscr->lines[t + i];
 			j = i;
 			while (1) {
 				k = j + d;
@@ -466,8 +464,8 @@ static void vc_uniscr_copy_area(struct uni_screen *dst,
 		return;
 
 	while (src_top_row < src_bot_row) {
-		char32_t *src_line = src->lines[src_top_row];
-		char32_t *dst_line = dst->lines[dst_row];
+		u32 *src_line = src->lines[src_top_row];
+		u32 *dst_line = dst->lines[dst_row];
 
 		memcpy(dst_line, src_line, src_cols * sizeof(*src_line));
 		if (dst_cols - src_cols)
@@ -476,7 +474,7 @@ static void vc_uniscr_copy_area(struct uni_screen *dst,
 		dst_row++;
 	}
 	while (dst_row < dst_rows) {
-		char32_t *dst_line = dst->lines[dst_row];
+		u32 *dst_line = dst->lines[dst_row];
 
 		memset32(dst_line, ' ', dst_cols);
 		dst_row++;
@@ -516,7 +514,7 @@ int vc_uniscr_check(struct vc_data *vc)
 	p = (unsigned short *)vc->vc_origin;
 	mask = vc->vc_hi_font_mask | 0xff;
 	for (y = 0; y < vc->vc_rows; y++) {
-		char32_t *line = uniscr->lines[y];
+		u32 *line = uniscr->lines[y];
 		for (x = 0; x < vc->vc_cols; x++) {
 			u16 glyph = scr_readw(p++) & mask;
 			line[x] = inverse_translate(vc, glyph, true);
@@ -550,7 +548,7 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
 		 */
 		row = (pos - vc->vc_origin) / vc->vc_size_row;
 		col = ((pos - vc->vc_origin) % vc->vc_size_row) / 2;
-		memcpy(dest, &uniscr->lines[row][col], nr * sizeof(char32_t));
+		memcpy(dest, &uniscr->lines[row][col], nr * sizeof(u32));
 	} else {
 		/*
 		 * Scrollback is active. For now let's simply backtranslate
@@ -560,7 +558,7 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
 		 */
 		u16 *p = (u16 *)pos;
 		int mask = vc->vc_hi_font_mask | 0xff;
-		char32_t *uni_buf = dest;
+		u32 *uni_buf = dest;
 		while (nr--) {
 			u16 glyph = scr_readw(p++) & mask;
 			*uni_buf++ = inverse_translate(vc, glyph, true);
-- 
2.39.0

