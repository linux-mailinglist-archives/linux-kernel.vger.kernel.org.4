Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5E95F5C5D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 00:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJEWE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 18:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJEWEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 18:04:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6501A22516
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665007450; x=1696543450;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=GPA5zru0bLPS1ZrLI+2WJ00Z5cYvkUWncyFnMvUxmRo=;
  b=IM6m93LQ/Rqu9kL9uY6LVCVVqoiGO3bcv/pqXEFo/PjpxGI1szHarEW1
   cgvBcW2Ju1AM/DbAHDevCis+VDBMZW+9D5YlMysg9+WF55S4+lA3qetp+
   RkdkSgpACDVa3atK4n0D7xewMYwhoaCy8yvyzdssN9BPezNVUI9hFc7y9
   HV9lnxDhO+4diRd2Xi81vcW5EEI9zU6lH05uQvCQQF1HE2nwC4fq5SCDv
   MbUHXxr0EhwhLHwRhTmFBTnHXkPWDbcdFyznKl3RVjD6TpFso4D8NW+y1
   rsE9hPrnsE7Q3gcAJ8y4LQZ7KG0aO1wHaSoAdhoNbWb3KPlmpqlHiLZBU
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="365218816"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="365218816"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 15:04:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="602193028"
X-IronPort-AV: E=Sophos;i="5.95,162,1661842800"; 
   d="scan'208";a="602193028"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga006.jf.intel.com with ESMTP; 05 Oct 2022 15:04:08 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, avagin@gmail.com,
        seanjc@google.com, chang.seok.bae@intel.com
Subject: [PATCH v3 3/3] x86/fpu: Correct the legacy state offset and size information
Date:   Wed,  5 Oct 2022 14:53:57 -0700
Message-Id: <20221005215357.1808-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221005215357.1808-1-chang.seok.bae@intel.com>
References: <20221005215357.1808-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MXCSR is architecturally part of the SSE state. But, the kernel code
presumes it as part of the FP component. Adjust the offset and size for
these legacy states.

Notably, each legacy component area is not contiguous, unlike extended
components. Add a WARNING to be emitted when the location of those
legacy states is queried.

Fixes: ac73b27aea4e ("x86/fpu/xstate: Fix xstate_offsets, xstate_sizes for non-extended xstates")
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v2:
* Replace pr_warn() with WARN_ON_ONCE() (Sean Christopherson).
* Massage the code comment (Sean Christopherson).
---
 arch/x86/kernel/fpu/xstate.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index d7676cfc32eb..252a54807f0c 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -140,10 +140,11 @@ static unsigned int xfeature_get_offset(u64 xcomp_bv, int xfeature)
 
 	/*
 	 * Non-compacted format and legacy features use the cached fixed
-	 * offsets.
+	 * offsets. N.B. Each legacy state is discontiguously located in
+	 * memory.
 	 */
 	if (!cpu_feature_enabled(X86_FEATURE_XCOMPACTED) ||
-	    xfeature <= XFEATURE_SSE)
+	    WARN_ON_ONCE(xfeature <= XFEATURE_SSE))
 		return xstate_offsets[xfeature];
 
 	/*
@@ -217,14 +218,18 @@ static void __init setup_xstate_cache(void)
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

