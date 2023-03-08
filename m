Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237016B0D20
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbjCHPlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjCHPk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:40:27 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC1392BEB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678290010; x=1709826010;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=W+jwVlTRdjvktA1nEkWNcAT5iygeBJ8dB2aSEBElQ1U=;
  b=bviiDxUMJdiXBZhjxH8bd0LGJ/qYjKA0oHf3Oq9Kc3oF0bwhOV0grBeP
   dKR5JZMdb3yCO9vsoZh0BKf4KdfXImhfT7OFTA9lacia0+Dl4hab1/9ah
   n32l+jfmZyq7uRK+EHdWaAdA5Aohexu1MknHh0woBT+AMq9uw19f+VHTS
   WBiGOW5TghS3XfxYuRh0dXMwvwxXTjsAlvctJa4IZylxbLHjQ+vlFf02m
   Xcg5eCMOn5Zhc7kK9dpXB+gIja/wZYTlmd4VuRQtgtlMWZo0sIBvPUTMn
   uOikrO3Rs/4N+x0Vx8UyCvyYonNXekj4AODuWoMBmigHs96NQzkOd7e3g
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="337703592"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="337703592"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:39:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="787160296"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="787160296"
Received: from lab-ah.igk.intel.com ([10.102.42.211])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:39:51 -0800
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Date:   Wed, 08 Mar 2023 16:39:06 +0100
Subject: [PATCH v5 4/4] drm/i915: add guard page to ggtt->error_capture
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-guard_error_capture-v5-4-6d1410d13540@intel.com>
References: <20230308-guard_error_capture-v5-0-6d1410d13540@intel.com>
In-Reply-To: <20230308-guard_error_capture-v5-0-6d1410d13540@intel.com>
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/gpu/drm/i915/gt/intel_ggtt.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
index b925da42c7cfc4..8fb700fde85c8f 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
@@ -502,6 +502,21 @@ static void cleanup_init_ggtt(struct i915_ggtt *ggtt)
 	mutex_destroy(&ggtt->error_mutex);
 }
 
+static void
+ggtt_insert_scratch_pages(struct i915_ggtt *ggtt, u64 offset, u64 length)
+{
+	struct i915_address_space *vm = &ggtt->vm;
+
+	if (vm->clear_range != nop_clear_range)
+		return vm->clear_range(vm, offset, length);
+
+	while (length > 0) {
+		vm->insert_page(vm, px_dma(vm->scratch[0]), offset, I915_CACHE_NONE, 0);
+		offset += I915_GTT_PAGE_SIZE;
+		length -= I915_GTT_PAGE_SIZE;
+	}
+}
+
 static int init_ggtt(struct i915_ggtt *ggtt)
 {
 	/*
@@ -550,8 +565,12 @@ static int init_ggtt(struct i915_ggtt *ggtt)
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
@@ -561,11 +580,15 @@ static int init_ggtt(struct i915_ggtt *ggtt)
 						    0, ggtt->mappable_end,
 						    DRM_MM_INSERT_LOW);
 	}
-	if (drm_mm_node_allocated(&ggtt->error_capture))
+	if (drm_mm_node_allocated(&ggtt->error_capture)) {
+		u64 start = ggtt->error_capture.start;
+		u64 size = ggtt->error_capture.size;
+
+		ggtt_insert_scratch_pages(ggtt, start, size);
 		drm_dbg(&ggtt->vm.i915->drm,
 			"Reserved GGTT:[%llx, %llx] for use by error capture\n",
-			ggtt->error_capture.start,
-			ggtt->error_capture.start + ggtt->error_capture.size);
+			start, start + size);
+	}
 
 	/*
 	 * The upper portion of the GuC address space has a sizeable hole
@@ -1256,6 +1279,10 @@ void i915_ggtt_resume(struct i915_ggtt *ggtt)
 
 	flush = i915_ggtt_resume_vm(&ggtt->vm);
 
+	if (drm_mm_node_allocated(&ggtt->error_capture))
+		ggtt_insert_scratch_pages(ggtt, ggtt->error_capture.start,
+					  ggtt->error_capture.size);
+
 	ggtt->invalidate(ggtt);
 
 	if (flush)

-- 
2.34.1
