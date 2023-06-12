Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA1972BD23
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjFLJyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFLJx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:53:59 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A8710D4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5149429c944so7240512a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686562702; x=1689154702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovwqjP88DLJU174wX93bEruUbTnFh4DciYUv65znDHc=;
        b=KZfdk105SVW1ZlUxEwaUHuC2cQAmWKzBmQ2NNpCN4F3/Qm43WAlHWWV3ZtTSbNAihm
         p/oy3xv28rDYE9OelY/atO/IhnMW0LnAxswzBt3BBluRaJPJhflX1fAuPHKNl4QabPnL
         /zX/+xDo7pqMY9INVkzGlS3GF/+a6aJ9/dcCU/2uKOsDojvqrzLi9W8lMq8ROjICCmAU
         IPQPF5kpHn+H1Jvnlh0lJK0QMPzPcLeSllzhYMeaSY5YYMp46GgDI65x5/ra8wpgkTNx
         J05FuZ2c3f4xqHcZrD/Xq1x9+4K5ss3hewqNuytZuxN8/2L2aXrnj6RQhSVphksTW9xp
         B1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562702; x=1689154702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovwqjP88DLJU174wX93bEruUbTnFh4DciYUv65znDHc=;
        b=bWyP+c/HeJ15/7iR1fnjHjbHB8vAFgR+Izb/3vLCpHSQjADqyhusvJpzj9wJ0KjlAn
         7mcZbUvmBVDJBvwfYrqzjP0tOpBUttdxssQtFEa8HAPOIpDuM47squKOt0JZPDQRhuoC
         GIseWBQFQbEg9a/9+sY9+Yb/373fwb8DzA4sNd0xkW+PtYDSPLKLrBHcocnqUCpUkBxk
         ogATaJMNh4sfWlusZYvcLZpoiBm4ekxRlXteU67O4mzmWME+JS8ltF9exzD2dconMow7
         j2P4jQMTncCq7mtIkRsyMFpiqL4+v3wFe5uxCX5/NqNIbKKWVu7HLz7WljwFIX26yUj6
         HDgw==
X-Gm-Message-State: AC+VfDy+Tt7SYUqQEsMRxsRMTVquTBy2phq5x89ua94NIudCQ7MZPNg7
        undYJesfC1wiHllYfHCQYis=
X-Google-Smtp-Source: ACHHUZ6od08fUS5Y5YBcxZ9WTfK/OI6dT7FI8Sb1oVaF31Hk1VrgKGdgSM0hpkvAGBFP0SFa0Z/byw==
X-Received: by 2002:a17:907:1c93:b0:97d:f8aa:6d37 with SMTP id nb19-20020a1709071c9300b0097df8aa6d37mr8045773ejc.61.1686562701654;
        Mon, 12 Jun 2023 02:38:21 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-212-171-43-8.retail.telecomitalia.it. [212.171.43.8])
        by smtp.gmail.com with ESMTPSA id ce23-20020a170906b25700b0097887b68c17sm4951358ejb.98.2023.06.12.02.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:38:21 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v3 1/7] mm: zswap: add pool shrinking mechanism
Date:   Mon, 12 Jun 2023 11:38:09 +0200
Message-Id: <20230612093815.133504-2-cerasuolodomenico@gmail.com>
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

Acked-by: Nhat Pham <nphamcs@gmail.com>
Tested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zswap.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 5 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 9fa86265f6dd..0024ec5ed574 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -154,6 +154,12 @@ struct crypto_acomp_ctx {
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
@@ -163,6 +169,8 @@ struct zswap_pool {
 	struct work_struct shrink_work;
 	struct hlist_node node;
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
+	struct list_head lru;
+	spinlock_t lru_lock;
 };
 
 /*
@@ -180,10 +188,12 @@ struct zswap_pool {
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
@@ -196,6 +206,7 @@ struct zswap_entry {
 		unsigned long value;
 	};
 	struct obj_cgroup *objcg;
+	struct list_head lru;
 };
 
 struct zswap_header {
@@ -368,6 +379,12 @@ static void zswap_free_entry(struct zswap_entry *entry)
 	if (!entry->length)
 		atomic_dec(&zswap_same_filled_pages);
 	else {
+		/* zpool_evictable will be removed once all 3 backends have migrated */
+		if (!zpool_evictable(entry->pool->zpool)) {
+			spin_lock(&entry->pool->lru_lock);
+			list_del(&entry->lru);
+			spin_unlock(&entry->pool->lru_lock);
+		}
 		zpool_free(entry->pool->zpool, entry->handle);
 		zswap_pool_put(entry->pool);
 	}
@@ -588,14 +605,72 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 	return NULL;
 }
 
+static int zswap_reclaim_entry(struct zswap_pool *pool)
+{
+	struct zswap_header *zhdr;
+	struct zswap_entry *entry;
+	struct zswap_tree *tree;
+	pgoff_t swpoffset;
+	int ret;
+
+	/* Get an entry off the LRU */
+	spin_lock(&pool->lru_lock);
+	if (list_empty(&pool->lru)) {
+		spin_unlock(&pool->lru_lock);
+		return -EINVAL;
+	}
+	entry = list_last_entry(&pool->lru, struct zswap_entry, lru);
+	list_del_init(&entry->lru);
+	zhdr = zpool_map_handle(pool->zpool, entry->handle, ZPOOL_MM_RO);
+	tree = zswap_trees[swp_type(zhdr->swpentry)];
+	zpool_unmap_handle(pool->zpool, entry->handle);
+	/*
+	 * Once the lru lock is dropped, the entry might get freed. The
+	 * swpoffset is copied to the stack, and entry isn't deref'd again
+	 * until the entry is verified to still be alive in the tree.
+	 */
+	swpoffset = swp_offset(zhdr->swpentry);
+	spin_unlock(&pool->lru_lock);
+
+	/* Check for invalidate() race */
+	spin_lock(&tree->lock);
+	if (entry != zswap_rb_search(&tree->rbroot, swpoffset)) {
+		ret = -EAGAIN;
+		goto unlock;
+	}
+	/* Hold a reference to prevent a free during writeback */
+	zswap_entry_get(entry);
+	spin_unlock(&tree->lock);
+
+	ret = zswap_writeback_entry(pool->zpool, entry->handle);
+
+	spin_lock(&tree->lock);
+	if (ret) {
+		/* Writeback failed, put entry back on LRU */
+		spin_lock(&pool->lru_lock);
+		list_move(&entry->lru, &pool->lru);
+		spin_unlock(&pool->lru_lock);
+	}
+
+	/* Drop local reference */
+	zswap_entry_put(tree, entry);
+unlock:
+	spin_unlock(&tree->lock);
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
+			ret = zswap_reclaim_entry(pool);
 		if (ret) {
 			zswap_reject_reclaim_fail++;
 			if (ret != -EAGAIN)
@@ -659,6 +734,8 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	 */
 	kref_init(&pool->kref);
 	INIT_LIST_HEAD(&pool->list);
+	INIT_LIST_HEAD(&pool->lru);
+	spin_lock_init(&pool->lru_lock);
 	INIT_WORK(&pool->shrink_work, shrink_worker);
 
 	zswap_pool_debug("created", pool);
@@ -1274,7 +1351,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	}
 
 	/* store */
-	hlen = zpool_evictable(entry->pool->zpool) ? sizeof(zhdr) : 0;
+	hlen = sizeof(zhdr);
 	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
 	if (zpool_malloc_support_movable(entry->pool->zpool))
 		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
@@ -1317,6 +1394,12 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
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
@@ -1398,8 +1481,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	/* decompress */
 	dlen = PAGE_SIZE;
 	src = zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL_MM_RO);
-	if (zpool_evictable(entry->pool->zpool))
-		src += sizeof(struct zswap_header);
+	src += sizeof(struct zswap_header);
 
 	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
 		memcpy(tmp, src, entry->length);
@@ -1432,6 +1514,11 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	if (!ret && zswap_exclusive_loads_enabled) {
 		zswap_invalidate_entry(tree, entry);
 		*exclusive = true;
+	} else if (entry->length && !zpool_evictable(entry->pool->zpool)) {
+		/* zpool_evictable will be removed once all 3 backends have migrated */
+		spin_lock(&entry->pool->lru_lock);
+		list_move(&entry->lru, &entry->pool->lru);
+		spin_unlock(&entry->pool->lru_lock);
 	}
 	spin_unlock(&tree->lock);
 
-- 
2.34.1

