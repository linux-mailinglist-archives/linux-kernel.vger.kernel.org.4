Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D9072BD31
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjFLJyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjFLJyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 05:54:01 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16AA5FF1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9741caaf9d4so612377866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 02:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686562703; x=1689154703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYQpKJ28RkPZW3NObwb2r+lw4fKc8lZ4o5qJebIhoW0=;
        b=BS47izYkA4or+JYwN3wR0jWIAr7/ME4QNRglwncxoAQO9o+6LY1zTB3kY03hwJHju2
         WMBjUOjW/qkJNlH28JdJ+xMVSh3pUuJFN7OzEc0McBsreP74hbwgjYAzIoGkOnD0l5R+
         r6QSkkJ2vh72n0/AFNniae1QDv+V4M4vYBiYrsQlOafLteiOGGVzFeSu2+DZXGjsCezo
         vZkT2lVVm5g49PS8kRftdY2RJiwWYCJJN6sI2bNJ/eySFQ2SQIXXzmm2FAJNYtOdFqxO
         6oq2UZjsDZ+09NG2OC5ZxQn26q5+eO6dFGX0+U+ujkJT9Lajq6pG9FJYc1FbfqSwS/t0
         N3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686562703; x=1689154703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYQpKJ28RkPZW3NObwb2r+lw4fKc8lZ4o5qJebIhoW0=;
        b=jcfLaSuzjE5GyaQwoMMjdEQl1mbDz53cw4l21og27wZ1NRY+8fB9Pj7s4OuiHdi7tZ
         KeP26AO7IuRYpqPdQs0Gf/w3H20LUzXGqe9mFcSJP5opjlCGusG3QBTr1BCA7JsLqsSN
         aqVD6kJDUwyQvR2EnXPHVxByOXOcr1ygnqiOAV1j3SR8Q127rUXC+bf+SGrgc4+xASyK
         PgCWrh4zkEO5WMSWiKb0Idyk+Bir3AU+Jc21fYqaJZrbHM6CNFjREjQOZhS0i2Pxj/zC
         8xTq9Y+7GlVKEm/q1cTXCoCftcQk6VV+zfcbuI3SEyGl6G2ABHtKBEYfHMiO3UXOE/1r
         04TQ==
X-Gm-Message-State: AC+VfDyXFPeBE1qnFS3kCrP5U8jT+OK8OmNL9lgjKSWtNGVfn2gUwXLN
        RsA+DZi4XGI287xsOFW3F9haVcNpqlyI/lM0
X-Google-Smtp-Source: ACHHUZ6Ig9GsZfwV+Y9+P73Dv4hJNyxOlnWH4bLFoYv6LKiG4MBKz3X8HRd4297KFDPeb/M14sM/3w==
X-Received: by 2002:a17:907:6da5:b0:974:4a33:83a7 with SMTP id sb37-20020a1709076da500b009744a3383a7mr8294900ejc.12.1686562702987;
        Mon, 12 Jun 2023 02:38:22 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-212-171-43-8.retail.telecomitalia.it. [212.171.43.8])
        by smtp.gmail.com with ESMTPSA id ce23-20020a170906b25700b0097887b68c17sm4951358ejb.98.2023.06.12.02.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 02:38:22 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [PATCH v3 2/7] mm: zswap: remove page reclaim logic from zbud
Date:   Mon, 12 Jun 2023 11:38:10 +0200
Message-Id: <20230612093815.133504-3-cerasuolodomenico@gmail.com>
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

Switch zbud to the new generic zswap LRU and remove its custom
implementation.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 mm/zbud.c | 163 +-----------------------------------------------------
 1 file changed, 1 insertion(+), 162 deletions(-)

diff --git a/mm/zbud.c b/mm/zbud.c
index 3acd26193920..9d35fd4091ed 100644
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
@@ -585,7 +425,6 @@ static struct zpool_driver zbud_zpool_driver = {
 	.destroy =	zbud_zpool_destroy,
 	.malloc =	zbud_zpool_malloc,
 	.free =		zbud_zpool_free,
-	.shrink =	zbud_zpool_shrink,
 	.map =		zbud_zpool_map,
 	.unmap =	zbud_zpool_unmap,
 	.total_size =	zbud_zpool_total_size,
-- 
2.34.1

