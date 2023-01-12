Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA7A666BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbjALIBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbjALIBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:01:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE2D5F52;
        Thu, 12 Jan 2023 00:01:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BD4C61F22;
        Thu, 12 Jan 2023 08:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54543C433D2;
        Thu, 12 Jan 2023 08:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673510501;
        bh=AUd9BP1H6PrTlB87Yq1IOGc/Bm8jrbLRoRhOWz62syw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nj5KuNiPjFfExtgXUtXVwd6rcpw/WegnC5dAlOuro8LsqeQsFcQiW7QCkJYQUmAmQ
         xZ6t5B0X9kaH2jKyzmVN1DDWZ5FdZAkXCU8xrLZFy1KZOd6rARkCkyxVW0trd5c8HE
         Y5+DzKsH7EukjataO2sAXVKofBRx3cak4I6piDhBcwVDOxOdI3FHe80YaKRtqWaqHZ
         fTAeBHgsFZPKRIaTn55Vum8fzxAyKwSsWo5ngwOYcWepTWaKD02em5hCfb7y9TK3Ye
         grCXSTNvcwiB2AFnsDFQ/9c2uGfmU3b5/nZlmY8pU9fbd97EEYPonE+cEyc3OXUZEz
         fRQCMz6lT4Ntw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     Kees Cook <keescook@chromium.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 02/11] tty: vt: drop get_vc_uniscr()
Date:   Thu, 12 Jan 2023 09:01:27 +0100
Message-Id: <20230112080136.4929-2-jirislaby@kernel.org>
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

Its definition depends on the NO_VC_UNI_SCREEN macro. But that is never
defined, so remove all this completely. I.e. expand the macro to
vc->vc_uni_screen everywhere.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 4b804665c51f..7e5baf9f8ad8 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -316,13 +316,6 @@ void schedule_console_callback(void)
  * Code to manage unicode-based screen buffers
  */
 
-#ifdef NO_VC_UNI_SCREEN
-/* this disables and optimizes related code away at compile time */
-#define get_vc_uniscr(vc) NULL
-#else
-#define get_vc_uniscr(vc) vc->vc_uni_screen
-#endif
-
 typedef uint32_t char32_t;
 
 /*
@@ -369,7 +362,7 @@ static void vc_uniscr_set(struct vc_data *vc, struct uni_screen *new_uniscr)
 
 static void vc_uniscr_putc(struct vc_data *vc, char32_t uc)
 {
-	struct uni_screen *uniscr = get_vc_uniscr(vc);
+	struct uni_screen *uniscr = vc->vc_uni_screen;
 
 	if (uniscr)
 		uniscr->lines[vc->state.y][vc->state.x] = uc;
@@ -377,7 +370,7 @@ static void vc_uniscr_putc(struct vc_data *vc, char32_t uc)
 
 static void vc_uniscr_insert(struct vc_data *vc, unsigned int nr)
 {
-	struct uni_screen *uniscr = get_vc_uniscr(vc);
+	struct uni_screen *uniscr = vc->vc_uni_screen;
 
 	if (uniscr) {
 		char32_t *ln = uniscr->lines[vc->state.y];
@@ -390,7 +383,7 @@ static void vc_uniscr_insert(struct vc_data *vc, unsigned int nr)
 
 static void vc_uniscr_delete(struct vc_data *vc, unsigned int nr)
 {
-	struct uni_screen *uniscr = get_vc_uniscr(vc);
+	struct uni_screen *uniscr = vc->vc_uni_screen;
 
 	if (uniscr) {
 		char32_t *ln = uniscr->lines[vc->state.y];
@@ -404,7 +397,7 @@ static void vc_uniscr_delete(struct vc_data *vc, unsigned int nr)
 static void vc_uniscr_clear_line(struct vc_data *vc, unsigned int x,
 				 unsigned int nr)
 {
-	struct uni_screen *uniscr = get_vc_uniscr(vc);
+	struct uni_screen *uniscr = vc->vc_uni_screen;
 
 	if (uniscr) {
 		char32_t *ln = uniscr->lines[vc->state.y];
@@ -416,7 +409,7 @@ static void vc_uniscr_clear_line(struct vc_data *vc, unsigned int x,
 static void vc_uniscr_clear_lines(struct vc_data *vc, unsigned int y,
 				  unsigned int nr)
 {
-	struct uni_screen *uniscr = get_vc_uniscr(vc);
+	struct uni_screen *uniscr = vc->vc_uni_screen;
 
 	if (uniscr) {
 		unsigned int cols = vc->vc_cols;
@@ -429,7 +422,7 @@ static void vc_uniscr_clear_lines(struct vc_data *vc, unsigned int y,
 static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 			     enum con_scroll dir, unsigned int nr)
 {
-	struct uni_screen *uniscr = get_vc_uniscr(vc);
+	struct uni_screen *uniscr = vc->vc_uni_screen;
 
 	if (uniscr) {
 		unsigned int i, j, k, sz, d, clear;
@@ -545,7 +538,7 @@ int vc_uniscr_check(struct vc_data *vc)
 void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
 			 unsigned int row, unsigned int col, unsigned int nr)
 {
-	struct uni_screen *uniscr = get_vc_uniscr(vc);
+	struct uni_screen *uniscr = vc->vc_uni_screen;
 	int offset = row * vc->vc_size_row + col * 2;
 	unsigned long pos;
 
@@ -1206,7 +1199,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	if (!newscreen)
 		return -ENOMEM;
 
-	if (get_vc_uniscr(vc)) {
+	if (vc->vc_uni_screen) {
 		new_uniscr = vc_uniscr_alloc(new_cols, new_rows);
 		if (!new_uniscr) {
 			kfree(newscreen);
@@ -1258,7 +1251,7 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	end = old_origin + old_row_size * min(old_rows, new_rows);
 
 	vc_uniscr_copy_area(new_uniscr, new_cols, new_rows,
-			    get_vc_uniscr(vc), rlth/2, first_copied_row,
+			    vc->vc_uni_screen, rlth/2, first_copied_row,
 			    min(old_rows, new_rows));
 	vc_uniscr_set(vc, new_uniscr);
 
@@ -4700,7 +4693,7 @@ EXPORT_SYMBOL_GPL(screen_glyph);
 
 u32 screen_glyph_unicode(const struct vc_data *vc, int n)
 {
-	struct uni_screen *uniscr = get_vc_uniscr(vc);
+	struct uni_screen *uniscr = vc->vc_uni_screen;
 
 	if (uniscr)
 		return uniscr->lines[n / vc->vc_cols][n % vc->vc_cols];
-- 
2.39.0

