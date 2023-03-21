Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A4F6C2660
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCUAf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCUAfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:35:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279F2BBB8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 17:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679358924; x=1710894924;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=541U4UtV3QlyfcTnxoIXC8ebj+SoFmzulWCbBJoBAkw=;
  b=Wapaxts4swYYzc8D3m5/QLAe9gCidJfFebH/JVxR7U+m47f9BJUPv1q/
   FTSjwy8qSS0EI8K74RfxIPxZn2PkH9gfoj5TZpqgVxPNFzNXUfP0KZoaC
   nOxglukGQBjITiGDKaqCRqKn2S3bleWRfF7OMArJTehvqtfcWLRpZ5OAU
   KSCu34eo1LxeLB2ukTlaHJXl5fBryw3+mrbDdFxUlSxFXBRPUrZFub2eH
   SocU80k1Sxlk4duSfuIXRcXCB+rwRmBYlLATj4XbQkViBtzQ6f71sk67z
   r+AGjXWBXamxVu321MuKjpHty0Fqk8LjWF0kZQAcGDWNy+0uQqmfTBfnd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="341170536"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="341170536"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 17:35:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="1010718718"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="1010718718"
Received: from cbellini-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.251.221.208])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 17:35:20 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E63A4109596; Tue, 21 Mar 2023 03:35:17 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     bp@alien8.de, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org
Cc:     linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de,
        x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH, REBASED] x86/tdx: Drop flags from __tdx_hypercall()
Date:   Tue, 21 Mar 2023 03:35:11 +0300
Message-Id: <20230321003511.9469-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After TDX_HCALL_ISSUE_STI got dropped, the only flag left is
TDX_HCALL_HAS_OUTPUT. The flag indicates if the caller wants to see
tdx_hypercall_args updated based on the hypercall output.

Drop the flags and provide __tdx_hypercall_ret() that matches
TDX_HCALL_HAS_OUTPUT semantics.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/boot/compressed/tdx.c    |  4 +-
 arch/x86/coco/tdx/tdcall.S        | 66 ++++++++++++++++++-------------
 arch/x86/coco/tdx/tdx.c           | 18 ++++-----
 arch/x86/include/asm/shared/tdx.h |  5 +--
 4 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 918a7606f53c..2d81d3cc72a1 100644
--- a/arch/x86/boot/compressed/tdx.c
+++ b/arch/x86/boot/compressed/tdx.c
@@ -26,7 +26,7 @@ static inline unsigned int tdx_io_in(int size, u16 port)
 		.r14 = port,
 	};
 
-	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
+	if (__tdx_hypercall_ret(&args))
 		return UINT_MAX;
 
 	return args.r11;
@@ -43,7 +43,7 @@ static inline void tdx_io_out(int size, u16 port, u32 value)
 		.r15 = value,
 	};
 
-	__tdx_hypercall(&args, 0);
+	__tdx_hypercall(&args);
 }
 
 static inline u8 tdx_inb(u16 port)
diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index 6a255e6809bc..b193c0a1d8db 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -85,12 +85,12 @@ SYM_FUNC_START(__tdx_module_call)
 SYM_FUNC_END(__tdx_module_call)
 
 /*
- * __tdx_hypercall() - Make hypercalls to a TDX VMM using TDVMCALL leaf
- * of TDCALL instruction
+ * TDX_HYPERCALL - Make hypercalls to a TDX VMM using TDVMCALL leaf of TDCALL
+ * instruction
  *
  * Transforms values in  function call argument struct tdx_hypercall_args @args
  * into the TDCALL register ABI. After TDCALL operation, VMM output is saved
- * back in @args.
+ * back in @args, if \ret is 1.
  *
  *-------------------------------------------------------------------------
  * TD VMCALL ABI:
@@ -105,26 +105,18 @@ SYM_FUNC_END(__tdx_module_call)
  *                       specification. Non zero value indicates vendor
  *                       specific ABI.
  * R11                 - VMCALL sub function number
- * RBX, RBP, RDI, RSI  - Used to pass VMCALL sub function specific arguments.
+ * RBX, RDX, RDI, RSI  - Used to pass VMCALL sub function specific arguments.
  * R8-R9, R12-R15      - Same as above.
  *
  * Output Registers:
  *
  * RAX                 - TDCALL instruction status (Not related to hypercall
  *                        output).
- * R10                 - Hypercall output error code.
- * R11-R15             - Hypercall sub function specific output values.
+ * RBX, RDX, RDI, RSI  - Hypercall sub function specific output values.
+ * R8-R15              - Same as above.
  *
- *-------------------------------------------------------------------------
- *
- * __tdx_hypercall() function ABI:
- *
- * @args  (RDI)        - struct tdx_hypercall_args for input and output
- * @flags (RSI)        - TDX_HCALL_* flags
- *
- * On successful completion, return the hypercall error code.
  */
-SYM_FUNC_START(__tdx_hypercall)
+.macro TDX_HYPERCALL ret:req
 	FRAME_BEGIN
 
 	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
@@ -134,9 +126,8 @@ SYM_FUNC_START(__tdx_hypercall)
 	push %r12
 	push %rbx
 
-	/* Free RDI and RSI to be used as TDVMCALL arguments */
+	/* Free RDI to be used as TDVMCALL arguments */
 	movq %rdi, %rax
-	push %rsi
 
 	/* Copy hypercall registers from arg struct: */
 	movq TDX_HYPERCALL_r8(%rax),  %r8
@@ -171,14 +162,11 @@ SYM_FUNC_START(__tdx_hypercall)
 	 * and are handled by callers.
 	 */
 	testq %rax, %rax
-	jne .Lpanic
+	jne .Lpanic\@
 
 	pop %rax
 
-	/* Copy hypercall result registers to arg struct if needed */
-	testq $TDX_HCALL_HAS_OUTPUT, (%rsp)
-	jz .Lout
-
+	.if \ret
 	movq %r8,  TDX_HYPERCALL_r8(%rax)
 	movq %r9,  TDX_HYPERCALL_r9(%rax)
 	movq %r10, TDX_HYPERCALL_r10(%rax)
@@ -191,7 +179,8 @@ SYM_FUNC_START(__tdx_hypercall)
 	movq %rsi, TDX_HYPERCALL_rsi(%rax)
 	movq %rbx, TDX_HYPERCALL_rbx(%rax)
 	movq %rdx, TDX_HYPERCALL_rdx(%rax)
-.Lout:
+	.endif
+
 	/* TDVMCALL leaf return code is in R10 */
 	movq %r10, %rax
 
@@ -208,9 +197,6 @@ SYM_FUNC_START(__tdx_hypercall)
 	xor %rdi,  %rdi
 	xor %rdx,  %rdx
 
-	/* Remove TDX_HCALL_* flags from the stack */
-	pop %rsi
-
 	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
 	pop %rbx
 	pop %r12
@@ -221,9 +207,33 @@ SYM_FUNC_START(__tdx_hypercall)
 	FRAME_END
 
 	RET
-.Lpanic:
+.Lpanic\@:
 	call __tdx_hypercall_failed
 	/* __tdx_hypercall_failed never returns */
 	REACHABLE
-	jmp .Lpanic
+	jmp .Lpanic\@
+.endm
+
+/*
+ *
+ * __tdx_hypercall() function ABI:
+ *
+ * @args  (RDI)        - struct tdx_hypercall_args for input
+ *
+ * On successful completion, return the hypercall error code.
+ */
+SYM_FUNC_START(__tdx_hypercall)
+	TDX_HYPERCALL ret=0
 SYM_FUNC_END(__tdx_hypercall)
+
+/*
+ *
+ * __tdx_hypercall_ret() function ABI:
+ *
+ * @args  (RDI)        - struct tdx_hypercall_args for input and output
+ *
+ * On successful completion, return the hypercall error code.
+ */
+SYM_FUNC_START(__tdx_hypercall_ret)
+	TDX_HYPERCALL ret=1
+SYM_FUNC_END(__tdx_hypercall_ret)
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 055300e08fb3..e146b599260f 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -66,7 +66,7 @@ static inline u64 _tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15)
 		.r15 = r15,
 	};
 
-	return __tdx_hypercall(&args, 0);
+	return __tdx_hypercall(&args);
 }
 
 /* Called from __tdx_hypercall() for unrecoverable failure */
@@ -99,7 +99,7 @@ long tdx_kvm_hypercall(unsigned int nr, unsigned long p1, unsigned long p2,
 		.r14 = p4,
 	};
 
-	return __tdx_hypercall(&args, 0);
+	return __tdx_hypercall(&args);
 }
 EXPORT_SYMBOL_GPL(tdx_kvm_hypercall);
 #endif
@@ -179,7 +179,7 @@ static void __noreturn tdx_panic(const char *msg)
 	 * happens to return.
 	 */
 	while (1)
-		__tdx_hypercall(&args, 0);
+		__tdx_hypercall(&args);
 }
 
 static void tdx_parse_tdinfo(u64 *cc_mask)
@@ -289,7 +289,7 @@ static u64 __cpuidle __halt(const bool irq_disabled)
 	 * can keep the vCPU in virtual HLT, even if an IRQ is
 	 * pending, without hanging/breaking the guest.
 	 */
-	return __tdx_hypercall(&args, 0);
+	return __tdx_hypercall(&args);
 }
 
 static int handle_halt(struct ve_info *ve)
@@ -326,7 +326,7 @@ static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 	 * can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI), section titled "TDG.VP.VMCALL<Instruction.RDMSR>".
 	 */
-	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
+	if (__tdx_hypercall_ret(&args))
 		return -EIO;
 
 	regs->ax = lower_32_bits(args.r11);
@@ -348,7 +348,7 @@ static int write_msr(struct pt_regs *regs, struct ve_info *ve)
 	 * can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI) section titled "TDG.VP.VMCALL<Instruction.WRMSR>".
 	 */
-	if (__tdx_hypercall(&args, 0))
+	if (__tdx_hypercall(&args))
 		return -EIO;
 
 	return ve_instr_len(ve);
@@ -380,7 +380,7 @@ static int handle_cpuid(struct pt_regs *regs, struct ve_info *ve)
 	 * ABI can be found in TDX Guest-Host-Communication Interface
 	 * (GHCI), section titled "VP.VMCALL<Instruction.CPUID>".
 	 */
-	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
+	if (__tdx_hypercall_ret(&args))
 		return -EIO;
 
 	/*
@@ -407,7 +407,7 @@ static bool mmio_read(int size, unsigned long addr, unsigned long *val)
 		.r15 = *val,
 	};
 
-	if (__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT))
+	if (__tdx_hypercall_ret(&args))
 		return false;
 	*val = args.r11;
 	return true;
@@ -541,7 +541,7 @@ static bool handle_in(struct pt_regs *regs, int size, int port)
 	 * in TDX Guest-Host-Communication Interface (GHCI) section titled
 	 * "TDG.VP.VMCALL<Instruction.IO>".
 	 */
-	success = !__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+	success = !__tdx_hypercall_ret(&args);
 
 	/* Update part of the register affected by the emulated instruction */
 	regs->ax &= ~mask;
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 4a03993e0785..2631e01f6e0f 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -7,8 +7,6 @@
 
 #define TDX_HYPERCALL_STANDARD  0
 
-#define TDX_HCALL_HAS_OUTPUT	BIT(0)
-
 #define TDX_CPUID_LEAF_ID	0x21
 #define TDX_IDENT		"IntelTDX    "
 
@@ -36,7 +34,8 @@ struct tdx_hypercall_args {
 };
 
 /* Used to request services from the VMM */
-u64 __tdx_hypercall(struct tdx_hypercall_args *args, unsigned long flags);
+u64 __tdx_hypercall(struct tdx_hypercall_args *args);
+u64 __tdx_hypercall_ret(struct tdx_hypercall_args *args);
 
 /* Called from __tdx_hypercall() for unrecoverable failure */
 void __tdx_hypercall_failed(void);
-- 
2.39.2

