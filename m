Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4DB60E9E0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiJZUHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiJZUGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:06:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5165791857
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:06:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f23so15265397plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eLGwbKV3BBUOzsaG0W84saUrLP5SGKXVz3Xw1kLQgs=;
        b=YnbOdy61eJftyiNAVtQlaSheYjFU9QGnOhN8d6buLYOroIL7bSX7FBIV769kp7XN4t
         e00hvxwyO2Fo6ei7jhhnHBZmjP73wDubAsLsY5DnWJCfpb4gCK2hcNL8qE+fzCE8LhNY
         fhjv87kf1mwJTJFEKNvhw02dnlg2DwTRnYDLkTyiaLo5M1YkRdYwWNg+Jv4nD3VMCmA2
         lqvIbtJ4dGpAU+OaDxkZbNnb3n2WGiPpNhyweYQo8Ub2i4GU/eo9iaPDr0Koj1Z6wDox
         ZSHFeoMNAVh2a6of/OV3CWer0niEqMY4ldK3uIT/l8rqJxBggQSOqzqg4vv3IUiW2WB8
         Y7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eLGwbKV3BBUOzsaG0W84saUrLP5SGKXVz3Xw1kLQgs=;
        b=6nD99jfU8/eN5Y10D5aZdw4WJRW1wWXh93JQExYhIQUyFRmZgWTlR3/GMzcisH+OOm
         wSGHqKnhUTH0mw+UlKUCQq46gcJmkzrfIoIeYrKfKNTmVvGYl0YR7MQE5LoWctsZ9nvN
         VzMF7GFqZuT0TBrzIPTjVYYWvroMTqWrdgbXecIWoAQzL8G333BWR80TAUPOgwHzHx6w
         4VnNIcsoY6F7LiTBWa4Z5YFxv+UxGkv/Mq9uaXrzmjVzyC9or1vNmgIl4Qw/yKQDY4Tr
         WWUGmKZzt5UA7MdtGwKpf3UgOEgRRv+WJj09ic9pweu/8aUrecHMgOh6ALKGj6BPPeUq
         oGlg==
X-Gm-Message-State: ACrzQf045SkI96c3PH8L77GgGSxUKWzIFbBaXIlTcEPhXBV+YC9PtK2R
        hcWr2KvAnppjyaOx6Hjanao=
X-Google-Smtp-Source: AMsMyM50+5QsPyvPHD6G+rlIglkmPx4wKqVV8cdlWHgNsV32FiuZgpNd2RbyE/nsV26Q00ASFl5F5g==
X-Received: by 2002:a17:902:cecc:b0:186:cd5c:3fc2 with SMTP id d12-20020a170902cecc00b00186cd5c3fc2mr8223249plg.152.1666814776763;
        Wed, 26 Oct 2022 13:06:16 -0700 (PDT)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78ec5000000b0056c04dee930sm3353909pfr.120.2022.10.26.13.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:06:16 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH 2/5] zsmalloc: Consolidate zs_pool's migrate_lock and size_class's locks
Date:   Wed, 26 Oct 2022 13:06:10 -0700
Message-Id: <20221026200613.1031261-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221026200613.1031261-1-nphamcs@gmail.com>
References: <20221026200613.1031261-1-nphamcs@gmail.com>
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

Currently, zsmalloc has a hierarchy of locks, which includes a
pool-level migrate_lock, and a lock for each size class. We have to
obtain both locks in the hotpath in most cases anyway, except for
zs_malloc. This exception will no longer exist when we introduce a LRU
into the zs_pool for the new writeback functionality - we will need to
obtain a pool-level lock to synchronize LRU handling even in zs_malloc.

In preparation for zsmalloc writeback, consolidate these locks into a
single pool-level lock, which drastically reduces the complexity of
synchronization in zsmalloc.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zsmalloc.c | 87 ++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 50 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d03941cace2c..326faa751f0a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -33,8 +33,7 @@
 /*
  * lock ordering:
  *	page_lock
- *	pool->migrate_lock
- *	class->lock
+ *	pool->lock
  *	zspage->lock
  */
 
@@ -192,7 +191,6 @@ static const int fullness_threshold_frac = 4;
 static size_t huge_class_size;
 
 struct size_class {
-	spinlock_t lock;
 	struct list_head fullness_list[NR_ZS_FULLNESS];
 	/*
 	 * Size of objects stored in this class. Must be multiple
@@ -247,8 +245,7 @@ struct zs_pool {
 #ifdef CONFIG_COMPACTION
 	struct work_struct free_work;
 #endif
-	/* protect page/zspage migration */
-	rwlock_t migrate_lock;
+	spinlock_t lock;
 };
 
 struct zspage {
@@ -355,7 +352,7 @@ static void cache_free_zspage(struct zs_pool *pool, struct zspage *zspage)
 	kmem_cache_free(pool->zspage_cachep, zspage);
 }
 
-/* class->lock(which owns the handle) synchronizes races */
+/* pool->lock(which owns the handle) synchronizes races */
 static void record_obj(unsigned long handle, unsigned long obj)
 {
 	*(unsigned long *)handle = obj;
@@ -452,7 +449,7 @@ static __maybe_unused int is_first_page(struct page *page)
 	return PagePrivate(page);
 }
 
-/* Protected by class->lock */
+/* Protected by pool->lock */
 static inline int get_zspage_inuse(struct zspage *zspage)
 {
 	return zspage->inuse;
@@ -597,13 +594,13 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 		if (class->index != i)
 			continue;
 
-		spin_lock(&class->lock);
+		spin_lock(&pool->lock);
 		class_almost_full = zs_stat_get(class, CLASS_ALMOST_FULL);
 		class_almost_empty = zs_stat_get(class, CLASS_ALMOST_EMPTY);
 		obj_allocated = zs_stat_get(class, OBJ_ALLOCATED);
 		obj_used = zs_stat_get(class, OBJ_USED);
 		freeable = zs_can_compact(class);
-		spin_unlock(&class->lock);
+		spin_unlock(&pool->lock);
 
 		objs_per_zspage = class->objs_per_zspage;
 		pages_used = obj_allocated / objs_per_zspage *
@@ -916,7 +913,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 
 	get_zspage_mapping(zspage, &class_idx, &fg);
 
-	assert_spin_locked(&class->lock);
+	assert_spin_locked(&pool->lock);
 
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(fg != ZS_EMPTY);
@@ -1247,19 +1244,19 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	BUG_ON(in_interrupt());
 
 	/* It guarantees it can get zspage from handle safely */
-	read_lock(&pool->migrate_lock);
+	spin_lock(&pool->lock);
 	obj = handle_to_obj(handle);
 	obj_to_location(obj, &page, &obj_idx);
 	zspage = get_zspage(page);
 
 	/*
-	 * migration cannot move any zpages in this zspage. Here, class->lock
+	 * migration cannot move any zpages in this zspage. Here, pool->lock
 	 * is too heavy since callers would take some time until they calls
 	 * zs_unmap_object API so delegate the locking from class to zspage
 	 * which is smaller granularity.
 	 */
 	migrate_read_lock(zspage);
-	read_unlock(&pool->migrate_lock);
+	spin_unlock(&pool->lock);
 
 	class = zspage_class(pool, zspage);
 	off = (class->size * obj_idx) & ~PAGE_MASK;
@@ -1412,8 +1409,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	size += ZS_HANDLE_SIZE;
 	class = pool->size_class[get_size_class_index(size)];
 
-	/* class->lock effectively protects the zpage migration */
-	spin_lock(&class->lock);
+	/* pool->lock effectively protects the zpage migration */
+	spin_lock(&pool->lock);
 	zspage = find_get_zspage(class);
 	if (likely(zspage)) {
 		obj = obj_malloc(pool, zspage, handle);
@@ -1421,12 +1418,12 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		fix_fullness_group(class, zspage);
 		record_obj(handle, obj);
 		class_stat_inc(class, OBJ_USED, 1);
-		spin_unlock(&class->lock);
+		spin_unlock(&pool->lock);
 
 		return handle;
 	}
 
-	spin_unlock(&class->lock);
+	spin_unlock(&pool->lock);
 
 	zspage = alloc_zspage(pool, class, gfp);
 	if (!zspage) {
@@ -1434,7 +1431,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		return (unsigned long)ERR_PTR(-ENOMEM);
 	}
 
-	spin_lock(&class->lock);
+	spin_lock(&pool->lock);
 	obj = obj_malloc(pool, zspage, handle);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
@@ -1447,7 +1444,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
-	spin_unlock(&class->lock);
+	spin_unlock(&pool->lock);
 
 	return handle;
 }
@@ -1491,16 +1488,14 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 		return;
 
 	/*
-	 * The pool->migrate_lock protects the race with zpage's migration
+	 * The pool->lock protects the race with zpage's migration
 	 * so it's safe to get the page from handle.
 	 */
-	read_lock(&pool->migrate_lock);
+	spin_lock(&pool->lock);
 	obj = handle_to_obj(handle);
 	obj_to_page(obj, &f_page);
 	zspage = get_zspage(f_page);
 	class = zspage_class(pool, zspage);
-	spin_lock(&class->lock);
-	read_unlock(&pool->migrate_lock);
 
 	obj_free(class->size, obj);
 	class_stat_dec(class, OBJ_USED, 1);
@@ -1510,7 +1505,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 
 	free_zspage(pool, class, zspage);
 out:
-	spin_unlock(&class->lock);
+	spin_unlock(&pool->lock);
 	cache_free_handle(pool, handle);
 }
 EXPORT_SYMBOL_GPL(zs_free);
@@ -1867,16 +1862,12 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	pool = zspage->pool;
 
 	/*
-	 * The pool migrate_lock protects the race between zpage migration
+	 * The pool's lock protects the race between zpage migration
 	 * and zs_free.
 	 */
-	write_lock(&pool->migrate_lock);
+	spin_lock(&pool->lock);
 	class = zspage_class(pool, zspage);
 
-	/*
-	 * the class lock protects zpage alloc/free in the zspage.
-	 */
-	spin_lock(&class->lock);
 	/* the migrate_write_lock protects zpage access via zs_map_object */
 	migrate_write_lock(zspage);
 
@@ -1906,10 +1897,9 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 	replace_sub_page(class, zspage, newpage, page);
 	/*
 	 * Since we complete the data copy and set up new zspage structure,
-	 * it's okay to release migration_lock.
+	 * it's okay to release the pool's lock.
 	 */
-	write_unlock(&pool->migrate_lock);
-	spin_unlock(&class->lock);
+	spin_unlock(&pool->lock);
 	dec_zspage_isolation(zspage);
 	migrate_write_unlock(zspage);
 
@@ -1964,9 +1954,9 @@ static void async_free_zspage(struct work_struct *work)
 		if (class->index != i)
 			continue;
 
-		spin_lock(&class->lock);
+		spin_lock(&pool->lock);
 		list_splice_init(&class->fullness_list[ZS_EMPTY], &free_pages);
-		spin_unlock(&class->lock);
+		spin_unlock(&pool->lock);
 	}
 
 	list_for_each_entry_safe(zspage, tmp, &free_pages, list) {
@@ -1976,9 +1966,9 @@ static void async_free_zspage(struct work_struct *work)
 		get_zspage_mapping(zspage, &class_idx, &fullness);
 		VM_BUG_ON(fullness != ZS_EMPTY);
 		class = pool->size_class[class_idx];
-		spin_lock(&class->lock);
+		spin_lock(&pool->lock);
 		__free_zspage(pool, class, zspage);
-		spin_unlock(&class->lock);
+		spin_unlock(&pool->lock);
 	}
 };
 
@@ -2039,10 +2029,11 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 	struct zspage *dst_zspage = NULL;
 	unsigned long pages_freed = 0;
 
-	/* protect the race between zpage migration and zs_free */
-	write_lock(&pool->migrate_lock);
-	/* protect zpage allocation/free */
-	spin_lock(&class->lock);
+	/*
+	 * protect the race between zpage migration and zs_free
+	 * as well as zpage allocation/free
+	 */
+	spin_lock(&pool->lock);
 	while ((src_zspage = isolate_zspage(class, true))) {
 		/* protect someone accessing the zspage(i.e., zs_map_object) */
 		migrate_write_lock(src_zspage);
@@ -2067,7 +2058,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 			putback_zspage(class, dst_zspage);
 			migrate_write_unlock(dst_zspage);
 			dst_zspage = NULL;
-			if (rwlock_is_contended(&pool->migrate_lock))
+			if (spin_is_contended(&pool->lock))
 				break;
 		}
 
@@ -2084,11 +2075,9 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 			pages_freed += class->pages_per_zspage;
 		} else
 			migrate_write_unlock(src_zspage);
-		spin_unlock(&class->lock);
-		write_unlock(&pool->migrate_lock);
+		spin_unlock(&pool->lock);
 		cond_resched();
-		write_lock(&pool->migrate_lock);
-		spin_lock(&class->lock);
+		spin_lock(&pool->lock);
 	}
 
 	if (src_zspage) {
@@ -2096,8 +2085,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		migrate_write_unlock(src_zspage);
 	}
 
-	spin_unlock(&class->lock);
-	write_unlock(&pool->migrate_lock);
+	spin_unlock(&pool->lock);
 
 	return pages_freed;
 }
@@ -2200,7 +2188,7 @@ struct zs_pool *zs_create_pool(const char *name)
 		return NULL;
 
 	init_deferred_free(pool);
-	rwlock_init(&pool->migrate_lock);
+	spin_lock_init(&pool->lock);
 
 	pool->name = kstrdup(name, GFP_KERNEL);
 	if (!pool->name)
@@ -2271,7 +2259,6 @@ struct zs_pool *zs_create_pool(const char *name)
 		class->index = i;
 		class->pages_per_zspage = pages_per_zspage;
 		class->objs_per_zspage = objs_per_zspage;
-		spin_lock_init(&class->lock);
 		pool->size_class[i] = class;
 		for (fullness = ZS_EMPTY; fullness < NR_ZS_FULLNESS;
 							fullness++)
-- 
2.30.2

