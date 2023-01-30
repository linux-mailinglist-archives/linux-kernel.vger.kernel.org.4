Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D993681BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 21:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjA3Uwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 15:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjA3UwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 15:52:13 -0500
Received: from out-38.mta0.migadu.com (out-38.mta0.migadu.com [91.218.175.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20722F7AE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 12:51:58 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675111917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f1IK6xrmRNNY97ld0D9rdSaArRx+XdmL+DdOqeJXePk=;
        b=N0ZO7gPgqsdvjfoPyEHM1M/4g1mQMy1nyep+nZYB85fu9/+taHsVg8HK0X2PLi8RvQGHqO
        rq+rLtZyEcgsm0wnNTECIM/mArPv2lN556mCiWgb6FLQeQVAiZ/y+BqWJjZ3IiuLdXsChe
        R7mZrLZFMf5+lGmc0Xsk9el5Wkl+ABw=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 17/18] lib/stackdepot: various comments clean-ups
Date:   Mon, 30 Jan 2023 21:49:41 +0100
Message-Id: <e6d509e769bacc1842de868084e157787e6a3817.1675111415.git.andreyknvl@google.com>
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

Clean up comments in include/linux/stackdepot.h and lib/stackdepot.c:

1. Rework the initialization comment in stackdepot.h.
2. Rework the header comment in stackdepot.c.
3. Various clean-ups for other comments.

Also adjust whitespaces for find_stack and depot_alloc_stack call sites.

No functional changes.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/stackdepot.h |  36 +++++------
 lib/stackdepot.c           | 120 ++++++++++++++++++-------------------
 2 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index f999811c66d7..173740987d8b 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- * A generic stack depot implementation
+ * Stack depot - a stack trace storage that avoids duplication.
  *
  * Author: Alexander Potapenko <glider@google.com>
  * Copyright (C) 2016 Google, Inc.
  *
- * Based on code by Dmitry Chernenkov.
+ * Based on the code by Dmitry Chernenkov.
  */
 
 #ifndef _LINUX_STACKDEPOT_H
@@ -17,35 +17,37 @@ typedef u32 depot_stack_handle_t;
 
 /*
  * Number of bits in the handle that stack depot doesn't use. Users may store
- * information in them.
+ * information in them via stack_depot_set/get_extra_bits.
  */
 #define STACK_DEPOT_EXTRA_BITS 5
 
 /*
- * Every user of stack depot has to call stack_depot_init() during its own init
- * when it's decided that it will be calling stack_depot_save() later. This is
- * recommended for e.g. modules initialized later in the boot process, when
- * slab_is_available() is true.
+ * Using stack depot requires its initialization, which can be done in 3 ways:
  *
- * The alternative is to select STACKDEPOT_ALWAYS_INIT to have stack depot
- * enabled as part of mm_init(), for subsystems where it's known at compile time
- * that stack depot will be used.
+ * 1. Selecting CONFIG_STACKDEPOT_ALWAYS_INIT. This option is suitable in
+ *    scenarios where it's known at compile time that stack depot will be used.
+ *    Enabling this config makes the kernel initialize stack depot in mm_init().
  *
- * Another alternative is to call stack_depot_request_early_init(), when the
- * decision to use stack depot is taken e.g. when evaluating kernel boot
- * parameters, which precedes the enablement point in mm_init().
+ * 2. Calling stack_depot_request_early_init() during early boot, before
+ *    stack_depot_early_init() in mm_init() completes. For example, this can
+ *    be done when evaluating kernel boot parameters.
+ *
+ * 3. Calling stack_depot_init(). Possible after boot is complete. This option
+ *    is recommended for modules initialized later in the boot process, after
+ *    mm_init() completes.
  *
  * stack_depot_init() and stack_depot_request_early_init() can be called
- * regardless of CONFIG_STACKDEPOT and are no-op when disabled. The actual
- * save/fetch/print functions should only be called from code that makes sure
- * CONFIG_STACKDEPOT is enabled.
+ * regardless of whether CONFIG_STACKDEPOT is enabled and are no-op when this
+ * config is disabled. The save/fetch/print stack depot functions can only be
+ * called from the code that makes sure CONFIG_STACKDEPOT is enabled _and_
+ * initializes stack depot via one of the ways listed above.
  */
 #ifdef CONFIG_STACKDEPOT
 int stack_depot_init(void);
 
 void __init stack_depot_request_early_init(void);
 
-/* This is supposed to be called only from mm_init() */
+/* Must be only called from mm_init(). */
 int __init stack_depot_early_init(void);
 #else
 static inline int stack_depot_init(void) { return 0; }
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index cc2fe8563af4..5128f9486ceb 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -1,22 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Generic stack depot for storing stack traces.
+ * Stack depot - a stack trace storage that avoids duplication.
  *
- * Some debugging tools need to save stack traces of certain events which can
- * be later presented to the user. For example, KASAN needs to safe alloc and
- * free stacks for each object, but storing two stack traces per object
- * requires too much memory (e.g. SLUB_DEBUG needs 256 bytes per object for
- * that).
+ * Stack depot is intended to be used by subsystems that need to store and
+ * later retrieve many potentially duplicated stack traces without wasting
+ * memory.
  *
- * Instead, stack depot maintains a hashtable of unique stacktraces. Since alloc
- * and free stacks repeat a lot, we save about 100x space.
- * Stacks are never removed from depot, so we store them contiguously one after
- * another in a contiguous memory allocation.
+ * For example, KASAN needs to save allocation and free stack traces for each
+ * object. Storing two stack traces per object requires a lot of memory (e.g.
+ * SLUB_DEBUG needs 256 bytes per object for that). Since allocation and free
+ * stack traces often repeat, using stack depot allows to save about 100x space.
+ *
+ * Internally, stack depot maintains a hash table of unique stacktraces. The
+ * stack traces themselves are stored contiguously one after another in a set
+ * of separate page allocations.
+ *
+ * Stack traces are never removed from stack depot.
  *
  * Author: Alexander Potapenko <glider@google.com>
  * Copyright (C) 2016 Google, Inc.
  *
- * Based on code by Dmitry Chernenkov.
+ * Based on the code by Dmitry Chernenkov.
  */
 
 #define pr_fmt(fmt) "stackdepot: " fmt
@@ -50,7 +54,7 @@
 	(((1LL << (DEPOT_SLAB_INDEX_BITS)) < DEPOT_SLABS_CAP) ? \
 	 (1LL << (DEPOT_SLAB_INDEX_BITS)) : DEPOT_SLABS_CAP)
 
-/* The compact structure to store the reference to stacks. */
+/* Compact structure that stores a reference to a stack. */
 union handle_parts {
 	depot_stack_handle_t handle;
 	struct {
@@ -62,11 +66,11 @@ union handle_parts {
 };
 
 struct stack_record {
-	struct stack_record *next;	/* Link in the hashtable */
-	u32 hash;			/* Hash in the hastable */
-	u32 size;			/* Number of frames in the stack */
+	struct stack_record *next;	/* Link in the hash table */
+	u32 hash;			/* Hash in the hash table */
+	u32 size;			/* Number of stored frames */
 	union handle_parts handle;
-	unsigned long entries[];	/* Variable-sized array of entries. */
+	unsigned long entries[];	/* Variable-sized array of frames */
 };
 
 static bool stack_depot_disabled;
@@ -305,7 +309,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	return stack;
 }
 
-/* Calculate hash for a stack */
+/* Calculates the hash for a stack. */
 static inline u32 hash_stack(unsigned long *entries, unsigned int size)
 {
 	return jhash2((u32 *)entries,
@@ -313,9 +317,9 @@ static inline u32 hash_stack(unsigned long *entries, unsigned int size)
 		      STACK_HASH_SEED);
 }
 
-/* Use our own, non-instrumented version of memcmp().
- *
- * We actually don't care about the order, just the equality.
+/*
+ * Non-instrumented version of memcmp().
+ * Does not check the lexicographical order, only the equality.
  */
 static inline
 int stackdepot_memcmp(const unsigned long *u1, const unsigned long *u2,
@@ -328,7 +332,7 @@ int stackdepot_memcmp(const unsigned long *u1, const unsigned long *u2,
 	return 0;
 }
 
-/* Find a stack that is equal to the one stored in entries in the hash */
+/* Finds a stack in a bucket of the hash table. */
 static inline struct stack_record *find_stack(struct stack_record *bucket,
 					     unsigned long *entries, int size,
 					     u32 hash)
@@ -345,27 +349,27 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
 }
 
 /**
- * __stack_depot_save - Save a stack trace from an array
+ * __stack_depot_save - Save a stack trace to stack depot
  *
- * @entries:		Pointer to storage array
- * @nr_entries:		Size of the storage array
- * @alloc_flags:	Allocation gfp flags
+ * @entries:		Pointer to the stack trace
+ * @nr_entries:		Number of frames in the stack
+ * @alloc_flags:	Allocation GFP flags
  * @can_alloc:		Allocate stack slabs (increased chance of failure if false)
  *
  * Saves a stack trace from @entries array of size @nr_entries. If @can_alloc is
- * %true, is allowed to replenish the stack slab pool in case no space is left
+ * %true, stack depot can replenish the stack slab pool in case no space is left
  * (allocates using GFP flags of @alloc_flags). If @can_alloc is %false, avoids
- * any allocations and will fail if no space is left to store the stack trace.
+ * any allocations and fails if no space is left to store the stack trace.
  *
- * If the stack trace in @entries is from an interrupt, only the portion up to
- * interrupt entry is saved.
+ * If the provided stack trace comes from the interrupt context, only the part
+ * up to the interrupt entry is saved.
  *
  * Context: Any context, but setting @can_alloc to %false is required if
  *          alloc_pages() cannot be used from the current context. Currently
- *          this is the case from contexts where neither %GFP_ATOMIC nor
+ *          this is the case for contexts where neither %GFP_ATOMIC nor
  *          %GFP_NOWAIT can be used (NMI, raw_spin_lock).
  *
- * Return: The handle of the stack struct stored in depot, 0 on failure.
+ * Return: Handle of the stack struct stored in depot, 0 on failure
  */
 depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					unsigned int nr_entries,
@@ -380,11 +384,11 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 
 	/*
 	 * If this stack trace is from an interrupt, including anything before
-	 * interrupt entry usually leads to unbounded stackdepot growth.
+	 * interrupt entry usually leads to unbounded stack depot growth.
 	 *
-	 * Because use of filter_irq_stacks() is a requirement to ensure
-	 * stackdepot can efficiently deduplicate interrupt stacks, always
-	 * filter_irq_stacks() to simplify all callers' use of stackdepot.
+	 * Since use of filter_irq_stacks() is a requirement to ensure stack
+	 * depot can efficiently deduplicate interrupt stacks, always
+	 * filter_irq_stacks() to simplify all callers' use of stack depot.
 	 */
 	nr_entries = filter_irq_stacks(entries, nr_entries);
 
@@ -399,8 +403,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	 * The smp_load_acquire() here pairs with smp_store_release() to
 	 * |bucket| below.
 	 */
-	found = find_stack(smp_load_acquire(bucket), entries,
-			   nr_entries, hash);
+	found = find_stack(smp_load_acquire(bucket), entries, nr_entries, hash);
 	if (found)
 		goto exit;
 
@@ -430,7 +433,8 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 
 	found = find_stack(*bucket, entries, nr_entries, hash);
 	if (!found) {
-		struct stack_record *new = depot_alloc_stack(entries, nr_entries, hash, &prealloc);
+		struct stack_record *new =
+			depot_alloc_stack(entries, nr_entries, hash, &prealloc);
 
 		if (new) {
 			new->next = *bucket;
@@ -443,8 +447,8 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		}
 	} else if (prealloc) {
 		/*
-		 * We didn't need to store this stack trace, but let's keep
-		 * the preallocated memory for the future.
+		 * Stack depot already contains this stack trace, but let's
+		 * keep the preallocated memory for the future.
 		 */
 		depot_init_slab(&prealloc);
 	}
@@ -452,7 +456,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	raw_spin_unlock_irqrestore(&slab_lock, flags);
 exit:
 	if (prealloc) {
-		/* Nobody used this memory, ok to free it. */
+		/* Stack depot didn't use this memory, free it. */
 		free_pages((unsigned long)prealloc, DEPOT_SLAB_ORDER);
 	}
 	if (found)
@@ -463,16 +467,16 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 EXPORT_SYMBOL_GPL(__stack_depot_save);
 
 /**
- * stack_depot_save - Save a stack trace from an array
+ * stack_depot_save - Save a stack trace to stack depot
  *
- * @entries:		Pointer to storage array
- * @nr_entries:		Size of the storage array
- * @alloc_flags:	Allocation gfp flags
+ * @entries:		Pointer to the stack trace
+ * @nr_entries:		Number of frames in the stack
+ * @alloc_flags:	Allocation GFP flags
  *
  * Context: Contexts where allocations via alloc_pages() are allowed.
  *          See __stack_depot_save() for more details.
  *
- * Return: The handle of the stack struct stored in depot, 0 on failure.
+ * Return: Handle of the stack trace stored in depot, 0 on failure
  */
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries,
@@ -483,13 +487,12 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 EXPORT_SYMBOL_GPL(stack_depot_save);
 
 /**
- * stack_depot_fetch - Fetch stack entries from a depot
+ * stack_depot_fetch - Fetch a stack trace from stack depot
  *
- * @handle:		Stack depot handle which was returned from
- *			stack_depot_save().
- * @entries:		Pointer to store the entries address
+ * @handle:	Stack depot handle returned from stack_depot_save()
+ * @entries:	Pointer to store the address of the stack trace
  *
- * Return: The number of trace entries for this depot.
+ * Return: Number of frames for the fetched stack
  */
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries)
@@ -521,11 +524,9 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 EXPORT_SYMBOL_GPL(stack_depot_fetch);
 
 /**
- * stack_depot_print - print stack entries from a depot
- *
- * @stack:		Stack depot handle which was returned from
- *			stack_depot_save().
+ * stack_depot_print - Print a stack trace from stack depot
  *
+ * @stack:	Stack depot handle returned from stack_depot_save()
  */
 void stack_depot_print(depot_stack_handle_t stack)
 {
@@ -539,17 +540,14 @@ void stack_depot_print(depot_stack_handle_t stack)
 EXPORT_SYMBOL_GPL(stack_depot_print);
 
 /**
- * stack_depot_snprint - print stack entries from a depot into a buffer
+ * stack_depot_snprint - Print a stack trace from stack depot into a buffer
  *
- * @handle:	Stack depot handle which was returned from
- *		stack_depot_save().
+ * @handle:	Stack depot handle returned from stack_depot_save()
  * @buf:	Pointer to the print buffer
- *
  * @size:	Size of the print buffer
- *
  * @spaces:	Number of leading spaces to print
  *
- * Return:	Number of bytes printed.
+ * Return:	Number of bytes printed
  */
 int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
 		       int spaces)
-- 
2.25.1

