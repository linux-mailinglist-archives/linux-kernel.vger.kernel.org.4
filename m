Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063866B3A62
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjCJJ1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCJJ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:27:26 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA737DD13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678440249; x=1709976249;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cnXIrMH6SE0F1eNgQYElRfVjjQ186pEPV0fuykHDPxU=;
  b=hfIZtPEdtectUYDCPV/XFrXIgR2FFJoIJPJIdc2WGJMmFvRhnLSQJ8V0
   nKDHgpR46WZ2ACBhRk5GRblpoQw3ds+oqgJQ6MzsoSQqNyyNutl+dcyg7
   09371uukgNwhlFZ5+6RrAK+LTvcynRmVn4dVAqQsdr7FtWCG18KkIutyF
   7Yniu/p7TtSytgIWftIpt+jvprI7usyLMosSJ3zSL1JPVRkl+cBVbdcXq
   RlKEZMCQ8lTzn8JYV+AplHYcGnH29i3vCH+O6Xv/KVN+LPPrl7uavTaqU
   6g8Y/k5Lv+HnmwPtbivY/D9wtdj/r0eXbcGW4ln/d4ANYGF+Lf/KmfKh7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="334164689"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="334164689"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 01:24:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10644"; a="801513249"
X-IronPort-AV: E=Sophos;i="5.98,249,1673942400"; 
   d="scan'208";a="801513249"
Received: from lab-ah.igk.intel.com ([10.102.42.211])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 01:24:06 -0800
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Date:   Fri, 10 Mar 2023 10:23:50 +0100
Subject: [PATCH v6 2/2] drm/i915: add guard page to ggtt->error_capture
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-guard_error_capture-v6-2-1b5f31422563@intel.com>
References: <20230308-guard_error_capture-v6-0-1b5f31422563@intel.com>
In-Reply-To: <20230308-guard_error_capture-v6-0-1b5f31422563@intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Chris Wilson <chris.p.wilson@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Write-combining memory allows speculative reads by CPU.
ggtt->error_capture is WC mapped to CPU, so CPU/MMU can try
to prefetch memory beyond the error_capture, ie it tries
to read memory pointed by next PTE in GGTT.
If this PTE points to invalid address DMAR errors will occur.
This behaviour was observed on ADL and RPL platforms.
To avoid it, guard scratch page should be added after error_capture.
The patch fixes the most annoying issue with error capture but
since WC reads are used also in other places there is a risk similar
problem can affect them as well.

v2:
  - modified commit message (I hope the diagnosis is correct),
  - added bug checks to ensure scratch is initialized on gen3 platforms.
    CI produces strange stacktrace for it suggesting scratch[0] is NULL,
    to be removed after resolving the issue with gen3 platforms.
v3:
  - removed bug checks, replaced with gen check.
v4:
  - change code for scratch page insertion to support all platforms,
  - add info in commit message there could be more similar issues
v5:
  - check for nop_clear_range instead of gen8 (Tvrtko),
  - re-insert scratch pages on resume (Tvrtko)
v6:
  - use scratch_range callback to set scratch pages (Chris)

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/gpu/drm/i915/gt/intel_ggtt.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
index 38e6f0b207fe0c..5ef7e03b11c8e6 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
@@ -572,8 +572,12 @@ static int init_ggtt(struct i915_ggtt *ggtt)
 		 * paths, and we trust that 0 will remain reserved. However,
 		 * the only likely reason for failure to insert is a driver
 		 * bug, which we expect to cause other failures...
+		 *
+		 * Since CPU can perform speculative reads on error capture
+		 * (write-combining allows it) add scratch page after error
+		 * capture to avoid DMAR errors.
 		 */
-		ggtt->error_capture.size = I915_GTT_PAGE_SIZE;
+		ggtt->error_capture.size = 2 * I915_GTT_PAGE_SIZE;
 		ggtt->error_capture.color = I915_COLOR_UNEVICTABLE;
 		if (drm_mm_reserve_node(&ggtt->vm.mm, &ggtt->error_capture))
 			drm_mm_insert_node_in_range(&ggtt->vm.mm,
@@ -583,11 +587,15 @@ static int init_ggtt(struct i915_ggtt *ggtt)
 						    0, ggtt->mappable_end,
 						    DRM_MM_INSERT_LOW);
 	}
-	if (drm_mm_node_allocated(&ggtt->error_capture))
+	if (drm_mm_node_allocated(&ggtt->error_capture)) {
+		u64 start = ggtt->error_capture.start;
+		u64 size = ggtt->error_capture.size;
+
+		ggtt->vm.scratch_range(&ggtt->vm, start, size);
 		drm_dbg(&ggtt->vm.i915->drm,
 			"Reserved GGTT:[%llx, %llx] for use by error capture\n",
-			ggtt->error_capture.start,
-			ggtt->error_capture.start + ggtt->error_capture.size);
+			start, start + size);
+	}
 
 	/*
 	 * The upper portion of the GuC address space has a sizeable hole
@@ -1280,6 +1288,10 @@ void i915_ggtt_resume(struct i915_ggtt *ggtt)
 
 	flush = i915_ggtt_resume_vm(&ggtt->vm);
 
+	if (drm_mm_node_allocated(&ggtt->error_capture))
+		ggtt->vm.scratch_range(&ggtt->vm, ggtt->error_capture.start,
+				       ggtt->error_capture.size);
+
 	ggtt->invalidate(ggtt);
 
 	if (flush)

-- 
2.34.1
