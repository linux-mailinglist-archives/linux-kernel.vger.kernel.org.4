Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB9E5E75C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiIWI2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiIWI1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:27:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2814E1296B1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 01:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663921650; x=1695457650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=To+r8DoSBWXEFxEDBPH41aSt7znF2w4YCd3jX7QhPMg=;
  b=IHElGTzVZJr3wvsOBcVoeDU93uwpS1XuJvdTbKSBgJJpEoCOrgbFivQ6
   ueqwKMIO811Bonob4ZE0CnW+Emq8mLxpwpTusRBF9oAd2YsBd8C8fmKv7
   ExWD/DCEcWNXz1pGlKjnTLLoDTsBsg7V+6iFFnI2+icH5+KvySFtF/KNa
   b/rmj6DibIdpUUqeAS5Up+7Y9G6tdPIfT/TfELmmWUK1nhU+XMPPiis9u
   hk48boyNUrOWSDSq1149P0RoUpCNdEmTy+ZOGj0L6mb9rTWFpEZgr0yZw
   NWKwRJNkVmctL5ZKlTszEUR7KwGP8F8FsrfvpIUQKVj3EfGwAEMPbwZCl
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="326874002"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="326874002"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 01:27:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="622444230"
Received: from ngoncia-mobl2.ger.corp.intel.com (HELO paris.ger.corp.intel.com) ([10.249.143.58])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 01:27:12 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@redhat.com,
        daniel@ffwll.ch, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, keescook@chromium.org,
        mauro.chehab@linux.intel.com, linux@rasmusvillemoes.dk,
        vitor@massaru.org, dlatypov@google.com, ndesaulniers@google.com
Subject: [PATCH v11 5/9] drm/i915: Check for integer truncation on scatterlist creation
Date:   Fri, 23 Sep 2022 11:26:24 +0300
Message-Id: <20220923082628.3061408-6-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220923082628.3061408-1-gwan-gyeong.mun@intel.com>
References: <20220923082628.3061408-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Wilson <chris@chris-wilson.co.uk>

There is an impedance mismatch between the scatterlist API using unsigned
int and our memory/page accounting in unsigned long. That is we may try
to create a scatterlist for a large object that overflows returning a
small table into which we try to fit very many pages. As the object size
is under control of userspace, we have to be prudent and catch the
conversion errors.

To catch the implicit truncation as we switch from unsigned long into the
scatterlist's unsigned int, we use overflows_type check and report
E2BIG prior to the operation. This is already used in our create ioctls to
indicate if the uABI request is simply too large for the backing store.
Failing that type check, we have a second check at sg_alloc_table time
to make sure the values we are passing into the scatterlist API are not
truncated.

It uses pgoff_t for locals that are dealing with page indices, in this
case, the page count is the limit of the page index.
And it uses safe_conversion() macro which performs a type conversion (cast)
of an integer value into a new variable, checking that the destination is
large enough to hold the source value.

v2: Move added i915_utils's macro into drm_util header (Jani N)
v5: Fix macros to be enclosed in parentheses for complex values
    Fix too long line warning
v8: Replace safe_conversion() with check_assign() (Kees)

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Brian Welty <brian.welty@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_internal.c |  6 ++++--
 drivers/gpu/drm/i915/gem/i915_gem_object.h   |  3 ---
 drivers/gpu/drm/i915/gem/i915_gem_phys.c     |  4 ++++
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c    |  5 ++++-
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c      |  4 ++++
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c  |  5 ++++-
 drivers/gpu/drm/i915/gvt/dmabuf.c            |  9 +++++----
 drivers/gpu/drm/i915/i915_scatterlist.h      | 11 +++++++++++
 8 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_internal.c b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
index c698f95af15f..53fa27e1c950 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_internal.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
@@ -37,10 +37,13 @@ static int i915_gem_object_get_pages_internal(struct drm_i915_gem_object *obj)
 	struct sg_table *st;
 	struct scatterlist *sg;
 	unsigned int sg_page_sizes;
-	unsigned int npages;
+	pgoff_t npages; /* restricted by sg_alloc_table */
 	int max_order;
 	gfp_t gfp;
 
+	if (check_assign(obj->base.size >> PAGE_SHIFT, &npages))
+		return -E2BIG;
+
 	max_order = MAX_ORDER;
 #ifdef CONFIG_SWIOTLB
 	if (is_swiotlb_active(obj->base.dev->dev)) {
@@ -67,7 +70,6 @@ static int i915_gem_object_get_pages_internal(struct drm_i915_gem_object *obj)
 	if (!st)
 		return -ENOMEM;
 
-	npages = obj->base.size / PAGE_SIZE;
 	if (sg_alloc_table(st, npages, GFP_KERNEL)) {
 		kfree(st);
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.h b/drivers/gpu/drm/i915/gem/i915_gem_object.h
index f2c4de31d563..b1f89b1cc0b2 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.h
@@ -26,9 +26,6 @@ enum intel_region_id;
  * this and catch if we ever need to fix it. In the meantime, if you do
  * spot such a local variable, please consider fixing!
  *
- * Aside from our own locals (for which we have no excuse!):
- * - sg_table embeds unsigned int for nents
- *
  * We can check for invalidly typed locals with typecheck(), see for example
  * i915_gem_object_get_sg().
  */
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_phys.c b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
index 0d0e46dae559..88ba7266a3a5 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_phys.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_phys.c
@@ -28,6 +28,10 @@ static int i915_gem_object_get_pages_phys(struct drm_i915_gem_object *obj)
 	void *dst;
 	int i;
 
+	/* Contiguous chunk, with a single scatterlist element */
+	if (overflows_type(obj->base.size, sg->length))
+		return -E2BIG;
+
 	if (GEM_WARN_ON(i915_gem_object_needs_bit17_swizzle(obj)))
 		return -EINVAL;
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index f42ca1179f37..339b0a9cf2d0 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -193,13 +193,16 @@ static int shmem_get_pages(struct drm_i915_gem_object *obj)
 	struct drm_i915_private *i915 = to_i915(obj->base.dev);
 	struct intel_memory_region *mem = obj->mm.region;
 	struct address_space *mapping = obj->base.filp->f_mapping;
-	const unsigned long page_count = obj->base.size / PAGE_SIZE;
 	unsigned int max_segment = i915_sg_segment_size();
 	struct sg_table *st;
 	struct sgt_iter sgt_iter;
+	pgoff_t page_count;
 	struct page *page;
 	int ret;
 
+	if (check_assign(obj->base.size >> PAGE_SHIFT, &page_count))
+		return -E2BIG;
+
 	/*
 	 * Assert that the object is not currently in any GPU domain. As it
 	 * wasn't in the GTT, there shouldn't be any way it could have been in
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index 004fc7478b41..bf99d1f02bd9 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -792,6 +792,10 @@ static int i915_ttm_get_pages(struct drm_i915_gem_object *obj)
 {
 	struct ttm_place requested, busy[I915_TTM_MAX_PLACEMENTS];
 	struct ttm_placement placement;
+	pgoff_t num_pages;
+
+	if (check_assign(obj->base.size >> PAGE_SHIFT, &num_pages))
+		return -E2BIG;
 
 	GEM_BUG_ON(obj->mm.n_placements > I915_TTM_MAX_PLACEMENTS);
 
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index 8423df021b71..48237e443863 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -128,13 +128,16 @@ static void i915_gem_object_userptr_drop_ref(struct drm_i915_gem_object *obj)
 
 static int i915_gem_userptr_get_pages(struct drm_i915_gem_object *obj)
 {
-	const unsigned long num_pages = obj->base.size >> PAGE_SHIFT;
 	unsigned int max_segment = i915_sg_segment_size();
 	struct sg_table *st;
 	unsigned int sg_page_sizes;
 	struct page **pvec;
+	pgoff_t num_pages; /* limited by sg_alloc_table_from_pages_segment */
 	int ret;
 
+	if (check_assign(obj->base.size >> PAGE_SHIFT, &num_pages))
+		return -E2BIG;
+
 	st = kmalloc(sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
index 01e54b45c5c1..bc6e823584ad 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.c
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
@@ -42,8 +42,7 @@
 
 #define GEN8_DECODE_PTE(pte) (pte & GENMASK_ULL(63, 12))
 
-static int vgpu_gem_get_pages(
-		struct drm_i915_gem_object *obj)
+static int vgpu_gem_get_pages(struct drm_i915_gem_object *obj)
 {
 	struct drm_i915_private *dev_priv = to_i915(obj->base.dev);
 	struct intel_vgpu *vgpu;
@@ -52,7 +51,10 @@ static int vgpu_gem_get_pages(
 	int i, j, ret;
 	gen8_pte_t __iomem *gtt_entries;
 	struct intel_vgpu_fb_info *fb_info;
-	u32 page_num;
+	pgoff_t page_num;
+
+	if (check_assign(obj->base.size >> PAGE_SHIFT, &page_num))
+		return -E2BIG;
 
 	fb_info = (struct intel_vgpu_fb_info *)obj->gvt_info;
 	if (drm_WARN_ON(&dev_priv->drm, !fb_info))
@@ -66,7 +68,6 @@ static int vgpu_gem_get_pages(
 	if (unlikely(!st))
 		return -ENOMEM;
 
-	page_num = obj->base.size >> PAGE_SHIFT;
 	ret = sg_alloc_table(st, page_num, GFP_KERNEL);
 	if (ret) {
 		kfree(st);
diff --git a/drivers/gpu/drm/i915/i915_scatterlist.h b/drivers/gpu/drm/i915/i915_scatterlist.h
index 9ddb3e743a3e..1d1802beb42b 100644
--- a/drivers/gpu/drm/i915/i915_scatterlist.h
+++ b/drivers/gpu/drm/i915/i915_scatterlist.h
@@ -220,4 +220,15 @@ struct i915_refct_sgt *i915_rsgt_from_buddy_resource(struct ttm_resource *res,
 						     u64 region_start,
 						     u32 page_alignment);
 
+/* Wrap scatterlist.h to sanity check for integer truncation */
+typedef unsigned int __sg_size_t; /* see linux/scatterlist.h */
+#define sg_alloc_table(sgt, nents, gfp) \
+	overflows_type(nents, __sg_size_t) ? -E2BIG \
+		: ((sg_alloc_table)(sgt, (__sg_size_t)(nents), gfp))
+
+#define sg_alloc_table_from_pages_segment(sgt, pages, npages, offset, size, max_segment, gfp) \
+	overflows_type(npages, __sg_size_t) ? -E2BIG \
+		: ((sg_alloc_table_from_pages_segment)(sgt, pages, (__sg_size_t)(npages), offset, \
+						       size, max_segment, gfp))
+
 #endif
-- 
2.37.1

