Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17504621D0D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 20:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiKHTc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 14:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiKHTcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 14:32:19 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC83686A8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 11:32:15 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p21so15053045plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 11:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9GdtafRH6I7WJFplWbRa+/LvLJ2SebdW8/3k5nqMJE=;
        b=HeLL9pUugyXL5l0vJmPh14x5FwOgG3uFcYxeXa4LAo6tlK5H6qwemLrVzMepGwwSbL
         1XSM5LB89hqDUXKTn7nCxIW9mS9P+Fe2hhT5km3fqjRlfguiMwcKbiHynvfkmJ9x9eCp
         2UW/Hmjpptv33NN6V41v1KgtmlBiMMniXhTarWPs9j0tpMUKnDeCo6gMrz1XoGZZEINO
         wOOf4F60w7GPAOUa25LvijmcrYvjUa4HjQ8F1QCneyl7ZxCvqTIRTpSrXvWldTTcF0F1
         dZ1PG/HKAd3fjeRPnS9ryrPYz86a9yMqpQJ/JN/wm6FSSywU/aHvaIwS+kHU46rflNAm
         mZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9GdtafRH6I7WJFplWbRa+/LvLJ2SebdW8/3k5nqMJE=;
        b=gqy/a2V4rhj1OlTHKeq7r9x5/cl9jHd9o6/TIBvL9Cn4SDGnOsAoT3bHyqseExIEvT
         e7J3dmzFhEYTt3s2PoOaSDJjY9jZirhfdZKv/2d5eOGT535FGbHfiSA7WAhucMjA6mTx
         8jM0Trm5s47Xa51jf1whSpOyG/mIhT/LVwIDWjkdaBbUtPGs/jt+7WicN+PvjDPgxvYh
         FlfppfGZWkSFWLgFUiJgUaRdRSZBlq0P/pXXRXqJshh930uMLC4Xf/eN2u6kE6rmjJSz
         U2wSvuWq50II3w31ypiC49zpg8HBhKcCmhrqwfxt6/cpuZfthZvEsCiYcDX+JKRbEt0V
         iwrQ==
X-Gm-Message-State: ACrzQf3o+e24+Ta20LWSxZq5kHN7yX7uaWZwSPde3483VjG+QmRLKInq
        okLCAQB8UROJ64hRxeX3dW8=
X-Google-Smtp-Source: AMsMyM6K4/C2Ik5EpREYYXKM/B0EMSr9bK+hu2eaeAuEVB8LWrEeBb5yowdbVV2ZpD+JBf667t4c4Q==
X-Received: by 2002:a17:902:ced1:b0:186:b18a:d0d5 with SMTP id d17-20020a170902ced100b00186b18ad0d5mr58143806plg.60.1667935934513;
        Tue, 08 Nov 2022 11:32:14 -0800 (PST)
Received: from localhost (fwdproxy-prn-023.fbsv.net. [2a03:2880:ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id d16-20020a170902ced000b0017f49b41c12sm7337665plg.173.2022.11.08.11.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 11:32:14 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v3 5/5] zsmalloc: Implement writeback mechanism for zsmalloc
Date:   Tue,  8 Nov 2022 11:32:07 -0800
Message-Id: <20221108193207.3297327-6-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108193207.3297327-1-nphamcs@gmail.com>
References: <20221108193207.3297327-1-nphamcs@gmail.com>
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
 mm/zsmalloc.c | 200 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 185 insertions(+), 15 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index ac86cffa62cd..3868ad3cd038 100644
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
@@ -446,6 +447,27 @@ static void zs_zpool_free(void *pool, unsigned long handle)
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
@@ -484,6 +506,7 @@ static struct zpool_driver zs_zpool_driver = {
 	.malloc_support_movable = true,
 	.malloc =		  zs_zpool_malloc,
 	.free =			  zs_zpool_free,
+	.shrink =		  zs_zpool_shrink,
 	.map =			  zs_zpool_map,
 	.unmap =		  zs_zpool_unmap,
 	.total_size =		  zs_zpool_total_size,
@@ -957,6 +980,21 @@ static int trylock_zspage(struct zspage *zspage)
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
@@ -971,6 +1009,9 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(fg != ZS_EMPTY);

+	/* Free all deferred handles from zs_free */
+	free_handles(pool, zspage);
+
 	next = page = get_first_page(zspage);
 	do {
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
@@ -1053,6 +1094,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
 	}

 	INIT_LIST_HEAD(&zspage->lru);
+	zspage->under_reclaim = false;
+	zspage->deferred_handles = NULL;

 	set_freeobj(zspage, 0);
 }
@@ -1474,11 +1517,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
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
@@ -1502,6 +1542,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)

 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
+
+out:
 	/* Move the zspage to front of pool's LRU */
 	move_to_front(pool, zspage);
 	spin_unlock(&pool->lock);
@@ -1559,12 +1601,24 @@ void zs_free(struct zs_pool *pool, unsigned long handle)

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
@@ -1764,7 +1818,7 @@ static enum fullness_group putback_zspage(struct size_class *class,
 	return fullness;
 }

-#ifdef CONFIG_COMPACTION
+#if defined(CONFIG_ZPOOL) || defined(CONFIG_COMPACTION)
 /*
  * To prevent zspage destroy during migration, zspage freeing should
  * hold locks of all pages in the zspage.
@@ -1806,6 +1860,24 @@ static void lock_zspage(struct zspage *zspage)
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
@@ -1822,6 +1894,7 @@ static void migrate_read_unlock(struct zspage *zspage) __releases(&zspage->lock)
 	read_unlock(&zspage->lock);
 }

+#ifdef CONFIG_COMPACTION
 static void migrate_write_lock(struct zspage *zspage)
 {
 	write_lock(&zspage->lock);
@@ -2382,6 +2455,103 @@ void zs_destroy_pool(struct zs_pool *pool)
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
