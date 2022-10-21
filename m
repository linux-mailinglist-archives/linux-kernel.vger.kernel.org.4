Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F84606E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 05:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJUDYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 23:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiJUDYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:24:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D5B5F8F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 20:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666322669; x=1697858669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BgwnaduZY7Uty+d/aSigQJByRP8rJXh8ABZquZbtWNQ=;
  b=ToqI//OFeJx8MV3ZZCMBrm/efbVxESRN/VoMo4wz3DtcgwRmStnGjzEj
   5UjIbTQmIMm05k7LcMSWpNCBkBwepfopb+chJ9GEV8wtbiG4eQHtlzYRm
   1DoQNgsI0VqJVtoNQS1VnIEVk02gJE58uAd0pTMYJ216/L4snN9UPEQ8C
   GTnyX2xe0Y3FB1rpTWy2HJ3afcsW2wpxOM35Rhd2owPF77pKs3DUHiY9d
   H7dgrkNH6LxZ6izx2mzNrSqt/BSQ/AnuLJta/LtIN4sMEW7FVyoMVyDHV
   UYhqAng+jf5fw35I911fPfJAejZRkMakdmqkAXZKUJLPhiyK3Lr9/ll3+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="333471620"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="333471620"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 20:24:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="719459612"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="719459612"
Received: from feng-clx.sh.intel.com ([10.238.200.228])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2022 20:24:19 -0700
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
Subject: [PATCH v7 3/3] mm/slub: extend redzone check to extra allocated kmalloc space than requested
Date:   Fri, 21 Oct 2022 11:24:05 +0800
Message-Id: <20221021032405.1825078-4-feng.tang@intel.com>
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

kmalloc will round up the request size to a fixed size (mostly power
of 2), so there could be a extra space than what is requested, whose
size is the actual buffer size minus original request size.

To better detect out of bound access or abuse of this space, add
redzone sanity check for it.

In current kernel, some kmalloc user already knows the existence of
the space and utilizes it after calling 'ksize()' to know the real
size of the allocated buffer. So we skip the sanity check for objects
which have been called with ksize(), as treating them as legitimate
users.

In some cases, the free pointer could be saved inside the latter
part of object data area, which may overlap the redzone part(for
small sizes of kmalloc objects). As suggested by Hyeonggon Yoo,
force the free pointer to be in meta data area when kmalloc redzone
debug is enabled, to make all kmalloc objects covered by redzone
check.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab.h        |  4 ++++
 mm/slab_common.c |  4 ++++
 mm/slub.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 8b4ee02fc14a..1dd773afd0c4 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -885,4 +885,8 @@ void __check_heap_object(const void *ptr, unsigned long n,
 }
 #endif
 
+#ifdef CONFIG_SLUB_DEBUG
+void skip_orig_size_check(struct kmem_cache *s, const void *object);
+#endif
+
 #endif /* MM_SLAB_H */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 33b1886b06eb..0bb4625f10a2 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1037,6 +1037,10 @@ size_t __ksize(const void *object)
 		return folio_size(folio);
 	}
 
+#ifdef CONFIG_SLUB_DEBUG
+	skip_orig_size_check(folio_slab(folio)->slab_cache, object);
+#endif
+
 	return slab_ksize(folio_slab(folio)->slab_cache);
 }
 
diff --git a/mm/slub.c b/mm/slub.c
index adff7553b54e..76581da6b9df 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -829,6 +829,17 @@ static inline void set_orig_size(struct kmem_cache *s,
 	if (!slub_debug_orig_size(s))
 		return;
 
+#ifdef CONFIG_KASAN_GENERIC
+	/*
+	 * KASAN could save its free meta data in object's data area at
+	 * offset 0, if the size is larger than 'orig_size', it will
+	 * overlap the data redzone in [orig_size+1, object_size], and
+	 * the check should be skipped.
+	 */
+	if (kasan_metadata_size(s, true) > orig_size)
+		orig_size = s->object_size;
+#endif
+
 	p += get_info_end(s);
 	p += sizeof(struct track) * 2;
 
@@ -848,6 +859,11 @@ static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
 	return *(unsigned int *)p;
 }
 
+void skip_orig_size_check(struct kmem_cache *s, const void *object)
+{
+	set_orig_size(s, (void *)object, s->object_size);
+}
+
 static void slab_bug(struct kmem_cache *s, char *fmt, ...)
 {
 	struct va_format vaf;
@@ -966,13 +982,27 @@ static __printf(3, 4) void slab_err(struct kmem_cache *s, struct slab *slab,
 static void init_object(struct kmem_cache *s, void *object, u8 val)
 {
 	u8 *p = kasan_reset_tag(object);
+	unsigned int orig_size = s->object_size;
 
-	if (s->flags & SLAB_RED_ZONE)
+	if (s->flags & SLAB_RED_ZONE) {
 		memset(p - s->red_left_pad, val, s->red_left_pad);
 
+		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
+			orig_size = get_orig_size(s, object);
+
+			/*
+			 * Redzone the extra allocated space by kmalloc
+			 * than requested.
+			 */
+			if (orig_size < s->object_size)
+				memset(p + orig_size, val,
+				       s->object_size - orig_size);
+		}
+	}
+
 	if (s->flags & __OBJECT_POISON) {
-		memset(p, POISON_FREE, s->object_size - 1);
-		p[s->object_size - 1] = POISON_END;
+		memset(p, POISON_FREE, orig_size - 1);
+		p[orig_size - 1] = POISON_END;
 	}
 
 	if (s->flags & SLAB_RED_ZONE)
@@ -1120,6 +1150,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 {
 	u8 *p = object;
 	u8 *endobject = object + s->object_size;
+	unsigned int orig_size;
 
 	if (s->flags & SLAB_RED_ZONE) {
 		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
@@ -1129,6 +1160,17 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 		if (!check_bytes_and_report(s, slab, object, "Right Redzone",
 			endobject, val, s->inuse - s->object_size))
 			return 0;
+
+		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
+			orig_size = get_orig_size(s, object);
+
+			if (s->object_size > orig_size  &&
+				!check_bytes_and_report(s, slab, object,
+					"kmalloc Redzone", p + orig_size,
+					val, s->object_size - orig_size)) {
+				return 0;
+			}
+		}
 	} else {
 		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
 			check_bytes_and_report(s, slab, p, "Alignment padding",
@@ -4206,7 +4248,8 @@ static int calculate_sizes(struct kmem_cache *s)
 	 */
 	s->inuse = size;
 
-	if ((flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) ||
+	if (slub_debug_orig_size(s) ||
+	    (flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) ||
 	    ((flags & SLAB_RED_ZONE) && s->object_size < sizeof(void *)) ||
 	    s->ctor) {
 		/*
-- 
2.34.1

