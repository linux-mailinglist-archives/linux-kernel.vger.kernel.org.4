Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2113681BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjA3UwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjA3UwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:52:10 -0500
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Jan 2023 12:51:56 PST
Received: from out-62.mta0.migadu.com (out-62.mta0.migadu.com [91.218.175.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A9D39B8C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:51:56 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675111914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z64aIL/3pnEFiG6bV8LdN1R6x92gKwWr8osFMwIva5I=;
        b=nfu6OwnDko1AKNqOQs12TRjWFH8CN3YRKYr2n98lnDMcdAtDTRf96kmqyCC0GgRU/w/evf
        HwHPm3R3lvim0v6dnV3z8SWxN4TpG9QvLzrWmN59lv13gbzTnZyVXd9w81iz5uKj4/obys
        9aoIBAek+zEi9/NdwK4PCRLjc1Z/mw8=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 12/18] lib/stackdepot: rename handle and slab constants
Date:   Mon, 30 Jan 2023 21:49:36 +0100
Message-Id: <d9c6d1fa0ae6e1e65577ee81444656c99eb598d8.1675111415.git.andreyknvl@google.com>
In-Reply-To: <cover.1675111415.git.andreyknvl@google.com>
References: <cover.1675111415.git.andreyknvl@google.com>
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
of slabs.

The old prefix is unclear and makes wonder about how these constants
are related to stack allocations. The new prefix is also shorter.

Also simplify the comment for DEPOT_SLAB_ORDER.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 56 +++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 023f299bedf6..b946ba74fea0 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -36,30 +36,28 @@
 #include <linux/memblock.h>
 #include <linux/kasan-enabled.h>
 
-#define DEPOT_STACK_BITS (sizeof(depot_stack_handle_t) * 8)
-
-#define STACK_ALLOC_NULL_PROTECTION_BITS 1
-#define STACK_ALLOC_ORDER 2 /* 'Slab' size order for stack depot, 4 pages */
-#define STACK_ALLOC_SIZE (1LL << (PAGE_SHIFT + STACK_ALLOC_ORDER))
-#define STACK_ALLOC_ALIGN 4
-#define STACK_ALLOC_OFFSET_BITS (STACK_ALLOC_ORDER + PAGE_SHIFT - \
-					STACK_ALLOC_ALIGN)
-#define STACK_ALLOC_INDEX_BITS (DEPOT_STACK_BITS - \
-		STACK_ALLOC_NULL_PROTECTION_BITS - \
-		STACK_ALLOC_OFFSET_BITS - STACK_DEPOT_EXTRA_BITS)
-#define STACK_ALLOC_SLABS_CAP 8192
-#define STACK_ALLOC_MAX_SLABS \
-	(((1LL << (STACK_ALLOC_INDEX_BITS)) < STACK_ALLOC_SLABS_CAP) ? \
-	 (1LL << (STACK_ALLOC_INDEX_BITS)) : STACK_ALLOC_SLABS_CAP)
+#define DEPOT_HANDLE_BITS (sizeof(depot_stack_handle_t) * 8)
+
+#define DEPOT_VALID_BITS 1
+#define DEPOT_SLAB_ORDER 2 /* Slab size order, 4 pages */
+#define DEPOT_SLAB_SIZE (1LL << (PAGE_SHIFT + DEPOT_SLAB_ORDER))
+#define DEPOT_STACK_ALIGN 4
+#define DEPOT_OFFSET_BITS (DEPOT_SLAB_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
+#define DEPOT_SLAB_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_VALID_BITS - \
+			       DEPOT_OFFSET_BITS - STACK_DEPOT_EXTRA_BITS)
+#define DEPOT_SLABS_CAP 8192
+#define DEPOT_MAX_SLABS \
+	(((1LL << (DEPOT_SLAB_INDEX_BITS)) < DEPOT_SLABS_CAP) ? \
+	 (1LL << (DEPOT_SLAB_INDEX_BITS)) : DEPOT_SLABS_CAP)
 
 /* The compact structure to store the reference to stacks. */
 union handle_parts {
 	depot_stack_handle_t handle;
 	struct {
-		u32 slab_index : STACK_ALLOC_INDEX_BITS;
-		u32 offset : STACK_ALLOC_OFFSET_BITS;
-		u32 valid : STACK_ALLOC_NULL_PROTECTION_BITS;
-		u32 extra : STACK_DEPOT_EXTRA_BITS;
+		u32 slab_index	: DEPOT_SLAB_INDEX_BITS;
+		u32 offset	: DEPOT_OFFSET_BITS;
+		u32 valid	: DEPOT_VALID_BITS;
+		u32 extra	: STACK_DEPOT_EXTRA_BITS;
 	};
 };
 
@@ -91,7 +89,7 @@ static unsigned int stack_bucket_number_order;
 static unsigned int stack_hash_mask;
 
 /* Array of memory regions that store stack traces. */
-static void *stack_slabs[STACK_ALLOC_MAX_SLABS];
+static void *stack_slabs[DEPOT_MAX_SLABS];
 /* Currently used slab in stack_slabs. */
 static int slab_index;
 /* Offset to the unused space in the currently used slab. */
@@ -235,7 +233,7 @@ static bool depot_init_slab(void **prealloc)
 		*prealloc = NULL;
 	} else {
 		/* If this is the last depot slab, do not touch the next one. */
-		if (slab_index + 1 < STACK_ALLOC_MAX_SLABS) {
+		if (slab_index + 1 < DEPOT_MAX_SLABS) {
 			stack_slabs[slab_index + 1] = *prealloc;
 			*prealloc = NULL;
 			/*
@@ -256,10 +254,10 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	struct stack_record *stack;
 	size_t required_size = struct_size(stack, entries, size);
 
-	required_size = ALIGN(required_size, 1 << STACK_ALLOC_ALIGN);
+	required_size = ALIGN(required_size, 1 << DEPOT_STACK_ALIGN);
 
-	if (unlikely(slab_offset + required_size > STACK_ALLOC_SIZE)) {
-		if (unlikely(slab_index + 1 >= STACK_ALLOC_MAX_SLABS)) {
+	if (unlikely(slab_offset + required_size > DEPOT_SLAB_SIZE)) {
+		if (unlikely(slab_index + 1 >= DEPOT_MAX_SLABS)) {
 			WARN_ONCE(1, "Stack depot reached limit capacity");
 			return NULL;
 		}
@@ -270,7 +268,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 		 * |next_slab_inited| in stack_depot_save() and
 		 * depot_init_slab().
 		 */
-		if (slab_index + 1 < STACK_ALLOC_MAX_SLABS)
+		if (slab_index + 1 < DEPOT_MAX_SLABS)
 			smp_store_release(&next_slab_inited, 0);
 	}
 	depot_init_slab(prealloc);
@@ -282,7 +280,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	stack->hash = hash;
 	stack->size = size;
 	stack->handle.slab_index = slab_index;
-	stack->handle.offset = slab_offset >> STACK_ALLOC_ALIGN;
+	stack->handle.offset = slab_offset >> DEPOT_STACK_ALIGN;
 	stack->handle.valid = 1;
 	stack->handle.extra = 0;
 	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
@@ -413,7 +411,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		alloc_flags &= ~GFP_ZONEMASK;
 		alloc_flags &= (GFP_ATOMIC | GFP_KERNEL);
 		alloc_flags |= __GFP_NOWARN;
-		page = alloc_pages(alloc_flags, STACK_ALLOC_ORDER);
+		page = alloc_pages(alloc_flags, DEPOT_SLAB_ORDER);
 		if (page)
 			prealloc = page_address(page);
 	}
@@ -445,7 +443,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 exit:
 	if (prealloc) {
 		/* Nobody used this memory, ok to free it. */
-		free_pages((unsigned long)prealloc, STACK_ALLOC_ORDER);
+		free_pages((unsigned long)prealloc, DEPOT_SLAB_ORDER);
 	}
 	if (found)
 		retval.handle = found->handle.handle;
@@ -490,7 +488,7 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 {
 	union handle_parts parts = { .handle = handle };
 	void *slab;
-	size_t offset = parts.offset << STACK_ALLOC_ALIGN;
+	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
 	struct stack_record *stack;
 
 	*entries = NULL;
-- 
2.25.1

