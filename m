Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C972217D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjFEIzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjFEIyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:54:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BF910C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:54:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-977cf86aae5so188982666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685955269; x=1688547269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SelvWHuRmB9qYK6uvKY8c3bmTfu/gV9/UpW9ng/IiW8=;
        b=cbgueKOQbNxHoHuF4V6qQsV6CQHBqS9C0tyOae7dbeOgLSxe3DfFUf2VIy888iH8Rh
         +FiT3UpNXP5s27/wP8KWthItEpMfOqKo1ZxyjNNyHjPWzW6mFzeSaCyVsl3eOa1K5dPY
         v1FGubyAKqYcb2ynOje2NPYX0JQx13GZJA+HkAj3MZOhUYqlLq/C0dXG3VXCqpC8AaXy
         PBLxPVAuB05smiQixJ7R9fe7Zz/vfbp0AQBV97blG7LHRfsW/Qw8Tc2PncdkXQlu1qAE
         ViobkuPoU5hDZozI92OqjNW8F5rkfF+IMBPeMU2TAhV7ifABrgaNBMJxE+W3ET5nJyCl
         5N3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685955269; x=1688547269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SelvWHuRmB9qYK6uvKY8c3bmTfu/gV9/UpW9ng/IiW8=;
        b=c8AX2bv2QkcV8pyXLrcHXJeACcyWU5cTHevEsdkZXFc3tiJ2n5WlQtlzzoNyS4KbxE
         v+ewJRZRrfkpabfcatEt+5WyYPpEPZcZk4vURJUZpRV5Zpk9Z/Q8Bmhk1MmrrfUGjpwk
         Uvw/DmDz7Rd4eR1OCJfFMR9xCrfVFkGi6RzRnd/eFGOroQvUsRvreoP8cVPj8KMEqiWk
         tbjFUPUrZymqgjM8zmCpVvG6l7hvf+Z7uhfMaz+qz+jNiMMOBxuYjOtrkzafIL/AMwTx
         mthkAVFD0+WvrIi0sj8rcJfK0SAPI78wCt55+T6HpsqHPZOdqsOie+htH0cKMa5X3rMV
         jSjw==
X-Gm-Message-State: AC+VfDyXXRp1MmWyxio91PDfQiRPgPBbwoWWjPOnjonRkvVbqehsL4Zi
        ICfj9Kk/tlwojaxCpRLcx4I=
X-Google-Smtp-Source: ACHHUZ6wY5Xh5bJKL7AoGQLq7KZiATpBq05Wko9yiuCDiodbq2oalYjNzVPNWjDIqqp6G3A9so00NQ==
X-Received: by 2002:a17:907:969f:b0:973:940e:a018 with SMTP id hd31-20020a170907969f00b00973940ea018mr4860860ejc.34.1685955269494;
        Mon, 05 Jun 2023 01:54:29 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-82-53-8-153.retail.telecomitalia.it. [82.53.8.153])
        by smtp.gmail.com with ESMTPSA id lx5-20020a170906af0500b00965c6c63ea3sm4048915ejb.35.2023.06.05.01.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 01:54:29 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [RFC PATCH 4/7] mm: zswap: remove page reclaim logic from zsmalloc
Date:   Mon,  5 Jun 2023 10:54:16 +0200
Message-Id: <20230605085419.44383-5-cerasuolodomenico@gmail.com>
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

With the recent enhancement to zswap enabling direct page writeback, the
need for the shrink code in zsmalloc has become obsolete. As a result,
this commit removes the page reclaim logic from zsmalloc entirely.

Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zsmalloc.c | 291 +-------------------------------------------------
 1 file changed, 2 insertions(+), 289 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 02f7f414aade..c87a60514f21 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -250,13 +250,6 @@ struct zs_pool {
 	/* Compact classes */
 	struct shrinker shrinker;
 
-#ifdef CONFIG_ZPOOL
-	/* List tracking the zspages in LRU order by most recently added object */
-	struct list_head lru;
-	struct zpool *zpool;
-	const struct zpool_ops *zpool_ops;
-#endif
-
 #ifdef CONFIG_ZSMALLOC_STAT
 	struct dentry *stat_dentry;
 #endif
@@ -279,13 +272,6 @@ struct zspage {
 	unsigned int freeobj;
 	struct page *first_page;
 	struct list_head list; /* fullness list */
-
-#ifdef CONFIG_ZPOOL
-	/* links the zspage to the lru list in the pool */
-	struct list_head lru;
-	bool under_reclaim;
-#endif
-
 	struct zs_pool *pool;
 	rwlock_t lock;
 };
@@ -393,14 +379,7 @@ static void *zs_zpool_create(const char *name, gfp_t gfp,
 	 * different contexts and its caller must provide a valid
 	 * gfp mask.
 	 */
-	struct zs_pool *pool = zs_create_pool(name);
-
-	if (pool) {
-		pool->zpool = zpool;
-		pool->zpool_ops = zpool_ops;
-	}
-
-	return pool;
+	return zs_create_pool(name);
 }
 
 static void zs_zpool_destroy(void *pool)
@@ -422,27 +401,6 @@ static void zs_zpool_free(void *pool, unsigned long handle)
 	zs_free(pool, handle);
 }
 
-static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries);
-
-static int zs_zpool_shrink(void *pool, unsigned int pages,
-			unsigned int *reclaimed)
-{
-	unsigned int total = 0;
-	int ret = -EINVAL;
-
-	while (total < pages) {
-		ret = zs_reclaim_page(pool, 8);
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
 static void *zs_zpool_map(void *pool, unsigned long handle,
 			enum zpool_mapmode mm)
 {
@@ -481,7 +439,7 @@ static struct zpool_driver zs_zpool_driver = {
 	.malloc_support_movable = true,
 	.malloc =		  zs_zpool_malloc,
 	.free =			  zs_zpool_free,
-	.shrink =		  zs_zpool_shrink,
+	.shrink =		  NULL,
 	.map =			  zs_zpool_map,
 	.unmap =		  zs_zpool_unmap,
 	.total_size =		  zs_zpool_total_size,
@@ -884,14 +842,6 @@ static inline bool obj_allocated(struct page *page, void *obj, unsigned long *ph
 	return obj_tagged(page, obj, phandle, OBJ_ALLOCATED_TAG);
 }
 
-#ifdef CONFIG_ZPOOL
-static bool obj_stores_deferred_handle(struct page *page, void *obj,
-		unsigned long *phandle)
-{
-	return obj_tagged(page, obj, phandle, OBJ_DEFERRED_HANDLE_TAG);
-}
-#endif
-
 static void reset_page(struct page *page)
 {
 	__ClearPageMovable(page);
@@ -1006,9 +956,6 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
 	}
 
 	remove_zspage(class, zspage, ZS_INUSE_RATIO_0);
-#ifdef CONFIG_ZPOOL
-	list_del(&zspage->lru);
-#endif
 	__free_zspage(pool, class, zspage);
 }
 
@@ -1054,11 +1001,6 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		off %= PAGE_SIZE;
 	}
 
-#ifdef CONFIG_ZPOOL
-	INIT_LIST_HEAD(&zspage->lru);
-	zspage->under_reclaim = false;
-#endif
-
 	set_freeobj(zspage, 0);
 }
 
@@ -1525,13 +1467,6 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
 out:
-#ifdef CONFIG_ZPOOL
-	/* Add/move zspage to beginning of LRU */
-	if (!list_empty(&zspage->lru))
-		list_del(&zspage->lru);
-	list_add(&zspage->lru, &pool->lru);
-#endif
-
 	spin_unlock(&pool->lock);
 
 	return handle;
@@ -1600,20 +1535,6 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	class = zspage_class(pool, zspage);
 
 	class_stat_dec(class, ZS_OBJS_INUSE, 1);
-
-#ifdef CONFIG_ZPOOL
-	if (zspage->under_reclaim) {
-		/*
-		 * Reclaim needs the handles during writeback. It'll free
-		 * them along with the zspage when it's done with them.
-		 *
-		 * Record current deferred handle in the object's header.
-		 */
-		obj_free(class->size, obj, &handle);
-		spin_unlock(&pool->lock);
-		return;
-	}
-#endif
 	obj_free(class->size, obj, NULL);
 
 	fullness = fix_fullness_group(class, zspage);
@@ -1890,23 +1811,6 @@ static void lock_zspage(struct zspage *zspage)
 }
 #endif /* defined(CONFIG_ZPOOL) || defined(CONFIG_COMPACTION) */
 
-#ifdef CONFIG_ZPOOL
-/*
- * Unlocks all the pages of the zspage.
- *
- * pool->lock must be held before this function is called
- * to prevent the underlying pages from migrating.
- */
-static void unlock_zspage(struct zspage *zspage)
-{
-	struct page *page = get_first_page(zspage);
-
-	do {
-		unlock_page(page);
-	} while ((page = get_next_page(page)) != NULL);
-}
-#endif /* CONFIG_ZPOOL */
-
 static void migrate_lock_init(struct zspage *zspage)
 {
 	rwlock_init(&zspage->lock);
@@ -2126,9 +2030,6 @@ static void async_free_zspage(struct work_struct *work)
 		VM_BUG_ON(fullness != ZS_INUSE_RATIO_0);
 		class = pool->size_class[class_idx];
 		spin_lock(&pool->lock);
-#ifdef CONFIG_ZPOOL
-		list_del(&zspage->lru);
-#endif
 		__free_zspage(pool, class, zspage);
 		spin_unlock(&pool->lock);
 	}
@@ -2474,10 +2375,6 @@ struct zs_pool *zs_create_pool(const char *name)
 	 */
 	zs_register_shrinker(pool);
 
-#ifdef CONFIG_ZPOOL
-	INIT_LIST_HEAD(&pool->lru);
-#endif
-
 	return pool;
 
 err:
@@ -2520,190 +2417,6 @@ void zs_destroy_pool(struct zs_pool *pool)
 }
 EXPORT_SYMBOL_GPL(zs_destroy_pool);
 
-#ifdef CONFIG_ZPOOL
-static void restore_freelist(struct zs_pool *pool, struct size_class *class,
-		struct zspage *zspage)
-{
-	unsigned int obj_idx = 0;
-	unsigned long handle, off = 0; /* off is within-page offset */
-	struct page *page = get_first_page(zspage);
-	struct link_free *prev_free = NULL;
-	void *prev_page_vaddr = NULL;
-
-	/* in case no free object found */
-	set_freeobj(zspage, (unsigned int)(-1UL));
-
-	while (page) {
-		void *vaddr = kmap_atomic(page);
-		struct page *next_page;
-
-		while (off < PAGE_SIZE) {
-			void *obj_addr = vaddr + off;
-
-			/* skip allocated object */
-			if (obj_allocated(page, obj_addr, &handle)) {
-				obj_idx++;
-				off += class->size;
-				continue;
-			}
-
-			/* free deferred handle from reclaim attempt */
-			if (obj_stores_deferred_handle(page, obj_addr, &handle))
-				cache_free_handle(pool, handle);
-
-			if (prev_free)
-				prev_free->next = obj_idx << OBJ_TAG_BITS;
-			else /* first free object found */
-				set_freeobj(zspage, obj_idx);
-
-			prev_free = (struct link_free *)vaddr + off / sizeof(*prev_free);
-			/* if last free object in a previous page, need to unmap */
-			if (prev_page_vaddr) {
-				kunmap_atomic(prev_page_vaddr);
-				prev_page_vaddr = NULL;
-			}
-
-			obj_idx++;
-			off += class->size;
-		}
-
-		/*
-		 * Handle the last (full or partial) object on this page.
-		 */
-		next_page = get_next_page(page);
-		if (next_page) {
-			if (!prev_free || prev_page_vaddr) {
-				/*
-				 * There is no free object in this page, so we can safely
-				 * unmap it.
-				 */
-				kunmap_atomic(vaddr);
-			} else {
-				/* update prev_page_vaddr since prev_free is on this page */
-				prev_page_vaddr = vaddr;
-			}
-		} else { /* this is the last page */
-			if (prev_free) {
-				/*
-				 * Reset OBJ_TAG_BITS bit to last link to tell
-				 * whether it's allocated object or not.
-				 */
-				prev_free->next = -1UL << OBJ_TAG_BITS;
-			}
-
-			/* unmap previous page (if not done yet) */
-			if (prev_page_vaddr) {
-				kunmap_atomic(prev_page_vaddr);
-				prev_page_vaddr = NULL;
-			}
-
-			kunmap_atomic(vaddr);
-		}
-
-		page = next_page;
-		off %= PAGE_SIZE;
-	}
-}
-
-static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
-{
-	int i, obj_idx, ret = 0;
-	unsigned long handle;
-	struct zspage *zspage;
-	struct page *page;
-	int fullness;
-
-	/* Lock LRU and fullness list */
-	spin_lock(&pool->lock);
-	if (list_empty(&pool->lru)) {
-		spin_unlock(&pool->lock);
-		return -EINVAL;
-	}
-
-	for (i = 0; i < retries; i++) {
-		struct size_class *class;
-
-		zspage = list_last_entry(&pool->lru, struct zspage, lru);
-		list_del(&zspage->lru);
-
-		/* zs_free may free objects, but not the zspage and handles */
-		zspage->under_reclaim = true;
-
-		class = zspage_class(pool, zspage);
-		fullness = get_fullness_group(class, zspage);
-
-		/* Lock out object allocations and object compaction */
-		remove_zspage(class, zspage, fullness);
-
-		spin_unlock(&pool->lock);
-		cond_resched();
-
-		/* Lock backing pages into place */
-		lock_zspage(zspage);
-
-		obj_idx = 0;
-		page = get_first_page(zspage);
-		while (1) {
-			handle = find_alloced_obj(class, page, &obj_idx);
-			if (!handle) {
-				page = get_next_page(page);
-				if (!page)
-					break;
-				obj_idx = 0;
-				continue;
-			}
-
-			/*
-			 * This will write the object and call zs_free.
-			 *
-			 * zs_free will free the object, but the
-			 * under_reclaim flag prevents it from freeing
-			 * the zspage altogether. This is necessary so
-			 * that we can continue working with the
-			 * zspage potentially after the last object
-			 * has been freed.
-			 */
-			ret = pool->zpool_ops->evict(pool->zpool, handle);
-			if (ret)
-				goto next;
-
-			obj_idx++;
-		}
-
-next:
-		/* For freeing the zspage, or putting it back in the pool and LRU list. */
-		spin_lock(&pool->lock);
-		zspage->under_reclaim = false;
-
-		if (!get_zspage_inuse(zspage)) {
-			/*
-			 * Fullness went stale as zs_free() won't touch it
-			 * while the page is removed from the pool. Fix it
-			 * up for the check in __free_zspage().
-			 */
-			zspage->fullness = ZS_INUSE_RATIO_0;
-
-			__free_zspage(pool, class, zspage);
-			spin_unlock(&pool->lock);
-			return 0;
-		}
-
-		/*
-		 * Eviction fails on one of the handles, so we need to restore zspage.
-		 * We need to rebuild its freelist (and free stored deferred handles),
-		 * put it back to the correct size class, and add it to the LRU list.
-		 */
-		restore_freelist(pool, class, zspage);
-		putback_zspage(class, zspage);
-		list_add(&zspage->lru, &pool->lru);
-		unlock_zspage(zspage);
-	}
-
-	spin_unlock(&pool->lock);
-	return -EAGAIN;
-}
-#endif /* CONFIG_ZPOOL */
-
 static int __init zs_init(void)
 {
 	int ret;
-- 
2.34.1

