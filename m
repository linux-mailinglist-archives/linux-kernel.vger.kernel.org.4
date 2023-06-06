Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F4F724713
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbjFFO54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237522AbjFFO5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:57:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A64390
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:56:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977e0fbd742so321329166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686063407; x=1688655407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhYnJ85SsBzbhwhmV4TUMs7WzUYYJEIUQ15AnoeRiic=;
        b=ErpkxP8q/AhVs8YDRi3AxcBq0SHf/vrmbAw2N0GMErkeQdpIrZwVLHUIVU2Er46Gmn
         75DYvqMZp0RRYEGHbhFy25Yx3pvO8I6i7rVk9xEoI7x0TrWCZ3tZOPqPqxAP3tvlw483
         6ktUFhSX/IsOMaD4OXDkAeIzpcLr5hbmIy8vLqRYtt5HAtB0mSGhkYVacc1q1fU+l6bt
         rqRToSPRrxONHqUlnfpGHS8k62PvFJ5Dj0cBbTTQFNYe+sh0LAX9eoCvnuMOwZU70+AX
         nSt195jqR104nvspIgjBk2S3uYHLmXudfxyPCSmMVI7ivtaCli0G8A4lwJLnht9lZV3e
         XspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686063407; x=1688655407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhYnJ85SsBzbhwhmV4TUMs7WzUYYJEIUQ15AnoeRiic=;
        b=COFlmjxV24qUSZ+gXytk6/ar9NBMUCCj7oPEcMd2havKSReq58wORnauFv53C7xRIC
         jQdJUKYc4N+3WCjXQHldWtmz6VBsAW9H6saHYqWNcpxESCb3yKpuDQVHc8dlLIRSAoE7
         w4UPMetcCU+m8BJR9piDW+DzK3dMd38KWKLeEQ8/S/Yimg22xsQEtGiO3a9XgUT7QjKu
         7S35fdvWRNzEeIptooe0pFK5RJ5VdjZcQ+ntReJEnyenhS53Pcd4YGKU80w14vq7K/ah
         hNJnTP+BKz3oh0YQaVMjFAz/DResZr/8QUSFU4AaIvEBFVotPwShfkXZPFYuWnzgPaxw
         Rvcg==
X-Gm-Message-State: AC+VfDw4b4CyltOCQgt2uWibbx6FjqE3mhXZgghEZbOObzrXQgVcD5Ry
        olNPUmME0W8MwovAD80Nqv4=
X-Google-Smtp-Source: ACHHUZ44LulQ9DHRQB907vvxaye5/xlqtk9kO3d51mVdftMDaYqu+C87L1Li8St0w+PV9GbRT2UzZw==
X-Received: by 2002:a17:907:3f0a:b0:970:73f0:19c9 with SMTP id hq10-20020a1709073f0a00b0097073f019c9mr2324132ejc.71.1686063406848;
        Tue, 06 Jun 2023 07:56:46 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-82-53-214-132.retail.telecomitalia.it. [82.53.214.132])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709063e4f00b00965c529f103sm5619618eji.86.2023.06.06.07.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:56:46 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [RFC PATCH v2 7/7] mm: zswap: remove zswap_header
Date:   Tue,  6 Jun 2023 16:56:11 +0200
Message-Id: <20230606145611.704392-8-cerasuolodomenico@gmail.com>
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
index ef8604812352..f689444dd5a7 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -193,7 +193,7 @@ struct zswap_pool {
  */
 struct zswap_entry {
 	struct rb_node rbnode;
-	pgoff_t offset;
+	swp_entry_t swpentry;
 	int refcount;
 	unsigned int length;
 	struct zswap_pool *pool;
@@ -205,10 +205,6 @@ struct zswap_entry {
 	struct list_head lru;
 };
 
-struct zswap_header {
-	swp_entry_t swpentry;
-};
-
 /*
  * The tree lock in the zswap_tree struct protects a few things:
  * - the rbtree
@@ -250,7 +246,7 @@ static bool zswap_has_pool;
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
 		 zpool_get_type((p)->zpool))
 
-static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap_header *zhdr,
+static int zswap_writeback_entry(struct zswap_entry *entry,
 				 struct zswap_tree *tree);
 static int zswap_pool_get(struct zswap_pool *pool);
 static void zswap_pool_put(struct zswap_pool *pool);
@@ -311,12 +307,14 @@ static struct zswap_entry *zswap_rb_search(struct rb_root *root, pgoff_t offset)
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
@@ -333,13 +331,15 @@ static int zswap_rb_insert(struct rb_root *root, struct zswap_entry *entry,
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
@@ -598,7 +598,6 @@ static struct zswap_pool *zswap_pool_find_get(char *type, char *compressor)
 static int zswap_shrink(struct zswap_pool *pool)
 {
 	struct zswap_entry *lru_entry, *tree_entry = NULL;
-	struct zswap_header *zhdr;
 	struct zswap_tree *tree;
 	int swpoffset;
 	int ret;
@@ -611,15 +610,13 @@ static int zswap_shrink(struct zswap_pool *pool)
 	}
 	lru_entry = list_last_entry(&pool->lru, struct zswap_entry, lru);
 	list_del_init(&lru_entry->lru);
-	zhdr = zpool_map_handle(pool->zpool, lru_entry->handle, ZPOOL_MM_RO);
-	tree = zswap_trees[swp_type(zhdr->swpentry)];
-	zpool_unmap_handle(pool->zpool, lru_entry->handle);
 	/*
 	 * Once the pool lock is dropped, the lru_entry might get freed. The
 	 * swpoffset is copied to the stack, and lru_entry isn't deref'd again
 	 * until the entry is verified to still be alive in the tree.
 	 */
-	swpoffset = swp_offset(zhdr->swpentry);
+	swpoffset = swp_offset(lru_entry->swpentry);
+	tree = zswap_trees[swp_type(lru_entry->swpentry)];
 	spin_unlock(&pool->lru_lock);
 
 	/* hold a reference from tree so it won't be freed during writeback */
@@ -633,7 +630,7 @@ static int zswap_shrink(struct zswap_pool *pool)
 	}
 	spin_unlock(&tree->lock);
 
-	ret = zswap_writeback_entry(lru_entry, zhdr, tree);
+	ret = zswap_writeback_entry(lru_entry, tree);
 
 	spin_lock(&tree->lock);
 	if (ret) {
@@ -1046,10 +1043,10 @@ static int zswap_get_swap_cache_page(swp_entry_t entry,
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
@@ -1089,7 +1086,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap_header
 		 * writing.
 		 */
 		spin_lock(&tree->lock);
-		if (zswap_rb_search(&tree->rbroot, entry->offset) != entry) {
+		if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) != entry) {
 			spin_unlock(&tree->lock);
 			delete_from_swap_cache(page_folio(page));
 			ret = -ENOMEM;
@@ -1101,8 +1098,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap_header
 		acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 		dlen = PAGE_SIZE;
 
-		zhdr = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
-		src = (u8 *)zhdr + sizeof(struct zswap_header);
+		src = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
 		if (!zpool_can_sleep_mapped(pool)) {
 			memcpy(tmp, src, entry->length);
 			src = tmp;
@@ -1196,11 +1192,10 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
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
@@ -1245,7 +1240,7 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
 		src = kmap_atomic(page);
 		if (zswap_is_page_same_filled(src, &value)) {
 			kunmap_atomic(src);
-			entry->offset = offset;
+			entry->swpentry = swp_entry(type, offset);
 			entry->length = 0;
 			entry->value = value;
 			atomic_inc(&zswap_same_filled_pages);
@@ -1299,11 +1294,10 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
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
@@ -1313,13 +1307,12 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
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
 
@@ -1418,7 +1411,6 @@ static int zswap_frontswap_load(unsigned type, pgoff_t offset,
 	/* decompress */
 	dlen = PAGE_SIZE;
 	src = zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL_MM_RO);
-	src += sizeof(struct zswap_header);
 
 	if (!zpool_can_sleep_mapped(entry->pool->zpool)) {
 		memcpy(tmp, src, entry->length);
-- 
2.34.1

