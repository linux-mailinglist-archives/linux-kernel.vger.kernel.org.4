Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D687173B4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbjEaC3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjEaC3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:29:16 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB0010E
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:29:14 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53f8167fb04so1674258a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685500154; x=1688092154;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NLCnoAH9K+Yfi/zkaMaChy7XZkCAL+ulwn++IFQ0ycA=;
        b=Skvw/IPE1Dai/OfyyOgJu+s/qnN9tAZA7/26s0ZKCfMdEctNVmftoo6VR5cazgAacL
         nZ/Aj4MilfOqIOW1YnrPtssifA2POVV4W7HJmwBmAtt4vwY5E5RC411rKdaL0N8qOw2Y
         WBoxBfLKme1zsNCQbuCUx8xJGCuba3mcXifGMBpEAS/kpWu/4X6yjY0BXwDy7GWvSStW
         ean0nQRncz05JEDmXISE7bOYL+4OyPAGsjG2V8MpCmEE7xb/qXFYpLQl+ZeAMPOusCzl
         xapggP/gH2tfI7rix9tQI2GQgtP/D7rqN1z0UQrZtO5jTmAv5Ome9WBuxioav0LI5QTE
         np+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685500154; x=1688092154;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NLCnoAH9K+Yfi/zkaMaChy7XZkCAL+ulwn++IFQ0ycA=;
        b=ICRCb+c7pThFmt2ie2PaTMKWhn2oSosjTKeIC9t3/stLE1rNPxColSIKXZZTqjCBSJ
         k/lZZ2yQOQRHEXI3DXeNs0TULE5d42yVCFHDCfkjcCYcCwa4NIzosyfzA54Z8NiL1sKM
         Atz8PjQWjK/93qDousSg5mlCYPZVEvzasAyjEvS5Hk/7Y7hBxKEh9wEqTaOM0Sv0Lnrf
         upd5tpe3Noot904GE7R/3tUHoacF7jWwF9BauozxhO7v2guN4lqGx26PZDu8H3Eo+AGz
         DsFEJNjza9WDcD8wmbhYpz9Iyxu3ZS/6XGDsfo9/PUXgIKi299kKPzbL0cbf0Cn0pFNX
         Fplg==
X-Gm-Message-State: AC+VfDxHozKKCqrHAt/LiBz7aeoDq4vw8pkclcn/pFKw/Dm7t7qVL4Sf
        UZ2/GPKyIvSrHWzJPCmM7F0r6kqBpJaFOBsi
X-Google-Smtp-Source: ACHHUZ4cqahWDL+3x0PxnUjdPzlxOyxsXirBqq/ZpMkSPEN/FqqQ81N9g4pciXeQKXBnMGu7Y1HjBPr4Y/vs3v+N
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:685:0:b0:530:866e:c3c1 with SMTP id
 127-20020a630685000000b00530866ec3c1mr818453pgg.11.1685500154067; Tue, 30 May
 2023 19:29:14 -0700 (PDT)
Date:   Wed, 31 May 2023 02:29:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531022911.1168524-1-yosryahmed@google.com>
Subject: [PATCH] mm: zswap: multiple zpool support
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support using multiple zpools of the same type in zswap, for concurrency
purposes. Add CONFIG_ZSWAP_NR_ZPOOLS_ORDER to control the number of
zpools. The order is specific by the config rather than the absolute
number to guarantee a power of 2. This is useful so that we can use
deterministically link each entry to a zpool by hashing the zswap_entry
pointer.

On a setup with zswap and zsmalloc, comparing a single zpool (current
default) to 32 zpools (by setting CONFIG_ZSWAP_NR_ZPOOLS_ORDER=32) shows
improvements in the zsmalloc lock contention, especially on the swap out
path.

The following shows the perf analysis of the swapout path when 10
workloads are simulatenously reclaiming and refaulting tmpfs pages.
There are some improvements on the swapin path as well, but much less
significant.

1 zpool:

 |--28.99%--zswap_frontswap_store
       |     |
       <snip>
       |     |
       |     |--8.98%--zpool_map_handle
       |     |     |
       |     |      --8.98%--zs_zpool_map
       |     |           |
       |     |            --8.95%--zs_map_object
       |     |                 |
       |     |                  --8.38%--_raw_spin_lock
       |     |                       |
       |     |                        --7.39%--queued_spin_lock_slowpath
       |     |
       |     |--8.82%--zpool_malloc
       |     |     |
       |     |      --8.82%--zs_zpool_malloc
       |     |           |
       |     |            --8.80%--zs_malloc
       |     |                 |
       |     |                 |--7.21%--_raw_spin_lock
       |     |                 |     |
       |     |                 |      --6.81%--queued_spin_lock_slowpath
       <snip>

32 zpools:

 |--16.73%--zswap_frontswap_store
       |     |
       <snip>
       |     |
       |     |--1.81%--zpool_malloc
       |     |     |
       |     |      --1.81%--zs_zpool_malloc
       |     |           |
       |     |            --1.79%--zs_malloc
       |     |                 |
       |     |                  --0.73%--obj_malloc
       |     |
       |     |--1.06%--zswap_update_total_size
       |     |
       |     |--0.59%--zpool_map_handle
       |     |     |
       |     |      --0.59%--zs_zpool_map
       |     |           |
       |     |            --0.57%--zs_map_object
       |     |                 |
       |     |                  --0.51%--_raw_spin_lock
       <snip>

Suggested-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/Kconfig | 12 +++++++
 mm/zswap.c | 95 ++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 76 insertions(+), 31 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 92c30879bf67..de1da56d2c07 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -59,6 +59,18 @@ config ZSWAP_EXCLUSIVE_LOADS
 	  The cost is that if the page was never dirtied and needs to be
 	  swapped out again, it will be re-compressed.
 
+config ZSWAP_NR_ZPOOLS_ORDER
+	int "Number of zpools in zswap, as power of 2"
+	default 0
+	depends on ZSWAP
+	help
+	  This options determines the number of zpools to use for zswap, it
+	  will be 1 << CONFIG_ZSWAP_NR_ZPOOLS_ORDER.
+
+	  Having multiple zpools helps with concurrency and lock contention
+	  on the swap in and swap out paths, but uses a little bit of extra
+	  space.
+
 choice
 	prompt "Default compressor"
 	depends on ZSWAP
diff --git a/mm/zswap.c b/mm/zswap.c
index fba80330afd1..7111036f8aa5 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -137,6 +137,9 @@ static bool zswap_non_same_filled_pages_enabled = true;
 module_param_named(non_same_filled_pages_enabled, zswap_non_same_filled_pages_enabled,
 		   bool, 0644);
 
+/* Order of zpools for global pool when memcg is enabled */
+static unsigned int zswap_nr_zpools = 1 << CONFIG_ZSWAP_NR_ZPOOLS_ORDER;
+
 /*********************************
 * data structures
 **********************************/
@@ -150,7 +153,6 @@ struct crypto_acomp_ctx {
 };
 
 struct zswap_pool {
-	struct zpool *zpool;
 	struct crypto_acomp_ctx __percpu *acomp_ctx;
 	struct kref kref;
 	struct list_head list;
@@ -158,6 +160,7 @@ struct zswap_pool {
 	struct work_struct shrink_work;
 	struct hlist_node node;
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
+	struct zpool *zpools[];
 };
 
 /*
@@ -236,7 +239,7 @@ static bool zswap_has_pool;
 
 #define zswap_pool_debug(msg, p)				\
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
-		 zpool_get_type((p)->zpool))
+		 zpool_get_type((p)->zpools[0]))
 
 static int zswap_writeback_entry(struct zpool *pool, unsigned long handle);
 static int zswap_pool_get(struct zswap_pool *pool);
@@ -263,11 +266,13 @@ static void zswap_update_total_size(void)
 {
 	struct zswap_pool *pool;
 	u64 total = 0;
+	int i;
 
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(pool, &zswap_pools, list)
-		total += zpool_get_total_size(pool->zpool);
+		for (i = 0; i < zswap_nr_zpools; i++)
+			total += zpool_get_total_size(pool->zpools[i]);
 
 	rcu_read_unlock();
 
@@ -350,6 +355,16 @@ static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
 	}
 }
 
+static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
+{
+	int i;
+
+	i = zswap_nr_zpools == 1 ? 0 :
+	    hash_ptr(entry, ilog2(zswap_nr_zpools));
+
+	return entry->pool->zpools[i];
+}
+
 /*
  * Carries out the common pattern of freeing and entry's zpool allocation,
  * freeing the entry itself, and decrementing the number of stored pages.
@@ -363,7 +378,7 @@ static void zswap_free_entry(struct zswap_entry *entry)
 	if (!entry->length)
 		atomic_dec(&zswap_same_filled_pages);
 	else {
-		zpool_free(entry->pool->zpool, entry->handle);
+		zpool_free(zswap_find_zpool(entry), entry->handle);
 		zswap_pool_put(entry->pool);
 	}
 	zswap_entry_cache_free(entry);
@@ -572,7 +587,8 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 	list_for_each_entry_rcu(pool, &zswap_pools, list) {
 		if (strcmp(pool->tfm_name, compressor))
 			continue;
-		if (strcmp(zpool_get_type(pool->zpool), type))
+		/* all zpools share the same type */
+		if (strcmp(zpool_get_type(pool->zpools[0]), type))
 			continue;
 		/* if we can't get it, it's about to be destroyed */
 		if (!zswap_pool_get(pool))
@@ -587,14 +603,17 @@ static void shrink_worker(struct work_struct *w)
 {
 	struct zswap_pool *pool = container_of(w, typeof(*pool),
 						shrink_work);
+	int i;
 
-	if (zpool_shrink(pool->zpool, 1, NULL))
-		zswap_reject_reclaim_fail++;
+	for (i = 0; i < zswap_nr_zpools; i++)
+		if (zpool_shrink(pool->zpools[i], 1, NULL))
+			zswap_reject_reclaim_fail++;
 	zswap_pool_put(pool);
 }
 
 static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 {
+	int i;
 	struct zswap_pool *pool;
 	char name[38]; /* 'zswap' + 32 char (max) num + \0 */
 	gfp_t gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
@@ -611,19 +630,25 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 			return NULL;
 	}
 
-	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	pool = kzalloc(sizeof(*pool) +
+		       sizeof(pool->zpools[0]) * zswap_nr_zpools,
+		       GFP_KERNEL);
 	if (!pool)
 		return NULL;
 
-	/* unique name for each pool specifically required by zsmalloc */
-	snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_count));
+	for (i = 0; i < zswap_nr_zpools; i++) {
+		/* unique name for each pool specifically required by zsmalloc */
+		snprintf(name, 38, "zswap%x",
+			 atomic_inc_return(&zswap_pools_count));
 
-	pool->zpool = zpool_create_pool(type, name, gfp, &zswap_zpool_ops);
-	if (!pool->zpool) {
-		pr_err("%s zpool not available\n", type);
-		goto error;
+		pool->zpools[i] = zpool_create_pool(type, name, gfp,
+						    &zswap_zpool_ops);
+		if (!pool->zpools[i]) {
+			pr_err("%s zpool not available\n", type);
+			goto error;
+		}
 	}
-	pr_debug("using %s zpool\n", zpool_get_type(pool->zpool));
+	pr_debug("using %s zpool\n", zpool_get_type(pool->zpools[0]));
 
 	strscpy(pool->tfm_name, compressor, sizeof(pool->tfm_name));
 
@@ -653,8 +678,8 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 error:
 	if (pool->acomp_ctx)
 		free_percpu(pool->acomp_ctx);
-	if (pool->zpool)
-		zpool_destroy_pool(pool->zpool);
+	while (i--)
+		zpool_destroy_pool(pool->zpools[i]);
 	kfree(pool);
 	return NULL;
 }
@@ -703,11 +728,14 @@ static struct zswap_pool *__zswap_pool_create_fallback(void)
 
 static void zswap_pool_destroy(struct zswap_pool *pool)
 {
+	int i;
+
 	zswap_pool_debug("destroying", pool);
 
 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 	free_percpu(pool->acomp_ctx);
-	zpool_destroy_pool(pool->zpool);
+	for (i = 0; i < zswap_nr_zpools; i++)
+		zpool_destroy_pool(pool->zpools[i]);
 	kfree(pool);
 }
 
@@ -1160,6 +1188,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	unsigned long handle, value;
 	char *buf;
 	u8 *src, *dst;
+	struct zpool *zpool;
 	struct zswap_header zhdr = { .swpentry = swp_entry(type, offset) };
 	gfp_t gfp;
 
@@ -1259,11 +1288,13 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	}
 
 	/* store */
-	hlen = zpool_evictable(entry->pool->zpool) ? sizeof(zhdr) : 0;
+	zpool = zswap_find_zpool(entry);
+	hlen = zpool_evictable(zpool) ? sizeof(zhdr) : 0;
 	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
-	if (zpool_malloc_support_movable(entry->pool->zpool))
+	if (zpool_malloc_support_movable(zpool))
 		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
-	ret = zpool_malloc(entry->pool->zpool, hlen + dlen, gfp, &handle);
+	ret = zpool_malloc(zpool, hlen + dlen, gfp, &handle);
+
 	if (ret == -ENOSPC) {
 		zswap_reject_compress_poor++;
 		goto put_dstmem;
@@ -1272,10 +1303,10 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 		zswap_reject_alloc_fail++;
 		goto put_dstmem;
 	}
-	buf = zpool_map_handle(entry->pool->zpool, handle, ZPOOL_MM_WO);
+	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
 	memcpy(buf, &zhdr, hlen);
 	memcpy(buf + hlen, dst, dlen);
-	zpool_unmap_handle(entry->pool->zpool, handle);
+	zpool_unmap_handle(zpool, handle);
 	mutex_unlock(acomp_ctx->mutex);
 
 	/* populate entry */
@@ -1353,6 +1384,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	u8 *src, *dst, *tmp;
 	unsigned int dlen;
 	int ret;
+	struct zpool *zpool;
 
 	/* find */
 	spin_lock(&tree->lock);
@@ -1372,7 +1404,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 		goto stats;
 	}
 
-	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
+	zpool = zswap_find_zpool(entry);
+	if (!zpool_can_sleep_mapped(zpool)) {
 		tmp = kmalloc(entry->length, GFP_KERNEL);
 		if (!tmp) {
 			ret = -ENOMEM;
@@ -1382,14 +1415,14 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 
 	/* decompress */
 	dlen = PAGE_SIZE;
-	src = zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL_MM_RO);
-	if (zpool_evictable(entry->pool->zpool))
+	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
+	if (zpool_evictable(zpool))
 		src += sizeof(struct zswap_header);
 
-	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
+	if (!zpool_can_sleep_mapped(zpool)) {
 		memcpy(tmp, src, entry->length);
 		src = tmp;
-		zpool_unmap_handle(entry->pool->zpool, entry->handle);
+		zpool_unmap_handle(zpool, entry->handle);
 	}
 
 	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
@@ -1401,8 +1434,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
 	mutex_unlock(acomp_ctx->mutex);
 
-	if (zpool_can_sleep_mapped(entry->pool->zpool))
-		zpool_unmap_handle(entry->pool->zpool, entry->handle);
+	if (zpool_can_sleep_mapped(zpool))
+		zpool_unmap_handle(zpool, entry->handle);
 	else
 		kfree(tmp);
 
@@ -1558,7 +1591,7 @@ static int zswap_setup(void)
 	pool = __zswap_pool_create_fallback();
 	if (pool) {
 		pr_info("loaded using pool %s/%s\n", pool->tfm_name,
-			zpool_get_type(pool->zpool));
+			zpool_get_type(pool->zpools[0]));
 		list_add(&pool->list, &zswap_pools);
 		zswap_has_pool = true;
 	} else {
-- 
2.41.0.rc0.172.g3f132b7071-goog

