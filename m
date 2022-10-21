Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E92607EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJUTJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJUTJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:09:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EE92958F7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 12:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666379345; x=1697915345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=JdXVsKlxxVP86houWMspGMMBvXkZdMMfXbsJ/GqeSZY=;
  b=Yi2MwRl9VFPf6N7Iy3U6/tEfSmDkrsI+x8+6nGa4AztpRL5PF9rCKipg
   tNB0vBx5LmUG+3t3tNAjcdAyDI14RlVhzIwydvWuH8Kkqrk/uBSAZ2DYq
   K21CsW/UoLG4RMXjDX1pBKJ8ilHWXxhdKy1PsoFyVqi9fY6oX2+Vbb/bB
   0H4qD0b98KcrpcBYA89f1OB16EqA4LsaEoWRIM0/aNrGFNUL6ZiDFqH+O
   YhdHDXjsJCgTGHFW9VV1+oeXbTpeggXUdO+EL+w09nSjBw3i0+7Ac6y5C
   pFltJvLQzZYOCx7JijxFY+hWjzsCLf6ykO1occBL/AWdM+RQS+K+9peKA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369140049"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="369140049"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 12:09:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="693839478"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="693839478"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga008.fm.intel.com with ESMTP; 21 Oct 2022 12:09:04 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, yuan.yao@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH v2] x86/fpu: Fix copy_xstate_to_uabi() to copy init states correctly
Date:   Fri, 21 Oct 2022 11:58:44 -0700
Message-Id: <20221021185844.13472-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221018221349.4196-2-chang.seok.bae@intel.com>
References: <20221018221349.4196-2-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Tested-by: Yuan Yao <yuan.yao@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/lkml/BYAPR11MB3717EDEF2351C958F2C86EED95259@BYAPR11MB3717.namprd11.prod.outlook.com/
---
Change from v1:
* Adjust the 'mask' instead of the loop iteration code (Dave Hansen).

The context of this along with the init_fpstate fix was described in the v1
cover letter:
  https://lore.kernel.org/lkml/20221018221349.4196-1-chang.seok.bae@intel.com/
---
 arch/x86/kernel/fpu/xstate.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index e77cabfa802f..59e543b95a3c 100644
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
-- 
2.17.1

