Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E6960E9E1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbiJZUHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiJZUGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:06:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F82A220E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:06:21 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m6so16594946pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OqjbX0ITf4k24OuoKwYdR+7colwCLHKEor3QZ1c38U=;
        b=B8/Zw4l4FSDq4hTG54dSyA1WeuK0Dz1r5JD85LjlCAjLNCsu+MH0bnTd8jjEnsSulV
         s/CLh+005SrNFDNzbqQrDnnoyMd5btQIsGqmYFFvJZIEP77Px713mxhnG60gec1LVfQC
         UfCzlpF8ILFekFuXunWwwlFeMahnDOiL0xypcbekLCThO56VkxqMbFSsgf7WfBl1hjrm
         oGUTYDJOstz3KhAVJ04QqOEkGCovf3rWK9WO4/xoDCtwHFQ2Tn98YCQbYwx5GM2rbNt3
         t5yM59yjjbw8dwfk8XY0jNDoWln3+eSnlD+pYGCde2RSC+iu8Ou/tUYxaQqH0Fgrt4EW
         QiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OqjbX0ITf4k24OuoKwYdR+7colwCLHKEor3QZ1c38U=;
        b=VdGIj51On1T4LReOVLCTu1HhcjFfcLwAdmakv5oGnAJahCKiGFew+g3Ta4iYfA60Zh
         DWVnmgZuIvQMpN+6k9xtTM2ucpwGwYLVvHlHzzIwJ1R/Lt0xYdWYVuj9/CJ1yXbdxP0j
         icYOZTu15ycKNrQd9av3zPs3Bsrd0B26MKeQ0yCqkalCvbRrmXuQMz6/iq0/MnjMs+G5
         o8OYmScRWpglpzluG4BXz37RsagLSyKJgrulAqhifuh7WNpKzEryVEY4tyvjypajG85A
         78INqcfM0PlBvw1ZjITYchHdGJOz9ancCX9lc9ajBpW6kGWB73f/kAvsmwxupEp9AeW5
         QaCQ==
X-Gm-Message-State: ACrzQf2MPBICY9CjQqPvvd62azeDOSdwtFDQn7bmDNcu6Gb5smb0oigh
        97jQEkOjugicjpssG/rGQAA=
X-Google-Smtp-Source: AMsMyM5o3eP60Zv0hO1mVs3qgeH/LP3UM8DuGGCr+5DJWpv+Yu2EDQE4y69NFgmo6zXatp4eFr11QA==
X-Received: by 2002:a05:6a00:10cf:b0:563:34ce:4138 with SMTP id d15-20020a056a0010cf00b0056334ce4138mr46545932pfu.6.1666814780588;
        Wed, 26 Oct 2022 13:06:20 -0700 (PDT)
Received: from localhost (fwdproxy-prn-001.fbsv.net. [2a03:2880:ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id g31-20020a63111f000000b0043a18cef977sm3156403pgl.13.2022.10.26.13.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:06:20 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH 5/5] zsmalloc: Implement writeback mechanism for zsmalloc
Date:   Wed, 26 Oct 2022 13:06:13 -0700
Message-Id: <20221026200613.1031261-6-nphamcs@gmail.com>
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

This commit adds the writeback mechanism for zsmalloc, analogous to the
zbud allocator. Zsmalloc will attempt to determine the coldest zspage
(i.e least recently used) in the pool, and attempt to write back all the
stored compressed objects via the pool's evict handler.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zsmalloc.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 177 insertions(+), 15 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 76ff2ed839d0..c79cbd3f46f3 100644
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
@@ -1762,7 +1816,6 @@ static enum fullness_group putback_zspage(struct size_class *class,
 	return fullness;
 }
 
-#ifdef CONFIG_COMPACTION
 /*
  * To prevent zspage destroy during migration, zspage freeing should
  * hold locks of all pages in the zspage.
@@ -1805,6 +1858,21 @@ static void lock_zspage(struct zspage *zspage)
 	migrate_read_unlock(zspage);
 }
 
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
+
 static void migrate_lock_init(struct zspage *zspage)
 {
 	rwlock_init(&zspage->lock);
@@ -1820,6 +1888,7 @@ static void migrate_read_unlock(struct zspage *zspage) __releases(&zspage->lock)
 	read_unlock(&zspage->lock);
 }
 
+#ifdef CONFIG_COMPACTION
 static void migrate_write_lock(struct zspage *zspage)
 {
 	write_lock(&zspage->lock);
@@ -2380,6 +2449,99 @@ void zs_destroy_pool(struct zs_pool *pool)
 }
 EXPORT_SYMBOL_GPL(zs_destroy_pool);
 
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
+
 static int __init zs_init(void)
 {
 	int ret;
-- 
2.30.2

