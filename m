Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DE2681BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjA3UvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjA3Uu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:50:56 -0500
Received: from out-216.mta0.migadu.com (out-216.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747117ABF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:50:55 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675111853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iXlgsoHOs+BLuKG+iZUfAdscpmKEgHjXPVNxwccGfOc=;
        b=H0xZx4zSVR5R1TTVo6Dq4Tk1fGJ1809Ce1jSVXVk9h7VH1pdC9UBrBWMfKmaJ+yvEFxCe1
        vKFqnqMgtIUBw3xUT1K3M8gRABOsrDMGcGVAgNiniZRonGSGt7pdfEGXPOy46OlfwTgUum
        C1sqB4MBr5XwWI9FFgqUEkV0dRI3CPE=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 11/18] lib/stackdepot: rename slab variables
Date:   Mon, 30 Jan 2023 21:49:35 +0100
Message-Id: <fc73ab8b1469d476363a918cbdfe28e1388c043a.1675111415.git.andreyknvl@google.com>
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

Give better names to slab-related global variables: change "depot_"
prefix to "slab_" to point out that these variables are related to
stack depot slabs.

Also rename the slabindex field in handle_parts to align its name with
the slab_index global variable.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 69b9316b0d4b..023f299bedf6 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -56,7 +56,7 @@
 union handle_parts {
 	depot_stack_handle_t handle;
 	struct {
-		u32 slabindex : STACK_ALLOC_INDEX_BITS;
+		u32 slab_index : STACK_ALLOC_INDEX_BITS;
 		u32 offset : STACK_ALLOC_OFFSET_BITS;
 		u32 valid : STACK_ALLOC_NULL_PROTECTION_BITS;
 		u32 extra : STACK_DEPOT_EXTRA_BITS;
@@ -93,11 +93,11 @@ static unsigned int stack_hash_mask;
 /* Array of memory regions that store stack traces. */
 static void *stack_slabs[STACK_ALLOC_MAX_SLABS];
 /* Currently used slab in stack_slabs. */
-static int depot_index;
+static int slab_index;
 /* Offset to the unused space in the currently used slab. */
-static size_t depot_offset;
+static size_t slab_offset;
 /* Lock that protects the variables above. */
-static DEFINE_RAW_SPINLOCK(depot_lock);
+static DEFINE_RAW_SPINLOCK(slab_lock);
 /* Whether the next slab is initialized. */
 static int next_slab_inited;
 
@@ -230,13 +230,13 @@ static bool depot_init_slab(void **prealloc)
 	 */
 	if (smp_load_acquire(&next_slab_inited))
 		return true;
-	if (stack_slabs[depot_index] == NULL) {
-		stack_slabs[depot_index] = *prealloc;
+	if (stack_slabs[slab_index] == NULL) {
+		stack_slabs[slab_index] = *prealloc;
 		*prealloc = NULL;
 	} else {
 		/* If this is the last depot slab, do not touch the next one. */
-		if (depot_index + 1 < STACK_ALLOC_MAX_SLABS) {
-			stack_slabs[depot_index + 1] = *prealloc;
+		if (slab_index + 1 < STACK_ALLOC_MAX_SLABS) {
+			stack_slabs[slab_index + 1] = *prealloc;
 			*prealloc = NULL;
 			/*
 			 * This smp_store_release pairs with smp_load_acquire()
@@ -258,35 +258,35 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 
 	required_size = ALIGN(required_size, 1 << STACK_ALLOC_ALIGN);
 
-	if (unlikely(depot_offset + required_size > STACK_ALLOC_SIZE)) {
-		if (unlikely(depot_index + 1 >= STACK_ALLOC_MAX_SLABS)) {
+	if (unlikely(slab_offset + required_size > STACK_ALLOC_SIZE)) {
+		if (unlikely(slab_index + 1 >= STACK_ALLOC_MAX_SLABS)) {
 			WARN_ONCE(1, "Stack depot reached limit capacity");
 			return NULL;
 		}
-		depot_index++;
-		depot_offset = 0;
+		slab_index++;
+		slab_offset = 0;
 		/*
 		 * smp_store_release() here pairs with smp_load_acquire() from
 		 * |next_slab_inited| in stack_depot_save() and
 		 * depot_init_slab().
 		 */
-		if (depot_index + 1 < STACK_ALLOC_MAX_SLABS)
+		if (slab_index + 1 < STACK_ALLOC_MAX_SLABS)
 			smp_store_release(&next_slab_inited, 0);
 	}
 	depot_init_slab(prealloc);
-	if (stack_slabs[depot_index] == NULL)
+	if (stack_slabs[slab_index] == NULL)
 		return NULL;
 
-	stack = stack_slabs[depot_index] + depot_offset;
+	stack = stack_slabs[slab_index] + slab_offset;
 
 	stack->hash = hash;
 	stack->size = size;
-	stack->handle.slabindex = depot_index;
-	stack->handle.offset = depot_offset >> STACK_ALLOC_ALIGN;
+	stack->handle.slab_index = slab_index;
+	stack->handle.offset = slab_offset >> STACK_ALLOC_ALIGN;
 	stack->handle.valid = 1;
 	stack->handle.extra = 0;
 	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
-	depot_offset += required_size;
+	slab_offset += required_size;
 
 	return stack;
 }
@@ -418,7 +418,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 			prealloc = page_address(page);
 	}
 
-	raw_spin_lock_irqsave(&depot_lock, flags);
+	raw_spin_lock_irqsave(&slab_lock, flags);
 
 	found = find_stack(*bucket, entries, nr_entries, hash);
 	if (!found) {
@@ -441,7 +441,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		WARN_ON(!depot_init_slab(&prealloc));
 	}
 
-	raw_spin_unlock_irqrestore(&depot_lock, flags);
+	raw_spin_unlock_irqrestore(&slab_lock, flags);
 exit:
 	if (prealloc) {
 		/* Nobody used this memory, ok to free it. */
@@ -497,12 +497,12 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 	if (!handle)
 		return 0;
 
-	if (parts.slabindex > depot_index) {
+	if (parts.slab_index > slab_index) {
 		WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
-			parts.slabindex, depot_index, handle);
+			parts.slab_index, slab_index, handle);
 		return 0;
 	}
-	slab = stack_slabs[parts.slabindex];
+	slab = stack_slabs[parts.slab_index];
 	if (!slab)
 		return 0;
 	stack = slab + offset;
-- 
2.25.1

