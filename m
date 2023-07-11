Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652C074E594
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGKD4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjGKDzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:55:51 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE43510C2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:55:22 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8bd586086so39283265ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689047722; x=1691639722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OtSvFihiDnLwRXPS16aFXYvoQJZK7qgLbCrmPMdkz4=;
        b=FG0CUQd2LZZyzjMyMvHehaF916WG7DrINm7YYqYYtJ5WS2xrMsL6v25DynuNojHGcY
         wxJHLbsZd3VzymebJe3AbpxVxh8p92JQt1W7oYL6JGZPHChw5F2mpgzCFQjPgG/pRgrG
         R9SdhrLWfRfpui4ajHnLe7B+Ce7DB6fG7EHTKc6H4b6krsWfzkslA3A6kJ65n57EMi67
         r7wGoSifkbrij6l+nuuX6+RLAvIa2M1VBQhNUZmrtD8uC9zIzrLOoK3lLbRmmWWH00zi
         F5dCS62bKbff4y7LupnA6PVUNnnxTM6u1aOsADrPYPfQ8pjREh97a5YCVgY0pq0yCm7r
         /dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689047722; x=1691639722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OtSvFihiDnLwRXPS16aFXYvoQJZK7qgLbCrmPMdkz4=;
        b=G0NP3W+3fPLpFQ1DbsgJPjkwo3ODmuZ5aDzqICwDsAfHIz1Yt9hnbgq8wXcs+1yLwa
         PlSHxVYjl1rtct1EQNBnDv3qN6nrnkI/UHC64TAunhD4PyZ1JvZ6r5ZniCIhoF9wb6lx
         o61+ZwYpd61BSqJ+0qm2+cPMEHg72tM7sUBhH5G1A3KXRTnyOp8DKbM5b/88UNyBW5oe
         9tHxVuYM5zdcSWZHVCNFcsylY5SW95HDyR/nCoauHpR+HfpdTH6HKltaYpaH0i8M2mS7
         XISYbNcAcFO141TmJxuGGDFdQeCg4tGRNXs1H7+o/MGYWhjLOVtd4KAyq7Bl45EncgRF
         azQw==
X-Gm-Message-State: ABy/qLYHTfNN0aGwGAle2dmB4hT3LXO8kbb82/IYVRUrAFrwyW1WPmbM
        em0nf83MPdpULKH8+Dn7r4IKtw==
X-Google-Smtp-Source: APBJJlEH9ks+ldoqWiak1C46jFp9K+PHzKkaAAEHH5o80WCKWCeDBoMcB9O6Ge8DSYjubjyST3RT1w==
X-Received: by 2002:a17:902:ecc2:b0:1b9:d439:c009 with SMTP id a2-20020a170902ecc200b001b9d439c009mr10667995plh.57.1689047722210;
        Mon, 10 Jul 2023 20:55:22 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id b15-20020a170903228f00b001b872c17535sm688329plh.13.2023.07.10.20.55.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Jul 2023 20:55:22 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 8/8] maple_tree: drop mas_first_entry()
Date:   Tue, 11 Jul 2023 11:54:44 +0800
Message-Id: <20230711035444.526-9-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230711035444.526-1-zhangpeng.00@bytedance.com>
References: <20230711035444.526-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The internal function mas_first_entry() is no longer used, so drop it.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 72 ------------------------------------------------
 1 file changed, 72 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 5eb5eede2727..bd4557eeb42c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6662,78 +6662,6 @@ static inline struct maple_enode *mas_get_slot(struct ma_state *mas,
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

