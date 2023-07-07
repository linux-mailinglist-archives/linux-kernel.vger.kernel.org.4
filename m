Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16F474AE8C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjGGKLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjGGKLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:11:19 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5A390
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 03:11:18 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a3e1152c23so1128260b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 03:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688724678; x=1691316678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=376wTeQ3MEMNHnxgt+OCJ0TDActL9tQSOLamj68yJ5U=;
        b=PH/CUggzy+Hxz5qtH/dAxeLKw8S9A4JGuhCxm6hb0Ho8ugH8PNZPXdHsNK/dF3dXgb
         j6aJl9zqPLPGAp0yGJXE0K3vu8RluCKZlgl4NGeIqNSGN8HJZn0b19LlAKncVwYP4SSU
         VP/hrp0Tvg4zU+zYj4sdffzcqwQV/Ns5I2BhsH/1gU23wwSEka9ZxHnVAbJ2y+HtMRDI
         dW9Tpmv/4fOobkulXGSHkUdl3dPtG1Ti2HrYQtwhoxgxdjnm0RCcNJIP5yxgrMlY8rV3
         a9rOZaQQML7Pd33PczJIEt2/kZ4Ypaz04/ehaYYH+NkctzWpjhoUMuPNQXxMCNi14HgL
         mdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688724678; x=1691316678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=376wTeQ3MEMNHnxgt+OCJ0TDActL9tQSOLamj68yJ5U=;
        b=TRbgZjWGEDWq+7XggAPZgmm1FCaSnIHrSaRVOUeAw5Re+1YxUwFugwXlEp0rAnd9fk
         5d6LFD/bdpqq8djImm94ORbSF2/s48UnKGb+zIuf+g1FzHtaydlbZd/hfw2n95N+5F9H
         KyoJ1Y9yPqAlog9AtjVJPUt6F9tX3zWGjjgm007Ryr4qbJmUtZNpoA2n5JMlUC1rsi8z
         H7qUfx4HrTc12be/8j2M4bnzzza972kcrPWPveTs748GpN6RUhbxSGdVQXPwR4xMQYUO
         hm/1z/GWI1nzEkdGokSnPXC1x9E/Pu6YH3Hs0aABaNayXWri8tdCE/1pILHakgLV6GGa
         q4GA==
X-Gm-Message-State: ABy/qLao0TtVGsRJUPhlyWO4AIKuL8iWkbGT97ptkeDH0itVPW+3pQWy
        1rp8oW6nzv7Sgt3fR5VP4zESZQ==
X-Google-Smtp-Source: APBJJlE96i/YYNYS+fT4KqAljST0vit2oDr5jySn4ZcFemFzRqybxbcHYXwxFe67VUmmDE8I/GOxMg==
X-Received: by 2002:a05:6808:1496:b0:3a3:ece5:83e0 with SMTP id e22-20020a056808149600b003a3ece583e0mr1237051oiw.26.1688724677972;
        Fri, 07 Jul 2023 03:11:17 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id x11-20020a056a00270b00b0068288aaf23esm2602549pfv.100.2023.07.07.03.11.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 07 Jul 2023 03:11:17 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [RESEND PATCH 2/8] maple_tree: don't use MAPLE_ARANGE64_META_MAX to indicate no gap
Date:   Fri,  7 Jul 2023 18:10:51 +0800
Message-Id: <20230707101057.29326-3-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
References: <20230707101057.29326-1-zhangpeng.00@bytedance.com>
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

Do not use a special offset to indicate that there is no gap. When there
is no gap, offset can point to any valid slots because its gap is 0.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 include/linux/maple_tree.h |  2 --
 lib/maple_tree.c           | 13 ++-----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index e18ecbefc7f7..4e004d86c780 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -29,14 +29,12 @@
 #define MAPLE_NODE_SLOTS	31	/* 256 bytes including ->parent */
 #define MAPLE_RANGE64_SLOTS	16	/* 256 bytes */
 #define MAPLE_ARANGE64_SLOTS	10	/* 240 bytes */
-#define MAPLE_ARANGE64_META_MAX	15	/* Out of range for metadata */
 #define MAPLE_ALLOC_SLOTS	(MAPLE_NODE_SLOTS - 1)
 #else
 /* 32bit sizes */
 #define MAPLE_NODE_SLOTS	63	/* 256 bytes including ->parent */
 #define MAPLE_RANGE64_SLOTS	32	/* 256 bytes */
 #define MAPLE_ARANGE64_SLOTS	21	/* 240 bytes */
-#define MAPLE_ARANGE64_META_MAX	31	/* Out of range for metadata */
 #define MAPLE_ALLOC_SLOTS	(MAPLE_NODE_SLOTS - 2)
 #endif /* defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64) */
 
diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f55e59bd9122..6a8982146338 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1610,8 +1610,6 @@ ma_max_gap(struct maple_node *node, unsigned long *gaps, enum maple_type mt,
  * mas_max_gap() - find the largest gap in a non-leaf node and set the slot.
  * @mas: The maple state.
  *
- * If the metadata gap is set to MAPLE_ARANGE64_META_MAX, there is no gap.
- *
  * Return: The gap value.
  */
 static inline unsigned long mas_max_gap(struct ma_state *mas)
@@ -1628,9 +1626,6 @@ static inline unsigned long mas_max_gap(struct ma_state *mas)
 	node = mas_mn(mas);
 	MAS_BUG_ON(mas, mt != maple_arange_64);
 	offset = ma_meta_gap(node, mt);
-	if (offset == MAPLE_ARANGE64_META_MAX)
-		return 0;
-
 	gaps = ma_gaps(node, mt);
 	return gaps[offset];
 }
@@ -1662,10 +1657,7 @@ static inline void mas_parent_gap(struct ma_state *mas, unsigned char offset,
 ascend:
 	MAS_BUG_ON(mas, pmt != maple_arange_64);
 	meta_offset = ma_meta_gap(pnode, pmt);
-	if (meta_offset == MAPLE_ARANGE64_META_MAX)
-		meta_gap = 0;
-	else
-		meta_gap = pgaps[meta_offset];
+	meta_gap = pgaps[meta_offset];
 
 	pgaps[offset] = new;
 
@@ -1678,7 +1670,6 @@ static inline void mas_parent_gap(struct ma_state *mas, unsigned char offset,
 
 		ma_set_meta_gap(pnode, pmt, offset);
 	} else if (new < meta_gap) {
-		meta_offset = 15;
 		new = ma_max_gap(pnode, pgaps, pmt, &meta_offset);
 		ma_set_meta_gap(pnode, pmt, meta_offset);
 	}
@@ -2076,7 +2067,7 @@ static inline void mab_mas_cp(struct maple_big_node *b_node,
 	end = j - 1;
 	if (likely(!ma_is_leaf(mt) && mt_is_alloc(mas->tree))) {
 		unsigned long max_gap = 0;
-		unsigned char offset = 15;
+		unsigned char offset = 0;
 
 		gaps = ma_gaps(node, mt);
 		do {
-- 
2.20.1

