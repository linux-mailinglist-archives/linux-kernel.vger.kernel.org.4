Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFF769EBDB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjBVARL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBVARI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:17:08 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453B9305C1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 16:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677025027; x=1708561027;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ir0hsEIH89zQL2BTvDlYGoS1WFfBwOYehEGIYJVMwdc=;
  b=KyGSgg1uKGq7bXnlD3yntFK296gY+ijTwSiVuJtZZU+Zr3OEJuKX3QZd
   6TUpGK4xc4ZVtAW/TKhKDWRh2+RZQ/sRyyGpu6rAR/vFNAHiz+8OPPwkT
   s+nfxG4u/KJA4k2pqQQNNvFrzW8e/+pdkI11aennKrV0Ydphy7SM6wO9D
   ARnMiJ7VLasF2eKV9g7TVknepda1IKR7AAmYtisUqTyOHkJDoDc2ZEL9M
   2i4RRvaCSDctv9zIxxEit2LLyelJUb+tIFdudThXMPg3w07Jds9B08zF+
   e9RvcY6VXztKaWrFwA++ukzPkx3vwjW6LqlrgFuO9tmRUjFc72qtvrTzh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="397482954"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="397482954"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 16:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="665158507"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="665158507"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2023 16:17:06 -0800
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     torvalds@linux-foundation.org
Cc:     kirill.shutemov@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [GIT PULL] x86/tdx for 6.3
Date:   Tue, 21 Feb 2023 16:16:36 -0800
Message-Id: <20230222001636.211793-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some x86/tdx changes for 6.3.  Other than a minor fixup,
the content here is to ensure that TDX guests never see virtualization
exceptions (#VE's) that might be induced by the untrusted VMM.

This is a highly desirable property.  Without it, #VE exception
handling would fall somewhere between NMIs, machine checks and
total insanity.  With it, #VE handling remains pretty mundane.

There is a conflict here with some cleanups which you already pulled
via tip:sched/core.  I've appended a conflict resolution from Ingo
that he used when merging these all together in tip/master.

--

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_tdx_for_6.3

for you to fetch changes up to 1e70c680375aa33cca97bff0bca68c0f82f5023c:

  x86/tdx: Do not corrupt frame-pointer in __tdx_hypercall() (2023-02-02 16:31:25 -0800)

----------------------------------------------------------------
 - Fixup comment typo
 - Prevent unexpected #VE's from:
  - Hosts removing perfectly good guest mappings (SEPT_VE_DISABLE
  - Excessive #VE notifications (NOTIFY_ENABLES) which are
    delivered via a #VE.

----------------------------------------------------------------
Kirill A. Shutemov (8):
      x86/tdx: Fix typo in comment in __tdx_hypercall()
      x86/tdx: Add more registers to struct tdx_hypercall_args
      x86/tdx: Refactor __tdx_hypercall() to allow pass down more arguments
      x86/tdx: Expand __tdx_hypercall() to handle more arguments
      x86/tdx: Use ReportFatalError to report missing SEPT_VE_DISABLE
      x86/tdx: Relax SEPT_VE_DISABLE check for debug TD
      x86/tdx: Disable NOTIFY_ENABLES
      x86/tdx: Do not corrupt frame-pointer in __tdx_hypercall()

 arch/x86/coco/tdx/tdcall.S        | 83 ++++++++++++++++++++++++++++-----------
 arch/x86/coco/tdx/tdx.c           | 62 ++++++++++++++++++++++++++++-
 arch/x86/include/asm/shared/tdx.h |  6 +++
 arch/x86/kernel/asm-offsets.c     |  6 +++
 4 files changed, 131 insertions(+), 26 deletions(-)
--

Author: Ingo Molnar <mingo@kernel.org>
Date:   Tue Feb 21 09:30:27 2023 +0100

    Merge branch 'x86/tdx'
    
    Conflicts:
            arch/x86/coco/tdx/tdcall.S
    
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --cc arch/x86/coco/tdx/tdcall.S
index ad0d51f03cb4,2bd436a4790d..6a255e6809bc
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@@ -27,12 -33,10 +33,12 @@@
   * details can be found in TDX GHCI specification, section
   * titled "TDCALL [TDG.VP.VMCALL] leaf".
   */
- #define TDVMCALL_EXPOSE_REGS_MASK	( TDX_R10 | TDX_R11 | \
- 					  TDX_R12 | TDX_R13 | \
- 					  TDX_R14 | TDX_R15 )
+ #define TDVMCALL_EXPOSE_REGS_MASK	\
+ 	( TDX_RDX | TDX_RBX | TDX_RSI | TDX_RDI | TDX_R8  | TDX_R9  | \
+ 	  TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15 )
  
 +.section .noinstr.text, "ax"
 +
  /*
   * __tdx_module_call()  - Used by TDX guests to request services from
   * the TDX module (does not include VMM services) using TDCALL instruction.
@@@ -131,16 -156,21 +158,8 @@@ SYM_FUNC_START(__tdx_hypercall
  	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
  	xor %eax, %eax
  
- 	/* Copy hypercall registers from arg struct: */
- 	movq TDX_HYPERCALL_r10(%rdi), %r10
- 	movq TDX_HYPERCALL_r11(%rdi), %r11
- 	movq TDX_HYPERCALL_r12(%rdi), %r12
- 	movq TDX_HYPERCALL_r13(%rdi), %r13
- 	movq TDX_HYPERCALL_r14(%rdi), %r14
- 	movq TDX_HYPERCALL_r15(%rdi), %r15
- 
  	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
  
 -	/*
 -	 * For the idle loop STI needs to be called directly before the TDCALL
 -	 * that enters idle (EXIT_REASON_HLT case). STI instruction enables
 -	 * interrupts only one instruction later. If there is a window between
 -	 * STI and the instruction that emulates the HALT state, there is a
 -	 * chance for interrupts to happen in this window, which can delay the
 -	 * HLT operation indefinitely. Since this is the not the desired
 -	 * result, conditionally call STI before TDCALL.
 -	 */
 -	testq $TDX_HCALL_ISSUE_STI, 8(%rsp)
 -	jz .Lskip_sti
 -	sti
 -.Lskip_sti:
  	tdcall
  
  	/*
