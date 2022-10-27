Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B3A61002F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiJ0S2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236083AbiJ0S1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:27:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6ED6C13F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:27:38 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h14so2377115pjv.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 11:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Qxnn32E7K5fwG9qlmrZunwYIr7QPfqQTj55cuv2KBQ=;
        b=j08rv24OOEXcxpceWztypi4enl6vYap7/LCyvJlDGi5XHxryZ/3c9V/GlNghTtlxlx
         alEHEIo8QqKASrCERkW+yaZ4lDPbrGSZYJCPOIPEDfLH51u0WfIY/c92LZ1budH4KXKI
         tRKuMB9sDJ6cAm2n/Nsn4YHjeWY59gBzs9oAfBXYHp8Tem4kileLDEXvVRKmjfEvrUMi
         zig/w2kGfSfEA+JGOkfZIrdBTEz4JSr+H/sIoOdtLlZiasmXa6u1cgykBC+Fnrq1j4/O
         bZGQcHNZg2W1ATgSyCeUhekeanGCxd1sYBlbhZZ0uGtnKX1iMkJJ1J+Gx3AgmyF8BM4Z
         3sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Qxnn32E7K5fwG9qlmrZunwYIr7QPfqQTj55cuv2KBQ=;
        b=kf18Iful5c4/Nqz2bqC1fw5T3WCmvow7aMtY1xjh9onbII/+LHWZPZzreGa1QRCSLq
         9Ss4GHLkEcjd5aUNOwMNAfcU1CUQY8In9XhMG8Cb6X9TUJzgFyKh6ousFaSUVZ4mHaGf
         q4cditKxeRAgQjStyRE25QSaSwX9+JGyrvbaF0b066tcWN4wcB0bfxh0bo65ZsGItXdz
         WwDsKsYSKL/MioIZiD8VXTxHYkmzFK61I7myPS4+YB8JaJEaMMJWKuME7cz3jJlpA2UU
         MfrPPey1ThW8/WK3kl3HGdFIeJkWaIzCnS8V7pP06WVolKxIFCAe0dN8+iwJGQf5ROpM
         8YgQ==
X-Gm-Message-State: ACrzQf2rOZOVOH+UboXgFdZxVz/eDoGbQpayIZg/5GB26MVPNibhjkQF
        9GFAuq4ONHwf7Em6OmM6IJU=
X-Google-Smtp-Source: AMsMyM47O2hvIbiuCpnRdUYdGDJI4DkeCeXJuoYiMGVR2dQZJKzAveWbsKTWxadv2EkXL19czJgdvQ==
X-Received: by 2002:a17:90b:3ecc:b0:20d:9da6:56cd with SMTP id rm12-20020a17090b3ecc00b0020d9da656cdmr11288436pjb.246.1666895257962;
        Thu, 27 Oct 2022 11:27:37 -0700 (PDT)
Received: from localhost (fwdproxy-prn-017.fbsv.net. [2a03:2880:ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id a15-20020a1709027e4f00b0017f5c7d3931sm1456339pln.282.2022.10.27.11.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 11:27:37 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v2 5/5] zsmalloc: Implement writeback mechanism for zsmalloc
Date:   Thu, 27 Oct 2022 11:27:36 -0700
Message-Id: <20221027182736.513530-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <202210272158.7swYwd23-lkp@intel.com>
References: <202210272158.7swYwd23-lkp@intel.com>
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

This commit adds the writeback mechanism for zsmalloc, analogous to the
zbud allocator. Zsmalloc will attempt to determine the coldest zspage
(i.e least recently used) in the pool, and attempt to write back all the
stored compressed objects via the pool's evict handler.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zsmalloc.c | 198 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 183 insertions(+), 15 deletions(-)

 Fix the issue reported by kernel test robot <lkp@intel.com>

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 76ff2ed839d0..f7fa69360dd9 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -279,10 +279,13 @@ struct zspage {
 	/* links the zspage to the lru list in the pool */
 	struct list_head lru;

+	bool under_reclaim;
+
+	/* list of unfreed handles whose objects have been reclaimed */
+	unsigned long *deferred_handles;
+
 	struct zs_pool *pool;
-#ifdef CONFIG_COMPACTION
 	rwlock_t lock;
-#endif
 };

 struct mapping_area {
@@ -303,10 +306,11 @@ static bool ZsHugePage(struct zspage *zspage)
 	return zspage->huge;
 }

-#ifdef CONFIG_COMPACTION
 static void migrate_lock_init(struct zspage *zspage);
 static void migrate_read_lock(struct zspage *zspage);
 static void migrate_read_unlock(struct zspage *zspage);
+
+#ifdef CONFIG_COMPACTION
 static void migrate_write_lock(struct zspage *zspage);
 static void migrate_write_lock_nested(struct zspage *zspage);
 static void migrate_write_unlock(struct zspage *zspage);
@@ -314,9 +318,6 @@ static void kick_deferred_free(struct zs_pool *pool);
 static void init_deferred_free(struct zs_pool *pool);
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage);
 #else
-static void migrate_lock_init(struct zspage *zspage) {}
-static void migrate_read_lock(struct zspage *zspage) {}
-static void migrate_read_unlock(struct zspage *zspage) {}
 static void migrate_write_lock(struct zspage *zspage) {}
 static void migrate_write_lock_nested(struct zspage *zspage) {}
 static void migrate_write_unlock(struct zspage *zspage) {}
@@ -444,6 +445,27 @@ static void zs_zpool_free(void *pool, unsigned long handle)
 	zs_free(pool, handle);
 }

+static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries);
+
+static int zs_zpool_shrink(void *pool, unsigned int pages,
+			unsigned int *reclaimed)
+{
+	unsigned int total = 0;
+	int ret = -EINVAL;
+
+	while (total < pages) {
+		ret = zs_reclaim_page(pool, 8);
+		if (ret < 0)
+			break;
+		total++;
+	}
+
+	if (reclaimed)
+		*reclaimed = total;
+
+	return ret;
+}
+
 static void *zs_zpool_map(void *pool, unsigned long handle,
 			enum zpool_mapmode mm)
 {
@@ -482,6 +504,7 @@ static struct zpool_driver zs_zpool_driver = {
 	.malloc_support_movable = true,
 	.malloc =		  zs_zpool_malloc,
 	.free =			  zs_zpool_free,
+	.shrink =     zs_zpool_shrink,
 	.map =			  zs_zpool_map,
 	.unmap =		  zs_zpool_unmap,
 	.total_size =		  zs_zpool_total_size,
@@ -955,6 +978,21 @@ static int trylock_zspage(struct zspage *zspage)
 	return 0;
 }

+/*
+ * Free all the deferred handles whose objects are freed in zs_free.
+ */
+static void free_handles(struct zs_pool *pool, struct zspage *zspage)
+{
+	unsigned long handle = (unsigned long) zspage->deferred_handles;
+
+	while (handle) {
+		unsigned long nxt_handle = handle_to_obj(handle);
+
+		cache_free_handle(pool, handle);
+		handle = nxt_handle;
+	}
+}
+
 static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 				struct zspage *zspage)
 {
@@ -969,6 +1007,9 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(fg != ZS_EMPTY);

+	/* Free all deferred handles from zs_free */
+	free_handles(pool, zspage);
+
 	next = page = get_first_page(zspage);
 	do {
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
@@ -1051,6 +1092,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 	}

 	INIT_LIST_HEAD(&zspage->lru);
+	zspage->under_reclaim = false;
+	zspage->deferred_handles = NULL;

 	set_freeobj(zspage, 0);
 }
@@ -1472,11 +1515,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		fix_fullness_group(class, zspage);
 		record_obj(handle, obj);
 		class_stat_inc(class, OBJ_USED, 1);
-		/* Move the zspage to front of pool's LRU */
-		move_to_front(pool, zspage);
-		spin_unlock(&pool->lock);

-		return handle;
+		goto out;
 	}

 	spin_unlock(&pool->lock);
@@ -1500,6 +1540,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)

 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
+
+out:
 	/* Move the zspage to front of pool's LRU */
 	move_to_front(pool, zspage);
 	spin_unlock(&pool->lock);
@@ -1557,12 +1599,24 @@ void zs_free(struct zs_pool *pool, unsigned long handle)

 	obj_free(class->size, obj);
 	class_stat_dec(class, OBJ_USED, 1);
+
+	if (zspage->under_reclaim) {
+		/*
+		 * Reclaim needs the handles during writeback. It'll free
+		 * them along with the zspage when it's done with them.
+		 *
+		 * Record current deferred handle at the memory location
+		 * whose address is given by handle.
+		 */
+		record_obj(handle, (unsigned long) zspage->deferred_handles);
+		zspage->deferred_handles = (unsigned long *) handle;
+		spin_unlock(&pool->lock);
+		return;
+	}
 	fullness = fix_fullness_group(class, zspage);
-	if (fullness != ZS_EMPTY)
-		goto out;
+	if (fullness == ZS_EMPTY)
+		free_zspage(pool, class, zspage);

-	free_zspage(pool, class, zspage);
-out:
 	spin_unlock(&pool->lock);
 	cache_free_handle(pool, handle);
 }
@@ -1762,7 +1816,7 @@ static enum fullness_group putback_zspage(struct size_class *class,
 	return fullness;
 }

-#ifdef CONFIG_COMPACTION
+#if defined(CONFIG_ZPOOL) || defined(CONFIG_COMPACTION)
 /*
  * To prevent zspage destroy during migration, zspage freeing should
  * hold locks of all pages in the zspage.
@@ -1804,6 +1858,24 @@ static void lock_zspage(struct zspage *zspage)
 	}
 	migrate_read_unlock(zspage);
 }
+#endif /* defined(CONFIG_ZPOOL) || defined(CONFIG_COMPACTION) */
+
+#ifdef CONFIG_ZPOOL
+/*
+ * Unlocks all the pages of the zspage.
+ *
+ * pool->lock must be held before this function is called
+ * to prevent the underlying pages from migrating.
+ */
+static void unlock_zspage(struct zspage *zspage)
+{
+	struct page *page = get_first_page(zspage);
+
+	do {
+		unlock_page(page);
+	} while ((page = get_next_page(page)) != NULL);
+}
+#endif /* CONFIG_ZPOOL */

 static void migrate_lock_init(struct zspage *zspage)
 {
@@ -1820,6 +1892,7 @@ static void migrate_read_unlock(struct zspage *zspage) __releases(&zspage->lock)
 	read_unlock(&zspage->lock);
 }

+#ifdef CONFIG_COMPACTION
 static void migrate_write_lock(struct zspage *zspage)
 {
 	write_lock(&zspage->lock);
@@ -2380,6 +2453,101 @@ void zs_destroy_pool(struct zs_pool *pool)
 }
 EXPORT_SYMBOL_GPL(zs_destroy_pool);

+#ifdef CONFIG_ZPOOL
+static int zs_reclaim_page(struct zs_pool *pool, unsigned int retries)
+{
+	int i, obj_idx, ret = 0;
+	unsigned long handle;
+	struct zspage *zspage;
+	struct page *page;
+	enum fullness_group fullness;
+
+	/* Lock LRU and fullness list */
+	spin_lock(&pool->lock);
+	if (!pool->ops || !pool->ops->evict || list_empty(&pool->lru) ||
+			retries == 0) {
+		spin_unlock(&pool->lock);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < retries; i++) {
+		struct size_class *class;
+
+		zspage = list_last_entry(&pool->lru, struct zspage, lru);
+		list_del(&zspage->lru);
+
+		/* zs_free may free objects, but not the zspage and handles */
+		zspage->under_reclaim = true;
+
+		/* Lock backing pages into place */
+		lock_zspage(zspage);
+
+		class = zspage_class(pool, zspage);
+		fullness = get_fullness_group(class, zspage);
+
+		/* Lock out object allocations and object compaction */
+		remove_zspage(class, zspage, fullness);
+
+		spin_unlock(&pool->lock);
+
+		obj_idx = 0;
+		page = zspage->first_page;
+		while (1) {
+			handle = find_alloced_obj(class, page, &obj_idx);
+			if (!handle) {
+				page = get_next_page(page);
+				if (!page)
+					break;
+				obj_idx = 0;
+				continue;
+			}
+
+			/*
+			 * This will write the object and call
+			 * zs_free.
+			 *
+			 * zs_free will free the object, but the
+			 * under_reclaim flag prevents it from freeing
+			 * the zspage altogether. This is necessary so
+			 * that we can continue working with the
+			 * zspage potentially after the last object
+			 * has been freed.
+			 */
+			ret = pool->ops->evict(pool, handle);
+			if (ret)
+				goto next;
+
+			obj_idx++;
+		}
+
+next:
+		/* For freeing the zspage, or putting it back in the pool and LRU list. */
+		spin_lock(&pool->lock);
+		zspage->under_reclaim = false;
+
+		if (!get_zspage_inuse(zspage)) {
+			/*
+			 * Fullness went stale as zs_free() won't touch it
+			 * while the page is removed from the pool. Fix it
+			 * up for the check in __free_zspage().
+			 */
+			zspage->fullness = ZS_EMPTY;
+
+			__free_zspage(pool, class, zspage);
+			spin_unlock(&pool->lock);
+			return 0;
+		}
+
+		putback_zspage(class, zspage);
+		list_add(&zspage->lru, &pool->lru);
+		unlock_zspage(zspage);
+	}
+
+	spin_unlock(&pool->lock);
+	return -EAGAIN;
+}
+#endif /* CONFIG_ZPOOL */
+
 static int __init zs_init(void)
 {
 	int ret;
--
2.30.2
