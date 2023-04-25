Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8516EE0CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbjDYLFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbjDYLFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:05:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA0D12C9C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b5ce4f069so7034069b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1682420738; x=1685012738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2GjseRaZiiYKMGFnELwsfMhZhXtBsHUr2pHKO1ngQg=;
        b=fHIvqUmZ5phg4ETfqPuneR+uYrbeTFZNsqI5XZ3pc1dHVDhJLXx+0FexrM2XAJvjaz
         DMzNPe20gZ+NCvxomVoNk7+UR79+C4T1KVvfdllMBQIDgMY2UOCW0DZxkYp6oq2Foui9
         Ad9oYzSTeGVri7alkJmHqYVcyUWCNAu61TGufp92Z8nGIMFj2zHiAVh9QMlyZMs8/X3n
         JaD5Z0SXR5QS9EAY/zo799iZxw/XCaMS5nZZFNEXsZ0uC8UWjlS5NmmnRb97ispvDyTB
         fJlLf2vgbq63ZL3bQSR/z4beNrVcaH7kTiLmle7C9I7G5kwKfFlFnPgkfKKqhnrV3Mw7
         FUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682420738; x=1685012738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2GjseRaZiiYKMGFnELwsfMhZhXtBsHUr2pHKO1ngQg=;
        b=PYuY0KzMPMDIjyRFbDRUduMsmW2BLuYO5GB1fiDKRB7Yz1p3oBON3Q5VLHMVh18DLd
         ecgo4y6DHJAoJM5LruxoTG3yMkVcAIOc3lARaWUGlRAk759kCUe4XDAgGC6TiZq4pdI4
         ei5Mw6DYimuYiaAxpAOlgvdXruvtwF2FN9GLydKfzNjlrm/o0q3tE7F7uXdw9y+/PeuY
         8zQE7pRfD0F9eJYCNExNX2ZiOkm8HMb5KE1Wo3WHHsNcUviCunwcEsXreaPPyRspilQO
         VA6KczwBgBygmijpRsVDsRFOfQ9mdlIi6nshjsNBBuDoXrhaSAYrMqnLbZY5lZcwKEIw
         NVpA==
X-Gm-Message-State: AAQBX9dymllCaZViv+aG4H+FfzSKnPZ9me7MPIGJb8+ak7H/Nve9m+CS
        OI9tz75cHm1Zg2StZYnIOvjmmA==
X-Google-Smtp-Source: AKy350awbzXJx1QHpvFyg+xGDq1ex4M+sbcmkf9pb2UwPJHCYhwULi9AWE37QwzjYRLfzfHBJukZkw==
X-Received: by 2002:a05:6a00:1581:b0:63b:8a91:e641 with SMTP id u1-20020a056a00158100b0063b8a91e641mr22828410pfk.11.1682420738337;
        Tue, 25 Apr 2023 04:05:38 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id u3-20020a056a00158300b0063f3aac78b9sm4422169pfk.79.2023.04.25.04.05.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Apr 2023 04:05:38 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 4/9] maple_tree: Update mtree_alloc_rrange() and mtree_alloc_range() testing
Date:   Tue, 25 Apr 2023 19:05:06 +0800
Message-Id: <20230425110511.11680-5-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
References: <20230425110511.11680-1-zhangpeng.00@bytedance.com>
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

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

The previous changes to the gap searching made this testing fail.
Unfortunately, there was not a safe update order, so fix the testing
now.

Fixes: e15e06a83923 ("lib/test_maple_tree: add testing for maple tree")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Co-developed-by: Peng Zhang <zhangpeng.00@bytedance.com>
Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/test_maple_tree.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index f1db333270e9f..30f2ebff95d75 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -102,7 +102,7 @@ static noinline void check_mtree_alloc_rrange(struct maple_tree *mt,
 	unsigned long result = expected + 1;
 	int ret;
 
-	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end - 1,
+	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end,
 			GFP_KERNEL);
 	MT_BUG_ON(mt, ret != eret);
 	if (ret)
@@ -680,7 +680,7 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 		0,              /* Return value success. */
 
 		0x0,            /* Min */
-		0x565234AF1 << 12,    /* Max */
+		0x565234AF0 << 12,    /* Max */
 		0x3000,         /* Size */
 		0x565234AEE << 12,  /* max - 3. */
 		0,              /* Return value success. */
@@ -692,14 +692,14 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 		0,              /* Return value success. */
 
 		0x0,            /* Min */
-		0x7F36D510A << 12,    /* Max */
+		0x7F36D5109 << 12,    /* Max */
 		0x4000,         /* Size */
 		0x7F36D5106 << 12,    /* First rev hole of size 0x4000 */
 		0,              /* Return value success. */
 
 		/* Ascend test. */
 		0x0,
-		34148798629 << 12,
+		34148798628 << 12,
 		19 << 12,
 		34148797418 << 12,
 		0x0,
@@ -711,6 +711,12 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 		0x0,
 		-EBUSY,
 
+		/* Single space test. */
+		34148798725 << 12,
+		34148798725 << 12,
+		1 << 12,
+		34148798725 << 12,
+		0,
 	};
 
 	int i, range_count = ARRAY_SIZE(range);
@@ -759,9 +765,9 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 	mas_unlock(&mas);
 	for (i = 0; i < req_range_count; i += 5) {
 #if DEBUG_REV_RANGE
-		pr_debug("\tReverse request between %lu-%lu size %lu, should get %lu\n",
-				req_range[i] >> 12,
-				(req_range[i + 1] >> 12) - 1,
+		pr_debug("\tReverse request %d between %lu-%lu size %lu, should get %lu\n",
+				i, req_range[i] >> 12,
+				(req_range[i + 1] >> 12),
 				req_range[i+2] >> 12,
 				req_range[i+3] >> 12);
 #endif
@@ -777,6 +783,7 @@ static noinline void check_alloc_rev_range(struct maple_tree *mt)
 
 	mt_set_non_kernel(1);
 	mtree_erase(mt, 34148798727); /* create a deleted range. */
+	mtree_erase(mt, 34148798725);
 	check_mtree_alloc_rrange(mt, 0, 34359052173, 210253414,
 			34148798725, 0, mt);
 
@@ -880,6 +887,13 @@ static noinline void check_alloc_range(struct maple_tree *mt)
 		4503599618982063UL << 12,  /* Size */
 		34359052178 << 12,  /* Expected location */
 		-EBUSY,             /* Return failure. */
+
+		/* Test a single entry */
+		34148798648 << 12,		/* Min */
+		34148798648 << 12,		/* Max */
+		4096,			/* Size of 1 */
+		34148798648 << 12,	/* Location is the same as min/max */
+		0,			/* Success */
 	};
 	int i, range_count = ARRAY_SIZE(range);
 	int req_range_count = ARRAY_SIZE(req_range);
@@ -2660,7 +2674,7 @@ static noinline void check_empty_area_window(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_empty_area(&mas, 5, 100, 6) != -EBUSY);
 
 	mas_reset(&mas);
-	MT_BUG_ON(mt, mas_empty_area(&mas, 0, 8, 10) != -EBUSY);
+	MT_BUG_ON(mt, mas_empty_area(&mas, 0, 8, 10) != -EINVAL);
 
 	mas_reset(&mas);
 	mas_empty_area(&mas, 100, 165, 3);
-- 
2.20.1

