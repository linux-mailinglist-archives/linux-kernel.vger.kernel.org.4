Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EA670B454
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 07:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjEVFHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 01:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjEVFHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 01:07:47 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A706592
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d15660784so2906667b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 22:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684732044; x=1687324044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8amRkLtdnjVq9cbmGyv8etEjiXwBdz+ISKHsxqN16tA=;
        b=GYE7/eh3Hqti3Du8XPZUomicyjqafnfRSVXMJgGIMFX6+SBScSqdwET8DvURyQAI25
         A2eaYMWJDwWyiQ/yLWt/12vUSj6bzkTk+pGFfX8gf+yVtmaOuB1FxffF70FUjmpqTzA9
         lU0TUqzND5gyGUb0yKeIQJRajq4+VN2W1jz/CsH9wkCLeVYW5gqLkCAnJanNMSasF/uU
         O8hpWEr2WtH/xMH1UAsDv43QHtp1r+L/SgUI5S5gEN4rskUkm/mEGMOt2LBfYeUiKTBX
         sc9hVVsA3HUHuvjjFUGzixiTj+Q9J+BBY3yvg5bd5a9gEihrq+709FCyt5O91kotDEH2
         G/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684732044; x=1687324044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8amRkLtdnjVq9cbmGyv8etEjiXwBdz+ISKHsxqN16tA=;
        b=XbwQScZwzJwh82qLgsej/xfEWSsLpGngFOfZT4aX1vtnKdpLInjGZDn89/tPW3qz0W
         3YfIyHblBoV+4Xu5YhxGbuLBoI/90tbezdxi5+I1erB+LoQ9yac3dFOPffm1exx70Xbh
         nF2kL0reFrUe4RYjYYEJrpYxCmTBVRbC4AnY/nZQQlPT5/JYaiFfUHbgfNTW+n8RLCw9
         DV0HNkcMomZUPy8XQJ8FD+f8G3JFXyuJ7bwCsuH3y3TVBsjg0/y2cxeQIwgPrhqUB2Z/
         gtukROO+il16qoEb/lhhixlxZGJQ29FlwTRgXk671KQgMYKQfE9Rs0cKMTuydeUyS0e1
         rzMg==
X-Gm-Message-State: AC+VfDxtg1fDDCfJlGzgft5OuyknsgtVc5LLqQTMXyWN2dKrViz+bCMj
        TtzZOkUSP6aReJ/4D7Ps1zn7W4xWG/SjSdZSiSo=
X-Google-Smtp-Source: ACHHUZ7HimVTIQoub3tu0mdIJwmiVfKwyk3rieE8LPbYzYmpwti5Dz/8eFWiSuI3fjzaDlWesoLrBg==
X-Received: by 2002:a05:6a00:1882:b0:64d:42cb:42af with SMTP id x2-20020a056a00188200b0064d42cb42afmr9286193pfh.4.1684732044137;
        Sun, 21 May 2023 22:07:24 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id t10-20020a62ea0a000000b0063b5776b073sm3247519pfh.117.2023.05.21.22.07.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 May 2023 22:07:23 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v3 02/10] maple_tree: Drop mas_{rev_}alloc() and mas_fill_gap()
Date:   Mon, 22 May 2023 13:06:48 +0800
Message-Id: <20230522050656.96215-3-zhangpeng.00@bytedance.com>
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

mas_{rev_}alloc() and mas_fill_gap() are useless, delete them.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 108 -----------------------------------------------
 1 file changed, 108 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 96d102d60b4e..263bd0ccc31b 100644
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
-- 
2.20.1

