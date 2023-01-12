Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBA6666C05
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbjALIC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236603AbjALICF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:02:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC985DED9;
        Thu, 12 Jan 2023 00:01:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84BF6B81DCD;
        Thu, 12 Jan 2023 08:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E63EC433D2;
        Thu, 12 Jan 2023 08:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673510511;
        bh=TWHqywhnC1AyNeGhwV9L/b7tKIRiDdJ9MlO+2ROnqKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=di9NiQo6yzgQpTR3i/+eOhkobjjmmXHBOZDTrROZ8iB/WRKal1dWXTjMw0bPCNLXR
         wD+ZflfslBlpnF3zH00dqLE/7A1fjh/7xzJJD+UxogywJYG6T6Nrj8j1hScXfuCsy7
         uNJkFPIzvztcTgRlDzkWnhs6pJMMqi0R1tfyuW2B9QYwWLGak413pQbAFOZ0uA/TWo
         YmDNFLtCblEchD0+QtbsiBMZnJoXPng9zTFpyGa8wDy9/oDcK2a+k3pwk4HqxBqq2K
         Xnz7vAZqzW3TB6wHjmFIQIqmsm3KPxxeRIcEOA7s7Q/ha/AZNtYebrnPMJ+ariAqpc
         D3lnWnxQDjqFg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     Kees Cook <keescook@chromium.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 08/11] tty: vt: simplify some unicode conditions
Date:   Thu, 12 Jan 2023 09:01:33 +0100
Message-Id: <20230112080136.4929-8-jirislaby@kernel.org>
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

After previous patches, we can simply test vc->vc_uni_lines, so do so in
many unicode functions. This makes the code more compact. And even use
  if (!)
    return;
in vc_uniscr_scroll(), so that the whole code is indented on the left.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 85 +++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 49 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index db72375141b0..74db07b32abe 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -357,18 +357,14 @@ static void vc_uniscr_set(struct vc_data *vc, u32 **new_uni_lines)
 
 static void vc_uniscr_putc(struct vc_data *vc, u32 uc)
 {
-	u32 **uni_lines = vc->vc_uni_lines;
-
-	if (uni_lines)
-		uni_lines[vc->state.y][vc->state.x] = uc;
+	if (vc->vc_uni_lines)
+		vc->vc_uni_lines[vc->state.y][vc->state.x] = uc;
 }
 
 static void vc_uniscr_insert(struct vc_data *vc, unsigned int nr)
 {
-	u32 **uni_lines = vc->vc_uni_lines;
-
-	if (uni_lines) {
-		u32 *ln = uni_lines[vc->state.y];
+	if (vc->vc_uni_lines) {
+		u32 *ln = vc->vc_uni_lines[vc->state.y];
 		unsigned int x = vc->state.x, cols = vc->vc_cols;
 
 		memmove(&ln[x + nr], &ln[x], (cols - x - nr) * sizeof(*ln));
@@ -378,10 +374,8 @@ static void vc_uniscr_insert(struct vc_data *vc, unsigned int nr)
 
 static void vc_uniscr_delete(struct vc_data *vc, unsigned int nr)
 {
-	u32 **uni_lines = vc->vc_uni_lines;
-
-	if (uni_lines) {
-		u32 *ln = uni_lines[vc->state.y];
+	if (vc->vc_uni_lines) {
+		u32 *ln = vc->vc_uni_lines[vc->state.y];
 		unsigned int x = vc->state.x, cols = vc->vc_cols;
 
 		memcpy(&ln[x], &ln[x + nr], (cols - x - nr) * sizeof(*ln));
@@ -392,59 +386,52 @@ static void vc_uniscr_delete(struct vc_data *vc, unsigned int nr)
 static void vc_uniscr_clear_line(struct vc_data *vc, unsigned int x,
 				 unsigned int nr)
 {
-	u32 **uni_lines = vc->vc_uni_lines;
-
-	if (uni_lines) {
-		u32 *ln = uni_lines[vc->state.y];
-
-		memset32(&ln[x], ' ', nr);
-	}
+	if (vc->vc_uni_lines)
+		memset32(&vc->vc_uni_lines[vc->state.y][x], ' ', nr);
 }
 
 static void vc_uniscr_clear_lines(struct vc_data *vc, unsigned int y,
 				  unsigned int nr)
 {
-	u32 **uni_lines = vc->vc_uni_lines;
-
-	if (uni_lines) {
-		unsigned int cols = vc->vc_cols;
-
+	if (vc->vc_uni_lines)
 		while (nr--)
-			memset32(uni_lines[y++], ' ', cols);
-	}
+			memset32(vc->vc_uni_lines[y++], ' ', vc->vc_cols);
 }
 
 static void vc_uniscr_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 			     enum con_scroll dir, unsigned int nr)
 {
 	u32 **uni_lines = vc->vc_uni_lines;
+	unsigned int i, j, k, sz, d, clear;
 
-	if (uni_lines) {
-		unsigned int i, j, k, sz, d, clear;
+	if (!uni_lines)
+		return;
 
-		sz = b - t;
-		clear = b - nr;
-		d = nr;
-		if (dir == SM_DOWN) {
-			clear = t;
-			d = sz - nr;
-		}
-		for (i = 0; i < gcd(d, sz); i++) {
-			u32 *tmp = uni_lines[t + i];
-			j = i;
-			while (1) {
-				k = j + d;
-				if (k >= sz)
-					k -= sz;
-				if (k == i)
-					break;
-				uni_lines[t + j] = uni_lines[t + k];
-				j = k;
-			}
-			uni_lines[t + j] = tmp;
+	sz = b - t;
+	clear = b - nr;
+	d = nr;
+
+	if (dir == SM_DOWN) {
+		clear = t;
+		d = sz - nr;
+	}
+
+	for (i = 0; i < gcd(d, sz); i++) {
+		u32 *tmp = uni_lines[t + i];
+		j = i;
+		while (1) {
+			k = j + d;
+			if (k >= sz)
+				k -= sz;
+			if (k == i)
+				break;
+			uni_lines[t + j] = uni_lines[t + k];
+			j = k;
 		}
-		vc_uniscr_clear_lines(vc, clear, nr);
+		uni_lines[t + j] = tmp;
 	}
+
+	vc_uniscr_clear_lines(vc, clear, nr);
 }
 
 static void vc_uniscr_copy_area(u32 **dst_lines,
-- 
2.39.0

