Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C65666BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbjALICE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbjALIBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:01:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED222B4A2;
        Thu, 12 Jan 2023 00:01:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87E5961F19;
        Thu, 12 Jan 2023 08:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC63C433F0;
        Thu, 12 Jan 2023 08:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673510499;
        bh=uvFGt8m0kb/25r4WJuay6Ci5zHJB60MpzpDntkWMu9Y=;
        h=From:To:Cc:Subject:Date:From;
        b=U1H+dih0uBZggAh0FyuNvFhyq7eHRkOtGEVoiT7T2rXc08GMz6rM62wk9uMQpd+T8
         az/noiJkRbKrtV3fWUuFUpb7pGgsgPnHxYP7MOTKSjGDdTSzSe/e/Wy9d51wMrQceF
         Rm9vub/Pmvr9r9ONOncmEaj9h2EgoU/GEoUNx7AfhxpIReos2UpTUzwM0kh4agQvfQ
         oz/056oqXvN0bNq1CcPMxIpPHQh8d0Gqg9h1nXJKFo5otsAz3TNqeHsbm8hRrARxEv
         AMl1TaTtNHzOpgNGspfrD12AQ2NDcFaj3XyU517Ejk8fNq5XHyUfGdp8VC/taUF/AC
         3+k5CDDnRceFQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     Kees Cook <keescook@chromium.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 01/11] tty: vt: remove vc_uniscr_debug_check()
Date:   Thu, 12 Jan 2023 09:01:26 +0100
Message-Id: <20230112080136.4929-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.39.0
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

VC_UNI_SCREEN_DEBUG is always defined as 0, so this code is never
executed. Drop it along with VC_UNI_SCREEN_DEBUG.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 40 ----------------------------------------
 1 file changed, 40 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 981d2bfcf9a5..4b804665c51f 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -323,8 +323,6 @@ void schedule_console_callback(void)
 #define get_vc_uniscr(vc) vc->vc_uni_screen
 #endif
 
-#define VC_UNI_SCREEN_DEBUG 0
-
 typedef uint32_t char32_t;
 
 /*
@@ -580,43 +578,6 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
 	}
 }
 
-/* this is for validation and debugging only */
-static void vc_uniscr_debug_check(struct vc_data *vc)
-{
-	struct uni_screen *uniscr = get_vc_uniscr(vc);
-	unsigned short *p;
-	int x, y, mask;
-
-	if (!VC_UNI_SCREEN_DEBUG || !uniscr)
-		return;
-
-	WARN_CONSOLE_UNLOCKED();
-
-	/*
-	 * Make sure our unicode screen translates into the same glyphs
-	 * as the actual screen. This is brutal indeed.
-	 */
-	p = (unsigned short *)vc->vc_origin;
-	mask = vc->vc_hi_font_mask | 0xff;
-	for (y = 0; y < vc->vc_rows; y++) {
-		char32_t *line = uniscr->lines[y];
-		for (x = 0; x < vc->vc_cols; x++) {
-			u16 glyph = scr_readw(p++) & mask;
-			char32_t uc = line[x];
-			int tc = conv_uni_to_pc(vc, uc);
-			if (tc == -4)
-				tc = conv_uni_to_pc(vc, 0xfffd);
-			if (tc == -4)
-				tc = conv_uni_to_pc(vc, '?');
-			if (tc != glyph)
-				pr_err_ratelimited(
-					"%s: mismatch at %d,%d: glyph=%#x tc=%#x\n",
-					__func__, x, y, glyph, tc);
-		}
-	}
-}
-
-
 static void con_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 		enum con_scroll dir, unsigned int nr)
 {
@@ -2959,7 +2920,6 @@ static int do_con_write(struct tty_struct *tty, const unsigned char *buf, int co
 			goto rescan_last_byte;
 	}
 	con_flush(vc, &draw);
-	vc_uniscr_debug_check(vc);
 	console_conditional_schedule();
 	notify_update(vc);
 	console_unlock();
-- 
2.39.0

