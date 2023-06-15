Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B42273199F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbjFONLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343749AbjFONLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:11:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB2B2700
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666a63f7907so386521b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686834656; x=1689426656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEErg3d4yT8esB8KpwjYxwMfJsf51/geZ+6n58UDGJs=;
        b=EF9Lkit8KeZA+6lEZX30z4AtzxQeXjXaFk3VG1hfh2/OEXDrTUs+QkddvuqbwKFGw5
         NNqqQL7MJRL8o5afvaoXGXt4M2Y5EUJhZvfO8yDoT8KKFGuNv4uRv4JQKKveXRRez2CH
         cpC9z+LFWjAtvwcmvfv1o236zgBYalBIf6twvsjmnqLecvTIgrQrJMwXOCE6tXnTXFMn
         ctm9NYACNGn6WIX2bZXp0PHMVPzmFZkGkETZdQjMNpURRfxtWpaAKdqsjVwGkcyG/1Et
         nnhuWEUU1xw2Jry13IAXUIyr1+L4D2uCbd0+m403S9gXx0X5hRfXAZ2XQQ4MIGqEJL4k
         3rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686834656; x=1689426656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CEErg3d4yT8esB8KpwjYxwMfJsf51/geZ+6n58UDGJs=;
        b=CpVBy0MX9Iy1NR7lulxhqIceILJReRzqp023YcZfOEAuWlFMTtq7w9fTyNPHmIUPKF
         9AIQabK/0YVyqp1v/kbNLBRr+nkeTNFUzsv0Ww9oydDFAEYqG3iB9BMqBDuAiMbjzBMf
         +4cXAujwGM9PERvXBjorAg2m6X1saV5f/AkF36l2Ss+xrLnO7Tsuzun+kASKYGSy89QT
         C1ZhvdRWbQRgpKEpyIAsfLNyLGKBROp2hHi8yM8K3XTJVkJP/lO6ISm16NXeYVoewO2b
         fxGaHIUqaMA4/435NaD7OM/oi1PFWM8H59zce+fBgmdNsKY4AF8uad9ww1/xGrXvJl48
         kgYQ==
X-Gm-Message-State: AC+VfDxpAi/XC22tMyjTpdgtdVJy2Cmw6gTwRJMCWvlj+U8jUD+0fyzf
        IDWrA/hRWQrINO0NbKFDOJ0DfA==
X-Google-Smtp-Source: ACHHUZ66o8V5eliveHpTDDCN4qg3tEA6UrvtjbBXn2YuCrBWuT9CqkfigWT9RVAiW4pUBar41PkAow==
X-Received: by 2002:a05:6a20:72ac:b0:10c:2349:459d with SMTP id o44-20020a056a2072ac00b0010c2349459dmr5255910pzk.11.1686834656065;
        Thu, 15 Jun 2023 06:10:56 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902b40100b001a804b16e38sm14036019plr.150.2023.06.15.06.10.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jun 2023 06:10:54 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 8/8] maple_tree: drop mas_first_entry()
Date:   Thu, 15 Jun 2023 21:08:59 +0800
Message-Id: <20230615130859.21858-9-zhangpeng.00@bytedance.com>
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

The internal function mas_first_entry() is no longer used, so drop it.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 72 ------------------------------------------------
 1 file changed, 72 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4c9f40322f5f..3908a3937214 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6658,78 +6658,6 @@ static inline struct maple_enode *mas_get_slot(struct ma_state *mas,
 			offset);
 }
 
-
-/*
- * mas_first_entry() - Go the first leaf and find the first entry.
- * @mas: the maple state.
- * @limit: the maximum index to check.
- * @*r_start: Pointer to set to the range start.
- *
- * Sets mas->offset to the offset of the entry, r_start to the range minimum.
- *
- * Return: The first entry or MAS_NONE.
- */
-static inline void *mas_first_entry(struct ma_state *mas, struct maple_node *mn,
-		unsigned long limit, enum maple_type mt)
-
-{
-	unsigned long max;
-	unsigned long *pivots;
-	void __rcu **slots;
-	void *entry = NULL;
-
-	mas->index = mas->min;
-	if (mas->index > limit)
-		goto none;
-
-	max = mas->max;
-	mas->offset = 0;
-	while (likely(!ma_is_leaf(mt))) {
-		MAS_WARN_ON(mas, mte_dead_node(mas->node));
-		slots = ma_slots(mn, mt);
-		entry = mas_slot(mas, slots, 0);
-		pivots = ma_pivots(mn, mt);
-		if (unlikely(ma_dead_node(mn)))
-			return NULL;
-		max = pivots[0];
-		mas->node = entry;
-		mn = mas_mn(mas);
-		mt = mte_node_type(mas->node);
-	}
-	MAS_WARN_ON(mas, mte_dead_node(mas->node));
-
-	mas->max = max;
-	slots = ma_slots(mn, mt);
-	entry = mas_slot(mas, slots, 0);
-	if (unlikely(ma_dead_node(mn)))
-		return NULL;
-
-	/* Slot 0 or 1 must be set */
-	if (mas->index > limit)
-		goto none;
-
-	if (likely(entry))
-		return entry;
-
-	mas->offset = 1;
-	entry = mas_slot(mas, slots, 1);
-	pivots = ma_pivots(mn, mt);
-	if (unlikely(ma_dead_node(mn)))
-		return NULL;
-
-	mas->index = pivots[0] + 1;
-	if (mas->index > limit)
-		goto none;
-
-	if (likely(entry))
-		return entry;
-
-none:
-	if (likely(!ma_dead_node(mn)))
-		mas->node = MAS_NONE;
-	return NULL;
-}
-
 /* Depth first search, post-order */
 static void mas_dfs_postorder(struct ma_state *mas, unsigned long max)
 {
-- 
2.20.1

