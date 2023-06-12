Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB5172BE2F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbjFLKCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbjFLJyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:54:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3101049E3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5149429c944so7240697a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686562709; x=1689154709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fU56VIBLxnADHQ9EwUvFSMVUPT9Hc1VDImYlSwrw2UY=;
        b=rPyAJhbxdlqwUwyy7dTVMaBUHWn0yYtfrSsTXXjp3XScuykpDtMKUSRhLnII7AOPxy
         LygimtnshwNmGzZp4SRktLKkKrw8YeGsLVvcXVWqwRg152gnuniKlICI/PUGjYrtNuDq
         9X0D0FfNc5DWhWUDwEYpeM09XkhOgj2vDLd+Tjx3qAT/jjzC93d32u43pbaRamHma0RQ
         FsMxBQqZ7lT0u3yAK7jrmhH1wHXB8K2cfVWkD5Z4zFPU6KuSLfQv4wL/ExHNW6YHyJKr
         HkrM1linZUifX/ITa62cR+cLUd4YP51PHa/Sj/Xd9+Nw8tflILQf6C5Alyzxrb95S5JA
         pP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562709; x=1689154709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fU56VIBLxnADHQ9EwUvFSMVUPT9Hc1VDImYlSwrw2UY=;
        b=XAhf96uC0/ZxHtcymGn5nODtTib8+GkUvnmZjoGLD4fqdlkCcdXIHOlFg3BHtDsOlz
         M5p8vscAstKv8c0cln/MLU2nCAtIIpHwmncOk89RiDC9ne5SNGqpRinsW/ABIGYnUdnx
         mhyFLTPU86oebQ9x0s1okuXy1i/njlKYZFa5RBNrEnLT8xiz+Z3b0XRRj0VAYuX+TBls
         b84zewxNQVcsG9BwRP4mctLNM2v5E6QYHT8GRYZUgKT2XAfSWQFKGBIvChbAzptQ6/8z
         eqWJyJXGk45XLsCMeuOQjvwQNn1PHN2u6IluY0BT2RO+vvavnIk0YzDIzpZlwxGRy8UE
         fwtA==
X-Gm-Message-State: AC+VfDxKgouUT3x4VMZUfOstGzkVSM17TfAC+Hzuz/rmVOS69SbtQ8Aj
        LpGZQ+T5QpNSRvbK4HsVu1w=
X-Google-Smtp-Source: ACHHUZ4Ka4ubZrdavFDrfWTwpLTvFWbauCZbwoMXabv7dPstChJIOunVXKEghyabVP0TxIpzU3irVQ==
X-Received: by 2002:a17:907:7f09:b0:973:a30d:b264 with SMTP id qf9-20020a1709077f0900b00973a30db264mr9422554ejc.46.1686562709657;
        Mon, 12 Jun 2023 02:38:29 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-212-171-43-8.retail.telecomitalia.it. [212.171.43.8])
        by smtp.gmail.com with ESMTPSA id ce23-20020a170906b25700b0097887b68c17sm4951358ejb.98.2023.06.12.02.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:38:29 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v3 7/7] mm: zswap: remove zswap_header
Date:   Mon, 12 Jun 2023 11:38:15 +0200
Message-Id: <20230612093815.133504-8-cerasuolodomenico@gmail.com>
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

Previously, zswap_header served the purpose of storing the swpentry
within zpool pages. This allowed zpool implementations to pass relevant
information to the writeback function. However, with the current
implementation, writeback is directly handled within zswap.
Consequently, there is no longer a necessity for zswap_header, as the
swp_entry_t can be stored directly in zswap_entry.

Tested-by: Yosry Ahmed <yosryahmed@google.com>
Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zswap.c | 52 ++++++++++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 3a6b07a19262..02d0a6f46f4a 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -197,7 +197,7 @@ struct zswap_pool {
  */
 struct zswap_entry {
 	struct rb_node rbnode;
-	pgoff_t offset;
+	swp_entry_t swpentry;
 	int refcount;
 	unsigned int length;
 	struct zswap_pool *pool;
@@ -209,10 +209,6 @@ struct zswap_entry {
 	struct list_head lru;
 };
 
-struct zswap_header {
-	swp_entry_t swpentry;
-};
-
 /*
  * The tree lock in the zswap_tree struct protects a few things:
  * - the rbtree
@@ -254,7 +250,7 @@ static bool zswap_has_pool;
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
 		 zpool_get_type((p)->zpool))
 
-static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap_header *zhdr,
+static int zswap_writeback_entry(struct zswap_entry *entry,
 				 struct zswap_tree *tree);
 static int zswap_pool_get(struct zswap_pool *pool);
 static void zswap_pool_put(struct zswap_pool *pool);
@@ -315,12 +311,14 @@ static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff_t offset)
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
@@ -337,13 +335,15 @@ static int zswap_rb_insert(struct rb_root *root, struct zswap_entry *entry,
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
@@ -601,7 +601,6 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 
 static int zswap_reclaim_entry(struct zswap_pool *pool)
 {
-	struct zswap_header *zhdr;
 	struct zswap_entry *entry;
 	struct zswap_tree *tree;
 	pgoff_t swpoffset;
@@ -615,15 +614,13 @@ static int zswap_reclaim_entry(struct zswap_pool *pool)
 	}
 	entry = list_last_entry(&pool->lru, struct zswap_entry, lru);
 	list_del_init(&entry->lru);
-	zhdr = zpool_map_handle(pool->zpool, entry->handle, ZPOOL_MM_RO);
-	tree = zswap_trees[swp_type(zhdr->swpentry)];
-	zpool_unmap_handle(pool->zpool, entry->handle);
 	/*
 	 * Once the lru lock is dropped, the entry might get freed. The
 	 * swpoffset is copied to the stack, and entry isn't deref'd again
 	 * until the entry is verified to still be alive in the tree.
 	 */
-	swpoffset = swp_offset(zhdr->swpentry);
+	swpoffset = swp_offset(entry->swpentry);
+	tree = zswap_trees[swp_type(entry->swpentry)];
 	spin_unlock(&pool->lru_lock);
 
 	/* Check for invalidate() race */
@@ -636,7 +633,7 @@ static int zswap_reclaim_entry(struct zswap_pool *pool)
 	zswap_entry_get(entry);
 	spin_unlock(&tree->lock);
 
-	ret = zswap_writeback_entry(entry, zhdr, tree);
+	ret = zswap_writeback_entry(entry, tree);
 
 	spin_lock(&tree->lock);
 	if (ret) {
@@ -1055,10 +1052,10 @@ static int zswap_get_swap_cache_page(swp_entry_t entry,
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
@@ -1098,7 +1095,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap_header
 		 * writing.
 		 */
 		spin_lock(&tree->lock);
-		if (zswap_rb_search(&tree->rbroot, entry->offset) != entry) {
+		if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
 			spin_unlock(&tree->lock);
 			delete_from_swap_cache(page_folio(page));
 			ret = -ENOMEM;
@@ -1110,8 +1107,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap_header
 		acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 		dlen = PAGE_SIZE;
 
-		zhdr = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
-		src = (u8 *)zhdr + sizeof(struct zswap_header);
+		src = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
 		if (!zpool_can_sleep_mapped(pool)) {
 			memcpy(tmp, src, entry->length);
 			src = tmp;
@@ -1205,11 +1201,10 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
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
@@ -1254,7 +1249,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 		src = kmap_atomic(page);
 		if (zswap_is_page_same_filled(src, &value)) {
 			kunmap_atomic(src);
-			entry->offset = offset;
+			entry->swpentry = swp_entry(type, offset);
 			entry->length = 0;
 			entry->value = value;
 			atomic_inc(&zswap_same_filled_pages);
@@ -1308,11 +1303,10 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
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
@@ -1322,13 +1316,12 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
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
 
@@ -1437,7 +1430,6 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	/* decompress */
 	dlen = PAGE_SIZE;
 	src = zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL_MM_RO);
-	src += sizeof(struct zswap_header);
 
 	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
 		memcpy(tmp, src, entry->length);
-- 
2.34.1

