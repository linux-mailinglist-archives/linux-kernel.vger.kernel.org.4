Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FAC72217E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjFEIzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjFEIyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:54:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ADBF4
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:54:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-973f8dbcc02so765517366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 01:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685955271; x=1688547271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEQ6QPB4mJhVwoMuepvYuRemR1X9+w0A2PDCNfia9oI=;
        b=BwOdiyaSZUHGVJGs/vjaFGq1KR8hK2/oGwJggh+ERhIKrheBPRdSrsSw1SR7vHSiY+
         w93Ajuzl5hnY0RLzrF4L0k43s5v0/3i1iUVXGxjLzjp+TkHZUUDAXDXKO+JaUlGKA+xb
         go7LP0UckICUvJRZH2VgL/hMxgKro3pF9g07ylLXavvz+JCU32gYJQgLDZQWom0ieelm
         i5Zr4v6Cc9DEZBnuHIDfMZrBRZBnA5CA0DLQDhAAhodg6A7y++wAdZSo6/r23nucx6uO
         JkGM+kEN+Qg3dhs6zuuL/VZed4mNeRN8x9gRzs668XeJmS3CobO6OngIC4DNBUHQFxi3
         nlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685955271; x=1688547271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEQ6QPB4mJhVwoMuepvYuRemR1X9+w0A2PDCNfia9oI=;
        b=L8QYxEC+/3oKGguXHqCYVtk5XKV7sKYxSIHC5DEpTZ6Jj1m4C9pI3mHAYgAn5ilrYv
         PJ9UvAVYOKDIoyDFm74xR0RkdQnVnppmNhuHP8dOjgRFEP+l2LrDIUHTPRMZQE4Tw0pH
         +j/w4biWyWiYiKyennJbHJuUhCB4KgB+kd8N9UQO0tkP0rDdBjo3fb3lO8YP1mVYTUV6
         p2QWswPPJq3xmKNnK6qWCaQqoNTQOOc2UnuPiDsUTqSG+5U/ujEzbWCB6XrdCONNdXsc
         GrBR/UeetqQAGhw1Oe0DeVrEnIZ0sX9UN01kLNxJ1bwfEG+2X0gkZsv8hpWNXo5JMspA
         Pf4A==
X-Gm-Message-State: AC+VfDyjDOEHWVum3HxFcSiZVWpHytSd/aD+bvMh69uYurrmEyU+AiIM
        9mc/32keypjBHkXHWjuhjfA=
X-Google-Smtp-Source: ACHHUZ5oDlqriXz/R+RJVsZA//qjle82GxeK6rf7sZMXIbC9Oq3G/dbVBeKcJEO9+dlCy9QbCyqbGQ==
X-Received: by 2002:a17:907:268c:b0:974:76:dcdd with SMTP id bn12-20020a170907268c00b009740076dcddmr6165926ejc.55.1685955270926;
        Mon, 05 Jun 2023 01:54:30 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-82-53-8-153.retail.telecomitalia.it. [82.53.8.153])
        by smtp.gmail.com with ESMTPSA id lx5-20020a170906af0500b00965c6c63ea3sm4048915ejb.35.2023.06.05.01.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 01:54:30 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [RFC PATCH 5/7] mm: zswap: remove shrink from zpool interface
Date:   Mon,  5 Jun 2023 10:54:17 +0200
Message-Id: <20230605085419.44383-6-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605085419.44383-1-cerasuolodomenico@gmail.com>
References: <20230605085419.44383-1-cerasuolodomenico@gmail.com>
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

Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 include/linux/zpool.h | 19 ++---------------
 mm/z3fold.c           |  5 +----
 mm/zbud.c             |  5 +----
 mm/zpool.c            | 48 ++-----------------------------------------
 mm/zsmalloc.c         |  5 +----
 mm/zswap.c            | 18 ++++------------
 6 files changed, 11 insertions(+), 89 deletions(-)

diff --git a/include/linux/zpool.h b/include/linux/zpool.h
index e8997010612a..6b15a4213de5 100644
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
@@ -40,7 +36,7 @@ enum zpool_mapmode {
 bool zpool_has_pool(char *type);
 
 struct zpool *zpool_create_pool(const char *type, const char *name,
-			gfp_t gfp, const struct zpool_ops *ops);
+			gfp_t gfp);
 
 const char *zpool_get_type(struct zpool *pool);
 
@@ -53,9 +49,6 @@ int zpool_malloc(struct zpool *pool, size_t size, gfp_t gfp,
 
 void zpool_free(struct zpool *pool, unsigned long handle);
 
-int zpool_shrink(struct zpool *pool, unsigned int pages,
-			unsigned int *reclaimed);
-
 void *zpool_map_handle(struct zpool *pool, unsigned long handle,
 			enum zpool_mapmode mm);
 
@@ -72,7 +65,6 @@ u64 zpool_get_total_size(struct zpool *pool);
  * @destroy:	destroy a pool.
  * @malloc:	allocate mem from a pool.
  * @free:	free mem from a pool.
- * @shrink:	shrink the pool.
  * @sleep_mapped: whether zpool driver can sleep during map.
  * @map:	map a handle.
  * @unmap:	unmap a handle.
@@ -87,10 +79,7 @@ struct zpool_driver {
 	atomic_t refcount;
 	struct list_head list;
 
-	void *(*create)(const char *name,
-			gfp_t gfp,
-			const struct zpool_ops *ops,
-			struct zpool *zpool);
+	void *(*create)(const char *name, gfp_t gfp);
 	void (*destroy)(void *pool);
 
 	bool malloc_support_movable;
@@ -98,9 +87,6 @@ struct zpool_driver {
 				unsigned long *handle);
 	void (*free)(void *pool, unsigned long handle);
 
-	int (*shrink)(void *pool, unsigned int pages,
-				unsigned int *reclaimed);
-
 	bool sleep_mapped;
 	void *(*map)(void *pool, unsigned long handle,
 				enum zpool_mapmode mm);
@@ -113,7 +99,6 @@ void zpool_register_driver(struct zpool_driver *driver);
 
 int zpool_unregister_driver(struct zpool_driver *driver);
 
-bool zpool_evictable(struct zpool *pool);
 bool zpool_can_sleep_mapped(struct zpool *pool);
 
 #endif
diff --git a/mm/z3fold.c b/mm/z3fold.c
index 4af8741553ac..e84de91ecccb 100644
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
@@ -1409,7 +1407,6 @@ static struct zpool_driver z3fold_zpool_driver = {
 	.destroy =	z3fold_zpool_destroy,
 	.malloc =	z3fold_zpool_malloc,
 	.free =		z3fold_zpool_free,
-	.shrink =	NULL,
 	.map =		z3fold_zpool_map,
 	.unmap =	z3fold_zpool_unmap,
 	.total_size =	z3fold_zpool_total_size,
diff --git a/mm/zbud.c b/mm/zbud.c
index 19bc662ef5e9..2190cc1f37b3 100644
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
@@ -425,7 +423,6 @@ static struct zpool_driver zbud_zpool_driver = {
 	.destroy =	zbud_zpool_destroy,
 	.malloc =	zbud_zpool_malloc,
 	.free =		zbud_zpool_free,
-	.shrink =	NULL,
 	.map =		zbud_zpool_map,
 	.unmap =	zbud_zpool_unmap,
 	.total_size =	zbud_zpool_total_size,
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
index c87a60514f21..316eb2784643 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -370,9 +370,7 @@ static void record_obj(unsigned long handle, unsigned long obj)
 
 #ifdef CONFIG_ZPOOL
 
-static void *zs_zpool_create(const char *name, gfp_t gfp,
-			     const struct zpool_ops *zpool_ops,
-			     struct zpool *zpool)
+static void *zs_zpool_create(const char *name, gfp_t gfp)
 {
 	/*
 	 * Ignore global gfp flags: zs_malloc() may be invoked from
@@ -439,7 +437,6 @@ static struct zpool_driver zs_zpool_driver = {
 	.malloc_support_movable = true,
 	.malloc =		  zs_zpool_malloc,
 	.free =			  zs_zpool_free,
-	.shrink =		  NULL,
 	.map =			  zs_zpool_map,
 	.unmap =		  zs_zpool_unmap,
 	.total_size =		  zs_zpool_total_size,
diff --git a/mm/zswap.c b/mm/zswap.c
index 80d7780bf066..f5fcb07a181d 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -248,10 +248,6 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle);
 static int zswap_pool_get(struct zswap_pool *pool);
 static void zswap_pool_put(struct zswap_pool *pool);
 
-static const struct zpool_ops zswap_zpool_ops = {
-	.evict = zswap_writeback_entry
-};
-
 static bool zswap_is_full(void)
 {
 	return totalram_pages() * zswap_max_pool_percent / 100 <
@@ -645,12 +641,8 @@ static void shrink_worker(struct work_struct *w)
 						shrink_work);
 	int ret, failures = 0;
 
-	/* zpool_evictable will be removed once all 3 backends have migrated*/
 	do {
-		if (zpool_evictable(pool->zpool))
-			ret = zpool_shrink(pool->zpool, 1, NULL);
-		else
-			ret = zswap_shrink(pool);
+		ret = zswap_shrink(pool);
 		if (ret) {
 			zswap_reject_reclaim_fail++;
 			if (ret != -EAGAIN)
@@ -688,7 +680,7 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	/* unique name for each pool specifically required by zsmalloc */
 	snprintf(name, 38, "zswap%x", atomic_inc_return(&zswap_pools_count));
 
-	pool->zpool = zpool_create_pool(type, name, gfp, &zswap_zpool_ops);
+	pool->zpool = zpool_create_pool(type, name, gfp);
 	if (!pool->zpool) {
 		pr_err("%s zpool not available\n", type);
 		goto error;
@@ -1375,8 +1367,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 		}
 	} while (ret == -EEXIST);
 	INIT_LIST_HEAD(&entry->lru);
-	/* zpool_evictable will be removed once all 3 backends have migrated*/
-	if (entry->length && !zpool_evictable(entry->pool->zpool)) {
+	if (entry->length) {
 		spin_lock(&entry->pool->lock);
 		list_add(&entry->lru, &entry->pool->lru);
 		spin_unlock(&entry->pool->lock);
@@ -1482,8 +1473,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 freeentry:
 	spin_lock(&tree->lock);
 	zswap_entry_put(tree, entry);
-	/* zpool_evictable will be removed once all 3 backends have migrated*/
-	if (entry->length && !zpool_evictable(entry->pool->zpool)) {
+	if (entry->length) {
 		spin_lock(&entry->pool->lock);
 		list_move(&entry->lru, &entry->pool->lru);
 		spin_unlock(&entry->pool->lock);
-- 
2.34.1

