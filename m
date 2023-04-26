Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE236EFC7D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239951AbjDZV3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbjDZV3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:29:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E663AA9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682544571; x=1714080571;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to;
  bh=n2S6Oqqx2tDXFa9lA26s/eufyyhgFSeaQ5i/57xJ+Mo=;
  b=ZApgK3bBeMrnNVsuewP3wyYslWxT6qLT5IxDvnhZJ026xPOUbCNmV3ir
   Pf08f/6iBWgap5fgE6KLJCSj/Py4cTftmD8HdibaYSBxFUsBEnp4/khV/
   HyaDZx7wKmeAW2mMfpxFYbjJB6Kg4el/88/XmJFfZMppOmoCNhJiQgSYz
   9Nnoam4juinDBoi2H32Rx+mjzK5phWLrjP5g7E2aWfD0jQd3y3QJk8Rd8
   CpgHHwxp4OI0r31np0fTAE7qNQcv3XzfJRajmoUhSkj0RpFu+fDPKuASt
   lil+71fhKp+F2lI1pHU/JAtDo6UMmYgb5LA10mg+foajFtmHtbLEPctx3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="344691038"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="344691038"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 14:29:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="805679873"
X-IronPort-AV: E=Sophos;i="5.99,229,1677571200"; 
   d="scan'208";a="805679873"
Received: from lab-ah.igk.intel.com ([10.102.138.202])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 14:29:29 -0700
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Date:   Wed, 26 Apr 2023 23:28:48 +0200
Subject: [PATCH v8 1/2] drm/i915: Migrate platform-dependent mock hugepage
 selftests to live
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230425-hugepage-migrate-v8-1-7868d54eaa27@intel.com>
References: <20230425-hugepage-migrate-v8-0-7868d54eaa27@intel.com>
In-Reply-To: <20230425-hugepage-migrate-v8-0-7868d54eaa27@intel.com>
To:     intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Matthew Auld <matthew.auld@intel.com>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cavitt <jonathan.cavitt@intel.com>

Convert the igt_mock_ppgtt_huge_fill and igt_mock_ppgtt_64K mock selftests
into live selftests as their requirements have recently become
platform-dependent. Additionally, apply necessary platform dependency
checks to these tests.

v8:
- handle properly 64K and 2M pages
v9:
- do not expect 64K pages if 2M are present
- fix hex printing
- obey commit message line limit

Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Co-developed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c | 106 ++++++++++++++++++------
 1 file changed, 81 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
index defece0bcb811f..cb5863f37f9d37 100644
--- a/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/gem/selftests/huge_pages.c
@@ -695,8 +695,7 @@ static int igt_mock_ppgtt_misaligned_dma(void *arg)
 	return err;
 }
 
-static void close_object_list(struct list_head *objects,
-			      struct i915_ppgtt *ppgtt)
+static void close_object_list(struct list_head *objects)
 {
 	struct drm_i915_gem_object *obj, *on;
 
@@ -710,17 +709,36 @@ static void close_object_list(struct list_head *objects,
 	}
 }
 
-static int igt_mock_ppgtt_huge_fill(void *arg)
+static int igt_ppgtt_huge_fill(void *arg)
 {
-	struct i915_ppgtt *ppgtt = arg;
-	struct drm_i915_private *i915 = ppgtt->vm.i915;
-	unsigned long max_pages = ppgtt->vm.total >> PAGE_SHIFT;
+	struct drm_i915_private *i915 = arg;
+	unsigned int supported = RUNTIME_INFO(i915)->page_sizes;
+	bool has_pte64 = GRAPHICS_VER_FULL(i915) >= IP_VER(12, 50);
+	struct i915_address_space *vm;
+	struct i915_gem_context *ctx;
+	unsigned long max_pages;
 	unsigned long page_num;
+	struct file *file;
 	bool single = false;
 	LIST_HEAD(objects);
 	IGT_TIMEOUT(end_time);
 	int err = -ENODEV;
 
+	if (supported == I915_GTT_PAGE_SIZE_4K)
+		return 0;
+
+	file = mock_file(i915);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	ctx = hugepage_ctx(i915, file);
+	if (IS_ERR(ctx)) {
+		err = PTR_ERR(ctx);
+		goto out;
+	}
+	vm = i915_gem_context_get_eb_vm(ctx);
+	max_pages = vm->total >> PAGE_SHIFT;
+
 	for_each_prime_number_from(page_num, 1, max_pages) {
 		struct drm_i915_gem_object *obj;
 		u64 size = page_num << PAGE_SHIFT;
@@ -750,13 +768,14 @@ static int igt_mock_ppgtt_huge_fill(void *arg)
 
 		list_add(&obj->st_link, &objects);
 
-		vma = i915_vma_instance(obj, &ppgtt->vm, NULL);
+		vma = i915_vma_instance(obj, vm, NULL);
 		if (IS_ERR(vma)) {
 			err = PTR_ERR(vma);
 			break;
 		}
 
-		err = i915_vma_pin(vma, 0, 0, PIN_USER);
+		/* vma start must be aligned to BIT(21) to allow 2M PTEs */
+		err = i915_vma_pin(vma, 0, BIT(21), PIN_USER);
 		if (err)
 			break;
 
@@ -784,12 +803,13 @@ static int igt_mock_ppgtt_huge_fill(void *arg)
 		GEM_BUG_ON(!expected_gtt);
 		GEM_BUG_ON(size);
 
-		if (expected_gtt & I915_GTT_PAGE_SIZE_4K)
+		if (!has_pte64 && (obj->base.size < I915_GTT_PAGE_SIZE_2M ||
+				   expected_gtt & I915_GTT_PAGE_SIZE_2M))
 			expected_gtt &= ~I915_GTT_PAGE_SIZE_64K;
 
 		i915_vma_unpin(vma);
 
-		if (vma->page_sizes.sg & I915_GTT_PAGE_SIZE_64K) {
+		if (!has_pte64 && vma->page_sizes.sg & I915_GTT_PAGE_SIZE_64K) {
 			if (!IS_ALIGNED(vma->node.start,
 					I915_GTT_PAGE_SIZE_2M)) {
 				pr_err("node.start(%llx) not aligned to 2M\n",
@@ -808,7 +828,7 @@ static int igt_mock_ppgtt_huge_fill(void *arg)
 		}
 
 		if (vma->resource->page_sizes_gtt != expected_gtt) {
-			pr_err("gtt=%u, expected=%u, size=%zd, single=%s\n",
+			pr_err("gtt=%#x, expected=%#x, size=0x%zx, single=%s\n",
 			       vma->resource->page_sizes_gtt, expected_gtt,
 			       obj->base.size, str_yes_no(!!single));
 			err = -EINVAL;
@@ -823,19 +843,25 @@ static int igt_mock_ppgtt_huge_fill(void *arg)
 		single = !single;
 	}
 
-	close_object_list(&objects, ppgtt);
+	close_object_list(&objects);
 
 	if (err == -ENOMEM || err == -ENOSPC)
 		err = 0;
 
+	i915_vm_put(vm);
+out:
+	fput(file);
 	return err;
 }
 
-static int igt_mock_ppgtt_64K(void *arg)
+static int igt_ppgtt_64K(void *arg)
 {
-	struct i915_ppgtt *ppgtt = arg;
-	struct drm_i915_private *i915 = ppgtt->vm.i915;
+	struct drm_i915_private *i915 = arg;
+	bool has_pte64 = GRAPHICS_VER_FULL(i915) >= IP_VER(12, 50);
 	struct drm_i915_gem_object *obj;
+	struct i915_address_space *vm;
+	struct i915_gem_context *ctx;
+	struct file *file;
 	const struct object_info {
 		unsigned int size;
 		unsigned int gtt;
@@ -907,16 +933,41 @@ static int igt_mock_ppgtt_64K(void *arg)
 	if (!HAS_PAGE_SIZES(i915, I915_GTT_PAGE_SIZE_64K))
 		return 0;
 
+	file = mock_file(i915);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	ctx = hugepage_ctx(i915, file);
+	if (IS_ERR(ctx)) {
+		err = PTR_ERR(ctx);
+		goto out;
+	}
+	vm = i915_gem_context_get_eb_vm(ctx);
+
 	for (i = 0; i < ARRAY_SIZE(objects); ++i) {
 		unsigned int size = objects[i].size;
 		unsigned int expected_gtt = objects[i].gtt;
 		unsigned int offset = objects[i].offset;
 		unsigned int flags = PIN_USER;
 
+		/*
+		 * For modern GTT models, the requirements for marking a page-table
+		 * as 64K have been relaxed.  Account for this.
+		 */
+		if (has_pte64) {
+			expected_gtt = 0;
+			if (size >= SZ_64K)
+				expected_gtt |= I915_GTT_PAGE_SIZE_64K;
+			if (size & (SZ_64K - 1))
+				expected_gtt |= I915_GTT_PAGE_SIZE_4K;
+		}
+
 		for (single = 0; single <= 1; single++) {
 			obj = fake_huge_pages_object(i915, size, !!single);
-			if (IS_ERR(obj))
-				return PTR_ERR(obj);
+			if (IS_ERR(obj)) {
+				err = PTR_ERR(obj);
+				goto out_vm;
+			}
 
 			err = i915_gem_object_pin_pages_unlocked(obj);
 			if (err)
@@ -928,7 +979,7 @@ static int igt_mock_ppgtt_64K(void *arg)
 			 */
 			obj->mm.page_sizes.sg &= ~I915_GTT_PAGE_SIZE_2M;
 
-			vma = i915_vma_instance(obj, &ppgtt->vm, NULL);
+			vma = i915_vma_instance(obj, vm, NULL);
 			if (IS_ERR(vma)) {
 				err = PTR_ERR(vma);
 				goto out_object_unpin;
@@ -945,7 +996,8 @@ static int igt_mock_ppgtt_64K(void *arg)
 			if (err)
 				goto out_vma_unpin;
 
-			if (!offset && vma->page_sizes.sg & I915_GTT_PAGE_SIZE_64K) {
+			if (!has_pte64 && !offset &&
+			    vma->page_sizes.sg & I915_GTT_PAGE_SIZE_64K) {
 				if (!IS_ALIGNED(vma->node.start,
 						I915_GTT_PAGE_SIZE_2M)) {
 					pr_err("node.start(%llx) not aligned to 2M\n",
@@ -964,9 +1016,10 @@ static int igt_mock_ppgtt_64K(void *arg)
 			}
 
 			if (vma->resource->page_sizes_gtt != expected_gtt) {
-				pr_err("gtt=%u, expected=%u, i=%d, single=%s\n",
+				pr_err("gtt=%#x, expected=%#x, i=%d, single=%s offset=%#x size=%#x\n",
 				       vma->resource->page_sizes_gtt,
-				       expected_gtt, i, str_yes_no(!!single));
+				       expected_gtt, i, str_yes_no(!!single),
+				       offset, size);
 				err = -EINVAL;
 				goto out_vma_unpin;
 			}
@@ -982,7 +1035,7 @@ static int igt_mock_ppgtt_64K(void *arg)
 		}
 	}
 
-	return 0;
+	goto out_vm;
 
 out_vma_unpin:
 	i915_vma_unpin(vma);
@@ -992,7 +1045,10 @@ static int igt_mock_ppgtt_64K(void *arg)
 	i915_gem_object_unlock(obj);
 out_object_put:
 	i915_gem_object_put(obj);
-
+out_vm:
+	i915_vm_put(vm);
+out:
+	fput(file);
 	return err;
 }
 
@@ -1910,8 +1966,6 @@ int i915_gem_huge_page_mock_selftests(void)
 		SUBTEST(igt_mock_exhaust_device_supported_pages),
 		SUBTEST(igt_mock_memory_region_huge_pages),
 		SUBTEST(igt_mock_ppgtt_misaligned_dma),
-		SUBTEST(igt_mock_ppgtt_huge_fill),
-		SUBTEST(igt_mock_ppgtt_64K),
 	};
 	struct drm_i915_private *dev_priv;
 	struct i915_ppgtt *ppgtt;
@@ -1962,6 +2016,8 @@ int i915_gem_huge_page_live_selftests(struct drm_i915_private *i915)
 		SUBTEST(igt_ppgtt_sanity_check),
 		SUBTEST(igt_ppgtt_compact),
 		SUBTEST(igt_ppgtt_mixed),
+		SUBTEST(igt_ppgtt_huge_fill),
+		SUBTEST(igt_ppgtt_64K),
 	};
 
 	if (!HAS_PPGTT(i915)) {

-- 
2.34.1
