Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD3462E227
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbiKQQjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiKQQi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:38:57 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C267819D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:38:48 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p21so2114842plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYWORxAy79T9WSWxF/CzcXujG+zLBtFc0XTbXyObrLk=;
        b=cxoxzA1yR0JaEcjtU7/sl5d2AWPjbyN5aOS8lYZ4bai+Z+XDdRAtGrSYARtZzd+1cY
         ZWH39uulSUzkCQGhLtKeairHXCRc6rkUM09SU6GptTcoXjZxBuM+SMbWbzyin4tVEzf/
         zJ3Pji1h80X7w9GZG8QKUW/EPJDpAJLrjUTbj1QJ5N3Mkz49EBn41LC/YiovSlPHCxhb
         mu6MrNkCYoYlTIwbAh0OU0DSpNzizg5v874pHUqkIRKLnwVgkMpiUA8x+kEtPSxOqXtN
         7yVsFRxSEgER6zooRBZfUO1wolw9tCxG82Z3TTRGZgYpBMrB0xMLRrJRuIa6i7Hq/TO8
         3kZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYWORxAy79T9WSWxF/CzcXujG+zLBtFc0XTbXyObrLk=;
        b=lZarqQ9GEdnJy8jXMBRJYYs/SuWrpwkbLjSwhD660QE9FMFKknSZqwUrKQU4kXxIDd
         HX4piVioERt+zjAjyTISIqDrsMplpMtfODlyxX8LEKsJRaTiW1Ksph+I9uAUuuNnjqnN
         np6cVRrmQaplZyAskumuiwcNsKmETvirXvgwq9Rvpucm3yUYv8zDlXVTr9xTzzn9eEDv
         JjaJqMKt3/jFKxWNIRjmJJsIaIhwhfsE08GiQws+t9wQF9xwcm8Yv23e+g1IyVTEbOTE
         uaKtN4B2Wcv3HVn/69nrE8Bh1SpO/HzfSDykSfRkqWt9Cp/vIkxjrTz4yD9w8PIQeciP
         n4kQ==
X-Gm-Message-State: ANoB5pkEfKrp5G731mUI5B4zUykSYocg1N2+mEYheIHCn5lCwy8cUQXC
        BViTZ4WjkoSH1bkTxHA396Y=
X-Google-Smtp-Source: AA0mqf7fn8cu6fs/3fJDiIG2Radf7GNtZoRsfAylYg2J1YU0aHoQ+8MVjWntS4QeVlQ82OqGkAf7cQ==
X-Received: by 2002:a17:902:d355:b0:17f:6fee:3334 with SMTP id l21-20020a170902d35500b0017f6fee3334mr3662600plk.10.1668703128072;
        Thu, 17 Nov 2022 08:38:48 -0800 (PST)
Received: from localhost (fwdproxy-prn-012.fbsv.net. [2a03:2880:ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id m10-20020a634c4a000000b00476e84c3530sm1176069pgl.60.2022.11.17.08.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 08:38:47 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v4 5/5] zsmalloc: Implement writeback mechanism for zsmalloc
Date:   Thu, 17 Nov 2022 08:38:39 -0800
Message-Id: <20221117163839.230900-6-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221117163839.230900-1-nphamcs@gmail.com>
References: <20221117163839.230900-1-nphamcs@gmail.com>
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
 mm/zsmalloc.c | 203 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 184 insertions(+), 19 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 776d0e15a401..0ab9f173e964 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -280,10 +280,13 @@ struct zspage {
 	struct list_head lru;
 #endif

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
@@ -304,10 +307,11 @@ static bool ZsHugePage(struct zspage *zspage)
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
@@ -315,9 +319,6 @@ static void kick_deferred_free(struct zs_pool *pool);
 static void init_deferred_free(struct zs_pool *pool);
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage);
 #else
-static void migrate_lock_init(struct zspage *zspage) {}
-static void migrate_read_lock(struct zspage *zspage) {}
-static void migrate_read_unlock(struct zspage *zspage) {}
 static void migrate_write_lock(struct zspage *zspage) {}
 static void migrate_write_lock_nested(struct zspage *zspage) {}
 static void migrate_write_unlock(struct zspage *zspage) {}
@@ -449,6 +450,27 @@ static void zs_zpool_free(void *pool, unsigned long handle)
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
@@ -487,6 +509,7 @@ static struct zpool_driver zs_zpool_driver = {
 	.malloc_support_movable = true,
 	.malloc =		  zs_zpool_malloc,
 	.free =			  zs_zpool_free,
+	.shrink =		  zs_zpool_shrink,
 	.map =			  zs_zpool_map,
 	.unmap =		  zs_zpool_unmap,
 	.total_size =		  zs_zpool_total_size,
@@ -960,6 +983,21 @@ static int trylock_zspage(struct zspage *zspage)
 	return 0;
 }

+/*
+ * Free all the deferred handles whose objects are freed in zs_free.
+ */
+static void free_handles(struct zs_pool *pool, struct zspage *zspage)
+{
+	unsigned long handle = (unsigned long)zspage->deferred_handles;
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
@@ -974,6 +1012,9 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(fg != ZS_EMPTY);

+	/* Free all deferred handles from zs_free */
+	free_handles(pool, zspage);
+
 	next = page = get_first_page(zspage);
 	do {
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
@@ -1060,6 +1101,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 #ifdef CONFIG_ZPOOL
 	INIT_LIST_HEAD(&zspage->lru);
 #endif
+	zspage->under_reclaim = false;
+	zspage->deferred_handles = NULL;

 	set_freeobj(zspage, 0);
 }
@@ -1482,13 +1525,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 		record_obj(handle, obj);
 		class_stat_inc(class, OBJ_USED, 1);

-#ifdef CONFIG_ZPOOL
-		/* Move the zspage to front of pool's LRU */
-		move_to_front(pool, zspage);
-#endif
-		spin_unlock(&pool->lock);
-
-		return handle;
+		goto out;
 	}

 	spin_unlock(&pool->lock);
@@ -1512,12 +1549,12 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)

 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
+out:
 #ifdef CONFIG_ZPOOL
 	/* Move the zspage to front of pool's LRU */
 	move_to_front(pool, zspage);
 #endif
 	spin_unlock(&pool->lock);
-
 	return handle;
 }
 EXPORT_SYMBOL_GPL(zs_malloc);
@@ -1571,12 +1608,24 @@ void zs_free(struct zs_pool *pool, unsigned long handle)

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
+		record_obj(handle, (unsigned long)zspage->deferred_handles);
+		zspage->deferred_handles = (unsigned long *)handle;
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
@@ -1776,7 +1825,7 @@ static enum fullness_group putback_zspage(struct size_class *class,
 	return fullness;
 }

-#ifdef CONFIG_COMPACTION
+#if defined(CONFIG_ZPOOL) || defined(CONFIG_COMPACTION)
 /*
  * To prevent zspage destroy during migration, zspage freeing should
  * hold locks of all pages in the zspage.
@@ -1818,6 +1867,24 @@ static void lock_zspage(struct zspage *zspage)
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
@@ -1834,6 +1901,7 @@ static void migrate_read_unlock(struct zspage *zspage) __releases(&zspage->lock)
 	read_unlock(&zspage->lock);
 }

+#ifdef CONFIG_COMPACTION
 static void migrate_write_lock(struct zspage *zspage)
 {
 	write_lock(&zspage->lock);
@@ -2398,6 +2466,103 @@ void zs_destroy_pool(struct zs_pool *pool)
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
+	if (retries == 0 || !pool->ops || !pool->ops->evict)
+		return -EINVAL;
+
+	/* Lock LRU and fullness list */
+	spin_lock(&pool->lock);
+	if (list_empty(&pool->lru)) {
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
+		class = zspage_class(pool, zspage);
+		fullness = get_fullness_group(class, zspage);
+
+		/* Lock out object allocations and object compaction */
+		remove_zspage(class, zspage, fullness);
+
+		spin_unlock(&pool->lock);
+
+		/* Lock backing pages into place */
+		lock_zspage(zspage);
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
