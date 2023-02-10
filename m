Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B98A692926
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjBJVTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbjBJVTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:19:18 -0500
Received: from out-134.mta1.migadu.com (out-134.mta1.migadu.com [95.215.58.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DB316319
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 13:18:48 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676063899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVeF/wdyK+2zAJh1QGD4/79VjlNXyPEki9KG1Xr/HS8=;
        b=mZ77UXQw8ph3QwwxXcMEUBuXupMLlxGBtFsT/tvE3yPr1CWb80YBs30hTsFcDo2cxvMjfU
        fh5338Sdmtuz7SNFr7A8idY55ISDszradFlit9kl2SJREmvICU9yKZEh/SEEnh1I4YWVCb
        jOA+wNYeS/EARv0AleT+tvRG6/ySbBA=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 15/18] lib/stacktrace, kasan, kmsan: rework extra_bits interface
Date:   Fri, 10 Feb 2023 22:16:03 +0100
Message-Id: <317123b5c05e2f82854fc55d8b285e0869d3cb77.1676063693.git.andreyknvl@google.com>
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

The current implementation of the extra_bits interface is confusing:
passing extra_bits to __stack_depot_save makes it seem that the extra
bits are somehow stored in stack depot. In reality, they are only
embedded into a stack depot handle and are not used within stack depot.

Drop the extra_bits argument from __stack_depot_save and instead provide
a new stack_depot_set_extra_bits function (similar to the exsiting
stack_depot_get_extra_bits) that saves extra bits into a stack depot
handle.

Update the callers of __stack_depot_save to use the new interace.

This change also fixes a minor issue in the old code: __stack_depot_save
does not return NULL if saving stack trace fails and extra_bits is used.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Changes v1->v2:
- Mark stack_depot_set_extra_bits as __must_check.
- Only assign extra bits in stack_depot_set_extra_bits for non-empty
  handles.
---
 include/linux/stackdepot.h |  4 +++-
 lib/stackdepot.c           | 42 ++++++++++++++++++++++++++++++--------
 mm/kasan/common.c          |  2 +-
 mm/kmsan/core.c            | 10 ++++++---
 4 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index c4e3abc16b16..267f4b2634ee 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -57,7 +57,6 @@ static inline int stack_depot_early_init(void)	{ return 0; }
 
 depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					unsigned int nr_entries,
-					unsigned int extra_bits,
 					gfp_t gfp_flags, bool can_alloc);
 
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
@@ -71,6 +70,9 @@ void stack_depot_print(depot_stack_handle_t stack);
 int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
 		       int spaces);
 
+depot_stack_handle_t __must_check stack_depot_set_extra_bits(
+			depot_stack_handle_t handle, unsigned int extra_bits);
+
 unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle);
 
 #endif
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 4df162a84bfe..8c6e4e9cb535 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -357,7 +357,6 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
  *
  * @entries:		Pointer to storage array
  * @nr_entries:		Size of the storage array
- * @extra_bits:		Flags to store in unused bits of depot_stack_handle_t
  * @alloc_flags:	Allocation gfp flags
  * @can_alloc:		Allocate stack pools (increased chance of failure if false)
  *
@@ -369,10 +368,6 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
  * If the stack trace in @entries is from an interrupt, only the portion up to
  * interrupt entry is saved.
  *
- * Additional opaque flags can be passed in @extra_bits, stored in the unused
- * bits of the stack handle, and retrieved using stack_depot_get_extra_bits()
- * without calling stack_depot_fetch().
- *
  * Context: Any context, but setting @can_alloc to %false is required if
  *          alloc_pages() cannot be used from the current context. Currently
  *          this is the case from contexts where neither %GFP_ATOMIC nor
@@ -382,7 +377,6 @@ static inline struct stack_record *find_stack(struct stack_record *bucket,
  */
 depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					unsigned int nr_entries,
-					unsigned int extra_bits,
 					gfp_t alloc_flags, bool can_alloc)
 {
 	struct stack_record *found = NULL, **bucket;
@@ -471,8 +465,6 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	if (found)
 		retval.handle = found->handle.handle;
 fast_exit:
-	retval.extra = extra_bits;
-
 	return retval.handle;
 }
 EXPORT_SYMBOL_GPL(__stack_depot_save);
@@ -493,7 +485,7 @@ depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries,
 				      gfp_t alloc_flags)
 {
-	return __stack_depot_save(entries, nr_entries, 0, alloc_flags, true);
+	return __stack_depot_save(entries, nr_entries, alloc_flags, true);
 }
 EXPORT_SYMBOL_GPL(stack_depot_save);
 
@@ -576,6 +568,38 @@ int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
 }
 EXPORT_SYMBOL_GPL(stack_depot_snprint);
 
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
+depot_stack_handle_t __must_check stack_depot_set_extra_bits(
+			depot_stack_handle_t handle, unsigned int extra_bits)
+{
+	union handle_parts parts = { .handle = handle };
+
+	/* Don't set extra bits on empty handles. */
+	if (!handle)
+		return 0;
+
+	parts.extra = extra_bits;
+	return parts.handle;
+}
+EXPORT_SYMBOL(stack_depot_set_extra_bits);
+
+/**
+ * stack_depot_get_extra_bits - Retrieve extra bits from a stack depot handle
+ *
+ * @handle:	Stack depot handle with extra bits saved
+ *
+ * Return: Extra bits retrieved from the stack depot handle
+ */
 unsigned int stack_depot_get_extra_bits(depot_stack_handle_t handle)
 {
 	union handle_parts parts = { .handle = handle };
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 833bf2cfd2a3..50f4338b477f 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -43,7 +43,7 @@ depot_stack_handle_t kasan_save_stack(gfp_t flags, bool can_alloc)
 	unsigned int nr_entries;
 
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
-	return __stack_depot_save(entries, nr_entries, 0, flags, can_alloc);
+	return __stack_depot_save(entries, nr_entries, flags, can_alloc);
 }
 
 void kasan_set_track(struct kasan_track *track, gfp_t flags)
diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index 112dce135c7f..f710257d6867 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -69,13 +69,15 @@ depot_stack_handle_t kmsan_save_stack_with_flags(gfp_t flags,
 {
 	unsigned long entries[KMSAN_STACK_DEPTH];
 	unsigned int nr_entries;
+	depot_stack_handle_t handle;
 
 	nr_entries = stack_trace_save(entries, KMSAN_STACK_DEPTH, 0);
 
 	/* Don't sleep (see might_sleep_if() in __alloc_pages_nodemask()). */
 	flags &= ~__GFP_DIRECT_RECLAIM;
 
-	return __stack_depot_save(entries, nr_entries, extra, flags, true);
+	handle = __stack_depot_save(entries, nr_entries, flags, true);
+	return stack_depot_set_extra_bits(handle, extra);
 }
 
 /* Copy the metadata following the memmove() behavior. */
@@ -215,6 +217,7 @@ depot_stack_handle_t kmsan_internal_chain_origin(depot_stack_handle_t id)
 	u32 extra_bits;
 	int depth;
 	bool uaf;
+	depot_stack_handle_t handle;
 
 	if (!id)
 		return id;
@@ -250,8 +253,9 @@ depot_stack_handle_t kmsan_internal_chain_origin(depot_stack_handle_t id)
 	 * positives when __stack_depot_save() passes it to instrumented code.
 	 */
 	kmsan_internal_unpoison_memory(entries, sizeof(entries), false);
-	return __stack_depot_save(entries, ARRAY_SIZE(entries), extra_bits,
-				  GFP_ATOMIC, true);
+	handle = __stack_depot_save(entries, ARRAY_SIZE(entries), GFP_ATOMIC,
+				    true);
+	return stack_depot_set_extra_bits(handle, extra_bits);
 }
 
 void kmsan_internal_set_shadow_origin(void *addr, size_t size, int b,
-- 
2.25.1

