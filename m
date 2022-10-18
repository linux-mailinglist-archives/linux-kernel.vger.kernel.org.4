Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18826035D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 00:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJRWYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 18:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJRWYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 18:24:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53593B5160
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 15:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666131849; x=1697667849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=zFu8kdh1AJjPdS6IUdrA9kk3zAfabiMarV67lFLQNUw=;
  b=YYXbvuiLwI6XSvN9nv08q0XyNmcV2xaxD8lB8X1335Xsm/07yh0mqUTt
   fsBRjZqh+koT69pJWPmJSVHi17YtOs1UctqGtd08jm3L5qPDI2i8XkPDy
   XgQsuIGQb1PtmBOn2by7SklKbvfxWSbl9v3zxGgCGpB3OFlh0BQcSn7rV
   zDAxUeagaQLj4pgfWiV/vc219LwPF3G1Ock6oEhDfGX1dWklVE2d1mrmK
   KlZj74VtFVgrtAxfs1aSxZEh36Tf/lAcCIC4RMbU+pl9ZQxMyDyxAiVdT
   jl4dMBUyI80Ef4ZOrz3/Re1d32+9BP4YjNnrt4ys/MHhoWoGjPvTytAv4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="304984894"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="304984894"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 15:24:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="623834773"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="623834773"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga007.jf.intel.com with ESMTP; 18 Oct 2022 15:24:08 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, yuan.yao@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH 1/1] x86/fpu: Fix copy_xstate_to_uabi() to copy init states correctly
Date:   Tue, 18 Oct 2022 15:13:49 -0700
Message-Id: <20221018221349.4196-2-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221018221349.4196-1-chang.seok.bae@intel.com>
References: <20220824191223.1248-1-chang.seok.bae@intel.com>
 <20221018221349.4196-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an extended state component is present in fpstate, but in init state,
the function copies from init_fpstate via copy_feature().

But, dynamic states are not present in init_fpstate. Then accessing
init_fpstate for those will explode like this:

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

Instead of referencing init_fpstate, simply zero out the userspace buffer
for the state component in an all-zeros init state.

Fixes: 2308ee57d93d ("x86/fpu/amx: Enable the AMX feature in 64-bit mode")
Reported-by: Yuan Yao <yuan.yao@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Yuan Yao <yuan.yao@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/lkml/BYAPR11MB3717EDEF2351C958F2C86EED95259@BYAPR11MB3717.namprd11.prod.outlook.com/
---
 arch/x86/kernel/fpu/xstate.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index e77cabfa802f..efa9e3a269fc 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1141,10 +1141,14 @@ void __copy_xstate_to_uabi_buf(struct membuf to, struct fpstate *fpstate,
 			 */
 			pkru.pkru = pkru_val;
 			membuf_write(&to, &pkru, sizeof(pkru));
+		} else if (!(header.xfeatures & BIT_ULL(i))) {
+			/*
+			 * Every extended state component has an all zeros
+			 * init state.
+			 */
+			membuf_zero(&to, xstate_sizes[i]);
 		} else {
-			copy_feature(header.xfeatures & BIT_ULL(i), &to,
-				     __raw_xsave_addr(xsave, i),
-				     __raw_xsave_addr(xinit, i),
+			membuf_write(&to, __raw_xsave_addr(xsave, i),
 				     xstate_sizes[i]);
 		}
 		/*
-- 
2.17.1

