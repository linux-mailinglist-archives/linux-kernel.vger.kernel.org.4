Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260BC5BB36E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiIPUWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiIPUWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:22:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9096A98CC
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 13:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663359719; x=1694895719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=amir2HUPEmO/61A+AAqczzCnbRgaN6rwh/1IJFe05oQ=;
  b=b5Jbj7d7eS1jUYyUJpHp0xmVE4AKtAdDTbnNvS35QCLdwSzQPY7qyruY
   duupBF2iYLGjy/xq+fcfHdkdcYQo66jQlYJdoiCfDk31FYNrPK3/b6Li8
   rFVV+sEbU0mjrCRU4NAftaGChOZU2GHll2r1vITkO7Gciq7n+CGrjPAY9
   LBF5GnHOo9JnRRQ1b0bOiv77FbRyypR20FIoii23EhnWu5e062fP75AJB
   ChFqyS+tAh7YTW/1jRxB3K+QGHBTc0PPR2ar1v6DOJk3MfJUTr/jhgB14
   RRhPO2bDzBJnfX7urdbPSJt//18Jjtk0U52CDiqWkuOUSmWHdiXxCDxWJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="278801386"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="278801386"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 13:21:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="680092300"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga008.fm.intel.com with ESMTP; 16 Sep 2022 13:21:57 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, avagin@gmail.com,
        chang.seok.bae@intel.com
Subject: [PATCH 4/4] x86/fpu: Correct the legacy state offset and size information
Date:   Fri, 16 Sep 2022 13:11:58 -0700
Message-Id: <20220916201158.8072-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220916201158.8072-1-chang.seok.bae@intel.com>
References: <20220916201158.8072-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MXCSR is architecturally part of the SSE state. But, the kernel code
presumes it as part of the FP component. Adjust the offset and size for
these legacy states.

Notably, each legacy component area is not contiguous, unlike extended
components. Add a warning message when these offset and size are
referenced.

Fixes: ac73b27aea4e ("x86/fpu/xstate: Fix xstate_offsets, xstate_sizes for non-extended xstates")
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/fpu/xstate.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index a35f91360e3f..2564da50d8bb 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -143,8 +143,13 @@ static unsigned int xfeature_get_offset(u64 xcomp_bv, int xfeature)
 	 * offsets.
 	 */
 	if (!cpu_feature_enabled(X86_FEATURE_XCOMPACTED) ||
-	    xfeature <= XFEATURE_SSE)
+	    xfeature <= XFEATURE_SSE) {
+		if (xfeature <= XFEATURE_SSE)
+			pr_warn("The legacy state (%d) is discontiguously located.\n",
+				xfeature);
+
 		return xstate_offsets[xfeature];
+	}
 
 	/*
 	 * Compacted format offsets depend on the actual content of the
@@ -217,14 +222,18 @@ static void __init setup_xstate_cache(void)
 	 * The FP xstates and SSE xstates are legacy states. They are always
 	 * in the fixed offsets in the xsave area in either compacted form
 	 * or standard form.
+	 *
+	 * But, while MXCSR is part of the SSE state, it is located in
+	 * between the FP states. Note that it is erroneous assuming that
+	 * each legacy area is contiguous.
 	 */
 	xstate_offsets[XFEATURE_FP]	= 0;
-	xstate_sizes[XFEATURE_FP]	= offsetof(struct fxregs_state,
-						   xmm_space);
+	xstate_sizes[XFEATURE_FP]	= offsetof(struct fxregs_state, mxcsr) +
+					  sizeof_field(struct fxregs_state, st_space);
 
-	xstate_offsets[XFEATURE_SSE]	= xstate_sizes[XFEATURE_FP];
-	xstate_sizes[XFEATURE_SSE]	= sizeof_field(struct fxregs_state,
-						       xmm_space);
+	xstate_offsets[XFEATURE_SSE]	= offsetof(struct fxregs_state, mxcsr);
+	xstate_sizes[XFEATURE_SSE]	= MXCSR_AND_FLAGS_SIZE +
+					  sizeof_field(struct fxregs_state, xmm_space);
 
 	for_each_extended_xfeature(i, fpu_kernel_cfg.max_features) {
 		cpuid_count(XSTATE_CPUID, i, &eax, &ebx, &ecx, &edx);
-- 
2.17.1

