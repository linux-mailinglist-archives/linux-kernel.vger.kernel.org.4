Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649BC63B200
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiK1TQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiK1TQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:16:21 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12652A43D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:16:20 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x66so11464970pfx.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRCSr1pTz6K6wdPtBbAWa4aN3tG3lkr1IsdWKZqDSLk=;
        b=WoKsWj+sHsST19ykpbG8s6H7nLNX8l9Ihbsp9tL14ftWTCBngqRJg+gn0YDHv/rjK8
         hgZDRuD/gg565LJXVXniIA99E818HT9mgJZQikSvddb5OEwFnAjmm94BxhmVOmO6xIvU
         9tcYq+bkvSqCqN107imWGrtaFh04uX08ZiX42A3tzhiPaCZ9mS0FbS5gP5f892HmqNcY
         v2bl3f2akDqinOw48tYCPhH6hAtmkPsm7N1Mry8h578PeyoUQOQ+PSrxReKu3ntb8vZy
         pst3zCxazSvyT9K0K0rJqLxspplJnqlmLQlMWL2Ep9AIaqX3yQABAFvWutvvxif4T1dS
         S4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRCSr1pTz6K6wdPtBbAWa4aN3tG3lkr1IsdWKZqDSLk=;
        b=wjVRhaecfqNCrskT+Qy3vOBoxeZ9oeqC80v5q3dippl0SN/ngcXaq6nBKOL0+/2Rov
         U6GaXPm89M4/uyLQCkE1xm+MzTLuVJzPHH4rV/NKZTLbPgON0kf5bsy4s2t3lwEmnVVl
         dK0+7KwVdp7DzpFICnvmso0tQjKsoxoieMXgQYCUrG5pf48jOf3BtCTm/jLOlZlGzE1z
         y/AmqVqLtrpXt941fqtrm0qEJJ78mwSn9Ui3evmGkLoDZGA1c1GWYQwM+oz8TqMEVDHX
         LpiATlwW1sGdstzN1ieEgICZzeNIwUcNOi+FsEVmT0GHYI+zuLjVBqlsAE837f5wS36t
         TKUw==
X-Gm-Message-State: ANoB5pmBvRqKUDqi7YRodDsSegqyTeuTrpYbDpbSMzJmlIHYvh0Uo9S6
        WbOpG6nCnStdRVA4ZVZW7d0=
X-Google-Smtp-Source: AA0mqf5hOZ/K+3ZtiWIoCY26o6TpUDJpIMpCrclO5OctE+qfS6HBCgLy6d3vr/vid71JIAsPnrxFVQ==
X-Received: by 2002:a05:6a00:1303:b0:561:7dc7:510b with SMTP id j3-20020a056a00130300b005617dc7510bmr54913163pfu.3.1669662980087;
        Mon, 28 Nov 2022 11:16:20 -0800 (PST)
Received: from localhost (fwdproxy-prn-007.fbsv.net. [2a03:2880:ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090341c400b00183e2a96414sm9256090ple.121.2022.11.28.11.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 11:16:19 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v7 2/6] zpool: clean out dead code
Date:   Mon, 28 Nov 2022 11:16:11 -0800
Message-Id: <20221128191616.1261026-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221128191616.1261026-1-nphamcs@gmail.com>
References: <20221128191616.1261026-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Weiner <hannes@cmpxchg.org>

There is a lot of provision for flexibility that isn't actually needed
or used. Zswap (the only zpool user) always passes zpool_ops with an
.evict method set. The backends who reclaim only do so for zswap, so
they can also directly call zpool_ops without indirection or checks.

Finally, there is no need to check the retries parameters and bail
with -EINVAL in the reclaim function, when that's called just a few
lines below with a hard-coded 8. There is no need to duplicate the
evictable and sleep_mapped attrs from the driver in zpool_ops.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/z3fold.c | 36 +++++-------------------------------
 mm/zbud.c   | 32 +++++---------------------------
 mm/zpool.c  | 10 ++--------
 3 files changed, 12 insertions(+), 66 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index cf71da10d04e..a4de0c317ac7 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -68,9 +68,6 @@
  * Structures
 *****************/
 struct z3fold_pool;
-struct z3fold_ops {
-	int (*evict)(struct z3fold_pool *pool, unsigned long handle);
-};

 enum buddy {
 	HEADLESS = 0,
@@ -138,8 +135,6 @@ struct z3fold_header {
  * @stale:	list of pages marked for freeing
  * @pages_nr:	number of z3fold pages in the pool.
  * @c_handle:	cache for z3fold_buddy_slots allocation
- * @ops:	pointer to a structure of user defined operations specified at
- *		pool creation time.
  * @zpool:	zpool driver
  * @zpool_ops:	zpool operations structure with an evict callback
  * @compact_wq:	workqueue for page layout background optimization
@@ -158,7 +153,6 @@ struct z3fold_pool {
 	struct list_head stale;
 	atomic64_t pages_nr;
 	struct kmem_cache *c_handle;
-	const struct z3fold_ops *ops;
 	struct zpool *zpool;
 	const struct zpool_ops *zpool_ops;
 	struct workqueue_struct *compact_wq;
@@ -907,13 +901,11 @@ static inline struct z3fold_header *__z3fold_alloc(struct z3fold_pool *pool,
  * z3fold_create_pool() - create a new z3fold pool
  * @name:	pool name
  * @gfp:	gfp flags when allocating the z3fold pool structure
- * @ops:	user-defined operations for the z3fold pool
  *
  * Return: pointer to the new z3fold pool or NULL if the metadata allocation
  * failed.
  */
-static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
-		const struct z3fold_ops *ops)
+static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp)
 {
 	struct z3fold_pool *pool = NULL;
 	int i, cpu;
@@ -949,7 +941,6 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp,
 	if (!pool->release_wq)
 		goto out_wq;
 	INIT_WORK(&pool->work, free_pages_work);
-	pool->ops = ops;
 	return pool;

 out_wq:
@@ -1230,10 +1221,6 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 	slots.pool = (unsigned long)pool | (1 << HANDLES_NOFREE);

 	spin_lock(&pool->lock);
-	if (!pool->ops || !pool->ops->evict || retries == 0) {
-		spin_unlock(&pool->lock);
-		return -EINVAL;
-	}
 	for (i = 0; i < retries; i++) {
 		if (list_empty(&pool->lru)) {
 			spin_unlock(&pool->lock);
@@ -1319,17 +1306,17 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
 		}
 		/* Issue the eviction callback(s) */
 		if (middle_handle) {
-			ret = pool->ops->evict(pool, middle_handle);
+			ret = pool->zpool_ops->evict(pool->zpool, middle_handle);
 			if (ret)
 				goto next;
 		}
 		if (first_handle) {
-			ret = pool->ops->evict(pool, first_handle);
+			ret = pool->zpool_ops->evict(pool->zpool, first_handle);
 			if (ret)
 				goto next;
 		}
 		if (last_handle) {
-			ret = pool->ops->evict(pool, last_handle);
+			ret = pool->zpool_ops->evict(pool->zpool, last_handle);
 			if (ret)
 				goto next;
 		}
@@ -1593,26 +1580,13 @@ static const struct movable_operations z3fold_mops = {
  * zpool
  ****************/

-static int z3fold_zpool_evict(struct z3fold_pool *pool, unsigned long handle)
-{
-	if (pool->zpool && pool->zpool_ops && pool->zpool_ops->evict)
-		return pool->zpool_ops->evict(pool->zpool, handle);
-	else
-		return -ENOENT;
-}
-
-static const struct z3fold_ops z3fold_zpool_ops = {
-	.evict =	z3fold_zpool_evict
-};
-
 static void *z3fold_zpool_create(const char *name, gfp_t gfp,
 			       const struct zpool_ops *zpool_ops,
 			       struct zpool *zpool)
 {
 	struct z3fold_pool *pool;

-	pool = z3fold_create_pool(name, gfp,
-				zpool_ops ? &z3fold_zpool_ops : NULL);
+	pool = z3fold_create_pool(name, gfp);
 	if (pool) {
 		pool->zpool = zpool;
 		pool->zpool_ops = zpool_ops;
diff --git a/mm/zbud.c b/mm/zbud.c
index 6348932430b8..3acd26193920 100644
--- a/mm/zbud.c
+++ b/mm/zbud.c
@@ -74,10 +74,6 @@

 struct zbud_pool;

-struct zbud_ops {
-	int (*evict)(struct zbud_pool *pool, unsigned long handle);
-};
-
 /**
  * struct zbud_pool - stores metadata for each zbud pool
  * @lock:	protects all pool fields and first|last_chunk fields of any
@@ -90,8 +86,6 @@ struct zbud_ops {
  * @lru:	list tracking the zbud pages in LRU order by most recently
  *		added buddy.
  * @pages_nr:	number of zbud pages in the pool.
- * @ops:	pointer to a structure of user defined operations specified at
- *		pool creation time.
  * @zpool:	zpool driver
  * @zpool_ops:	zpool operations structure with an evict callback
  *
@@ -110,7 +104,6 @@ struct zbud_pool {
 	};
 	struct list_head lru;
 	u64 pages_nr;
-	const struct zbud_ops *ops;
 	struct zpool *zpool;
 	const struct zpool_ops *zpool_ops;
 };
@@ -212,12 +205,11 @@ static int num_free_chunks(struct zbud_header *zhdr)
 /**
  * zbud_create_pool() - create a new zbud pool
  * @gfp:	gfp flags when allocating the zbud pool structure
- * @ops:	user-defined operations for the zbud pool
  *
  * Return: pointer to the new zbud pool or NULL if the metadata allocation
  * failed.
  */
-static struct zbud_pool *zbud_create_pool(gfp_t gfp, const struct zbud_ops *ops)
+static struct zbud_pool *zbud_create_pool(gfp_t gfp)
 {
 	struct zbud_pool *pool;
 	int i;
@@ -231,7 +223,6 @@ static struct zbud_pool *zbud_create_pool(gfp_t gfp, const struct zbud_ops *ops)
 	INIT_LIST_HEAD(&pool->buddied);
 	INIT_LIST_HEAD(&pool->lru);
 	pool->pages_nr = 0;
-	pool->ops = ops;
 	return pool;
 }

@@ -419,8 +410,7 @@ static int zbud_reclaim_page(struct zbud_pool *pool, unsigned int retries)
 	unsigned long first_handle = 0, last_handle = 0;

 	spin_lock(&pool->lock);
-	if (!pool->ops || !pool->ops->evict || list_empty(&pool->lru) ||
-			retries == 0) {
+	if (list_empty(&pool->lru)) {
 		spin_unlock(&pool->lock);
 		return -EINVAL;
 	}
@@ -444,12 +434,12 @@ static int zbud_reclaim_page(struct zbud_pool *pool, unsigned int retries)

 		/* Issue the eviction callback(s) */
 		if (first_handle) {
-			ret = pool->ops->evict(pool, first_handle);
+			ret = pool->zpool_ops->evict(pool->zpool, first_handle);
 			if (ret)
 				goto next;
 		}
 		if (last_handle) {
-			ret = pool->ops->evict(pool, last_handle);
+			ret = pool->zpool_ops->evict(pool->zpool, last_handle);
 			if (ret)
 				goto next;
 		}
@@ -524,25 +514,13 @@ static u64 zbud_get_pool_size(struct zbud_pool *pool)
  * zpool
  ****************/

-static int zbud_zpool_evict(struct zbud_pool *pool, unsigned long handle)
-{
-	if (pool->zpool && pool->zpool_ops && pool->zpool_ops->evict)
-		return pool->zpool_ops->evict(pool->zpool, handle);
-	else
-		return -ENOENT;
-}
-
-static const struct zbud_ops zbud_zpool_ops = {
-	.evict =	zbud_zpool_evict
-};
-
 static void *zbud_zpool_create(const char *name, gfp_t gfp,
 			       const struct zpool_ops *zpool_ops,
 			       struct zpool *zpool)
 {
 	struct zbud_pool *pool;

-	pool = zbud_create_pool(gfp, zpool_ops ? &zbud_zpool_ops : NULL);
+	pool = zbud_create_pool(gfp);
 	if (pool) {
 		pool->zpool = zpool;
 		pool->zpool_ops = zpool_ops;
diff --git a/mm/zpool.c b/mm/zpool.c
index f46c0d5e766c..571f5c5031dd 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -21,9 +21,6 @@
 struct zpool {
 	struct zpool_driver *driver;
 	void *pool;
-	const struct zpool_ops *ops;
-	bool evictable;
-	bool can_sleep_mapped;
 };

 static LIST_HEAD(drivers_head);
@@ -177,9 +174,6 @@ struct zpool *zpool_create_pool(const char *type, const char *name, gfp_t gfp,

 	zpool->driver = driver;
 	zpool->pool = driver->create(name, gfp, ops, zpool);
-	zpool->ops = ops;
-	zpool->evictable = driver->shrink && ops && ops->evict;
-	zpool->can_sleep_mapped = driver->sleep_mapped;

 	if (!zpool->pool) {
 		pr_err("couldn't create %s pool\n", type);
@@ -380,7 +374,7 @@ u64 zpool_get_total_size(struct zpool *zpool)
  */
 bool zpool_evictable(struct zpool *zpool)
 {
-	return zpool->evictable;
+	return zpool->driver->shrink;
 }

 /**
@@ -398,7 +392,7 @@ bool zpool_evictable(struct zpool *zpool)
  */
 bool zpool_can_sleep_mapped(struct zpool *zpool)
 {
-	return zpool->can_sleep_mapped;
+	return zpool->driver->sleep_mapped;
 }

 MODULE_LICENSE("GPL");
--
2.30.2
