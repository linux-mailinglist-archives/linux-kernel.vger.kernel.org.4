Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09ADC722179
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjFEIyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjFEIyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:54:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBC1FD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:54:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-97460240863so529386966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685955265; x=1688547265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2DLNLAJGk9U4ajDcY71N5DEib8TdCX45Wj1IDbynZg=;
        b=eQiQ5afD6YPcElylYEflOGi5aW/xEBHc41Rb9GZi6rSuBZaFGqTR32/nLMY5rz2Mqo
         ki14V4ucZgEzIqqzug/2Y08sQN7XzRMIxFSltWnLeYxmyJUiDLv44qd+4lT0hHzi+rV1
         /W9vhFNcGRw9Y+g1qpX0l67xnC/H/+V5sqdwqGel1+VBuLZoce02j6lpkQfGC8NxMVLs
         jUoj/posgjUbCAXYceY84Ja3qU2Q34LMlvLE3Hehx4B13nx5PcdFKrIMWNW/l0FxUMpf
         E/V9e6IEChlFiKrvtMPf/MiU7Ly6e6YBTPy92LsKmUWl+N/LjPc0inFDcR3Gtfvjj5RP
         JBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685955265; x=1688547265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2DLNLAJGk9U4ajDcY71N5DEib8TdCX45Wj1IDbynZg=;
        b=kvOWNl5GFNbx7jm1qcKFdqBTaM1Aftrc3N21Nsf+c37FlLLMySQqnJE9LFhrnUR23K
         RQJbkhBv6M1BYlsn+V6JsgYiwkRfV49R7jyfIBijqcbyyJ321RDGUL/WhRwJ/atBPGb8
         7fETydhZidXi4xVi0bYqLXybdZyucnDPb5zHlIIZ8u7Wl89XfoIjgswDi3vqbzToztZ0
         BMLCXHJTNr5gsB2GxCzSj0wWOpvodLzUfSdBwgyYKFDfLdFQl0yQjqijfRgr3UID3p/o
         fIxX75UfnDrmX33k2BmnkY2z4BS3dfqX1N2WsVbIXk+QO0O4sZziU9yhY1qq7OQStX7d
         rc9A==
X-Gm-Message-State: AC+VfDzrWJ51OAZDFcK1ddrHFL3w7XD3TtcipDKvSV1XN+Nsuc3fExXu
        AwqyQYsYtNXi8AuBgt1FOBo=
X-Google-Smtp-Source: ACHHUZ5KVM9zYYDYs5pXjK0cCIdsnB+EdKNKyJU0MngTlOFGDnoelVN+dvU53IYb/mqv7ePnv2T7og==
X-Received: by 2002:a17:907:7e8e:b0:977:4b19:97a with SMTP id qb14-20020a1709077e8e00b009774b19097amr6311772ejc.73.1685955265373;
        Mon, 05 Jun 2023 01:54:25 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-82-53-8-153.retail.telecomitalia.it. [82.53.8.153])
        by smtp.gmail.com with ESMTPSA id lx5-20020a170906af0500b00965c6c63ea3sm4048915ejb.35.2023.06.05.01.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 01:54:25 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [RFC PATCH 1/7] mm: zswap: add pool shrinking mechanism
Date:   Mon,  5 Jun 2023 10:54:13 +0200
Message-Id: <20230605085419.44383-2-cerasuolodomenico@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605085419.44383-1-cerasuolodomenico@gmail.com>
References: <20230605085419.44383-1-cerasuolodomenico@gmail.com>
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
 mm/zswap.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 5 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index bcb82e09eb64..80d7780bf066 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -159,6 +159,8 @@ struct zswap_pool {
 	struct work_struct shrink_work;
 	struct hlist_node node;
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
+	struct list_head lru;
+	spinlock_t lock;
 };
 
 /*
@@ -176,10 +178,12 @@ struct zswap_pool {
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
@@ -192,6 +196,7 @@ struct zswap_entry {
 		unsigned long value;
 	};
 	struct obj_cgroup *objcg;
+	struct list_head lru;
 };
 
 struct zswap_header {
@@ -364,6 +369,9 @@ static void zswap_free_entry(struct zswap_entry *entry)
 	if (!entry->length)
 		atomic_dec(&zswap_same_filled_pages);
 	else {
+		spin_lock(&entry->pool->lock);
+		list_del_init(&entry->lru);
+		spin_unlock(&entry->pool->lock);
 		zpool_free(entry->pool->zpool, entry->handle);
 		zswap_pool_put(entry->pool);
 	}
@@ -584,14 +592,65 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 	return NULL;
 }
 
+static int zswap_shrink(struct zswap_pool *pool)
+{
+	struct zswap_entry *lru_entry, *tree_entry = NULL;
+	struct zswap_header *zhdr;
+	struct zswap_tree *tree;
+	swp_entry_t swpentry;
+	int ret;
+
+	/* get a reclaimable entry from LRU */
+	spin_lock(&pool->lock);
+	if (list_empty(&pool->lru)) {
+		spin_unlock(&pool->lock);
+		return -EINVAL;
+	}
+	lru_entry = list_last_entry(&pool->lru, struct zswap_entry, lru);
+	list_del_init(&lru_entry->lru);
+	zhdr = zpool_map_handle(pool->zpool, lru_entry->handle, ZPOOL_MM_RO);
+	tree = zswap_trees[swp_type(zhdr->swpentry)];
+	zpool_unmap_handle(pool->zpool, lru_entry->handle);
+	swpentry = zhdr->swpentry;
+	spin_unlock(&pool->lock);
+
+	/* hold a reference from tree so it won't be freed during writeback */
+	spin_lock(&tree->lock);
+	tree_entry = zswap_entry_find_get(&tree->rbroot, swp_offset(swpentry));
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
+		spin_lock(&pool->lock);
+		list_move(&lru_entry->lru, &pool->lru);
+		spin_unlock(&pool->lock);
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
 
+	/* zpool_evictable will be removed once all 3 backends have migrated*/
 	do {
-		ret = zpool_shrink(pool->zpool, 1, NULL);
+		if (zpool_evictable(pool->zpool))
+			ret = zpool_shrink(pool->zpool, 1, NULL);
+		else
+			ret = zswap_shrink(pool);
 		if (ret) {
 			zswap_reject_reclaim_fail++;
 			if (ret != -EAGAIN)
@@ -655,6 +714,8 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	 */
 	kref_init(&pool->kref);
 	INIT_LIST_HEAD(&pool->list);
+	INIT_LIST_HEAD(&pool->lru);
+	spin_lock_init(&pool->lock);
 	INIT_WORK(&pool->shrink_work, shrink_worker);
 
 	zswap_pool_debug("created", pool);
@@ -1270,7 +1331,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	}
 
 	/* store */
-	hlen = zpool_evictable(entry->pool->zpool) ? sizeof(zhdr) : 0;
+	hlen = sizeof(zhdr);
 	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
 	if (zpool_malloc_support_movable(entry->pool->zpool))
 		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
@@ -1313,6 +1374,13 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 			zswap_entry_put(tree, dupentry);
 		}
 	} while (ret == -EEXIST);
+	INIT_LIST_HEAD(&entry->lru);
+	/* zpool_evictable will be removed once all 3 backends have migrated*/
+	if (entry->length && !zpool_evictable(entry->pool->zpool)) {
+		spin_lock(&entry->pool->lock);
+		list_add(&entry->lru, &entry->pool->lru);
+		spin_unlock(&entry->pool->lock);
+	}
 	spin_unlock(&tree->lock);
 
 	/* update stats */
@@ -1384,8 +1452,7 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	/* decompress */
 	dlen = PAGE_SIZE;
 	src = zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL_MM_RO);
-	if (zpool_evictable(entry->pool->zpool))
-		src += sizeof(struct zswap_header);
+	src += sizeof(struct zswap_header);
 
 	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
 		memcpy(tmp, src, entry->length);
@@ -1415,6 +1482,12 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 freeentry:
 	spin_lock(&tree->lock);
 	zswap_entry_put(tree, entry);
+	/* zpool_evictable will be removed once all 3 backends have migrated*/
+	if (entry->length && !zpool_evictable(entry->pool->zpool)) {
+		spin_lock(&entry->pool->lock);
+		list_move(&entry->lru, &entry->pool->lru);
+		spin_unlock(&entry->pool->lock);
+	}
 	spin_unlock(&tree->lock);
 
 	return ret;
-- 
2.34.1

