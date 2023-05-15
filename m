Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1057E702DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242082AbjEONTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241373AbjEONS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:18:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4889910A
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:28 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5208be24dcbso9137435a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1684156708; x=1686748708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EveqtihCJt7fcxXdeINag7+zgOnp1O/guDL1F4v1dKU=;
        b=iH5wFnjAsZmRlAplDuTJ9I2hT2yvPCtbCKAQtoKqkq9S613j7lIiGO7vKZbSxzeW9h
         y+bsbpYKxsSfj0ALt0rm64PBjNnXlkahKtOH0yA3Cur9j3p8fSEUf6LVDIwbYOyemyEx
         JbYvB6KqpsD9G8GEDUDuDf2iQmVs2gW09IIshiqQf6gjH417PbMKiSGifdc7GmoEQfm0
         KYF8J1oWTM6zH6D4HVei6jdxOb9NOAUCc5G2cdQbBoM16/K567m0A03DOMoHDmNhYIRZ
         QiTRh5AtBQdJ1rnV9qTdcMXoAqu/IC34CoDAq4WgSRaGVQANFFafyPMJBUaFX4iT1wXS
         W+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156708; x=1686748708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EveqtihCJt7fcxXdeINag7+zgOnp1O/guDL1F4v1dKU=;
        b=Zg9PvVcYtyK36IWuGPlk3xYX2RV7DJBbvtvmPTKXkSbOF35PRAK5KLwY/HriRVjyBs
         e5MWTqE0MuoNaoLGCzF3O98922wbUlz//ZwAoO4QMdRC0guScTuZI0wBgdl5WCuQ+Tza
         KDjyWCtxu5t6Q/KCAKietNyUqnZvt8Lj5YB/T1h9M/5TVn3ACRs8bwcQ8/NWPZTupXl7
         L/POaf8PTJSsw0i26eagJaymnXwZHib4Tcqr8no6ekRLM94A+wOr4XseduEpWdClc8lf
         /cBsCAj3e1oMIicj2SBi+cIWf6VXzB6d7/ZJhNs6KTgAwenjOhjMzmooasLsFfdahjQ2
         y8Qg==
X-Gm-Message-State: AC+VfDwdWnQd6dKY+HcsW2tj9ho3F57cOgFvdsNzWmj1aYtJ04HRLlZW
        HgoDSO04+rqVOCOsyhVvtRmwQA==
X-Google-Smtp-Source: ACHHUZ7JMEsSVoqIlBjE6pkY5JjMvLaZiehEFdZD2uDcVkyZJj0xmJh8G6Mir8ezq0lEU2wjPZzOhQ==
X-Received: by 2002:a17:90a:9906:b0:23f:83de:7e4a with SMTP id b6-20020a17090a990600b0023f83de7e4amr31914390pjp.7.1684156707618;
        Mon, 15 May 2023 06:18:27 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id gl20-20020a17090b121400b0024749e7321bsm14190014pjb.6.2023.05.15.06.18.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 May 2023 06:18:27 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 01/10] maple_tree: Drop the test code for mtree_alloc_{range,rrange}()
Date:   Mon, 15 May 2023 21:17:48 +0800
Message-Id: <20230515131757.60035-2-zhangpeng.00@bytedance.com>
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

Drop the test code for mtree_alloc_{range,rrange}() because we are going
to drop them.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/test_maple_tree.c | 389 ------------------------------------------
 1 file changed, 389 deletions(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index 9939be34e516e..86d7f742d243e 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -97,42 +97,6 @@ static void __init *mtree_test_erase(struct maple_tree *mt, unsigned long index)
 	return mtree_erase(mt, index);
 }
 
-#if defined(CONFIG_64BIT)
-static noinline void __init check_mtree_alloc_range(struct maple_tree *mt,
-		unsigned long start, unsigned long end, unsigned long size,
-		unsigned long expected, int eret, void *ptr)
-{
-
-	unsigned long result = expected + 1;
-	int ret;
-
-	ret = mtree_alloc_range(mt, &result, ptr, size, start, end,
-			GFP_KERNEL);
-	MT_BUG_ON(mt, ret != eret);
-	if (ret)
-		return;
-
-	MT_BUG_ON(mt, result != expected);
-}
-
-static noinline void __init check_mtree_alloc_rrange(struct maple_tree *mt,
-		unsigned long start, unsigned long end, unsigned long size,
-		unsigned long expected, int eret, void *ptr)
-{
-
-	unsigned long result = expected + 1;
-	int ret;
-
-	ret = mtree_alloc_rrange(mt, &result, ptr, size, start, end,
-			GFP_KERNEL);
-	MT_BUG_ON(mt, ret != eret);
-	if (ret)
-		return;
-
-	MT_BUG_ON(mt, result != expected);
-}
-#endif
-
 static noinline void __init check_load(struct maple_tree *mt,
 				       unsigned long index, void *ptr)
 {
@@ -635,348 +599,6 @@ static noinline void __init check_find_2(struct maple_tree *mt)
 	/*MT_BUG_ON(mt, !mtree_empty(mt)); */
 }
 
-
-#if defined(CONFIG_64BIT)
-static noinline void __init check_alloc_rev_range(struct maple_tree *mt)
-{
-	/*
-	 * Generated by:
-	 * cat /proc/self/maps | awk '{print $1}'|
-	 * awk -F "-" '{printf "0x%s, 0x%s, ", $1, $2}'
-	 */
-
-	static const unsigned long range[] = {
-	/*      Inclusive     , Exclusive. */
-		0x565234af2000, 0x565234af4000,
-		0x565234af4000, 0x565234af9000,
-		0x565234af9000, 0x565234afb000,
-		0x565234afc000, 0x565234afd000,
-		0x565234afd000, 0x565234afe000,
-		0x565235def000, 0x565235e10000,
-		0x7f36d4bfd000, 0x7f36d4ee2000,
-		0x7f36d4ee2000, 0x7f36d4f04000,
-		0x7f36d4f04000, 0x7f36d504c000,
-		0x7f36d504c000, 0x7f36d5098000,
-		0x7f36d5098000, 0x7f36d5099000,
-		0x7f36d5099000, 0x7f36d509d000,
-		0x7f36d509d000, 0x7f36d509f000,
-		0x7f36d509f000, 0x7f36d50a5000,
-		0x7f36d50b9000, 0x7f36d50db000,
-		0x7f36d50db000, 0x7f36d50dc000,
-		0x7f36d50dc000, 0x7f36d50fa000,
-		0x7f36d50fa000, 0x7f36d5102000,
-		0x7f36d5102000, 0x7f36d5103000,
-		0x7f36d5103000, 0x7f36d5104000,
-		0x7f36d5104000, 0x7f36d5105000,
-		0x7fff5876b000, 0x7fff5878d000,
-		0x7fff5878e000, 0x7fff58791000,
-		0x7fff58791000, 0x7fff58793000,
-	};
-
-	static const unsigned long holes[] = {
-		/*
-		 * Note: start of hole is INCLUSIVE
-		 *        end of hole is EXCLUSIVE
-		 *        (opposite of the above table.)
-		 * Start of hole, end of hole,  size of hole (+1)
-		 */
-		0x565234afb000, 0x565234afc000, 0x1000,
-		0x565234afe000, 0x565235def000, 0x12F1000,
-		0x565235e10000, 0x7f36d4bfd000, 0x28E49EDED000,
-	};
-
-	/*
-	 * req_range consists of 4 values.
-	 * 1. min index
-	 * 2. max index
-	 * 3. size
-	 * 4. number that should be returned.
-	 * 5. return value
-	 */
-	static const unsigned long req_range[] = {
-		0x565234af9000, /* Min */
-		0x7fff58791000, /* Max */
-		0x1000,         /* Size */
-		0x7fff5878d << 12,  /* First rev hole of size 0x1000 */
-		0,              /* Return value success. */
-
-		0x0,            /* Min */
-		0x565234AF0 << 12,    /* Max */
-		0x3000,         /* Size */
-		0x565234AEE << 12,  /* max - 3. */
-		0,              /* Return value success. */
-
-		0x0,            /* Min */
-		-1,             /* Max */
-		0x1000,         /* Size */
-		562949953421311 << 12,/* First rev hole of size 0x1000 */
-		0,              /* Return value success. */
-
-		0x0,            /* Min */
-		0x7F36D5109 << 12,    /* Max */
-		0x4000,         /* Size */
-		0x7F36D5106 << 12,    /* First rev hole of size 0x4000 */
-		0,              /* Return value success. */
-
-		/* Ascend test. */
-		0x0,
-		34148798628 << 12,
-		19 << 12,
-		34148797418 << 12,
-		0x0,
-
-		/* Too big test. */
-		0x0,
-		18446744073709551615UL,
-		562915594369134UL << 12,
-		0x0,
-		-EBUSY,
-
-		/* Single space test. */
-		34148798725 << 12,
-		34148798725 << 12,
-		1 << 12,
-		34148798725 << 12,
-		0,
-	};
-
-	int i, range_count = ARRAY_SIZE(range);
-	int req_range_count = ARRAY_SIZE(req_range);
-	unsigned long min = 0;
-
-	MA_STATE(mas, mt, 0, 0);
-
-	mtree_store_range(mt, MTREE_ALLOC_MAX, ULONG_MAX, XA_ZERO_ENTRY,
-			  GFP_KERNEL);
-#define DEBUG_REV_RANGE 0
-	for (i = 0; i < range_count; i += 2) {
-		/* Inclusive, Inclusive (with the -1) */
-
-#if DEBUG_REV_RANGE
-		pr_debug("\t%s: Insert %lu-%lu\n", __func__, range[i] >> 12,
-				(range[i + 1] >> 12) - 1);
-#endif
-		check_insert_range(mt, range[i] >> 12, (range[i + 1] >> 12) - 1,
-				xa_mk_value(range[i] >> 12), 0);
-		mt_validate(mt);
-	}
-
-
-	mas_lock(&mas);
-	for (i = 0; i < ARRAY_SIZE(holes); i += 3) {
-#if DEBUG_REV_RANGE
-		pr_debug("Search from %lu-%lu for gap %lu should be at %lu\n",
-				min, holes[i+1]>>12, holes[i+2]>>12,
-				holes[i] >> 12);
-#endif
-		MT_BUG_ON(mt, mas_empty_area_rev(&mas, min,
-					holes[i+1] >> 12,
-					holes[i+2] >> 12));
-#if DEBUG_REV_RANGE
-		pr_debug("Found %lu %lu\n", mas.index, mas.last);
-		pr_debug("gap %lu %lu\n", (holes[i] >> 12),
-				(holes[i+1] >> 12));
-#endif
-		MT_BUG_ON(mt, mas.last + 1 != (holes[i+1] >> 12));
-		MT_BUG_ON(mt, mas.index != (holes[i+1] >> 12) - (holes[i+2] >> 12));
-		min = holes[i+1] >> 12;
-		mas_reset(&mas);
-	}
-
-	mas_unlock(&mas);
-	for (i = 0; i < req_range_count; i += 5) {
-#if DEBUG_REV_RANGE
-		pr_debug("\tReverse request %d between %lu-%lu size %lu, should get %lu\n",
-				i, req_range[i] >> 12,
-				(req_range[i + 1] >> 12),
-				req_range[i+2] >> 12,
-				req_range[i+3] >> 12);
-#endif
-		check_mtree_alloc_rrange(mt,
-				req_range[i]   >> 12, /* start */
-				req_range[i+1] >> 12, /* end */
-				req_range[i+2] >> 12, /* size */
-				req_range[i+3] >> 12, /* expected address */
-				req_range[i+4],       /* expected return */
-				xa_mk_value(req_range[i] >> 12)); /* pointer */
-		mt_validate(mt);
-	}
-
-	mt_set_non_kernel(1);
-	mtree_erase(mt, 34148798727); /* create a deleted range. */
-	mtree_erase(mt, 34148798725);
-	check_mtree_alloc_rrange(mt, 0, 34359052173, 210253414,
-			34148798725, 0, mt);
-
-	mtree_destroy(mt);
-}
-
-static noinline void __init check_alloc_range(struct maple_tree *mt)
-{
-	/*
-	 * Generated by:
-	 * cat /proc/self/maps|awk '{print $1}'|
-	 * awk -F "-" '{printf "0x%s, 0x%s, ", $1, $2}'
-	 */
-
-	static const unsigned long range[] = {
-	/*      Inclusive     , Exclusive. */
-		0x565234af2000, 0x565234af4000,
-		0x565234af4000, 0x565234af9000,
-		0x565234af9000, 0x565234afb000,
-		0x565234afc000, 0x565234afd000,
-		0x565234afd000, 0x565234afe000,
-		0x565235def000, 0x565235e10000,
-		0x7f36d4bfd000, 0x7f36d4ee2000,
-		0x7f36d4ee2000, 0x7f36d4f04000,
-		0x7f36d4f04000, 0x7f36d504c000,
-		0x7f36d504c000, 0x7f36d5098000,
-		0x7f36d5098000, 0x7f36d5099000,
-		0x7f36d5099000, 0x7f36d509d000,
-		0x7f36d509d000, 0x7f36d509f000,
-		0x7f36d509f000, 0x7f36d50a5000,
-		0x7f36d50b9000, 0x7f36d50db000,
-		0x7f36d50db000, 0x7f36d50dc000,
-		0x7f36d50dc000, 0x7f36d50fa000,
-		0x7f36d50fa000, 0x7f36d5102000,
-		0x7f36d5102000, 0x7f36d5103000,
-		0x7f36d5103000, 0x7f36d5104000,
-		0x7f36d5104000, 0x7f36d5105000,
-		0x7fff5876b000, 0x7fff5878d000,
-		0x7fff5878e000, 0x7fff58791000,
-		0x7fff58791000, 0x7fff58793000,
-	};
-	static const unsigned long holes[] = {
-		/* Start of hole, end of hole,  size of hole (+1) */
-		0x565234afb000, 0x565234afc000, 0x1000,
-		0x565234afe000, 0x565235def000, 0x12F1000,
-		0x565235e10000, 0x7f36d4bfd000, 0x28E49EDED000,
-	};
-
-	/*
-	 * req_range consists of 4 values.
-	 * 1. min index
-	 * 2. max index
-	 * 3. size
-	 * 4. number that should be returned.
-	 * 5. return value
-	 */
-	static const unsigned long req_range[] = {
-		0x565234af9000, /* Min */
-		0x7fff58791000, /* Max */
-		0x1000,         /* Size */
-		0x565234afb000, /* First hole in our data of size 1000. */
-		0,              /* Return value success. */
-
-		0x0,            /* Min */
-		0x7fff58791000, /* Max */
-		0x1F00,         /* Size */
-		0x0,            /* First hole in our data of size 2000. */
-		0,              /* Return value success. */
-
-		/* Test ascend. */
-		34148797436 << 12, /* Min */
-		0x7fff587AF000,    /* Max */
-		0x3000,         /* Size */
-		34148798629 << 12,             /* Expected location */
-		0,              /* Return value success. */
-
-		/* Test failing. */
-		34148798623 << 12,  /* Min */
-		34148798683 << 12,  /* Max */
-		0x15000,            /* Size */
-		0,             /* Expected location */
-		-EBUSY,              /* Return value failed. */
-
-		/* Test filling entire gap. */
-		34148798623 << 12,  /* Min */
-		0x7fff587AF000,    /* Max */
-		0x10000,           /* Size */
-		34148798632 << 12,             /* Expected location */
-		0,              /* Return value success. */
-
-		/* Test walking off the end of root. */
-		0,                  /* Min */
-		-1,                 /* Max */
-		-1,                 /* Size */
-		0,                  /* Expected location */
-		-EBUSY,             /* Return value failure. */
-
-		/* Test looking for too large a hole across entire range. */
-		0,                  /* Min */
-		-1,                 /* Max */
-		4503599618982063UL << 12,  /* Size */
-		34359052178 << 12,  /* Expected location */
-		-EBUSY,             /* Return failure. */
-
-		/* Test a single entry */
-		34148798648 << 12,		/* Min */
-		34148798648 << 12,		/* Max */
-		4096,			/* Size of 1 */
-		34148798648 << 12,	/* Location is the same as min/max */
-		0,			/* Success */
-	};
-	int i, range_count = ARRAY_SIZE(range);
-	int req_range_count = ARRAY_SIZE(req_range);
-	unsigned long min = 0x565234af2000;
-	MA_STATE(mas, mt, 0, 0);
-
-	mtree_store_range(mt, MTREE_ALLOC_MAX, ULONG_MAX, XA_ZERO_ENTRY,
-			  GFP_KERNEL);
-	for (i = 0; i < range_count; i += 2) {
-#define DEBUG_ALLOC_RANGE 0
-#if DEBUG_ALLOC_RANGE
-		pr_debug("\tInsert %lu-%lu\n", range[i] >> 12,
-			 (range[i + 1] >> 12) - 1);
-		mt_dump(mt, mt_dump_hex);
-#endif
-		check_insert_range(mt, range[i] >> 12, (range[i + 1] >> 12) - 1,
-				xa_mk_value(range[i] >> 12), 0);
-		mt_validate(mt);
-	}
-
-
-
-	mas_lock(&mas);
-	for (i = 0; i < ARRAY_SIZE(holes); i += 3) {
-
-#if DEBUG_ALLOC_RANGE
-		pr_debug("\tGet empty %lu-%lu size %lu (%lx-%lx)\n", min >> 12,
-			holes[i+1] >> 12, holes[i+2] >> 12,
-			min, holes[i+1]);
-#endif
-		MT_BUG_ON(mt, mas_empty_area(&mas, min >> 12,
-					holes[i+1] >> 12,
-					holes[i+2] >> 12));
-		MT_BUG_ON(mt, mas.index != holes[i] >> 12);
-		min = holes[i+1];
-		mas_reset(&mas);
-	}
-	mas_unlock(&mas);
-	for (i = 0; i < req_range_count; i += 5) {
-#if DEBUG_ALLOC_RANGE
-		pr_debug("\tTest %d: %lu-%lu size %lu expected %lu (%lu-%lu)\n",
-			 i/5, req_range[i]   >> 12, req_range[i + 1]   >> 12,
-			 req_range[i + 2]   >> 12, req_range[i + 3]   >> 12,
-			 req_range[i], req_range[i+1]);
-#endif
-		check_mtree_alloc_range(mt,
-				req_range[i]   >> 12, /* start */
-				req_range[i+1] >> 12, /* end */
-				req_range[i+2] >> 12, /* size */
-				req_range[i+3] >> 12, /* expected address */
-				req_range[i+4],       /* expected return */
-				xa_mk_value(req_range[i] >> 12)); /* pointer */
-		mt_validate(mt);
-#if DEBUG_ALLOC_RANGE
-		mt_dump(mt, mt_dump_hex);
-#endif
-	}
-
-	mtree_destroy(mt);
-}
-#endif
-
 static noinline void __init check_ranges(struct maple_tree *mt)
 {
 	int i, val, val2;
@@ -3448,17 +3070,6 @@ static int __init maple_tree_seed(void)
 	check_ranges(&tree);
 	mtree_destroy(&tree);
 
-#if defined(CONFIG_64BIT)
-	/* These tests have ranges outside of 4GB */
-	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
-	check_alloc_range(&tree);
-	mtree_destroy(&tree);
-
-	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
-	check_alloc_rev_range(&tree);
-	mtree_destroy(&tree);
-#endif
-
 	mt_init_flags(&tree, 0);
 
 	check_load(&tree, set[0], NULL);       /* See if 5015 -> NULL */
-- 
2.20.1

