Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDE172217A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjFEIyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjFEIyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:54:33 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B358FE9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 01:54:28 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1b3836392so33292111fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 01:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685955267; x=1688547267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TN78WiIx7cKXEIt/YKhQKp1rR04fEU3vjXSMTSFKJB8=;
        b=UWV12U6c8huHFRDsSzfwHOrNWPM6lbwWeq0HFxKoyUB/+azTg5F3uh59/s64hax2vX
         NuiEstX02JUkFIc5aLWsrMnbkBJOZ5aIMVYRWMmOHb6XOPjz9WiAH0psHiQe7rkDapbn
         wEazo0J8Jb8aSbuPHmljoF9TZ3MtZ+e0lof7t5ujmz+el2GMiZhZuEQL2waB1bufhCVq
         BUpXy2rsuS66MEgOxXfiet5GJdfP/+PznOQAEySCDTd7pZlVCTx9FmqQdkw15Pc9h9ud
         zVbTg1eYYm7IUa1dERUQ+8Zsiv6/RohVbtOx4urbdqT/fo84rEUHIEEHXwxxA11zwk5u
         EAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685955267; x=1688547267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TN78WiIx7cKXEIt/YKhQKp1rR04fEU3vjXSMTSFKJB8=;
        b=Ux6iUYv/MXHsxeLMCTUexP9vlH5r1iABwTCbveEEuwxyHXlk7mPPIR6tC2TfeLmm6U
         Cn+PSpNl9HLknHYoc2Kks9jFPIYQB6Lw1A9CcV5SrRYoXiuylTnPrUsIyIPV5x63rj3k
         4wgj0Zu3cVmmRDbp0Fl0GxqIcRl+998wu08D74BQYxWDmITmx4uPfnmHCKcjD6k6t30h
         5cXbBBqFODYf+F7JEW9pAtuYapZRGE67UZi4St2MXmSrCSQSIkE+kEXlJfcD3uhd5hU6
         GQq3wcyFmN86tHk8s1O0oA1iBS4yZNwbqDDxT0v5pI3/IUUur8DF+qKVN5Qf4UnDWgzd
         WAwQ==
X-Gm-Message-State: AC+VfDy9fdPwlev62C1f7I2Iqh8DcIcSBF10Q5BE342rv9Xy5t3TLyjL
        CJ7RsFzQ+9+1pcSgNAm6/rk=
X-Google-Smtp-Source: ACHHUZ7HHuMCCI6vDLhBrlOivI1Buhm0espit1xD2A/mambYtBFBwmDn6jX/Y6pIMENcjNYb7sIlPg==
X-Received: by 2002:a2e:9a8b:0:b0:2b1:b814:c112 with SMTP id p11-20020a2e9a8b000000b002b1b814c112mr3128462lji.49.1685955266690;
        Mon, 05 Jun 2023 01:54:26 -0700 (PDT)
Received: from lelloman-5950.homenet.telecomitalia.it (host-82-53-8-153.retail.telecomitalia.it. [82.53.8.153])
        by smtp.gmail.com with ESMTPSA id lx5-20020a170906af0500b00965c6c63ea3sm4048915ejb.35.2023.06.05.01.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 01:54:26 -0700 (PDT)
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
To:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, yosryahmed@google.com, linux-mm@kvack.org
Cc:     ddstreet@ieee.org, sjenning@redhat.com, nphamcs@gmail.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Subject: [RFC PATCH 2/7] mm: zswap: remove page reclaim logic from zbud
Date:   Mon,  5 Jun 2023 10:54:14 +0200
Message-Id: <20230605085419.44383-3-cerasuolodomenico@gmail.com>
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

