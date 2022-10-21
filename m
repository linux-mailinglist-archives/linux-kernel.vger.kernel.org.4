Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C89606E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 05:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJUDYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 23:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJUDYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:24:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225511DDDB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 20:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666322659; x=1697858659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TNsKWHYJLqAo/IELz04ecR5M2wF4zce2b3Ctn8SweIk=;
  b=UvBTWdXZfmdyCKnxuwdmvhWMuU2YzM1GMZnoR4IKEu89IDisATU9EVlv
   8U5d4IVWcEnIpuc8q++HzUzC3oHoId1nMY7nKkAZDwI8ynKRdJwx2xivg
   S2Hv0YZlDODsbO2DBNOGreouP6uX9EZ016f+8jpO6rtYOEk6xoQA0xG+q
   8/pDQZepEChWFGBl+y8w0TEwoJb1VcyM/1+1PrABvZpGgEUHokIIDh01b
   2T2EtZJWKT8y5Y6Db8PX9mlBz85C1LstBRoyxayFptTKkBCfurBaU/7Rb
   38c2pyEAmORjra5Vd7yngA72Qi6i7HtdiHEXZhwZsBP3oRsZOpeF530nN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="333471613"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="333471613"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 20:24:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="719459592"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="719459592"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2022 20:24:14 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v7 2/3] mm: kasan: Extend kasan_metadata_size() to also cover in-object size
Date:   Fri, 21 Oct 2022 11:24:04 +0800
Message-Id: <20221021032405.1825078-3-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021032405.1825078-1-feng.tang@intel.com>
References: <20221021032405.1825078-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kasan is enabled for slab/slub, it may save kasan' free_meta
data in the former part of slab object data area in slab object's
free path, which works fine.

There is ongoing effort to extend slub's debug function which will
redzone the latter part of kmalloc object area, and when both of
the debug are enabled, there is possible conflict, especially when
the kmalloc object has small size, as caught by 0Day bot [1].

To solve it, slub code needs to know the in-object kasan's meta
data size. Currently, there is existing kasan_metadata_size()
which returns the kasan's metadata size inside slub's metadata
area, so extend it to also cover the in-object meta size by
adding a boolean flag 'in_object'.

There is no functional change to existing code logic.

[1]. https://lore.kernel.org/lkml/YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020/
Reported-by: kernel test robot <oliver.sang@intel.com>
Suggested-by: Andrey Konovalov <andreyknvl@gmail.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/linux/kasan.h |  5 +++--
 mm/kasan/generic.c    | 19 +++++++++++++------
 mm/slub.c             |  4 ++--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index d811b3d7d2a1..96c9d56e5510 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -302,7 +302,7 @@ static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
 
 #ifdef CONFIG_KASAN_GENERIC
 
-size_t kasan_metadata_size(struct kmem_cache *cache);
+size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object);
 slab_flags_t kasan_never_merge(void);
 void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
 			slab_flags_t *flags);
@@ -315,7 +315,8 @@ void kasan_record_aux_stack_noalloc(void *ptr);
 #else /* CONFIG_KASAN_GENERIC */
 
 /* Tag-based KASAN modes do not use per-object metadata. */
-static inline size_t kasan_metadata_size(struct kmem_cache *cache)
+static inline size_t kasan_metadata_size(struct kmem_cache *cache,
+						bool in_object)
 {
 	return 0;
 }
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index d8b5590f9484..b076f597a378 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -450,15 +450,22 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
 		__memset(alloc_meta, 0, sizeof(*alloc_meta));
 }
 
-size_t kasan_metadata_size(struct kmem_cache *cache)
+size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
 {
+	struct kasan_cache *info = &cache->kasan_info;
+
 	if (!kasan_requires_meta())
 		return 0;
-	return (cache->kasan_info.alloc_meta_offset ?
-		sizeof(struct kasan_alloc_meta) : 0) +
-		((cache->kasan_info.free_meta_offset &&
-		  cache->kasan_info.free_meta_offset != KASAN_NO_FREE_META) ?
-		 sizeof(struct kasan_free_meta) : 0);
+
+	if (in_object)
+		return (info->free_meta_offset ?
+			0 : sizeof(struct kasan_free_meta));
+	else
+		return (info->alloc_meta_offset ?
+			sizeof(struct kasan_alloc_meta) : 0) +
+			((info->free_meta_offset &&
+			info->free_meta_offset != KASAN_NO_FREE_META) ?
+			sizeof(struct kasan_free_meta) : 0);
 }
 
 static void __kasan_record_aux_stack(void *addr, bool can_alloc)
diff --git a/mm/slub.c b/mm/slub.c
index 17292c2d3eee..adff7553b54e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -910,7 +910,7 @@ static void print_trailer(struct kmem_cache *s, struct slab *slab, u8 *p)
 	if (slub_debug_orig_size(s))
 		off += sizeof(unsigned int);
 
-	off += kasan_metadata_size(s);
+	off += kasan_metadata_size(s, false);
 
 	if (off != size_from_object(s))
 		/* Beginning of the filler is the free pointer */
@@ -1070,7 +1070,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
 			off += sizeof(unsigned int);
 	}
 
-	off += kasan_metadata_size(s);
+	off += kasan_metadata_size(s, false);
 
 	if (size_from_object(s) == off)
 		return 1;
-- 
2.34.1

