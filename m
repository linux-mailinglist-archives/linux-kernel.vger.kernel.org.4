Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52896CD2F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjC2HZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjC2HYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:24:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCDB213A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 00:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680074669; x=1711610669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lZB7D+9oAqqUk803oQiOFCr0X6utrKVFTvfta1a/CQQ=;
  b=G2hggRGu5eXem7cemsyrXbUwebGh8sXC4ws42/S8YubBv+V++lBn5mt/
   7wjuSClFs/Up0rK+EdCXfQbNYHpcXDMXxlGdhJW3h2SwDIPIp+XKycs5L
   y+pat0/YK9ObD7X8MxbmquTOeznO0fqGaAbrFILARQqmMz4HSclPrGfCR
   py+N+bExBAvEPeuLMOtkx56FTiGfO9LhczUXuu/9IIYUpb5Eq0qkrPkT+
   68vu6DCFOSRpH/0gMAdREgf4ngRB0d/U9gUH1G36dRKR2S3MkbNPA/kAE
   eBU6EEB2tyJIj5tY1mGpmB+rIP51lNJfp3P0PiXrGYKiw4nr9RLYB3eqK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="405745889"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="405745889"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="684160559"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="684160559"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.112])
  by orsmga002.jf.intel.com with ESMTP; 29 Mar 2023 00:24:24 -0700
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
        Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 3/9] drm/i915: Use kmap_local_page() in gem/i915_gem_shmem.c
Date:   Wed, 29 Mar 2023 15:32:14 +0800
Message-Id: <20230329073220.3982460-4-zhao1.liu@linux.intel.com>
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
kmap_local_page()[1].

The main difference between atomic and local mappings is that local
mappings doesn't disable page faults or preemption (the preemption is
disabled for !PREEMPT_RT case, otherwise it only disables migration).

With kmap_local_page(), we can avoid the often unwanted side effect of
unnecessary page faults or preemption disables.

In drm/i915/gem/i915_gem_shmem.c, the function shmem_pwrite() need to
disable pagefault to eliminate the potential recursion fault[2]. But
here __copy_from_user_inatomic() doesn't need to disable preemption and
local mapping is valid for sched in/out.

So it can use kmap_local_page() / kunmap_local() with
pagefault_disable() / pagefault_enable() to replace atomic mapping.

[1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com
[2]: https://patchwork.freedesktop.org/patch/295840/

v2: No code change since v1, and added description of the motivation of
    using kmap_local_page().

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Suggested by credits:
  Ira: Referred to his suggestions about keeping pagefault_disable().
  Fabio: Referred to his description about why kmap_local_page() should
         be preferred.
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 37d1efcd3ca6..ad69a79c8b31 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -475,11 +475,13 @@ shmem_pwrite(struct drm_i915_gem_object *obj,
 		if (err < 0)
 			return err;
 
-		vaddr = kmap_atomic(page);
+		vaddr = kmap_local_page(page);
+		pagefault_disable();
 		unwritten = __copy_from_user_inatomic(vaddr + pg,
 						      user_data,
 						      len);
-		kunmap_atomic(vaddr);
+		pagefault_enable();
+		kunmap_local(vaddr);
 
 		err = aops->write_end(obj->base.filp, mapping, offset, len,
 				      len - unwritten, page, data);
-- 
2.34.1

