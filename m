Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDB3692917
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjBJVRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjBJVRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:17:36 -0500
Received: from out-244.mta1.migadu.com (out-244.mta1.migadu.com [IPv6:2001:41d0:203:375::f4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB5F7D3D4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:17:17 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676063835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1pklH2NkOlTJAHbPzx+nHrEQIp6yNaNdAfbP7NW3o0=;
        b=SagK2gsxbvOWT+w/hLC0FRbCHZrjxp0Pp51OaIqyRyPod85oFY766GqOrA1hJ+WtbIF3KL
        ho8d9GYzLVk4QS8kf0Lycn2hGllcaSZv3uOfOeg6Rkd8Z8EnmKpdYFjGKBM7wv3n36S190
        cer+cVsokuJpsF4ZbuEL4RB+LJH9/WQ=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 10/18] lib/stackdepot: rename handle and pool constants
Date:   Fri, 10 Feb 2023 22:15:58 +0100
Message-Id: <84fcceb0acc261a356a0ad4bdfab9ff04bea2445.1676063693.git.andreyknvl@google.com>
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

Change the "STACK_ALLOC_" prefix to "DEPOT_" for the constants that
define the number of bits in stack depot handles and the maximum number
of pools.

The old prefix is unclear and makes wonder about how these constants
are related to stack allocations. The new prefix is also shorter.

Also simplify the comment for DEPOT_POOL_ORDER.

No functional changes.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 56 +++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 522e36cf449f..97bba462ee13 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -36,30 +36,28 @@
 #include <linux/memblock.h>
 #include <linux/kasan-enabled.h>
 
-#define DEPOT_STACK_BITS (sizeof(depot_stack_handle_t) * 8)
-
-#define STACK_ALLOC_NULL_PROTECTION_BITS 1
-#define STACK_ALLOC_ORDER 2 /* Pool size order for stack depot, 4 pages */
-#define STACK_ALLOC_SIZE (1LL << (PAGE_SHIFT + STACK_ALLOC_ORDER))
-#define STACK_ALLOC_ALIGN 4
-#define STACK_ALLOC_OFFSET_BITS (STACK_ALLOC_ORDER + PAGE_SHIFT - \
-					STACK_ALLOC_ALIGN)
-#define STACK_ALLOC_INDEX_BITS (DEPOT_STACK_BITS - \
-		STACK_ALLOC_NULL_PROTECTION_BITS - \
-		STACK_ALLOC_OFFSET_BITS - STACK_DEPOT_EXTRA_BITS)
-#define STACK_ALLOC_POOLS_CAP 8192
-#define STACK_ALLOC_MAX_POOLS \
-	(((1LL << (STACK_ALLOC_INDEX_BITS)) < STACK_ALLOC_POOLS_CAP) ? \
-	 (1LL << (STACK_ALLOC_INDEX_BITS)) : STACK_ALLOC_POOLS_CAP)
+#define DEPOT_HANDLE_BITS (sizeof(depot_stack_handle_t) * 8)
+
+#define DEPOT_VALID_BITS 1
+#define DEPOT_POOL_ORDER 2 /* Pool size order, 4 pages */
+#define DEPOT_POOL_SIZE (1LL << (PAGE_SHIFT + DEPOT_POOL_ORDER))
+#define DEPOT_STACK_ALIGN 4
+#define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
+#define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_VALID_BITS - \
+			       DEPOT_OFFSET_BITS - STACK_DEPOT_EXTRA_BITS)
+#define DEPOT_POOLS_CAP 8192
+#define DEPOT_MAX_POOLS \
+	(((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
+	 (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
 
 /* The compact structure to store the reference to stacks. */
 union handle_parts {
 	depot_stack_handle_t handle;
 	struct {
-		u32 pool_index : STACK_ALLOC_INDEX_BITS;
-		u32 offset : STACK_ALLOC_OFFSET_BITS;
-		u32 valid : STACK_ALLOC_NULL_PROTECTION_BITS;
-		u32 extra : STACK_DEPOT_EXTRA_BITS;
+		u32 pool_index	: DEPOT_POOL_INDEX_BITS;
+		u32 offset	: DEPOT_OFFSET_BITS;
+		u32 valid	: DEPOT_VALID_BITS;
+		u32 extra	: STACK_DEPOT_EXTRA_BITS;
 	};
 };
 
@@ -91,7 +89,7 @@ static unsigned int stack_bucket_number_order;
 static unsigned int stack_hash_mask;
 
 /* Array of memory regions that store stack traces. */
-static void *stack_pools[STACK_ALLOC_MAX_POOLS];
+static void *stack_pools[DEPOT_MAX_POOLS];
 /* Currently used pool in stack_pools. */
 static int pool_index;
 /* Offset to the unused space in the currently used pool. */
@@ -235,7 +233,7 @@ static bool init_stack_pool(void **prealloc)
 		*prealloc = NULL;
 	} else {
 		/* If this is the last depot pool, do not touch the next one. */
-		if (pool_index + 1 < STACK_ALLOC_MAX_POOLS) {
+		if (pool_index + 1 < DEPOT_MAX_POOLS) {
 			stack_pools[pool_index + 1] = *prealloc;
 			*prealloc = NULL;
 		}
@@ -255,10 +253,10 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	struct stack_record *stack;
 	size_t required_size = struct_size(stack, entries, size);
 
-	required_size = ALIGN(required_size, 1 << STACK_ALLOC_ALIGN);
+	required_size = ALIGN(required_size, 1 << DEPOT_STACK_ALIGN);
 
-	if (unlikely(pool_offset + required_size > STACK_ALLOC_SIZE)) {
-		if (unlikely(pool_index + 1 >= STACK_ALLOC_MAX_POOLS)) {
+	if (unlikely(pool_offset + required_size > DEPOT_POOL_SIZE)) {
+		if (unlikely(pool_index + 1 >= DEPOT_MAX_POOLS)) {
 			WARN_ONCE(1, "Stack depot reached limit capacity");
 			return NULL;
 		}
@@ -269,7 +267,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 		 * |next_pool_inited| in stack_depot_save() and
 		 * init_stack_pool().
 		 */
-		if (pool_index + 1 < STACK_ALLOC_MAX_POOLS)
+		if (pool_index + 1 < DEPOT_MAX_POOLS)
 			smp_store_release(&next_pool_inited, 0);
 	}
 	init_stack_pool(prealloc);
@@ -281,7 +279,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	stack->hash = hash;
 	stack->size = size;
 	stack->handle.pool_index = pool_index;
-	stack->handle.offset = pool_offset >> STACK_ALLOC_ALIGN;
+	stack->handle.offset = pool_offset >> DEPOT_STACK_ALIGN;
 	stack->handle.valid = 1;
 	stack->handle.extra = 0;
 	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
@@ -412,7 +410,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		alloc_flags &= ~GFP_ZONEMASK;
 		alloc_flags &= (GFP_ATOMIC | GFP_KERNEL);
 		alloc_flags |= __GFP_NOWARN;
-		page = alloc_pages(alloc_flags, STACK_ALLOC_ORDER);
+		page = alloc_pages(alloc_flags, DEPOT_POOL_ORDER);
 		if (page)
 			prealloc = page_address(page);
 	}
@@ -444,7 +442,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 exit:
 	if (prealloc) {
 		/* Nobody used this memory, ok to free it. */
-		free_pages((unsigned long)prealloc, STACK_ALLOC_ORDER);
+		free_pages((unsigned long)prealloc, DEPOT_POOL_ORDER);
 	}
 	if (found)
 		retval.handle = found->handle.handle;
@@ -489,7 +487,7 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 {
 	union handle_parts parts = { .handle = handle };
 	void *pool;
-	size_t offset = parts.offset << STACK_ALLOC_ALIGN;
+	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
 	struct stack_record *stack;
 
 	*entries = NULL;
-- 
2.25.1

