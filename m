Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8065E6CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiIVUKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiIVUKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:10:40 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E17F2745
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663877439; x=1695413439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2wQU5u0JEJI3UkDRA0Tf2j+yl1WWuKxxoHm3zoZx9Lc=;
  b=jT0kQimmYbTL+HK8JfpHYkIJWJdGUqVMc16qu1tzOLkVJ1f5Kx2M2K+R
   RJGrI1NPxH7qqQLaEqq7zjESy7hR+NzOKOVwVuJcZbX0tI7oYDJYIiLrY
   +Bw+s5DVyiSCZL6mx1YLloU1f7WhQV1zw8Ohv1oZDwVr3VSiQ6rP6lmzP
   oaLo+2dJLkJnrgIUclantddHeRTFnjUkRMfns6+hXy2aNhruhrnU1l6Kd
   UM81So5PwmV3bmfE+HQdmwbaxyNLzKwezJHFlzM2zf/m8rIQDARYn42/7
   Kd+lmfni6QWCIEycM0qYEJXyI8U0l982z/YdGiycMaY/08pbYgh+oFFew
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="300404292"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="300404292"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="597592000"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga006.jf.intel.com with ESMTP; 22 Sep 2022 13:10:37 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, avagin@gmail.com,
        seanjc@google.com, chang.seok.bae@intel.com
Subject: [PATCH v2 1/4] x86/fpu: Fix the MXCSR state reshuffling between userspace and kernel buffers
Date:   Thu, 22 Sep 2022 13:00:31 -0700
Message-Id: <20220922200034.23759-2-chang.seok.bae@intel.com>
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

== Hardware Background ==

The MXCSR state, as part of the SSE component, has different treatments
with XSAVE*/XRSTOR* between the two XSAVE formats:

- When the MXCSR state is XSAVEd in the non-compacted format, the feature
bit in XSTATE_BV pertains to the XMM registers. XRSTOR restores the MXCSR
state without referencing XSTATE_BV.

- But, on XSAVE* with the compacted format, the SSE bit is set in XSTATE_BV
if MXCSR is not in the init state on XSAVE*. Then, on XRSTOR*, the state is
restored only when the SSE bit is set in XSTATE_BV.

== Regression ==

The XSTATE copy routine between userspace and kernel buffers used to be
separate for different XSAVE formats. Commit 43be46e89698 ("x86/fpu:
Sanitize xstateregs_set()") combined them together.

This change appears to be a regression on XSAVES-less systems. But, the
merged code is based on the original conversion code with commit
91c3dba7dbc1 ("x86/fpu/xstate: Fix PTRACE frames for XSAVES").

That has such oversight as:
- Mistreating MXCSR as part of the FP state instead of the SSE component.
- Taking the SSE bit in XSTATE_BV always for all the SSE states.

== Correction ==

Update the XSTATE conversion code:
- Refactor the copy routine for legacy states. Treat MXCSR as part of SSE.
- Copying MXCSR, reference XSTATE_BV only with the compacted format.
- Also, flip the SSE bit in XSTATE_BV accordingly to the format.

Reported-by: Andrei Vagin <avagin@gmail.com>
Fixes: 91c3dba7dbc1 ("x86/fpu/xstate: Fix PTRACE frames for XSAVES")
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/lkml/CANaxB-wkcNKWjyNGFuMn6f6H2DQSGwwQjUgg1eATdUgmM-Kg+A@mail.gmail.com/
---
 arch/x86/kernel/fpu/xstate.c | 70 +++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c8340156bfd2..d7676cfc32eb 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1064,6 +1064,7 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 			       u32 pkru_val, enum xstate_copy_mode copy_mode)
 {
 	const unsigned int off_mxcsr = offsetof(struct fxregs_state, mxcsr);
+	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
 	struct xregs_state *xinit = &init_fpstate.regs.xsave;
 	struct xregs_state *xsave = &fpstate->regs.xsave;
 	struct xstate_header header;
@@ -1093,8 +1094,13 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 	copy_feature(header.xfeatures & XFEATURE_MASK_FP, &to, &xsave->i387,
 		     &xinit->i387, off_mxcsr);
 
-	/* Copy MXCSR when SSE or YMM are set in the feature mask */
-	copy_feature(header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM),
+	/*
+	 * Copy MXCSR depending on the XSAVE format. If compacted,
+	 * reference the feature mask. Otherwise, check if any of related
+	 * features is valid.
+	 */
+	copy_feature(compacted ? header.xfeatures & XFEATURE_MASK_SSE :
+		     fpstate->user_xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM),
 		     &to, &xsave->i387.mxcsr, &xinit->i387.mxcsr,
 		     MXCSR_AND_FLAGS_SIZE);
 
@@ -1199,6 +1205,11 @@ static int copy_from_buffer(void *dst, unsigned int offset, unsigned int size,
 static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
 			       const void __user *ubuf)
 {
+	const unsigned int off_stspace = offsetof(struct fxregs_state, st_space);
+	const unsigned int off_xmm = offsetof(struct fxregs_state, xmm_space);
+	const unsigned int off_mxcsr = offsetof(struct fxregs_state, mxcsr);
+	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
+	struct fxregs_state *fxsave = &fpstate->regs.fxsave;
 	struct xregs_state *xsave = &fpstate->regs.xsave;
 	unsigned int offset, size;
 	struct xstate_header hdr;
@@ -1212,38 +1223,48 @@ static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
 	if (validate_user_xstate_header(&hdr, fpstate))
 		return -EINVAL;
 
-	/* Validate MXCSR when any of the related features is in use */
-	mask = XFEATURE_MASK_FP | XFEATURE_MASK_SSE | XFEATURE_MASK_YMM;
-	if (hdr.xfeatures & mask) {
+	if (hdr.xfeatures & XFEATURE_MASK_FP) {
+		if (copy_from_buffer(fxsave, 0, off_mxcsr, kbuf, ubuf))
+			return -EINVAL;
+		if (copy_from_buffer(fxsave->st_space, off_stspace, sizeof(fxsave->st_space),
+				     kbuf, ubuf))
+			return -EINVAL;
+	}
+
+	/* Validate MXCSR when any of the related features is valid. */
+	mask = XFEATURE_MASK_SSE | XFEATURE_MASK_YMM;
+	if (fpstate->user_xfeatures & mask) {
 		u32 mxcsr[2];
 
-		offset = offsetof(struct fxregs_state, mxcsr);
-		if (copy_from_buffer(mxcsr, offset, sizeof(mxcsr), kbuf, ubuf))
+		if (copy_from_buffer(mxcsr, off_mxcsr, sizeof(mxcsr), kbuf, ubuf))
 			return -EFAULT;
 
 		/* Reserved bits in MXCSR must be zero. */
 		if (mxcsr[0] & ~mxcsr_feature_mask)
 			return -EINVAL;
 
-		/* SSE and YMM require MXCSR even when FP is not in use. */
-		if (!(hdr.xfeatures & XFEATURE_MASK_FP)) {
-			xsave->i387.mxcsr = mxcsr[0];
-			xsave->i387.mxcsr_mask = mxcsr[1];
-		}
+		/*
+		 * Copy MXCSR regardless of the feature mask as userspace
+		 * uses the uncompacted format.
+		 */
+		fxsave->mxcsr = mxcsr[0];
+		fxsave->mxcsr_mask = mxcsr[1];
 	}
 
-	for (i = 0; i < XFEATURE_MAX; i++) {
-		mask = BIT_ULL(i);
+	if (hdr.xfeatures & XFEATURE_MASK_SSE) {
+		if (copy_from_buffer(fxsave->xmm_space, off_xmm, sizeof(fxsave->xmm_space),
+				     kbuf, ubuf))
+			return -EINVAL;
+	}
 
-		if (hdr.xfeatures & mask) {
-			void *dst = __raw_xsave_addr(xsave, i);
+	for_each_extended_xfeature(i, hdr.xfeatures) {
+		void *dst = __raw_xsave_addr(xsave, i);
 
-			offset = xstate_offsets[i];
-			size = xstate_sizes[i];
+		offset = xstate_offsets[i];
+		size = xstate_sizes[i];
 
-			if (copy_from_buffer(dst, offset, size, kbuf, ubuf))
-				return -EFAULT;
-		}
+		if (copy_from_buffer(dst, offset, size, kbuf, ubuf))
+			return -EFAULT;
 	}
 
 	/*
@@ -1256,6 +1277,13 @@ static int copy_uabi_to_xstate(struct fpstate *fpstate, const void *kbuf,
 	 * Add back in the features that came in from userspace:
 	 */
 	xsave->header.xfeatures |= hdr.xfeatures;
+	/*
+	 * Convert the SSE bit in the feature mask as it implies
+	 * differently between the formats. It indicates the MXCSR state
+	 * if compacted; otherwise, it pertains to XMM registers.
+	 */
+	if (compacted && fxsave->mxcsr != MXCSR_DEFAULT)
+		xsave->header.xfeatures |= XFEATURE_MASK_SSE;
 
 	return 0;
 }
-- 
2.17.1

