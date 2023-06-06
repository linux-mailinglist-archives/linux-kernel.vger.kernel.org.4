Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E93724712
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbjFFO5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbjFFO5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:57:01 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF00F172B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:56:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-970056276acso926798666b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686063398; x=1688655398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNnndC93KmKiJnAdpPk9x4L+XFhcaShgDP51CZZAbUg=;
        b=VvNAjXztB5HLv66Z7inI4RSDPfsbGyrp1hNKEvci8vJEXgplc4UI/hPgx/Keqr396i
         FMn8+llh0ojGW+56pk4GI2C6uvCfFqTcVsX/rJAGcCGZI7LErcDw668W9SASc8M+j2u0
         m961k1ZmTyZfbD+PaHTU5YOkEE7Ex511buMwE1MOU+lzI91KQMzpNwD/DrvXuEIGUW4T
         52Fkp9Ze3mDlLyRrWR9R8LALrhU2nmEUSPgzpD8lI2BxnCB+jvA7oqjf3UaZncYuXWU3
         //ZsYfPixGcS/bKotKwOO12kbXmh4yppmZVvZNhAwrzrc3hxgTHjVe8oruhU9yEXY2F/
         dhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686063398; x=1688655398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNnndC93KmKiJnAdpPk9x4L+XFhcaShgDP51CZZAbUg=;
        b=AHvh/QoZz5g1DmDGzvRCZJOsifIl6B03IhzHhtXhbhHWSnDktvXVFgkAWy6VP9F5ng
         m7LRZAEyuooBrwoLodO90Qn3Wo/X9ZROFpptVm/YnvS+UCRNufyKyu3JX6qLtvJW8gmj
         W9xNfWtV/T499eo8DDwmk/GFf0YNaGtYPq45+h+uz052BRKcgMIkh/wDTfkT0454ZFhW
         vq8ta0nKmjIFZla10yW1r1l9tHkLG2FSX5gVfeg4n6R+9vnB9UKL0NFSUV9DpZf6YtLT
         jgTTmIm0eZy4yg3KwMMbdH7pj5m7QCkZx5kB22O5Dh5j0w4jIAxDgGutx/D8FnPoSfl4
         FAcA==
X-Gm-Message-State: AC+VfDziXLcAeWda4v2bZcohM0PdK6oQNQOTvGM7MsbBWitw/7yo1h5D
        wANYeIbJjRUbLaixHUudcQk=
X-Google-Smtp-Source: ACHHUZ7nzt8HuDTIMD+Sa6i4Y0wlUgjMVtJxHsbrI7oye9qT4xlBex7OIXEjQDUsUqPcb7nD8Lh0kg==
X-Received: by 2002:a17:907:1ca3:b0:973:f72f:dfac with SMTP id nb35-20020a1709071ca300b00973f72fdfacmr2895578ejc.67.1686063398160;
        Tue, 06 Jun 2023 07:56:38 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-82-53-214-132.retail.telecomitalia.it. [82.53.214.132])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709063e4f00b00965c529f103sm5619618eji.86.2023.06.06.07.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:56:37 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [RFC PATCH v2 1/7] mm: zswap: add pool shrinking mechanism
Date:   Tue,  6 Jun 2023 16:56:05 +0200
Message-Id: <20230606145611.704392-2-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com>
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

Each zpool driver (zbud, z3fold and zsmalloc) implements its own shrink
function, which is called from zpool_shrink. However, with this commit,
a unified shrink function is added to zswap. The ultimate goal is to
eliminate the need for zpool_shrink once all zpool implementations have
dropped their shrink code.

To ensure the functionality of each commit, this change focuses solely
on adding the mechanism itself. No modifications are made to
the backends, meaning that functionally, there are no immediate changes.
The zswap mechanism will only come into effect once the backends have
removed their shrink code. The subsequent commits will address the
modifications needed in the backends.

Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zswap.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 5 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index bcb82e09eb64..c99bafcefecf 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -150,6 +150,12 @@ struct crypto_acomp_ctx {
 	struct mutex *mutex;
 };
 
+/*
+ * The lock ordering is zswap_tree.lock -> zswap_pool.lru_lock.
+ * The only case where lru_lock is not acquired while holding tree.lock is
+ * when a zswap_entry is taken off the lru for writeback, in that case it
+ * needs to be verified that it's still valid in the tree.
+ */
 struct zswap_pool {
 	struct zpool *zpool;
 	struct crypto_acomp_ctx __percpu *acomp_ctx;
@@ -159,6 +165,8 @@ struct zswap_pool {
 	struct work_struct shrink_work;
 	struct hlist_node node;
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
+	struct list_head lru;
+	spinlock_t lru_lock;
 };
 
 /*
@@ -176,10 +184,12 @@ struct zswap_pool {
  *            be held while changing the refcount.  Since the lock must
  *            be held, there is no reason to also make refcount atomic.
  * length - the length in bytes of the compressed page data.  Needed during
- *          decompression. For a same value filled page length is 0.
+ *          decompression. For a same value filled page length is 0, and both
+ *          pool and lru are invalid and must be ignored.
  * pool - the zswap_pool the entry's data is in
  * handle - zpool allocation handle that stores the compressed page data
  * value - value of the same-value filled pages which have same content
+ * lru - handle to the pool's lru used to evict pages.
  */
 struct zswap_entry {
 	struct rb_node rbnode;
@@ -192,6 +202,7 @@ struct zswap_entry {
 		unsigned long value;
 	};
 	struct obj_cgroup *objcg;
+	struct list_head lru;
 };
 
 struct zswap_header {
@@ -364,6 +375,12 @@ static void zswap_free_entry(struct zswap_entry *entry)
 	if (!entry->length)
 		atomic_dec(&zswap_same_filled_pages);
 	else {
+	/* zpool_evictable will be removed once all 3 backends have migrated */
+		if (!zpool_evictable(entry->pool->zpool)) {
+			spin_lock(&entry->pool->lru_lock);
+			list_del(&entry->lru);
+			spin_unlock(&entry->pool->lru_lock);
+		}
 		zpool_free(entry->pool->zpool, entry->handle);
 		zswap_pool_put(entry->pool);
 	}
@@ -584,14 +601,70 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 	return NULL;
 }
 
+static int zswap_shrink(struct zswap_pool *pool)
+{
+	struct zswap_entry *lru_entry, *tree_entry = NULL;
+	struct zswap_header *zhdr;
+	struct zswap_tree *tree;
+	int swpoffset;
+	int ret;
+
+	/* get a reclaimable entry from LRU */
+	spin_lock(&pool->lru_lock);
+	if (list_empty(&pool->lru)) {
+		spin_unlock(&pool->lru_lock);
+		return -EINVAL;
+	}
+	lru_entry = list_last_entry(&pool->lru, struct zswap_entry, lru);
+	list_del_init(&lru_entry->lru);
+	zhdr = zpool_map_handle(pool->zpool, lru_entry->handle, ZPOOL_MM_RO);
+	tree = zswap_trees[swp_type(zhdr->swpentry)];
+	zpool_unmap_handle(pool->zpool, lru_entry->handle);
+	/*
+	 * Once the pool lock is dropped, the lru_entry might get freed. The
+	 * swpoffset is copied to the stack, and lru_entry isn't deref'd again
+	 * until the entry is verified to still be alive in the tree.
+	 */
+	swpoffset = swp_offset(zhdr->swpentry);
+	spin_unlock(&pool->lru_lock);
+
+	/* hold a reference from tree so it won't be freed during writeback */
+	spin_lock(&tree->lock);
+	tree_entry = zswap_entry_find_get(&tree->rbroot, swpoffset);
+	if (tree_entry != lru_entry) {
+		if (tree_entry)
+			zswap_entry_put(tree, tree_entry);
+		spin_unlock(&tree->lock);
+		return -EAGAIN;
+	}
+	spin_unlock(&tree->lock);
+
+	ret = zswap_writeback_entry(pool->zpool, lru_entry->handle);
+
+	spin_lock(&tree->lock);
+	if (ret) {
+		spin_lock(&pool->lru_lock);
+		list_move(&lru_entry->lru, &pool->lru);
+		spin_unlock(&pool->lru_lock);
+	}
+	zswap_entry_put(tree, tree_entry);
+	spin_unlock(&tree->lock);
+
+	return ret ? -EAGAIN : 0;
+}
+
 static void shrink_worker(struct work_struct *w)
 {
 	struct zswap_pool *pool = container_of(w, typeof(*pool),
 						shrink_work);
 	int ret, failures = 0;
 
+	/* zpool_evictable will be removed once all 3 backends have migrated */
 	do {
-		ret = zpool_shrink(pool->zpool, 1, NULL);
+		if (zpool_evictable(pool->zpool))
+			ret = zpool_shrink(pool->zpool, 1, NULL);
+		else
+			ret = zswap_shrink(pool);
 		if (ret) {
 			zswap_reject_reclaim_fail++;
 			if (ret != -EAGAIN)
@@ -655,6 +728,8 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	 */
 	kref_init(&pool->kref);
 	INIT_LIST_HEAD(&pool->list);
+	INIT_LIST_HEAD(&pool->lru);
+	spin_lock_init(&pool->lru_lock);
 	INIT_WORK(&pool->shrink_work, shrink_worker);
 
 	zswap_pool_debug("created", pool);
@@ -1270,7 +1345,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	}
 
 	/* store */
-	hlen = zpool_evictable(entry->pool->zpool) ? sizeof(zhdr) : 0;
+	hlen = sizeof(zhdr);
 	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
 	if (zpool_malloc_support_movable(entry->pool->zpool))
 		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
@@ -1313,6 +1388,12 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 			zswap_entry_put(tree, dupentry);
 		}
 	} while (ret == -EEXIST);
+	/* zpool_evictable will be removed once all 3 backends have migrated */
+	if (entry->length && !zpool_evictable(entry->pool->zpool)) {
+		spin_lock(&entry->pool->lru_lock);
+		list_add(&entry->lru, &entry->pool->lru);
+		spin_unlock(&entry->pool->lru_lock);
+	}
 	spin_unlock(&tree->lock);
 
 	/* update stats */
@@ -1384,8 +1465,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	/* decompress */
 	dlen = PAGE_SIZE;
 	src = zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL_MM_RO);
-	if (zpool_evictable(entry->pool->zpool))
-		src += sizeof(struct zswap_header);
+	src += sizeof(struct zswap_header);
 
 	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
 		memcpy(tmp, src, entry->length);
@@ -1415,6 +1495,12 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 freeentry:
 	spin_lock(&tree->lock);
 	zswap_entry_put(tree, entry);
+	/* zpool_evictable will be removed once all 3 backends have migrated */
+	if (entry->length && !zpool_evictable(entry->pool->zpool)) {
+		spin_lock(&entry->pool->lru_lock);
+		list_move(&entry->lru, &entry->pool->lru);
+		spin_unlock(&entry->pool->lru_lock);
+	}
 	spin_unlock(&tree->lock);
 
 	return ret;
-- 
2.34.1

