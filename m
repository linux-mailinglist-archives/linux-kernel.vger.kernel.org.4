Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAACB748458
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjGEMoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGEMoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:44:12 -0400
Received: from out-1.mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3E810D5
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:44:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688561049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OvYom9X/S7wayVeQUgTcDXl5jN2F2BPuKd+7kG4C4mU=;
        b=L8cZm9LxdvRBYMRNAvSEu9H0IxP7taSx5EvR7BcZ8G88ca7lnB4ReJaYDVG16WBkTlpRN7
        24GG0wNfx+8UM1CyKbWj+H72mwRnnArUTCvZRaQVPbU+ySUdM/44CzzLQw+XaOIEncUFVt
        8VsKnaiXIIbjxVhTkWZ85lf6z419tXo=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Feng Tang <feng.tang@intel.com>, stable@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH] kasan, slub: fix HW_TAGS zeroing with slub_debug
Date:   Wed,  5 Jul 2023 14:44:02 +0200
Message-Id: <678ac92ab790dba9198f9ca14f405651b97c8502.1688561016.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Commit 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated
kmalloc space than requested") added precise kmalloc redzone poisoning
to the slub_debug functionality.

However, this commit didn't account for HW_TAGS KASAN fully initializing
the object via its built-in memory initialization feature. Even though
HW_TAGS KASAN memory initialization contains special memory initialization
handling for when slub_debug is enabled, it does not account for in-object
slub_debug redzones. As a result, HW_TAGS KASAN can overwrite these
redzones and cause false-positive slub_debug reports.

To fix the issue, avoid HW_TAGS KASAN memory initialization when slub_debug
is enabled altogether. Implement this by moving the __slub_debug_enabled
check to slab_post_alloc_hook. Common slab code seems like a more
appropriate place for a slub_debug check anyway.

Fixes: 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated kmalloc space than requested")
Cc: <stable@vger.kernel.org>
Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h | 12 ------------
 mm/slab.h        | 16 ++++++++++++++--
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index b799f11e45dc..2e973b36fe07 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -466,18 +466,6 @@ static inline void kasan_unpoison(const void *addr, size_t size, bool init)
 
 	if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
 		return;
-	/*
-	 * Explicitly initialize the memory with the precise object size to
-	 * avoid overwriting the slab redzone. This disables initialization in
-	 * the arch code and may thus lead to performance penalty. This penalty
-	 * does not affect production builds, as slab redzones are not enabled
-	 * there.
-	 */
-	if (__slub_debug_enabled() &&
-	    init && ((unsigned long)size & KASAN_GRANULE_MASK)) {
-		init = false;
-		memzero_explicit((void *)addr, size);
-	}
 	size = round_up(size, KASAN_GRANULE_SIZE);
 
 	hw_set_mem_tag_range((void *)addr, size, tag, init);
diff --git a/mm/slab.h b/mm/slab.h
index 6a5633b25eb5..9c0e09d0f81f 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -723,6 +723,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 					unsigned int orig_size)
 {
 	unsigned int zero_size = s->object_size;
+	bool kasan_init = init;
 	size_t i;
 
 	flags &= gfp_allowed_mask;
@@ -739,6 +740,17 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 	    (s->flags & SLAB_KMALLOC))
 		zero_size = orig_size;
 
+	/*
+	 * When slub_debug is enabled, avoid memory initialization integrated
+	 * into KASAN and instead zero out the memory via the memset below with
+	 * the proper size. Otherwise, KASAN might overwrite SLUB redzones and
+	 * cause false-positive reports. This does not lead to a performance
+	 * penalty on production builds, as slub_debug is not intended to be
+	 * enabled there.
+	 */
+	if (__slub_debug_enabled())
+		kasan_init = false;
+
 	/*
 	 * As memory initialization might be integrated into KASAN,
 	 * kasan_slab_alloc and initialization memset must be
@@ -747,8 +759,8 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
 	 * As p[i] might get tagged, memset and kmemleak hook come after KASAN.
 	 */
 	for (i = 0; i < size; i++) {
-		p[i] = kasan_slab_alloc(s, p[i], flags, init);
-		if (p[i] && init && !kasan_has_integrated_init())
+		p[i] = kasan_slab_alloc(s, p[i], flags, kasan_init);
+		if (p[i] && init && (!kasan_init || !kasan_has_integrated_init()))
 			memset(p[i], 0, zero_size);
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, flags);
-- 
2.25.1

