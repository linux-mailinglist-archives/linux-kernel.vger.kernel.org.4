Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C4B74E590
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 05:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjGKDzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 23:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjGKDzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 23:55:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC7CE4D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:55:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b8b318c5a7so38828905ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 20:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689047704; x=1691639704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTNORhAMfZiekvn/WZoJTK6LhdTh4U3lAjASoHlporQ=;
        b=Rxbx43isig3S+GFU16br5sALnoQtHUSEfGe8cb+ol6pqYx3UiUAaexdoL7DR65ZV81
         3BODyot5ZjoWbtgXrORsNGEWWtJ8jdaf2v8QLo99182QN4+QD5t7R2T05RsHZ+/W79Zv
         TwWyCEEUja+pliatca1lfjHTT5nZ6/CwqIIW8MyHzRJ/10vt2Kw7wPEfjwzbDzjkbW8L
         oRk3casJ7rRn20xOrC09xX6p1x+1YVSWI1WJNd8e+wU6yNu5GRbwhqi7LWhFFPDyuAWz
         +6A0BSCS9J/6Mu2Ku/InixWET9G+pAzYMPbE3oiCwyI7VkhzmRHkrRpGcj64xjJvPZ0Q
         BbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689047704; x=1691639704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTNORhAMfZiekvn/WZoJTK6LhdTh4U3lAjASoHlporQ=;
        b=CqXT+dOr2SBMPew24VIEQbhcacscxKJf4P5WIp+bzD3N4DvxqqDzYQOcJUQ+R4mJaB
         LuP5qCQTgbN3UI+JWYN54zvQMDTYis7PlW62Pv/bIwCaou4+JxE050eSUuNDkcGxSheP
         EV2E3DQvfa5TI8v+uXvJkQTrkBBzWuIY466EHyVyF3wvIzLqoNL2cmRptzUoAsf6fQSg
         oLkYyqgrGWenOLmqoFYE9YM6nBwheN8Y1ddOt7au+ZVF/8REbaGjH3n/nj4qDZLhnHW+
         j1Vh6Rk1xQPK4W/E+9f3bxN5eFgFyNOTYhZMUCq1BN4beptiW+D5Dwp4ADUG3JllFJG6
         4NKQ==
X-Gm-Message-State: ABy/qLZ7x6BZBaRVmslDIFaSL+4z3RjFcSSK3aXb3UXtRLYBAYazzcwh
        BCrpYoQIdABCSOxGqntJ3iSyOQ==
X-Google-Smtp-Source: APBJJlHl4mfJ9Y+/M0jhzcC8s4QeCj9XHWKUmY872oNAImgfWhir2FpEPfZ6WWSLjO/pMZSofQvtWA==
X-Received: by 2002:a17:903:26d3:b0:1b8:a88c:4dc6 with SMTP id jg19-20020a17090326d300b001b8a88c4dc6mr14392136plb.45.1689047704708;
        Mon, 10 Jul 2023 20:55:04 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id b15-20020a170903228f00b001b872c17535sm688329plh.13.2023.07.10.20.55.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Jul 2023 20:55:04 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 2/8] maple_tree: don't use MAPLE_ARANGE64_META_MAX to indicate no gap
Date:   Tue, 11 Jul 2023 11:54:38 +0800
Message-Id: <20230711035444.526-3-zhangpeng.00@bytedance.com>
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

Do not use a special offset to indicate that there is no gap. When there
is no gap, offset can point to any valid slots because its gap is 0.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
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

