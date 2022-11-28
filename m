Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2985563B201
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbiK1TQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiK1TQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:16:23 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2237B2A72C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:16:22 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 140so11463851pfz.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExG6lmT8dvWnpflTbpJM8HrOLYrR6VJHXI/Psqh0C0Y=;
        b=V60CBauNQzHEVrccaqhf87xf1fx0GsfzOJp+uXFsGzNU9ke01CDJ72B+QiN383k4sN
         VzkeTtN8xmGe9Xg12SCCtlz1eiwsiiLgh1bAuLN3gqqrytVEuW3OQ2+8e39KvtBM+amQ
         Zv4pFO0JddjSEykJXKsPct2PEqIZR/59Q0QDZgglRkWAsYH2MfeMr1MMPa3Jv9e0FvNS
         3YFvxAYoQQywUgV66RmkdZfTM681Pw7z2n8FBY2xD0Zq+ii+Pffn/1WvBhdxu65FoqMA
         3SLZwXKjtvTXTBrCep/jz0IHPt5vaoQhDp+U5LX17w2kUKkY3rarVuACRIexGe8Scw/7
         t1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExG6lmT8dvWnpflTbpJM8HrOLYrR6VJHXI/Psqh0C0Y=;
        b=YFS7kudlNRdaMLCKQq6qN4O6gLzSARw6sNyc5I3xx8YwoxRfRlO1Y0fY7xOIwsZEeu
         oxefDkeqB1PFgi2XNqd4AwgN133OnFPs9UAnczgwzb3DQRHAbr4f9g41hH/QEPPNsalg
         fBrnugjntEiMcPWRXKFU7nq+bw/AgX/hnS2NNk2aFhT1BZdEW4TBXu3syDiqobOH5Nzs
         FCMlw7G4+BqSrsvRNhmffbw8txJ4U+cohhybTRUGONL927oOPq/B8vHJ8ttUBMgvlnd6
         eyu76mWtadApJ7Jk30yadD3NO5ILQoPePCS0nPalFsMffGq8HKmjCSwIbx53sK+/WIxp
         /Dog==
X-Gm-Message-State: ANoB5pkjIkhv2LfyKM9RGPxJ/tp7LJKsRhjvlbZKOcmnE0K5SsXPde9U
        EYyiaBbIrmVPIITQ9waRofeMNMBXOUdNIw==
X-Google-Smtp-Source: AA0mqf41zUPopT41Ye2wflSu0jpR4ajnaER/TTyeS8LpLd5LGtmwd9kTxrcY7FfpL5RjNzFtjruwsQ==
X-Received: by 2002:aa7:8595:0:b0:574:3ccd:a468 with SMTP id w21-20020aa78595000000b005743ccda468mr28783409pfn.61.1669662981505;
        Mon, 28 Nov 2022 11:16:21 -0800 (PST)
Received: from localhost (fwdproxy-prn-010.fbsv.net. [2a03:2880:ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id w8-20020a17090a1b8800b001f94d25bfabsm9932074pjc.28.2022.11.28.11.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 11:16:20 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v7 3/6] zsmalloc: Consolidate zs_pool's migrate_lock and size_class's locks
Date:   Mon, 28 Nov 2022 11:16:12 -0800
Message-Id: <20221128191616.1261026-4-nphamcs@gmail.com>
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

Currently, zsmalloc has a hierarchy of locks, which includes a
pool-level migrate_lock, and a lock for each size class. We have to
obtain both locks in the hotpath in most cases anyway, except for
zs_malloc. This exception will no longer exist when we introduce a LRU
into the zs_pool for the new writeback functionality - we will need to
obtain a pool-level lock to synchronize LRU handling even in zs_malloc.

In preparation for zsmalloc writeback, consolidate these locks into a
single pool-level lock, which drastically reduces the complexity of
synchronization in zsmalloc.

We have also benchmarked the lock consolidation to see the performance
effect of this change on zram.

First, we ran a synthetic FS workload on a server machine with 36 cores
(same machine for all runs), using

fs_mark  -d  ../zram1mnt  -s  100000  -n  2500  -t  32  -k

before and after for btrfs and ext4 on zram (FS usage is 80%).

Here is the result (unit is file/second):

With lock consolidation (btrfs):
Average: 13520.2, Median: 13531.0, Stddev: 137.5961482019028

Without lock consolidation (btrfs):
Average: 13487.2, Median: 13575.0, Stddev: 309.08283679298665

With lock consolidation (ext4):
Average: 16824.4, Median: 16839.0, Stddev: 89.97388510006668

Without lock consolidation (ext4)
Average: 16958.0, Median: 16986.0, Stddev: 194.7370021336469

As you can see, we observe a 0.3% regression for btrfs, and a 0.9%
regression for ext4. This is a small, barely measurable difference in my
opinion.

For a more realistic scenario, we also tries building the kernel on zram.
Here is the time it takes (in seconds):

With lock consolidation (btrfs):
real
Average: 319.6, Median: 320.0, Stddev: 0.8944271909999159
user
Average: 6894.2, Median: 6895.0, Stddev: 25.528415540334656
sys
Average: 521.4, Median: 522.0, Stddev: 1.51657508881031

Without lock consolidation (btrfs):
real
Average: 319.8, Median: 320.0, Stddev: 0.8366600265340756
user
Average: 6896.6, Median: 6899.0, Stddev: 16.04057355583023
sys
Average: 520.6, Median: 521.0, Stddev: 1.140175425099138

With lock consolidation (ext4):
real
Average: 320.0, Median: 319.0, Stddev: 1.4142135623730951
user
Average: 6896.8, Median: 6878.0, Stddev: 28.621670111997307
sys
Average: 521.2, Median: 521.0, Stddev: 1.7888543819998317

Without lock consolidation (ext4)
real
Average: 319.6, Median: 319.0, Stddev: 0.8944271909999159
user
Average: 6886.2, Median: 6887.0, Stddev: 16.93221781102523
sys
Average: 520.4, Median: 520.0, Stddev: 1.140175425099138

The difference is entirely within the noise of a typical run on zram. This
hardly justifies the complexity of maintaining both the pool lock and
the class lock. In fact, for writeback, we would need to introduce yet
another lock to prevent data races on the pool's LRU, further
complicating the lock handling logic. IMHO, it is just better to
collapse all of these into a single pool-level lock.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/zsmalloc.c | 87 ++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 50 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 78feda34ad9a..5427a00a0518 100644
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
@@ -1268,19 +1265,19 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
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
@@ -1433,8 +1430,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	size += ZS_HANDLE_SIZE;
 	class = pool->size_class[get_size_class_index(size)];

-	/* class->lock effectively protects the zpage migration */
-	spin_lock(&class->lock);
+	/* pool->lock effectively protects the zpage migration */
+	spin_lock(&pool->lock);
 	zspage = find_get_zspage(class);
 	if (likely(zspage)) {
 		obj = obj_malloc(pool, zspage, handle);
@@ -1442,12 +1439,12 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
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
@@ -1455,7 +1452,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		return (unsigned long)ERR_PTR(-ENOMEM);
 	}

-	spin_lock(&class->lock);
+	spin_lock(&pool->lock);
 	obj = obj_malloc(pool, zspage, handle);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
@@ -1468,7 +1465,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)

 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
-	spin_unlock(&class->lock);
+	spin_unlock(&pool->lock);

 	return handle;
 }
@@ -1512,16 +1509,14 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
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
@@ -1531,7 +1526,7 @@ void zs_free(struct zs_pool *pool, unsigned long handle)

 	free_zspage(pool, class, zspage);
 out:
-	spin_unlock(&class->lock);
+	spin_unlock(&pool->lock);
 	cache_free_handle(pool, handle);
 }
 EXPORT_SYMBOL_GPL(zs_free);
@@ -1888,16 +1883,12 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
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

@@ -1927,10 +1918,9 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
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

@@ -1985,9 +1975,9 @@ static void async_free_zspage(struct work_struct *work)
 		if (class->index != i)
 			continue;

-		spin_lock(&class->lock);
+		spin_lock(&pool->lock);
 		list_splice_init(&class->fullness_list[ZS_EMPTY], &free_pages);
-		spin_unlock(&class->lock);
+		spin_unlock(&pool->lock);
 	}

 	list_for_each_entry_safe(zspage, tmp, &free_pages, list) {
@@ -1997,9 +1987,9 @@ static void async_free_zspage(struct work_struct *work)
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

@@ -2060,10 +2050,11 @@ static unsigned long __zs_compact(struct zs_pool *pool,
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
@@ -2088,7 +2079,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 			putback_zspage(class, dst_zspage);
 			migrate_write_unlock(dst_zspage);
 			dst_zspage = NULL;
-			if (rwlock_is_contended(&pool->migrate_lock))
+			if (spin_is_contended(&pool->lock))
 				break;
 		}

@@ -2105,11 +2096,9 @@ static unsigned long __zs_compact(struct zs_pool *pool,
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
@@ -2117,8 +2106,7 @@ static unsigned long __zs_compact(struct zs_pool *pool,
 		migrate_write_unlock(src_zspage);
 	}

-	spin_unlock(&class->lock);
-	write_unlock(&pool->migrate_lock);
+	spin_unlock(&pool->lock);

 	return pages_freed;
 }
@@ -2221,7 +2209,7 @@ struct zs_pool *zs_create_pool(const char *name)
 		return NULL;

 	init_deferred_free(pool);
-	rwlock_init(&pool->migrate_lock);
+	spin_lock_init(&pool->lock);

 	pool->name = kstrdup(name, GFP_KERNEL);
 	if (!pool->name)
@@ -2292,7 +2280,6 @@ struct zs_pool *zs_create_pool(const char *name)
 		class->index = i;
 		class->pages_per_zspage = pages_per_zspage;
 		class->objs_per_zspage = objs_per_zspage;
-		spin_lock_init(&class->lock);
 		pool->size_class[i] = class;
 		for (fullness = ZS_EMPTY; fullness < NR_ZS_FULLNESS;
 							fullness++)
--
2.30.2
