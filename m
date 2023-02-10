Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85670692928
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjBJVTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjBJVTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:19:51 -0500
Received: from out-44.mta1.migadu.com (out-44.mta1.migadu.com [IPv6:2001:41d0:203:375::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622E781CF5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:19:23 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676063961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FT29KRMbRE0UIrHSR8VL9ToKxsY1mNQpa5JLen40C60=;
        b=s10+K4Rzc2sALXbIT+1TmOUw/81gMdFkCt3qDr6ED6IWbAlMmTt/KRQMXBw6qBCR6MobWg
        d3HivIkbrsLLO9p7S+4pHdXxB1gdQs2OLVS4TRFlC/4OfM+P1PI3uxfXCz9h5ocVbc3BCx
        Y061miA3dkscw+XnPpB5bNkpLLfQj4s=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 18/18] lib/stackdepot: move documentation comments to stackdepot.h
Date:   Fri, 10 Feb 2023 22:16:06 +0100
Message-Id: <fbfee41495b306dd8881f9b1c1b80999c885e82f.1676063693.git.andreyknvl@google.com>
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

Move all interface- and usage-related documentation comments to
include/linux/stackdepot.h.

It makes sense to have them in the header where they are available to
the interface users.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/stackdepot.h | 87 ++++++++++++++++++++++++++++++++++++++
 lib/stackdepot.c           | 87 --------------------------------------
 2 files changed, 87 insertions(+), 87 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index afdf8ee7b597..91f038829eaa 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -2,6 +2,17 @@
 /*
  * Stack depot - a stack trace storage that avoids duplication.
  *
+ * Stack depot is intended to be used by subsystems that need to store and
+ * later retrieve many potentially duplicated stack traces without wasting
+ * memory.
+ *
+ * For example, KASAN needs to save allocation and free stack traces for each
+ * object. Storing two stack traces per object requires a lot of memory (e.g.
+ * SLUB_DEBUG needs 256 bytes per object for that). Since allocation and free
+ * stack traces often repeat, using stack depot allows to save about 100x space.
+ *
+ * Stack traces are never removed from stack depot.
+ *
  * Author: Alexander Potapenko <glider@google.com>
  * Copyright (C) 2016 Google, Inc.
  *
@@ -57,24 +68,100 @@ static inline void stack_depot_request_early_init(void) { }
 static inline int stack_depot_early_init(void)	{ return 0; }
 #endif
 
+/**
+ * __stack_depot_save - Save a stack trace to stack depot
+ *
+ * @entries:		Pointer to the stack trace
+ * @nr_entries:		Number of frames in the stack
+ * @alloc_flags:	Allocation GFP flags
+ * @can_alloc:		Allocate stack pools (increased chance of failure if false)
+ *
+ * Saves a stack trace from @entries array of size @nr_entries. If @can_alloc is
+ * %true, stack depot can replenish the stack pools in case no space is left
+ * (allocates using GFP flags of @alloc_flags). If @can_alloc is %false, avoids
+ * any allocations and fails if no space is left to store the stack trace.
+ *
+ * If the provided stack trace comes from the interrupt context, only the part
+ * up to the interrupt entry is saved.
+ *
+ * Context: Any context, but setting @can_alloc to %false is required if
+ *          alloc_pages() cannot be used from the current context. Currently
+ *          this is the case for contexts where neither %GFP_ATOMIC nor
+ *          %GFP_NOWAIT can be used (NMI, raw_spin_lock).
+ *
+ * Return: Handle of the stack struct stored in depot, 0 on failure
+ */
 depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					unsigned int nr_entries,
 					gfp_t gfp_flags, bool can_alloc);
 
+/**
+ * stack_depot_save - Save a stack trace to stack depot
+ *
+ * @entries:		Pointer to the stack trace
+ * @nr_entries:		Number of frames in the stack
+ * @alloc_flags:	Allocation GFP flags
+ *
+ * Context: Contexts where allocations via alloc_pages() are allowed.
+ *          See __stack_depot_save() for more details.
+ *
+ * Return: Handle of the stack trace stored in depot, 0 on failure
+ */
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries, gfp_t gfp_flags);
 
+/**
+ * stack_depot_fetch - Fetch a stack trace from stack depot
+ *
+ * @handle:	Stack depot handle returned from stack_depot_save()
+ * @entries:	Pointer to store the address of the stack trace
+ *
+ * Return: Number of frames for the fetched stack
+ */
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries);
 
+/**
+ * stack_depot_print - Print a stack trace from stack depot
+ *
+ * @stack:	Stack depot handle returned from stack_depot_save()
+ */
 void stack_depot_print(depot_stack_handle_t stack);
 
+/**
+ * stack_depot_snprint - Print a stack trace from stack depot into a buffer
+ *
+ * @handle:	Stack depot handle returned from stack_depot_save()
+ * @buf:	Pointer to the print buffer
+ * @size:	Size of the print buffer
+ * @spaces:	Number of leading spaces to print
+ *
+ * Return:	Number of bytes printed
+ */
 int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
 		       int spaces);
 
+/**
+ * stack_depot_set_extra_bits - Set extra bits in a stack depot handle
+ *
+ * @handle:	Stack depot handle returned from stack_depot_save()
+ * @extra_bits:	Value to set the extra bits
+ *
+ * Return: Stack depot handle with extra bits set
+ *
+ * Stack depot handles have a few unused bits, which can be used for storing
+ * user-specific information. These bits are transparent to the stack depot.
+ */
 depot_stack_handle_t __must_check stack_depot_set_extra_bits(
 			depot_stack_handle_t handle, unsigned int extra_bits);
 
+/**
+ * stack_depot_get_extra_bits - Retrieve extra bits from a stack depot handle
+ *
+ * @handle:	Stack depot handle with extra bits saved
+ *
+ * Return: Extra bits retrieved from the stack depot handle
+ */
 unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle);
 
 #endif
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 02bb6cdb69dc..ec772e78af39 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -2,21 +2,10 @@
 /*
  * Stack depot - a stack trace storage that avoids duplication.
  *
- * Stack depot is intended to be used by subsystems that need to store and
- * later retrieve many potentially duplicated stack traces without wasting
- * memory.
- *
- * For example, KASAN needs to save allocation and free stack traces for each
- * object. Storing two stack traces per object requires a lot of memory (e.g.
- * SLUB_DEBUG needs 256 bytes per object for that). Since allocation and free
- * stack traces often repeat, using stack depot allows to save about 100x space.
- *
  * Internally, stack depot maintains a hash table of unique stacktraces. The
  * stack traces themselves are stored contiguously one after another in a set
  * of separate page allocations.
  *
- * Stack traces are never removed from stack depot.
- *
  * Author: Alexander Potapenko <glider@google.com>
  * Copyright (C) 2016 Google, Inc.
  *
@@ -360,29 +349,6 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
 	return NULL;
 }
 
-/**
- * __stack_depot_save - Save a stack trace to stack depot
- *
- * @entries:		Pointer to the stack trace
- * @nr_entries:		Number of frames in the stack
- * @alloc_flags:	Allocation GFP flags
- * @can_alloc:		Allocate stack pools (increased chance of failure if false)
- *
- * Saves a stack trace from @entries array of size @nr_entries. If @can_alloc is
- * %true, stack depot can replenish the stack pools in case no space is left
- * (allocates using GFP flags of @alloc_flags). If @can_alloc is %false, avoids
- * any allocations and fails if no space is left to store the stack trace.
- *
- * If the provided stack trace comes from the interrupt context, only the part
- * up to the interrupt entry is saved.
- *
- * Context: Any context, but setting @can_alloc to %false is required if
- *          alloc_pages() cannot be used from the current context. Currently
- *          this is the case for contexts where neither %GFP_ATOMIC nor
- *          %GFP_NOWAIT can be used (NMI, raw_spin_lock).
- *
- * Return: Handle of the stack struct stored in depot, 0 on failure
- */
 depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					unsigned int nr_entries,
 					gfp_t alloc_flags, bool can_alloc)
@@ -477,18 +443,6 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 }
 EXPORT_SYMBOL_GPL(__stack_depot_save);
 
-/**
- * stack_depot_save - Save a stack trace to stack depot
- *
- * @entries:		Pointer to the stack trace
- * @nr_entries:		Number of frames in the stack
- * @alloc_flags:	Allocation GFP flags
- *
- * Context: Contexts where allocations via alloc_pages() are allowed.
- *          See __stack_depot_save() for more details.
- *
- * Return: Handle of the stack trace stored in depot, 0 on failure
- */
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries,
 				      gfp_t alloc_flags)
@@ -497,14 +451,6 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 }
 EXPORT_SYMBOL_GPL(stack_depot_save);
 
-/**
- * stack_depot_fetch - Fetch a stack trace from stack depot
- *
- * @handle:	Stack depot handle returned from stack_depot_save()
- * @entries:	Pointer to store the address of the stack trace
- *
- * Return: Number of frames for the fetched stack
- */
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries)
 {
@@ -537,11 +483,6 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 }
 EXPORT_SYMBOL_GPL(stack_depot_fetch);
 
-/**
- * stack_depot_print - Print a stack trace from stack depot
- *
- * @stack:	Stack depot handle returned from stack_depot_save()
- */
 void stack_depot_print(depot_stack_handle_t stack)
 {
 	unsigned long *entries;
@@ -553,16 +494,6 @@ void stack_depot_print(depot_stack_handle_t stack)
 }
 EXPORT_SYMBOL_GPL(stack_depot_print);
 
-/**
- * stack_depot_snprint - Print a stack trace from stack depot into a buffer
- *
- * @handle:	Stack depot handle returned from stack_depot_save()
- * @buf:	Pointer to the print buffer
- * @size:	Size of the print buffer
- * @spaces:	Number of leading spaces to print
- *
- * Return:	Number of bytes printed
- */
 int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
 		       int spaces)
 {
@@ -575,17 +506,6 @@ int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
 }
 EXPORT_SYMBOL_GPL(stack_depot_snprint);
 
-/**
- * stack_depot_set_extra_bits - Set extra bits in a stack depot handle
- *
- * @handle:	Stack depot handle returned from stack_depot_save()
- * @extra_bits:	Value to set the extra bits
- *
- * Return: Stack depot handle with extra bits set
- *
- * Stack depot handles have a few unused bits, which can be used for storing
- * user-specific information. These bits are transparent to the stack depot.
- */
 depot_stack_handle_t __must_check stack_depot_set_extra_bits(
 			depot_stack_handle_t handle, unsigned int extra_bits)
 {
@@ -600,13 +520,6 @@ depot_stack_handle_t __must_check stack_depot_set_extra_bits(
 }
 EXPORT_SYMBOL(stack_depot_set_extra_bits);
 
-/**
- * stack_depot_get_extra_bits - Retrieve extra bits from a stack depot handle
- *
- * @handle:	Stack depot handle with extra bits saved
- *
- * Return: Extra bits retrieved from the stack depot handle
- */
 unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle)
 {
 	union handle_parts parts = { .handle = handle };
-- 
2.25.1

