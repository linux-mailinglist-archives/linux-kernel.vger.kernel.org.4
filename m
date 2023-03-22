Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CA96C5402
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjCVSrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjCVSrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:47:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000133FBBF;
        Wed, 22 Mar 2023 11:47:03 -0700 (PDT)
Date:   Wed, 22 Mar 2023 18:47:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679510821;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=orRDZYEpCWusGNjKZyrotkqv81Pm7TZ3tbx3cakZ/vk=;
        b=M2VE+dbsQiK+UGM6hBpp7Eh7vsnupQA/svxvu1vKKKXdJ4c8j141uxxwhtF9wZspcXuUwo
        k9QsMgreQuMky+vD9qiElT1hYZy4tBSZp6fUqVtNshqvbLZFsyS+i+qMnRiTXK4iLSRt9N
        1VeEkRXsTBrtD/1IMqEjaSzWBi4piuRB9EFkLYIHE8kpk/lN+xmNdy/Y+RRtVplvzTfa38
        90q72PxTTZV7+fgkbqCcuhPcUQllx0sC0yO1yFDBwiiZG1qcwiGju3s6hidtaqvt5PS9LF
        r/fArEctBJdChHDv4hFSdQaaAzuWRfCpAWioeP5QQgJyhoKi3dy7OVuP/LY/kQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679510821;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=orRDZYEpCWusGNjKZyrotkqv81Pm7TZ3tbx3cakZ/vk=;
        b=zjSN4xzCQvM74j0fshwSU/uqBVn+fjTG9Vc5bGeHF1pZD2Chr46gumrGjJncomrn/R35nM
        3xCWaMsRF3B2zwAQ==
From:   "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Drop flags from __tdx_hypercall()
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <167951082134.5837.2857157295741501011.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     7a3a401874bea02f568aa416ac29170d8cde0dc2
Gitweb:        https://git.kernel.org/tip/7a3a401874bea02f568aa416ac29170d8cde0dc2
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Tue, 21 Mar 2023 03:35:11 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 22 Mar 2023 11:36:05 -07:00

x86/tdx: Drop flags from __tdx_hypercall()

After TDX_HCALL_ISSUE_STI got dropped, the only flag left is
TDX_HCALL_HAS_OUTPUT. The flag indicates if the caller wants to see
tdx_hypercall_args updated based on the hypercall output.

Drop the flags and provide __tdx_hypercall_ret() that matches
TDX_HCALL_HAS_OUTPUT semantics.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20230321003511.9469-1-kirill.shutemov%40linux.intel.com
---
 arch/x86/boot/compressed/tdx.c    |  4 +-
 arch/x86/coco/tdx/tdcall.S        | 66 +++++++++++++++++-------------
 arch/x86/coco/tdx/tdx.c           | 18 ++++----
 arch/x86/include/asm/shared/tdx.h |  5 +--
 4 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/arch/x86/boot/compressed/tdx.c b/arch/x86/boot/compressed/tdx.c
index 918a760..2d81d3c 100644
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
index 6a255e6..b193c0a 100644
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
index 055300e..e146b59 100644
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
index 4a03993..2631e01 100644
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
