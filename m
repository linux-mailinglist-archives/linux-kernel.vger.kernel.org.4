Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4338F651187
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiLSSJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiLSSJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:09:25 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8883C13D2E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:09:22 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671473360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q1bgbk/eccXXGZAfv8673C2QwsHP8oQwWEyVA4UhFuA=;
        b=Q0abomfey0eVyDXeEpG4bSeCNeX+2I4SQ+MKSq08jSIPT6eCVdjibkXNCrs3VD5dtuP+cF
        Qo+EQGI46I3OaaK91MsGAWHYnelGnvwoH9JbL3Ez0Xy3kZAzW3nhhwRzsCijpmfjGYP/vk
        2YX2SsMhZWJ+wqh8VmNaaG33YDY4YtM=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v4] kasan: allow sampling page_alloc allocations for HW_TAGS
Date:   Mon, 19 Dec 2022 19:09:18 +0100
Message-Id: <129da0614123bb85ed4dd61ae30842b2dd7c903f.1671471846.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

As Hardware Tag-Based KASAN is intended to be used in production, its
performance impact is crucial. As page_alloc allocations tend to be big,
tagging and checking all such allocations can introduce a significant
slowdown.

Add two new boot parameters that allow to alleviate that slowdown:

- kasan.page_alloc.sample, which makes Hardware Tag-Based KASAN tag only
  every Nth page_alloc allocation with the order configured by the second
  added parameter (default: tag every such allocation).

- kasan.page_alloc.sample.order, which makes sampling enabled by the first
  parameter only affect page_alloc allocations with the order equal or
  greater than the specified value (default: 3, see below).

The exact performance improvement caused by using the new parameters
depends on their values and the applied workload.

The chosen default value for kasan.page_alloc.sample.order is 3, which
matches both PAGE_ALLOC_COSTLY_ORDER and SKB_FRAG_PAGE_ORDER. This is done
for two reasons:

1. PAGE_ALLOC_COSTLY_ORDER is "the order at which allocations are deemed
   costly to service", which corresponds to the idea that only large and
   thus costly allocations are supposed to sampled.

2. One of the workloads targeted by this patch is a benchmark that sends
   a large amount of data over a local loopback connection. Most multi-page
   data allocations in the networking subsystem have the order of
   SKB_FRAG_PAGE_ORDER (or PAGE_ALLOC_COSTLY_ORDER).

When running a local loopback test on a testing MTE-enabled device in sync
mode, enabling Hardware Tag-Based KASAN introduces a ~50% slowdown.
Applying this patch and setting kasan.page_alloc.sampling to a value higher
than 1 allows to lower the slowdown. The performance improvement saturates
around the sampling interval value of 10 with the default sampling page
order of 3. This lowers the slowdown to ~20%. The slowdown in real
scenarios involving the network will likely be better.

Enabling page_alloc sampling has a downside: KASAN misses bad accesses to
a page_alloc allocation that has not been tagged. This lowers the value of
KASAN as a security mitigation.

However, based on measuring the number of page_alloc allocations of
different orders during boot in a test build, sampling with the default
kasan.page_alloc.sample.order value affects only ~7% of allocations.
The rest ~93% of allocations are still checked deterministically.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v3-v4:
- Minor documentation fixes.

Changes v2-v3:
- Drop __GFP_KASAN_SAMPLE flag.
- Add kasan.page_alloc.sample.order.
- Add fast-path for disabled sampling to kasan_sample_page_alloc.

Changes v1->v2:
- Only sample allocations when __GFP_KASAN_SAMPLE is provided to
  alloc_pages().
- Fix build when KASAN is disabled.
- Add more information about the flag to documentation.
- Use optimized preemption-safe approach for sampling suggested by Marco.
---
 Documentation/dev-tools/kasan.rst | 17 +++++++++
 include/linux/kasan.h             | 14 +++++---
 mm/kasan/common.c                 |  9 +++--
 mm/kasan/hw_tags.c                | 60 +++++++++++++++++++++++++++++++
 mm/kasan/kasan.h                  | 27 ++++++++++++++
 mm/page_alloc.c                   | 43 ++++++++++++++--------
 6 files changed, 149 insertions(+), 21 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 5c93ab915049..e66916a483cd 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -140,6 +140,23 @@ disabling KASAN altogether or controlling its features:
 - ``kasan.vmalloc=off`` or ``=on`` disables or enables tagging of vmalloc
   allocations (default: ``on``).
 
+- ``kasan.page_alloc.sample=<sampling interval>`` makes KASAN tag only every
+  Nth page_alloc allocation with the order equal or greater than
+  ``kasan.page_alloc.sample.order``, where N is the value of the ``sample``
+  parameter (default: ``1``, or tag every such allocation).
+  This parameter is intended to mitigate the performance overhead introduced
+  by KASAN.
+  Note that enabling this parameter makes Hardware Tag-Based KASAN skip checks
+  of allocations chosen by sampling and thus miss bad accesses to these
+  allocations. Use the default value for accurate bug detection.
+
+- ``kasan.page_alloc.sample.order=<minimum page order>`` specifies the minimum
+  order of allocations that are affected by sampling (default: ``3``).
+  Only applies when ``kasan.page_alloc.sample`` is set to a value greater
+  than ``1``.
+  This parameter is intended to allow sampling only large page_alloc
+  allocations, which is the biggest source of the performance overhead.
+
 Error reports
 ~~~~~~~~~~~~~
 
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 96c9d56e5510..5ebbaf672009 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -120,12 +120,13 @@ static __always_inline void kasan_poison_pages(struct page *page,
 		__kasan_poison_pages(page, order, init);
 }
 
-void __kasan_unpoison_pages(struct page *page, unsigned int order, bool init);
-static __always_inline void kasan_unpoison_pages(struct page *page,
+bool __kasan_unpoison_pages(struct page *page, unsigned int order, bool init);
+static __always_inline bool kasan_unpoison_pages(struct page *page,
 						 unsigned int order, bool init)
 {
 	if (kasan_enabled())
-		__kasan_unpoison_pages(page, order, init);
+		return __kasan_unpoison_pages(page, order, init);
+	return false;
 }
 
 void __kasan_cache_create_kmalloc(struct kmem_cache *cache);
@@ -249,8 +250,11 @@ static __always_inline bool kasan_check_byte(const void *addr)
 static inline void kasan_unpoison_range(const void *address, size_t size) {}
 static inline void kasan_poison_pages(struct page *page, unsigned int order,
 				      bool init) {}
-static inline void kasan_unpoison_pages(struct page *page, unsigned int order,
-					bool init) {}
+static inline bool kasan_unpoison_pages(struct page *page, unsigned int order,
+					bool init)
+{
+	return false;
+}
 static inline void kasan_cache_create_kmalloc(struct kmem_cache *cache) {}
 static inline void kasan_poison_slab(struct slab *slab) {}
 static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 833bf2cfd2a3..1d0008e1c420 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -95,19 +95,24 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
 }
 #endif /* CONFIG_KASAN_STACK */
 
-void __kasan_unpoison_pages(struct page *page, unsigned int order, bool init)
+bool __kasan_unpoison_pages(struct page *page, unsigned int order, bool init)
 {
 	u8 tag;
 	unsigned long i;
 
 	if (unlikely(PageHighMem(page)))
-		return;
+		return false;
+
+	if (!kasan_sample_page_alloc(order))
+		return false;
 
 	tag = kasan_random_tag();
 	kasan_unpoison(set_tag(page_address(page), tag),
 		       PAGE_SIZE << order, init);
 	for (i = 0; i < (1 << order); i++)
 		page_kasan_tag_set(page + i, tag);
+
+	return true;
 }
 
 void __kasan_poison_pages(struct page *page, unsigned int order, bool init)
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index b22c4f461cb0..d1bcb0205327 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -59,6 +59,24 @@ EXPORT_SYMBOL_GPL(kasan_mode);
 /* Whether to enable vmalloc tagging. */
 DEFINE_STATIC_KEY_TRUE(kasan_flag_vmalloc);
 
+#define PAGE_ALLOC_SAMPLE_DEFAULT	1
+#define PAGE_ALLOC_SAMPLE_ORDER_DEFAULT	3
+
+/*
+ * Sampling interval of page_alloc allocation (un)poisoning.
+ * Defaults to no sampling.
+ */
+unsigned long kasan_page_alloc_sample = PAGE_ALLOC_SAMPLE_DEFAULT;
+
+/*
+ * Minimum order of page_alloc allocations to be affected by sampling.
+ * The default value is chosen to match both
+ * PAGE_ALLOC_COSTLY_ORDER and SKB_FRAG_PAGE_ORDER.
+ */
+unsigned int kasan_page_alloc_sample_order = PAGE_ALLOC_SAMPLE_ORDER_DEFAULT;
+
+DEFINE_PER_CPU(long, kasan_page_alloc_skip);
+
 /* kasan=off/on */
 static int __init early_kasan_flag(char *arg)
 {
@@ -122,6 +140,48 @@ static inline const char *kasan_mode_info(void)
 		return "sync";
 }
 
+/* kasan.page_alloc.sample=<sampling interval> */
+static int __init early_kasan_flag_page_alloc_sample(char *arg)
+{
+	int rv;
+
+	if (!arg)
+		return -EINVAL;
+
+	rv = kstrtoul(arg, 0, &kasan_page_alloc_sample);
+	if (rv)
+		return rv;
+
+	if (!kasan_page_alloc_sample || kasan_page_alloc_sample > LONG_MAX) {
+		kasan_page_alloc_sample = PAGE_ALLOC_SAMPLE_DEFAULT;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+early_param("kasan.page_alloc.sample", early_kasan_flag_page_alloc_sample);
+
+/* kasan.page_alloc.sample.order=<minimum page order> */
+static int __init early_kasan_flag_page_alloc_sample_order(char *arg)
+{
+	int rv;
+
+	if (!arg)
+		return -EINVAL;
+
+	rv = kstrtouint(arg, 0, &kasan_page_alloc_sample_order);
+	if (rv)
+		return rv;
+
+	if (kasan_page_alloc_sample_order > INT_MAX) {
+		kasan_page_alloc_sample_order = PAGE_ALLOC_SAMPLE_ORDER_DEFAULT;
+		return -EINVAL;
+	}
+
+	return 0;
+}
+early_param("kasan.page_alloc.sample.order", early_kasan_flag_page_alloc_sample_order);
+
 /*
  * kasan_init_hw_tags_cpu() is called for each CPU.
  * Not marked as __init as a CPU can be hot-plugged after boot.
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index ea8cf1310b1e..32413f22aa82 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -42,6 +42,10 @@ enum kasan_mode {
 
 extern enum kasan_mode kasan_mode __ro_after_init;
 
+extern unsigned long kasan_page_alloc_sample;
+extern unsigned int kasan_page_alloc_sample_order;
+DECLARE_PER_CPU(long, kasan_page_alloc_skip);
+
 static inline bool kasan_vmalloc_enabled(void)
 {
 	return static_branch_likely(&kasan_flag_vmalloc);
@@ -57,6 +61,24 @@ static inline bool kasan_sync_fault_possible(void)
 	return kasan_mode == KASAN_MODE_SYNC || kasan_mode == KASAN_MODE_ASYMM;
 }
 
+static inline bool kasan_sample_page_alloc(unsigned int order)
+{
+	/* Fast-path for when sampling is disabled. */
+	if (kasan_page_alloc_sample == 1)
+		return true;
+
+	if (order < kasan_page_alloc_sample_order)
+		return true;
+
+	if (this_cpu_dec_return(kasan_page_alloc_skip) < 0) {
+		this_cpu_write(kasan_page_alloc_skip,
+			       kasan_page_alloc_sample - 1);
+		return true;
+	}
+
+	return false;
+}
+
 #else /* CONFIG_KASAN_HW_TAGS */
 
 static inline bool kasan_async_fault_possible(void)
@@ -69,6 +91,11 @@ static inline bool kasan_sync_fault_possible(void)
 	return true;
 }
 
+static inline bool kasan_sample_page_alloc(unsigned int order)
+{
+	return true;
+}
+
 #endif /* CONFIG_KASAN_HW_TAGS */
 
 #ifdef CONFIG_KASAN_GENERIC
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0745aedebb37..7d980dc0000e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1356,6 +1356,8 @@ static int free_tail_pages_check(struct page *head_page, struct page *page)
  *    see the comment next to it.
  * 3. Skipping poisoning is requested via __GFP_SKIP_KASAN_POISON,
  *    see the comment next to it.
+ * 4. The allocation is excluded from being checked due to sampling,
+ *    see the call to kasan_unpoison_pages.
  *
  * Poisoning pages during deferred memory init will greatly lengthen the
  * process and cause problem in large memory systems as the deferred pages
@@ -2468,7 +2470,8 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 {
 	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
 			!should_skip_init(gfp_flags);
-	bool init_tags = init && (gfp_flags & __GFP_ZEROTAGS);
+	bool zero_tags = init && (gfp_flags & __GFP_ZEROTAGS);
+	bool reset_tags = !zero_tags;
 	int i;
 
 	set_page_private(page, 0);
@@ -2491,30 +2494,42 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	 */
 
 	/*
-	 * If memory tags should be zeroed (which happens only when memory
-	 * should be initialized as well).
+	 * If memory tags should be zeroed
+	 * (which happens only when memory should be initialized as well).
 	 */
-	if (init_tags) {
+	if (zero_tags) {
 		/* Initialize both memory and tags. */
 		for (i = 0; i != 1 << order; ++i)
 			tag_clear_highpage(page + i);
 
-		/* Note that memory is already initialized by the loop above. */
+		/* Take note that memory was initialized by the loop above. */
 		init = false;
 	}
 	if (!should_skip_kasan_unpoison(gfp_flags)) {
-		/* Unpoison shadow memory or set memory tags. */
-		kasan_unpoison_pages(page, order, init);
-
-		/* Note that memory is already initialized by KASAN. */
-		if (kasan_has_integrated_init())
-			init = false;
-	} else {
-		/* Ensure page_address() dereferencing does not fault. */
+		/* Try unpoisoning (or setting tags) and initializing memory. */
+		if (kasan_unpoison_pages(page, order, init)) {
+			/* Take note that memory was initialized by KASAN. */
+			if (kasan_has_integrated_init())
+				init = false;
+			/* Take note that memory tags were set by KASAN. */
+			reset_tags = false;
+		} else {
+			/*
+			 * KASAN decided to exclude this allocation from being
+			 * poisoned due to sampling. Skip poisoning as well.
+			 */
+			SetPageSkipKASanPoison(page);
+		}
+	}
+	/*
+	 * If memory tags have not been set, reset the page tags to ensure
+	 * page_address() dereferencing does not fault.
+	 */
+	if (reset_tags) {
 		for (i = 0; i != 1 << order; ++i)
 			page_kasan_tag_reset(page + i);
 	}
-	/* If memory is still not initialized, do it now. */
+	/* If memory is still not initialized, initialize it now. */
 	if (init)
 		kernel_init_pages(page, 1 << order);
 	/* Propagate __GFP_SKIP_KASAN_POISON to page flags. */
-- 
2.25.1

