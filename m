Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102D372BD39
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjFLJz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjFLJyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:54:02 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE2349DF
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977d55ac17bso762581466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686562706; x=1689154706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qqabn+5EZnE3xDBV/hK/uIK9ftICUILiN887bfpMl50=;
        b=VXHkwjjYAYvgJn0o0mmj8tPgMol+yYARZ/ysRinnWzusuBZgC+a79n6wHSu8WEsx4p
         EAGxIa/ZXpDS2/l5rLYOQFi4I0qV3cE+prGitoYDeL8bi+QiOTBoYD3wK0FuVyr88G9e
         5F8ZoW80SQFRoo/2WMD2/uN64+VYTE0hvwin3Op0ZXSAIDYWpME5qf8l51RJlJQk4P63
         fucA6dWn1mgoPV1CdFbl7i4lUZP1ja+JLYMxwlTBCGvtaRnJCEnqtdVQx7hrcAwPh7hR
         W+g+ONUUpryQ0cQwLv6+JreSgNwJ8SLKMjFdH5biM9SppVCySh1omBRxEuOrlCMeG7rN
         myTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562706; x=1689154706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qqabn+5EZnE3xDBV/hK/uIK9ftICUILiN887bfpMl50=;
        b=UjCg/QEnRJ+mRa7RkhZ9B48ZBU8d5CVi/QQ1TYxOO13VnwBlLc3bDNy7TnjIzgnHR7
         erL9T9hHL7/W6bqCoW/hTF2dtKrfa7moPOApW7ixnSKyY39MqwDCbkXgyRPSsQyMr/xc
         r4WCHGpqm2OSkWvrvvA4rNmTo6AybmkC/J2zuCafFFaKAcneo1jTDe5vexse36pen7zp
         yuHuoxA5+8WtXNprfWZ8uwdKjIuM7XYuouzjrDXhGu1HgKXSTZJx+oyVOdow5a0ahKXl
         hhsXmbiFtRaFFnrwr8ioneUOWHevxdlRtiHJS3H2waKvYBwPZC1SxCqmRojCZ2GSR3+O
         tgpA==
X-Gm-Message-State: AC+VfDz3hLD/v9kHvd0wrxsOHISBhp3ydvYNgP1lZS1+vrLLg11WEHHR
        JeGVA8y7ZnDQ0Uzu8IWUdhc=
X-Google-Smtp-Source: ACHHUZ74X9HGGClZK/hRGG7bOiLl3qlJW7y4hEvEU/q03AAT5pBayVQiFxfjnbxw8l8ogxtwH0/Tlg==
X-Received: by 2002:a17:907:368d:b0:961:78c2:1d27 with SMTP id bi13-20020a170907368d00b0096178c21d27mr10471708ejc.19.1686562705698;
        Mon, 12 Jun 2023 02:38:25 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-212-171-43-8.retail.telecomitalia.it. [212.171.43.8])
        by smtp.gmail.com with ESMTPSA id ce23-20020a170906b25700b0097887b68c17sm4951358ejb.98.2023.06.12.02.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:38:25 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v3 4/7] mm: zswap: remove page reclaim logic from zsmalloc
Date:   Mon, 12 Jun 2023 11:38:12 +0200
Message-Id: <20230612093815.133504-5-cerasuolodomenico@gmail.com>
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

Switch zsmalloc to the new generic zswap LRU and remove its custom
implementation.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
Tested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zsmalloc.c | 392 ++------------------------------------------------
 1 file changed, 12 insertions(+), 380 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index c0d433541636..e4d1ad521738 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -107,21 +107,8 @@
  */
 #define OBJ_ALLOCATED_TAG 1
 
-#ifdef CONFIG_ZPOOL
-/*
- * The second least-significant bit in the object's header identifies if the
- * value stored at the header is a deferred handle from the last reclaim
- * attempt.
- *
- * As noted above, this is valid because we have room for two bits.
- */
-#define OBJ_DEFERRED_HANDLE_TAG	2
-#define OBJ_TAG_BITS	2
-#define OBJ_TAG_MASK	(OBJ_ALLOCATED_TAG | OBJ_DEFERRED_HANDLE_TAG)
-#else
 #define OBJ_TAG_BITS	1
 #define OBJ_TAG_MASK	OBJ_ALLOCATED_TAG
-#endif /* CONFIG_ZPOOL */
 
 #define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
 #define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
@@ -227,12 +214,6 @@ struct link_free {
 		 * Handle of allocated object.
 		 */
 		unsigned long handle;
-#ifdef CONFIG_ZPOOL
-		/*
-		 * Deferred handle of a reclaimed object.
-		 */
-		unsigned long deferred_handle;
-#endif
 	};
 };
 
@@ -250,13 +231,6 @@ struct zs_pool {
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
@@ -279,13 +253,6 @@ struct zspage {
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
@@ -393,14 +360,7 @@ static void *zs_zpool_create(const char *name, gfp_t gfp,
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
@@ -422,27 +382,6 @@ static void zs_zpool_free(void *pool, unsigned long handle)
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
@@ -481,7 +420,6 @@ static struct zpool_driver zs_zpool_driver = {
 	.malloc_support_movable = true,
 	.malloc =		  zs_zpool_malloc,
 	.free =			  zs_zpool_free,
-	.shrink =		  zs_zpool_shrink,
 	.map =			  zs_zpool_map,
 	.unmap =		  zs_zpool_unmap,
 	.total_size =		  zs_zpool_total_size,
@@ -884,14 +822,6 @@ static inline bool obj_allocated(struct page *page, void *obj, unsigned long *ph
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
@@ -922,39 +852,6 @@ static int trylock_zspage(struct zspage *zspage)
 	return 0;
 }
 
-#ifdef CONFIG_ZPOOL
-static unsigned long find_deferred_handle_obj(struct size_class *class,
-		struct page *page, int *obj_idx);
-
-/*
- * Free all the deferred handles whose objects are freed in zs_free.
- */
-static void free_handles(struct zs_pool *pool, struct size_class *class,
-		struct zspage *zspage)
-{
-	int obj_idx = 0;
-	struct page *page = get_first_page(zspage);
-	unsigned long handle;
-
-	while (1) {
-		handle = find_deferred_handle_obj(class, page, &obj_idx);
-		if (!handle) {
-			page = get_next_page(page);
-			if (!page)
-				break;
-			obj_idx = 0;
-			continue;
-		}
-
-		cache_free_handle(pool, handle);
-		obj_idx++;
-	}
-}
-#else
-static inline void free_handles(struct zs_pool *pool, struct size_class *class,
-		struct zspage *zspage) {}
-#endif
-
 static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 				struct zspage *zspage)
 {
@@ -969,9 +866,6 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(fg != ZS_INUSE_RATIO_0);
 
-	/* Free all deferred handles from zs_free */
-	free_handles(pool, class, zspage);
-
 	next = page = get_first_page(zspage);
 	do {
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
@@ -1006,9 +900,6 @@ static void free_zspage(struct zs_pool *pool, struct size_class *class,
 	}
 
 	remove_zspage(class, zspage, ZS_INUSE_RATIO_0);
-#ifdef CONFIG_ZPOOL
-	list_del(&zspage->lru);
-#endif
 	__free_zspage(pool, class, zspage);
 }
 
@@ -1054,11 +945,6 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 		off %= PAGE_SIZE;
 	}
 
-#ifdef CONFIG_ZPOOL
-	INIT_LIST_HEAD(&zspage->lru);
-	zspage->under_reclaim = false;
-#endif
-
 	set_freeobj(zspage, 0);
 }
 
@@ -1525,20 +1411,13 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
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
 }
 EXPORT_SYMBOL_GPL(zs_malloc);
 
-static void obj_free(int class_size, unsigned long obj, unsigned long *handle)
+static void obj_free(int class_size, unsigned long obj)
 {
 	struct link_free *link;
 	struct zspage *zspage;
@@ -1554,25 +1433,12 @@ static void obj_free(int class_size, unsigned long obj, unsigned long *handle)
 	vaddr = kmap_atomic(f_page);
 	link = (struct link_free *)(vaddr + f_offset);
 
-	if (handle) {
-#ifdef CONFIG_ZPOOL
-		/* Stores the (deferred) handle in the object's header */
-		*handle |= OBJ_DEFERRED_HANDLE_TAG;
-		*handle &= ~OBJ_ALLOCATED_TAG;
-
-		if (likely(!ZsHugePage(zspage)))
-			link->deferred_handle = *handle;
-		else
-			f_page->index = *handle;
-#endif
-	} else {
-		/* Insert this object in containing zspage's freelist */
-		if (likely(!ZsHugePage(zspage)))
-			link->next = get_freeobj(zspage) << OBJ_TAG_BITS;
-		else
-			f_page->index = 0;
-		set_freeobj(zspage, f_objidx);
-	}
+	/* Insert this object in containing zspage's freelist */
+	if (likely(!ZsHugePage(zspage)))
+		link->next = get_freeobj(zspage) << OBJ_TAG_BITS;
+	else
+		f_page->index = 0;
+	set_freeobj(zspage, f_objidx);
 
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, -1);
@@ -1600,21 +1466,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
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
-	obj_free(class->size, obj, NULL);
+	obj_free(class->size, obj);
 
 	fullness = fix_fullness_group(class, zspage);
 	if (fullness == ZS_INUSE_RATIO_0)
@@ -1735,18 +1587,6 @@ static unsigned long find_alloced_obj(struct size_class *class,
 	return find_tagged_obj(class, page, obj_idx, OBJ_ALLOCATED_TAG);
 }
 
-#ifdef CONFIG_ZPOOL
-/*
- * Find object storing a deferred handle in header in zspage from index object
- * and return handle.
- */
-static unsigned long find_deferred_handle_obj(struct size_class *class,
-		struct page *page, int *obj_idx)
-{
-	return find_tagged_obj(class, page, obj_idx, OBJ_DEFERRED_HANDLE_TAG);
-}
-#endif
-
 struct zs_compact_control {
 	/* Source spage for migration which could be a subpage of zspage */
 	struct page *s_page;
@@ -1786,7 +1626,7 @@ static void migrate_zspage(struct zs_pool *pool, struct size_class *class,
 		zs_object_copy(class, free_obj, used_obj);
 		obj_idx++;
 		record_obj(handle, free_obj);
-		obj_free(class->size, used_obj, NULL);
+		obj_free(class->size, used_obj);
 	}
 
 	/* Remember last position in this iteration */
@@ -1846,7 +1686,7 @@ static int putback_zspage(struct size_class *class, struct zspage *zspage)
 	return fullness;
 }
 
-#if defined(CONFIG_ZPOOL) || defined(CONFIG_COMPACTION)
+#ifdef CONFIG_COMPACTION
 /*
  * To prevent zspage destroy during migration, zspage freeing should
  * hold locks of all pages in the zspage.
@@ -1888,24 +1728,7 @@ static void lock_zspage(struct zspage *zspage)
 	}
 	migrate_read_unlock(zspage);
 }
-#endif /* defined(CONFIG_ZPOOL) || defined(CONFIG_COMPACTION) */
-
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
+#endif /* CONFIG_COMPACTION */
 
 static void migrate_lock_init(struct zspage *zspage)
 {
@@ -2126,9 +1949,6 @@ static void async_free_zspage(struct work_struct *work)
 		VM_BUG_ON(fullness != ZS_INUSE_RATIO_0);
 		class = pool->size_class[class_idx];
 		spin_lock(&pool->lock);
-#ifdef CONFIG_ZPOOL
-		list_del(&zspage->lru);
-#endif
 		__free_zspage(pool, class, zspage);
 		spin_unlock(&pool->lock);
 	}
@@ -2474,10 +2294,6 @@ struct zs_pool *zs_create_pool(const char *name)
 	 */
 	zs_register_shrinker(pool);
 
-#ifdef CONFIG_ZPOOL
-	INIT_LIST_HEAD(&pool->lru);
-#endif
-
 	return pool;
 
 err:
@@ -2520,190 +2336,6 @@ void zs_destroy_pool(struct zs_pool *pool)
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

