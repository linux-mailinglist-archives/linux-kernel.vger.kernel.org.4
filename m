Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E02F702DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242031AbjEONSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241895AbjEONSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:18:33 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D66B1700
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:31 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so11766043a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684156711; x=1686748711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SqZWlsfkbxEd4BsTm1MhrUO1FrEvEzjaPkEdKk7VYI=;
        b=V4yvdebIzkZLzBXRdBJ/cqlNoldxsWjHV+VVk67DXhofASL/pQ6Sn/RCFW7Rit5oF5
         eN76yVDQO2rdOlHRbBhgVTYaCnQ1mgf6eLRo++EXcdBEFpoZdNigL3UQaELWi1EcgsGX
         8YiAsABMNMu0jqrcVUBl4HlHzlHsKYVVl1wNagcLVG6hQHBfBbhmDiC/Q7kYyweQ1At9
         2RLHAfkffK1DlgF30rG5KAP7UaTjJ8Uhdtkv/Pw7AcWh6Y5OF6KOSZ4+Uqz9sEWdUWNA
         wQnD8S6lAFuhOojjwHM/Wfr84k66hoMehS9bhtXwct8hf+cerazoCuwks9SlHPlrwBqZ
         Bsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156711; x=1686748711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SqZWlsfkbxEd4BsTm1MhrUO1FrEvEzjaPkEdKk7VYI=;
        b=fhpiLqfRfbTJcgg0aySiqCJ2FMC58ZMIl++I+1jx37ZhKFad2hHTzKZIp+Ai909xb4
         /0BoFLI+LP1IaSGx54bQxSpv9pqE/db+GIOPSPMcNEhXisPUFRllAI925WrkLErQIIdX
         1yTVhc34IM+5vO+YjKmYGf7KmC+xbjx0olaj35GUtm7M8jKzUuiza8D8MH+xo6SbJ98N
         U48kWG2+YB0Lq87zns+YYmQPWeZgv4kcwSo2H4cTbLv/RtfPmAVdMimH6LimiD35mSp+
         KRy3/goZPz13s+xCZ74sFMMN0+Ss3NZ5AWmeOseC8zNgbNMCHShqUGx3NT7fLHGSz2ra
         GU+g==
X-Gm-Message-State: AC+VfDxhJ29YKp3bFt9Wbbu/FVLmvg3NK9wiS7r9TakJDTLQ06sHJqjy
        A2a2ze4Sac6aoZ+iOVgqpgQXQw==
X-Google-Smtp-Source: ACHHUZ5o2obesVD5PMEZoRPcOhk0yxjhISRraF1Wv/wfPVSvpR0BGoHlgKqx3NWmD17MpLvIqgEwow==
X-Received: by 2002:a17:90a:ee88:b0:247:13f5:47de with SMTP id i8-20020a17090aee8800b0024713f547demr32771298pjz.44.1684156710773;
        Mon, 15 May 2023 06:18:30 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id gl20-20020a17090b121400b0024749e7321bsm14190014pjb.6.2023.05.15.06.18.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 May 2023 06:18:30 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 02/10] maple_tree: Drop mtree_alloc_{range,rrange}() and related functions.
Date:   Mon, 15 May 2023 21:17:49 +0800
Message-Id: <20230515131757.60035-3-zhangpeng.00@bytedance.com>
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

Drop mtree_alloc_{range,rrange}(), mas_{rev_}alloc() and mas_fill_gap().
mtree_alloc_{range,rrange}() currently have no users and can be easily
implemented with mas_empty_area{_rev}(). mas_{rev_}alloc() and
mas_fill_gap() are just their internal functions, drop them together.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 include/linux/maple_tree.h |   7 --
 lib/maple_tree.c           | 177 -------------------------------------
 2 files changed, 184 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 542b09118a09f..3dd6edccf83af 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -306,13 +306,6 @@ int mtree_insert(struct maple_tree *mt, unsigned long index,
 		void *entry, gfp_t gfp);
 int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 		unsigned long last, void *entry, gfp_t gfp);
-int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
-		void *entry, unsigned long size, unsigned long min,
-		unsigned long max, gfp_t gfp);
-int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
-		void *entry, unsigned long size, unsigned long min,
-		unsigned long max, gfp_t gfp);
-
 int mtree_store_range(struct maple_tree *mt, unsigned long first,
 		      unsigned long last, void *entry, gfp_t gfp);
 int mtree_store(struct maple_tree *mt, unsigned long index,
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b37065a6f570d..49dfe81dfa1b6 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5120,46 +5120,6 @@ static inline void mas_awalk(struct ma_state *mas, unsigned long size)
 	}
 }
 
-/*
- * mas_fill_gap() - Fill a located gap with @entry.
- * @mas: The maple state
- * @entry: The value to store
- * @slot: The offset into the node to store the @entry
- * @size: The size of the entry
- * @index: The start location
- */
-static inline void mas_fill_gap(struct ma_state *mas, void *entry,
-		unsigned char slot, unsigned long size, unsigned long *index)
-{
-	MA_WR_STATE(wr_mas, mas, entry);
-	unsigned char pslot = mte_parent_slot(mas->node);
-	struct maple_enode *mn = mas->node;
-	unsigned long *pivots;
-	enum maple_type ptype;
-	/*
-	 * mas->index is the start address for the search
-	 *  which may no longer be needed.
-	 * mas->last is the end address for the search
-	 */
-
-	*index = mas->index;
-	mas->last = mas->index + size - 1;
-
-	/*
-	 * It is possible that using mas->max and mas->min to correctly
-	 * calculate the index and last will cause an issue in the gap
-	 * calculation, so fix the ma_state here
-	 */
-	mas_ascend(mas);
-	ptype = mte_node_type(mas->node);
-	pivots = ma_pivots(mas_mn(mas), ptype);
-	mas->max = mas_safe_pivot(mas, pivots, pslot, ptype);
-	mas->min = mas_safe_min(mas, pivots, pslot);
-	mas->node = mn;
-	mas->offset = slot;
-	mas_wr_store_entry(&wr_mas);
-}
-
 /*
  * mas_sparse_area() - Internal function.  Return upper or lower limit when
  * searching for a gap in an empty tree.
@@ -5307,74 +5267,6 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned long min,
 }
 EXPORT_SYMBOL_GPL(mas_empty_area_rev);
 
-static inline int mas_alloc(struct ma_state *mas, void *entry,
-		unsigned long size, unsigned long *index)
-{
-	unsigned long min;
-
-	mas_start(mas);
-	if (mas_is_none(mas) || mas_is_ptr(mas)) {
-		mas_root_expand(mas, entry);
-		if (mas_is_err(mas))
-			return xa_err(mas->node);
-
-		if (!mas->index)
-			return mas_pivot(mas, 0);
-		return mas_pivot(mas, 1);
-	}
-
-	/* Must be walking a tree. */
-	mas_awalk(mas, size);
-	if (mas_is_err(mas))
-		return xa_err(mas->node);
-
-	if (mas->offset == MAPLE_NODE_SLOTS)
-		goto no_gap;
-
-	/*
-	 * At this point, mas->node points to the right node and we have an
-	 * offset that has a sufficient gap.
-	 */
-	min = mas->min;
-	if (mas->offset)
-		min = mas_pivot(mas, mas->offset - 1) + 1;
-
-	if (mas_is_err(mas))
-		return xa_err(mas->node);
-
-	if (mas->index < min)
-		mas->index = min;
-
-	mas_fill_gap(mas, entry, mas->offset, size, index);
-	return 0;
-
-no_gap:
-	return -EBUSY;
-}
-
-static inline int mas_rev_alloc(struct ma_state *mas, unsigned long min,
-				unsigned long max, void *entry,
-				unsigned long size, unsigned long *index)
-{
-	int ret = 0;
-
-	ret = mas_empty_area_rev(mas, min, max, size);
-	if (ret)
-		return ret;
-
-	if (mas_is_err(mas))
-		return xa_err(mas->node);
-
-	if (mas->offset == MAPLE_NODE_SLOTS)
-		goto no_gap;
-
-	mas_fill_gap(mas, entry, mas->offset, size, index);
-	return 0;
-
-no_gap:
-	return -EBUSY;
-}
-
 /*
  * mte_dead_leaves() - Mark all leaves of a node as dead.
  * @mas: The maple state
@@ -6481,75 +6373,6 @@ int mtree_insert(struct maple_tree *mt, unsigned long index, void *entry,
 }
 EXPORT_SYMBOL(mtree_insert);
 
-int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
-		void *entry, unsigned long size, unsigned long min,
-		unsigned long max, gfp_t gfp)
-{
-	int ret = 0;
-
-	MA_STATE(mas, mt, min, min);
-	if (!mt_is_alloc(mt))
-		return -EINVAL;
-
-	if (WARN_ON_ONCE(mt_is_reserved(entry)))
-		return -EINVAL;
-
-	if (min > max)
-		return -EINVAL;
-
-	if (max < size)
-		return -EINVAL;
-
-	if (!size)
-		return -EINVAL;
-
-	mtree_lock(mt);
-retry:
-	mas.offset = 0;
-	mas.index = min;
-	mas.last = max - size + 1;
-	ret = mas_alloc(&mas, entry, size, startp);
-	if (mas_nomem(&mas, gfp))
-		goto retry;
-
-	mtree_unlock(mt);
-	return ret;
-}
-EXPORT_SYMBOL(mtree_alloc_range);
-
-int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
-		void *entry, unsigned long size, unsigned long min,
-		unsigned long max, gfp_t gfp)
-{
-	int ret = 0;
-
-	MA_STATE(mas, mt, min, max - size + 1);
-	if (!mt_is_alloc(mt))
-		return -EINVAL;
-
-	if (WARN_ON_ONCE(mt_is_reserved(entry)))
-		return -EINVAL;
-
-	if (min > max)
-		return -EINVAL;
-
-	if (max < size - 1)
-		return -EINVAL;
-
-	if (!size)
-		return -EINVAL;
-
-	mtree_lock(mt);
-retry:
-	ret = mas_rev_alloc(&mas, min, max, entry, size, startp);
-	if (mas_nomem(&mas, gfp))
-		goto retry;
-
-	mtree_unlock(mt);
-	return ret;
-}
-EXPORT_SYMBOL(mtree_alloc_rrange);
-
 /**
  * mtree_erase() - Find an index and erase the entire range.
  * @mt: The maple tree
-- 
2.20.1

