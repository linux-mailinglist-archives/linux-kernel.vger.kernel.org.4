Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D69F709F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjESStL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjESStJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:49:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1361700;
        Fri, 19 May 2023 11:48:51 -0700 (PDT)
Date:   Fri, 19 May 2023 20:48:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684522129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=yMtivqkUAqqnsZXk4VtbvoP9i8FMY2mtgw5ZmhJ+e1U=;
        b=q2TDypQB+zD+jySiOP4cMCby8ICAQsGn4ARtsV/Ulfbu1p7smP2x1elBGyBZC6+cu0rHy+
        ShkKz+YE9CRIKsFR95s47fJPi1KeMDGOjRSMdQavoITVYlUD0GIAhBpONdqvuk2ZRU2dwc
        CfdyBnjoQjWGTLjZjgcaGwuNEzlA0faKn+cRxf8ILKBkXWwBoYb6mbAiLZn21JVALFsFdy
        gLhJubdfgMZ5t/0lqK6QMUqPnzd5Flf5UQHMzly6Kvdzpku75sPE/ZcZtPi6lr5qqTQ7KG
        Hpl0K18nwRxIWYHwKk2YSr9QYHYsI5mbJqN7m4xJkQE3acrl2NknyQtqkbko1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684522129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=yMtivqkUAqqnsZXk4VtbvoP9i8FMY2mtgw5ZmhJ+e1U=;
        b=vTXKaDfpO2upBex8PctZRhtK8JaLtMW9ezc0pHJ+VI8AEouP+uq47X7ov7dwxWP3K5v1lN
        kvRgQMVgLrofZIBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.3.3-rt15
Message-ID: <20230519184848.JLp18ErY@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.3.3-rt15 patch set. 

Changes since v6.3.3-rt14:

  - Pavel Pisa reported a problem on Xilinx Zynq (ARM). While looking at
    the backtrace, bad VFP handling was identified which was introduced
    in v6.3 cycle. A few patches were backported and extended to
    address the the VFP problem.

Known issues
     None

The delta patch against v6.3.3-rt14 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/incr/patch-6.3.3-rt14-rt15.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.3.3-rt15

The RT patch against v6.3.3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/older/patch-6.3.3-rt15.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.3/older/patches-6.3.3-rt15.tar.xz

Sebastian

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 06b48ce23e1ca..505a306e0271a 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -244,19 +244,6 @@ THUMB(	fpreg	.req	r7	)
 	.endm
 #endif
 
-	.macro	local_bh_disable, ti, tmp
-	ldr	\tmp, [\ti, #TI_PREEMPT]
-	add	\tmp, \tmp, #SOFTIRQ_DISABLE_OFFSET
-	str	\tmp, [\ti, #TI_PREEMPT]
-	.endm
-
-	.macro	local_bh_enable_ti, ti, tmp
-	get_thread_info \ti
-	ldr	\tmp, [\ti, #TI_PREEMPT]
-	sub	\tmp, \tmp, #SOFTIRQ_DISABLE_OFFSET
-	str	\tmp, [\ti, #TI_PREEMPT]
-	.endm
-
 #define USERL(l, x...)				\
 9999:	x;					\
 	.pushsection __ex_table,"a";		\
diff --git a/arch/arm/vfp/entry.S b/arch/arm/vfp/entry.S
index 6dabb47617781..62206ef250371 100644
--- a/arch/arm/vfp/entry.S
+++ b/arch/arm/vfp/entry.S
@@ -23,15 +23,9 @@
 @
 ENTRY(do_vfp)
 	mov	r1, r10
-	mov	r3, r9
- 	ldr	r4, .LCvfp
-	ldr	pc, [r4]		@ call VFP entry point
+	str	lr, [sp, #-8]!
+	add	r3, sp, #4
+	str	r9, [r3]
+	bl	vfp_entry
+	ldr	pc, [sp], #8
 ENDPROC(do_vfp)
-
-ENTRY(vfp_null_entry)
-	ret	lr
-ENDPROC(vfp_null_entry)
-
-	.align	2
-.LCvfp:
-	.word	vfp_vector
diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
index 60acd42e05786..860512042bc21 100644
--- a/arch/arm/vfp/vfphw.S
+++ b/arch/arm/vfp/vfphw.S
@@ -75,8 +75,6 @@
 @  lr  = unrecognised instruction return address
 @  IRQs enabled.
 ENTRY(vfp_support_entry)
-	local_bh_disable r1, r4
-
 	ldr	r11, [r1, #TI_CPU]	@ CPU number
 	add	r10, r1, #TI_VFPSTATE	@ r10 = workspace
 
@@ -174,14 +172,15 @@ ENTRY(vfp_support_entry)
 					@ out before setting an FPEXC that
 					@ stops us reading stuff
 	VFPFMXR	FPEXC, r1		@ Restore FPEXC last
+	mov	sp, r3			@ we think we have handled things
+	pop	{lr}
 	sub	r2, r2, #4		@ Retry current instruction - if Thumb
 	str	r2, [sp, #S_PC]		@ mode it's two 16-bit instructions,
 					@ else it's one 32-bit instruction, so
 					@ always subtract 4 from the following
 					@ instruction address.
-	local_bh_enable_ti r10, r4
-	ret	r3			@ we think we have handled things
 
+	b	vfp_exit	@ tail call
 
 look_for_VFP_exceptions:
 	@ Check for synchronous or asynchronous exception
@@ -204,13 +203,13 @@ ENTRY(vfp_support_entry)
 	@ not recognised by VFP
 
 	DBGSTR	"not VFP"
-	local_bh_enable_ti r10, r4
-	ret	lr
+	b	vfp_exit	@ tail call
 
 process_exception:
 	DBGSTR	"bounce"
+	mov	sp, r3			@ setup for a return to the user code.
+	pop	{lr}
 	mov	r2, sp			@ nothing stacked - regdump is at TOS
-	mov	lr, r3			@ setup for a return to the user code.
 
 	@ Now call the C code to package up the bounce to the support code
 	@   r0 holds the trigger instruction
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 01bc48d738478..a2745d17e9c71 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -32,10 +32,9 @@
 /*
  * Our undef handlers (in entry.S)
  */
-asmlinkage void vfp_support_entry(void);
-asmlinkage void vfp_null_entry(void);
+asmlinkage void vfp_support_entry(u32, void *, u32, u32);
 
-asmlinkage void (*vfp_vector)(void) = vfp_null_entry;
+static bool have_vfp __ro_after_init;
 
 /*
  * Dual-use variable.
@@ -55,6 +54,34 @@ static unsigned int __initdata VFP_arch;
  */
 union vfp_state *vfp_current_hw_state[NR_CPUS];
 
+/*
+ * Claim ownership of the VFP unit.
+ *
+ * The caller may change VFP registers until vfp_unlock() is called.
+ *
+ * local_bh_disable() is used to disable preemption and to disable VFP
+ * processing in softirq context. On PREEMPT_RT kernels local_bh_disable() is
+ * not sufficient because it only serializes soft interrupt related sections
+ * via a local lock, but stays preemptible. Disabling preemption is the right
+ * choice here as bottom half processing is always in thread context on RT
+ * kernels so it implicitly prevents bottom half processing as well.
+ */
+static void vfp_lock(void)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_disable();
+	else
+		preempt_disable();
+}
+
+static void vfp_unlock(void)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_bh_enable();
+	else
+		preempt_enable();
+}
+
 /*
  * Is 'thread's most up to date state stored in this CPUs hardware?
  * Must be called from non-preemptible context.
@@ -240,7 +267,7 @@ static void vfp_panic(char *reason, u32 inst)
 /*
  * Process bitmask of exception conditions.
  */
-static void vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, struct pt_regs *regs)
+static int vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr)
 {
 	int si_code = 0;
 
@@ -248,8 +275,7 @@ static void vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, struct pt_
 
 	if (exceptions == VFP_EXCEPTION_ERROR) {
 		vfp_panic("unhandled bounce", inst);
-		vfp_raise_sigfpe(FPE_FLTINV, regs);
-		return;
+		return FPE_FLTINV;
 	}
 
 	/*
@@ -277,8 +303,7 @@ static void vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, struct pt_
 	RAISE(FPSCR_OFC, FPSCR_OFE, FPE_FLTOVF);
 	RAISE(FPSCR_IOC, FPSCR_IOE, FPE_FLTINV);
 
-	if (si_code)
-		vfp_raise_sigfpe(si_code, regs);
+	return si_code;
 }
 
 /*
@@ -323,6 +348,8 @@ static u32 vfp_emulate_instruction(u32 inst, u32 fpscr, struct pt_regs *regs)
 void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs)
 {
 	u32 fpscr, orig_fpscr, fpsid, exceptions;
+	int si_code2 = 0;
+	int si_code = 0;
 
 	pr_debug("VFP: bounce: trigger %08x fpexc %08x\n", trigger, fpexc);
 
@@ -370,7 +397,7 @@ void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs)
 		 * unallocated VFP instruction but with FPSCR.IXE set and not
 		 * on VFP subarch 1.
 		 */
-		 vfp_raise_exceptions(VFP_EXCEPTION_ERROR, trigger, fpscr, regs);
+		si_code = vfp_raise_exceptions(VFP_EXCEPTION_ERROR, trigger, fpscr);
 		goto exit;
 	}
 
@@ -395,7 +422,7 @@ void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs)
 	 */
 	exceptions = vfp_emulate_instruction(trigger, fpscr, regs);
 	if (exceptions)
-		vfp_raise_exceptions(exceptions, trigger, orig_fpscr, regs);
+		si_code2 = vfp_raise_exceptions(exceptions, trigger, orig_fpscr);
 
 	/*
 	 * If there isn't a second FP instruction, exit now. Note that
@@ -414,9 +441,14 @@ void VFP_bounce(u32 trigger, u32 fpexc, struct pt_regs *regs)
  emulate:
 	exceptions = vfp_emulate_instruction(trigger, orig_fpscr, regs);
 	if (exceptions)
-		vfp_raise_exceptions(exceptions, trigger, orig_fpscr, regs);
+		si_code = vfp_raise_exceptions(exceptions, trigger, orig_fpscr);
+
  exit:
-	local_bh_enable();
+	vfp_unlock();
+	if (si_code2)
+		vfp_raise_sigfpe(si_code2, regs);
+	if (si_code)
+		vfp_raise_sigfpe(si_code, regs);
 }
 
 static void vfp_enable(void *unused)
@@ -515,11 +547,9 @@ static inline void vfp_pm_init(void) { }
  */
 void vfp_sync_hwstate(struct thread_info *thread)
 {
-	unsigned int cpu = get_cpu();
+	vfp_lock();
 
-	local_bh_disable();
-
-	if (vfp_state_in_hw(cpu, thread)) {
+	if (vfp_state_in_hw(raw_smp_processor_id(), thread)) {
 		u32 fpexc = fmrx(FPEXC);
 
 		/*
@@ -530,8 +560,7 @@ void vfp_sync_hwstate(struct thread_info *thread)
 		fmxr(FPEXC, fpexc);
 	}
 
-	local_bh_enable();
-	put_cpu();
+	vfp_unlock();
 }
 
 /* Ensure that the thread reloads the hardware VFP state on the next use. */
@@ -645,6 +674,30 @@ static int vfp_starting_cpu(unsigned int unused)
 	return 0;
 }
 
+/*
+ * Entered with:
+ *
+ *  r0  = instruction opcode (32-bit ARM or two 16-bit Thumb)
+ *  r1  = thread_info pointer
+ *  r2  = PC value to resume execution after successful emulation
+ *  r3  = normal "successful" return address
+ *  lr  = unrecognised instruction return address
+ */
+asmlinkage void vfp_entry(u32 trigger, struct thread_info *ti, u32 resume_pc,
+			  u32 resume_return_address)
+{
+	if (unlikely(!have_vfp))
+		return;
+
+	vfp_lock();
+	vfp_support_entry(trigger, ti, resume_pc, resume_return_address);
+}
+
+asmlinkage void vfp_exit(void)
+{
+	vfp_unlock();
+}
+
 #ifdef CONFIG_KERNEL_MODE_NEON
 
 static int vfp_kmode_exception(struct pt_regs *regs, unsigned int instr)
@@ -720,7 +773,7 @@ void kernel_neon_begin(void)
 	unsigned int cpu;
 	u32 fpexc;
 
-	local_bh_disable();
+	vfp_lock();
 
 	/*
 	 * Kernel mode NEON is only allowed outside of hardirq context with
@@ -751,7 +804,7 @@ void kernel_neon_end(void)
 {
 	/* Disable the NEON/VFP unit. */
 	fmxr(FPEXC, fmrx(FPEXC) & ~FPEXC_EN);
-	local_bh_enable();
+	vfp_unlock();
 }
 EXPORT_SYMBOL(kernel_neon_end);
 
@@ -798,7 +851,6 @@ static int __init vfp_init(void)
 	vfpsid = fmrx(FPSID);
 	barrier();
 	unregister_undef_hook(&vfp_detect_hook);
-	vfp_vector = vfp_null_entry;
 
 	pr_info("VFP support v0.3: ");
 	if (VFP_arch) {
@@ -883,7 +935,7 @@ static int __init vfp_init(void)
 				  "arm/vfp:starting", vfp_starting_cpu,
 				  vfp_dying_cpu);
 
-	vfp_vector = vfp_support_entry;
+	have_vfp = true;
 
 	thread_register_notifier(&vfp_notifier_block);
 	vfp_pm_init();
diff --git a/localversion-rt b/localversion-rt
index 08b3e75841adc..18777ec0c27d4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt14
+-rt15
