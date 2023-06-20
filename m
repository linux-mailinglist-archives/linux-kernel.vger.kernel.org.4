Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EBE737542
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 21:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjFTTqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 15:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFTTqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 15:46:49 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D5C10F4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:46:47 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b50e3096b0so40116255ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687290407; x=1689882407;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e8e/gV6Ny17QnNph6JSaPejJmkR8uPNsGl7TybykgrQ=;
        b=pap/Vep95TcKYRt7RN39zXtGOPI9M/9cgLzA0WC6HrCL1AGOnPAQmfSNG1LBsBxnmC
         s30PF/3nnx+kxDpbnWpMwhodxr5AzrIm3SmJnHmvB1GnrpL8Td9bPlciJBYwCD01kHis
         DF/Rug8W4scSK/7L2sp7Y61Z4I++fTBifJwp/t4M7PyD547PyCfuDWBhObbqboAhX1Cd
         mWLw8z4nVGdtTuOloJTlvAQK9Aoqj4t66jRvRk5qDsnlBhwZ34xpukJgAewBt9IWWyhB
         Zx9LyFDOkARWwxT2mMVTJgY+mELmMM3/jl5i01WCf2XkDwntZPhuWfATiStIjjVbWSiu
         P8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290407; x=1689882407;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e8e/gV6Ny17QnNph6JSaPejJmkR8uPNsGl7TybykgrQ=;
        b=iwgf8xYyjaLIRv0eBKvn6MEqYFc8uygHQihvMbr0TETZAzOX2oX6RO+JrQ+SScxJeF
         rJbYp0xcXWscM8WtdSvdvCx5C3ZPonpvg4WEsDNJKy7MpqySZqgBHzVw3xbB84TkevSl
         1BEj1t5DylCcBYTrJSRZ5jjALVz1UjyyyZBok9m2VT5kn6fmR0Zt+Lt7gk1W7Jac6lNH
         gBc8EIySBkUyKTu3raraoKh7TWanMCvbouZMRR/TpP54DlYfTk25o/gC3QyiU/GquFmE
         phtzHXlpO2wx6hRN6pMk8NBxQpHYdEtBAAjcZTNKMvV0xXsXU8JRGWgtg4Xc2Od9jF3q
         UWqA==
X-Gm-Message-State: AC+VfDxzwKjkmyuo0BErUnoDVFn828vB6zvbwexpUrFGuHR4CohFlNQ/
        DNYmyR6qqOh0fcgVlk6/ScB8iSmj/9QHIROg
X-Google-Smtp-Source: ACHHUZ6FoE0jd8KPaT8+WeSftXc3Jnt4nNdvn+DOWQIe3j15VPfVvB1QYOATlSumBWRjQ9fbEeWMvh2+NMkwRvjd
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:c109:b0:1b5:3912:5c13 with SMTP
 id 9-20020a170902c10900b001b539125c13mr1670157pli.1.1687290407453; Tue, 20
 Jun 2023 12:46:47 -0700 (PDT)
Date:   Tue, 20 Jun 2023 19:46:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230620194644.3142384-1-yosryahmed@google.com>
Subject: [PATCH v3] mm: zswap: multiple zpools support
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
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
purposes. A fixed number of 32 zpools is suggested by this commit, which
was determined empirically. It can be later changed or made into a
config option if needed.

On a setup with zswap and zsmalloc, comparing a single zpool to 32
zpools shows improvements in the zsmalloc lock contention, especially on
the swap out path.

The following shows the perf analysis of the swapout path when 10
workloads are simultaneously reclaiming and refaulting tmpfs pages.
There are some improvements on the swap in path as well, but less
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

v2 -> v3:
- Removed config option (Johannes Weiner). Now it's a constant.
- Fixed spelling typos (Yu Zhao).

v1 -> v2:
- Prettified perf graph in commit log.
- Changed zswap_nr_zpools to a macro, changed zswap_pool->zpools to a
  fixed size array instead of a flex array.
- Removed stale comment.

---
 mm/zswap.c | 81 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 27 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 87b204233115..6ee7028497b8 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -142,6 +142,9 @@ static bool zswap_exclusive_loads_enabled = IS_ENABLED(
 		CONFIG_ZSWAP_EXCLUSIVE_LOADS_DEFAULT_ON);
 module_param_named(exclusive_loads, zswap_exclusive_loads_enabled, bool, 0644);
 
+/* Number of zpools in zswap_pool (empirically determined for scalability) */
+#define ZSWAP_NR_ZPOOLS 32
+
 /*********************************
 * data structures
 **********************************/
@@ -161,7 +164,7 @@ struct crypto_acomp_ctx {
  * needs to be verified that it's still valid in the tree.
  */
 struct zswap_pool {
-	struct zpool *zpool;
+	struct zpool *zpools[ZSWAP_NR_ZPOOLS];
 	struct crypto_acomp_ctx __percpu *acomp_ctx;
 	struct kref kref;
 	struct list_head list;
@@ -248,7 +251,7 @@ static bool zswap_has_pool;
 
 #define zswap_pool_debug(msg, p)				\
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
-		 zpool_get_type((p)->zpool))
+		 zpool_get_type((p)->zpools[0]))
 
 static int zswap_writeback_entry(struct zswap_entry *entry,
 				 struct zswap_tree *tree);
@@ -272,11 +275,13 @@ static void zswap_update_total_size(void)
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
 
@@ -363,6 +368,16 @@ static void zswap_rb_erase(struct rb_root *root, struct zswap_entry *entry)
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
@@ -379,7 +394,7 @@ static void zswap_free_entry(struct zswap_entry *entry)
 		spin_lock(&entry->pool->lru_lock);
 		list_del(&entry->lru);
 		spin_unlock(&entry->pool->lru_lock);
-		zpool_free(entry->pool->zpool, entry->handle);
+		zpool_free(zswap_find_zpool(entry), entry->handle);
 		zswap_pool_put(entry->pool);
 	}
 	zswap_entry_cache_free(entry);
@@ -588,7 +603,8 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 	list_for_each_entry_rcu(pool, &zswap_pools, list) {
 		if (strcmp(pool->tfm_name, compressor))
 			continue;
-		if (strcmp(zpool_get_type(pool->zpool), type))
+		/* all zpools share the same type */
+		if (strcmp(zpool_get_type(pool->zpools[0]), type))
 			continue;
 		/* if we can't get it, it's about to be destroyed */
 		if (!zswap_pool_get(pool))
@@ -692,6 +708,7 @@ static void shrink_worker(struct work_struct *w)
 
 static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 {
+	int i;
 	struct zswap_pool *pool;
 	char name[38]; /* 'zswap' + 32 char (max) num + \0 */
 	gfp_t gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
@@ -712,15 +729,18 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	if (!pool)
 		return NULL;
 
-	/* unique name for each pool specifically required by zsmalloc */
-	snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_count));
+	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++) {
+		/* unique name for each pool specifically required by zsmalloc */
+		snprintf(name, 38, "zswap%x",
+			 atomic_inc_return(&zswap_pools_count));
 
-	pool->zpool = zpool_create_pool(type, name, gfp);
-	if (!pool->zpool) {
-		pr_err("%s zpool not available\n", type);
-		goto error;
+		pool->zpools[i] = zpool_create_pool(type, name, gfp);
+		if (!pool->zpools[i]) {
+			pr_err("%s zpool not available\n", type);
+			goto error;
+		}
 	}
-	pr_debug("using %s zpool\n", zpool_get_type(pool->zpool));
+	pr_debug("using %s zpool\n", zpool_get_type(pool->zpools[0]));
 
 	strscpy(pool->tfm_name, compressor, sizeof(pool->tfm_name));
 
@@ -752,8 +772,8 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
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
@@ -802,11 +822,14 @@ static struct zswap_pool *__zswap_pool_create_fallback(void)
 
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
 
@@ -1070,7 +1093,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	struct page *page;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
-	struct zpool *pool = entry->pool->zpool;
+	struct zpool *pool = zswap_find_zpool(entry);
 
 	u8 *src, *tmp = NULL;
 	unsigned int dlen;
@@ -1211,6 +1234,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct obj_cgroup *objcg = NULL;
 	struct zswap_pool *pool;
+	struct zpool *zpool;
 	int ret;
 	unsigned int dlen = PAGE_SIZE;
 	unsigned long handle, value;
@@ -1321,10 +1345,11 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	}
 
 	/* store */
+	zpool = zswap_find_zpool(entry);
 	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
-	if (zpool_malloc_support_movable(entry->pool->zpool))
+	if (zpool_malloc_support_movable(zpool))
 		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
-	ret = zpool_malloc(entry->pool->zpool, dlen, gfp, &handle);
+	ret = zpool_malloc(zpool, dlen, gfp, &handle);
 	if (ret == -ENOSPC) {
 		zswap_reject_compress_poor++;
 		goto put_dstmem;
@@ -1333,9 +1358,9 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 		zswap_reject_alloc_fail++;
 		goto put_dstmem;
 	}
-	buf = zpool_map_handle(entry->pool->zpool, handle, ZPOOL_MM_WO);
+	buf = zpool_map_handle(zpool, handle, ZPOOL_MM_WO);
 	memcpy(buf, dst, dlen);
-	zpool_unmap_handle(entry->pool->zpool, handle);
+	zpool_unmap_handle(zpool, handle);
 	mutex_unlock(acomp_ctx->mutex);
 
 	/* populate entry */
@@ -1406,6 +1431,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
 	u8 *src, *dst, *tmp;
+	struct zpool *zpool;
 	unsigned int dlen;
 	int ret;
 
@@ -1427,7 +1453,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 		goto stats;
 	}
 
-	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
+	zpool = zswap_find_zpool(entry);
+	if (!zpool_can_sleep_mapped(zpool)) {
 		tmp = kmalloc(entry->length, GFP_KERNEL);
 		if (!tmp) {
 			ret = -ENOMEM;
@@ -1437,12 +1464,12 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 
 	/* decompress */
 	dlen = PAGE_SIZE;
-	src = zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL_MM_RO);
+	src = zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
 
-	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
+	if (!zpool_can_sleep_mapped(zpool)) {
 		memcpy(tmp, src, entry->length);
 		src = tmp;
-		zpool_unmap_handle(entry->pool->zpool, entry->handle);
+		zpool_unmap_handle(zpool, entry->handle);
 	}
 
 	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
@@ -1454,8 +1481,8 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
 	mutex_unlock(acomp_ctx->mutex);
 
-	if (zpool_can_sleep_mapped(entry->pool->zpool))
-		zpool_unmap_handle(entry->pool->zpool, entry->handle);
+	if (zpool_can_sleep_mapped(zpool))
+		zpool_unmap_handle(zpool, entry->handle);
 	else
 		kfree(tmp);
 
@@ -1616,7 +1643,7 @@ static int zswap_setup(void)
 	pool = __zswap_pool_create_fallback();
 	if (pool) {
 		pr_info("loaded using pool %s/%s\n", pool->tfm_name,
-			zpool_get_type(pool->zpool));
+			zpool_get_type(pool->zpools[0]));
 		list_add(&pool->list, &zswap_pools);
 		zswap_has_pool = true;
 	} else {
-- 
2.41.0.162.gfafddb0af9-goog

