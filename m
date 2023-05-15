Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECD2702DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242284AbjEONUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241917AbjEONTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:19:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42E82D4F
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:53 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-643b7b8f8ceso7258939b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684156733; x=1686748733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArSLVUhdR9DQTTW/HQ0w3hLWCHQGeUGpXjVNbpJHsbw=;
        b=OY1tnyrNCLJ8dOnmp29AF4fQG0LVxASZn702ct1srPN3WTfsxFNCBRYdQLYwc6kuWt
         o70JfEDVIFUdVdNeIH/jJPOcRv9jEbVvhWXHoX+VGSuoQzE4KAv2rLMaD5HqYeqThYB2
         leU3yXWK2fpP4YQP7Nl4A6y2ls2C4xj20yTIY9f5SnUx6QaV0HKLQbNCKwV3+/ZHg3bn
         hwgtpNiJfKbcLKuvi/rJSfuqMI3aUr0+XWuap/hwlD0We5HkP++9q+9T/JB7ZhTWl5TL
         0NSOdoksiwNTnC1LHb060N3xyPjGvo8Xmw6pLH5YEXuU+R3+mn9q+We4wQvInISp/lEs
         cKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156733; x=1686748733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArSLVUhdR9DQTTW/HQ0w3hLWCHQGeUGpXjVNbpJHsbw=;
        b=AwULWNdhoIdTKo/BFbXsVKRCR9Pi2gE4qID6MZYdf5ovfeI0DQC0vla39JZ+lBurmE
         a9CbhSx5Yu2ucjI7d259GJ/Q2O1YsyaUQmLB2LUiYYfUcGt0/VtoxvJpuqiOq9os37qx
         ij3aos9U5LWo25zedeUTAoOa3gqcwKjFfoGjOtN37facE3aqRn2PuQbleoweBY8mJ6HN
         5jVdgkek+TaFh07RNW0vlKlgDdmnD1SVeUmwiYG8oln/sUGR5xdTjUE36xTilAtNAabF
         4JPhE4uU8BI2KAPqyFt1FfPF2hX0JEirE1eNkoC/RJfTWPI9eB80nQvIDCsslXlC1KMi
         nHOg==
X-Gm-Message-State: AC+VfDz70fVPTfiMl467lialtL1RXGKdEb1pm6DS5B7W7l5QB8o0BOJm
        HPLHq8/prueQJny9tzbjX+ETuyznbBjCnxR5vGU=
X-Google-Smtp-Source: ACHHUZ6YT7KoeQeNgm4bcB4ACN2DGOZvEt8Ia9xhmqJ46OkY/eCRFO8DvWR5h4sWDKWbrM68M9ETbg==
X-Received: by 2002:a05:6a20:1448:b0:105:55a7:d5ff with SMTP id a8-20020a056a20144800b0010555a7d5ffmr8063212pzi.28.1684156733094;
        Mon, 15 May 2023 06:18:53 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id gl20-20020a17090b121400b0024749e7321bsm14190014pjb.6.2023.05.15.06.18.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 May 2023 06:18:52 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 10/10] maple_tree: Simplify and clean up mas_wr_node_store()
Date:   Mon, 15 May 2023 21:17:57 +0800
Message-Id: <20230515131757.60035-11-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
References: <20230515131757.60035-1-zhangpeng.00@bytedance.com>
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
 lib/maple_tree.c | 75 +++++++++++++-----------------------------------
 1 file changed, 20 insertions(+), 55 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d558e7bcb6da8..ff4aa01cf88b6 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4066,46 +4066,21 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
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
 	unsigned char dst_offset;
-	unsigned char new_end = wr_mas->node_end;
-	unsigned char offset;
-	unsigned char node_slots = mt_slots[wr_mas->type];
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
+	if (mas->last == wr_mas->end_piv)
 		wr_mas->offset_end++;
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
+	else if (unlikely(wr_mas->r_max == ULONG_MAX))
+		mas_bulk_rebalance(mas, wr_mas->node_end, wr_mas->type);
 
 	/* Not enough data. */
 	if (!mte_is_root(mas->node) && (new_end <= mt_min_slots[wr_mas->type]) &&
@@ -4128,47 +4103,36 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
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
+	if (wr_mas->offset_end > wr_mas->node_end)
 		goto done;
-	}
 
-	dst_offset++;
+	dst_offset = mas->offset + 1;
 	/* Copy to the end of node if necessary. */
 	copy_size = wr_mas->node_end - wr_mas->offset_end + 1;
 	memcpy(dst_slots + dst_offset, wr_mas->slots + wr_mas->offset_end,
 	       sizeof(void *) * copy_size);
-	if (dst_offset < max_piv) {
-		if (copy_size > max_piv - dst_offset)
-			copy_size = max_piv - dst_offset;
+	memcpy(dst_pivots + dst_offset, wr_mas->pivots + wr_mas->offset_end,
+	       sizeof(unsigned long) * (copy_size - 1));
 
-		memcpy(dst_pivots + dst_offset,
-		       wr_mas->pivots + wr_mas->offset_end,
-		       sizeof(unsigned long) * copy_size);
-	}
-
-	if ((wr_mas->node_end == node_slots - 1) && (new_end < node_slots - 1))
+	if (new_end < node_pivots)
 		dst_pivots[new_end] = mas->max;
 
 done:
@@ -4429,7 +4393,8 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 
 	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
 		return;
-	else if (mas_wr_node_store(wr_mas))
+
+	if (mas_wr_node_store(wr_mas, new_end))
 		return;
 
 	if (mas_is_err(mas))
-- 
2.20.1

