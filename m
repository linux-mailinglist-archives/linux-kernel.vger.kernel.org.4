Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B44B722181
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjFEIzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjFEIyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:54:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F42F9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:54:35 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-973f78329e3so727200166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 01:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685955273; x=1688547273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVmMhDTQ10trTXW64TT8b/Jb6v8KkbgopQstkowo3kg=;
        b=S2CBCc7S1D5TyINJ4n6MaFi+ueeEVJ8MTbgRBpyzA+R0AbwW9KkfEixJ2MhYOpcYDc
         EAzBemMbxXn4g5200Ys+TM3sRyeU1du0s8LzJG3OgUmM9dcf1tP843V4g7u8V4TaB8dT
         BGB1V5Hxgysph/WHqi40ZrmvS1cLQz8mIClJ0uSU2hM07vA6YGgwW3TGcwgXgcYovTYI
         Q7zhl4VQcEztJemlxc839J3aRhDXbvc9F+kl9FHIwzD307hlwdFuGJWPBz6beiL6RsuA
         LPCO9roEfxcRcTYXrSaZvZ9jYL/X9BuxyjJdvY8YvaY69dIIJWnEmc/I33T1hFbTROyM
         tRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685955273; x=1688547273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVmMhDTQ10trTXW64TT8b/Jb6v8KkbgopQstkowo3kg=;
        b=T9vsb5qiW5juslvb5jGZgu8bPWndTlLytle4FBqjNSzqOcCPmAiKqYl26Y4y2BUgo6
         YYfjY9rhw48od1CwXzNn2G+cr9SuAAqhDD2Y1UlCI1nN5097tBrjH+cxc2ox5/n9yZEI
         hYPRnbiCNrNk7CblALK3/s5YvVK8eHLJ+7a84SOi2Z3yz5kD7+TCx+tA1b2F58ToS3bz
         wh1U2EOxa7PNTBWd+0xCJWoPp+aGzXO+MDpVR3+V5Puozu9K2GxmlbK16Mpj/wUQLRpb
         CfbPzkQTBWQqkHGmRDxq29a55xGjX0pULdltC51dB/t9k+nq4fh0uR90xT6zkGEPDRlF
         Sq7Q==
X-Gm-Message-State: AC+VfDwxjdqs7cOK/wtPiLMgT+Eyj7xoEOG79pfKCYp4n88nGM903JGR
        Yz84jySyOmuJKwz9HnUTe98=
X-Google-Smtp-Source: ACHHUZ7VtYnY07SuCzrxCYhkO4n1lzMeQWXrlB2VW5S45ipj8YgpPp7xrStUz4gzWgmLJZ6GaV2rDA==
X-Received: by 2002:a17:907:2cc4:b0:94f:36a0:da45 with SMTP id hg4-20020a1709072cc400b0094f36a0da45mr6012980ejc.29.1685955273472;
        Mon, 05 Jun 2023 01:54:33 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-82-53-8-153.retail.telecomitalia.it. [82.53.8.153])
        by smtp.gmail.com with ESMTPSA id lx5-20020a170906af0500b00965c6c63ea3sm4048915ejb.35.2023.06.05.01.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 01:54:33 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [RFC PATCH 7/7] mm: zswap: remove zswap_header
Date:   Mon,  5 Jun 2023 10:54:19 +0200
Message-Id: <20230605085419.44383-8-cerasuolodomenico@gmail.com>
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

Previously, zswap_header served the purpose of storing the swpentry
within zpool pages. This allowed zpool implementations to pass relevant
information to the writeback function. However, with the current
implementation, writeback is directly handled within zswap.
Consequently, there is no longer a necessity for zswap_header, as the
swp_entry_t can be stored directly in zswap_entry.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zswap.c | 52 ++++++++++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 8ee30a989508..093beaeaaebc 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -187,7 +187,7 @@ struct zswap_pool {
  */
 struct zswap_entry {
 	struct rb_node rbnode;
-	pgoff_t offset;
+	swp_entry_t swpentry;
 	int refcount;
 	unsigned int length;
 	struct zswap_pool *pool;
@@ -199,10 +199,6 @@ struct zswap_entry {
 	struct list_head lru;
 };
 
-struct zswap_header {
-	swp_entry_t swpentry;
-};
-
 /*
  * The tree lock in the zswap_tree struct protects a few things:
  * - the rbtree
@@ -244,7 +240,7 @@ static bool zswap_has_pool;
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
 		 zpool_get_type((p)->zpool))
 
-static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap_header *zhdr,
+static int zswap_writeback_entry(struct zswap_entry *entry,
 				 struct zswap_tree *tree);
 static int zswap_pool_get(struct zswap_pool *pool);
 static void zswap_pool_put(struct zswap_pool *pool);
@@ -305,12 +301,14 @@ static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff_t offset)
 {
 	struct rb_node *node = root->rb_node;
 	struct zswap_entry *entry;
+	pgoff_t entry_offset;
 
 	while (node) {
 		entry = rb_entry(node, struct zswap_entry, rbnode);
-		if (entry->offset > offset)
+		entry_offset = swp_offset(entry->swpentry);
+		if (entry_offset > offset)
 			node = node->rb_left;
-		else if (entry->offset < offset)
+		else if (entry_offset < offset)
 			node = node->rb_right;
 		else
 			return entry;
@@ -327,13 +325,15 @@ static int zswap_rb_insert(struct rb_root *root, struct zswap_entry *entry,
 {
 	struct rb_node **link = &root->rb_node, *parent = NULL;
 	struct zswap_entry *myentry;
+	pgoff_t myentry_offset, entry_offset = swp_offset(entry->swpentry);
 
 	while (*link) {
 		parent = *link;
 		myentry = rb_entry(parent, struct zswap_entry, rbnode);
-		if (myentry->offset > entry->offset)
+		myentry_offset = swp_offset(myentry->swpentry);
+		if (myentry_offset > entry_offset)
 			link = &(*link)->rb_left;
-		else if (myentry->offset < entry->offset)
+		else if (myentry_offset < entry_offset)
 			link = &(*link)->rb_right;
 		else {
 			*dupentry = myentry;
@@ -592,7 +592,6 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 static int zswap_shrink(struct zswap_pool *pool)
 {
 	struct zswap_entry *lru_entry, *tree_entry = NULL;
-	struct zswap_header *zhdr;
 	struct zswap_tree *tree;
 	swp_entry_t swpentry;
 	int ret;
@@ -605,10 +604,8 @@ static int zswap_shrink(struct zswap_pool *pool)
 	}
 	lru_entry = list_last_entry(&pool->lru, struct zswap_entry, lru);
 	list_del_init(&lru_entry->lru);
-	zhdr = zpool_map_handle(pool->zpool, lru_entry->handle, ZPOOL_MM_RO);
-	tree = zswap_trees[swp_type(zhdr->swpentry)];
-	zpool_unmap_handle(pool->zpool, lru_entry->handle);
-	swpentry = zhdr->swpentry;
+	swpentry = lru_entry->swpentry;
+	tree = zswap_trees[swp_type(lru_entry->swpentry)];
 	spin_unlock(&pool->lock);
 
 	/* hold a reference from tree so it won't be freed during writeback */
@@ -622,7 +619,7 @@ static int zswap_shrink(struct zswap_pool *pool)
 	}
 	spin_unlock(&tree->lock);
 
-	ret = zswap_writeback_entry(lru_entry, zhdr, tree);
+	ret = zswap_writeback_entry(lru_entry, tree);
 
 	spin_lock(&tree->lock);
 	if (ret) {
@@ -1029,10 +1026,10 @@ static int zswap_get_swap_cache_page(swp_entry_t entry,
  * the swap cache, the compressed version stored by zswap can be
  * freed.
  */
-static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap_header *zhdr,
+static int zswap_writeback_entry(struct zswap_entry *entry,
 				 struct zswap_tree *tree)
 {
-	swp_entry_t swpentry = zhdr->swpentry;
+	swp_entry_t swpentry = entry->swpentry;
 	struct page *page;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
@@ -1072,7 +1069,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap_header
 		 * writing.
 		 */
 		spin_lock(&tree->lock);
-		if (zswap_rb_search(&tree->rbroot, entry->offset) != entry) {
+		if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
 			spin_unlock(&tree->lock);
 			delete_from_swap_cache(page_folio(page));
 			ret = -ENOMEM;
@@ -1084,8 +1081,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap_header
 		acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 		dlen = PAGE_SIZE;
 
-		zhdr = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
-		src = (u8 *)zhdr + sizeof(struct zswap_header);
+		src = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
 		if (!zpool_can_sleep_mapped(pool)) {
 			memcpy(tmp, src, entry->length);
 			src = tmp;
@@ -1192,11 +1188,10 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	struct obj_cgroup *objcg = NULL;
 	struct zswap_pool *pool;
 	int ret;
-	unsigned int hlen, dlen = PAGE_SIZE;
+	unsigned int dlen = PAGE_SIZE;
 	unsigned long handle, value;
 	char *buf;
 	u8 *src, *dst;
-	struct zswap_header zhdr = { .swpentry = swp_entry(type, offset) };
 	gfp_t gfp;
 
 	/* THP isn't supported */
@@ -1241,7 +1236,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 		src = kmap_atomic(page);
 		if (zswap_is_page_same_filled(src, &value)) {
 			kunmap_atomic(src);
-			entry->offset = offset;
+			entry->swpentry = swp_entry(type, offset);
 			entry->length = 0;
 			entry->value = value;
 			atomic_inc(&zswap_same_filled_pages);
@@ -1295,11 +1290,10 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 	}
 
 	/* store */
-	hlen = sizeof(zhdr);
 	gfp = __GFP_NORETRY | __GFP_NOWARN | __GFP_KSWAPD_RECLAIM;
 	if (zpool_malloc_support_movable(entry->pool->zpool))
 		gfp |= __GFP_HIGHMEM | __GFP_MOVABLE;
-	ret = zpool_malloc(entry->pool->zpool, hlen + dlen, gfp, &handle);
+	ret = zpool_malloc(entry->pool->zpool, dlen, gfp, &handle);
 	if (ret == -ENOSPC) {
 		zswap_reject_compress_poor++;
 		goto put_dstmem;
@@ -1309,13 +1303,12 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 		goto put_dstmem;
 	}
 	buf = zpool_map_handle(entry->pool->zpool, handle, ZPOOL_MM_WO);
-	memcpy(buf, &zhdr, hlen);
-	memcpy(buf + hlen, dst, dlen);
+	memcpy(buf, dst, dlen);
 	zpool_unmap_handle(entry->pool->zpool, handle);
 	mutex_unlock(acomp_ctx->mutex);
 
 	/* populate entry */
-	entry->offset = offset;
+	entry->swpentry = swp_entry(type, offset);
 	entry->handle = handle;
 	entry->length = dlen;
 
@@ -1415,7 +1408,6 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	/* decompress */
 	dlen = PAGE_SIZE;
 	src = zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL_MM_RO);
-	src += sizeof(struct zswap_header);
 
 	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
 		memcpy(tmp, src, entry->length);
-- 
2.34.1

