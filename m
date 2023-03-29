Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDC56CD2F2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjC2HYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjC2HYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:24:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D1040C5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680074659; x=1711610659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LRvnQ75nV6J4t1eJkOClYlFPCaO/BWveDjZ+1rUjKAM=;
  b=dizsUuUIdk4ylU60Y+d0K2/e2AY6pSPkIADjgXARvM7hieN87aWl77WN
   S1zUX/917/P4ZHOBlvT7manw40Ua7pEk3MOGsP0n1HvOZ3d63fxoK0Rqc
   P82p32nBYMSxnesPbMSX2LQO9hN8pO3p1dSqU3M9Ray0ejTee7Kwb0J6w
   C1ddR1af+Pz2SmyAsuIi/6rOYEZsEdZLyujZ5Nfk3/J6lg7CkPpheko8D
   VIYyXub1W48vwBm7Q+kJwajfcM9TL6ffcMphTZLW1StPHZCgm3kSCupSS
   cRUQNT820hmpbKOIBMjrc1yJVp8pdDyFptazoEKOYgjHHblTwMDDi8r5l
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="405745851"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="405745851"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:24:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="684160545"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="684160545"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.112])
  by orsmga002.jf.intel.com with ESMTP; 29 Mar 2023 00:24:14 -0700
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>,
        Zhenyu Wang <zhenyu.z.wang@intel.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v2 1/9] drm/i915: Use kmap_local_page() in gem/i915_gem_object.c
Date:   Wed, 29 Mar 2023 15:32:12 +0800
Message-Id: <20230329073220.3982460-2-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329073220.3982460-1-zhao1.liu@linux.intel.com>
References: <20230329073220.3982460-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Liu <zhao1.liu@intel.com>

The use of kmap_atomic() is being deprecated in favor of
kmap_local_page()[1], and this patch converts the call from
kmap_atomic() to kmap_local_page().

The main difference between atomic and local mappings is that local
mappings doesn't disable page faults or preemption (the preemption is
disabled for !PREEMPT_RT case, otherwise it only disables migration).

With kmap_local_page(), we can avoid the often unwanted side effect of
unnecessary page faults and preemption disables.

There're 2 reasons why i915_gem_object_read_from_page_kmap() doesn't
need to disable pagefaults and preemption for mapping:

1. The flush operation is safe. In drm/i915/gem/i915_gem_object.c,
i915_gem_object_read_from_page_kmap() calls drm_clflush_virt_range() to
use CLFLUSHOPT or WBINVD to flush. Since CLFLUSHOPT is global on x86
and WBINVD is called on each cpu in drm_clflush_virt_range(), the flush
operation is global.

2. Any context switch caused by preemption or page faults (page fault
may cause sleep) doesn't affect the validity of local mapping.

Therefore, i915_gem_object_read_from_page_kmap() is a function where
the use of kmap_local_page() in place of kmap_atomic() is correctly
suited.

Convert the calls of kmap_atomic() / kunmap_atomic() to
kmap_local_page() / kunmap_local().

And remove the redundant variable that stores the address of the mapped
page since kunmap_local() can accept any pointer within the page.

[1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com

v2:
* Dropped hot plug related description since it has nothing to do with
  kmap_local_page().
* Rebased on f47e630 (drm/i915/gem: Typecheck page lookups) to keep
  the "idx" variable of type pgoff_t here.
* Added description of the motivation of using kmap_local_page().

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Suggested by credits:
  Dave: Referred to his explanation about cache flush.
  Ira: Referred to his task document, review comments and explanation
       about cache flush.
  Fabio: Referred to his boiler plate commit message and his description
         about why kmap_local_page() should be preferred.
---
 drivers/gpu/drm/i915/gem/i915_gem_object.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index e6d4efde4fc5..c0bfdd7784f7 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -428,17 +428,15 @@ static void
 i915_gem_object_read_from_page_kmap(struct drm_i915_gem_object *obj, u64 offset, void *dst, int size)
 {
 	pgoff_t idx = offset >> PAGE_SHIFT;
-	void *src_map;
 	void *src_ptr;
 
-	src_map = kmap_atomic(i915_gem_object_get_page(obj, idx));
-
-	src_ptr = src_map + offset_in_page(offset);
+	src_ptr = kmap_local_page(i915_gem_object_get_page(obj, idx))
+	          + offset_in_page(offset);
 	if (!(obj->cache_coherent & I915_BO_CACHE_COHERENT_FOR_READ))
 		drm_clflush_virt_range(src_ptr, size);
 	memcpy(dst, src_ptr, size);
 
-	kunmap_atomic(src_map);
+	kunmap_local(src_ptr);
 }
 
 static void
-- 
2.34.1

