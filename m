Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5B1692916
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjBJVRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbjBJVRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:17:36 -0500
Received: from out-119.mta1.migadu.com (out-119.mta1.migadu.com [95.215.58.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0580B125AB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:17:16 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676063835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k1dYguidu/ftb/l9KscZ+n0HL8ER05ZmODhupOX0dXU=;
        b=dPUdX3td2hwjMJwaydwAO7P6cUwMqS7s04CWXZgZq4rTtFDVS2WfxxJlWzHAOeK9hg6Lnp
        mCqInVHJA2e4igp9gnVXcPY1rn3bEgd5mZ2Atb1ioMZCMAInTnVEmakuMT0E/nYF/mUMJS
        xuCob2cUSwIvHkTDy32/Oyfxzxb+b/M=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 09/18] lib/stackdepot: rename slab to pool
Date:   Fri, 10 Feb 2023 22:15:57 +0100
Message-Id: <923c507edb350c3b6ef85860f36be489dfc0ad21.1676063693.git.andreyknvl@google.com>
In-Reply-To: <cover.1676063693.git.andreyknvl@google.com>
References: <cover.1676063693.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Use "pool" instead of "slab" for naming memory regions stack depot
uses to store stack traces. Using "slab" is confusing, as stack depot
pools have nothing to do with the slab allocator.

Also give better names to pool-related global variables: change
"depot_" prefix to "pool_" to point out that these variables are
related to stack depot pools.

Also rename the slabindex (poolindex) field in handle_parts to pool_index
to align its name with the pool_index global variable.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Use "pool" instead of "slab" for memory regions that store stack traces.
---
 lib/stackdepot.c | 106 +++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index d1ab53197353..522e36cf449f 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -39,7 +39,7 @@
 #define DEPOT_STACK_BITS (sizeof(depot_stack_handle_t) * 8)
 
 #define STACK_ALLOC_NULL_PROTECTION_BITS 1
-#define STACK_ALLOC_ORDER 2 /* 'Slab' size order for stack depot, 4 pages */
+#define STACK_ALLOC_ORDER 2 /* Pool size order for stack depot, 4 pages */
 #define STACK_ALLOC_SIZE (1LL << (PAGE_SHIFT + STACK_ALLOC_ORDER))
 #define STACK_ALLOC_ALIGN 4
 #define STACK_ALLOC_OFFSET_BITS (STACK_ALLOC_ORDER + PAGE_SHIFT - \
@@ -47,16 +47,16 @@
 #define STACK_ALLOC_INDEX_BITS (DEPOT_STACK_BITS - \
 		STACK_ALLOC_NULL_PROTECTION_BITS - \
 		STACK_ALLOC_OFFSET_BITS - STACK_DEPOT_EXTRA_BITS)
-#define STACK_ALLOC_SLABS_CAP 8192
-#define STACK_ALLOC_MAX_SLABS \
-	(((1LL << (STACK_ALLOC_INDEX_BITS)) < STACK_ALLOC_SLABS_CAP) ? \
-	 (1LL << (STACK_ALLOC_INDEX_BITS)) : STACK_ALLOC_SLABS_CAP)
+#define STACK_ALLOC_POOLS_CAP 8192
+#define STACK_ALLOC_MAX_POOLS \
+	(((1LL << (STACK_ALLOC_INDEX_BITS)) < STACK_ALLOC_POOLS_CAP) ? \
+	 (1LL << (STACK_ALLOC_INDEX_BITS)) : STACK_ALLOC_POOLS_CAP)
 
 /* The compact structure to store the reference to stacks. */
 union handle_parts {
 	depot_stack_handle_t handle;
 	struct {
-		u32 slabindex : STACK_ALLOC_INDEX_BITS;
+		u32 pool_index : STACK_ALLOC_INDEX_BITS;
 		u32 offset : STACK_ALLOC_OFFSET_BITS;
 		u32 valid : STACK_ALLOC_NULL_PROTECTION_BITS;
 		u32 extra : STACK_DEPOT_EXTRA_BITS;
@@ -91,15 +91,15 @@ static unsigned int stack_bucket_number_order;
 static unsigned int stack_hash_mask;
 
 /* Array of memory regions that store stack traces. */
-static void *stack_slabs[STACK_ALLOC_MAX_SLABS];
-/* Currently used slab in stack_slabs. */
-static int depot_index;
-/* Offset to the unused space in the currently used slab. */
-static size_t depot_offset;
+static void *stack_pools[STACK_ALLOC_MAX_POOLS];
+/* Currently used pool in stack_pools. */
+static int pool_index;
+/* Offset to the unused space in the currently used pool. */
+static size_t pool_offset;
 /* Lock that protects the variables above. */
-static DEFINE_RAW_SPINLOCK(depot_lock);
-/* Whether the next slab is initialized. */
-static int next_slab_inited;
+static DEFINE_RAW_SPINLOCK(pool_lock);
+/* Whether the next pool is initialized. */
+static int next_pool_inited;
 
 static int __init disable_stack_depot(char *str)
 {
@@ -220,30 +220,30 @@ int stack_depot_init(void)
 }
 EXPORT_SYMBOL_GPL(stack_depot_init);
 
-static bool init_stack_slab(void **prealloc)
+static bool init_stack_pool(void **prealloc)
 {
 	if (!*prealloc)
 		return false;
 	/*
 	 * This smp_load_acquire() pairs with smp_store_release() to
-	 * |next_slab_inited| below and in depot_alloc_stack().
+	 * |next_pool_inited| below and in depot_alloc_stack().
 	 */
-	if (smp_load_acquire(&next_slab_inited))
+	if (smp_load_acquire(&next_pool_inited))
 		return true;
-	if (stack_slabs[depot_index] == NULL) {
-		stack_slabs[depot_index] = *prealloc;
+	if (stack_pools[pool_index] == NULL) {
+		stack_pools[pool_index] = *prealloc;
 		*prealloc = NULL;
 	} else {
-		/* If this is the last depot slab, do not touch the next one. */
-		if (depot_index + 1 < STACK_ALLOC_MAX_SLABS) {
-			stack_slabs[depot_index + 1] = *prealloc;
+		/* If this is the last depot pool, do not touch the next one. */
+		if (pool_index + 1 < STACK_ALLOC_MAX_POOLS) {
+			stack_pools[pool_index + 1] = *prealloc;
 			*prealloc = NULL;
 		}
 		/*
 		 * This smp_store_release pairs with smp_load_acquire() from
-		 * |next_slab_inited| above and in stack_depot_save().
+		 * |next_pool_inited| above and in stack_depot_save().
 		 */
-		smp_store_release(&next_slab_inited, 1);
+		smp_store_release(&next_pool_inited, 1);
 	}
 	return true;
 }
@@ -257,35 +257,35 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 
 	required_size = ALIGN(required_size, 1 << STACK_ALLOC_ALIGN);
 
-	if (unlikely(depot_offset + required_size > STACK_ALLOC_SIZE)) {
-		if (unlikely(depot_index + 1 >= STACK_ALLOC_MAX_SLABS)) {
+	if (unlikely(pool_offset + required_size > STACK_ALLOC_SIZE)) {
+		if (unlikely(pool_index + 1 >= STACK_ALLOC_MAX_POOLS)) {
 			WARN_ONCE(1, "Stack depot reached limit capacity");
 			return NULL;
 		}
-		depot_index++;
-		depot_offset = 0;
+		pool_index++;
+		pool_offset = 0;
 		/*
 		 * smp_store_release() here pairs with smp_load_acquire() from
-		 * |next_slab_inited| in stack_depot_save() and
-		 * init_stack_slab().
+		 * |next_pool_inited| in stack_depot_save() and
+		 * init_stack_pool().
 		 */
-		if (depot_index + 1 < STACK_ALLOC_MAX_SLABS)
-			smp_store_release(&next_slab_inited, 0);
+		if (pool_index + 1 < STACK_ALLOC_MAX_POOLS)
+			smp_store_release(&next_pool_inited, 0);
 	}
-	init_stack_slab(prealloc);
-	if (stack_slabs[depot_index] == NULL)
+	init_stack_pool(prealloc);
+	if (stack_pools[pool_index] == NULL)
 		return NULL;
 
-	stack = stack_slabs[depot_index] + depot_offset;
+	stack = stack_pools[pool_index] + pool_offset;
 
 	stack->hash = hash;
 	stack->size = size;
-	stack->handle.slabindex = depot_index;
-	stack->handle.offset = depot_offset >> STACK_ALLOC_ALIGN;
+	stack->handle.pool_index = pool_index;
+	stack->handle.offset = pool_offset >> STACK_ALLOC_ALIGN;
 	stack->handle.valid = 1;
 	stack->handle.extra = 0;
 	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
-	depot_offset += required_size;
+	pool_offset += required_size;
 
 	return stack;
 }
@@ -336,10 +336,10 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
  * @nr_entries:		Size of the storage array
  * @extra_bits:		Flags to store in unused bits of depot_stack_handle_t
  * @alloc_flags:	Allocation gfp flags
- * @can_alloc:		Allocate stack slabs (increased chance of failure if false)
+ * @can_alloc:		Allocate stack pools (increased chance of failure if false)
  *
  * Saves a stack trace from @entries array of size @nr_entries. If @can_alloc is
- * %true, is allowed to replenish the stack slab pool in case no space is left
+ * %true, is allowed to replenish the stack pool in case no space is left
  * (allocates using GFP flags of @alloc_flags). If @can_alloc is %false, avoids
  * any allocations and will fail if no space is left to store the stack trace.
  *
@@ -396,14 +396,14 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		goto exit;
 
 	/*
-	 * Check if the current or the next stack slab need to be initialized.
+	 * Check if the current or the next stack pool need to be initialized.
 	 * If so, allocate the memory - we won't be able to do that under the
 	 * lock.
 	 *
 	 * The smp_load_acquire() here pairs with smp_store_release() to
-	 * |next_slab_inited| in depot_alloc_stack() and init_stack_slab().
+	 * |next_pool_inited| in depot_alloc_stack() and init_stack_pool().
 	 */
-	if (unlikely(can_alloc && !smp_load_acquire(&next_slab_inited))) {
+	if (unlikely(can_alloc && !smp_load_acquire(&next_pool_inited))) {
 		/*
 		 * Zero out zone modifiers, as we don't have specific zone
 		 * requirements. Keep the flags related to allocation in atomic
@@ -417,7 +417,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 			prealloc = page_address(page);
 	}
 
-	raw_spin_lock_irqsave(&depot_lock, flags);
+	raw_spin_lock_irqsave(&pool_lock, flags);
 
 	found = find_stack(*bucket, entries, nr_entries, hash);
 	if (!found) {
@@ -437,10 +437,10 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		 * We didn't need to store this stack trace, but let's keep
 		 * the preallocated memory for the future.
 		 */
-		WARN_ON(!init_stack_slab(&prealloc));
+		WARN_ON(!init_stack_pool(&prealloc));
 	}
 
-	raw_spin_unlock_irqrestore(&depot_lock, flags);
+	raw_spin_unlock_irqrestore(&pool_lock, flags);
 exit:
 	if (prealloc) {
 		/* Nobody used this memory, ok to free it. */
@@ -488,7 +488,7 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries)
 {
 	union handle_parts parts = { .handle = handle };
-	void *slab;
+	void *pool;
 	size_t offset = parts.offset << STACK_ALLOC_ALIGN;
 	struct stack_record *stack;
 
@@ -496,15 +496,15 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 	if (!handle)
 		return 0;
 
-	if (parts.slabindex > depot_index) {
-		WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
-			parts.slabindex, depot_index, handle);
+	if (parts.pool_index > pool_index) {
+		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
+			parts.pool_index, pool_index, handle);
 		return 0;
 	}
-	slab = stack_slabs[parts.slabindex];
-	if (!slab)
+	pool = stack_pools[parts.pool_index];
+	if (!pool)
 		return 0;
-	stack = slab + offset;
+	stack = pool + offset;
 
 	*entries = stack->entries;
 	return stack->size;
-- 
2.25.1

