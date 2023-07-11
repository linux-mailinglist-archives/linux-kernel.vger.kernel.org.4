Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C387374E58B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjGKDzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjGKDzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:55:10 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F0EE57
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:55:08 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-560b7ac3cbfso3764694eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689047707; x=1691639707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nUv2eBUflOVJLrJw9mH1jkiLbgnM6ws75Pkn4jd+6E=;
        b=ba93/ClplBNkeT536iWxDiRxrvDKLuk5KzbRIGlkNS/wjSUDSw0YG2fdY+wocAKY5f
         QIcaK5gsT/UKH1/j1gmInqnQydQtLdFwMoEaVF8Y0JynNst6O2va9pZ58iQ78jbDHz4R
         ndraKp96OKm6JzDpx9nPiOKqPRN6160Rbdcb2ka3yKuAnldcB1vGQArUyhhiXyJmqeu2
         DFn5VI06R0dhs/J0QOYB+u8lmCI5Mtr0NqjaEOG+OIxk4KMQHM16azCfVmq9ldF6/EYQ
         M/n4PHfRcWMdYBEYL/VcaBdPlvczwae5dmhcz/2jNwPFqIr4m2+KUs+sIdqrqveJOrb2
         UMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689047707; x=1691639707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nUv2eBUflOVJLrJw9mH1jkiLbgnM6ws75Pkn4jd+6E=;
        b=IH0XITFDDkGKoYhBniSbzmMVczUwm5DyGLvU9LP7Wo7/4cKXI/xNDystSx3md24gxS
         IyvqA5TKAaZctE4kqVvotysps18pvAPVV6FmxrQQxFGq/OCHDY2ljriBdg5wJucSLva1
         8cIj7EE6wnTZUWYh+OROGJ18SksifLdUHzPNvlRgtB7OULme7FOwf2BV15Twf7cPQVuV
         Xet42VN/iTfxP5shU1PRfmsc0L9AteEg4CyEeTftsZ9hksER+pk8fo+MyRieQlwZutcY
         u/iMfaPc+5M9lEKKzE/5/ADITGADMByryqDjQrnil7896Z3dB73ugVVfiL8CRJVIn4gG
         RpeQ==
X-Gm-Message-State: ABy/qLYnguV8GhT90EtZMa+cIHrhDmRLOgsO29Sb9cvOkg1XEh7UGjZ5
        yMxNaMoGLVIGVwF9ZlMrmJLAlw==
X-Google-Smtp-Source: APBJJlFQdZ5ouen7AkuwOFPVNmD1rUP/WKxjeZ5E1cKkHpCB9W7ANQJv0/FGjEcF/RHwquL0uQTEFg==
X-Received: by 2002:a05:6358:c0f:b0:135:4dcf:9a2a with SMTP id f15-20020a0563580c0f00b001354dcf9a2amr10478949rwj.7.1689047707525;
        Mon, 10 Jul 2023 20:55:07 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id b15-20020a170903228f00b001b872c17535sm688329plh.13.2023.07.10.20.55.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Jul 2023 20:55:07 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 3/8] maple_tree: make mas_validate_gaps() to check metadata
Date:   Tue, 11 Jul 2023 11:54:39 +0800
Message-Id: <20230711035444.526-4-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230711035444.526-1-zhangpeng.00@bytedance.com>
References: <20230711035444.526-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make mas_validate_gaps() check whether the offset in the metadata points
to the largest gap. By the way, simplify this function.

Add the verification that gaps beyond the node limit are zero.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 78 ++++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 6a8982146338..a5776fab1875 100644
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
-	int i;
+	unsigned long *pivots = ma_pivots(node, mt);
+	unsigned int i;
 
-	if (ma_is_dense(mte_node_type(mte))) {
+	if (ma_is_dense(mt)) {
 		for (i = 0; i < mt_slot_count(mte); i++) {
 			if (mas_get_slot(mas, i)) {
 				if (gap > max_gap)
@@ -7004,52 +7005,59 @@ static void mas_validate_gaps(struct ma_state *mas)
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
+				       mas_mn(mas), i, gap, p_end, p_start,
+				       p_end - p_start + 1);
+				MT_BUG_ON(mas->tree, gap > p_end - p_start + 1);
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
+		if (offset > i) {
+			pr_err("gap offset %p[%u] is invalid\n", node, offset);
+			MT_BUG_ON(mas->tree, 1);
+		}
+
+		if (gaps[offset] != max_gap) {
+			pr_err("gap %p[%u] is not the largest gap %lu\n",
+			       node, offset, max_gap);
+			MT_BUG_ON(mas->tree, 1);
+		}
+
+		MT_BUG_ON(mas->tree, !gaps);
+		for (i++ ; i < mt_slot_count(mte); i++) {
+			if (gaps[i] != 0) {
+				pr_err("gap %p[%u] beyond node limit != 0\n",
+				       node, i);
+				MT_BUG_ON(mas->tree, 1);
+			}
+		}
+	}
+
 	if (mte_is_root(mte))
 		return;
 
@@ -7059,10 +7067,8 @@ static void mas_validate_gaps(struct ma_state *mas)
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

