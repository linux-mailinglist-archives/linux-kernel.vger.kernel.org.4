Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9AD608174
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJUWZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJUWZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:25:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDD1140E68;
        Fri, 21 Oct 2022 15:25:23 -0700 (PDT)
Date:   Fri, 21 Oct 2022 22:25:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666391120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mC43962uVKGAlF97kVQ/2Yk+2veweV1Yl78IBTeen9U=;
        b=f6WkOOu7gGMTSYbG3IiWWK8UBoeaSVZiAX6nlhBzUy0h40cuay6eAwnNNwqjHB/Tgt54X6
        HdCr+LKPCxZqxyvPsOUuCJP7l+DNVq/eC4f21CqWX6or33FpHhtBVI5wn1u4BsoVg3u8Nn
        N5c/fMvwvErjZUKSpii2snPTyjxIhGVIcWKDI7e9CBlXAlEYxnxgEl3rCwkC+9StxSeh/J
        tXYbjJwch7Of2dscXIp0K4sfCMjMi8+2qoDHlS4hrms5ErMH5mRWDeXsDAQsO2EDAPqGKI
        x1SKSsV+u3cLMJbQfokvM8ZYZ4SaesW2ujwkgjz8zaWUBEaCGI4t9eBCsITdqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666391120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mC43962uVKGAlF97kVQ/2Yk+2veweV1Yl78IBTeen9U=;
        b=GEPauoEcTc61qc8UBuJyq8IU7IIRYJ5lwjpk58pdOPMj34hS3BWQx32cU6gNy6UB2AxQFv
        qaR3SwJkLsyIzsAQ==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/fpu: Fix copy_xstate_to_uabi() to copy init
 states correctly
Cc:     Yuan Yao <yuan.yao@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221021185844.13472-1-chang.seok.bae@intel.com>
References: <20221021185844.13472-1-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <166639111821.401.9381657733834636095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     471f0aa7fa64e23766a1473b32d9ec3f0718895a
Gitweb:        https://git.kernel.org/tip/471f0aa7fa64e23766a1473b32d9ec3f0718895a
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Fri, 21 Oct 2022 11:58:44 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 21 Oct 2022 15:22:09 -07:00

x86/fpu: Fix copy_xstate_to_uabi() to copy init states correctly

When an extended state component is not present in fpstate, but in init
state, the function copies from init_fpstate via copy_feature().

But, dynamic states are not present in init_fpstate because of all-zeros
init states. Then retrieving them from init_fpstate will explode like this:

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 ...
 RIP: 0010:memcpy_erms+0x6/0x10
  ? __copy_xstate_to_uabi_buf+0x381/0x870
  fpu_copy_guest_fpstate_to_uabi+0x28/0x80
  kvm_arch_vcpu_ioctl+0x14c/0x1460 [kvm]
  ? __this_cpu_preempt_check+0x13/0x20
  ? vmx_vcpu_put+0x2e/0x260 [kvm_intel]
  kvm_vcpu_ioctl+0xea/0x6b0 [kvm]
  ? kvm_vcpu_ioctl+0xea/0x6b0 [kvm]
  ? __fget_light+0xd4/0x130
  __x64_sys_ioctl+0xe3/0x910
  ? debug_smp_processor_id+0x17/0x20
  ? fpregs_assert_state_consistent+0x27/0x50
  do_syscall_64+0x3f/0x90
  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Adjust the 'mask' to zero out the userspace buffer for the features that
are not available both from fpstate and from init_fpstate.

The dynamic features depend on the compacted XSAVE format. Ensure it is
enabled before reading XCOMP_BV in init_fpstate.

Fixes: 2308ee57d93d ("x86/fpu/amx: Enable the AMX feature in 64-bit mode")
Reported-by: Yuan Yao <yuan.yao@intel.com>
Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Yuan Yao <yuan.yao@intel.com>
Link: https://lore.kernel.org/lkml/BYAPR11MB3717EDEF2351C958F2C86EED95259@BYAPR11MB3717.namprd11.prod.outlook.com/
Link: https://lkml.kernel.org/r/20221021185844.13472-1-chang.seok.bae@intel.com
---
 arch/x86/kernel/fpu/xstate.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index e77cabf..59e543b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1125,6 +1125,15 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 	 */
 	mask = fpstate->user_xfeatures;
 
+	/*
+	 * Dynamic features are not present in init_fpstate. When they are
+	 * in an all zeros init state, remove those from 'mask' to zero
+	 * those features in the user buffer instead of retrieving them
+	 * from init_fpstate.
+	 */
+	if (fpu_state_size_dynamic())
+		mask &= (header.xfeatures | xinit->header.xcomp_bv);
+
 	for_each_extended_xfeature(i, mask) {
 		/*
 		 * If there was a feature or alignment gap, zero the space
