Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D6273199A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343815AbjFONLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343637AbjFONK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:10:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2B926AF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:33 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b51488ad67so6044445ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686834633; x=1689426633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6/zuKtdX43AYOwkx8Y/LcH+jU9PgkVm8ZKPRILAQQ4=;
        b=lacYI1rdr01pCdKfMnHhOKSCgbbBcVdmvwoMpr0oZyI57wLUeehSv5VQlOckRsf5J3
         QwhNEOl0DD1FfI3cPy9Z9ARfNVfzViCEPcpq03XbXk5so1vLbh7DPPRvpWO1zi4bomBO
         5EbytiQEqeWF2jRC+LaPbXlHtXlCG4qOPd7q7hU8lFSMsJL5SL0LGE4TM/XGlK6GPGuJ
         iXGq9IAho5nY3K2O6BfuUmtjOhLdtYDQ2x1ilR7xqptKeCyr9ahA4zheIQqe3U2QGjsA
         xUmmiKov49NhTlzUKrGnBWPBapM+IwdvYyEfaCSov4WzDmpMBvBIQUcB1Z2ef64knjTX
         tz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686834633; x=1689426633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6/zuKtdX43AYOwkx8Y/LcH+jU9PgkVm8ZKPRILAQQ4=;
        b=Tk09dPvHJOMzFdrm26mNez1GWk1SZKASNTJQiOOVVlvydxhvYYTF4jrdtjDy5viX1e
         yBSzqhSxFgQxmPjqbizuF/hRsjS/pF0QLW/9eYMBvsJWXUMyJ2DHNp11KcNUi3cgnhbu
         ipmY740+8YCo0R3FABG7DGrBAbfTK9jwAaA4yAyCKV9QGqCPbKs8qkAIEt/KwAeYex6R
         ZJ151raIrPQ/O8i8iHRHPLgzw3gZoIACD07B2zmDRziHEQ+h52MpR4FrJMlkTQexdXiG
         UjsqIzLTj0QHXY3CSi+tg5CwCkOZZSXsWzpxv5Jrn1VL1uyBsvkqHIzjq7P3grMX2JJw
         iIjA==
X-Gm-Message-State: AC+VfDxx/qbkPhRe9Nr+vfSbAt4DhZRCuKCq5TblY7Lfi3e6ga0RYZ/M
        2A7rbk7qVckYlybGx3sM4RBszQ==
X-Google-Smtp-Source: ACHHUZ6ClsMMuqONIhSHw0V4cLgVblslnQbletm4QH4BqdufHG1FhyUbrsEu2gxGbJhTSD33t7/k6Q==
X-Received: by 2002:a17:903:32c3:b0:1b3:d8ac:8db5 with SMTP id i3-20020a17090332c300b001b3d8ac8db5mr10723526plr.40.1686834633447;
        Thu, 15 Jun 2023 06:10:33 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id x1-20020a170902b40100b001a804b16e38sm14036019plr.150.2023.06.15.06.10.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Jun 2023 06:10:32 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 2/8] maple_tree: don't use MAPLE_ARANGE64_META_MAX to indicate no gap
Date:   Thu, 15 Jun 2023 21:08:53 +0800
Message-Id: <20230615130859.21858-3-zhangpeng.00@bytedance.com>
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
index 23202edb9f1e..8aba9e419e08 100644
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

