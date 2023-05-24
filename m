Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D1570EBC4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbjEXDPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbjEXDOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:14:10 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91845E47
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ae763f9c0bso3588535ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684898016; x=1687490016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4r/B+P0ZNt0u/JsXVxRA88PA4LS1ywC9VJ4XyQ5w3aw=;
        b=cKaK0PzJJClj7BIIZ9xYrlQhdCx17KGgfoycYEDKN5jEXKpKR6cV6dy46l6VOK1ADK
         0IuruPcnO8kruo2u+evuuL/X7ccEK37inNOY2P47BF9uZHhHo1eaAzgmg1V76hoDz2KS
         XRjqHbwSw/X+izm8dPf9zqZ8jowCvO4nb8SOF+P4tA9/3ku1Of+FpDUMl9Jx82LhyDTK
         3TN0i1owLb8gw+gFqvSG/v0sNXQ5AsWP0Rd0gq4N/fWnWYNm3exaJ5f7FZsHTiQQ6CAf
         eJFaw3mxGwFtw/AK2XXpKo1btbWmrcjCSuREvHhg+QNkXqinuEBJecKgXCvEs3l5RkdC
         +5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684898016; x=1687490016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4r/B+P0ZNt0u/JsXVxRA88PA4LS1ywC9VJ4XyQ5w3aw=;
        b=hlELB4VwhhPMNJm2/2JDMcIBWxozywjXSpLAEZmLJbPmpH07B1HTO/SoI/l+k/3eNg
         jZTve5+hAXWXdwbAGKZmT42h7nDq/mKzy52SwVfK3z3oKVSN9Bg3abpVVDej2xnLiNBO
         loxvb0H2P0Dwngm7H4HHxbaT/0eu5mzRzQa3B3RYpZfRuSgTT5YuYmr7/gqKuMKClV7W
         983p3JY/4rkNUtVyYclKl+flh4iwKLTozMQkqwdj2fRgGpj1KaLs3BgPz72/7KbReWi7
         Kzkt5xymZh/X8UF91LbqwR84Ftc2hEAJ2+q+UCYfq/+/6+0Rf8UwOpKpCC/DUvDLqrib
         5CLw==
X-Gm-Message-State: AC+VfDzrcG/ThJBYqhRZE+HmGKQFjKuw1VFuHzKsboZlKvpYQOxa9S1L
        KDCgcIIEvAbTh6rd0skoGGmnavFjIx/5IcqX0es=
X-Google-Smtp-Source: ACHHUZ5GbrNE/nQ058ApxvQBF7XTwlVqs4vuWERFZGTqmJi/FDyeGR4CvtfKaCmE4h3xFL8vgvU9jw==
X-Received: by 2002:a17:902:f547:b0:1ac:9890:1c49 with SMTP id h7-20020a170902f54700b001ac98901c49mr22348049plf.15.1684898016058;
        Tue, 23 May 2023 20:13:36 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001ab061e352bsm7480769plr.195.2023.05.23.20.13.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 May 2023 20:13:35 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 08/10] maple_tree: Rework mas_wr_slot_store() to be cleaner and more efficient.
Date:   Wed, 24 May 2023 11:12:45 +0800
Message-Id: <20230524031247.65949-9-zhangpeng.00@bytedance.com>
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

Get whether the two gaps to be overwritten are empty to avoid calling
mas_update_gap() all the time. Also clean up the code and add comments.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 53 +++++++++++++++++-------------------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 676976a005e5..1a2b9bb9c014 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4202,49 +4202,34 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas)
 static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
-	unsigned long lmax; /* Logical max. */
 	unsigned char offset = mas->offset;
+	bool gap = false;
 
-	if ((wr_mas->r_max > mas->last) && ((wr_mas->r_min != mas->index) ||
-				  (offset != wr_mas->node_end)))
+	if (wr_mas->offset_end - offset != 1)
 		return false;
 
-	if (offset == wr_mas->node_end - 1)
-		lmax = mas->max;
-	else
-		lmax = wr_mas->pivots[offset + 1];
-
-	/* going to overwrite too many slots. */
-	if (lmax < mas->last)
-		return false;
-
-	if (wr_mas->r_min == mas->index) {
-		/* overwriting two or more ranges with one. */
-		if (lmax == mas->last)
-			return false;
+	gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
+	gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
 
-		/* Overwriting all of offset and a portion of offset + 1. */
+	if (mas->index == wr_mas->r_min) {
+		/* Overwriting the range and over a part of the next range. */
 		rcu_assign_pointer(wr_mas->slots[offset], wr_mas->entry);
 		wr_mas->pivots[offset] = mas->last;
-		goto done;
+	} else {
+		/* Overwriting a part of the range and over the next range */
+		rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
+		wr_mas->pivots[offset] = mas->index - 1;
+		mas->offset++; /* Keep mas accurate. */
 	}
 
-	/* Doesn't end on the next range end. */
-	if (lmax != mas->last)
-		return false;
-
-	/* Overwriting a portion of offset and all of offset + 1 */
-	if ((offset + 1 < mt_pivots[wr_mas->type]) &&
-	    (wr_mas->entry || wr_mas->pivots[offset + 1]))
-		wr_mas->pivots[offset + 1] = mas->last;
-
-	rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
-	wr_mas->pivots[offset] = mas->index - 1;
-	mas->offset++; /* Keep mas accurate. */
-
-done:
 	trace_ma_write(__func__, mas, 0, wr_mas->entry);
-	mas_update_gap(mas);
+	/*
+	 * Only update gap when the new entry is empty or there is an empty
+	 * entry in the original two ranges.
+	 */
+	if (!wr_mas->entry || gap)
+		mas_update_gap(mas);
+
 	return true;
 }
 
@@ -4391,7 +4376,7 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 	if (new_end == wr_mas->node_end + 1 && mas_wr_append(wr_mas))
 		return;
 
-	if ((wr_mas->offset_end - mas->offset <= 1) && mas_wr_slot_store(wr_mas))
+	if (new_end == wr_mas->node_end && mas_wr_slot_store(wr_mas))
 		return;
 	else if (mas_wr_node_store(wr_mas))
 		return;
-- 
2.20.1

