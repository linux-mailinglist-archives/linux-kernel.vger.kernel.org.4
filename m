Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC0970636B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjEQI7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjEQI66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:58:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AC53593
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:58:52 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-517c840f181so238593a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684313932; x=1686905932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muDPH+0qSOjRZteWOxPwTAv/64dXCJZISlqxUy7MmMc=;
        b=AiP2PsxHN0UHtZNnNBLr9fCq5OgdAGQZRi7YFbOy2y/QUmZGsAStn51hGs3WPRvljK
         svzaf6zF4ms1xX5WJP6W7TogJIGblfgPdXi9w1v1KuiIhKEX8Zk0snQOV4pinKwdWAHN
         mAULjfjv3Vc5J4MQ/wNoqrLmlADD8RkSavPiFzDEdMa/Clbc/P5o1R1dSgAilJ2mD9qY
         +oxe+1+zRqvjGRT7Dr+q9A4EhpY3XNl62BHcNLWGtE2/bn5gMbQrlrSwTPcGSMDvSJgW
         43EQ7iB8SiNhZZOKQaYKYg1YMadvkVWEgFXQPJpxJ/aUfwBGIFQVBVScKAElsFpAhhG7
         e2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684313932; x=1686905932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=muDPH+0qSOjRZteWOxPwTAv/64dXCJZISlqxUy7MmMc=;
        b=hSsStW9XwdCOHYhOG2sm+XrDb0y3QzcXgh93HD4lRT8L826weKmnYPSKO0B7aSi3kT
         cZMqZF385u0pjuZtpLmJ8YDUivu+e16wj5p3Vfln2H+nLgXORIrkS3P5SRJ1lZFp8Tj/
         Q5aPemx9RP0SKwa2plCotOvshck4Qb8ganvuHgLkRUAall7IioNRB0U2JTTSAsOxYjp/
         X3CKmpjfDAUAKfK+ej+iinYdNIY6LynumOCvH05X4EHR/Jc+GbwfAPNskoOkaor8eBKk
         MtAthiHq0ctGp5lixN+84WBjvw8OmFw+k6duhfgq4OkPLxa9uXkT4qNigH3clbXH2qDY
         +RVA==
X-Gm-Message-State: AC+VfDx5Eb7UhxzOW1h+JNL5v54aeyD9SX3z8RWAqhBucH/1JGmhXiRg
        uuNMYiK64dARl3AZzOkaDIIXvA==
X-Google-Smtp-Source: ACHHUZ4BXjI5mVv9fCacdk56Cmg8gwN9m86sJFs+fFA8+ULEQQFgEOjIXo0WZkwYGUOjYAKzll45Lg==
X-Received: by 2002:a05:6a20:1590:b0:105:5086:fd42 with SMTP id h16-20020a056a20159000b001055086fd42mr18006961pzj.45.1684313932035;
        Wed, 17 May 2023 01:58:52 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id m18-20020a63ed52000000b0052c9d1533b6sm15056765pgk.56.2023.05.17.01.58.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 May 2023 01:58:51 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 02/10] maple_tree: Drop mas_{rev_}alloc() and mas_fill_gap()
Date:   Wed, 17 May 2023 16:58:01 +0800
Message-Id: <20230517085809.86522-3-zhangpeng.00@bytedance.com>
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

mas_{rev_}alloc() and mas_fill_gap() are useless, delete them.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 108 -----------------------------------------------
 1 file changed, 108 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index e1820e90f167..c8176f360dc2 100644
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

