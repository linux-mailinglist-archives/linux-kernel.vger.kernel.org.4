Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB65B6835
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiIMGzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiIMGy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:54:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2E312D36
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663052094; x=1694588094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jNIjARJaqhZDNzVjt1J74PS/eC/mhxmnJkoZtfdgppw=;
  b=UOdizk4RsiiFSxlXLWgk3JJaIhgbs+1ct8yX8Xd7dqFlI2UJ9dnF/ddP
   ULqdSO0yDWf0o/MOSPm3+APwUesh6vmr1PHM6YKFSCFujiH70Z1ikALjb
   T4HWdHWFoog/aBhpWhO6q/JpCypdsDKtlwFA9BTxoCsAvpR6rISqzUpnN
   QcjRqWoCtPul4HeYcmYMgIELthV+h1XOzPPYX7Q2w4t8ATPRrq2LB09st
   J96igUebfZg2FfBAoOp5ntjrYOkmG8W+izcJz8PYiatPTRMdVENZ2BQg2
   S4mNbklsHKAgNFfaqNeuEsNggM4hKY0nZHSI08wskhmnInkJ8zdqtqGI3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="298855248"
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="298855248"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 23:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,312,1654585200"; 
   d="scan'208";a="861440725"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by fmsmga006.fm.intel.com with ESMTP; 12 Sep 2022 23:54:51 -0700
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
        Jonathan Corbet <corbet@lwn.net>,
        Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Feng Tang <feng.tang@intel.com>
Subject: [PATCH v6 2/4] mm/slub: only zero the requested size of buffer for kzalloc
Date:   Tue, 13 Sep 2022 14:54:21 +0800
Message-Id: <20220913065423.520159-3-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220913065423.520159-1-feng.tang@intel.com>
References: <20220913065423.520159-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
zero the requested part, so that sanity check could be added to
the extra space later.

Performance wise, smaller zeroing length also brings shorter
execution time, as shown from test data on various server/desktop
platforms.

For kzalloc users who will call ksize() later and utilize this
extra space, please be aware that the space is not zeroed any
more.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/slab.c |  7 ++++---
 mm/slab.h |  5 +++--
 mm/slub.c | 10 +++++++---
 3 files changed, 14 insertions(+), 8 deletions(-)

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
index d0ef9dd44b71..3cf5adf63f48 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -730,7 +730,8 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
 
 static inline void slab_post_alloc_hook(struct kmem_cache *s,
 					struct obj_cgroup *objcg, gfp_t flags,
-					size_t size, void **p, bool init)
+					size_t size, void **p, bool init,
+					unsigned int orig_size)
 {
 	size_t i;
 
@@ -746,7 +747,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 	for (i = 0; i < size; i++) {
 		p[i] = kasan_slab_alloc(s, p[i], flags, init);
 		if (p[i] && init && !kasan_has_integrated_init())
-			memset(p[i], 0, s->object_size);
+			memset(p[i], 0, orig_size);
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, flags);
 	}
diff --git a/mm/slub.c b/mm/slub.c
index c8ba16b3a4db..6f823e99d8b4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3376,7 +3376,11 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s, struct list_l
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
@@ -3833,11 +3837,11 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
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

