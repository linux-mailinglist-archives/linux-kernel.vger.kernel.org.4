Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6D263245D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiKUNxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKUNxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:53:31 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F101B94AE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669038810; x=1700574810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xAgBqOEUMmWoQfbkuo6RneBuqFILZ8nL3SYVkdsI98s=;
  b=BBXMjNn1G6DZ7lRQKRZAUM6N+9CBmlwTI5MkcZu1sHgxL7wpYd6wkpKA
   QoBR3DzvnHMtYaIISy6rYqK5fSxAISFVW3N4ByEs5iObMXmKit3iP5cJI
   C9tfbMSZOfIVc3xOk1YrTILOZ+CIDDjUz8Q/T7SNEO//+yoyxLvoKsgsn
   USY09+bweTQjQgvkADb7O+wVlIaJ+FSTCoIpZWLcTPc9GNZWBDLUYdbCn
   pbkQCYp8uLE+zu/fTyA+hrLqAZfxKjfbpf/cq+LV9rS9C5AjXFxcuzp3E
   jcbKaKHYFf6udyxj+LdZXnq+iYX039HEh9hpbMcH2Dv0i7chTme5QdVgL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="312261165"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="312261165"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 05:53:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="886125108"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="886125108"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga006.fm.intel.com with ESMTP; 21 Nov 2022 05:53:26 -0800
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
Subject: [PATCH -next 2/2] mm/kasan: simplify is_kmalloc check
Date:   Mon, 21 Nov 2022 21:50:24 +0800
Message-Id: <20221121135024.1655240-2-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221121135024.1655240-1-feng.tang@intel.com>
References: <20221121135024.1655240-1-feng.tang@intel.com>
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

Use new is_kmalloc_cache() to simplify the code of checking whether
a kmem_cache is a kmalloc cache.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/kasan.h | 9 ---------
 mm/kasan/common.c     | 9 ++-------
 mm/slab_common.c      | 1 -
 3 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index dff604912687..fc46f5d6f404 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -102,7 +102,6 @@ struct kasan_cache {
 	int alloc_meta_offset;
 	int free_meta_offset;
 #endif
-	bool is_kmalloc;
 };
 
 void __kasan_unpoison_range(const void *addr, size_t size);
@@ -129,13 +128,6 @@ static __always_inline bool kasan_unpoison_pages(struct page *page,
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
@@ -252,7 +244,6 @@ static inline void kasan_poison_pages(struct page *page, unsigned int order,
 				      bool init) {}
 static inline bool kasan_unpoison_pages(struct page *page, unsigned int order,
 					bool init) { return false; }
-static inline void kasan_cache_create_kmalloc(struct kmem_cache *cache) {}
 static inline void kasan_poison_slab(struct slab *slab) {}
 static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
 					void *object) {}
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 1f30080a7a4c..f7e0e5067e7a 100644
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
+	if (kasan_stack_collection_enabled() && is_kmalloc_cache(cache))
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
index 8276022f0da4..a5480d67f391 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -663,7 +663,6 @@ struct kmem_cache *__init create_kmalloc_cache(const char *name,
 
 	create_boot_cache(s, name, size, flags | SLAB_KMALLOC, useroffset,
 								usersize);
-	kasan_cache_create_kmalloc(s);
 	list_add(&s->list, &slab_caches);
 	s->refcount = 1;
 	return s;
-- 
2.34.1

