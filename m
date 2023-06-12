Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A168572BD2A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjFLJyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjFLJyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:54:02 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FFE10E3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:26 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-970056276acso624954766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686562704; x=1689154704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWcn4pimJ5KW1PBG1fIPKyRzJ8b978SaqQ0pm1IG1/8=;
        b=UsGToKvO4y90q4yPLfqeWwZ/1V3U/Fn8s4qhkbX9Y0D9gowJK4N1qYjtTOtJZiTZ0U
         GiBeZ3eWkRFQ0fzeJ3ERdtZaSGlKW1hrZiq19+LMbKSeGowZAlRYAbwcLsR2zdro1wFN
         d1WW2BnINvfFGYPgsDk8EaD/w8EKgECRYGik8RnfdqKxEDtFXxL7ZlQUi8uMk+NHfORK
         2mnKNSBtv4eAJsG2l2AjLI1iZFJ6cCKwSxL6zu/E4V3LpKwU0qdKG8x/QPTe/EmMDSUZ
         Eilm18mT8nvlwgTRYy3W5o4nzPV4EzMAEg07fT+8jK4uUojKmBbedhpFS59yQ2+ix95i
         a7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562704; x=1689154704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWcn4pimJ5KW1PBG1fIPKyRzJ8b978SaqQ0pm1IG1/8=;
        b=YHtA/8orx8ETN4/Gr0whjuKV4a9ZukW0guAG6EXYy2M719SusGZGwZeka6p+crxOao
         oT18OGxQEVAa0XSL6prPOFXnyViTuJz0LhqivcbGrwHNOb3+bic7a/xVV1Kk1XsRt+Yx
         vIzqdqooBCEjpFn1G0dp9nyN7CEhFoRvuOegmERukiyEdFDiJNueFzyk4CZ8JalM592z
         qPaGhzFHMh7g7LRf6QMBOQ2Y45In5KlDDlnsmIIqmZhyMxQ0fBQ/3xxzLBYgRS3LbZ6t
         PD45L22Lem3GSnUKW0FT6FNCSzCWxiYV24pgbEGigU96yvzznWH36apogSnF9+rjilJl
         c2Pw==
X-Gm-Message-State: AC+VfDxAUPUmedSoMW0dVExx1d8EKnjO7HbSpQNnlHegSYdypq8jx6Vb
        NZ+FbhqK2lw4Rcto/dDnk/s=
X-Google-Smtp-Source: ACHHUZ6tHRVdQFPG4ynNEr8OcqEEKS8YgYXjZBp+ML8Rf4c1enXgl3lldAM9eCWh7Htg9JlTd86A8A==
X-Received: by 2002:a17:906:da83:b0:974:1ced:6a59 with SMTP id xh3-20020a170906da8300b009741ced6a59mr8089543ejb.3.1686562704358;
        Mon, 12 Jun 2023 02:38:24 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-212-171-43-8.retail.telecomitalia.it. [212.171.43.8])
        by smtp.gmail.com with ESMTPSA id ce23-20020a170906b25700b0097887b68c17sm4951358ejb.98.2023.06.12.02.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:38:23 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v3 3/7] mm: zswap: remove page reclaim logic from z3fold
Date:   Mon, 12 Jun 2023 11:38:11 +0200
Message-Id: <20230612093815.133504-4-cerasuolodomenico@gmail.com>
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

Switch z3fold to the new generic zswap LRU and remove its custom
implementation.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/z3fold.c | 245 +---------------------------------------------------
 1 file changed, 2 insertions(+), 243 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 0cef845d397b..238a214de59f 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -125,13 +125,11 @@ struct z3fold_header {
 /**
  * struct z3fold_pool - stores metadata for each z3fold pool
  * @name:	pool name
- * @lock:	protects pool unbuddied/lru lists
+ * @lock:	protects pool unbuddied lists
  * @stale_lock:	protects pool stale page list
  * @unbuddied:	per-cpu array of lists tracking z3fold pages that contain 2-
  *		buddies; the list each z3fold page is added to depends on
  *		the size of its free region.
- * @lru:	list tracking the z3fold pages in LRU order by most recently
- *		added buddy.
  * @stale:	list of pages marked for freeing
  * @pages_nr:	number of z3fold pages in the pool.
  * @c_handle:	cache for z3fold_buddy_slots allocation
@@ -149,12 +147,9 @@ struct z3fold_pool {
 	spinlock_t lock;
 	spinlock_t stale_lock;
 	struct list_head *unbuddied;
-	struct list_head lru;
 	struct list_head stale;
 	atomic64_t pages_nr;
 	struct kmem_cache *c_handle;
-	struct zpool *zpool;
-	const struct zpool_ops *zpool_ops;
 	struct workqueue_struct *compact_wq;
 	struct workqueue_struct *release_wq;
 	struct work_struct work;
@@ -329,7 +324,6 @@ static struct z3fold_header *init_z3fold_page(struct page *page, bool headless,
 	struct z3fold_header *zhdr = page_address(page);
 	struct z3fold_buddy_slots *slots;
 
-	INIT_LIST_HEAD(&page->lru);
 	clear_bit(PAGE_HEADLESS, &page->private);
 	clear_bit(MIDDLE_CHUNK_MAPPED, &page->private);
 	clear_bit(NEEDS_COMPACTING, &page->private);
@@ -451,8 +445,6 @@ static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
 	set_bit(PAGE_STALE, &page->private);
 	clear_bit(NEEDS_COMPACTING, &page->private);
 	spin_lock(&pool->lock);
-	if (!list_empty(&page->lru))
-		list_del_init(&page->lru);
 	spin_unlock(&pool->lock);
 
 	if (locked)
@@ -930,7 +922,6 @@ static struct z3fold_pool *z3fold_create_pool(const char *name, gfp_t gfp)
 		for_each_unbuddied_list(i, 0)
 			INIT_LIST_HEAD(&unbuddied[i]);
 	}
-	INIT_LIST_HEAD(&pool->lru);
 	INIT_LIST_HEAD(&pool->stale);
 	atomic64_set(&pool->pages_nr, 0);
 	pool->name = name;
@@ -1073,12 +1064,6 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
 
 headless:
 	spin_lock(&pool->lock);
-	/* Add/move z3fold page to beginning of LRU */
-	if (!list_empty(&page->lru))
-		list_del(&page->lru);
-
-	list_add(&page->lru, &pool->lru);
-
 	*handle = encode_handle(zhdr, bud);
 	spin_unlock(&pool->lock);
 	if (bud != HEADLESS)
@@ -1115,9 +1100,6 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		 * immediately so we don't care about its value any more.
 		 */
 		if (!page_claimed) {
-			spin_lock(&pool->lock);
-			list_del(&page->lru);
-			spin_unlock(&pool->lock);
 			put_z3fold_header(zhdr);
 			free_z3fold_page(page, true);
 			atomic64_dec(&pool->pages_nr);
@@ -1172,194 +1154,6 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 	put_z3fold_header(zhdr);
 }
 
-/**
- * z3fold_reclaim_page() - evicts allocations from a pool page and frees it
- * @pool:	pool from which a page will attempt to be evicted
- * @retries:	number of pages on the LRU list for which eviction will
- *		be attempted before failing
- *
- * z3fold reclaim is different from normal system reclaim in that it is done
- * from the bottom, up. This is because only the bottom layer, z3fold, has
- * information on how the allocations are organized within each z3fold page.
- * This has the potential to create interesting locking situations between
- * z3fold and the user, however.
- *
- * To avoid these, this is how z3fold_reclaim_page() should be called:
- *
- * The user detects a page should be reclaimed and calls z3fold_reclaim_page().
- * z3fold_reclaim_page() will remove a z3fold page from the pool LRU list and
- * call the user-defined eviction handler with the pool and handle as
- * arguments.
- *
- * If the handle can not be evicted, the eviction handler should return
- * non-zero. z3fold_reclaim_page() will add the z3fold page back to the
- * appropriate list and try the next z3fold page on the LRU up to
- * a user defined number of retries.
- *
- * If the handle is successfully evicted, the eviction handler should
- * return 0 _and_ should have called z3fold_free() on the handle. z3fold_free()
- * contains logic to delay freeing the page if the page is under reclaim,
- * as indicated by the setting of the PG_reclaim flag on the underlying page.
- *
- * If all buddies in the z3fold page are successfully evicted, then the
- * z3fold page can be freed.
- *
- * Returns: 0 if page is successfully freed, otherwise -EINVAL if there are
- * no pages to evict or an eviction handler is not registered, -EAGAIN if
- * the retry limit was hit.
- */
-static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
-{
-	int i, ret = -1;
-	struct z3fold_header *zhdr = NULL;
-	struct page *page = NULL;
-	struct list_head *pos;
-	unsigned long first_handle = 0, middle_handle = 0, last_handle = 0;
-	struct z3fold_buddy_slots slots __attribute__((aligned(SLOTS_ALIGN)));
-
-	rwlock_init(&slots.lock);
-	slots.pool = (unsigned long)pool | (1 << HANDLES_NOFREE);
-
-	spin_lock(&pool->lock);
-	for (i = 0; i < retries; i++) {
-		if (list_empty(&pool->lru)) {
-			spin_unlock(&pool->lock);
-			return -EINVAL;
-		}
-		list_for_each_prev(pos, &pool->lru) {
-			page = list_entry(pos, struct page, lru);
-
-			zhdr = page_address(page);
-			if (test_bit(PAGE_HEADLESS, &page->private)) {
-				/*
-				 * For non-headless pages, we wait to do this
-				 * until we have the page lock to avoid racing
-				 * with __z3fold_alloc(). Headless pages don't
-				 * have a lock (and __z3fold_alloc() will never
-				 * see them), but we still need to test and set
-				 * PAGE_CLAIMED to avoid racing with
-				 * z3fold_free(), so just do it now before
-				 * leaving the loop.
-				 */
-				if (test_and_set_bit(PAGE_CLAIMED, &page->private))
-					continue;
-
-				break;
-			}
-
-			if (!z3fold_page_trylock(zhdr)) {
-				zhdr = NULL;
-				continue; /* can't evict at this point */
-			}
-
-			/* test_and_set_bit is of course atomic, but we still
-			 * need to do it under page lock, otherwise checking
-			 * that bit in __z3fold_alloc wouldn't make sense
-			 */
-			if (zhdr->foreign_handles ||
-			    test_and_set_bit(PAGE_CLAIMED, &page->private)) {
-				z3fold_page_unlock(zhdr);
-				zhdr = NULL;
-				continue; /* can't evict such page */
-			}
-			list_del_init(&zhdr->buddy);
-			zhdr->cpu = -1;
-			/* See comment in __z3fold_alloc. */
-			kref_get(&zhdr->refcount);
-			break;
-		}
-
-		if (!zhdr)
-			break;
-
-		list_del_init(&page->lru);
-		spin_unlock(&pool->lock);
-
-		if (!test_bit(PAGE_HEADLESS, &page->private)) {
-			/*
-			 * We need encode the handles before unlocking, and
-			 * use our local slots structure because z3fold_free
-			 * can zero out zhdr->slots and we can't do much
-			 * about that
-			 */
-			first_handle = 0;
-			last_handle = 0;
-			middle_handle = 0;
-			memset(slots.slot, 0, sizeof(slots.slot));
-			if (zhdr->first_chunks)
-				first_handle = __encode_handle(zhdr, &slots,
-								FIRST);
-			if (zhdr->middle_chunks)
-				middle_handle = __encode_handle(zhdr, &slots,
-								MIDDLE);
-			if (zhdr->last_chunks)
-				last_handle = __encode_handle(zhdr, &slots,
-								LAST);
-			/*
-			 * it's safe to unlock here because we hold a
-			 * reference to this page
-			 */
-			z3fold_page_unlock(zhdr);
-		} else {
-			first_handle = encode_handle(zhdr, HEADLESS);
-			last_handle = middle_handle = 0;
-		}
-		/* Issue the eviction callback(s) */
-		if (middle_handle) {
-			ret = pool->zpool_ops->evict(pool->zpool, middle_handle);
-			if (ret)
-				goto next;
-		}
-		if (first_handle) {
-			ret = pool->zpool_ops->evict(pool->zpool, first_handle);
-			if (ret)
-				goto next;
-		}
-		if (last_handle) {
-			ret = pool->zpool_ops->evict(pool->zpool, last_handle);
-			if (ret)
-				goto next;
-		}
-next:
-		if (test_bit(PAGE_HEADLESS, &page->private)) {
-			if (ret == 0) {
-				free_z3fold_page(page, true);
-				atomic64_dec(&pool->pages_nr);
-				return 0;
-			}
-			spin_lock(&pool->lock);
-			list_add(&page->lru, &pool->lru);
-			spin_unlock(&pool->lock);
-			clear_bit(PAGE_CLAIMED, &page->private);
-		} else {
-			struct z3fold_buddy_slots *slots = zhdr->slots;
-			z3fold_page_lock(zhdr);
-			if (kref_put(&zhdr->refcount,
-					release_z3fold_page_locked)) {
-				kmem_cache_free(pool->c_handle, slots);
-				return 0;
-			}
-			/*
-			 * if we are here, the page is still not completely
-			 * free. Take the global pool lock then to be able
-			 * to add it back to the lru list
-			 */
-			spin_lock(&pool->lock);
-			list_add(&page->lru, &pool->lru);
-			spin_unlock(&pool->lock);
-			if (list_empty(&zhdr->buddy))
-				add_to_unbuddied(pool, zhdr);
-			clear_bit(PAGE_CLAIMED, &page->private);
-			z3fold_page_unlock(zhdr);
-		}
-
-		/* We started off locked to we need to lock the pool back */
-		spin_lock(&pool->lock);
-	}
-	spin_unlock(&pool->lock);
-	return -EAGAIN;
-}
-
 /**
  * z3fold_map() - maps the allocation associated with the given handle
  * @pool:	pool in which the allocation resides
@@ -1470,8 +1264,6 @@ static bool z3fold_page_isolate(struct page *page, isolate_mode_t mode)
 	spin_lock(&pool->lock);
 	if (!list_empty(&zhdr->buddy))
 		list_del_init(&zhdr->buddy);
-	if (!list_empty(&page->lru))
-		list_del_init(&page->lru);
 	spin_unlock(&pool->lock);
 
 	kref_get(&zhdr->refcount);
@@ -1531,9 +1323,6 @@ static int z3fold_page_migrate(struct page *newpage, struct page *page,
 		encode_handle(new_zhdr, MIDDLE);
 	set_bit(NEEDS_COMPACTING, &newpage->private);
 	new_zhdr->cpu = smp_processor_id();
-	spin_lock(&pool->lock);
-	list_add(&newpage->lru, &pool->lru);
-	spin_unlock(&pool->lock);
 	__SetPageMovable(newpage, &z3fold_mops);
 	z3fold_page_unlock(new_zhdr);
 
@@ -1559,9 +1348,6 @@ static void z3fold_page_putback(struct page *page)
 	INIT_LIST_HEAD(&page->lru);
 	if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
 		return;
-	spin_lock(&pool->lock);
-	list_add(&page->lru, &pool->lru);
-	spin_unlock(&pool->lock);
 	if (list_empty(&zhdr->buddy))
 		add_to_unbuddied(pool, zhdr);
 	clear_bit(PAGE_CLAIMED, &page->private);
@@ -1582,14 +1368,7 @@ static void *z3fold_zpool_create(const char *name, gfp_t gfp,
 			       const struct zpool_ops *zpool_ops,
 			       struct zpool *zpool)
 {
-	struct z3fold_pool *pool;
-
-	pool = z3fold_create_pool(name, gfp);
-	if (pool) {
-		pool->zpool = zpool;
-		pool->zpool_ops = zpool_ops;
-	}
-	return pool;
+	return z3fold_create_pool(name, gfp);
 }
 
 static void z3fold_zpool_destroy(void *pool)
@@ -1607,25 +1386,6 @@ static void z3fold_zpool_free(void *pool, unsigned long handle)
 	z3fold_free(pool, handle);
 }
 
-static int z3fold_zpool_shrink(void *pool, unsigned int pages,
-			unsigned int *reclaimed)
-{
-	unsigned int total = 0;
-	int ret = -EINVAL;
-
-	while (total < pages) {
-		ret = z3fold_reclaim_page(pool, 8);
-		if (ret < 0)
-			break;
-		total++;
-	}
-
-	if (reclaimed)
-		*reclaimed = total;
-
-	return ret;
-}
-
 static void *z3fold_zpool_map(void *pool, unsigned long handle,
 			enum zpool_mapmode mm)
 {
@@ -1649,7 +1409,6 @@ static struct zpool_driver z3fold_zpool_driver = {
 	.destroy =	z3fold_zpool_destroy,
 	.malloc =	z3fold_zpool_malloc,
 	.free =		z3fold_zpool_free,
-	.shrink =	z3fold_zpool_shrink,
 	.map =		z3fold_zpool_map,
 	.unmap =	z3fold_zpool_unmap,
 	.total_size =	z3fold_zpool_total_size,
-- 
2.34.1

