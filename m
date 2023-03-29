Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2015C6CD31D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjC2HZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjC2HZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:25:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0191448B
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680074700; x=1711610700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GMpKo8ThZ2YBrIiNDv5DIUoRW6Piin/4x6sH+rZpkMU=;
  b=N8SOof7zkbbECzwuzNHEYGNELDAnjm5FRzrTaUH5Vn4ILm5YOuPPd4u3
   ttZa/H3J04Wf/rFzSypUwdJtxSnserWGnIkCLKbSMOFzim5LHBp2XhwU7
   BMbPG2mwwaL7IUpgwgzBg+RIyzAoeNt2dgaZb/XOFxZ6yuJINj7qthM6R
   xtjdnZc2il0tckucZ90KWT4MNkGPZCOmJgC5nadikl1nBUFKJ3EmxsGJz
   DcPotdxbUzHDveF8w9QroLy4Eltnr4zqUnvqIqFu8OQEHyr7u+J83g2w8
   CNF1uylvzPYib24AMAFbHJlMCFanf2DJ0IJnTUIuTbwr48oKovs3hfHkQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="405746125"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="405746125"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:24:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="684160621"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="684160621"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.112])
  by orsmga002.jf.intel.com with ESMTP; 29 Mar 2023 00:24:40 -0700
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
Subject: [PATCH v2 6/9] drm/i915: Use kmap_local_page() in gem/selftests/i915_gem_context.c
Date:   Wed, 29 Mar 2023 15:32:17 +0800
Message-Id: <20230329073220.3982460-7-zhao1.liu@linux.intel.com>
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
mappings doesn't disable page faults or preemption.

With kmap_local_page(), we can avoid the often unwanted side effect of
unnecessary page faults or preemption disables.

In drm/i915/gem/selftests/i915_gem_context.c, functions cpu_fill() and
cpu_check() mainly uses mapping to flush cache and check/assign the
value.

There're 2 reasons why cpu_fill() and cpu_check() don't need to disable
pagefaults and preemption for mapping:

1. The flush operation is safe. cpu_fill() and cpu_check() call
drm_clflush_virt_range() to use CLFLUSHOPT or WBINVD to flush. Since
CLFLUSHOPT is global on x86 and WBINVD is called on each cpu in
drm_clflush_virt_range(), the flush operation is global.

2. Any context switch caused by preemption or page faults (page fault
may cause sleep) doesn't affect the validity of local mapping.

Therefore, cpu_fill() and cpu_check() are functions where the use of
kmap_local_page() in place of kmap_atomic() is correctly suited.

Convert the calls of kmap_atomic() / kunmap_atomic() to
kmap_local_page() / kunmap_local().

[1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com

v2:
* Dropped hot plug related description since it has nothing to do with
  kmap_local_page().
* No code change since v1, and added description of the motivation of
  using kmap_local_page().

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
 drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
index a81fa6a20f5a..dcbc0b8e3323 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_context.c
@@ -481,12 +481,12 @@ static int cpu_fill(struct drm_i915_gem_object *obj, u32 value)
 	for (n = 0; n < real_page_count(obj); n++) {
 		u32 *map;
 
-		map = kmap_atomic(i915_gem_object_get_page(obj, n));
+		map = kmap_local_page(i915_gem_object_get_page(obj, n));
 		for (m = 0; m < DW_PER_PAGE; m++)
 			map[m] = value;
 		if (!has_llc)
 			drm_clflush_virt_range(map, PAGE_SIZE);
-		kunmap_atomic(map);
+		kunmap_local(map);
 	}
 
 	i915_gem_object_finish_access(obj);
@@ -512,7 +512,7 @@ static noinline int cpu_check(struct drm_i915_gem_object *obj,
 	for (n = 0; n < real_page_count(obj); n++) {
 		u32 *map, m;
 
-		map = kmap_atomic(i915_gem_object_get_page(obj, n));
+		map = kmap_local_page(i915_gem_object_get_page(obj, n));
 		if (needs_flush & CLFLUSH_BEFORE)
 			drm_clflush_virt_range(map, PAGE_SIZE);
 
@@ -538,7 +538,7 @@ static noinline int cpu_check(struct drm_i915_gem_object *obj,
 		}
 
 out_unmap:
-		kunmap_atomic(map);
+		kunmap_local(map);
 		if (err)
 			break;
 	}
-- 
2.34.1

