Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B2763B20B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiK1TQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiK1TQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:16:27 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032E92A736
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:16:25 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id w129so11454523pfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 11:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4gi1oG2jocLUE4hkXZ/M31m4aC6HWi7g5/rCEC+57M=;
        b=FGM0jY3WNm+ApgBJGMPpYq7TVSQbR2kUx0BMOXpRfUckWD9UKFecYNRwtU3znkUFd+
         jgovPgGYP96PGP/C0sUG/6ptMDPQ6wfR/RicLLaJLSWkJfQ4B4FogNMhx/lUzMeKcqlZ
         Q851rePp9nEIoe79Ioro4je17Z2PG3pVQ19e0W7I9o+YDgndV7OXTg0+sYt2aD23UjPA
         lFtuuA/a8a3ascu2MNPfRoS8pSQi16a7yQVIK9uxbvloeC5/vzObjTcNux+wf67KO5NC
         FYT2vIQ2f4UM9DFOGbEj1dPMcSK7a9kDtJQalCuOGE5rT1jNU2X5/mADTUi36NZqTfwS
         Pg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4gi1oG2jocLUE4hkXZ/M31m4aC6HWi7g5/rCEC+57M=;
        b=UZ/d2CXTEISMMAihHD2r6MY/tG2C/u/u6SdR0aH2XBUB9b9BHJT/ra2mjUpZ671GdE
         sS/zv5j39HRJo6yyBKO72yu0JhfrAaBxf0dyRpKm1GRZxEy1mgKSfa7+eZ2VpO06JaIu
         iGUj1p2oz5+vRlw0oMf0ubTD6nCfhBRYv+s87MfUQiN5uk/v7s14ozIkH2IlAj4NQKuM
         3Vk7IhkA/YwaFP0AQ3ybMVkXgQchcdMYwmpwjEu806KP6GaF+8Db3GRka3bpWD54tsta
         YBMmHeG4Wdbifqd+zm0ddpvXMsA04ds8CE2RIF0qW8VqHwPyhKpar9kyZZDLCCPXLLIb
         hkEg==
X-Gm-Message-State: ANoB5pkCUks5QLKmQ10v1jcQZeit1tGKRvc6dPrS4mlvyVjFrPsEnWCo
        sdyiwO5HnU7S5AV3cSN9XHE=
X-Google-Smtp-Source: AA0mqf4k+8ejpzi+51JV8sGSjHrlAuQjlPDP9ehqDk2GJ9wAQScXid4TygsdVRkzUkcpqiUJDtCOWg==
X-Received: by 2002:aa7:8595:0:b0:574:3ccd:a468 with SMTP id w21-20020aa78595000000b005743ccda468mr28783695pfn.61.1669662985347;
        Mon, 28 Nov 2022 11:16:25 -0800 (PST)
Received: from localhost (fwdproxy-prn-012.fbsv.net. [2a03:2880:ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id u143-20020a627995000000b0056cee8af3a5sm8436415pfc.29.2022.11.28.11.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 11:16:24 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v7 6/6] zsmalloc: Implement writeback mechanism for zsmalloc
Date:   Mon, 28 Nov 2022 11:16:15 -0800
Message-Id: <20221128191616.1261026-7-nphamcs@gmail.com>
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

This commit adds the writeback mechanism for zsmalloc, analogous to the
zbud allocator. Zsmalloc will attempt to determine the coldest zspage
(i.e least recently used) in the pool, and attempt to write back all the
stored compressed objects via the pool's evict handler.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zsmalloc.c | 194 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 183 insertions(+), 11 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index d06f9150b9da..9445bee6b014 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -271,12 +271,13 @@ struct zspage {
 #ifdef CONFIG_ZPOOL
 	/* links the zspage to the lru list in the pool */
 	struct list_head lru;
+	bool under_reclaim;
+	/* list of unfreed handles whose objects have been reclaimed */
+	unsigned long *deferred_handles;
 #endif

 	struct zs_pool *pool;
-#ifdef CONFIG_COMPACTION
 	rwlock_t lock;
-#endif
 };

 struct mapping_area {
@@ -297,10 +298,11 @@ static bool ZsHugePage(struct zspage *zspage)
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
@@ -308,9 +310,6 @@ static void kick_deferred_free(struct zs_pool *pool);
 static void init_deferred_free(struct zs_pool *pool);
 static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage);
 #else
-static void migrate_lock_init(struct zspage *zspage) {}
-static void migrate_read_lock(struct zspage *zspage) {}
-static void migrate_read_unlock(struct zspage *zspage) {}
 static void migrate_write_lock(struct zspage *zspage) {}
 static void migrate_write_lock_nested(struct zspage *zspage) {}
 static void migrate_write_unlock(struct zspage *zspage) {}
@@ -413,6 +412,27 @@ static void zs_zpool_free(void *pool, unsigned long handle)
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
@@ -451,6 +471,7 @@ static struct zpool_driver zs_zpool_driver = {
 	.malloc_support_movable = true,
 	.malloc =		  zs_zpool_malloc,
 	.free =			  zs_zpool_free,
+	.shrink =		  zs_zpool_shrink,
 	.map =			  zs_zpool_map,
 	.unmap =		  zs_zpool_unmap,
 	.total_size =		  zs_zpool_total_size,
@@ -924,6 +945,25 @@ static int trylock_zspage(struct zspage *zspage)
 	return 0;
 }

+#ifdef CONFIG_ZPOOL
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
+#else
+static inline void free_handles(struct zs_pool *pool, struct zspage *zspage) {}
+#endif
+
 static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 				struct zspage *zspage)
 {
@@ -938,6 +978,9 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(fg != ZS_EMPTY);

+	/* Free all deferred handles from zs_free */
+	free_handles(pool, zspage);
+
 	next = page = get_first_page(zspage);
 	do {
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
@@ -1023,6 +1066,8 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)

 #ifdef CONFIG_ZPOOL
 	INIT_LIST_HEAD(&zspage->lru);
+	zspage->under_reclaim = false;
+	zspage->deferred_handles = NULL;
 #endif

 	set_freeobj(zspage, 0);
@@ -1572,12 +1617,26 @@ void zs_free(struct zs_pool *pool, unsigned long handle)

 	obj_free(class->size, obj);
 	class_stat_dec(class, OBJ_USED, 1);
+
+#ifdef CONFIG_ZPOOL
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
+#endif
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
@@ -1777,7 +1836,7 @@ static enum fullness_group putback_zspage(struct size_class *class,
 	return fullness;
 }

-#ifdef CONFIG_COMPACTION
+#if defined(CONFIG_ZPOOL) || defined(CONFIG_COMPACTION)
 /*
  * To prevent zspage destroy during migration, zspage freeing should
  * hold locks of all pages in the zspage.
@@ -1819,6 +1878,24 @@ static void lock_zspage(struct zspage *zspage)
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
@@ -1835,6 +1912,7 @@ static void migrate_read_unlock(struct zspage *zspage) __releases(&zspage->lock)
 	read_unlock(&zspage->lock);
 }

+#ifdef CONFIG_COMPACTION
 static void migrate_write_lock(struct zspage *zspage)
 {
 	write_lock(&zspage->lock);
@@ -2399,6 +2477,100 @@ void zs_destroy_pool(struct zs_pool *pool)
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
+		cond_resched();
+
+		/* Lock backing pages into place */
+		lock_zspage(zspage);
+
+		obj_idx = 0;
+		page = get_first_page(zspage);
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
+			 * This will write the object and call zs_free.
+			 *
+			 * zs_free will free the object, but the
+			 * under_reclaim flag prevents it from freeing
+			 * the zspage altogether. This is necessary so
+			 * that we can continue working with the
+			 * zspage potentially after the last object
+			 * has been freed.
+			 */
+			ret = pool->zpool_ops->evict(pool->zpool, handle);
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
