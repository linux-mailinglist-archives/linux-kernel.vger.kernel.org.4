Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BCA74AE91
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjGGKMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjGGKLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:11:46 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94848170F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:11:21 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-53fa455cd94so984137a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 03:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688724681; x=1691316681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNMajAjya5LH1cr0h8UcY7AWKYluSf3DNGPBuMzeW+I=;
        b=hOQ+fMw+BoiKkHf4LQFjJnXVHwgx2GGmC/dU+wccE2ou+6cHm99YqltRcJg7kqi77w
         zjJuucAdKRHBItZe1kbAqEj3SOEHXVqcT+vtsgJH9vPZ1sQHFHGQMUAd73UPZ+IuncE+
         PxN6UdZ/JpdNDMEMv9hq8FfOUobjmEvmd0t1+SSb+rvuDL4J5mp6pm8ZeaTupFiAkyn/
         6NBrEumoORrpUSnZ6eOh0MaZQltxZBWELIm9f4h7m4hIOFxH6pHCn/DAtuZ0RgiNSFCL
         6GX4aHss9kmIE3DU40cuEcPA98gWIB5scldrp5GwlCikrV/AtjDreQKvRxCIPaVcO+Zd
         Ssqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688724681; x=1691316681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNMajAjya5LH1cr0h8UcY7AWKYluSf3DNGPBuMzeW+I=;
        b=Pvdur0QhjTLBFyPVWxdsSBsY+R4pihndyxwZDiymup8hYv6u0vor3wrS/qGPsyj1ku
         2rxSB5nFjTQNWQYkODJ9Rk3Tphsan17UKAyddFuXuQ0RIxl0SsY6SnlLXTW1EyoRlBTa
         sDDT2YEYrnRxQMGOswvpzlehncwwmtqMfktA+XkQ/u8CJlkWw3d1IFfoZkRdPxzIsH4j
         2hipREMl1QVJJwZr/cELUv6/U3ZoPK8rXLvpfcEAaszOR2IRFp95v0Sg+bIOjxyKCvIV
         Z5GZqygWhZDcNMcJh42SC8Xf2dqIprIyuzJTtU73RFmk7imCdnGCrCYEhsW//uGJ/dj2
         cPtw==
X-Gm-Message-State: ABy/qLZoPM4WjUlq6tHSwjbtvIgc4V1L7AyyXxkYrmcD4eSBM+aU1AKC
        0X8Kc4kNI2MGQidMWAKVPdy8UQ==
X-Google-Smtp-Source: APBJJlFF6iwtClAEjjI0g2PkdpD1KpvblVyCvkJamsMfzMjqpTWoEpTSQSc6Wdy/cPKbmJxSQP1qIA==
X-Received: by 2002:a05:6a20:d7:b0:12d:2abd:73f4 with SMTP id 23-20020a056a2000d700b0012d2abd73f4mr3051324pzh.26.1688724681045;
        Fri, 07 Jul 2023 03:11:21 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id x11-20020a056a00270b00b0068288aaf23esm2602549pfv.100.2023.07.07.03.11.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Jul 2023 03:11:20 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [RESEND PATCH 3/8] maple_tree: make mas_validate_gaps() to check metadata
Date:   Fri,  7 Jul 2023 18:10:52 +0800
Message-Id: <20230707101057.29326-4-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make mas_validate_gaps() check whether the offset in the metadata points
to the largest gap. By the way, simplify this function.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 68 +++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 6a8982146338..1fe8b6a787dd 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6983,15 +6983,16 @@ EXPORT_SYMBOL_GPL(mt_dump);
 static void mas_validate_gaps(struct ma_state *mas)
 {
 	struct maple_enode *mte = mas->node;
-	struct maple_node *p_mn;
+	struct maple_node *p_mn, *node = mte_to_node(mte);
+	enum maple_type mt = mte_node_type(mas->node);
 	unsigned long gap = 0, max_gap = 0;
 	unsigned long p_end, p_start = mas->min;
-	unsigned char p_slot;
+	unsigned char p_slot, offset;
 	unsigned long *gaps = NULL;
-	unsigned long *pivots = ma_pivots(mte_to_node(mte), mte_node_type(mte));
+	unsigned long *pivots = ma_pivots(node, mt);
 	int i;
 
-	if (ma_is_dense(mte_node_type(mte))) {
+	if (ma_is_dense(mt)) {
 		for (i = 0; i < mt_slot_count(mte); i++) {
 			if (mas_get_slot(mas, i)) {
 				if (gap > max_gap)
@@ -7004,52 +7005,51 @@ static void mas_validate_gaps(struct ma_state *mas)
 		goto counted;
 	}
 
-	gaps = ma_gaps(mte_to_node(mte), mte_node_type(mte));
+	gaps = ma_gaps(node, mt);
 	for (i = 0; i < mt_slot_count(mte); i++) {
-		p_end = mas_logical_pivot(mas, pivots, i, mte_node_type(mte));
+		p_end = mas_logical_pivot(mas, pivots, i, mt);
 
 		if (!gaps) {
-			if (mas_get_slot(mas, i)) {
-				gap = 0;
-				goto not_empty;
-			}
-
-			gap += p_end - p_start + 1;
+			if (!mas_get_slot(mas, i))
+				gap = p_end - p_start + 1;
 		} else {
 			void *entry = mas_get_slot(mas, i);
 
 			gap = gaps[i];
-			if (!entry) {
-				if (gap != p_end - p_start + 1) {
-					pr_err("%p[%u] -> %p %lu != %lu - %lu + 1\n",
-						mas_mn(mas), i,
-						mas_get_slot(mas, i), gap,
-						p_end, p_start);
-					mt_dump(mas->tree, mt_dump_hex);
-
-					MT_BUG_ON(mas->tree,
-						gap != p_end - p_start + 1);
-				}
-			} else {
-				if (gap > p_end - p_start + 1) {
-					pr_err("%p[%u] %lu >= %lu - %lu + 1 (%lu)\n",
-					mas_mn(mas), i, gap, p_end, p_start,
-					p_end - p_start + 1);
-					MT_BUG_ON(mas->tree,
-						gap > p_end - p_start + 1);
-				}
+			MT_BUG_ON(mas->tree, !entry);
+
+			if (gap > p_end - p_start + 1) {
+				pr_err("%p[%u] %lu >= %lu - %lu + 1 (%lu)\n",
+				mas_mn(mas), i, gap, p_end, p_start,
+				p_end - p_start + 1);
+				MT_BUG_ON(mas->tree,
+					gap > p_end - p_start + 1);
 			}
 		}
 
 		if (gap > max_gap)
 			max_gap = gap;
-not_empty:
+
 		p_start = p_end + 1;
 		if (p_end >= mas->max)
 			break;
 	}
 
 counted:
+	if (mt == maple_arange_64) {
+		offset = ma_meta_gap(node, mt);
+		if (offset > mt_slots[mt]) {
+			pr_err("gap offset %p[%u] is invalid\n", node, offset);
+			MT_BUG_ON(mas->tree, 1);
+		}
+
+		if (gaps[offset] != max_gap) {
+			pr_err("gap %p[%u] is not the largest gap %lu\n",
+			       node, offset, max_gap);
+			MT_BUG_ON(mas->tree, 1);
+		}
+	}
+
 	if (mte_is_root(mte))
 		return;
 
@@ -7059,10 +7059,8 @@ static void mas_validate_gaps(struct ma_state *mas)
 	if (ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap) {
 		pr_err("gap %p[%u] != %lu\n", p_mn, p_slot, max_gap);
 		mt_dump(mas->tree, mt_dump_hex);
+		MT_BUG_ON(mas->tree, 1);
 	}
-
-	MT_BUG_ON(mas->tree,
-		  ma_gaps(p_mn, mas_parent_type(mas, mte))[p_slot] != max_gap);
 }
 
 static void mas_validate_parent_slot(struct ma_state *mas)
-- 
2.20.1

