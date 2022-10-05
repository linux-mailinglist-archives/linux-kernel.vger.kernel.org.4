Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28875F5982
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiJESEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiJESD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:03:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B7F7172C;
        Wed,  5 Oct 2022 11:03:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so2504103pjk.2;
        Wed, 05 Oct 2022 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVCvABAzZpcB1Yd0f9owRm5bhoDgwilteM8uMFdB0/0=;
        b=mpUGQ5wAmEoiNp0TsmAkDQGf+3eb7aR2cKLQ2LZhfehStaXh3JnCppkRW8LZPCe+by
         e5zvBFzm7soKVLdanhXKl6KQkT5/DjXZ3Cj87nV2zgPNOlq4Ce/iBJ2Jx+nVtl46XtgO
         kvOOEfGTXRbBxt3RFHLzzbUkPtY0x8lrK9bfEW8oClsisY3LJz8TAGkG8ECg8oGuqLug
         MwOm7PHTqecK5bdLmTNbGvcUHt8VRTZ7ZO7Di2OEgigK/uj59HJJjBNLD730OLo24uVk
         cL6i3sX2VgLkHJ/H/o6n+XOrMls9fxAGxsz8xuQw+BOiyoEjMpwpRgo4fXMfF2On929R
         oJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVCvABAzZpcB1Yd0f9owRm5bhoDgwilteM8uMFdB0/0=;
        b=kqlVlxiHBq8nEnjEasBqJF6zHeCDLz6DGAI1dI30/5e0zZdah4nOYGct0iOnfFb6jL
         sXkEPBhfI77YkIH1qTdHvRrgqbAgpPq+2BGV5cA0RQTnbwOGGvE+t8lSAdlNgDeZOvgJ
         hVtIVqNK5oFjyzZ0ojOtHMAAkfpcq69Fpk9D3gA6XHGvkSP49oqKYdf4hg2oly+eWA6G
         7n0ADh2lvPEghEfT9HMsREOft7t8/CxIbzrkXkPJZDyInDXfGxCirJ2gi/i3ynWZBgIK
         Ehd2xegbxHkwTJZ8BXkRItcau3tfkG+21MjLOGGfBUDGtTzB2I0DTmLNAg60ItGO4Sk2
         QYOQ==
X-Gm-Message-State: ACrzQf1qwQTPu+lKMO4wvBlSlaoWS7TCWoHiX/R3AD2lsCx7Mj9Fw0lM
        h8SI90HUR5b10p6T+k2EDE4=
X-Google-Smtp-Source: AMsMyM76elMyGdYLqmYEzlb0EvZzQrrcq16s35J/Z6liGP+p+uL1N0ov5WsEO+IIPHGlxZIw64UlmQ==
X-Received: by 2002:a17:902:e952:b0:17c:2eee:c0ce with SMTP id b18-20020a170902e95200b0017c2eeec0cemr676521pll.145.1664993035919;
        Wed, 05 Oct 2022 11:03:55 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id y17-20020a170903011100b001788494b764sm10674639plc.231.2022.10.05.11.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 11:03:55 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mm: mempool: introduce page bulk allocator
Date:   Wed,  5 Oct 2022 11:03:39 -0700
Message-Id: <20221005180341.1738796-3-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20221005180341.1738796-1-shy828301@gmail.com>
References: <20221005180341.1738796-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since v5.13 the page bulk allocator was introduced to allocate order-0
pages in bulk.  There are a few mempool allocator callers which does
order-0 page allocation in a loop, for example, dm-crypt, f2fs compress,
etc.  A mempool page bulk allocator seems useful.  So introduce the
mempool page bulk allocator.

It introduces the below APIs:
  - mempool_init_pages_bulk()
  - mempool_create_pages_bulk()
They initialize the mempool for page bulk allocator.  The pool is filled
by alloc_page() in a loop.

  - mempool_alloc_pages_bulk_list()
  - mempool_alloc_pages_bulk_array()
They do bulk allocation from mempool.
They do the below conceptually:
  1. Call bulk page allocator
  2. If the allocation is fulfilled then return otherwise try to
     allocate the remaining pages from the mempool
  3. If it is fulfilled then return otherwise retry from #1 with sleepable
     gfp
  4. If it is still failed, sleep for a while to wait for the mempool is
     refilled, then retry from #1
The populated pages will stay on the list or array until the callers
consume them or free them.
Since mempool allocator is guaranteed to success in the sleepable context,
so the two APIs return true for success or false for fail.  It is the
caller's responsibility to handle failure case (partial allocation), just
like the page bulk allocator.

The mempool typically is an object agnostic allocator, but bulk allocation
is only supported by pages, so the mempool bulk allocator is for page
allocation only as well.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/mempool.h |  19 ++++
 mm/mempool.c            | 188 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 197 insertions(+), 10 deletions(-)

diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index 0c964ac107c2..8bad28bceaa8 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -13,6 +13,11 @@ struct kmem_cache;
 typedef void * (mempool_alloc_t)(gfp_t gfp_mask, void *pool_data);
 typedef void (mempool_free_t)(void *element, void *pool_data);
 
+typedef unsigned int (mempool_alloc_pages_bulk_t)(gfp_t gfp_mask,
+					unsigned int nr, void *pool_data,
+					struct list_head *page_list,
+					struct page **page_array);
+
 typedef struct mempool_s {
 	spinlock_t lock;
 	int min_nr;		/* nr of elements at *elements */
@@ -22,6 +27,7 @@ typedef struct mempool_s {
 	void *pool_data;
 	mempool_alloc_t *alloc;
 	mempool_free_t *free;
+	mempool_alloc_pages_bulk_t *alloc_pages_bulk;
 	wait_queue_head_t wait;
 } mempool_t;
 
@@ -36,18 +42,31 @@ int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
 		      gfp_t gfp_mask, int node_id);
 int mempool_init(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
 		 mempool_free_t *free_fn, void *pool_data);
+int mempool_init_pages_bulk(mempool_t *pool, int min_nr,
+			    mempool_alloc_pages_bulk_t *alloc_pages_bulk_fn,
+			    mempool_free_t *free_fn, void *pool_data);
 
 extern mempool_t *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
 			mempool_free_t *free_fn, void *pool_data);
 extern mempool_t *mempool_create_node(int min_nr, mempool_alloc_t *alloc_fn,
 			mempool_free_t *free_fn, void *pool_data,
 			gfp_t gfp_mask, int nid);
+extern mempool_t *mempool_create_pages_bulk(int min_nr,
+			mempool_alloc_pages_bulk_t *alloc_pages_bulk_fn,
+			mempool_free_t *free_fn, void *pool_data);
 
 extern int mempool_resize(mempool_t *pool, int new_min_nr);
 extern void mempool_destroy(mempool_t *pool);
 extern void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask) __malloc;
 extern void mempool_free(void *element, mempool_t *pool);
 
+extern bool mempool_alloc_pages_bulk_list(mempool_t *pool, gfp_t gfp_mask,
+					  unsigned int nr,
+					  struct list_head *page_list);
+extern bool mempool_alloc_pages_bulk_array(mempool_t *pool, gfp_t gfp_mask,
+					   unsigned int nr,
+					   struct page **page_array);
+
 /*
  * A mempool_alloc_t and mempool_free_t that get the memory from
  * a slab cache that is passed in through pool_data.
diff --git a/mm/mempool.c b/mm/mempool.c
index ba32151f3843..7711ca2e6d66 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -177,6 +177,7 @@ void mempool_destroy(mempool_t *pool)
 EXPORT_SYMBOL(mempool_destroy);
 
 static inline int __mempool_init(mempool_t *pool, int min_nr,
+				 mempool_alloc_pages_bulk_t *alloc_pages_bulk_fn,
 				 mempool_alloc_t *alloc_fn,
 				 mempool_free_t *free_fn, void *pool_data,
 				 gfp_t gfp_mask, int node_id)
@@ -186,8 +187,11 @@ static inline int __mempool_init(mempool_t *pool, int min_nr,
 	pool->pool_data = pool_data;
 	pool->alloc	= alloc_fn;
 	pool->free	= free_fn;
+	pool->alloc_pages_bulk = alloc_pages_bulk_fn;
 	init_waitqueue_head(&pool->wait);
 
+	WARN_ON_ONCE(alloc_pages_bulk_fn && alloc_fn);
+
 	pool->elements = kmalloc_array_node(min_nr, sizeof(void *),
 					    gfp_mask, node_id);
 	if (!pool->elements)
@@ -199,7 +203,10 @@ static inline int __mempool_init(mempool_t *pool, int min_nr,
 	while (pool->curr_nr < pool->min_nr) {
 		void *element;
 
-		element = pool->alloc(gfp_mask, pool->pool_data);
+		if (pool->alloc_pages_bulk)
+			element = alloc_page(gfp_mask);
+		else
+			element = pool->alloc(gfp_mask, pool->pool_data);
 		if (unlikely(!element)) {
 			mempool_exit(pool);
 			return -ENOMEM;
@@ -214,7 +221,7 @@ int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
 		      mempool_free_t *free_fn, void *pool_data,
 		      gfp_t gfp_mask, int node_id)
 {
-	return __mempool_init(pool, min_nr, alloc_fn, free_fn, pool_data,
+	return __mempool_init(pool, min_nr, NULL, alloc_fn, free_fn, pool_data,
 			      gfp_mask, node_id);
 }
 EXPORT_SYMBOL(mempool_init_node);
@@ -236,15 +243,40 @@ EXPORT_SYMBOL(mempool_init_node);
 int mempool_init(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
 		 mempool_free_t *free_fn, void *pool_data)
 {
-	return __mempool_init(pool, min_nr, alloc_fn, free_fn,
+	return __mempool_init(pool, min_nr, NULL, alloc_fn, free_fn,
 			      pool_data, GFP_KERNEL, NUMA_NO_NODE);
 
 }
 EXPORT_SYMBOL(mempool_init);
 
-static mempool_t *__mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
-				   mempool_free_t *free_fn, void *pool_data,
-				   gfp_t gfp_mask, int node_id)
+/**
+ * mempool_init_pages_bulk - initialize a pages pool for bulk allocator
+ * @pool: pointer to the memory pool that should be initialized
+ * @min_nr: the minimum number of elements guaranteed to be
+ *          allocated for this pool.
+ * @alloc_pages_bulk_fn: user-defined pages bulk allocation function.
+ * @free_fn: user-defined element-freeing function.
+ * @pool_data: optional private data available to the user-defined functions.
+ *
+ * Like mempool_create(), but initializes the pool in (i.e. embedded in another
+ * structure).
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+int mempool_init_pages_bulk(mempool_t *pool, int min_nr,
+			    mempool_alloc_pages_bulk_t *alloc_pages_bulk_fn,
+			    mempool_free_t *free_fn, void *pool_data)
+{
+	return __mempool_init(pool, min_nr, alloc_pages_bulk_fn, NULL,
+			      free_fn, pool_data, GFP_KERNEL, NUMA_NO_NODE);
+}
+EXPORT_SYMBOL(mempool_init_pages_bulk);
+
+static mempool_t *__mempool_create(int min_nr,
+			mempool_alloc_pages_bulk_t *alloc_pages_bulk_fn,
+			mempool_alloc_t *alloc_fn,
+			mempool_free_t *free_fn, void *pool_data,
+			gfp_t gfp_mask, int node_id)
 {
 	mempool_t *pool;
 
@@ -252,8 +284,8 @@ static mempool_t *__mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
 	if (!pool)
 		return NULL;
 
-	if (__mempool_init(pool, min_nr, alloc_fn, free_fn, pool_data,
-			   gfp_mask, node_id)) {
+	if (__mempool_init(pool, min_nr, alloc_pages_bulk_fn, alloc_fn,
+			   free_fn, pool_data, gfp_mask, node_id)) {
 		kfree(pool);
 		return NULL;
 	}
@@ -280,7 +312,7 @@ static mempool_t *__mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
 mempool_t *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
 				mempool_free_t *free_fn, void *pool_data)
 {
-	return __mempool_create(min_nr, alloc_fn, free_fn, pool_data,
+	return __mempool_create(min_nr, NULL, alloc_fn, free_fn, pool_data,
 				GFP_KERNEL, NUMA_NO_NODE);
 }
 EXPORT_SYMBOL(mempool_create);
@@ -289,11 +321,21 @@ mempool_t *mempool_create_node(int min_nr, mempool_alloc_t *alloc_fn,
 			       mempool_free_t *free_fn, void *pool_data,
 			       gfp_t gfp_mask, int node_id)
 {
-	return __mempool_create(min_nr, alloc_fn, free_fn, pool_data,
+	return __mempool_create(min_nr, NULL, alloc_fn, free_fn, pool_data,
 				gfp_mask, node_id);
 }
 EXPORT_SYMBOL(mempool_create_node);
 
+mempool_t* mempool_create_pages_bulk(int min_nr,
+			mempool_alloc_pages_bulk_t *alloc_pages_bulk_fn,
+			mempool_free_t *free_fn, void *pool_data)
+{
+	return __mempool_create(min_nr, alloc_pages_bulk_fn, NULL,
+				free_fn, pool_data, GFP_KERNEL,
+				NUMA_NO_NODE);
+}
+EXPORT_SYMBOL(mempool_create_pages_bulk);
+
 /**
  * mempool_resize - resize an existing memory pool
  * @pool:       pointer to the memory pool which was allocated via
@@ -457,6 +499,132 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(mempool_alloc);
 
+/**
+ * mempool_alloc_pages_bulk - allocate a bulk of pagesfrom a specific
+ *                           memory pool
+ * @pool:       pointer to the memory pool which was allocated via
+ *              mempool_create().
+ * @gfp_mask:   the usual allocation bitmask.
+ * @nr:         the number of requested pages.
+ * @page_list:  the list the pages will be added to.
+ * @page_array: the array the pages will be added to.
+ *
+ * this function only sleeps if the alloc_pages_bulk_fn() function sleeps
+ * or the allocation can not be satisfied even though the mempool is depleted.
+ * Note that due to preallocation, this function *never* fails when called
+ * from process contexts. (it might fail if called from an IRQ context.)
+ * Note: using __GFP_ZERO is not supported.  And the caller should not pass
+ * in both valid page_list and page_array.
+ *
+ * Return: true when nr pages are allocated or false if not.  It is the
+ *         caller's responsibility to free the partial allocated pages.
+ */
+static bool mempool_alloc_pages_bulk(mempool_t *pool, gfp_t gfp_mask,
+				     unsigned int nr,
+				     struct list_head *page_list,
+				     struct page **page_array)
+{
+	unsigned long flags;
+	wait_queue_entry_t wait;
+	gfp_t gfp_temp;
+	int i;
+	unsigned int ret, nr_remaining;
+	struct page *page;
+
+	VM_WARN_ON_ONCE(gfp_mask & __GFP_ZERO);
+	might_alloc(gfp_mask);
+
+	gfp_mask |= __GFP_NOMEMALLOC;   /* don't allocate emergency reserves */
+	gfp_mask |= __GFP_NORETRY;      /* don't loop in __alloc_pages */
+	gfp_mask |= __GFP_NOWARN;       /* failures are OK */
+
+	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO);
+
+repeat_alloc:
+	i = 0;
+	ret = pool->alloc_pages_bulk(gfp_temp, nr, pool->pool_data, page_list,
+				     page_array);
+
+	if (ret == nr)
+		return true;
+
+	nr_remaining = nr - ret;
+
+	spin_lock_irqsave(&pool->lock, flags);
+	/* Allocate page from the pool and add to the list or array */
+	while (pool->curr_nr && (nr_remaining > 0)) {
+		page = remove_element(pool);
+		spin_unlock_irqrestore(&pool->lock, flags);
+		smp_wmb();
+
+		kmemleak_update_trace((void *)page);
+
+		if (page_list)
+			list_add(&page->lru, page_list);
+		else
+			page_array[ret + i] = page;
+
+		i++;
+		nr_remaining--;
+
+		spin_lock_irqsave(&pool->lock, flags);
+	}
+
+	spin_unlock_irqrestore(&pool->lock, flags);
+
+	if (!nr_remaining)
+		return true;
+
+	/*
+	 * The bulk allocator counts in the populated pages for array,
+	 * but don't do it for list.
+	 */
+	if (page_list)
+		nr = nr_remaining;
+
+	/*
+	 * We use gfp mask w/o direct reclaim or IO for the first round.  If
+	 * alloc failed with that and @pool was empty, retry immediately.
+	 */
+	if (gfp_temp != gfp_mask) {
+		gfp_temp = gfp_mask;
+		goto repeat_alloc;
+	}
+
+	/* We must not sleep if !__GFP_DIRECT_RECLAIM */
+	if (!(gfp_mask & __GFP_DIRECT_RECLAIM))
+		return false;
+
+	/* Let's wait for someone else to return an element to @pool */
+	init_wait(&wait);
+	prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
+
+	/*
+	 * FIXME: this should be io_schedule().  The timeout is there as a
+	 * workaround for some DM problems in 2.6.18.
+	 */
+	io_schedule_timeout(5*HZ);
+
+	finish_wait(&pool->wait, &wait);
+	goto repeat_alloc;
+}
+
+bool mempool_alloc_pages_bulk_list(mempool_t *pool, gfp_t gfp_mask,
+				   unsigned int nr,
+				   struct list_head *page_list)
+{
+	return mempool_alloc_pages_bulk(pool, gfp_mask, nr, page_list, NULL);
+}
+EXPORT_SYMBOL(mempool_alloc_pages_bulk_list);
+
+bool mempool_alloc_pages_bulk_array(mempool_t *pool, gfp_t gfp_mask,
+				    unsigned int nr,
+				    struct page **page_array)
+{
+	return mempool_alloc_pages_bulk(pool, gfp_mask, nr, NULL, page_array);
+}
+EXPORT_SYMBOL(mempool_alloc_pages_bulk_array);
+
 /**
  * mempool_free - return an element to the pool.
  * @element:   pool element pointer.
-- 
2.26.3

