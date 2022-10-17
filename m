Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8171D600AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbiJQJdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbiJQJdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:33:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D905A808
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665999176; x=1697535176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Ch/gzI1CiEltsWtZiZ1vnI7GDsumr0SEFm747ErScU=;
  b=jgCItgeC1R/Zp94KyKUhQnOWheZ9NvWIOckwNkWRHkjNznPwLqAZsUb6
   MEZtEmJhJNDS2ooI4yuMy3552pwR2w0zCOKFAGQF3Tgba+HmIP943UcIp
   pRsLLJsbPNNuwFAlO4blrePUBbUS4WaVAG4gCs2BiIL3Ks44SMPMXVxoO
   An5oaMC49vxjX+zh3Kk1BQPdJn+WJvOeoxG/y5elWau+SnSCGBJTy/6vn
   Dv3jZTT3ENkzf62GaMbrZAC9qbQkD1fla//f6X7HfJ9CRNtilZw/dduyz
   gAyQSxCLx7Fkf9IxoW7wi2hpRBK8KgYDXKpNdNBQsi/2hjEnQWwpXRS6r
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="305741641"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="305741641"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 02:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10502"; a="717431333"
X-IronPort-AV: E=Sophos;i="5.95,191,1661842800"; 
   d="scan'208";a="717431333"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.132])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Oct 2022 02:32:52 -0700
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
Subject: [PATCH 8/9] drm/i915: Use kmap_local_page() in i915_cmd_parser.c
Date:   Mon, 17 Oct 2022 17:37:24 +0800
Message-Id: <20221017093726.2070674-9-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017093726.2070674-1-zhao1.liu@linux.intel.com>
References: <20221017093726.2070674-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhao Liu <zhao1.liu@intel.com>

The use of kmap_atomic() is being deprecated in favor of
kmap_local_page()[1].

The main difference between atomic and local mappings is that local
mappings doesn't disable page faults or preemption.

There're 2 reasons why function copy_batch() doesn't need to disable
pagefaults and preemption for mapping:

1. The flush operation is safe for CPU hotplug when preemption is not
disabled. In i915_cmd_parser.c, the function copy_batch() calls
drm_clflush_virt_range() to use CLFLUSHOPT or WBINVD to flush.
Since CLFLUSHOPT is global on x86 and WBINVD is called on each cpu
in drm_clflush_virt_range(), the flush operation is global and any
issue with cpu's being added or removed can be handled safely.

2. Any context switch caused by preemption or sleep (pagefault may
cause sleep) doesn't affect the validity of local mapping.

Therefore, copy_batch() is a function where the use of
kmap_local_page() in place of kmap_atomic() is correctly suited.

Convert the calls of kmap_atomic() / kunmap_atomic() to
kmap_local_page() / kunmap_local().

[1]: https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Suggested by credits:
  Dave: Referred to his explanation about cache flush.
  Ira: Referred to his task document, review comments and explanation about
       cache flush.
  Fabio: Referred to his boiler plate commit message.
---
 drivers/gpu/drm/i915/i915_cmd_parser.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_cmd_parser.c b/drivers/gpu/drm/i915/i915_cmd_parser.c
index f93e6122f247..1a56000d7476 100644
--- a/drivers/gpu/drm/i915/i915_cmd_parser.c
+++ b/drivers/gpu/drm/i915/i915_cmd_parser.c
@@ -1211,11 +1211,11 @@ static u32 *copy_batch(struct drm_i915_gem_object *dst_obj,
 		for (n = offset >> PAGE_SHIFT; remain; n++) {
 			int len = min(remain, PAGE_SIZE - x);
 
-			src = kmap_atomic(i915_gem_object_get_page(src_obj, n));
+			src = kmap_local_page(i915_gem_object_get_page(src_obj, n));
 			if (src_needs_clflush)
 				drm_clflush_virt_range(src + x, len);
 			memcpy(ptr, src + x, len);
-			kunmap_atomic(src);
+			kunmap_local(src);
 
 			ptr += len;
 			remain -= len;
-- 
2.34.1

