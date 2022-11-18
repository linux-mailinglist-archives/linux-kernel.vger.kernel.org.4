Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E86662ED59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 06:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbiKRFwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 00:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRFwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:52:04 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E3297AA4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 21:52:02 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id h24so2551529qta.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 21:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hB/0dgzyU4NYEF49HS/unqfJFv7OHK+uChX7FtR2Ow=;
        b=JKH1eR15UvYhVWjBvHOXtlR2KqCoK0/rabxnle6hD3+EOeS2cCvP7/W/mruCBurYKQ
         w7l9Xu2HRyqvbHVtzpKM75gjWo6tue3zxmt68fCXNDbyb8GDYwZ2TGcasCQGnBk9OPHu
         d/rl3ORk3k0xi9PjpfAjNxwQUPzXa1nG1I7uuJY9PMFqIb5zDfx+QVRiNgts+phfS7FG
         eTv+WtXVO+tCi9toMcLP1WJtQDtDaNK9xj9RWWyV2JlKFZZAUiMl5vxNTp4n5/+wnhQl
         06sgtdNADn2oEWSvdN2q6+Es3mavgAeP992O6RjSYPpAX3lQWxEMCpQqk9GjKm/+3dXR
         2D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hB/0dgzyU4NYEF49HS/unqfJFv7OHK+uChX7FtR2Ow=;
        b=1DsqsT5eM+1GaLlwaW1eCY0nMg7nEnGeKMq55iERQLQy6zQhdp7p8MwwdI8VpSUSTp
         vj3aOwPaOinQYFwTwczo/HHjAO0UKFN0kpo0kGLg+P2aAOZaiKC50idb+F0IbaXaEcDD
         ZpM0uZo1+NJCrXGSTdSHeoeIVVIeImM7yZKSm08JNwRTgmVwp2g9uv6bakgqBVtftnzm
         x70cZCtxWfe1DiJPme4VP+1R21C3RsfBlquGeNpn+dljVR6nchKhjw3zjl8Zx8NZqWYp
         sxwzsQ08WwG9YhUEiPtfRE67D+ztZNfzfTU0vLNJnBuoZENGHu05oXKeOCCJ34WI38QY
         t1RA==
X-Gm-Message-State: ANoB5pkPQp5YH0pEKhetcX1VvK1Fy9zlByVQaa8il31m05Bd0u9UlL2D
        O8DFKGbiqdFg7gUnjXJMnx8ohw==
X-Google-Smtp-Source: AA0mqf5rpscGQ/uzptObFfz+HfMJFi2mObRpKxYWfZhnSu5vQFKoGYNyjVYhFGTDxsjHF9P5A96+gQ==
X-Received: by 2002:ac8:514b:0:b0:35d:5a2e:72f with SMTP id h11-20020ac8514b000000b0035d5a2e072fmr5352074qtn.324.1668750722057;
        Thu, 17 Nov 2022 21:52:02 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id t4-20020ac87384000000b0039cba52974fsm1518095qtp.94.2022.11.17.21.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:52:01 -0800 (PST)
Date:   Fri, 18 Nov 2022 00:52:25 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v4 4/5] zsmalloc: Add ops fields to zs_pool to store
 evict handlers
Message-ID: <Y3cdmX7QNd38GBHt@cmpxchg.org>
References: <20221117163839.230900-1-nphamcs@gmail.com>
 <20221117163839.230900-5-nphamcs@gmail.com>
 <Y3a08ElhlyLN+0rG@google.com>
 <Y3cU4eAsQWo4bzsh@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3cU4eAsQWo4bzsh@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 12:15:15AM -0500, Johannes Weiner wrote:
> @@ -22,8 +22,6 @@ struct zpool {
>  	struct zpool_driver *driver;
>  	void *pool;
>  	const struct zpool_ops *ops;
> -	bool evictable;
> -	bool can_sleep_mapped;
>  };

Oops, forgot to remove ops, which is unused too.

---

From 408c8b9caafa960da703762d9aaec09a6575b207 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 17 Nov 2022 23:49:30 -0500
Subject: [PATCH] zpool: clean out dead code

There is a lot of provision for flexibility that isn't actually needed
or used. Zswap (the only zpool user) always passes zpool_ops with an
.evict method set. The backends who reclaim only do so for zswap, so
they can also directly call zpool_ops without indirection or checks.

Finally, there is no need to check the retries parameters and bail
with -EINVAL in the reclaim function, when that's called just a few
lines below with a hard-coded 8. There is no need to duplicate the
evictable and sleep_mapped attrs from the driver in zpool_ops.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
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
index 68facc193496..fc3a9893e107 100644
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
@@ -391,7 +385,7 @@ bool zpool_evictable(struct zpool *zpool)
  */
 bool zpool_can_sleep_mapped(struct zpool *zpool)
 {
-	return zpool->can_sleep_mapped;
+	return zpool->driver->sleep_mapped;
 }
 
 MODULE_LICENSE("GPL");
-- 
2.38.1

