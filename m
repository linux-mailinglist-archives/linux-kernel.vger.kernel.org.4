Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DADE696D86
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 20:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjBNTCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 14:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjBNTCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 14:02:46 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9D225E1D;
        Tue, 14 Feb 2023 11:02:40 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id t7so4983541ilq.2;
        Tue, 14 Feb 2023 11:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqvEeGV6oh0EWfoDksrWyy2/Blf2fwRqNf/jz7ukuRw=;
        b=XJb3P1GciLVeQG93r4o0mynAwuHd7u3qjuhxyiL0TEqMUd8vqu1fsRZ4Zfzb/k3DPU
         prTNpeY9UpiQ7F6VxxBag9eRJ2onavUHA2hM/fNVsfsis5vV0zbZXsKHxWFnJiZsPyMC
         ZtUy/4hdmnwt8HEoY2D8x/GuOhbx+p7zKivIYO4haVkzb/hKCf2QaUOAFbVw023mInPA
         Kwi1C/2Po0TUXCgEWVJjEw4GkHjc2JmuiT+ZYhNrIyZK+KxZy2OkNyEB4o+KpwFq9rpt
         LWvmGDrYIktQWZlXFNI9xbwzh7koFfoyxSmZ9Oksm6wdlIBi63AppQtvOcOJJN6gQ+8F
         +GkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqvEeGV6oh0EWfoDksrWyy2/Blf2fwRqNf/jz7ukuRw=;
        b=LAk/hRgl8NkVZ6asM7wUQwQtGAxK6oUALz5wq3ZnEbkxIGquv5LJsZ/YT2Kx+DhSmf
         T9yoJEqkxlEHHIafbrUwXNsFgPAGQ7LeqzR+cxniywo2OZPtzUXuHrVaaU98ehhO27nO
         Vf9T5UdZxTkevq8OqNq06WdgCR7JX6UsgbbDWxilAD6yHNPj3Zsf5Yy45h37ZW0N+ahv
         nfSSXUZQxEp6HkXXdyWpdw27MDSvNnRQxxKW7gAAA4PLHXVaPD1VaYVh6dDeUMKKt0YG
         b5VnWGUAaMu3z0XDJsK2kk4xuBqqao8FjiI7kwisM3qS0CGa5K3Zu5YTNMzJrnh8oRWe
         VVGg==
X-Gm-Message-State: AO0yUKVOTMDg+dirgrjqz+lBkqix497cb9rGnwXbEHYUIA/0k9oseChG
        6Qjyr2VHYV+6GIXuXiCLVQg=
X-Google-Smtp-Source: AK7set9w7As1PUAlwdFW1t3QYCy1I6uoqWw2i5qBHiV+D4qRRjOPuzWXvnCCj9OvgR5i77kopvWOXg==
X-Received: by 2002:a05:6e02:1a43:b0:310:ae72:32a0 with SMTP id u3-20020a056e021a4300b00310ae7232a0mr4441998ilv.21.1676401359609;
        Tue, 14 Feb 2023 11:02:39 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id r11-20020a056e0219cb00b0030c27c9eea4sm3608770ill.33.2023.02.14.11.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 11:02:39 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 3/5] mm: mempool: introduce page bulk allocator
Date:   Tue, 14 Feb 2023 11:02:19 -0800
Message-Id: <20230214190221.1156876-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230214190221.1156876-1-shy828301@gmail.com>
References: <20230214190221.1156876-1-shy828301@gmail.com>
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

  - mempool_alloc_pages_bulk_array()
  - mempool_alloc_pages_bulk_cb()
They do bulk allocation from mempool.
They do the below conceptually:
  1. Call bulk page allocator
  2. If the allocation is fulfilled then return otherwise try to
     allocate the remaining pages from the mempool
  3. If it is fulfilled then return otherwise retry from #1 with sleepable
     gfp
  4. If it is still failed, sleep for a while to wait for the mempool is
     refilled, then retry from #1
The populated pages will stay on the array until the callers consume them
or free them, or are consumed by the callback immediately.

Since mempool allocator is guaranteed to success in the sleepable context,
so the two APIs return true for success or false for fail.  It is the
caller's responsibility to handle failure case (partial allocation), just
like the page bulk allocator.

The mempool typically is an object agnostic allocator, but bulk allocation
is only supported by pages, so the mempool bulk allocator is for page
allocation only as well.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 include/linux/mempool.h |  21 +++++
 mm/mempool.c            | 177 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 181 insertions(+), 17 deletions(-)

diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index 4aae6c06c5f2..1907395b2ef5 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -13,6 +13,12 @@ struct kmem_cache;
 typedef void * (mempool_alloc_t)(gfp_t gfp_mask, void *pool_data);
 typedef void (mempool_free_t)(void *element, void *pool_data);
 
+typedef unsigned int (mempool_alloc_pages_bulk_t)(gfp_t gfp_mask,
+					unsigned int nr, void *pool_data,
+					struct page **page_array,
+					void (*cb)(struct page *, void *),
+					void *data);
+
 typedef struct mempool_s {
 	spinlock_t lock;
 	int min_nr;		/* nr of elements at *elements */
@@ -22,6 +28,7 @@ typedef struct mempool_s {
 	void *pool_data;
 	mempool_alloc_t *alloc;
 	mempool_free_t *free;
+	mempool_alloc_pages_bulk_t *alloc_pages_bulk;
 	wait_queue_head_t wait;
 } mempool_t;
 
@@ -41,18 +48,32 @@ int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
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
 
+extern bool mempool_alloc_pages_bulk_array(mempool_t *pool, gfp_t gfp_mask,
+					   unsigned int nr,
+					   struct page **page_array);
+extern bool mempool_alloc_pages_bulk_cb(mempool_t *pool, gfp_t gfp_mask,
+					unsigned int nr,
+					void (*cb)(struct page *, void *),
+					void *data);
+
 /*
  * A mempool_alloc_t and mempool_free_t that get the memory from
  * a slab cache that is passed in through pool_data.
diff --git a/mm/mempool.c b/mm/mempool.c
index 975c9d1491b6..dddcd847d765 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -183,6 +183,7 @@ void mempool_destroy(mempool_t *pool)
 EXPORT_SYMBOL(mempool_destroy);
 
 static inline int __mempool_init(mempool_t *pool, int min_nr,
+				 mempool_alloc_pages_bulk_t *alloc_pages_bulk_fn,
 				 mempool_alloc_t *alloc_fn,
 				 mempool_free_t *free_fn, void *pool_data,
 				 gfp_t gfp_mask, int node_id)
@@ -192,8 +193,11 @@ static inline int __mempool_init(mempool_t *pool, int min_nr,
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
@@ -205,7 +209,10 @@ static inline int __mempool_init(mempool_t *pool, int min_nr,
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
@@ -220,7 +227,7 @@ int mempool_init_node(mempool_t *pool, int min_nr, mempool_alloc_t *alloc_fn,
 		      mempool_free_t *free_fn, void *pool_data,
 		      gfp_t gfp_mask, int node_id)
 {
-	return __mempool_init(pool, min_nr, alloc_fn, free_fn, pool_data,
+	return __mempool_init(pool, min_nr, NULL, alloc_fn, free_fn, pool_data,
 			      gfp_mask, node_id);
 }
 EXPORT_SYMBOL(mempool_init_node);
@@ -242,14 +249,39 @@ EXPORT_SYMBOL(mempool_init_node);
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
 
@@ -257,8 +289,8 @@ static mempool_t *__mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
 	if (!pool)
 		return NULL;
 
-	if (__mempool_init(pool, min_nr, alloc_fn, free_fn, pool_data,
-			   gfp_mask, node_id)) {
+	if (__mempool_init(pool, min_nr, alloc_pages_bulk_fn, alloc_fn,
+			   free_fn, pool_data, gfp_mask, node_id)) {
 		kfree(pool);
 		return NULL;
 	}
@@ -285,7 +317,7 @@ static mempool_t *__mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
 mempool_t *mempool_create(int min_nr, mempool_alloc_t *alloc_fn,
 				mempool_free_t *free_fn, void *pool_data)
 {
-	return __mempool_create(min_nr, alloc_fn, free_fn, pool_data,
+	return __mempool_create(min_nr, NULL, alloc_fn, free_fn, pool_data,
 				GFP_KERNEL, NUMA_NO_NODE);
 }
 EXPORT_SYMBOL(mempool_create);
@@ -294,11 +326,21 @@ mempool_t *mempool_create_node(int min_nr, mempool_alloc_t *alloc_fn,
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
@@ -379,12 +421,23 @@ int mempool_resize(mempool_t *pool, int new_min_nr)
 }
 EXPORT_SYMBOL(mempool_resize);
 
-static void *__mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
+#define MEMPOOL_BULK_SUCCESS_PTR	((void *)16)
+
+static void * __mempool_alloc(mempool_t *pool, gfp_t gfp_mask, unsigned int nr,
+			      struct page **page_array,
+			      void (*cb)(struct page *, void *),
+			      void *data)
 {
 	void *element;
 	unsigned long flags;
 	wait_queue_entry_t wait;
 	gfp_t gfp_temp;
+	int i;
+	unsigned int ret, nr_remaining;
+	struct page *page;
+	bool bulk_page_alloc = true;
+
+	ret = nr_remaining = 0;
 
 	VM_WARN_ON_ONCE(gfp_mask & __GFP_ZERO);
 	might_alloc(gfp_mask);
@@ -395,14 +448,27 @@ static void *__mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
 
 	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO);
 
+	if ((nr == 1) && (!page_array && !cb && !data))
+		bulk_page_alloc = false;
+
 repeat_alloc:
+	i = 0;
+
+	if (bulk_page_alloc) {
+		ret = pool->alloc_pages_bulk(gfp_temp, nr, pool->pool_data,
+					     page_array, cb, data);
+		if (ret == nr)
+			return MEMPOOL_BULK_SUCCESS_PTR;
+	} else {
+		element = pool->alloc(gfp_temp, pool->pool_data);
+		if (likely(element != NULL))
+			return element;
+	}
 
-	element = pool->alloc(gfp_temp, pool->pool_data);
-	if (likely(element != NULL))
-		return element;
+	nr_remaining = nr - ret;
 
 	spin_lock_irqsave(&pool->lock, flags);
-	if (likely(pool->curr_nr)) {
+	while (pool->curr_nr && (nr_remaining > 0)) {
 		element = remove_element(pool);
 		spin_unlock_irqrestore(&pool->lock, flags);
 		/* paired with rmb in mempool_free(), read comment there */
@@ -412,9 +478,34 @@ static void *__mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
 		 * for debugging.
 		 */
 		kmemleak_update_trace(element);
-		return element;
+
+		if (!bulk_page_alloc)
+			return element;
+
+		page = (struct page *)element;
+		if (page_array)
+			page_array[ret + i] = page;
+		else
+			cb(page, data);
+
+		i++;
+		nr_remaining--;
+
+		spin_lock_irqsave(&pool->lock, flags);
+	}
+
+	if (bulk_page_alloc && !nr_remaining) {
+		spin_unlock_irqrestore(&pool->lock, flags);
+		return MEMPOOL_BULK_SUCCESS_PTR;
 	}
 
+	/*
+	 * The bulk allocator counts in the populated pages for array,
+	 * but don't do it for the callback version.
+	 */
+	if (bulk_page_alloc && !page_array)
+		nr = nr_remaining;
+
 	/*
 	 * We use gfp mask w/o direct reclaim or IO for the first round.  If
 	 * alloc failed with that and @pool was empty, retry immediately.
@@ -463,10 +554,62 @@ static void *__mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
  */
 void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
 {
-	return __mempool_alloc(pool, gfp_mask);
+	return __mempool_alloc(pool, gfp_mask, 1, NULL, NULL, NULL);
 }
 EXPORT_SYMBOL(mempool_alloc);
 
+/**
+ * mempool_alloc_pages_bulk - allocate a bulk of pagesfrom a specific
+ *                           memory pool
+ * @pool:       pointer to the memory pool which was allocated via
+ *              mempool_create().
+ * @gfp_mask:   the usual allocation bitmask.
+ * @nr:         the number of requested pages.
+ * @page_array: the array the pages will be added to.
+ * @cb:		the callback function that will handle the page.
+ * @data:	the parameter used by the callback
+ *
+ * this function only sleeps if the alloc_pages_bulk_fn() function sleeps
+ * or the allocation can not be satisfied even though the mempool is depleted.
+ * Note that due to preallocation, this function *never* fails when called
+ * from process contexts. (it might fail if called from an IRQ context.)
+ * Note: using __GFP_ZERO is not supported.  And the caller should not pass
+ * in both valid page_array and callback.
+ *
+ * Return: true when nr pages are allocated or false if not.  It is the
+ *         caller's responsibility to free the partial allocated pages.
+ */
+static bool mempool_alloc_pages_bulk(mempool_t *pool, gfp_t gfp_mask,
+				     unsigned int nr,
+				     struct page **page_array,
+				     void (*cb)(struct page *, void *),
+				     void *data)
+{
+	if(!__mempool_alloc(pool, gfp_mask, nr, page_array, cb, data))
+		return false;
+
+	return true;
+}
+
+bool mempool_alloc_pages_bulk_array(mempool_t *pool, gfp_t gfp_mask,
+				    unsigned int nr,
+				    struct page **page_array)
+{
+	return mempool_alloc_pages_bulk(pool, gfp_mask, nr, page_array,
+					NULL, NULL);
+}
+EXPORT_SYMBOL(mempool_alloc_pages_bulk_array);
+
+bool mempool_alloc_pages_bulk_cb(mempool_t *pool, gfp_t gfp_mask,
+				 unsigned int nr,
+				 void (*cb)(struct page *, void *),
+				 void *data)
+{
+	return mempool_alloc_pages_bulk(pool, gfp_mask, nr, NULL,
+					cb, data);
+}
+EXPORT_SYMBOL(mempool_alloc_pages_bulk_cb);
+
 /**
  * mempool_free - return an element to the pool.
  * @element:   pool element pointer.
-- 
2.39.0

