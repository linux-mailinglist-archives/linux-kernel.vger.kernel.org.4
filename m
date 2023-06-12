Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02B4E72BD25
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjFLJzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjFLJyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:54:03 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A530549E2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5147f7d045bso6128578a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686562707; x=1689154707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTNeAR1y7R/gjs/C8GIclCvhUGvklnuLgBw6XnZGDXw=;
        b=ir5X+fcVOPWPnflY9pVtwguKK2ey3SgZuOxuv2ZOkxFDqKz73VdIUv1QOgSTeQaljT
         UI/fWwyMUUy4mleSW3jXzJ74tzNZF19bZFTmt17x5Id0f13/bZBftEI56XJ++JOpA8ye
         ZGKSDaJf4MJPj+7yZpVhH9ltSaxKkJf+f19A5v0LJstxmdhz4VrtLOIGrPv8NCzqDVJU
         wsFfWr8DdsxgONEWJGL0Z8zcEj4XON7Uli+htyIuwZQoIxq09NT4savqJ8upjsIfZYZW
         0U2GJPSDw1W1+xKUHWicjr9kM+QlOmdT3nAsSC8E3BKBgSTA8qDe6gylqPzp8N6/Ddcv
         RdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562707; x=1689154707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTNeAR1y7R/gjs/C8GIclCvhUGvklnuLgBw6XnZGDXw=;
        b=BYuXMLozcRbffl3bATPGBRPBdFeLsMLx4A0Mp8dlvfb/DfIgFnEbfaBHFDklg/7tjb
         VyVlMHeLpi8DRPdOw+nZk1VDqdmssiuW8zeRYkGI/gn54BcE8CgrluToen1cqDevwvgK
         0AWh+smCvjGsayFwR79JpJGYlMDu+SKwxnQxkh/JQnaFru4tGfoGSG7eOdm+Luk+PPgK
         8rgcwc1qwUlPVXrPmMZGfNf25hRRCi3H2qhT1vJXwlutMNatLhGX9ljo5SGUmSPoxCZL
         WZn80PIy7FGHfe3WntqGIdTpIjHHiK04TzJgYu5qZv+t4dHnRBfomTgMhBdF3vksoy5i
         vI0w==
X-Gm-Message-State: AC+VfDzgtrmtXw+EivzFxHKnlEPdHSnrRT2+z2qj2qy3WnTCFIuYKULQ
        MEkEfbZuQKJRFtXGfKKWMds=
X-Google-Smtp-Source: ACHHUZ7yW28J5ffg2/9V/86Xlp2i9s2l/FUpHWl5+YPp3E42r82mnAA7eI63Vhw/XCRR6E3f1h1G6w==
X-Received: by 2002:a17:906:da87:b0:974:1c91:a752 with SMTP id xh7-20020a170906da8700b009741c91a752mr8922130ejb.5.1686562707002;
        Mon, 12 Jun 2023 02:38:27 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-212-171-43-8.retail.telecomitalia.it. [212.171.43.8])
        by smtp.gmail.com with ESMTPSA id ce23-20020a170906b25700b0097887b68c17sm4951358ejb.98.2023.06.12.02.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:38:26 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v3 5/7] mm: zswap: remove shrink from zpool interface
Date:   Mon, 12 Jun 2023 11:38:13 +0200
Message-Id: <20230612093815.133504-6-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612093815.133504-1-cerasuolodomenico@gmail.com>
References: <20230612093815.133504-1-cerasuolodomenico@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all three zswap backends have removed their shrink code, it is
no longer necessary for the zpool interface to include shrink/writeback
endpoints.

Acked-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 include/linux/zpool.h | 20 ++----------------
 mm/z3fold.c           |  4 +---
 mm/zbud.c             |  4 +---
 mm/zpool.c            | 48 ++-----------------------------------------
 mm/zsmalloc.c         |  4 +---
 mm/zswap.c            | 27 +++++++-----------------
 6 files changed, 14 insertions(+), 93 deletions(-)

diff --git a/include/linux/zpool.h b/include/linux/zpool.h
index e8997010612a..3296438eec06 100644
--- a/include/linux/zpool.h
+++ b/include/linux/zpool.h
@@ -14,10 +14,6 @@
 
 struct zpool;
 
-struct zpool_ops {
-	int (*evict)(struct zpool *pool, unsigned long handle);
-};
-
 /*
  * Control how a handle is mapped.  It will be ignored if the
  * implementation does not support it.  Its use is optional.
@@ -39,8 +35,7 @@ enum zpool_mapmode {
 
 bool zpool_has_pool(char *type);
 
-struct zpool *zpool_create_pool(const char *type, const char *name,
-			gfp_t gfp, const struct zpool_ops *ops);
+struct zpool *zpool_create_pool(const char *type, const char *name, gfp_t gfp);
 
 const char *zpool_get_type(struct zpool *pool);
 
@@ -53,9 +48,6 @@ int zpool_malloc(struct zpool *pool, size_t size, gfp_t gfp,
 
 void zpool_free(struct zpool *pool, unsigned long handle);
 
-int zpool_shrink(struct zpool *pool, unsigned int pages,
-			unsigned int *reclaimed);
-
 void *zpool_map_handle(struct zpool *pool, unsigned long handle,
 			enum zpool_mapmode mm);
 
@@ -72,7 +64,6 @@ u64 zpool_get_total_size(struct zpool *pool);
  * @destroy:	destroy a pool.
  * @malloc:	allocate mem from a pool.
  * @free:	free mem from a pool.
- * @shrink:	shrink the pool.
  * @sleep_mapped: whether zpool driver can sleep during map.
  * @map:	map a handle.
  * @unmap:	unmap a handle.
@@ -87,10 +78,7 @@ struct zpool_driver {
 	atomic_t refcount;
 	struct list_head list;
 
-	void *(*create)(const char *name,
-			gfp_t gfp,
-			const struct zpool_ops *ops,
-			struct zpool *zpool);
+	void *(*create)(const char *name, gfp_t gfp);
 	void (*destroy)(void *pool);
 
 	bool malloc_support_movable;
@@ -98,9 +86,6 @@ struct zpool_driver {
 				unsigned long *handle);
 	void (*free)(void *pool, unsigned long handle);
 
-	int (*shrink)(void *pool, unsigned int pages,
-				unsigned int *reclaimed);
-
 	bool sleep_mapped;
 	void *(*map)(void *pool, unsigned long handle,
 				enum zpool_mapmode mm);
@@ -113,7 +98,6 @@ void zpool_register_driver(struct zpool_driver *driver);
 
 int zpool_unregister_driver(struct zpool_driver *driver);
 
-bool zpool_evictable(struct zpool *pool);
 bool zpool_can_sleep_mapped(struct zpool *pool);
 
 #endif
diff --git a/mm/z3fold.c b/mm/z3fold.c
index 238a214de59f..e84de91ecccb 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -1364,9 +1364,7 @@ static const struct movable_operations z3fold_mops = {
  * zpool
  ****************/
 
-static void *z3fold_zpool_create(const char *name, gfp_t gfp,
-			       const struct zpool_ops *zpool_ops,
-			       struct zpool *zpool)
+static void *z3fold_zpool_create(const char *name, gfp_t gfp)
 {
 	return z3fold_create_pool(name, gfp);
 }
diff --git a/mm/zbud.c b/mm/zbud.c
index 9d35fd4091ed..2190cc1f37b3 100644
--- a/mm/zbud.c
+++ b/mm/zbud.c
@@ -380,9 +380,7 @@ static u64 zbud_get_pool_size(struct zbud_pool *pool)
  * zpool
  ****************/
 
-static void *zbud_zpool_create(const char *name, gfp_t gfp,
-			       const struct zpool_ops *zpool_ops,
-			       struct zpool *zpool)
+static void *zbud_zpool_create(const char *name, gfp_t gfp)
 {
 	return zbud_create_pool(gfp);
 }
diff --git a/mm/zpool.c b/mm/zpool.c
index 6a19c4a58f77..846410479c2f 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -133,7 +133,6 @@ EXPORT_SYMBOL(zpool_has_pool);
  * @type:	The type of the zpool to create (e.g. zbud, zsmalloc)
  * @name:	The name of the zpool (e.g. zram0, zswap)
  * @gfp:	The GFP flags to use when allocating the pool.
- * @ops:	The optional ops callback.
  *
  * This creates a new zpool of the specified type.  The gfp flags will be
  * used when allocating memory, if the implementation supports it.  If the
@@ -145,8 +144,7 @@ EXPORT_SYMBOL(zpool_has_pool);
  *
  * Returns: New zpool on success, NULL on failure.
  */
-struct zpool *zpool_create_pool(const char *type, const char *name, gfp_t gfp,
-		const struct zpool_ops *ops)
+struct zpool *zpool_create_pool(const char *type, const char *name, gfp_t gfp)
 {
 	struct zpool_driver *driver;
 	struct zpool *zpool;
@@ -173,7 +171,7 @@ struct zpool *zpool_create_pool(const char *type, const char *name, gfp_t gfp,
 	}
 
 	zpool->driver = driver;
-	zpool->pool = driver->create(name, gfp, ops, zpool);
+	zpool->pool = driver->create(name, gfp);
 
 	if (!zpool->pool) {
 		pr_err("couldn't create %s pool\n", type);
@@ -279,30 +277,6 @@ void zpool_free(struct zpool *zpool, unsigned long handle)
 	zpool->driver->free(zpool->pool, handle);
 }
 
-/**
- * zpool_shrink() - Shrink the pool size
- * @zpool:	The zpool to shrink.
- * @pages:	The number of pages to shrink the pool.
- * @reclaimed:	The number of pages successfully evicted.
- *
- * This attempts to shrink the actual memory size of the pool
- * by evicting currently used handle(s).  If the pool was
- * created with no zpool_ops, or the evict call fails for any
- * of the handles, this will fail.  If non-NULL, the @reclaimed
- * parameter will be set to the number of pages reclaimed,
- * which may be more than the number of pages requested.
- *
- * Implementations must guarantee this to be thread-safe.
- *
- * Returns: 0 on success, negative value on error/failure.
- */
-int zpool_shrink(struct zpool *zpool, unsigned int pages,
-			unsigned int *reclaimed)
-{
-	return zpool->driver->shrink ?
-	       zpool->driver->shrink(zpool->pool, pages, reclaimed) : -EINVAL;
-}
-
 /**
  * zpool_map_handle() - Map a previously allocated handle into memory
  * @zpool:	The zpool that the handle was allocated from
@@ -359,24 +333,6 @@ u64 zpool_get_total_size(struct zpool *zpool)
 	return zpool->driver->total_size(zpool->pool);
 }
 
-/**
- * zpool_evictable() - Test if zpool is potentially evictable
- * @zpool:	The zpool to test
- *
- * Zpool is only potentially evictable when it's created with struct
- * zpool_ops.evict and its driver implements struct zpool_driver.shrink.
- *
- * However, it doesn't necessarily mean driver will use zpool_ops.evict
- * in its implementation of zpool_driver.shrink. It could do internal
- * defragmentation instead.
- *
- * Returns: true if potentially evictable; false otherwise.
- */
-bool zpool_evictable(struct zpool *zpool)
-{
-	return zpool->driver->shrink;
-}
-
 /**
  * zpool_can_sleep_mapped - Test if zpool can sleep when do mapped.
  * @zpool:	The zpool to test
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index e4d1ad521738..3f057970504e 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -351,9 +351,7 @@ static void record_obj(unsigned long handle, unsigned long obj)
 
 #ifdef CONFIG_ZPOOL
 
-static void *zs_zpool_create(const char *name, gfp_t gfp,
-			     const struct zpool_ops *zpool_ops,
-			     struct zpool *zpool)
+static void *zs_zpool_create(const char *name, gfp_t gfp)
 {
 	/*
 	 * Ignore global gfp flags: zs_malloc() may be invoked from
diff --git a/mm/zswap.c b/mm/zswap.c
index 0024ec5ed574..a4f8c20e161b 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -258,10 +258,6 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle);
 static int zswap_pool_get(struct zswap_pool *pool);
 static void zswap_pool_put(struct zswap_pool *pool);
 
-static const struct zpool_ops zswap_zpool_ops = {
-	.evict = zswap_writeback_entry
-};
-
 static bool zswap_is_full(void)
 {
 	return totalram_pages() * zswap_max_pool_percent / 100 <
@@ -379,12 +375,9 @@ static void zswap_free_entry(struct zswap_entry *entry)
 	if (!entry->length)
 		atomic_dec(&zswap_same_filled_pages);
 	else {
-		/* zpool_evictable will be removed once all 3 backends have migrated */
-		if (!zpool_evictable(entry->pool->zpool)) {
-			spin_lock(&entry->pool->lru_lock);
-			list_del(&entry->lru);
-			spin_unlock(&entry->pool->lru_lock);
-		}
+		spin_lock(&entry->pool->lru_lock);
+		list_del(&entry->lru);
+		spin_unlock(&entry->pool->lru_lock);
 		zpool_free(entry->pool->zpool, entry->handle);
 		zswap_pool_put(entry->pool);
 	}
@@ -665,12 +658,8 @@ static void shrink_worker(struct work_struct *w)
 						shrink_work);
 	int ret, failures = 0;
 
-	/* zpool_evictable will be removed once all 3 backends have migrated */
 	do {
-		if (zpool_evictable(pool->zpool))
-			ret = zpool_shrink(pool->zpool, 1, NULL);
-		else
-			ret = zswap_reclaim_entry(pool);
+		ret = zswap_reclaim_entry(pool);
 		if (ret) {
 			zswap_reject_reclaim_fail++;
 			if (ret != -EAGAIN)
@@ -708,7 +697,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	/* unique name for each pool specifically required by zsmalloc */
 	snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_count));
 
-	pool->zpool = zpool_create_pool(type, name, gfp, &zswap_zpool_ops);
+	pool->zpool = zpool_create_pool(type, name, gfp);
 	if (!pool->zpool) {
 		pr_err("%s zpool not available\n", type);
 		goto error;
@@ -1394,8 +1383,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 			zswap_entry_put(tree, dupentry);
 		}
 	} while (ret == -EEXIST);
-	/* zpool_evictable will be removed once all 3 backends have migrated */
-	if (entry->length && !zpool_evictable(entry->pool->zpool)) {
+	if (entry->length) {
 		spin_lock(&entry->pool->lru_lock);
 		list_add(&entry->lru, &entry->pool->lru);
 		spin_unlock(&entry->pool->lru_lock);
@@ -1514,8 +1502,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	if (!ret && zswap_exclusive_loads_enabled) {
 		zswap_invalidate_entry(tree, entry);
 		*exclusive = true;
-	} else if (entry->length && !zpool_evictable(entry->pool->zpool)) {
-		/* zpool_evictable will be removed once all 3 backends have migrated */
+	} else if (entry->length) {
 		spin_lock(&entry->pool->lru_lock);
 		list_move(&entry->lru, &entry->pool->lru);
 		spin_unlock(&entry->pool->lru_lock);
-- 
2.34.1

