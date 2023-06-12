Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096F572BD45
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjFLJzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjFLJyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:54:03 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BA549E0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so10462617a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686562708; x=1689154708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtDbY3geJk5ZFtkgOT5O5EUWsoo6AICXqA8Xr4TghOM=;
        b=sbtrlJfjq4iOA2iKxVvlVUOSJqU+wWrzWL5qkr7NPaCf0qspebF+DperUWmXtMsLN7
         awsXcdmmd3l5lMRpE1uWm4Giyfpswpz59osjNefCCyHA+bAac/onBHIcr7U7qMwjPYPn
         Y7held6fOw7FIBMb+tQOwpsJtbCGa9QQPho8tZFf1E97/Tmo1q9+MCfnzmdVYUHpWBX/
         9jjsSc9HNbCXfd+48kzRAY23T92961bkPMF7VoN50AjcHvTHkQ7Q+vTchaFUC3bbgbpK
         FefZWzCUGcr60mNZWhF4mhpksv5TtnPksEsoKqaTkB5qzYsVkIKSRxIsFKaQ2VQfvt71
         mF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562708; x=1689154708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtDbY3geJk5ZFtkgOT5O5EUWsoo6AICXqA8Xr4TghOM=;
        b=XFhFZeSKg3Xc33ve79tWcP1jcr1IoBh2QVodWnp4bKULtnTaTi5PIbzUiLgacvLZ9k
         8jkMOtch8lUrayELobkgbjQJ3Mgfk5idkNWGNhHaJ+cOxPg2r0lbpFOCn1ZXuOApZhev
         XtZECQ8JuYpIq5a2XHH6FJFVioSRfkztHAnyLlE+2y7vwUf2u50ZhkpVhCzeQQKA2MfA
         g1VYE8TS8T/gyWqB3vFGRhmERcNbDzF3cDuSR/iWIlmWl8MfWQtFtdI6SBUdW4uofde3
         +qtws629V+5UzzXH3Pb/ZI92YO4coOtXG1Uhbjaez1KOAgpfx6c2/UR4B6lLRDZ5YYf2
         JQdg==
X-Gm-Message-State: AC+VfDw6B+GewEi6BB+0Tew+OXH6FaYqQAUb5cGXY9fV1UPLv/mzxwsZ
        K5nbu+z+6ug9hyz2AsKsxPo=
X-Google-Smtp-Source: ACHHUZ5jdk574K53jAuDd36SfnD+TsI8d0fI044BN7IUN/jGQusjkNJ8HZapcVM3ykunUY7a3uRgmQ==
X-Received: by 2002:a17:906:7953:b0:973:92a8:f611 with SMTP id l19-20020a170906795300b0097392a8f611mr8867651ejo.31.1686562708286;
        Mon, 12 Jun 2023 02:38:28 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-212-171-43-8.retail.telecomitalia.it. [212.171.43.8])
        by smtp.gmail.com with ESMTPSA id ce23-20020a170906b25700b0097887b68c17sm4951358ejb.98.2023.06.12.02.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:38:27 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v3 6/7] mm: zswap: simplify writeback function
Date:   Mon, 12 Jun 2023 11:38:14 +0200
Message-Id: <20230612093815.133504-7-cerasuolodomenico@gmail.com>
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

zswap_writeback_entry() used to be a callback for the backends, which
don't know about struct zswap_entry.

Now that the only user is the generic zswap LRU reclaimer, it can be
simplified: pass the pinned zswap_entry directly, and consolidate the
refcount management in the shrink function.

Tested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zswap.c | 70 +++++++++++++++---------------------------------------
 1 file changed, 19 insertions(+), 51 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index a4f8c20e161b..3a6b07a19262 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -254,7 +254,8 @@ static bool zswap_has_pool;
 	pr_debug("%s pool %s/%s\n", msg, (p)->tfm_name,		\
 		 zpool_get_type((p)->zpool))
 
-static int zswap_writeback_entry(struct zpool *pool, unsigned long handle);
+static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap_header *zhdr,
+				 struct zswap_tree *tree);
 static int zswap_pool_get(struct zswap_pool *pool);
 static void zswap_pool_put(struct zswap_pool *pool);
 
@@ -635,7 +636,7 @@ static int zswap_reclaim_entry(struct zswap_pool *pool)
 	zswap_entry_get(entry);
 	spin_unlock(&tree->lock);
 
-	ret = zswap_writeback_entry(pool->zpool, entry->handle);
+	ret = zswap_writeback_entry(entry, zhdr, tree);
 
 	spin_lock(&tree->lock);
 	if (ret) {
@@ -643,8 +644,17 @@ static int zswap_reclaim_entry(struct zswap_pool *pool)
 		spin_lock(&pool->lru_lock);
 		list_move(&entry->lru, &pool->lru);
 		spin_unlock(&pool->lru_lock);
+		goto put_unlock;
 	}
 
+	/* Check for invalidate() race */
+	if (entry != zswap_rb_search(&tree->rbroot, swpoffset))
+		goto put_unlock;
+
+	/* Drop base reference */
+	zswap_entry_put(tree, entry);
+
+put_unlock:
 	/* Drop local reference */
 	zswap_entry_put(tree, entry);
 unlock:
@@ -1045,16 +1055,14 @@ static int zswap_get_swap_cache_page(swp_entry_t entry,
  * the swap cache, the compressed version stored by zswap can be
  * freed.
  */
-static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
+static int zswap_writeback_entry(struct zswap_entry *entry, struct zswap_header *zhdr,
+				 struct zswap_tree *tree)
 {
-	struct zswap_header *zhdr;
-	swp_entry_t swpentry;
-	struct zswap_tree *tree;
-	pgoff_t offset;
-	struct zswap_entry *entry;
+	swp_entry_t swpentry = zhdr->swpentry;
 	struct page *page;
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
+	struct zpool *pool = entry->pool->zpool;
 
 	u8 *src, *tmp = NULL;
 	unsigned int dlen;
@@ -1069,25 +1077,6 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 			return -ENOMEM;
 	}
 
-	/* extract swpentry from data */
-	zhdr = zpool_map_handle(pool, handle, ZPOOL_MM_RO);
-	swpentry = zhdr->swpentry; /* here */
-	tree = zswap_trees[swp_type(swpentry)];
-	offset = swp_offset(swpentry);
-	zpool_unmap_handle(pool, handle);
-
-	/* find and ref zswap entry */
-	spin_lock(&tree->lock);
-	entry = zswap_entry_find_get(&tree->rbroot, offset);
-	if (!entry) {
-		/* entry was invalidated */
-		spin_unlock(&tree->lock);
-		kfree(tmp);
-		return 0;
-	}
-	spin_unlock(&tree->lock);
-	BUG_ON(offset != entry->offset);
-
 	/* try to allocate swap cache page */
 	switch (zswap_get_swap_cache_page(swpentry, &page)) {
 	case ZSWAP_SWAPCACHE_FAIL: /* no memory or invalidate happened */
@@ -1121,12 +1110,12 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 		dlen = PAGE_SIZE;
 
-		zhdr = zpool_map_handle(pool, handle, ZPOOL_MM_RO);
+		zhdr = zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
 		src = (u8 *)zhdr + sizeof(struct zswap_header);
 		if (!zpool_can_sleep_mapped(pool)) {
 			memcpy(tmp, src, entry->length);
 			src = tmp;
-			zpool_unmap_handle(pool, handle);
+			zpool_unmap_handle(pool, entry->handle);
 		}
 
 		mutex_lock(acomp_ctx->mutex);
@@ -1141,7 +1130,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 		if (!zpool_can_sleep_mapped(pool))
 			kfree(tmp);
 		else
-			zpool_unmap_handle(pool, handle);
+			zpool_unmap_handle(pool, entry->handle);
 
 		BUG_ON(ret);
 		BUG_ON(dlen != PAGE_SIZE);
@@ -1158,23 +1147,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	put_page(page);
 	zswap_written_back_pages++;
 
-	spin_lock(&tree->lock);
-	/* drop local reference */
-	zswap_entry_put(tree, entry);
-
-	/*
-	* There are two possible situations for entry here:
-	* (1) refcount is 1(normal case),  entry is valid and on the tree
-	* (2) refcount is 0, entry is freed and not on the tree
-	*     because invalidate happened during writeback
-	*  search the tree and free the entry if find entry
-	*/
-	if (entry == zswap_rb_search(&tree->rbroot, offset))
-		zswap_entry_put(tree, entry);
-	spin_unlock(&tree->lock);
-
 	return ret;
-
 fail:
 	if (!zpool_can_sleep_mapped(pool))
 		kfree(tmp);
@@ -1183,13 +1156,8 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	* if we get here due to ZSWAP_SWAPCACHE_EXIST
 	* a load may be happening concurrently.
 	* it is safe and okay to not free the entry.
-	* if we free the entry in the following put
 	* it is also okay to return !0
 	*/
-	spin_lock(&tree->lock);
-	zswap_entry_put(tree, entry);
-	spin_unlock(&tree->lock);
-
 	return ret;
 }
 
-- 
2.34.1

