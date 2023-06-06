Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CC9724711
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbjFFO5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbjFFO5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:57:02 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71463172E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:56:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51458e3af68so9150596a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686063399; x=1688655399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TN78WiIx7cKXEIt/YKhQKp1rR04fEU3vjXSMTSFKJB8=;
        b=Zmi/pM5GeX1TCkDu0/TcsPvYa0WHt9FdbFsYAg17+aTuvKSuiIDo85Ig8fOayfYnVZ
         odUqr0prtaZ8I6zWF9wcSKNIPNc7vNIzbG7ClXKrafjf86aD006b28o6zf5W1R3duQY+
         3yjffZTjiGYCw/PpvsvmwGyYfSN2bP1c78vTirIqcqdwDZjYqSs7LmIfy/ZhoWWi2/ME
         Rfh+SDW6e6FBVWPOzaQGiKK/7EC8vu6+GTvhx5lfNLwG8idoaY4Xc4CKf/HJEVQRp/M2
         kAoa3YZ5TS6rffRSPrPYDK0ibprRjmOqVU13g+9sY2TTnZt6/cmA1mgnsvQGTLIDP2so
         Le/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686063399; x=1688655399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TN78WiIx7cKXEIt/YKhQKp1rR04fEU3vjXSMTSFKJB8=;
        b=iMkY1Nx/iroQ8LUc2Dh3pV6v7W5+EdKFDUv5R4i55eKCvfKD17djP2p7U+M2M886ai
         hyEgbRJLxXvlqF6lfAxypk7t/kbq8+CaQ9Txc3H34i/WXnnpLNMKpVKRdJ2pME6NerMI
         M2QGfA0Xiyewm2pGrK2CuD9f1PjXPOUjQb3JEfrId0VFZzgbQD3ifjFVr5FJMnvxonJw
         EZesS7pwCeGeDmz5RRb+nug8uXK99k2I1Ly7KpfmmU856EkYGemSs4ODwjwamDwu6ztK
         lsjKcQlpzAvuTxh9J7bdQNxJzzhrg6olTRwlsStFfgfpNlgI3RDr9TJwfDtpkcAX1qqk
         ptsg==
X-Gm-Message-State: AC+VfDxEi2U/FHh9Tcrjr/lj4BY0EcqYFGWns5tZi+QAIj5hIJKBuKZD
        R8pL1/JgU5WdyI+S4g4lSuU=
X-Google-Smtp-Source: ACHHUZ7h0Sy8I8sy+GvB4+qK53PAR243yh2fyrMJjzTc76KSOjo3ZHg0Z/bVWRvlHrf19liu0BKU3w==
X-Received: by 2002:a17:907:3189:b0:966:4bb3:df63 with SMTP id xe9-20020a170907318900b009664bb3df63mr2939539ejb.63.1686063399576;
        Tue, 06 Jun 2023 07:56:39 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-82-53-214-132.retail.telecomitalia.it. [82.53.214.132])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709063e4f00b00965c529f103sm5619618eji.86.2023.06.06.07.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:56:39 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [RFC PATCH v2 2/7] mm: zswap: remove page reclaim logic from zbud
Date:   Tue,  6 Jun 2023 16:56:06 +0200
Message-Id: <20230606145611.704392-3-cerasuolodomenico@gmail.com>
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

With the recent enhancement to zswap enabling direct page writeback, the
need for the shrink code in zbud has become obsolete. As a result, this
commit removes the page reclaim logic from zbud entirely.

Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zbud.c | 164 +-----------------------------------------------------
 1 file changed, 2 insertions(+), 162 deletions(-)

diff --git a/mm/zbud.c b/mm/zbud.c
index 3acd26193920..19bc662ef5e9 100644
--- a/mm/zbud.c
+++ b/mm/zbud.c
@@ -83,11 +83,7 @@ struct zbud_pool;
  *		its free region.
  * @buddied:	list tracking the zbud pages that contain two buddies;
  *		these zbud pages are full
- * @lru:	list tracking the zbud pages in LRU order by most recently
- *		added buddy.
  * @pages_nr:	number of zbud pages in the pool.
- * @zpool:	zpool driver
- * @zpool_ops:	zpool operations structure with an evict callback
  *
  * This structure is allocated at pool creation time and maintains metadata
  * pertaining to a particular zbud pool.
@@ -102,26 +98,20 @@ struct zbud_pool {
 		struct list_head buddied;
 		struct list_head unbuddied[NCHUNKS];
 	};
-	struct list_head lru;
 	u64 pages_nr;
-	struct zpool *zpool;
-	const struct zpool_ops *zpool_ops;
 };
 
 /*
  * struct zbud_header - zbud page metadata occupying the first chunk of each
  *			zbud page.
  * @buddy:	links the zbud page into the unbuddied/buddied lists in the pool
- * @lru:	links the zbud page into the lru list in the pool
  * @first_chunks:	the size of the first buddy in chunks, 0 if free
  * @last_chunks:	the size of the last buddy in chunks, 0 if free
  */
 struct zbud_header {
 	struct list_head buddy;
-	struct list_head lru;
 	unsigned int first_chunks;
 	unsigned int last_chunks;
-	bool under_reclaim;
 };
 
 /*****************
@@ -149,8 +139,6 @@ static struct zbud_header *init_zbud_page(struct page *page)
 	zhdr->first_chunks = 0;
 	zhdr->last_chunks = 0;
 	INIT_LIST_HEAD(&zhdr->buddy);
-	INIT_LIST_HEAD(&zhdr->lru);
-	zhdr->under_reclaim = false;
 	return zhdr;
 }
 
@@ -221,7 +209,6 @@ static struct zbud_pool *zbud_create_pool(gfp_t gfp)
 	for_each_unbuddied_list(i, 0)
 		INIT_LIST_HEAD(&pool->unbuddied[i]);
 	INIT_LIST_HEAD(&pool->buddied);
-	INIT_LIST_HEAD(&pool->lru);
 	pool->pages_nr = 0;
 	return pool;
 }
@@ -310,11 +297,6 @@ static int zbud_alloc(struct zbud_pool *pool, size_t size, gfp_t gfp,
 		list_add(&zhdr->buddy, &pool->buddied);
 	}
 
-	/* Add/move zbud page to beginning of LRU */
-	if (!list_empty(&zhdr->lru))
-		list_del(&zhdr->lru);
-	list_add(&zhdr->lru, &pool->lru);
-
 	*handle = encode_handle(zhdr, bud);
 	spin_unlock(&pool->lock);
 
@@ -325,11 +307,6 @@ static int zbud_alloc(struct zbud_pool *pool, size_t size, gfp_t gfp,
  * zbud_free() - frees the allocation associated with the given handle
  * @pool:	pool in which the allocation resided
  * @handle:	handle associated with the allocation returned by zbud_alloc()
- *
- * In the case that the zbud page in which the allocation resides is under
- * reclaim, as indicated by the PG_reclaim flag being set, this function
- * only sets the first|last_chunks to 0.  The page is actually freed
- * once both buddies are evicted (see zbud_reclaim_page() below).
  */
 static void zbud_free(struct zbud_pool *pool, unsigned long handle)
 {
@@ -345,18 +322,11 @@ static void zbud_free(struct zbud_pool *pool, unsigned long handle)
 	else
 		zhdr->first_chunks = 0;
 
-	if (zhdr->under_reclaim) {
-		/* zbud page is under reclaim, reclaim will free */
-		spin_unlock(&pool->lock);
-		return;
-	}
-
 	/* Remove from existing buddy list */
 	list_del(&zhdr->buddy);
 
 	if (zhdr->first_chunks == 0 && zhdr->last_chunks == 0) {
 		/* zbud page is empty, free */
-		list_del(&zhdr->lru);
 		free_zbud_page(zhdr);
 		pool->pages_nr--;
 	} else {
@@ -368,110 +338,6 @@ static void zbud_free(struct zbud_pool *pool, unsigned long handle)
 	spin_unlock(&pool->lock);
 }
 
-/**
- * zbud_reclaim_page() - evicts allocations from a pool page and frees it
- * @pool:	pool from which a page will attempt to be evicted
- * @retries:	number of pages on the LRU list for which eviction will
- *		be attempted before failing
- *
- * zbud reclaim is different from normal system reclaim in that the reclaim is
- * done from the bottom, up.  This is because only the bottom layer, zbud, has
- * information on how the allocations are organized within each zbud page. This
- * has the potential to create interesting locking situations between zbud and
- * the user, however.
- *
- * To avoid these, this is how zbud_reclaim_page() should be called:
- *
- * The user detects a page should be reclaimed and calls zbud_reclaim_page().
- * zbud_reclaim_page() will remove a zbud page from the pool LRU list and call
- * the user-defined eviction handler with the pool and handle as arguments.
- *
- * If the handle can not be evicted, the eviction handler should return
- * non-zero. zbud_reclaim_page() will add the zbud page back to the
- * appropriate list and try the next zbud page on the LRU up to
- * a user defined number of retries.
- *
- * If the handle is successfully evicted, the eviction handler should
- * return 0 _and_ should have called zbud_free() on the handle. zbud_free()
- * contains logic to delay freeing the page if the page is under reclaim,
- * as indicated by the setting of the PG_reclaim flag on the underlying page.
- *
- * If all buddies in the zbud page are successfully evicted, then the
- * zbud page can be freed.
- *
- * Returns: 0 if page is successfully freed, otherwise -EINVAL if there are
- * no pages to evict or an eviction handler is not registered, -EAGAIN if
- * the retry limit was hit.
- */
-static int zbud_reclaim_page(struct zbud_pool *pool, unsigned int retries)
-{
-	int i, ret, freechunks;
-	struct zbud_header *zhdr;
-	unsigned long first_handle = 0, last_handle = 0;
-
-	spin_lock(&pool->lock);
-	if (list_empty(&pool->lru)) {
-		spin_unlock(&pool->lock);
-		return -EINVAL;
-	}
-	for (i = 0; i < retries; i++) {
-		zhdr = list_last_entry(&pool->lru, struct zbud_header, lru);
-		list_del(&zhdr->lru);
-		list_del(&zhdr->buddy);
-		/* Protect zbud page against free */
-		zhdr->under_reclaim = true;
-		/*
-		 * We need encode the handles before unlocking, since we can
-		 * race with free that will set (first|last)_chunks to 0
-		 */
-		first_handle = 0;
-		last_handle = 0;
-		if (zhdr->first_chunks)
-			first_handle = encode_handle(zhdr, FIRST);
-		if (zhdr->last_chunks)
-			last_handle = encode_handle(zhdr, LAST);
-		spin_unlock(&pool->lock);
-
-		/* Issue the eviction callback(s) */
-		if (first_handle) {
-			ret = pool->zpool_ops->evict(pool->zpool, first_handle);
-			if (ret)
-				goto next;
-		}
-		if (last_handle) {
-			ret = pool->zpool_ops->evict(pool->zpool, last_handle);
-			if (ret)
-				goto next;
-		}
-next:
-		spin_lock(&pool->lock);
-		zhdr->under_reclaim = false;
-		if (zhdr->first_chunks == 0 && zhdr->last_chunks == 0) {
-			/*
-			 * Both buddies are now free, free the zbud page and
-			 * return success.
-			 */
-			free_zbud_page(zhdr);
-			pool->pages_nr--;
-			spin_unlock(&pool->lock);
-			return 0;
-		} else if (zhdr->first_chunks == 0 ||
-				zhdr->last_chunks == 0) {
-			/* add to unbuddied list */
-			freechunks = num_free_chunks(zhdr);
-			list_add(&zhdr->buddy, &pool->unbuddied[freechunks]);
-		} else {
-			/* add to buddied list */
-			list_add(&zhdr->buddy, &pool->buddied);
-		}
-
-		/* add to beginning of LRU */
-		list_add(&zhdr->lru, &pool->lru);
-	}
-	spin_unlock(&pool->lock);
-	return -EAGAIN;
-}
-
 /**
  * zbud_map() - maps the allocation associated with the given handle
  * @pool:	pool in which the allocation resides
@@ -518,14 +384,7 @@ static void *zbud_zpool_create(const char *name, gfp_t gfp,
 			       const struct zpool_ops *zpool_ops,
 			       struct zpool *zpool)
 {
-	struct zbud_pool *pool;
-
-	pool = zbud_create_pool(gfp);
-	if (pool) {
-		pool->zpool = zpool;
-		pool->zpool_ops = zpool_ops;
-	}
-	return pool;
+	return zbud_create_pool(gfp);
 }
 
 static void zbud_zpool_destroy(void *pool)
@@ -543,25 +402,6 @@ static void zbud_zpool_free(void *pool, unsigned long handle)
 	zbud_free(pool, handle);
 }
 
-static int zbud_zpool_shrink(void *pool, unsigned int pages,
-			unsigned int *reclaimed)
-{
-	unsigned int total = 0;
-	int ret = -EINVAL;
-
-	while (total < pages) {
-		ret = zbud_reclaim_page(pool, 8);
-		if (ret < 0)
-			break;
-		total++;
-	}
-
-	if (reclaimed)
-		*reclaimed = total;
-
-	return ret;
-}
-
 static void *zbud_zpool_map(void *pool, unsigned long handle,
 			enum zpool_mapmode mm)
 {
@@ -585,7 +425,7 @@ static struct zpool_driver zbud_zpool_driver = {
 	.destroy =	zbud_zpool_destroy,
 	.malloc =	zbud_zpool_malloc,
 	.free =		zbud_zpool_free,
-	.shrink =	zbud_zpool_shrink,
+	.shrink =	NULL,
 	.map =		zbud_zpool_map,
 	.unmap =	zbud_zpool_unmap,
 	.total_size =	zbud_zpool_total_size,
-- 
2.34.1

