Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC15E5E6CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiIVUKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiIVUKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:10:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25229F372B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663877441; x=1695413441;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=6q+7YG95fTQJu0XBlZybDpu+Be16ol9OqAsEH3PK4pM=;
  b=H1MT/OUVF0uoXngJbfk2cTij3OBp/blTIdzxIeX01qlIwP3eg6LAK0ab
   cLpA0A/hNxCWEp6OzWwCIuoNmsj2995oztnizm8ypiXJZN8jwXwTHVXym
   7o6Q+SIuTM9ewnAAC/ZISyFrNXWkVpUeGX1R8UtvVQIbNaav3wv9cNr7V
   JG8OA+DsYjs/9RA4D5Fo/aOcivsOMD+CUYLEWtPUhM3vzTT0rmTimGmse
   0M/8ZWNJt5cLO1HEdZV24xHkm09YpbQT1SM8aslTR5BpaSXapP8LNkj4s
   YyXvf/FRnY6x9Oy0QBR611ehr9tJDatWzQXW+nQ4IBJxtV9AgarDPolod
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="300404299"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="300404299"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:10:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="597592015"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga006.jf.intel.com with ESMTP; 22 Sep 2022 13:10:38 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, avagin@gmail.com,
        seanjc@google.com, chang.seok.bae@intel.com
Subject: [PATCH v2 4/4] x86/fpu: Correct the legacy state offset and size information
Date:   Thu, 22 Sep 2022 13:00:34 -0700
Message-Id: <20220922200034.23759-5-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220922200034.23759-1-chang.seok.bae@intel.com>
References: <20220922200034.23759-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index a3f7045d1f8e..ac2ec5d6e7e4 100644
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

