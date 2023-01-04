Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C4365CCCA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjADGJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjADGIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:08:52 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8093BFD20
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 22:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672812530; x=1704348530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yjPAo3gzL+gE/D3nqOFC9+brYvlet3IWm71HhQsK8Fo=;
  b=SJfKpvYh++XWiwE6vEsDuGnfzmsAxRLBcc2hOVX9UFUdqabbhhBR2gvo
   vTlT1IWrnmZEtk98eRD1Ny7U+kdW66rUZ3hbOMMc4KBjAxufOBxwTKHue
   aUHi64fawAFPsvWWCHJ50IIxgb25NxYvgoonD6hdzff1KhlpeYybP1lrL
   xer3enWWsOQ7IPseKznTcBqxu9o/AYNX5ZFvhIoz8gypuJRKLqP95DLN/
   ZP0Os246rajTsENRmI3oCQVXa2pmaB4n34qUFL9Y/jj8/yuRxs1AdmCeR
   IufTR1TFqS0MG6Doznasg0bLZ/glL9/QI6lYkWexupl2GKCvABG1vu/mX
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="323840140"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="323840140"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 22:08:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="779094081"
X-IronPort-AV: E=Sophos;i="5.96,299,1665471600"; 
   d="scan'208";a="779094081"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by orsmga004.jf.intel.com with ESMTP; 03 Jan 2023 22:08:45 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-mm@kvack.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>
Subject: [Patch v3 -mm 2/2] mm/kasan: simplify and refine kasan_cache code
Date:   Wed,  4 Jan 2023 14:06:05 +0800
Message-Id: <20230104060605.930910-2-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230104060605.930910-1-feng.tang@intel.com>
References: <20230104060605.930910-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct 'kasan_cache' has a member 'is_kmalloc' indicating whether
its host kmem_cache is a kmalloc cache. With newly introduced
is_kmalloc_cache() helper, 'is_kmalloc' and its related function can
be replaced and removed.

Also 'kasan_cache' is only needed by KASAN generic mode, and not by
SW/HW tag modes, so refine its protection macro accordingly, suggested
by Andrey Konoval.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
---
Changlog:

  Since v2:
  * Rebase latest -mm tree, fix a conflict with kasan changes
  * Collect Reviewed-by tag

  Since v1
  * Use CONFIG_KASAN_GENERIC instead of CONFIG_KASAN for 'kasan_cache',
    as suggested by Andrey Konovalov

 include/linux/kasan.h    | 22 +++++-----------------
 include/linux/slab_def.h |  2 +-
 include/linux/slub_def.h |  2 +-
 mm/kasan/common.c        |  9 ++-------
 mm/slab_common.c         |  1 -
 5 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 5ebbaf672009..f7ef70661ce2 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -96,15 +96,6 @@ static inline bool kasan_has_integrated_init(void)
 }
 
 #ifdef CONFIG_KASAN
-
-struct kasan_cache {
-#ifdef CONFIG_KASAN_GENERIC
-	int alloc_meta_offset;
-	int free_meta_offset;
-#endif
-	bool is_kmalloc;
-};
-
 void __kasan_unpoison_range(const void *addr, size_t size);
 static __always_inline void kasan_unpoison_range(const void *addr, size_t size)
 {
@@ -129,13 +120,6 @@ static __always_inline bool kasan_unpoison_pages(struct page *page,
 	return false;
 }
 
-void __kasan_cache_create_kmalloc(struct kmem_cache *cache);
-static __always_inline void kasan_cache_create_kmalloc(struct kmem_cache *cache)
-{
-	if (kasan_enabled())
-		__kasan_cache_create_kmalloc(cache);
-}
-
 void __kasan_poison_slab(struct slab *slab);
 static __always_inline void kasan_poison_slab(struct slab *slab)
 {
@@ -255,7 +239,6 @@ static inline bool kasan_unpoison_pages(struct page *page, unsigned int order,
 {
 	return false;
 }
-static inline void kasan_cache_create_kmalloc(struct kmem_cache *cache) {}
 static inline void kasan_poison_slab(struct slab *slab) {}
 static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
 					void *object) {}
@@ -306,6 +289,11 @@ static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
 
 #ifdef CONFIG_KASAN_GENERIC
 
+struct kasan_cache {
+	int alloc_meta_offset;
+	int free_meta_offset;
+};
+
 size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object);
 slab_flags_t kasan_never_merge(void);
 void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index 5834bad8ad78..a61e7d55d0d3 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -72,7 +72,7 @@ struct kmem_cache {
 	int obj_offset;
 #endif /* CONFIG_DEBUG_SLAB */
 
-#ifdef CONFIG_KASAN
+#ifdef CONFIG_KASAN_GENERIC
 	struct kasan_cache kasan_info;
 #endif
 
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index aa0ee1678d29..f6df03f934e5 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -136,7 +136,7 @@ struct kmem_cache {
 	unsigned int *random_seq;
 #endif
 
-#ifdef CONFIG_KASAN
+#ifdef CONFIG_KASAN_GENERIC
 	struct kasan_cache kasan_info;
 #endif
 
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 1d0008e1c420..6b8e9c848573 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -122,11 +122,6 @@ void __kasan_poison_pages(struct page *page, unsigned int order, bool init)
 			     KASAN_PAGE_FREE, init);
 }
 
-void __kasan_cache_create_kmalloc(struct kmem_cache *cache)
-{
-	cache->kasan_info.is_kmalloc = true;
-}
-
 void __kasan_poison_slab(struct slab *slab)
 {
 	struct page *page = slab_page(slab);
@@ -326,7 +321,7 @@ void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
 	kasan_unpoison(tagged_object, cache->object_size, init);
 
 	/* Save alloc info (if possible) for non-kmalloc() allocations. */
-	if (kasan_stack_collection_enabled() && !cache->kasan_info.is_kmalloc)
+	if (kasan_stack_collection_enabled() && !is_kmalloc_cache(cache))
 		kasan_save_alloc_info(cache, tagged_object, flags);
 
 	return tagged_object;
@@ -372,7 +367,7 @@ static inline void *____kasan_kmalloc(struct kmem_cache *cache,
 	 * Save alloc info (if possible) for kmalloc() allocations.
 	 * This also rewrites the alloc info when called from kasan_krealloc().
 	 */
-	if (kasan_stack_collection_enabled() && cache->kasan_info.is_kmalloc)
+	if (kasan_stack_collection_enabled() && is_kmalloc_cache(cache))
 		kasan_save_alloc_info(cache, (void *)object, flags);
 
 	/* Keep the tag that was set by kasan_slab_alloc(). */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1cba98acc486..bf4e777cfe90 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -670,7 +670,6 @@ struct kmem_cache *__init create_kmalloc_cache(const char *name,
 
 	create_boot_cache(s, name, size, flags | SLAB_KMALLOC, useroffset,
 								usersize);
-	kasan_cache_create_kmalloc(s);
 	list_add(&s->list, &slab_caches);
 	s->refcount = 1;
 	return s;
-- 
2.34.1

