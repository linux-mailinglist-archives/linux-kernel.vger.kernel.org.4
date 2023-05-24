Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD42970EBBE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239299AbjEXDOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbjEXDNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:13:46 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799AAE9
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:19 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae4be0b1f3so3383245ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684897999; x=1687489999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckt2ag3ZoF3mgkuxNjyDxYjsZDgVbwKu3RW+Fb2CiD0=;
        b=R9RNnIENcm151VyqYa/nqwjf1BhewhDeVjq4hnYK2ZCJ9zYTYaDCmfildSu8xlJ29P
         87FyT/a7va4k24YfyPPXmQjaWvuZRn47kTxvSRFCr6VnmSc2MtDTqImDn1eMPL8CNoHy
         cA3eyqxHaCcIxQLKKxtJDN1TLGOrfTooLKwS/4QF73ztb6i7qhrfqyAjaFvdSjm0B1rN
         UsNuaVxpBWAvHSMVQ1mHnSLHrEYAcgRFS7FQXRgDKwceWjRlB5ov0JaaksFOfmy1TlyX
         jzd94++aTxMoXfMtaax3HspHd/jL4wyu16QSUWtc3Hs5i0VfMgI3savoY1uOx4KEgXYy
         uRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684897999; x=1687489999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckt2ag3ZoF3mgkuxNjyDxYjsZDgVbwKu3RW+Fb2CiD0=;
        b=lUnd/uyqUU7QuG4jZJlMWh8V5RGFYD0HrMVtHN7J8or3WtAuzXcjveSsY5FwQc87W1
         8+yCKkZITyBRJsxKqkYbFtSK9BkwBDOtD5FgN6BQoFlI0E2mD7Lcv8eTxP5w6LCfDmNS
         ndvKddvjABSt2Ouwh862o8613fCBJY7DNUnrcWBnMAZn1gh9Nivs7hvetVShPuTLW0AZ
         jDJ88ksDvDodSTnG+a5ykmszpguoqcT+DjeTysjP10CUbeyGEhlO/4RfmenCFn9r0Mtt
         IbY+k6KhIGX+Ygm/ZedO87beqR2MljvmGgTsxlmIVpv4aHCA6fiLVhtMFdjFR5DKz6Z6
         F3hQ==
X-Gm-Message-State: AC+VfDwVkN+gs6QTCpiFrGBIgEu9a/FLIOCrzoIhYgR3a4k5JTdcntWt
        z0FZtB6Vh2R9VJhfDSFiNmbMew==
X-Google-Smtp-Source: ACHHUZ4xqpvx+J6/8q6bDUGXkrIfdgSfVg+6S8HYltONtfrDCgiX7zHvArLeqYXpbVbXCwHuRTRBng==
X-Received: by 2002:a17:902:bf06:b0:1ab:1bdd:b307 with SMTP id bi6-20020a170902bf0600b001ab1bddb307mr13560839plb.51.1684897998911;
        Tue, 23 May 2023 20:13:18 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001ab061e352bsm7480769plr.195.2023.05.23.20.13.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 May 2023 20:13:18 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v4 02/10] maple_tree: Drop mas_{rev_}alloc() and mas_fill_gap()
Date:   Wed, 24 May 2023 11:12:39 +0800
Message-Id: <20230524031247.65949-3-zhangpeng.00@bytedance.com>
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

mas_{rev_}alloc() and mas_fill_gap() are no longer used, delete them.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
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

