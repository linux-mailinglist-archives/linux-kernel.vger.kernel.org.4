Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B146714307
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 06:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjE2E2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 00:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjE2E11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 00:27:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D52CDA;
        Sun, 28 May 2023 21:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685334271; x=1716870271;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V0xFNmsgSLaC4LEeeeVRVq6pgwLAsX5npCXwP9cZLts=;
  b=OvK3oQfDrb7P+0TFlKoPdJyPGnUOAeYF1XN3UPOWceTp1HojXhiOulDD
   9AiDPbUxe1ij3HNWbvdxv3g7ZOT1qMp3+kUX81Tg1mhvtKwSUmEKXYeXk
   Dxq0KTgMZxIkO/3jc8oG+TMMCLOVAM4YPdK7Kce5KSXAMZatE5qnyVkW1
   q5pCymi5UO4HutCMjwFhNEWLS4vWruJZJlT/I9Mx1DNs4AirG+MxKt0im
   Q+832oXEkmSjnNNV2I68vChD80ADQSK5uZoJl/7MPN61DBbXxRs3ci/27
   GnGnGr2QdS2/MzmJd08B46pwWqdXckUi9Bs/PRNOFVO2qikZAK6lJF5du
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="334966104"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="334966104"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 21:21:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="775784390"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; 
   d="scan'208";a="775784390"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2023 21:21:23 -0700
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com
Subject: [PATCH v14 062/113] KVM: TDX: Add helper assembly function to TDX vcpu
Date:   Sun, 28 May 2023 21:19:44 -0700
Message-Id: <bdaf2ee52653e2a46c5b98a10f3e2928dd7b2572.1685333728.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685333727.git.isaku.yamahata@intel.com>
References: <cover.1685333727.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

TDX defines an API to run TDX vcpu with its own ABI.  Define an assembly
helper function to run TDX vcpu to hide the special ABI so that C code can
call it with function call ABI.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 arch/x86/include/asm/tdx.h |   3 +-
 arch/x86/kvm/vmx/vmenter.S | 156 +++++++++++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 97492b69e93f..d2d41bc452fd 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -16,7 +16,8 @@
  * Bits 47:40 == 0xFF indicate Reserved status code class that never used by
  * TDX module.
  */
-#define TDX_ERROR			_BITUL(63)
+#define TDX_ERROR_BIT			63
+#define TDX_ERROR			_BITUL(TDX_ERROR_BIT)
 #define TDX_SW_ERROR			(TDX_ERROR | GENMASK_ULL(47, 40))
 #define TDX_SEAMCALL_VMFAILINVALID	(TDX_SW_ERROR | _UL(0xFFFF0000))
 
diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
index 631fd7da2bc3..ae93a576e934 100644
--- a/arch/x86/kvm/vmx/vmenter.S
+++ b/arch/x86/kvm/vmx/vmenter.S
@@ -6,6 +6,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/percpu.h>
 #include <asm/segment.h>
+#include <asm/tdx.h>
 #include "kvm-asm-offsets.h"
 #include "run_flags.h"
 
@@ -31,6 +32,12 @@
 #define VCPU_R15	__VCPU_REGS_R15 * WORD_SIZE
 #endif
 
+#ifdef CONFIG_INTEL_TDX_HOST
+#define TDH_VP_ENTER		0
+#define EXIT_REASON_TDCALL	77
+#define seamcall		.byte 0x66,0x0f,0x01,0xcf
+#endif
+
 .macro VMX_DO_EVENT_IRQOFF call_insn call_target
 	/*
 	 * Unconditionally create a stack frame, getting the correct RSP on the
@@ -360,3 +367,152 @@ SYM_FUNC_END(vmread_error_trampoline)
 SYM_FUNC_START(vmx_do_interrupt_irqoff)
 	VMX_DO_EVENT_IRQOFF CALL_NOSPEC _ASM_ARG1
 SYM_FUNC_END(vmx_do_interrupt_irqoff)
+
+#ifdef CONFIG_INTEL_TDX_HOST
+
+.pushsection .noinstr.text, "ax"
+
+/**
+ * __tdx_vcpu_run - Call SEAMCALL(TDH_VP_ENTER) to run a TD vcpu
+ * @tdvpr:	physical address of TDVPR
+ * @regs:	void * (to registers of TDVCPU)
+ * @gpr_mask:	non-zero if guest registers need to be loaded prior to TDH_VP_ENTER
+ *
+ * Returns:
+ *	TD-Exit Reason
+ *
+ * Note: KVM doesn't support using XMM in its hypercalls, it's the HyperV
+ *	 code's responsibility to save/restore XMM registers on TDVMCALL.
+ */
+SYM_FUNC_START(__tdx_vcpu_run)
+	push %rbp
+	mov  %rsp, %rbp
+
+	push %r15
+	push %r14
+	push %r13
+	push %r12
+	push %rbx
+
+	/* Save @regs, which is needed after TDH_VP_ENTER to capture output. */
+	push %rsi
+
+	/* Load @tdvpr to RCX */
+	mov %rdi, %rcx
+
+	/* No need to load guest GPRs if the last exit wasn't a TDVMCALL. */
+	test %dx, %dx
+	je 1f
+
+	/* Load @regs to RAX, which will be clobbered with $TDH_VP_ENTER anyways. */
+	mov %rsi, %rax
+
+	mov VCPU_RBX(%rax), %rbx
+	mov VCPU_RDX(%rax), %rdx
+	mov VCPU_RBP(%rax), %rbp
+	mov VCPU_RSI(%rax), %rsi
+	mov VCPU_RDI(%rax), %rdi
+
+	mov VCPU_R8 (%rax),  %r8
+	mov VCPU_R9 (%rax),  %r9
+	mov VCPU_R10(%rax), %r10
+	mov VCPU_R11(%rax), %r11
+	mov VCPU_R12(%rax), %r12
+	mov VCPU_R13(%rax), %r13
+	mov VCPU_R14(%rax), %r14
+	mov VCPU_R15(%rax), %r15
+
+	/*  Load TDH_VP_ENTER to RAX.  This kills the @regs pointer! */
+1:	mov $TDH_VP_ENTER, %rax
+
+2:	seamcall
+
+	/*
+	 * Use same return value convention to tdxcall.S.
+	 * TDX_SEAMCALL_VMFAILINVALID doesn't conflict with any TDX status code.
+	 */
+	jnc 3f
+	mov $TDX_SEAMCALL_VMFAILINVALID, %rax
+	jmp 5f
+3:
+
+	/* Skip to the exit path if TDH_VP_ENTER failed. */
+	bt $TDX_ERROR_BIT, %rax
+	jc 5f
+
+	/* Temporarily save the TD-Exit reason. */
+	push %rax
+
+	/* check if TD-exit due to TDVMCALL */
+	cmp $EXIT_REASON_TDCALL, %ax
+
+	/* Reload @regs to RAX. */
+	mov 8(%rsp), %rax
+
+	/* Jump on non-TDVMCALL */
+	jne 4f
+
+	/* Save all output from SEAMCALL(TDH_VP_ENTER) */
+	mov %rbx, VCPU_RBX(%rax)
+	mov %rbp, VCPU_RBP(%rax)
+	mov %rsi, VCPU_RSI(%rax)
+	mov %rdi, VCPU_RDI(%rax)
+	mov %r10, VCPU_R10(%rax)
+	mov %r11, VCPU_R11(%rax)
+	mov %r12, VCPU_R12(%rax)
+	mov %r13, VCPU_R13(%rax)
+	mov %r14, VCPU_R14(%rax)
+	mov %r15, VCPU_R15(%rax)
+
+4:	mov %rcx, VCPU_RCX(%rax)
+	mov %rdx, VCPU_RDX(%rax)
+	mov %r8,  VCPU_R8 (%rax)
+	mov %r9,  VCPU_R9 (%rax)
+
+	/*
+	 * Clear all general purpose registers except RSP and RAX to prevent
+	 * speculative use of the guest's values.
+	 */
+	xor %rbx, %rbx
+	xor %rcx, %rcx
+	xor %rdx, %rdx
+	xor %rsi, %rsi
+	xor %rdi, %rdi
+	xor %rbp, %rbp
+	xor %r8,  %r8
+	xor %r9,  %r9
+	xor %r10, %r10
+	xor %r11, %r11
+	xor %r12, %r12
+	xor %r13, %r13
+	xor %r14, %r14
+	xor %r15, %r15
+
+	/* Restore the TD-Exit reason to RAX for return. */
+	pop %rax
+
+	/* "POP" @regs. */
+5:	add $8, %rsp
+	pop %rbx
+	pop %r12
+	pop %r13
+	pop %r14
+	pop %r15
+
+	pop %rbp
+	RET
+
+6:	cmpb $0, kvm_rebooting
+	je 1f
+	mov $TDX_SW_ERROR, %r12
+	orq %r12, %rax
+	jmp 5b
+1:	ud2
+	/* Use FAULT version to know what fault happened. */
+	_ASM_EXTABLE_FAULT(2b, 6b)
+
+SYM_FUNC_END(__tdx_vcpu_run)
+
+.popsection
+
+#endif
-- 
2.25.1

