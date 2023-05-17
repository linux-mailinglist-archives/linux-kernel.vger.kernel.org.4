Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FBC706377
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjEQJAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjEQI7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:59:41 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3748159E5
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:59:12 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-52160f75920so299944a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684313951; x=1686905951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9aNGrqQBPjiuab0lkbsDijWS2guYts9Wyl3byUG0bc=;
        b=PVkHjKmNBRNoPUuywfzQSWpLOEe9y6Le98hPE+07bPGymbDIGtwrSk4xVyi3eR0k2S
         bX5kBB0H3NlzJfQEoP7sfHuEmEbDGUEcp9HPEsMVuzE+ptHbpQXZPJ7+zrXdwQNJ83ce
         8ENSur0Opp8Zbg8MGsz+sUNE0qhL2bVj2HGCLmTOb1inynR0m+UBjc0msDu/7sxqJM2p
         Aa3bFJ7LFReAOst5AYiFDvfGMDZHcviGgITrQh9bibrxAdKMbOIHjjI+iqCOknwkkP79
         K3v1Zx+QjZw5pAMKf58p3Ra2EZ8oyz7Ha+OckwnkN0YlwvSvcwbx3v1bsdc5IkIx16By
         FVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313951; x=1686905951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9aNGrqQBPjiuab0lkbsDijWS2guYts9Wyl3byUG0bc=;
        b=ZO0nxJYi1p2yL+oCnS/hBU1u0tPM39+VL93HO+gdOXdJfLeK+nhJWjM1yXl2wuxXRu
         a1ppDe7TNJZQ84+ha7JFweP9y09XL7WIu6aX4c4COap7lomoRALbUJgpUJ9eV52AlBd+
         3FCY96S6Y7ch1sjskEONAkCdA/yjhG4Pxpxa4CkRqjMuirLatIE4Li/awi4LqZLRReNx
         RoJHO+OMExl1a37TD0ZxIGMfc1+XCaD9OYLuGH5PjaE59Xoc8ho53BpH052bbezlDTSQ
         Os+JWwZMdBZE7Z3cTPdhobInfcjdvR85jWplYSjaxEvN/dTQwM/WMMTf0nAdZA3Ja/NZ
         4G8Q==
X-Gm-Message-State: AC+VfDwEHnmhWgWpRZsd9X9bukxq+saVOEc7asXH7WH0C8/zv8pwpHp/
        Zf/qQw/QQjsbI5LqlFLD92PSBV4v6BfEpPM6ub8=
X-Google-Smtp-Source: ACHHUZ5DxkbsJqpwqqa/RF6nfH0fg2jWd8EQ2nzER6XH1u8bbzG2vqw0bz1d1ax/FUaCfeRQQtr7dw==
X-Received: by 2002:a17:90a:af86:b0:250:5194:b135 with SMTP id w6-20020a17090aaf8600b002505194b135mr35679211pjq.34.1684313951480;
        Wed, 17 May 2023 01:59:11 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id m18-20020a63ed52000000b0052c9d1533b6sm15056765pgk.56.2023.05.17.01.59.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 May 2023 01:59:11 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 09/10] maple_tree: Simplify and clean up mas_wr_node_store()
Date:   Wed, 17 May 2023 16:58:08 +0800
Message-Id: <20230517085809.86522-10-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
References: <20230517085809.86522-1-zhangpeng.00@bytedance.com>
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

Simplify and clean up mas_wr_node_store(), remove unnecessary code.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 87 +++++++++++++++---------------------------------
 1 file changed, 26 insertions(+), 61 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 25a8b7d5d598..b86001ad4632 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4072,52 +4072,27 @@ static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
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
@@ -4134,47 +4109,36 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
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
@@ -4387,7 +4351,8 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 
 	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
 		return;
-	else if (mas_wr_node_store(wr_mas))
+
+	if (mas_wr_node_store(wr_mas, new_end))
 		return;
 
 	if (mas_is_err(mas))
-- 
2.20.1

