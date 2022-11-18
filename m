Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11B662ED19
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 06:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbiKRFO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 00:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbiKRFOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:14:54 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3037342C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 21:14:51 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id h7so2101263qvs.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 21:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cps+dr7Masaue6SEA1cOwam8E00KKDa11kpmkte+dvw=;
        b=CVfaYOTLnhq+C1vzAVjVijsMl5TkuAn8KHJRqRsjt9JShmfez1AlLLMt/5bxfJ4NFa
         FZUekTHQ5t/SwrXgj+ae4j54drfL9GA7JgsBIDd4TxgIoVtC/smQjZlIfksaBDwR5XoA
         bLQeoWjOx7Wh+6Gibnd3UwBu7MfyKUqICNRlsKVed6556jSzEE7CahaP/0V3DZBkoE+k
         rZnAvQl4vw0cWozhN/zS/kyCMOrQXm61KSUzI+mq/LpY8SDHCtOfrBpBbVF3InN1jjTi
         y8gMI0VeyAnucaiLpWTaBh0P31E9boMegd01QQCRpWQNQ6owUWz9kv5e8gSPHwdpcxoL
         aBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cps+dr7Masaue6SEA1cOwam8E00KKDa11kpmkte+dvw=;
        b=0fXqBSxPuxmzuDvlQTrKRR461bKua0/gv3ayCgvOU6dBMgAutnHAn7dkAuKVGk5ioV
         g2CqEFrCzsh6P0Doos/rMDrsLxs0CNILC3kYH/epgLqoq8zNlrW4pIbplE/pF6V0PLWp
         jYhpOEpWmbNvTtyJFkPrdyrl5m4GjydT2nyeTJyuZM/t9rBWxEDtJ4P9xc5T5NilOdEI
         pOknNTi117UDTQ10alXEPhbV7F0Vr5XwFK7Nr97lJ4jTrSni78JNxouUyCJtI892IiBc
         cbhx4LVpyB755oXLK9UAKR8fBy3KP3H9jV3M2UUtRn9opiGZJP/hqdQhN1/QKE0pUS0y
         2dZg==
X-Gm-Message-State: ANoB5pk/ee5K3l8oitjb/kzDQoj89PLTUBayjUbeY/bAM8KNUwddYAIY
        Zw9ysPQ2YnYLR7xo3pKGenjYjA==
X-Google-Smtp-Source: AA0mqf6dtwnzkegvPHBy8V3axztXGg1+iQT1gq4xPwbxXY9/sUveZngKtRWxiehoIlFNdzcwDilpYw==
X-Received: by 2002:a05:6214:162c:b0:4c6:92da:3c21 with SMTP id e12-20020a056214162c00b004c692da3c21mr1788161qvw.33.1668748490966;
        Thu, 17 Nov 2022 21:14:50 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bc4])
        by smtp.gmail.com with ESMTPSA id cn6-20020a05622a248600b003a4cda52c95sm1493120qtb.63.2022.11.17.21.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:14:50 -0800 (PST)
Date:   Fri, 18 Nov 2022 00:15:13 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v4 4/5] zsmalloc: Add ops fields to zs_pool to store
 evict handlers
Message-ID: <Y3cU4eAsQWo4bzsh@cmpxchg.org>
References: <20221117163839.230900-1-nphamcs@gmail.com>
 <20221117163839.230900-5-nphamcs@gmail.com>
 <Y3a08ElhlyLN+0rG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3a08ElhlyLN+0rG@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 02:25:52PM -0800, Minchan Kim wrote:
> On Thu, Nov 17, 2022 at 08:38:38AM -0800, Nhat Pham wrote:
> > This adds fields to zs_pool to store evict handlers for writeback,
> > analogous to the zbud allocator.
> > 
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  mm/zsmalloc.c | 35 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 34 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> > index 2557b55ec767..776d0e15a401 100644
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -225,6 +225,12 @@ struct link_free {
> >  	};
> >  };
> > 
> > +struct zs_pool;
> > +
> > +struct zs_ops {
> > +	int (*evict)(struct zs_pool *pool, unsigned long handle);
> > +};
> > +
> >  struct zs_pool {
> >  	const char *name;
> > 
> > @@ -242,6 +248,9 @@ struct zs_pool {
> >  #ifdef CONFIG_ZPOOL
> >  	/* List tracking the zspages in LRU order by most recently added object */
> >  	struct list_head lru;
> > +	const struct zs_ops *ops;
> > +	struct zpool *zpool;
> > +	const struct zpool_ops *zpool_ops;
> >  #endif
> > 
> >  #ifdef CONFIG_ZSMALLOC_STAT
> > @@ -385,6 +394,18 @@ static void record_obj(unsigned long handle, unsigned long obj)
> > 
> >  #ifdef CONFIG_ZPOOL
> > 
> > +static int zs_zpool_evict(struct zs_pool *pool, unsigned long handle)
> > +{
> > +	if (pool->zpool && pool->zpool_ops && pool->zpool_ops->evict)
> > +		return pool->zpool_ops->evict(pool->zpool, handle);
> > +	else
> > +		return -ENOENT;
> > +}
> > +
> > +static const struct zs_ops zs_zpool_ops = {
> > +	.evict =	zs_zpool_evict
> > +};
> > +
> >  static void *zs_zpool_create(const char *name, gfp_t gfp,
> >  			     const struct zpool_ops *zpool_ops,
> >  			     struct zpool *zpool)
> > @@ -394,7 +415,19 @@ static void *zs_zpool_create(const char *name, gfp_t gfp,
> >  	 * different contexts and its caller must provide a valid
> >  	 * gfp mask.
> >  	 */
> > -	return zs_create_pool(name);
> > +	struct zs_pool *pool = zs_create_pool(name);
> > +
> > +	if (pool) {
> > +		pool->zpool = zpool;
> > +		pool->zpool_ops = zpool_ops;
> > +
> > +		if (zpool_ops)
> 
> I lost. When do we have zpool_ops as NULL?

It actually can't be as of today, it's just the zpool API that
pretends it can be, and so zsmalloc follows it here.

Actually, this is pretty trivial to clean up across zpool and the
drivers. How about the below patch? Nhat, would you mind picking that
up into your series? It should be easy to update 4/5 in the same way.

---
From a608726b01ff78a8084f8255484c83d0aa144faf Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 17 Nov 2022 23:49:30 -0500
Subject: [PATCH] zpool: clean out dead code

There is a lot of provision for flexibility that isn't actually needed
or used:

- Zswap, the only zpool user, always passes zpool_ops with an .evict
  method set. The backends who reclaim only do so for zswap, so they
  can also directly call zpool_ops without indirection or checks.

- There is no need to check the retries parameters and bail with
  -EINVAL in the reclaim function, when that's called just a few lines
  below with a hard-coded 8.

- There is no need to duplicate the evictable and sleep_mapped attrs
  from the driver in zpool, when driver is in zpool->driver.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/z3fold.c | 36 +++++-------------------------------
 mm/zbud.c   | 32 +++++---------------------------
 mm/zpool.c  |  9 ++-------
 3 files changed, 12 insertions(+), 65 deletions(-)

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
index 68facc193496..74977526d60d 100644
--- a/mm/zpool.c
+++ b/mm/zpool.c
@@ -22,8 +22,6 @@ struct zpool {
 	struct zpool_driver *driver;
 	void *pool;
 	const struct zpool_ops *ops;
-	bool evictable;
-	bool can_sleep_mapped;
 };
 
 static LIST_HEAD(drivers_head);
@@ -177,9 +175,6 @@ struct zpool *zpool_create_pool(const char *type, const char *name, gfp_t gfp,
 
 	zpool->driver = driver;
 	zpool->pool = driver->create(name, gfp, ops, zpool);
-	zpool->ops = ops;
-	zpool->evictable = driver->shrink && ops && ops->evict;
-	zpool->can_sleep_mapped = driver->sleep_mapped;
 
 	if (!zpool->pool) {
 		pr_err("couldn't create %s pool\n", type);
@@ -380,7 +375,7 @@ u64 zpool_get_total_size(struct zpool *zpool)
  */
 bool zpool_evictable(struct zpool *zpool)
 {
-	return zpool->evictable;
+	return zpool->driver->shrink;
 }
 
 /**
@@ -391,7 +386,7 @@ bool zpool_evictable(struct zpool *zpool)
  */
 bool zpool_can_sleep_mapped(struct zpool *zpool)
 {
-	return zpool->can_sleep_mapped;
+	return zpool->driver->sleep_mapped;
 }
 
 MODULE_LICENSE("GPL");
-- 
2.38.1
