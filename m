Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0294473199B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343798AbjFONLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343724AbjFONLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:11:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA0626BA
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b3b3f67ad6so45418965ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686834637; x=1689426637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MG8wEkfZhYGC5aupLXEONPEpLbQPJyBuYKNQETRNYXQ=;
        b=JBdX1l1x+iSg2CpjvKE+gC3fQ5LWgXkFJ7O3qRqfSLsduXgNEEnfZyRZYD+aaDtn7N
         uSkoiI3TK2NJb/opjoa/il1l5jtgGuKT70/3p9YVeEph/4m8CwB62pWy40V19y6b3aBt
         T+3f4gBTnPVMNomBZwR+rHzM3IPEpaFZKEVHjpr3cDYsT085CBjG839Y0kDt0RG7zprr
         cs36S3Z9fzu8SZxcfDKFdL14UvqkXTGVFkmjRRMVFjUSG++ubc5+L0lc0JrsYkImHvD1
         qPTGQOAli/Oa9AWBv0XxRDill+ZhjXzuiBCDJbggf+iwNECB11Vh4LZldV3czFsyeBDD
         w8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686834637; x=1689426637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MG8wEkfZhYGC5aupLXEONPEpLbQPJyBuYKNQETRNYXQ=;
        b=PTBuDcuCCjQGnNSP9tkcK1jvgAaGBGJ4B1OU/p88C/vN5B+q/nvnbCq8tn1qsBdTny
         nvnZAmiJeAGcs3p/eqmRB3PXnuK0zRiu2F+yHNrLILp1uqzEj8PkxuJ7gPL4QvUjNh4a
         +gbQCiKrFWuJVBiV3Td2g3CirOQDAlo6o6WO9E/g7qT4/vyYiJGVNyv/50BfsjNn7SKq
         hIaVHJnPnt8ymuxZujqAijC9+KGxETtiJHhntltbICpDUl9iMLy341amXwEsEXTtHEVE
         YmONHeSis+uW5V+47Q9OJZoVoZitneEJfNp6Qc8qRrYCOhstsg/Lc7JNnrVSuRgV/35C
         oVeQ==
X-Gm-Message-State: AC+VfDxnSTTS6nIAe3TzGfBX6OSte7S4xHAbfVnwU2FmuMbtkNSohLQ+
        mnDwPRa/pS42eNXcc4qsRjKa2A==
X-Google-Smtp-Source: ACHHUZ7WKJVUJ+SDKFA9ptbKZMIDGFAgwrtvXxZ4yz/AJGuNYEZLYBZtCRPVCyj7PJ8FHVY00ecTSg==
X-Received: by 2002:a17:903:1390:b0:1b2:28ca:d16 with SMTP id jx16-20020a170903139000b001b228ca0d16mr13196115plb.44.1686834637281;
        Thu, 15 Jun 2023 06:10:37 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902b40100b001a804b16e38sm14036019plr.150.2023.06.15.06.10.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jun 2023 06:10:36 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 3/8] maple_tree: make mas_validate_gaps() to check metadata
Date:   Thu, 15 Jun 2023 21:08:54 +0800
Message-Id: <20230615130859.21858-4-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230615130859.21858-1-zhangpeng.00@bytedance.com>
References: <20230615130859.21858-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 8aba9e419e08..799afd590cf3 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6979,15 +6979,16 @@ EXPORT_SYMBOL_GPL(mt_dump);
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
@@ -7000,52 +7001,51 @@ static void mas_validate_gaps(struct ma_state *mas)
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
 
@@ -7055,10 +7055,8 @@ static void mas_validate_gaps(struct ma_state *mas)
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

