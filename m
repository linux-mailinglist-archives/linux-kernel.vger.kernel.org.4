Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036E86C532E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjCVSBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjCVSBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:01:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9578561891;
        Wed, 22 Mar 2023 11:01:29 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:01:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679508088;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=g2/kLf12zsmjkGo2fuYgRRQLmW0ehWIkkORiB8/GozQ=;
        b=se9R3i7Ca4EoQoiPEbWwU5GlYcEbXoDpZHrXzLo6ESBs/lc4JHdzphv/3dPhhRmivjPt18
        WPNzkKj/85j7UV9PxYR5pe1tI5pFYnoiPA5HBvrBmDOAazPOEUz26zQ9/LOSvXGef+EbOR
        v1BSAPPERjWPRT0zl+G4Sw5YO4SA/57gpmdno6WEtIrITWtJplIcTp9i+o5AP4CUhvXGJG
        HkqI7Ouu4Nqi7iSdNwYAOSJDjbuTifsG2u6VSi7VpGQjE4apQ9aSUEdBwryrpO3emokmm9
        Npy+lHVUwL0rwEWFZVHQmguqiel2Swyu6HpjCtFxOH7EYIIh1lfgMJ1VRMNUgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679508088;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=g2/kLf12zsmjkGo2fuYgRRQLmW0ehWIkkORiB8/GozQ=;
        b=HmByTlx9UFkb1bRKGWz5eqwNgtWzbvgxoyi0C0mf7rv6sUWCA5jYonprsmiHz9BSi0tyZq
        2fUAeVRrDRZkadCw==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu/xstate: Prevent false-positive warning in
 __copy_xstate_uabi_buf()
Cc:     Mingwei Zhang <mizhang@google.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167950808781.5837.16341412203285253820.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     736a40b528614c7f731a7e549ccfaed6ac3a6333
Gitweb:        https://git.kernel.org/tip/736a40b528614c7f731a7e549ccfaed6ac3a6333
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Mon, 27 Feb 2023 13:05:03 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 22 Mar 2023 10:57:17 -07:00

x86/fpu/xstate: Prevent false-positive warning in __copy_xstate_uabi_buf()

__copy_xstate_to_uabi_buf() copies either from the tasks XSAVE buffer
or from init_fpstate into the ptrace buffer. Dynamic features, like
XTILEDATA, have an all zeroes init state and are not saved in
init_fpstate, which means the corresponding bit is not set in the
xfeatures bitmap of the init_fpstate header.

But __copy_xstate_to_uabi_buf() retrieves addresses for both the tasks
xstate and init_fpstate unconditionally via __raw_xsave_addr().

So if the tasks XSAVE buffer has a dynamic feature set, then the
address retrieval for init_fpstate triggers the warning in
__raw_xsave_addr() which checks the feature bit in the init_fpstate
header.

Remove the address retrieval from init_fpstate for extended features.
They have an all zeroes init state so init_fpstate has zeros for them.
Then zeroing the user buffer for the init state is the same as copying
them from init_fpstate.

Fixes: 2308ee57d93d ("x86/fpu/amx: Enable the AMX feature in 64-bit mode")
Reported-by: Mingwei Zhang <mizhang@google.com>
Link: https://lore.kernel.org/kvm/20230221163655.920289-2-mizhang@google.com/
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Mingwei Zhang <mizhang@google.com>
Link: https://lore.kernel.org/all/20230227210504.18520-2-chang.seok.bae%40intel.com
---
 arch/x86/kernel/fpu/xstate.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 714166c..0bab497 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1118,21 +1118,20 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 	zerofrom = offsetof(struct xregs_state, extended_state_area);
 
 	/*
-	 * The ptrace buffer is in non-compacted XSAVE format.  In
-	 * non-compacted format disabled features still occupy state space,
-	 * but there is no state to copy from in the compacted
-	 * init_fpstate. The gap tracking will zero these states.
-	 */
-	mask = fpstate->user_xfeatures;
-
-	/*
-	 * Dynamic features are not present in init_fpstate. When they are
-	 * in an all zeros init state, remove those from 'mask' to zero
-	 * those features in the user buffer instead of retrieving them
-	 * from init_fpstate.
+	 * This 'mask' indicates which states to copy from fpstate.
+	 * Those extended states that are not present in fpstate are
+	 * either disabled or initialized:
+	 *
+	 * In non-compacted format, disabled features still occupy
+	 * state space but there is no state to copy from in the
+	 * compacted init_fpstate. The gap tracking will zero these
+	 * states.
+	 *
+	 * The extended features have an all zeroes init state. Thus,
+	 * remove them from 'mask' to zero those features in the user
+	 * buffer instead of retrieving them from init_fpstate.
 	 */
-	if (fpu_state_size_dynamic())
-		mask &= (header.xfeatures | xinit->header.xcomp_bv);
+	mask = header.xfeatures;
 
 	for_each_extended_xfeature(i, mask) {
 		/*
@@ -1151,9 +1150,8 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 			pkru.pkru = pkru_val;
 			membuf_write(&to, &pkru, sizeof(pkru));
 		} else {
-			copy_feature(header.xfeatures & BIT_ULL(i), &to,
+			membuf_write(&to,
 				     __raw_xsave_addr(xsave, i),
-				     __raw_xsave_addr(xinit, i),
 				     xstate_sizes[i]);
 		}
 		/*
