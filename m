Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBEE63084E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiKSBTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiKSBSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:18:15 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017D2F60B5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:15:46 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y10so4738445plp.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 16:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co9VEJF4pdxmrIDsS8H+BTo/CtOiZYr3gRWH6+3Vpr4=;
        b=T0YKjRwwzXJG2yRWFWfCM687bYqCIIoadzwEjQFvRTsy4BBI7Q1v1cPIo3piv1EOu5
         ksLLpkjjRbaCjmKa2qR9lbumsFOCXTXPEgF858ZOaWAvmuU21JTnd9/H72E1Y9xmuQmO
         BBbiGmtGmXmdVqKR6lULR+/UERUdy94CZEgLg5tu12N+NXZB3grZXVL8fYawPBSHrIbT
         9grObhJ7iztQZ9tpmLwnTxgrlApibIBEAHtjdNYiAmLEArbEXfa+1m/hsVNTOYQTZM41
         LqH8ZFFGKdde707H4Q1MHM/Q3gbdcfZbkFlQ4qTC/+S04DVQKr4lNJBwZlj/bUU9xsFE
         t8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Co9VEJF4pdxmrIDsS8H+BTo/CtOiZYr3gRWH6+3Vpr4=;
        b=S266nQ7PeftqXXbt22Q3Bmj1LbDIg0e2GdfZk9d3EFk72Xn8tXn+UhfmEqyxrdL2uF
         0YMUQZGgYkQhfanFP+cORemn3bADpPXkm3xGzopcgbl1sbhDoqY+pFFhhQk5wAAaVxRn
         XpnV5KG2oV7wCXV5pZyZQQrTluY9p4uPOYuR3AbhNcgdBjM7ovWXVfaB6x4wFvyV3jTN
         wJZAvJQZ1iCPkuOk6AJdCxz/mZyzCFYpB61gKZMBD6WASRJ9RnACOafiiYgR9LKY9DeM
         lj1Zl3wwf//fZXKwSJxl4OkVoBMNQr3FisFsouLrlBR55+BBSRT9dvk7W+NG7cF0MnaS
         1Wcg==
X-Gm-Message-State: ANoB5pkfYm+QJ7rC/lNYmjTDV1hvNXfS6CgQgil2sb+62nFM/IJPCAyJ
        81rYpd+04Akw7Qy2lY8skQA=
X-Google-Smtp-Source: AA0mqf6B6K/1xRL8XHotAHoGiBG7qKCqhD0g8IdKbNhXqLYxxJbDoyXr34M0AscDiqFOxLyMlV3RkQ==
X-Received: by 2002:a17:903:2055:b0:188:bed6:3fbe with SMTP id q21-20020a170903205500b00188bed63fbemr1812139pla.38.1668816945445;
        Fri, 18 Nov 2022 16:15:45 -0800 (PST)
Received: from localhost (fwdproxy-prn-018.fbsv.net. [2a03:2880:ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id o14-20020a170902d4ce00b00186acb14c4asm4418285plg.67.2022.11.18.16.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 16:15:45 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: [PATCH v6 6/6] zsmalloc: Implement writeback mechanism for zsmalloc
Date:   Fri, 18 Nov 2022 16:15:36 -0800
Message-Id: <20221119001536.2086599-7-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221119001536.2086599-1-nphamcs@gmail.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
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
 mm/zsmalloc.c | 193 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 182 insertions(+), 11 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 9920f3584511..3fba04e10227 100644
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
@@ -1535,12 +1580,26 @@ void zs_free(struct zs_pool *pool, unsigned long handle)

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
@@ -1740,7 +1799,7 @@ static enum fullness_group putback_zspage(struct size_class *class,
 	return fullness;
 }

-#ifdef CONFIG_COMPACTION
+#if defined(CONFIG_ZPOOL) || defined(CONFIG_COMPACTION)
 /*
  * To prevent zspage destroy during migration, zspage freeing should
  * hold locks of all pages in the zspage.
@@ -1782,6 +1841,24 @@ static void lock_zspage(struct zspage *zspage)
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
@@ -1798,6 +1875,7 @@ static void migrate_read_unlock(struct zspage *zspage) __releases(&zspage->lock)
 	read_unlock(&zspage->lock);
 }

+#ifdef CONFIG_COMPACTION
 static void migrate_write_lock(struct zspage *zspage)
 {
 	write_lock(&zspage->lock);
@@ -2362,6 +2440,99 @@ void zs_destroy_pool(struct zs_pool *pool)
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
