Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1A170EBC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbjEXDP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239191AbjEXDOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:14:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A18619D
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:39 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae87bdc452so3237325ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684898019; x=1687490019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgqFNmLUsjBpqCt/LIT5GKl+BluIQMtFefGaXd2M17I=;
        b=fos9Fr5j7HfGCNewdVHPba52r/od/Xq+HkXaE/eBVHR4axkXK0nFdYi0oZZCCy7z6j
         Ot3MbKyYncgN49VuQuaicHywCvA4q8+r4AghQkyphciFzgep109ZY4LKjb9lhUwztXIN
         3/uF6rSQdy/dt6dBkGKhxdSBO/qF8l3nH6p6sko1NwTHkLuOXTIZfQFKqDzJxlNwdaBv
         iN3+WueQq+mUfyQka+huDH6Wr5Qh3iNEDtj3hoYY+4m/M5HAVkQ0MjI2Rvdv3KlzAk79
         nA32aCjmUw7mldHuv/7K7VxjoffhtwdiZMB6hXpYIWjVpcOEuWGegvx55XSCg40ZM/Jp
         2d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684898019; x=1687490019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgqFNmLUsjBpqCt/LIT5GKl+BluIQMtFefGaXd2M17I=;
        b=FwS2g8mjj0fc6f5jzoWxPkHNu6E/lPBukzAnCZ/ez87gDoVN146eIS443z1LKYo8JT
         lo3AwNh+6ViAJZQMuCATGOgjvX9HSX19B8o0jdqNWEMh1n/j5WK8cMfb5/WweXsBdNCE
         CYVgFe/rfeQiawx7OOuCn1N2x3SukEpZoek2EvfJ3/2vn0HbbRglD3rhPYr7X7ztP1/n
         8mVbab1jTBJZWlS1gshHUjCnqchUysBraf3eg0hAGe7GJ3i1yz9qZP5euXGOaMIvir6g
         5P+fNHA0WKdmp6VSdryUqm9/y+NygS41GIWI3JVZkcFKgqLKIYmcqsUB0V+RRHSAW8Zb
         nP1A==
X-Gm-Message-State: AC+VfDyEJxaFOYr1AbL6P02H6eU97YQzx5AFi3G+CbsVXHXFi7Ua8u1G
        06LEkHMQvJzf1HTsJRCBBU1BaA==
X-Google-Smtp-Source: ACHHUZ4u5qWVuJZ5LJ1wZwJuBtkbV2DwExZQW26B04OfbrwVGraCJfjD+4T7DSMkKkHQBxFPv3ONfw==
X-Received: by 2002:a17:902:efd3:b0:1ad:164:74ee with SMTP id ja19-20020a170902efd300b001ad016474eemr15460302plb.15.1684898018881;
        Tue, 23 May 2023 20:13:38 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001ab061e352bsm7480769plr.195.2023.05.23.20.13.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 May 2023 20:13:38 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 09/10] maple_tree: Simplify and clean up mas_wr_node_store()
Date:   Wed, 24 May 2023 11:12:46 +0800
Message-Id: <20230524031247.65949-10-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230524031247.65949-1-zhangpeng.00@bytedance.com>
References: <20230524031247.65949-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify and clean up mas_wr_node_store(), remove unnecessary code.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 87 +++++++++++++++---------------------------------
 1 file changed, 26 insertions(+), 61 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 1a2b9bb9c014..bfffbb7cab26 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4074,52 +4074,27 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
  *
  * Return: True if stored, false otherwise
  */
-static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
+static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
+				     unsigned char new_end)
 {
 	struct ma_state *mas = wr_mas->mas;
 	void __rcu **dst_slots;
 	unsigned long *dst_pivots;
-	unsigned char dst_offset;
-	unsigned char new_end = wr_mas->node_end;
-	unsigned char offset;
-	unsigned char node_slots = mt_slots[wr_mas->type];
+	unsigned char dst_offset, offset_end = wr_mas->offset_end;
 	struct maple_node reuse, *newnode;
-	unsigned char copy_size, max_piv = mt_pivots[wr_mas->type];
+	unsigned char copy_size, node_pivots = mt_pivots[wr_mas->type];
 	bool in_rcu = mt_in_rcu(mas->tree);
 
-	offset = mas->offset;
-	if (mas->last == wr_mas->r_max) {
-		/* runs right to the end of the node */
-		if (mas->last == mas->max)
-			new_end = offset;
-		/* don't copy this offset */
-		wr_mas->offset_end++;
-	} else if (mas->last < wr_mas->r_max) {
-		/* new range ends in this range */
-		if (unlikely(wr_mas->r_max == ULONG_MAX))
-			mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
-
-		new_end++;
-	} else {
-		if (wr_mas->end_piv == mas->last)
-			wr_mas->offset_end++;
-
-		new_end -= wr_mas->offset_end - offset - 1;
-	}
-
-	/* new range starts within a range */
-	if (wr_mas->r_min < mas->index)
-		new_end++;
-
-	/* Not enough room */
-	if (new_end >= node_slots)
-		return false;
-
-	/* Not enough data. */
+	/* Check if there is enough data. The room is enough. */
 	if (!mte_is_root(mas->node) && (new_end <= mt_min_slots[wr_mas->type]) &&
 	    !(mas->mas_flags & MA_STATE_BULK))
 		return false;
 
+	if (mas->last == wr_mas->end_piv)
+		offset_end++; /* don't copy this offset */
+	else if (unlikely(wr_mas->r_max == ULONG_MAX))
+		mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
+
 	/* set up node. */
 	if (in_rcu) {
 		mas_node_count(mas, 1);
@@ -4136,47 +4111,36 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
 	dst_pivots = ma_pivots(newnode, wr_mas->type);
 	dst_slots = ma_slots(newnode, wr_mas->type);
 	/* Copy from start to insert point */
-	memcpy(dst_pivots, wr_mas->pivots, sizeof(unsigned long) * (offset + 1));
-	memcpy(dst_slots, wr_mas->slots, sizeof(void *) * (offset + 1));
-	dst_offset = offset;
+	memcpy(dst_pivots, wr_mas->pivots, sizeof(unsigned long) * mas->offset);
+	memcpy(dst_slots, wr_mas->slots, sizeof(void *) * mas->offset);
 
 	/* Handle insert of new range starting after old range */
 	if (wr_mas->r_min < mas->index) {
-		mas->offset++;
-		rcu_assign_pointer(dst_slots[dst_offset], wr_mas->content);
-		dst_pivots[dst_offset++] = mas->index - 1;
+		rcu_assign_pointer(dst_slots[mas->offset], wr_mas->content);
+		dst_pivots[mas->offset++] = mas->index - 1;
 	}
 
 	/* Store the new entry and range end. */
-	if (dst_offset < max_piv)
-		dst_pivots[dst_offset] = mas->last;
-	mas->offset = dst_offset;
-	rcu_assign_pointer(dst_slots[dst_offset], wr_mas->entry);
+	if (mas->offset < node_pivots)
+		dst_pivots[mas->offset] = mas->last;
+	rcu_assign_pointer(dst_slots[mas->offset], wr_mas->entry);
 
 	/*
 	 * this range wrote to the end of the node or it overwrote the rest of
 	 * the data
 	 */
-	if (wr_mas->offset_end > wr_mas->node_end || mas->last >= mas->max) {
-		new_end = dst_offset;
+	if (offset_end > wr_mas->node_end)
 		goto done;
-	}
 
-	dst_offset++;
+	dst_offset = mas->offset + 1;
 	/* Copy to the end of node if necessary. */
-	copy_size = wr_mas->node_end - wr_mas->offset_end + 1;
-	memcpy(dst_slots + dst_offset, wr_mas->slots + wr_mas->offset_end,
+	copy_size = wr_mas->node_end - offset_end + 1;
+	memcpy(dst_slots + dst_offset, wr_mas->slots + offset_end,
 	       sizeof(void *) * copy_size);
-	if (dst_offset < max_piv) {
-		if (copy_size > max_piv - dst_offset)
-			copy_size = max_piv - dst_offset;
-
-		memcpy(dst_pivots + dst_offset,
-		       wr_mas->pivots + wr_mas->offset_end,
-		       sizeof(unsigned long) * copy_size);
-	}
+	memcpy(dst_pivots + dst_offset, wr_mas->pivots + offset_end,
+	       sizeof(unsigned long) * (copy_size - 1));
 
-	if ((wr_mas->node_end == node_slots - 1) && (new_end < node_slots - 1))
+	if (new_end < node_pivots)
 		dst_pivots[new_end] = mas->max;
 
 done:
@@ -4378,7 +4342,8 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 
 	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
 		return;
-	else if (mas_wr_node_store(wr_mas))
+
+	if (mas_wr_node_store(wr_mas, new_end))
 		return;
 
 	if (mas_is_err(mas))
-- 
2.20.1

