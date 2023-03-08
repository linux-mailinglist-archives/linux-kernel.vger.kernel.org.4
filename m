Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BDB6B0D21
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjCHPlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjCHPkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:40:25 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9095D26A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678290009; x=1709826009;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wG3vf2+xlpzOKdj5dCj9/rgBBguHqYIRNINuZ3j1/Dc=;
  b=m+3DxtLKGcIi07Hge9SmupV9IN8MFNYT93ZRY2OtqsaBpp7/u1eBSJQB
   iOjfy+0SmPm22zxkeO4ycCoe8Iem6SYNqAH+0doNN0ckMY92UGxhQRkBT
   o422fkrOy2sH0aeDd6d4MnrZ7qInirdg1j+S8H/X4BkfyK1MxOnuN0Nwi
   R2oEkO3DyKdWnwEu+56kuxbyc4pPyFrV4qKjZsS8SsqB9wI8FK5eAfzCm
   wWIR77R0W+IxTA1q3mkMyEdQG9uM+NP8uphDlWWkvhEYsmP0LY3l4kfXS
   Tah2Ww5qmmeNWHi3xEXTR2XG5Azf5DRYgpV8VpQdaM6EkgrdQyAwhi3L6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="337703576"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="337703576"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:39:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="787160279"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="787160279"
Received: from lab-ah.igk.intel.com ([10.102.42.211])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 07:39:49 -0800
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Date:   Wed, 08 Mar 2023 16:39:05 +0100
Subject: [PATCH v5 3/4] drm/i915/selftests: use nop_clear_range instead of
 local function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-guard_error_capture-v5-3-6d1410d13540@intel.com>
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

Since nop_clear_range is visible it can be used here.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
---
 drivers/gpu/drm/i915/selftests/mock_gtt.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/mock_gtt.c b/drivers/gpu/drm/i915/selftests/mock_gtt.c
index ece97e4faacb97..89119e3970279f 100644
--- a/drivers/gpu/drm/i915/selftests/mock_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/mock_gtt.c
@@ -57,11 +57,6 @@ static void mock_cleanup(struct i915_address_space *vm)
 {
 }
 
-static void mock_clear_range(struct i915_address_space *vm,
-			     u64 start, u64 length)
-{
-}
-
 struct i915_ppgtt *mock_ppgtt(struct drm_i915_private *i915, const char *name)
 {
 	struct i915_ppgtt *ppgtt;
@@ -80,7 +75,7 @@ struct i915_ppgtt *mock_ppgtt(struct drm_i915_private *i915, const char *name)
 	ppgtt->vm.alloc_pt_dma = alloc_pt_dma;
 	ppgtt->vm.alloc_scratch_dma = alloc_pt_dma;
 
-	ppgtt->vm.clear_range = mock_clear_range;
+	ppgtt->vm.clear_range = nop_clear_range;
 	ppgtt->vm.insert_page = mock_insert_page;
 	ppgtt->vm.insert_entries = mock_insert_entries;
 	ppgtt->vm.cleanup = mock_cleanup;
@@ -119,7 +114,7 @@ void mock_init_ggtt(struct intel_gt *gt)
 	ggtt->vm.alloc_pt_dma = alloc_pt_dma;
 	ggtt->vm.alloc_scratch_dma = alloc_pt_dma;
 
-	ggtt->vm.clear_range = mock_clear_range;
+	ggtt->vm.clear_range = nop_clear_range;
 	ggtt->vm.insert_page = mock_insert_page;
 	ggtt->vm.insert_entries = mock_insert_entries;
 	ggtt->vm.cleanup = mock_cleanup;

-- 
2.34.1
