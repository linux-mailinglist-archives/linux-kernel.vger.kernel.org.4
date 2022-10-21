Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BE8606E4A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 05:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJUDYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 23:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJUDYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:24:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99D01B65C8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 20:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666322654; x=1697858654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DZlZbkmzdjTJqsSTh0PWMpWULB1+KKo5zc/qeSpD1kM=;
  b=FPaYQwtMlGIygD5c5XwrdlDH0d1K99m5v9aroVtLozfMUN1gN3NyZfBu
   4lmZydFRf28L0vKlQRWlxu26ZLaBkSDcTBRewhZPFZf/h6dnDRKvieazA
   1DHONo4f8tHtv5CTfgx/FN4s8+ZZM1BYiQ2fQ8UiLWxEA24Y3q92OJQP2
   dBS1ydgX3BT73WRXdGAYqi3z1LYTqHM0pDEB/YhcthR9fFYuKoVTjWX0z
   Kv6wkt21djkVRZIc9QhfKSx4Qqcx3iegep4tkPn5b2gtiEWsmpCZfSWte
   xqsImrqjNAxo1OvFRwUjpMZrEEQFkkkjDLoOpTR6LrCWdpNMjTRi8OsMB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="333471603"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="333471603"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 20:24:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="719459559"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="719459559"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2022 20:24:11 -0700
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
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v7 1/3] mm/slub: only zero requested size of buffer for kzalloc when debug enabled
Date:   Fri, 21 Oct 2022 11:24:03 +0800
Message-Id: <20221021032405.1825078-2-feng.tang@intel.com>
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

kzalloc/kmalloc will round up the request size to a fixed size
(mostly power of 2), so the allocated memory could be more than
requested. Currently kzalloc family APIs will zero all the
allocated memory.

To detect out-of-bound usage of the extra allocated memory, only
zero the requested part, so that redzone sanity check could be
added to the extra space later.

For kzalloc users who will call ksize() later and utilize this
extra space, please be aware that the space is not zeroed any
more when debug is enabled. (Thanks to Kees Cook's effort to
sanitize all ksize() user cases [1], this won't be a big issue).

[1]. https://lore.kernel.org/all/20220922031013.2150682-1-keescook@chromium.org/#r
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/slab.c |  7 ++++---
 mm/slab.h | 18 ++++++++++++++++--
 mm/slub.c | 10 +++++++---
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index a5486ff8362a..4594de0e3d6b 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3253,7 +3253,8 @@ slab_alloc_node(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
 	init = slab_want_init_on_alloc(flags, cachep);
 
 out:
-	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init);
+	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init,
+				cachep->object_size);
 	return objp;
 }
 
@@ -3506,13 +3507,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	 * Done outside of the IRQ disabled section.
 	 */
 	slab_post_alloc_hook(s, objcg, flags, size, p,
-				slab_want_init_on_alloc(flags, s));
+			slab_want_init_on_alloc(flags, s), s->object_size);
 	/* FIXME: Trace call missing. Christoph would like a bulk variant */
 	return size;
 error:
 	local_irq_enable();
 	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
-	slab_post_alloc_hook(s, objcg, flags, i, p, false);
+	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
 	kmem_cache_free_bulk(s, i, p);
 	return 0;
 }
diff --git a/mm/slab.h b/mm/slab.h
index 0202a8c2f0d2..8b4ee02fc14a 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -720,12 +720,26 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
 
 static inline void slab_post_alloc_hook(struct kmem_cache *s,
 					struct obj_cgroup *objcg, gfp_t flags,
-					size_t size, void **p, bool init)
+					size_t size, void **p, bool init,
+					unsigned int orig_size)
 {
+	unsigned int zero_size = s->object_size;
 	size_t i;
 
 	flags &= gfp_allowed_mask;
 
+	/*
+	 * For kmalloc object, the allocated memory size(object_size) is likely
+	 * larger than the requested size(orig_size). If redzone check is
+	 * enabled for the extra space, don't zero it, as it will be redzoned
+	 * soon. The redzone operation for this extra space could be seen as a
+	 * replacement of current poisoning under certain debug option, and
+	 * won't break other sanity checks.
+	 */
+	if (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
+	    (s->flags & SLAB_KMALLOC))
+		zero_size = orig_size;
+
 	/*
 	 * As memory initialization might be integrated into KASAN,
 	 * kasan_slab_alloc and initialization memset must be
@@ -736,7 +750,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 	for (i = 0; i < size; i++) {
 		p[i] = kasan_slab_alloc(s, p[i], flags, init);
 		if (p[i] && init && !kasan_has_integrated_init())
-			memset(p[i], 0, s->object_size);
+			memset(p[i], 0, zero_size);
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, flags);
 		kmsan_slab_alloc(s, p[i], flags);
diff --git a/mm/slub.c b/mm/slub.c
index 12354fb8d6e4..17292c2d3eee 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3395,7 +3395,11 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
 	init = slab_want_init_on_alloc(gfpflags, s);
 
 out:
-	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init);
+	/*
+	 * When init equals 'true', like for kzalloc() family, only
+	 * @orig_size bytes will be zeroed instead of s->object_size
+	 */
+	slab_post_alloc_hook(s, objcg, gfpflags, 1, &object, init, orig_size);
 
 	return object;
 }
@@ -3852,11 +3856,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	 * Done outside of the IRQ disabled fastpath loop.
 	 */
 	slab_post_alloc_hook(s, objcg, flags, size, p,
-				slab_want_init_on_alloc(flags, s));
+			slab_want_init_on_alloc(flags, s), s->object_size);
 	return i;
 error:
 	slub_put_cpu_ptr(s->cpu_slab);
-	slab_post_alloc_hook(s, objcg, flags, i, p, false);
+	slab_post_alloc_hook(s, objcg, flags, i, p, false, s->object_size);
 	kmem_cache_free_bulk(s, i, p);
 	return 0;
 }
-- 
2.34.1

