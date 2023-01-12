Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BAF666C06
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbjALIDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239000AbjALICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:02:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695CAFD05;
        Thu, 12 Jan 2023 00:01:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08D0660EDF;
        Thu, 12 Jan 2023 08:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458E5C433F0;
        Thu, 12 Jan 2023 08:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673510514;
        bh=3zkHmSkTqzg+wO4Yo1xSsZmVhJyL00UT5aGVNmRkJv4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3XxI6b7Qaxkqe7TGxq/dSMr3jsNlr8ZGA6qvE5wVpp+ARdVwS8k2bjbHA2ETyIvY
         4ucrXLTV2AbsalmssRqy9v7c5amG/cWwUovznhZt62/Jvyj5nIxRFxvC4jrY7LXePp
         k6FDA4KAmzwWMDU5iRnWdr220dVqxGh9OaPDRETs/EAz5tf1/SqZtQCTcEs1UTuO2P
         nES283UHy68+TTahrkAAkaz1tvDadam5Cq4kqdcffZY3jySGIksFHgMbpMIrqaNxhr
         b1NnBowIeovB0QQ/qEzmQrvNicOy+QzSag/tPVpCy+WGPKdXBUw8mDyvXDQbiWNAv3
         WO0yfm9RmR4dQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     Kees Cook <keescook@chromium.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 10/11] tty: vt: saner names for more scroll variables
Date:   Thu, 12 Jan 2023 09:01:35 +0100
Message-Id: <20230112080136.4929-10-jirislaby@kernel.org>
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

Rename more variables (t, b, s, d) -> (top, bottom, src, dst) to make
them more obvious.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7cda18b7ee3d..165c81211bdc 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -420,21 +420,22 @@ static void juggle_array(u32 **array, unsigned int size, unsigned int nr)
 	}
 }
 
-static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
-			     enum con_scroll dir, unsigned int nr)
+static void vc_uniscr_scroll(struct vc_data *vc, unsigned int top,
+			     unsigned int bottom, enum con_scroll dir,
+			     unsigned int nr)
 {
 	u32 **uni_lines = vc->vc_uni_lines;
-	unsigned int size = b - t;
+	unsigned int size = bottom - top;
 
 	if (!uni_lines)
 		return;
 
 	if (dir == SM_DOWN) {
 		juggle_array(&uni_lines[top], size, size - nr);
-		vc_uniscr_clear_lines(vc, t, nr);
+		vc_uniscr_clear_lines(vc, top, nr);
 	} else {
 		juggle_array(&uni_lines[top], size, nr);
-		vc_uniscr_clear_lines(vc, b - nr, nr);
+		vc_uniscr_clear_lines(vc, bottom - nr, nr);
 	}
 }
 
@@ -556,27 +557,30 @@ void vc_uniscr_copy_line(const struct vc_data *vc, void *dest, bool viewed,
 	}
 }
 
-static void con_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
-		enum con_scroll dir, unsigned int nr)
+static void con_scroll(struct vc_data *vc, unsigned int top,
+		       unsigned int bottom, enum con_scroll dir,
+		       unsigned int nr)
 {
-	u16 *clear, *d, *s;
+	u16 *clear, *dst, *src;
 
-	if (t + nr >= b)
-		nr = b - t - 1;
-	if (b > vc->vc_rows || t >= b || nr < 1)
+	if (top + nr >= bottom)
+		nr = bottom - top - 1;
+	if (bottom > vc->vc_rows || top >= bottom || nr < 1)
 		return;
-	vc_uniscr_scroll(vc, t, b, dir, nr);
-	if (con_is_visible(vc) && vc->vc_sw->con_scroll(vc, t, b, dir, nr))
+
+	vc_uniscr_scroll(vc, top, bottom, dir, nr);
+	if (con_is_visible(vc) &&
+			vc->vc_sw->con_scroll(vc, top, bottom, dir, nr))
 		return;
 
-	s = clear = (u16 *)(vc->vc_origin + vc->vc_size_row * t);
-	d = (u16 *)(vc->vc_origin + vc->vc_size_row * (t + nr));
+	src = clear = (u16 *)(vc->vc_origin + vc->vc_size_row * top);
+	dst = (u16 *)(vc->vc_origin + vc->vc_size_row * (top + nr));
 
 	if (dir == SM_UP) {
-		clear = s + (b - t - nr) * vc->vc_cols;
-		swap(s, d);
+		clear = src + (bottom - top - nr) * vc->vc_cols;
+		swap(src, dst);
 	}
-	scr_memmovew(d, s, (b - t - nr) * vc->vc_size_row);
+	scr_memmovew(dst, src, (bottom - top - nr) * vc->vc_size_row);
 	scr_memsetw(clear, vc->vc_video_erase_char, vc->vc_size_row * nr);
 }
 
-- 
2.39.0

