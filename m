Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882EF718E32
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjEaWNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjEaWNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:13:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69896136
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:13:05 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-568fa455b8fso1338257b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685571184; x=1688163184;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kClKXqeloyxMMh0khV3cE8dt5meCCUKnXo8ic9kYom4=;
        b=1fgOTLhCQ5e7jtsYbkonKNGvZXxmQZfN5C55K/Pmgs+G61pQUqYPdk5S88MfnIyvJA
         XenGIHxXr33mreFCRdTtk0PgI9xaygqwb3nzq0GNXhkE11AJNXQ4Ck4NKhdstB5qc6GR
         vfo6ur8L3btuIbvO+sHdEXGWMf9kyxSY7+WXGv1492iyEmcP5HurXP5o99b16steJXzU
         l9wxDk/Vd8n07l9LB6iUunTnwy5O5giF7NjAS5zW9WtyqnaN8FeEnVFsWHwWL7bjDEnb
         za/I84M654g+EKLrBnZ9DOFY+gdj2h0ez5SN5QJxObAmJuOAYkTaN67mp9PMUIdLF0Z+
         TUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685571184; x=1688163184;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kClKXqeloyxMMh0khV3cE8dt5meCCUKnXo8ic9kYom4=;
        b=RhnRdhTTsjLSSXJGrRZ+KIAQAw6Cqn/zgT9Sh8pXmQNafbs7YuJRu6KAqy31PQBons
         uOLDzZq5brw4zOOXvAe36aD/E5uHa/bzszPEml9ijabsWgZUZhuXFdko2bdSEqvpZ52M
         bFRONACdTIT0eHXJwNxJjVWb6Ibm3etb8kbc4SdZ7CeNJ3HUSU1+RALqB/bb40zy6zSU
         R0O3XDGNQXOND3H0ehzsVSrOegO6+xjdSg5q76w/tdTj3EXm7v/5so6AeJghzzDVtsdq
         Ol1EMAL3TDJNahEIeJK/hEzbZxX3DOvTHduBM/f2sQ1kXQ2r2yUYgndjCX0URStpY2YU
         uVyg==
X-Gm-Message-State: AC+VfDwagJjI2u6Cc3GArPn6+ej42x81EknmM4H+QlsG585wAONS6hoF
        7ZJD9GebqzXsSD9FhVl+0ZaD48u3rUpl8ONL
X-Google-Smtp-Source: ACHHUZ7xoumgYYKOJIfY7rkh83Lq9DdBx2tq1q9MZLJkEf7CL6P1XeO1zkyO1qFbNTt+sJftod5pGvW8XBW1Y41Q
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:4307:0:b0:561:c10b:6eb8 with SMTP
 id q7-20020a814307000000b00561c10b6eb8mr4047952ywa.6.1685571184668; Wed, 31
 May 2023 15:13:04 -0700 (PDT)
Date:   Wed, 31 May 2023 22:13:01 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531221302.1664613-1-yosryahmed@google.com>
Subject: [PATCH v2] mm: zswap: multiple zpools support
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
There are some improvements on the swap in path as well, but much less
significant.

1 zpool:

 |--28.99%--zswap_frontswap_store
       |
       <snip>
       |
       |--8.98%--zpool_map_handle
       |     |
       |      --8.98%--zs_zpool_map
       |           |
       |            --8.95%--zs_map_object
       |                 |
       |                  --8.38%--_raw_spin_lock
       |                       |
       |                        --7.39%--queued_spin_lock_slowpath
       |
       |--8.82%--zpool_malloc
       |     |
       |      --8.82%--zs_zpool_malloc
       |           |
       |            --8.80%--zs_malloc
       |                 |
       |                 |--7.21%--_raw_spin_lock
       |                 |     |
       |                 |      --6.81%--queued_spin_lock_slowpath
       <snip>

32 zpools:

 |--16.73%--zswap_frontswap_store
       |
       <snip>
       |
       |--1.81%--zpool_malloc
       |     |
       |      --1.81%--zs_zpool_malloc
       |           |
       |            --1.79%--zs_malloc
       |                 |
       |                  --0.73%--obj_malloc
       |
       |--1.06%--zswap_update_total_size
       |
       |--0.59%--zpool_map_handle
       |     |
       |      --0.59%--zs_zpool_map
       |           |
       |            --0.57%--zs_map_object
       |                 |
       |                  --0.51%--_raw_spin_lock
       <snip>

Suggested-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

v1 -> v2:
- Prettified perf graph in commit log.
- Changed zswap_nr_zpools to a macro, changed zswap_pool->zpools to a
  fixed size array instead of a flex array.
- Removed stale comment.

---
 mm/Kconfig | 12 +++++++
 mm/zswap.c | 91 ++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 73 insertions(+), 30 deletions(-)

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
index fba80330afd1..cb47b9cfb603 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -137,6 +137,9 @@ static bool zswap_non_same_filled_pages_enabled = true;
 module_param_named(non_same_filled_pages_enabled, zswap_non_same_filled_pages_enabled,
 		   bool, 0644);
 
+/* Number of zpools in zswap_pool */
+#define ZSWAP_NR_ZPOOLS (1 << CONFIG_ZSWAP_NR_ZPOOLS_ORDER)
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
+	struct zpool *zpools[ZSWAP_NR_ZPOOLS];
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
+		for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
+			total += zpool_get_total_size(pool->zpools[i]);
 
 	rcu_read_unlock();
 
@@ -350,6 +355,16 @@ static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
 	}
 }
 
+static struct zpool *zswap_find_zpool(struct zswap_entry *entry)
+{
+	int i = 0;
+
+	if (ZSWAP_NR_ZPOOLS > 1)
+		i = hash_ptr(entry, ilog2(ZSWAP_NR_ZPOOLS));
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
+	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
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
@@ -615,15 +634,19 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	if (!pool)
 		return NULL;
 
-	/* unique name for each pool specifically required by zsmalloc */
-	snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_count));
+	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++) {
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
 
@@ -653,8 +676,8 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
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
@@ -703,11 +726,14 @@ static struct zswap_pool *__zswap_pool_create_fallback(void)
 
 static void zswap_pool_destroy(struct zswap_pool *pool)
 {
+	int i;
+
 	zswap_pool_debug("destroying", pool);
 
 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 	free_percpu(pool->acomp_ctx);
-	zpool_destroy_pool(pool->zpool);
+	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
+		zpool_destroy_pool(pool->zpools[i]);
 	kfree(pool);
 }
 
@@ -1160,6 +1186,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	unsigned long handle, value;
 	char *buf;
 	u8 *src, *dst;
+	struct zpool *zpool;
 	struct zswap_header zhdr = { .swpentry = swp_entry(type, offset) };
 	gfp_t gfp;
 
@@ -1259,11 +1286,13 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
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
@@ -1272,10 +1301,10 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
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
@@ -1353,6 +1382,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	u8 *src, *dst, *tmp;
 	unsigned int dlen;
 	int ret;
+	struct zpool *zpool;
 
 	/* find */
 	spin_lock(&tree->lock);
@@ -1372,7 +1402,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 		goto stats;
 	}
 
-	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
+	zpool = zswap_find_zpool(entry);
+	if (!zpool_can_sleep_mapped(zpool)) {
 		tmp = kmalloc(entry->length, GFP_KERNEL);
 		if (!tmp) {
 			ret = -ENOMEM;
@@ -1382,14 +1413,14 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 
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
@@ -1401,8 +1432,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
 	mutex_unlock(acomp_ctx->mutex);
 
-	if (zpool_can_sleep_mapped(entry->pool->zpool))
-		zpool_unmap_handle(entry->pool->zpool, entry->handle);
+	if (zpool_can_sleep_mapped(zpool))
+		zpool_unmap_handle(zpool, entry->handle);
 	else
 		kfree(tmp);
 
@@ -1558,7 +1589,7 @@ static int zswap_setup(void)
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

