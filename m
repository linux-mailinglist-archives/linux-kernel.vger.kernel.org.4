Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEC6681BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjA3U4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjA3U4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:56:12 -0500
Received: from out-32.mta1.migadu.com (out-32.mta1.migadu.com [95.215.58.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948AF33460
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:56:10 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675111787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qcsUnulCBN0ghXL+bzeFYdD4TQnNlpFLy99BvSyy4/8=;
        b=Oa/CuJOao/mJdTHw8cL7VpOXLoCP0ssTyb6Tb4Afcaf2iT1bMwfIzMn8VP90YhF+Kw1dn5
        nlRen0XClp4mDU8OoBIH9A55gvf9AIpEUnPu3NprTuPLm5Oj48kdn+8rpZFRY69OwzrT5/
        V6Mbai08U9sLTKUwkyeeYJiudqhoCR0=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 02/18] lib/stackdepot: put functions in logical order
Date:   Mon, 30 Jan 2023 21:49:26 +0100
Message-Id: <632393332c364171c69b7c054b3b2233acbfa996.1675111415.git.andreyknvl@google.com>
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

Put stack depot functions' declarations and definitions in a more logical
order:

1. Functions that save stack traces into stack depot.
2. Functions that fetch and print stack traces.
3. stack_depot_get_extra_bits that operates on stack depot handles
   and does not interact with the stack depot storage.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/stackdepot.h |  15 +-
 lib/stackdepot.c           | 316 ++++++++++++++++++-------------------
 2 files changed, 166 insertions(+), 165 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 9ca7798d7a31..1296a6eeaec0 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -14,17 +14,13 @@
 #include <linux/gfp.h>
 
 typedef u32 depot_stack_handle_t;
+
 /*
  * Number of bits in the handle that stack depot doesn't use. Users may store
  * information in them.
  */
 #define STACK_DEPOT_EXTRA_BITS 5
 
-depot_stack_handle_t __stack_depot_save(unsigned long *entries,
-					unsigned int nr_entries,
-					unsigned int extra_bits,
-					gfp_t gfp_flags, bool can_alloc);
-
 /*
  * Every user of stack depot has to call stack_depot_init() during its own init
  * when it's decided that it will be calling stack_depot_save() later. This is
@@ -59,17 +55,22 @@ static inline void stack_depot_want_early_init(void) { }
 static inline int stack_depot_early_init(void)	{ return 0; }
 #endif
 
+depot_stack_handle_t __stack_depot_save(unsigned long *entries,
+					unsigned int nr_entries,
+					unsigned int extra_bits,
+					gfp_t gfp_flags, bool can_alloc);
+
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries, gfp_t gfp_flags);
 
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries);
 
-unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle);
+void stack_depot_print(depot_stack_handle_t stack);
 
 int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
 		       int spaces);
 
-void stack_depot_print(depot_stack_handle_t stack);
+unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle);
 
 #endif
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 0eed9bbcf23e..23d2a68a587b 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -79,85 +79,6 @@ static int next_slab_inited;
 static size_t depot_offset;
 static DEFINE_RAW_SPINLOCK(depot_lock);
 
-unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle)
-{
-	union handle_parts parts = { .handle = handle };
-
-	return parts.extra;
-}
-EXPORT_SYMBOL(stack_depot_get_extra_bits);
-
-static bool init_stack_slab(void **prealloc)
-{
-	if (!*prealloc)
-		return false;
-	/*
-	 * This smp_load_acquire() pairs with smp_store_release() to
-	 * |next_slab_inited| below and in depot_alloc_stack().
-	 */
-	if (smp_load_acquire(&next_slab_inited))
-		return true;
-	if (stack_slabs[depot_index] == NULL) {
-		stack_slabs[depot_index] = *prealloc;
-		*prealloc = NULL;
-	} else {
-		/* If this is the last depot slab, do not touch the next one. */
-		if (depot_index + 1 < STACK_ALLOC_MAX_SLABS) {
-			stack_slabs[depot_index + 1] = *prealloc;
-			*prealloc = NULL;
-			/*
-			 * This smp_store_release pairs with smp_load_acquire()
-			 * from |next_slab_inited| above and in
-			 * stack_depot_save().
-			 */
-			smp_store_release(&next_slab_inited, 1);
-		}
-	}
-	return true;
-}
-
-/* Allocation of a new stack in raw storage */
-static struct stack_record *
-depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
-{
-	struct stack_record *stack;
-	size_t required_size = struct_size(stack, entries, size);
-
-	required_size = ALIGN(required_size, 1 << STACK_ALLOC_ALIGN);
-
-	if (unlikely(depot_offset + required_size > STACK_ALLOC_SIZE)) {
-		if (unlikely(depot_index + 1 >= STACK_ALLOC_MAX_SLABS)) {
-			WARN_ONCE(1, "Stack depot reached limit capacity");
-			return NULL;
-		}
-		depot_index++;
-		depot_offset = 0;
-		/*
-		 * smp_store_release() here pairs with smp_load_acquire() from
-		 * |next_slab_inited| in stack_depot_save() and
-		 * init_stack_slab().
-		 */
-		if (depot_index + 1 < STACK_ALLOC_MAX_SLABS)
-			smp_store_release(&next_slab_inited, 0);
-	}
-	init_stack_slab(prealloc);
-	if (stack_slabs[depot_index] == NULL)
-		return NULL;
-
-	stack = stack_slabs[depot_index] + depot_offset;
-
-	stack->hash = hash;
-	stack->size = size;
-	stack->handle.slabindex = depot_index;
-	stack->handle.offset = depot_offset >> STACK_ALLOC_ALIGN;
-	stack->handle.valid = 1;
-	stack->handle.extra = 0;
-	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
-	depot_offset += required_size;
-
-	return stack;
-}
-
 /* one hash table bucket entry per 16kB of memory */
 #define STACK_HASH_SCALE	14
 /* limited between 4k and 1M buckets */
@@ -271,6 +192,77 @@ int stack_depot_init(void)
 }
 EXPORT_SYMBOL_GPL(stack_depot_init);
 
+static bool init_stack_slab(void **prealloc)
+{
+	if (!*prealloc)
+		return false;
+	/*
+	 * This smp_load_acquire() pairs with smp_store_release() to
+	 * |next_slab_inited| below and in depot_alloc_stack().
+	 */
+	if (smp_load_acquire(&next_slab_inited))
+		return true;
+	if (stack_slabs[depot_index] == NULL) {
+		stack_slabs[depot_index] = *prealloc;
+		*prealloc = NULL;
+	} else {
+		/* If this is the last depot slab, do not touch the next one. */
+		if (depot_index + 1 < STACK_ALLOC_MAX_SLABS) {
+			stack_slabs[depot_index + 1] = *prealloc;
+			*prealloc = NULL;
+			/*
+			 * This smp_store_release pairs with smp_load_acquire()
+			 * from |next_slab_inited| above and in
+			 * stack_depot_save().
+			 */
+			smp_store_release(&next_slab_inited, 1);
+		}
+	}
+	return true;
+}
+
+/* Allocation of a new stack in raw storage */
+static struct stack_record *
+depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
+{
+	struct stack_record *stack;
+	size_t required_size = struct_size(stack, entries, size);
+
+	required_size = ALIGN(required_size, 1 << STACK_ALLOC_ALIGN);
+
+	if (unlikely(depot_offset + required_size > STACK_ALLOC_SIZE)) {
+		if (unlikely(depot_index + 1 >= STACK_ALLOC_MAX_SLABS)) {
+			WARN_ONCE(1, "Stack depot reached limit capacity");
+			return NULL;
+		}
+		depot_index++;
+		depot_offset = 0;
+		/*
+		 * smp_store_release() here pairs with smp_load_acquire() from
+		 * |next_slab_inited| in stack_depot_save() and
+		 * init_stack_slab().
+		 */
+		if (depot_index + 1 < STACK_ALLOC_MAX_SLABS)
+			smp_store_release(&next_slab_inited, 0);
+	}
+	init_stack_slab(prealloc);
+	if (stack_slabs[depot_index] == NULL)
+		return NULL;
+
+	stack = stack_slabs[depot_index] + depot_offset;
+
+	stack->hash = hash;
+	stack->size = size;
+	stack->handle.slabindex = depot_index;
+	stack->handle.offset = depot_offset >> STACK_ALLOC_ALIGN;
+	stack->handle.valid = 1;
+	stack->handle.extra = 0;
+	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
+	depot_offset += required_size;
+
+	return stack;
+}
+
 /* Calculate hash for a stack */
 static inline u32 hash_stack(unsigned long *entries, unsigned int size)
 {
@@ -310,85 +302,6 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
 	return NULL;
 }
 
-/**
- * stack_depot_snprint - print stack entries from a depot into a buffer
- *
- * @handle:	Stack depot handle which was returned from
- *		stack_depot_save().
- * @buf:	Pointer to the print buffer
- *
- * @size:	Size of the print buffer
- *
- * @spaces:	Number of leading spaces to print
- *
- * Return:	Number of bytes printed.
- */
-int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
-		       int spaces)
-{
-	unsigned long *entries;
-	unsigned int nr_entries;
-
-	nr_entries = stack_depot_fetch(handle, &entries);
-	return nr_entries ? stack_trace_snprint(buf, size, entries, nr_entries,
-						spaces) : 0;
-}
-EXPORT_SYMBOL_GPL(stack_depot_snprint);
-
-/**
- * stack_depot_print - print stack entries from a depot
- *
- * @stack:		Stack depot handle which was returned from
- *			stack_depot_save().
- *
- */
-void stack_depot_print(depot_stack_handle_t stack)
-{
-	unsigned long *entries;
-	unsigned int nr_entries;
-
-	nr_entries = stack_depot_fetch(stack, &entries);
-	if (nr_entries > 0)
-		stack_trace_print(entries, nr_entries, 0);
-}
-EXPORT_SYMBOL_GPL(stack_depot_print);
-
-/**
- * stack_depot_fetch - Fetch stack entries from a depot
- *
- * @handle:		Stack depot handle which was returned from
- *			stack_depot_save().
- * @entries:		Pointer to store the entries address
- *
- * Return: The number of trace entries for this depot.
- */
-unsigned int stack_depot_fetch(depot_stack_handle_t handle,
-			       unsigned long **entries)
-{
-	union handle_parts parts = { .handle = handle };
-	void *slab;
-	size_t offset = parts.offset << STACK_ALLOC_ALIGN;
-	struct stack_record *stack;
-
-	*entries = NULL;
-	if (!handle)
-		return 0;
-
-	if (parts.slabindex > depot_index) {
-		WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
-			parts.slabindex, depot_index, handle);
-		return 0;
-	}
-	slab = stack_slabs[parts.slabindex];
-	if (!slab)
-		return 0;
-	stack = slab + offset;
-
-	*entries = stack->entries;
-	return stack->size;
-}
-EXPORT_SYMBOL_GPL(stack_depot_fetch);
-
 /**
  * __stack_depot_save - Save a stack trace from an array
  *
@@ -534,3 +447,90 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 	return __stack_depot_save(entries, nr_entries, 0, alloc_flags, true);
 }
 EXPORT_SYMBOL_GPL(stack_depot_save);
+
+/**
+ * stack_depot_fetch - Fetch stack entries from a depot
+ *
+ * @handle:		Stack depot handle which was returned from
+ *			stack_depot_save().
+ * @entries:		Pointer to store the entries address
+ *
+ * Return: The number of trace entries for this depot.
+ */
+unsigned int stack_depot_fetch(depot_stack_handle_t handle,
+			       unsigned long **entries)
+{
+	union handle_parts parts = { .handle = handle };
+	void *slab;
+	size_t offset = parts.offset << STACK_ALLOC_ALIGN;
+	struct stack_record *stack;
+
+	*entries = NULL;
+	if (!handle)
+		return 0;
+
+	if (parts.slabindex > depot_index) {
+		WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
+			parts.slabindex, depot_index, handle);
+		return 0;
+	}
+	slab = stack_slabs[parts.slabindex];
+	if (!slab)
+		return 0;
+	stack = slab + offset;
+
+	*entries = stack->entries;
+	return stack->size;
+}
+EXPORT_SYMBOL_GPL(stack_depot_fetch);
+
+/**
+ * stack_depot_print - print stack entries from a depot
+ *
+ * @stack:		Stack depot handle which was returned from
+ *			stack_depot_save().
+ *
+ */
+void stack_depot_print(depot_stack_handle_t stack)
+{
+	unsigned long *entries;
+	unsigned int nr_entries;
+
+	nr_entries = stack_depot_fetch(stack, &entries);
+	if (nr_entries > 0)
+		stack_trace_print(entries, nr_entries, 0);
+}
+EXPORT_SYMBOL_GPL(stack_depot_print);
+
+/**
+ * stack_depot_snprint - print stack entries from a depot into a buffer
+ *
+ * @handle:	Stack depot handle which was returned from
+ *		stack_depot_save().
+ * @buf:	Pointer to the print buffer
+ *
+ * @size:	Size of the print buffer
+ *
+ * @spaces:	Number of leading spaces to print
+ *
+ * Return:	Number of bytes printed.
+ */
+int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
+		       int spaces)
+{
+	unsigned long *entries;
+	unsigned int nr_entries;
+
+	nr_entries = stack_depot_fetch(handle, &entries);
+	return nr_entries ? stack_trace_snprint(buf, size, entries, nr_entries,
+						spaces) : 0;
+}
+EXPORT_SYMBOL_GPL(stack_depot_snprint);
+
+unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle)
+{
+	union handle_parts parts = { .handle = handle };
+
+	return parts.extra;
+}
+EXPORT_SYMBOL(stack_depot_get_extra_bits);
-- 
2.25.1

