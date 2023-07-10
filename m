Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDD874CA8E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjGJDaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGJD3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:29:32 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78D830C4
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 20:27:34 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666ecf9a081so3485330b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 20:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688959654; x=1691551654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z+IV/3EU3GY4vUZv6vrcuErb2vDPlc1Isf1U0nOs3EE=;
        b=T0DkrsabQei0/XIIO4dbC8R+HefLxd2T0hbWqqISpHzkWcVXf6rFLJrihNvSzxwoNL
         y8OL10sicociCQXP4eGVvGHpBvzWf65vEDtKQj3iZGoYIDjHp3D7icwIwk6uh5TVF9F9
         qi8v3BrfFvlhUy+vOtLb+Be9OYoyaDDnED8Ubl5i7m90FFpvOTcnRTjV6z5YSV25ZiyT
         XlRSrV7GmtV1YHpef7qd0LaiCRZqJ2nBX0RlP1brg+K7Y3BiMkpbC11kgdQTJhDXEekN
         jvx1AaHdQnL3/hwtGFEeqR2pvIy5CiITrk6Xbn2DGXkORVJJF0SdbhWRoZfTKBesUNRY
         W6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688959654; x=1691551654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+IV/3EU3GY4vUZv6vrcuErb2vDPlc1Isf1U0nOs3EE=;
        b=KH2nMn4wdABismua/uHItNFoYW4mKoFSuWCUP+CYnDmFPsQNZcoBw8z/RtapEki2w1
         yo1DHoJpcLcl4B/p6MKEihC++WiB4lWnWvPCe6mwlIgTjeI4FHksI6v73QRDIGqauPtQ
         /MTezUJD43ilUh32h4HPYkY+wRj6UVO7ws4easBYzzG4UpD1PM9yVIVNFdinNzvGGxYI
         siEVLGgb+xgMViftTV6wQJ0W4UJWFk1+UOM393L08JDhHvRb52B9dT4aWRbJmacFVw0O
         i6wCurgACnp9IMVXtqLE3pFF9mIiL7gk3v63AZhB2x1JR1N30JgJYSYL2FWbRsYNV9Yc
         9TzQ==
X-Gm-Message-State: ABy/qLb/uv3hRznZjmol65y/JiybFYiIxCFkgvwdHzAHL8OrsW1UavA1
        a86CcV0awOv6W3uYPW+Ci4ejfw==
X-Google-Smtp-Source: APBJJlHK/NBb4uu/gdhAvc3gFctQlQEEpQnHzVEJ2KN/gCiA6SP14wS++9kHd3JIOelROmaBKGrQnA==
X-Received: by 2002:a05:6a00:1704:b0:682:2fea:39f0 with SMTP id h4-20020a056a00170400b006822fea39f0mr13853334pfc.5.1688959653872;
        Sun, 09 Jul 2023 20:27:33 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7800f000000b00682c864f35bsm6279748pfi.140.2023.07.09.20.27.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 09 Jul 2023 20:27:33 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH] mm: kfence: allocate kfence_metadata at runtime
Date:   Mon, 10 Jul 2023 11:27:14 +0800
Message-Id: <20230710032714.26200-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfence_metadata is currently a static array. For the purpose of
allocating scalable __kfence_pool, we first change it to runtime
allocation of metadata. Since the size of an object of kfence_metadata
is 1160 bytes, we can save at least 72 pages (with default 256 objects)
without enabling kfence.

Below is the numbers obtained in qemu (with default 256 objects).
before: Memory: 8134692K/8388080K available (3668K bss)
after: Memory: 8136740K/8388080K available (1620K bss)
More than expected, it saves 2MB memory.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 mm/kfence/core.c   | 102 ++++++++++++++++++++++++++++++++-------------
 mm/kfence/kfence.h |   5 ++-
 2 files changed, 78 insertions(+), 29 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index dad3c0eb70a0..b9fec1c46e3d 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -116,7 +116,7 @@ EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
  * backing pages (in __kfence_pool).
  */
 static_assert(CONFIG_KFENCE_NUM_OBJECTS > 0);
-struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
+struct kfence_metadata *kfence_metadata;
 
 /* Freelist with available objects. */
 static struct list_head kfence_freelist = LIST_HEAD_INIT(kfence_freelist);
@@ -643,13 +643,56 @@ static unsigned long kfence_init_pool(void)
 	return addr;
 }
 
+static int kfence_alloc_metadata(void)
+{
+	unsigned long nr_pages = KFENCE_METADATA_SIZE / PAGE_SIZE;
+
+#ifdef CONFIG_CONTIG_ALLOC
+	struct page *pages;
+
+	pages = alloc_contig_pages(nr_pages, GFP_KERNEL, first_online_node,
+				   NULL);
+	if (pages)
+		kfence_metadata = page_to_virt(pages);
+#else
+	if (nr_pages > MAX_ORDER_NR_PAGES) {
+		pr_warn("KFENCE_NUM_OBJECTS too large for buddy allocator\n");
+		return -EINVAL;
+	}
+	kfence_metadata = alloc_pages_exact(KFENCE_METADATA_SIZE,
+					    GFP_KERNEL);
+#endif
+
+	if (!kfence_metadata)
+		return -ENOMEM;
+
+	memset(kfence_metadata, 0, KFENCE_METADATA_SIZE);
+	return 0;
+}
+
+static void kfence_free_metadata(void)
+{
+	if (WARN_ON(!kfence_metadata))
+		return;
+#ifdef CONFIG_CONTIG_ALLOC
+	free_contig_range(page_to_pfn(virt_to_page((void *)kfence_metadata)),
+			  KFENCE_METADATA_SIZE / PAGE_SIZE);
+#else
+	free_pages_exact((void *)kfence_metadata, KFENCE_METADATA_SIZE);
+#endif
+	kfence_metadata = NULL;
+}
+
 static bool __init kfence_init_pool_early(void)
 {
-	unsigned long addr;
+	unsigned long addr = (unsigned long)__kfence_pool;
 
 	if (!__kfence_pool)
 		return false;
 
+	if (!kfence_alloc_metadata())
+		goto free_pool;
+
 	addr = kfence_init_pool();
 
 	if (!addr) {
@@ -663,6 +706,7 @@ static bool __init kfence_init_pool_early(void)
 		return true;
 	}
 
+	kfence_free_metadata();
 	/*
 	 * Only release unprotected pages, and do not try to go back and change
 	 * page attributes due to risk of failing to do so as well. If changing
@@ -670,31 +714,12 @@ static bool __init kfence_init_pool_early(void)
 	 * fails for the first page, and therefore expect addr==__kfence_pool in
 	 * most failure cases.
 	 */
+free_pool:
 	memblock_free_late(__pa(addr), KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool));
 	__kfence_pool = NULL;
 	return false;
 }
 
-static bool kfence_init_pool_late(void)
-{
-	unsigned long addr, free_size;
-
-	addr = kfence_init_pool();
-
-	if (!addr)
-		return true;
-
-	/* Same as above. */
-	free_size = KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool);
-#ifdef CONFIG_CONTIG_ALLOC
-	free_contig_range(page_to_pfn(virt_to_page((void *)addr)), free_size / PAGE_SIZE);
-#else
-	free_pages_exact((void *)addr, free_size);
-#endif
-	__kfence_pool = NULL;
-	return false;
-}
-
 /* === DebugFS Interface ==================================================== */
 
 static int stats_show(struct seq_file *seq, void *v)
@@ -896,6 +921,10 @@ void __init kfence_init(void)
 static int kfence_init_late(void)
 {
 	const unsigned long nr_pages = KFENCE_POOL_SIZE / PAGE_SIZE;
+	unsigned long addr = (unsigned long)__kfence_pool;
+	unsigned long free_size = KFENCE_POOL_SIZE;
+	int ret;
+
 #ifdef CONFIG_CONTIG_ALLOC
 	struct page *pages;
 
@@ -913,15 +942,29 @@ static int kfence_init_late(void)
 		return -ENOMEM;
 #endif
 
-	if (!kfence_init_pool_late()) {
-		pr_err("%s failed\n", __func__);
-		return -EBUSY;
+	ret = kfence_alloc_metadata();
+	if (!ret)
+		goto free_pool;
+
+	addr = kfence_init_pool();
+	if (!addr) {
+		kfence_init_enable();
+		kfence_debugfs_init();
+		return 0;
 	}
 
-	kfence_init_enable();
-	kfence_debugfs_init();
+	pr_err("%s failed\n", __func__);
+	kfence_free_metadata();
+	free_size = KFENCE_POOL_SIZE - (addr - (unsigned long)__kfence_pool);
+	ret = -EBUSY;
 
-	return 0;
+free_pool:
+#ifdef CONFIG_CONTIG_ALLOC
+	free_contig_range(page_to_pfn(virt_to_page((void *)addr)), free_size / PAGE_SIZE);
+#else
+	free_pages_exact((void *)addr, free_size);
+#endif
+	return ret;
 }
 
 static int kfence_enable_late(void)
@@ -941,6 +984,9 @@ void kfence_shutdown_cache(struct kmem_cache *s)
 	struct kfence_metadata *meta;
 	int i;
 
+	if (!__kfence_pool)
+		return;
+
 	for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
 		bool in_use;
 
diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
index 392fb273e7bd..f46fbb03062b 100644
--- a/mm/kfence/kfence.h
+++ b/mm/kfence/kfence.h
@@ -102,7 +102,10 @@ struct kfence_metadata {
 #endif
 };
 
-extern struct kfence_metadata kfence_metadata[CONFIG_KFENCE_NUM_OBJECTS];
+#define KFENCE_METADATA_SIZE PAGE_ALIGN(sizeof(struct kfence_metadata) * \
+					CONFIG_KFENCE_NUM_OBJECTS)
+
+extern struct kfence_metadata *kfence_metadata;
 
 static inline struct kfence_metadata *addr_to_metadata(unsigned long addr)
 {
-- 
2.20.1

