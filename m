Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32A0666C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239689AbjALIDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbjALICN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:02:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73324FD2B;
        Thu, 12 Jan 2023 00:01:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30C34B81D8E;
        Thu, 12 Jan 2023 08:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3816C433F1;
        Thu, 12 Jan 2023 08:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673510512;
        bh=DnqvmF2aWahKM6zVZyQwE90cv9Dp02hz9VBXVjL20Pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmZOmhiOag8SJaiXECdA5eTpqRdvsNxnA0S9wm2lTUl+bSLoeURIvZSq0Gw8ZoAqy
         BrmiTm60/hX1krQwEqx9s5cLZ3WVEXBxCyqnd3/OAp6hfIyjsI962ku3CbAqNL55h6
         g6YCVMqKMk09OtKPiFC6cexTY2Crd5h7WvMoG9tPAJi80xArnkziPYkNSvUYutUBCM
         csJ+mPL6ghZm+ORVNHdLO5zuLlz7DfTZo38NNSf4M1t8gGz1Hb++yFjy+VicrbNR5q
         /yhBKZ2YXmOq6tkhxb2R16gxAicQyznAAWog7d4D6LP8wu+3AX3QCLmJpStvl4X3yq
         B7XPEhA20mhrQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     Kees Cook <keescook@chromium.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 09/11] tty: vt: separate array juggling to juggle_array()
Date:   Thu, 12 Jan 2023 09:01:34 +0100
Message-Id: <20230112080136.4929-9-jirislaby@kernel.org>
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

The algorithm used for scrolling is the array juggling. It has
complexity O(N) and space complexity O(1). I.e. quite fast w/o
requirements for temporary storage.

Move the algorithm to a separate function so it is obvious what it is.
It is almost generic (except the array type), so if anyone else wants
array rotation, feel free to make it generic and move it to include/.

And rename all the variables from i, j, k, sz, d, and so on to something
saner.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 52 ++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 74db07b32abe..7cda18b7ee3d 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -398,40 +398,44 @@ static void vc_uniscr_clear_lines(struct vc_data *vc, unsigned int y,
 			memset32(vc->vc_uni_lines[y++], ' ', vc->vc_cols);
 }
 
+/* juggling array rotation algorithm (complexity O(N), size complexity O(1)) */
+static void juggle_array(u32 **array, unsigned int size, unsigned int nr)
+{
+	unsigned int gcd_idx;
+
+	for (gcd_idx = 0; gcd_idx < gcd(nr, size); gcd_idx++) {
+		u32 *gcd_idx_val = array[gcd_idx];
+		unsigned int dst_idx = gcd_idx;
+
+		while (1) {
+			unsigned int src_idx = (dst_idx + nr) % size;
+			if (src_idx == gcd_idx)
+				break;
+
+			array[dst_idx] = array[src_idx];
+			dst_idx = src_idx;
+		}
+
+		array[dst_idx] = gcd_idx_val;
+	}
+}
+
 static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 			     enum con_scroll dir, unsigned int nr)
 {
 	u32 **uni_lines = vc->vc_uni_lines;
-	unsigned int i, j, k, sz, d, clear;
+	unsigned int size = b - t;
 
 	if (!uni_lines)
 		return;
 
-	sz = b - t;
-	clear = b - nr;
-	d = nr;
-
 	if (dir == SM_DOWN) {
-		clear = t;
-		d = sz - nr;
-	}
-
-	for (i = 0; i < gcd(d, sz); i++) {
-		u32 *tmp = uni_lines[t + i];
-		j = i;
-		while (1) {
-			k = j + d;
-			if (k >= sz)
-				k -= sz;
-			if (k == i)
-				break;
-			uni_lines[t + j] = uni_lines[t + k];
-			j = k;
-		}
-		uni_lines[t + j] = tmp;
+		juggle_array(&uni_lines[top], size, size - nr);
+		vc_uniscr_clear_lines(vc, t, nr);
+	} else {
+		juggle_array(&uni_lines[top], size, nr);
+		vc_uniscr_clear_lines(vc, b - nr, nr);
 	}
-
-	vc_uniscr_clear_lines(vc, clear, nr);
 }
 
 static void vc_uniscr_copy_area(u32 **dst_lines,
-- 
2.39.0

