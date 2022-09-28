Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697265ED76F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233428AbiI1IPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbiI1IOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:14:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016B6BEE;
        Wed, 28 Sep 2022 01:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664352873; x=1695888873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EcU7AaNW1bRj3YDi/xCjAHSsB7dr/NE8Y5qtQn5y8Vc=;
  b=PfB8reHr+RbI5RRk0ITSOaNcgiaFF+r/iqUySOzZxry0qMSKidAyvfEk
   lSFgoBP8Q+7F4tUs7oVgrTLTCu9BhI7vYCKbZ+Sp4P5NYASjXjGBM6Kd5
   G+9rF0s20uc9nk9myg0BTGl5KJ4D/RevshVuR00YK6YmGwKPjLfVC8v+p
   EALP5gLOvwJuf7MQpFN3tUDJ/Mqj3B/j5dzofG90N35vye/OfbPGK99vu
   NjmLCn3u+Mo/EV9/DhSqNp6U6zGHzPCocq4LP3EwPnlji8Qcl5ZBtHOTI
   OVfNGahkHtJV9s2Z7LcsnYPqhpk6WN7lNl1aLhZVtR3z0L0uZrXWksIM0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="300258445"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="300258445"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 01:14:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="621836368"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="621836368"
Received: from maciejos-mobl.ger.corp.intel.com (HELO paris.ger.corp.intel.com) ([10.249.147.47])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 01:14:10 -0700
From:   Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mchehab@kernel.org, chris@chris-wilson.co.uk,
        matthew.auld@intel.com, thomas.hellstrom@linux.intel.com,
        jani.nikula@intel.com, nirmoy.das@intel.com, airlied@redhat.com,
        daniel@ffwll.ch, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, keescook@chromium.org,
        mauro.chehab@linux.intel.com, linux@rasmusvillemoes.dk,
        vitor@massaru.org, dlatypov@google.com, ndesaulniers@google.com,
        trix@redhat.com, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org, linux-sparse@vger.kernel.org,
        nathan@kernel.org, gustavoars@kernel.org,
        luc.vanoostenryck@gmail.com
Subject: [PATCH v13 6/9] drm/i915: Check for integer truncation on the configuration of ttm place
Date:   Wed, 28 Sep 2022 11:12:57 +0300
Message-Id: <20220928081300.101516-7-gwan-gyeong.mun@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220928081300.101516-1-gwan-gyeong.mun@intel.com>
References: <20220928081300.101516-1-gwan-gyeong.mun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an impedance mismatch between the first/last valid page
frame number of ttm place in unsigned and our memory/page accounting in
unsigned long.
As the object size is under the control of userspace, we have to be prudent
and catch the conversion errors.
To catch the implicit truncation as we switch from unsigned long to
unsigned, we use overflows_type check and report E2BIG or overflow_type
prior to the operation.

v3: Not to change execution inside a macro. (Mauro)
    Add safe_conversion_gem_bug_on() macro and remove temporal
    SAFE_CONVERSION() macro.
v4: Fix unhandled GEM_BUG_ON() macro call from safe_conversion_gem_bug_on()
v6: Fix to follow general use case for GEM_BUG_ON(). (Jani)
v7: Fix to use WARN_ON() macro where GEM_BUG_ON() macro was used. (Jani)
v8: Replace safe_conversion() with check_assign() (Kees)

Signed-off-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com> (v2)
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org> (v3)
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com> (v5)
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c |  6 +++---
 drivers/gpu/drm/i915/intel_region_ttm.c | 17 ++++++++++++++---
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index 8d7c392d335c..d33f06b95c48 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -140,14 +140,14 @@ i915_ttm_place_from_region(const struct intel_memory_region *mr,
 	if (flags & I915_BO_ALLOC_CONTIGUOUS)
 		place->flags |= TTM_PL_FLAG_CONTIGUOUS;
 	if (offset != I915_BO_INVALID_OFFSET) {
-		place->fpfn = offset >> PAGE_SHIFT;
-		place->lpfn = place->fpfn + (size >> PAGE_SHIFT);
+		WARN_ON(check_assign(offset >> PAGE_SHIFT, &place->fpfn));
+		WARN_ON(check_assign(place->fpfn + (size >> PAGE_SHIFT), &place->lpfn));
 	} else if (mr->io_size && mr->io_size < mr->total) {
 		if (flags & I915_BO_ALLOC_GPU_ONLY) {
 			place->flags |= TTM_PL_FLAG_TOPDOWN;
 		} else {
 			place->fpfn = 0;
-			place->lpfn = mr->io_size >> PAGE_SHIFT;
+			WARN_ON(check_assign(mr->io_size >> PAGE_SHIFT, &place->lpfn));
 		}
 	}
 }
diff --git a/drivers/gpu/drm/i915/intel_region_ttm.c b/drivers/gpu/drm/i915/intel_region_ttm.c
index 575d67bc6ffe..37a964b20b36 100644
--- a/drivers/gpu/drm/i915/intel_region_ttm.c
+++ b/drivers/gpu/drm/i915/intel_region_ttm.c
@@ -209,14 +209,23 @@ intel_region_ttm_resource_alloc(struct intel_memory_region *mem,
 	if (flags & I915_BO_ALLOC_CONTIGUOUS)
 		place.flags |= TTM_PL_FLAG_CONTIGUOUS;
 	if (offset != I915_BO_INVALID_OFFSET) {
-		place.fpfn = offset >> PAGE_SHIFT;
-		place.lpfn = place.fpfn + (size >> PAGE_SHIFT);
+		if (WARN_ON(check_assign(offset >> PAGE_SHIFT, &place.fpfn))) {
+			ret = -E2BIG;
+			goto out;
+		}
+		if (WARN_ON(check_assign(place.fpfn + (size >> PAGE_SHIFT), &place.lpfn))) {
+			ret = -E2BIG;
+			goto out;
+		}
 	} else if (mem->io_size && mem->io_size < mem->total) {
 		if (flags & I915_BO_ALLOC_GPU_ONLY) {
 			place.flags |= TTM_PL_FLAG_TOPDOWN;
 		} else {
 			place.fpfn = 0;
-			place.lpfn = mem->io_size >> PAGE_SHIFT;
+			if (WARN_ON(check_assign(mem->io_size >> PAGE_SHIFT, &place.lpfn))) {
+				ret = -E2BIG;
+				goto out;
+			}
 		}
 	}
 
@@ -224,6 +233,8 @@ intel_region_ttm_resource_alloc(struct intel_memory_region *mem,
 	mock_bo.bdev = &mem->i915->bdev;
 
 	ret = man->func->alloc(man, &mock_bo, &place, &res);
+
+out:
 	if (ret == -ENOSPC)
 		ret = -ENXIO;
 	if (!ret)
-- 
2.37.1

