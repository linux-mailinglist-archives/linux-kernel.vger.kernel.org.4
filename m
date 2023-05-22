Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6996B70B458
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjEVFIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjEVFIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:08:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9D2E9
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:45 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso3003293b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684732065; x=1687324065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXcykhEsvUWhqgulB/awfwAbXbqU+zgrczKRgN6cHyY=;
        b=BKOlFfw73MQsx7LKzihVb1eW2ku1Xa0uxS543oAZwXAeguF1RrGxaXVIbOQY17SQAQ
         kV1Uhnt0EvCzfgZCQJRhJA1pjbp8GCJmlUxZ8ozuWFSLCFY8c/MplHp2+j7uwMSrHVBa
         zU4r2Q45Vv1cofp/3n9tPjiEhbtoj/DxS6hNtjdbzivBv8C2Czl+xRXGAS+dhMiWKz0r
         /CIdRyWY17x9u18PW8dv9F5DlJFuCEK3kFjIekHWt3qgvtdh/p5TxWQX/VTgOScLeSHE
         7x32o2kDITVj9QcRo0K2UK8/Mgua27wg8lQIjh01Up1//2t3VGz9t58HMSjr+JHyVx+X
         DncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732065; x=1687324065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXcykhEsvUWhqgulB/awfwAbXbqU+zgrczKRgN6cHyY=;
        b=E2XH3r7VHRBqM2JuvuMNLaRfebwjXI9N3t/4AXX4Oph6sswGLrJkxDQe0ILtZEKU1C
         xunPLDl0Ovx+5NMdnhJ1JmmdgAc3cMCBwC1ONpooxiBVH69TayIXPPiaVsAOvX55CDoM
         zJyT+RAjcE2bVwZpSDInhcnezQA1XG/g5CmjcUFbSMPcfZzS3NtxTxDtM3MAeRErgqra
         TUrpnPvlH0qirJthbaJmRuDMdH6314ZbGynvRhJ+exEKJo0tF423m9Ntj4uEuoArWIHE
         RZKaQpTI7wYCLPIhZ1FPguOBIR2WANcm4CTTJNixEvbbVceVvPDJMftvrsdiLkvqKVSp
         /cnw==
X-Gm-Message-State: AC+VfDwyfYjumUnoaCCzxjZOhAuvO5fb6xlLw9Zbh/TUfkxqq3tJbQfH
        1bqjpgV2vle6Rb8Bc3FwUSgpmA==
X-Google-Smtp-Source: ACHHUZ4GwWTWE5gkEqNoMIf2XcDiWGmxfbFx8zj08GpTeiP2eOnG/1Io/VG9zQ4q7LRUwyQxcVeeSA==
X-Received: by 2002:a05:6a00:1803:b0:643:6aed:3a9 with SMTP id y3-20020a056a00180300b006436aed03a9mr12429588pfa.0.1684732064880;
        Sun, 21 May 2023 22:07:44 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id t10-20020a62ea0a000000b0063b5776b073sm3247519pfh.117.2023.05.21.22.07.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 May 2023 22:07:44 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 09/10] maple_tree: Simplify and clean up mas_wr_node_store()
Date:   Mon, 22 May 2023 13:06:55 +0800
Message-Id: <20230522050656.96215-10-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
References: <20230522050656.96215-1-zhangpeng.00@bytedance.com>
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

Simplify and clean up mas_wr_node_store(), remove unnecessary code.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 87 +++++++++++++++---------------------------------
 1 file changed, 26 insertions(+), 61 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 1fc872f7683c..aa1472c45757 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4075,52 +4075,27 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
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
@@ -4137,47 +4112,36 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
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
@@ -4379,7 +4343,8 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 
 	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
 		return;
-	else if (mas_wr_node_store(wr_mas))
+
+	if (mas_wr_node_store(wr_mas, new_end))
 		return;
 
 	if (mas_is_err(mas))
-- 
2.20.1

