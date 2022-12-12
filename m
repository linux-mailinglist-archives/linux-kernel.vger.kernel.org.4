Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31B3649BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 11:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiLLKJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 05:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbiLLKJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 05:09:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EFBE018
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:09:09 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670839748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=oXyIDbqMTGLVJRAajo+THugbtWe3yMcrvQ9/1U9Fpq4=;
        b=x7HqG2FP9/N5wWACrLevMpi980O7ei8oU9VdpYwo2c5kG1n3vkqVvMKZBNkFvU1U1llLmj
        wIUdLfOVhrV+pYvdfRKA6cPOc6ixm5mlQdgeOiNPRKlQWgLbNC26Z88J0/CRtPnDZPDbb7
        dBKVgYJlQvuIS0ozPhyn7axsWz0aCvG9nv9M2tikM2jG0Is84CoCtAKSIusmBJLUgaAkq1
        e86Kn0FmTcZPyB+EwtUL8o+sIoAB4ZdE2QIBwKduS/u3s3a1mentRaOqY91rNELQMwYOxG
        J866+EZsNt3Em1gPMjKHwCFdhzf3L9wkLFL7kP3f5PrRI9ngyVpWzohu9uYFKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670839748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=oXyIDbqMTGLVJRAajo+THugbtWe3yMcrvQ9/1U9Fpq4=;
        b=J/R1uq7i2n7+K6DfaKYb7RBcPQ8D5Lo0hTwAuk0LsECOn1Ykx2LW2IXlJNbPwwoeHFNE3k
        TLPu/ryK89TEiMBQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/misc for v6.2-rc1
References: <167083907785.564878.11381307641454805335.tglx@xen13.tec.linutronix.de>
Message-ID: <167083908656.564878.7729109468817582873.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 12 Dec 2022 11:09:07 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/misc branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2022-12=
-10

up to:  00ed1eabcc3b: x86/espfix: Use get_random_long() rather than archrandom

Updates for miscellaneous x86 areas:

  - Reserve a new boot loader type for barebox which is usally used on ARM
    and MIPS, but can also be utilized as EFI payload on x86 to provide
    watchdog-supervised boot up.

  - Consolidate the native and compat 32bit signal handling code and split
    the 64bit version out into a separate source file

  - Switch the ESPFIX random usage to get_random_long().

Thanks,

	tglx

------------------>
Ahmad Fatoum (1):
      Documentation/x86/boot: Reserve type_of_loader=3D13 for barebox

Brian Gerst (8):
      x86/signal: Remove sig parameter from frame setup functions
      x86/signal: Remove sigset_t parameter from frame setup functions
      signal/compat: Remove compat_sigset_t override
      x86: Remove __USER32_DS
      x86/signal: Merge get_sigframe()
      x86/signal: Add ABI prefixes to frame setup functions
      x86/signal/32: Merge native and compat 32-bit signal code
      x86/signal/64: Move 64-bit signal code to its own file

Jason A. Donenfeld (1):
      x86/espfix: Use get_random_long() rather than archrandom


 Documentation/x86/boot.rst                         |   1 +
 arch/x86/entry/entry_64_compat.S                   |   4 +-
 arch/x86/ia32/Makefile                             |   2 -
 arch/x86/include/asm/elf.h                         |   4 -
 arch/x86/include/asm/fpu/signal.h                  |   7 -
 arch/x86/include/asm/segment.h                     |   2 +-
 arch/x86/include/asm/sighandling.h                 |   9 +
 arch/x86/include/asm/signal.h                      |   5 -
 arch/x86/kernel/Makefile                           |   4 +-
 arch/x86/kernel/espfix_64.c                        |  12 +-
 arch/x86/kernel/signal.c                           | 654 +------------------=
--
 .../x86/{ia32/ia32_signal.c =3D> kernel/signal_32.c} | 117 ++--
 arch/x86/kernel/signal_64.c                        | 383 ++++++++++++
 arch/x86/xen/xen-asm.S                             |   8 +-
 include/linux/compat.h                             |   2 -
 include/linux/syscalls.h                           |   2 +
 16 files changed, 495 insertions(+), 721 deletions(-)
 rename arch/x86/{ia32/ia32_signal.c =3D> kernel/signal_32.c} (82%)
 create mode 100644 arch/x86/kernel/signal_64.c

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 894a19897005..240d084782a6 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -455,6 +455,7 @@ Protocol:	2.00+
 	11 Minimal Linux Bootloader
 	   <http://sebastian-plotz.blogspot.de>
 	12 OVMF UEFI virtualization stack
+	13 barebox
 	=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
   Please contact <hpa@zytor.com> if you need a bootloader ID value assigned.
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compa=
t.S
index 4dd19819053a..59b93901660d 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -61,7 +61,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
=20
 	/* Construct struct pt_regs on stack */
-	pushq	$__USER32_DS		/* pt_regs->ss */
+	pushq	$__USER_DS		/* pt_regs->ss */
 	pushq	$0			/* pt_regs->sp =3D 0 (placeholder) */
=20
 	/*
@@ -197,7 +197,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GL=
OBAL)
 	ANNOTATE_NOENDBR
=20
 	/* Construct struct pt_regs on stack */
-	pushq	$__USER32_DS		/* pt_regs->ss */
+	pushq	$__USER_DS		/* pt_regs->ss */
 	pushq	%r8			/* pt_regs->sp */
 	pushq	%r11			/* pt_regs->flags */
 	pushq	$__USER32_CS		/* pt_regs->cs */
diff --git a/arch/x86/ia32/Makefile b/arch/x86/ia32/Makefile
index e481056698de..333556a86b2a 100644
--- a/arch/x86/ia32/Makefile
+++ b/arch/x86/ia32/Makefile
@@ -3,7 +3,5 @@
 # Makefile for the ia32 kernel emulation subsystem.
 #
=20
-obj-$(CONFIG_IA32_EMULATION) :=3D ia32_signal.o
-
 audit-class-$(CONFIG_AUDIT) :=3D audit.o
 obj-$(CONFIG_IA32_EMULATION) +=3D $(audit-class-y)
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index cb0ff1055ab1..be8b58da63b9 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -152,10 +152,6 @@ do {						\
 	(elf_check_arch_ia32(x) ||					\
 	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine =3D=3D EM_X86_64))
=20
-#if __USER32_DS !=3D __USER_DS
-# error "The following code assumes __USER32_DS =3D=3D __USER_DS"
-#endif
-
 static inline void elf_common_init(struct thread_struct *t,
 				   struct pt_regs *regs, const u16 ds)
 {
diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/sig=
nal.h
index e1c9df9102a5..611fa41711af 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -13,16 +13,9 @@
 #ifdef CONFIG_X86_64
 # include <uapi/asm/sigcontext.h>
 # include <asm/user32.h>
-struct ksignal;
-int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
-			compat_sigset_t *set, struct pt_regs *regs);
-int ia32_setup_frame(int sig, struct ksignal *ksig,
-		     compat_sigset_t *set, struct pt_regs *regs);
 #else
 # define user_i387_ia32_struct	user_i387_struct
 # define user32_fxsr_struct	user_fxsr_struct
-# define ia32_setup_frame	__setup_frame
-# define ia32_setup_rt_frame	__setup_rt_frame
 #endif
=20
 extern void convert_from_fxsr(struct user_i387_ia32_struct *env,
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 2e7890dd58a4..c390a672d560 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -135,6 +135,7 @@
 #define __KERNEL_DS			(GDT_ENTRY_KERNEL_DS*8)
 #define __USER_DS			(GDT_ENTRY_DEFAULT_USER_DS*8 + 3)
 #define __USER_CS			(GDT_ENTRY_DEFAULT_USER_CS*8 + 3)
+#define __USER32_CS			__USER_CS
 #define __ESPFIX_SS			(GDT_ENTRY_ESPFIX_SS*8)
=20
 /* segment for calling fn: */
@@ -210,7 +211,6 @@
 #define __KERNEL_DS			(GDT_ENTRY_KERNEL_DS*8)
 #define __USER32_CS			(GDT_ENTRY_DEFAULT_USER32_CS*8 + 3)
 #define __USER_DS			(GDT_ENTRY_DEFAULT_USER_DS*8 + 3)
-#define __USER32_DS			__USER_DS
 #define __USER_CS			(GDT_ENTRY_DEFAULT_USER_CS*8 + 3)
 #define __CPUNODE_SEG			(GDT_ENTRY_CPUNODE*8 + 3)
=20
diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighan=
dling.h
index 65e667279e0f..e770c4fc47f4 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -15,4 +15,13 @@
=20
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
=20
+void __user *
+get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
+	     void __user **fpstate);
+
+int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs);
+int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
+int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
+int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
+
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 2dfb5fea13af..4a4043ca6493 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -28,11 +28,6 @@ typedef struct {
 #define SA_IA32_ABI	0x02000000u
 #define SA_X32_ABI	0x01000000u
=20
-#ifndef CONFIG_COMPAT
-#define compat_sigset_t compat_sigset_t
-typedef sigset_t compat_sigset_t;
-#endif
-
 #endif /* __ASSEMBLY__ */
 #include <uapi/asm/signal.h>
 #ifndef __ASSEMBLY__
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f901658d9f7c..cceaafdd2d84 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -44,7 +44,7 @@ obj-y			+=3D head_$(BITS).o
 obj-y			+=3D head$(BITS).o
 obj-y			+=3D ebda.o
 obj-y			+=3D platform-quirks.o
-obj-y			+=3D process_$(BITS).o signal.o
+obj-y			+=3D process_$(BITS).o signal.o signal_$(BITS).o
 obj-$(CONFIG_COMPAT)	+=3D signal_compat.o
 obj-y			+=3D traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
 obj-y			+=3D time.o ioport.o dumpstack.o nmi.o
@@ -54,7 +54,7 @@ obj-$(CONFIG_JUMP_LABEL)	+=3D jump_label.o
 obj-$(CONFIG_IRQ_WORK)  +=3D irq_work.o
 obj-y			+=3D probe_roms.o
 obj-$(CONFIG_X86_32)	+=3D sys_ia32.o
-obj-$(CONFIG_IA32_EMULATION)	+=3D sys_ia32.o
+obj-$(CONFIG_IA32_EMULATION)	+=3D sys_ia32.o signal_32.o
 obj-$(CONFIG_X86_64)	+=3D sys_x86_64.o
 obj-$(CONFIG_X86_ESPFIX64)	+=3D espfix_64.o
 obj-$(CONFIG_SYSFS)	+=3D ksysfs.o
diff --git a/arch/x86/kernel/espfix_64.c b/arch/x86/kernel/espfix_64.c
index 9417d5aa7305..16f9814c9be0 100644
--- a/arch/x86/kernel/espfix_64.c
+++ b/arch/x86/kernel/espfix_64.c
@@ -94,17 +94,7 @@ static inline unsigned long espfix_base_addr(unsigned int =
cpu)
=20
 static void init_espfix_random(void)
 {
-	unsigned long rand;
-
-	/*
-	 * This is run before the entropy pools are initialized,
-	 * but this is hopefully better than nothing.
-	 */
-	if (!arch_get_random_longs(&rand, 1)) {
-		/* The constant is an arbitrary large prime */
-		rand =3D rdtsc();
-		rand *=3D 0xc345c6b72fd16123UL;
-	}
+	unsigned long rand =3D get_random_long();
=20
 	slot_random =3D rand % ESPFIX_STACKS_PER_PAGE;
 	page_random =3D (rand / ESPFIX_STACKS_PER_PAGE)
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 9c7265b524c7..1504eb8d25aa 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -37,180 +37,27 @@
 #include <asm/sighandling.h>
 #include <asm/vm86.h>
=20
-#ifdef CONFIG_X86_64
-#include <linux/compat.h>
-#include <asm/proto.h>
-#include <asm/ia32_unistd.h>
-#include <asm/fpu/xstate.h>
-#endif /* CONFIG_X86_64 */
-
 #include <asm/syscall.h>
 #include <asm/sigframe.h>
 #include <asm/signal.h>
=20
-#ifdef CONFIG_X86_64
-/*
- * If regs->ss will cause an IRET fault, change it.  Otherwise leave it
- * alone.  Using this generally makes no sense unless
- * user_64bit_mode(regs) would return true.
- */
-static void force_valid_ss(struct pt_regs *regs)
+static inline int is_ia32_compat_frame(struct ksignal *ksig)
 {
-	u32 ar;
-	asm volatile ("lar %[old_ss], %[ar]\n\t"
-		      "jz 1f\n\t"		/* If invalid: */
-		      "xorl %[ar], %[ar]\n\t"	/* set ar =3D 0 */
-		      "1:"
-		      : [ar] "=3Dr" (ar)
-		      : [old_ss] "rm" ((u16)regs->ss));
-
-	/*
-	 * For a valid 64-bit user context, we need DPL 3, type
-	 * read-write data or read-write exp-down data, and S and P
-	 * set.  We can't use VERW because VERW doesn't check the
-	 * P bit.
-	 */
-	ar &=3D AR_DPL_MASK | AR_S | AR_P | AR_TYPE_MASK;
-	if (ar !=3D (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA) &&
-	    ar !=3D (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA_EXPDOWN))
-		regs->ss =3D __USER_DS;
+	return IS_ENABLED(CONFIG_IA32_EMULATION) &&
+		ksig->ka.sa.sa_flags & SA_IA32_ABI;
 }
-# define CONTEXT_COPY_SIZE	offsetof(struct sigcontext, reserved1)
-#else
-# define CONTEXT_COPY_SIZE	sizeof(struct sigcontext)
-#endif
=20
-static bool restore_sigcontext(struct pt_regs *regs,
-			       struct sigcontext __user *usc,
-			       unsigned long uc_flags)
+static inline int is_ia32_frame(struct ksignal *ksig)
 {
-	struct sigcontext sc;
-
-	/* Always make any pending restarted system calls return -EINTR */
-	current->restart_block.fn =3D do_no_restart_syscall;
-
-	if (copy_from_user(&sc, usc, CONTEXT_COPY_SIZE))
-		return false;
-
-#ifdef CONFIG_X86_32
-	loadsegment(gs, sc.gs);
-	regs->fs =3D sc.fs;
-	regs->es =3D sc.es;
-	regs->ds =3D sc.ds;
-#endif /* CONFIG_X86_32 */
-
-	regs->bx =3D sc.bx;
-	regs->cx =3D sc.cx;
-	regs->dx =3D sc.dx;
-	regs->si =3D sc.si;
-	regs->di =3D sc.di;
-	regs->bp =3D sc.bp;
-	regs->ax =3D sc.ax;
-	regs->sp =3D sc.sp;
-	regs->ip =3D sc.ip;
-
-#ifdef CONFIG_X86_64
-	regs->r8 =3D sc.r8;
-	regs->r9 =3D sc.r9;
-	regs->r10 =3D sc.r10;
-	regs->r11 =3D sc.r11;
-	regs->r12 =3D sc.r12;
-	regs->r13 =3D sc.r13;
-	regs->r14 =3D sc.r14;
-	regs->r15 =3D sc.r15;
-#endif /* CONFIG_X86_64 */
-
-	/* Get CS/SS and force CPL3 */
-	regs->cs =3D sc.cs | 0x03;
-	regs->ss =3D sc.ss | 0x03;
-
-	regs->flags =3D (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
-	/* disable syscall checks */
-	regs->orig_ax =3D -1;
-
-#ifdef CONFIG_X86_64
-	/*
-	 * Fix up SS if needed for the benefit of old DOSEMU and
-	 * CRIU.
-	 */
-	if (unlikely(!(uc_flags & UC_STRICT_RESTORE_SS) && user_64bit_mode(regs)))
-		force_valid_ss(regs);
-#endif
-
-	return fpu__restore_sig((void __user *)sc.fpstate,
-			       IS_ENABLED(CONFIG_X86_32));
+	return IS_ENABLED(CONFIG_X86_32) || is_ia32_compat_frame(ksig);
 }
=20
-static __always_inline int
-__unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
-		     struct pt_regs *regs, unsigned long mask)
+static inline int is_x32_frame(struct ksignal *ksig)
 {
-#ifdef CONFIG_X86_32
-	unsigned int gs;
-	savesegment(gs, gs);
-
-	unsafe_put_user(gs,	  (unsigned int __user *)&sc->gs, Efault);
-	unsafe_put_user(regs->fs, (unsigned int __user *)&sc->fs, Efault);
-	unsafe_put_user(regs->es, (unsigned int __user *)&sc->es, Efault);
-	unsafe_put_user(regs->ds, (unsigned int __user *)&sc->ds, Efault);
-#endif /* CONFIG_X86_32 */
-
-	unsafe_put_user(regs->di, &sc->di, Efault);
-	unsafe_put_user(regs->si, &sc->si, Efault);
-	unsafe_put_user(regs->bp, &sc->bp, Efault);
-	unsafe_put_user(regs->sp, &sc->sp, Efault);
-	unsafe_put_user(regs->bx, &sc->bx, Efault);
-	unsafe_put_user(regs->dx, &sc->dx, Efault);
-	unsafe_put_user(regs->cx, &sc->cx, Efault);
-	unsafe_put_user(regs->ax, &sc->ax, Efault);
-#ifdef CONFIG_X86_64
-	unsafe_put_user(regs->r8, &sc->r8, Efault);
-	unsafe_put_user(regs->r9, &sc->r9, Efault);
-	unsafe_put_user(regs->r10, &sc->r10, Efault);
-	unsafe_put_user(regs->r11, &sc->r11, Efault);
-	unsafe_put_user(regs->r12, &sc->r12, Efault);
-	unsafe_put_user(regs->r13, &sc->r13, Efault);
-	unsafe_put_user(regs->r14, &sc->r14, Efault);
-	unsafe_put_user(regs->r15, &sc->r15, Efault);
-#endif /* CONFIG_X86_64 */
-
-	unsafe_put_user(current->thread.trap_nr, &sc->trapno, Efault);
-	unsafe_put_user(current->thread.error_code, &sc->err, Efault);
-	unsafe_put_user(regs->ip, &sc->ip, Efault);
-#ifdef CONFIG_X86_32
-	unsafe_put_user(regs->cs, (unsigned int __user *)&sc->cs, Efault);
-	unsafe_put_user(regs->flags, &sc->flags, Efault);
-	unsafe_put_user(regs->sp, &sc->sp_at_signal, Efault);
-	unsafe_put_user(regs->ss, (unsigned int __user *)&sc->ss, Efault);
-#else /* !CONFIG_X86_32 */
-	unsafe_put_user(regs->flags, &sc->flags, Efault);
-	unsafe_put_user(regs->cs, &sc->cs, Efault);
-	unsafe_put_user(0, &sc->gs, Efault);
-	unsafe_put_user(0, &sc->fs, Efault);
-	unsafe_put_user(regs->ss, &sc->ss, Efault);
-#endif /* CONFIG_X86_32 */
-
-	unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);
-
-	/* non-iBCS2 extensions.. */
-	unsafe_put_user(mask, &sc->oldmask, Efault);
-	unsafe_put_user(current->thread.cr2, &sc->cr2, Efault);
-	return 0;
-Efault:
-	return -EFAULT;
+	return IS_ENABLED(CONFIG_X86_X32_ABI) &&
+		ksig->ka.sa.sa_flags & SA_X32_ABI;
 }
=20
-#define unsafe_put_sigcontext(sc, fp, regs, set, label)			\
-do {									\
-	if (__unsafe_setup_sigcontext(sc, fp, regs, set->sig[0]))	\
-		goto label;						\
-} while(0);
-
-#define unsafe_put_sigmask(set, frame, label) \
-	unsafe_put_user(*(__u64 *)(set), \
-			(__u64 __user *)&(frame)->uc.uc_sigmask, \
-			label)
-
 /*
  * Set up a signal frame.
  */
@@ -223,24 +70,12 @@ do {									\
 /*
  * Determine which stack to use..
  */
-static unsigned long align_sigframe(unsigned long sp)
-{
-#ifdef CONFIG_X86_32
-	/*
-	 * Align the stack pointer according to the i386 ABI,
-	 * i.e. so that on function entry ((sp + 4) & 15) =3D=3D 0.
-	 */
-	sp =3D ((sp + 4) & -FRAME_ALIGNMENT) - 4;
-#else /* !CONFIG_X86_32 */
-	sp =3D round_down(sp, FRAME_ALIGNMENT) - 8;
-#endif
-	return sp;
-}
-
-static void __user *
-get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
+void __user *
+get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	     void __user **fpstate)
 {
+	struct k_sigaction *ka =3D &ksig->ka;
+	int ia32_frame =3D is_ia32_frame(ksig);
 	/* Default to using normal stack */
 	bool nested_altstack =3D on_sig_stack(regs->sp);
 	bool entering_altstack =3D false;
@@ -249,7 +84,7 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,=
 size_t frame_size,
 	unsigned long buf_fx =3D 0;
=20
 	/* redzone */
-	if (IS_ENABLED(CONFIG_X86_64))
+	if (!ia32_frame)
 		sp -=3D 128;
=20
 	/* This is the X/Open sanctioned signal stack switching.  */
@@ -263,7 +98,7 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,=
 size_t frame_size,
 			sp =3D current->sas_ss_sp + current->sas_ss_size;
 			entering_altstack =3D true;
 		}
-	} else if (IS_ENABLED(CONFIG_X86_32) &&
+	} else if (ia32_frame &&
 		   !nested_altstack &&
 		   regs->ss !=3D __USER_DS &&
 		   !(ka->sa.sa_flags & SA_RESTORER) &&
@@ -273,11 +108,19 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *re=
gs, size_t frame_size,
 		entering_altstack =3D true;
 	}
=20
-	sp =3D fpu__alloc_mathframe(sp, IS_ENABLED(CONFIG_X86_32),
-				  &buf_fx, &math_size);
+	sp =3D fpu__alloc_mathframe(sp, ia32_frame, &buf_fx, &math_size);
 	*fpstate =3D (void __user *)sp;
=20
-	sp =3D align_sigframe(sp - frame_size);
+	sp -=3D frame_size;
+
+	if (ia32_frame)
+		/*
+		 * Align the stack pointer according to the i386 ABI,
+		 * i.e. so that on function entry ((sp + 4) & 15) =3D=3D 0.
+		 */
+		sp =3D ((sp + 4) & -FRAME_ALIGNMENT) - 4;
+	else
+		sp =3D round_down(sp, FRAME_ALIGNMENT) - 8;
=20
 	/*
 	 * If we are on the alternate signal stack and would overflow it, don't.
@@ -300,391 +143,6 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *re=
gs, size_t frame_size,
 	return (void __user *)sp;
 }
=20
-#ifdef CONFIG_X86_32
-static const struct {
-	u16 poplmovl;
-	u32 val;
-	u16 int80;
-} __attribute__((packed)) retcode =3D {
-	0xb858,		/* popl %eax; movl $..., %eax */
-	__NR_sigreturn,
-	0x80cd,		/* int $0x80 */
-};
-
-static const struct {
-	u8  movl;
-	u32 val;
-	u16 int80;
-	u8  pad;
-} __attribute__((packed)) rt_retcode =3D {
-	0xb8,		/* movl $..., %eax */
-	__NR_rt_sigreturn,
-	0x80cd,		/* int $0x80 */
-	0
-};
-
-static int
-__setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
-	      struct pt_regs *regs)
-{
-	struct sigframe __user *frame;
-	void __user *restorer;
-	void __user *fp =3D NULL;
-
-	frame =3D get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
-
-	if (!user_access_begin(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	unsafe_put_user(sig, &frame->sig, Efault);
-	unsafe_put_sigcontext(&frame->sc, fp, regs, set, Efault);
-	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
-	if (current->mm->context.vdso)
-		restorer =3D current->mm->context.vdso +
-			vdso_image_32.sym___kernel_sigreturn;
-	else
-		restorer =3D &frame->retcode;
-	if (ksig->ka.sa.sa_flags & SA_RESTORER)
-		restorer =3D ksig->ka.sa.sa_restorer;
-
-	/* Set up to return from userspace.  */
-	unsafe_put_user(restorer, &frame->pretcode, Efault);
-
-	/*
-	 * This is popl %eax ; movl $__NR_sigreturn, %eax ; int $0x80
-	 *
-	 * WE DO NOT USE IT ANY MORE! It's only left here for historical
-	 * reasons and because gdb uses it as a signature to notice
-	 * signal handler stack frames.
-	 */
-	unsafe_put_user(*((u64 *)&retcode), (u64 *)frame->retcode, Efault);
-	user_access_end();
-
-	/* Set up registers for signal handler */
-	regs->sp =3D (unsigned long)frame;
-	regs->ip =3D (unsigned long)ksig->ka.sa.sa_handler;
-	regs->ax =3D (unsigned long)sig;
-	regs->dx =3D 0;
-	regs->cx =3D 0;
-
-	regs->ds =3D __USER_DS;
-	regs->es =3D __USER_DS;
-	regs->ss =3D __USER_DS;
-	regs->cs =3D __USER_CS;
-
-	return 0;
-
-Efault:
-	user_access_end();
-	return -EFAULT;
-}
-
-static int __setup_rt_frame(int sig, struct ksignal *ksig,
-			    sigset_t *set, struct pt_regs *regs)
-{
-	struct rt_sigframe __user *frame;
-	void __user *restorer;
-	void __user *fp =3D NULL;
-
-	frame =3D get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
-
-	if (!user_access_begin(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	unsafe_put_user(sig, &frame->sig, Efault);
-	unsafe_put_user(&frame->info, &frame->pinfo, Efault);
-	unsafe_put_user(&frame->uc, &frame->puc, Efault);
-
-	/* Create the ucontext.  */
-	if (static_cpu_has(X86_FEATURE_XSAVE))
-		unsafe_put_user(UC_FP_XSTATE, &frame->uc.uc_flags, Efault);
-	else
-		unsafe_put_user(0, &frame->uc.uc_flags, Efault);
-	unsafe_put_user(0, &frame->uc.uc_link, Efault);
-	unsafe_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
-
-	/* Set up to return from userspace.  */
-	restorer =3D current->mm->context.vdso +
-		vdso_image_32.sym___kernel_rt_sigreturn;
-	if (ksig->ka.sa.sa_flags & SA_RESTORER)
-		restorer =3D ksig->ka.sa.sa_restorer;
-	unsafe_put_user(restorer, &frame->pretcode, Efault);
-
-	/*
-	 * This is movl $__NR_rt_sigreturn, %ax ; int $0x80
-	 *
-	 * WE DO NOT USE IT ANY MORE! It's only left here for historical
-	 * reasons and because gdb uses it as a signature to notice
-	 * signal handler stack frames.
-	 */
-	unsafe_put_user(*((u64 *)&rt_retcode), (u64 *)frame->retcode, Efault);
-	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_sigmask(set, frame, Efault);
-	user_access_end();
-=09
-	if (copy_siginfo_to_user(&frame->info, &ksig->info))
-		return -EFAULT;
-
-	/* Set up registers for signal handler */
-	regs->sp =3D (unsigned long)frame;
-	regs->ip =3D (unsigned long)ksig->ka.sa.sa_handler;
-	regs->ax =3D (unsigned long)sig;
-	regs->dx =3D (unsigned long)&frame->info;
-	regs->cx =3D (unsigned long)&frame->uc;
-
-	regs->ds =3D __USER_DS;
-	regs->es =3D __USER_DS;
-	regs->ss =3D __USER_DS;
-	regs->cs =3D __USER_CS;
-
-	return 0;
-Efault:
-	user_access_end();
-	return -EFAULT;
-}
-#else /* !CONFIG_X86_32 */
-static unsigned long frame_uc_flags(struct pt_regs *regs)
-{
-	unsigned long flags;
-
-	if (boot_cpu_has(X86_FEATURE_XSAVE))
-		flags =3D UC_FP_XSTATE | UC_SIGCONTEXT_SS;
-	else
-		flags =3D UC_SIGCONTEXT_SS;
-
-	if (likely(user_64bit_mode(regs)))
-		flags |=3D UC_STRICT_RESTORE_SS;
-
-	return flags;
-}
-
-static int __setup_rt_frame(int sig, struct ksignal *ksig,
-			    sigset_t *set, struct pt_regs *regs)
-{
-	struct rt_sigframe __user *frame;
-	void __user *fp =3D NULL;
-	unsigned long uc_flags;
-
-	/* x86-64 should always use SA_RESTORER. */
-	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
-		return -EFAULT;
-
-	frame =3D get_sigframe(&ksig->ka, regs, sizeof(struct rt_sigframe), &fp);
-	uc_flags =3D frame_uc_flags(regs);
-
-	if (!user_access_begin(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	/* Create the ucontext.  */
-	unsafe_put_user(uc_flags, &frame->uc.uc_flags, Efault);
-	unsafe_put_user(0, &frame->uc.uc_link, Efault);
-	unsafe_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
-
-	/* Set up to return from userspace.  If provided, use a stub
-	   already in userspace.  */
-	unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);
-	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_sigmask(set, frame, Efault);
-	user_access_end();
-
-	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-		if (copy_siginfo_to_user(&frame->info, &ksig->info))
-			return -EFAULT;
-	}
-
-	/* Set up registers for signal handler */
-	regs->di =3D sig;
-	/* In case the signal handler was declared without prototypes */
-	regs->ax =3D 0;
-
-	/* This also works for non SA_SIGINFO handlers because they expect the
-	   next argument after the signal number on the stack. */
-	regs->si =3D (unsigned long)&frame->info;
-	regs->dx =3D (unsigned long)&frame->uc;
-	regs->ip =3D (unsigned long) ksig->ka.sa.sa_handler;
-
-	regs->sp =3D (unsigned long)frame;
-
-	/*
-	 * Set up the CS and SS registers to run signal handlers in
-	 * 64-bit mode, even if the handler happens to be interrupting
-	 * 32-bit or 16-bit code.
-	 *
-	 * SS is subtle.  In 64-bit mode, we don't need any particular
-	 * SS descriptor, but we do need SS to be valid.  It's possible
-	 * that the old SS is entirely bogus -- this can happen if the
-	 * signal we're trying to deliver is #GP or #SS caused by a bad
-	 * SS value.  We also have a compatibility issue here: DOSEMU
-	 * relies on the contents of the SS register indicating the
-	 * SS value at the time of the signal, even though that code in
-	 * DOSEMU predates sigreturn's ability to restore SS.  (DOSEMU
-	 * avoids relying on sigreturn to restore SS; instead it uses
-	 * a trampoline.)  So we do our best: if the old SS was valid,
-	 * we keep it.  Otherwise we replace it.
-	 */
-	regs->cs =3D __USER_CS;
-
-	if (unlikely(regs->ss !=3D __USER_DS))
-		force_valid_ss(regs);
-
-	return 0;
-
-Efault:
-	user_access_end();
-	return -EFAULT;
-}
-#endif /* CONFIG_X86_32 */
-
-#ifdef CONFIG_X86_X32_ABI
-static int x32_copy_siginfo_to_user(struct compat_siginfo __user *to,
-		const struct kernel_siginfo *from)
-{
-	struct compat_siginfo new;
-
-	copy_siginfo_to_external32(&new, from);
-	if (from->si_signo =3D=3D SIGCHLD) {
-		new._sifields._sigchld_x32._utime =3D from->si_utime;
-		new._sifields._sigchld_x32._stime =3D from->si_stime;
-	}
-	if (copy_to_user(to, &new, sizeof(struct compat_siginfo)))
-		return -EFAULT;
-	return 0;
-}
-
-int copy_siginfo_to_user32(struct compat_siginfo __user *to,
-			   const struct kernel_siginfo *from)
-{
-	if (in_x32_syscall())
-		return x32_copy_siginfo_to_user(to, from);
-	return __copy_siginfo_to_user32(to, from);
-}
-#endif /* CONFIG_X86_X32_ABI */
-
-static int x32_setup_rt_frame(struct ksignal *ksig,
-			      compat_sigset_t *set,
-			      struct pt_regs *regs)
-{
-#ifdef CONFIG_X86_X32_ABI
-	struct rt_sigframe_x32 __user *frame;
-	unsigned long uc_flags;
-	void __user *restorer;
-	void __user *fp =3D NULL;
-
-	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
-		return -EFAULT;
-
-	frame =3D get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
-
-	uc_flags =3D frame_uc_flags(regs);
-
-	if (!user_access_begin(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	/* Create the ucontext.  */
-	unsafe_put_user(uc_flags, &frame->uc.uc_flags, Efault);
-	unsafe_put_user(0, &frame->uc.uc_link, Efault);
-	unsafe_compat_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
-	unsafe_put_user(0, &frame->uc.uc__pad0, Efault);
-	restorer =3D ksig->ka.sa.sa_restorer;
-	unsafe_put_user(restorer, (unsigned long __user *)&frame->pretcode, Efault);
-	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_sigmask(set, frame, Efault);
-	user_access_end();
-
-	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-		if (x32_copy_siginfo_to_user(&frame->info, &ksig->info))
-			return -EFAULT;
-	}
-
-	/* Set up registers for signal handler */
-	regs->sp =3D (unsigned long) frame;
-	regs->ip =3D (unsigned long) ksig->ka.sa.sa_handler;
-
-	/* We use the x32 calling convention here... */
-	regs->di =3D ksig->sig;
-	regs->si =3D (unsigned long) &frame->info;
-	regs->dx =3D (unsigned long) &frame->uc;
-
-	loadsegment(ds, __USER_DS);
-	loadsegment(es, __USER_DS);
-
-	regs->cs =3D __USER_CS;
-	regs->ss =3D __USER_DS;
-#endif	/* CONFIG_X86_X32_ABI */
-
-	return 0;
-#ifdef CONFIG_X86_X32_ABI
-Efault:
-	user_access_end();
-	return -EFAULT;
-#endif
-}
-
-/*
- * Do a signal return; undo the signal stack.
- */
-#ifdef CONFIG_X86_32
-SYSCALL_DEFINE0(sigreturn)
-{
-	struct pt_regs *regs =3D current_pt_regs();
-	struct sigframe __user *frame;
-	sigset_t set;
-
-	frame =3D (struct sigframe __user *)(regs->sp - 8);
-
-	if (!access_ok(frame, sizeof(*frame)))
-		goto badframe;
-	if (__get_user(set.sig[0], &frame->sc.oldmask) ||
-	    __get_user(set.sig[1], &frame->extramask[0]))
-		goto badframe;
-
-	set_current_blocked(&set);
-
-	/*
-	 * x86_32 has no uc_flags bits relevant to restore_sigcontext.
-	 * Save a few cycles by skipping the __get_user.
-	 */
-	if (!restore_sigcontext(regs, &frame->sc, 0))
-		goto badframe;
-	return regs->ax;
-
-badframe:
-	signal_fault(regs, frame, "sigreturn");
-
-	return 0;
-}
-#endif /* CONFIG_X86_32 */
-
-SYSCALL_DEFINE0(rt_sigreturn)
-{
-	struct pt_regs *regs =3D current_pt_regs();
-	struct rt_sigframe __user *frame;
-	sigset_t set;
-	unsigned long uc_flags;
-
-	frame =3D (struct rt_sigframe __user *)(regs->sp - sizeof(long));
-	if (!access_ok(frame, sizeof(*frame)))
-		goto badframe;
-	if (__get_user(*(__u64 *)&set, (__u64 __user *)&frame->uc.uc_sigmask))
-		goto badframe;
-	if (__get_user(uc_flags, &frame->uc.uc_flags))
-		goto badframe;
-
-	set_current_blocked(&set);
-
-	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
-		goto badframe;
-
-	if (restore_altstack(&frame->uc.uc_stack))
-		goto badframe;
-
-	return regs->ax;
-
-badframe:
-	signal_fault(regs, frame, "rt_sigreturn");
-	return 0;
-}
-
 /*
  * There are four different struct types for signal frame: sigframe_ia32,
  * rt_sigframe_ia32, rt_sigframe_x32, and rt_sigframe. Use the worst case
@@ -743,43 +201,22 @@ unsigned long get_sigframe_size(void)
 	return max_frame_size;
 }
=20
-static inline int is_ia32_compat_frame(struct ksignal *ksig)
-{
-	return IS_ENABLED(CONFIG_IA32_EMULATION) &&
-		ksig->ka.sa.sa_flags & SA_IA32_ABI;
-}
-
-static inline int is_ia32_frame(struct ksignal *ksig)
-{
-	return IS_ENABLED(CONFIG_X86_32) || is_ia32_compat_frame(ksig);
-}
-
-static inline int is_x32_frame(struct ksignal *ksig)
-{
-	return IS_ENABLED(CONFIG_X86_X32_ABI) &&
-		ksig->ka.sa.sa_flags & SA_X32_ABI;
-}
-
 static int
 setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
-	int usig =3D ksig->sig;
-	sigset_t *set =3D sigmask_to_save();
-	compat_sigset_t *cset =3D (compat_sigset_t *) set;
-
 	/* Perform fixup for the pre-signal frame. */
 	rseq_signal_deliver(ksig, regs);
=20
 	/* Set up the stack frame */
 	if (is_ia32_frame(ksig)) {
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
-			return ia32_setup_rt_frame(usig, ksig, cset, regs);
+			return ia32_setup_rt_frame(ksig, regs);
 		else
-			return ia32_setup_frame(usig, ksig, cset, regs);
+			return ia32_setup_frame(ksig, regs);
 	} else if (is_x32_frame(ksig)) {
-		return x32_setup_rt_frame(ksig, cset, regs);
+		return x32_setup_rt_frame(ksig, regs);
 	} else {
-		return __setup_rt_frame(ksig->sig, ksig, set, regs);
+		return x64_setup_rt_frame(ksig, regs);
 	}
 }
=20
@@ -969,36 +406,3 @@ bool sigaltstack_size_valid(size_t ss_size)
 	return true;
 }
 #endif /* CONFIG_DYNAMIC_SIGFRAME */
-
-#ifdef CONFIG_X86_X32_ABI
-COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
-{
-	struct pt_regs *regs =3D current_pt_regs();
-	struct rt_sigframe_x32 __user *frame;
-	sigset_t set;
-	unsigned long uc_flags;
-
-	frame =3D (struct rt_sigframe_x32 __user *)(regs->sp - 8);
-
-	if (!access_ok(frame, sizeof(*frame)))
-		goto badframe;
-	if (__get_user(set.sig[0], (__u64 __user *)&frame->uc.uc_sigmask))
-		goto badframe;
-	if (__get_user(uc_flags, &frame->uc.uc_flags))
-		goto badframe;
-
-	set_current_blocked(&set);
-
-	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
-		goto badframe;
-
-	if (compat_restore_altstack(&frame->uc.uc_stack))
-		goto badframe;
-
-	return regs->ax;
-
-badframe:
-	signal_fault(regs, frame, "x32 rt_sigreturn");
-	return 0;
-}
-#endif
diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/kernel/signal_32.c
similarity index 82%
rename from arch/x86/ia32/ia32_signal.c
rename to arch/x86/kernel/signal_32.c
index c9c3859322fa..2553136cf39b 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/kernel/signal_32.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  linux/arch/x86_64/ia32/ia32_signal.c
- *
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *
  *  1997-11-28  Modified for POSIX.1b signals by Richard Henderson
@@ -26,7 +24,6 @@
 #include <linux/uaccess.h>
 #include <asm/fpu/signal.h>
 #include <asm/ptrace.h>
-#include <asm/ia32_unistd.h>
 #include <asm/user32.h>
 #include <uapi/asm/sigcontext.h>
 #include <asm/proto.h>
@@ -35,6 +32,9 @@
 #include <asm/sighandling.h>
 #include <asm/smap.h>
=20
+#ifdef CONFIG_IA32_EMULATION
+#include <asm/ia32_unistd.h>
+
 static inline void reload_segments(struct sigcontext_32 *sc)
 {
 	unsigned int cur;
@@ -53,6 +53,21 @@ static inline void reload_segments(struct sigcontext_32 *s=
c)
 		loadsegment(es, sc->es | 0x03);
 }
=20
+#define sigset32_t			compat_sigset_t
+#define restore_altstack32		compat_restore_altstack
+#define unsafe_save_altstack32		unsafe_compat_save_altstack
+
+#else
+
+#define sigset32_t			sigset_t
+#define __NR_ia32_sigreturn		__NR_sigreturn
+#define __NR_ia32_rt_sigreturn		__NR_rt_sigreturn
+#define restore_altstack32		restore_altstack
+#define unsafe_save_altstack32		unsafe_save_altstack
+#define __copy_siginfo_to_user32	copy_siginfo_to_user
+
+#endif
+
 /*
  * Do a signal return; undo the signal stack.
  */
@@ -86,6 +101,7 @@ static bool ia32_restore_sigcontext(struct pt_regs *regs,
 	/* disable syscall checks */
 	regs->orig_ax =3D -1;
=20
+#ifdef CONFIG_IA32_EMULATION
 	/*
 	 * Reload fs and gs if they have changed in the signal
 	 * handler.  This does not handle long fs/gs base changes in
@@ -93,10 +109,17 @@ static bool ia32_restore_sigcontext(struct pt_regs *regs,
 	 * normal case.
 	 */
 	reload_segments(&sc);
+#else
+	loadsegment(gs, sc.gs);
+	regs->fs =3D sc.fs;
+	regs->es =3D sc.es;
+	regs->ds =3D sc.ds;
+#endif
+
 	return fpu__restore_sig(compat_ptr(sc.fpstate), 1);
 }
=20
-COMPAT_SYSCALL_DEFINE0(sigreturn)
+SYSCALL32_DEFINE0(sigreturn)
 {
 	struct pt_regs *regs =3D current_pt_regs();
 	struct sigframe_ia32 __user *frame =3D (struct sigframe_ia32 __user *)(regs=
->sp-8);
@@ -119,7 +142,7 @@ COMPAT_SYSCALL_DEFINE0(sigreturn)
 	return 0;
 }
=20
-COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
+SYSCALL32_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs =3D current_pt_regs();
 	struct rt_sigframe_ia32 __user *frame;
@@ -129,7 +152,7 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
=20
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
-	if (__get_user(set.sig[0], (__u64 __user *)&frame->uc.uc_sigmask))
+	if (__get_user(*(__u64 *)&set, (__u64 __user *)&frame->uc.uc_sigmask))
 		goto badframe;
=20
 	set_current_blocked(&set);
@@ -137,7 +160,7 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 	if (!ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
 		goto badframe;
=20
-	if (compat_restore_altstack(&frame->uc.uc_stack))
+	if (restore_altstack32(&frame->uc.uc_stack))
 		goto badframe;
=20
 	return regs->ax;
@@ -159,9 +182,15 @@ __unsafe_setup_sigcontext32(struct sigcontext_32 __user =
*sc,
 			    struct pt_regs *regs, unsigned int mask)
 {
 	unsafe_put_user(get_user_seg(gs), (unsigned int __user *)&sc->gs, Efault);
+#ifdef CONFIG_IA32_EMULATION
 	unsafe_put_user(get_user_seg(fs), (unsigned int __user *)&sc->fs, Efault);
 	unsafe_put_user(get_user_seg(ds), (unsigned int __user *)&sc->ds, Efault);
 	unsafe_put_user(get_user_seg(es), (unsigned int __user *)&sc->es, Efault);
+#else
+	unsafe_put_user(regs->fs, (unsigned int __user *)&sc->fs, Efault);
+	unsafe_put_user(regs->es, (unsigned int __user *)&sc->es, Efault);
+	unsafe_put_user(regs->ds, (unsigned int __user *)&sc->ds, Efault);
+#endif
=20
 	unsafe_put_user(regs->di, &sc->di, Efault);
 	unsafe_put_user(regs->si, &sc->si, Efault);
@@ -196,43 +225,9 @@ do {									\
 		goto label;						\
 } while(0)
=20
-/*
- * Determine which stack to use..
- */
-static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
-				 size_t frame_size,
-				 void __user **fpstate)
-{
-	unsigned long sp, fx_aligned, math_size;
-
-	/* Default to using normal stack */
-	sp =3D regs->sp;
-
-	/* This is the X/Open sanctioned signal stack switching.  */
-	if (ksig->ka.sa.sa_flags & SA_ONSTACK)
-		sp =3D sigsp(sp, ksig);
-	/* This is the legacy signal stack switching. */
-	else if (regs->ss !=3D __USER32_DS &&
-		!(ksig->ka.sa.sa_flags & SA_RESTORER) &&
-		 ksig->ka.sa.sa_restorer)
-		sp =3D (unsigned long) ksig->ka.sa.sa_restorer;
-
-	sp =3D fpu__alloc_mathframe(sp, 1, &fx_aligned, &math_size);
-	*fpstate =3D (struct _fpstate_32 __user *) sp;
-	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
-				      math_size))
-		return (void __user *) -1L;
-
-	sp -=3D frame_size;
-	/* Align the stack pointer according to the i386 ABI,
-	 * i.e. so that on function entry ((sp + 4) & 15) =3D=3D 0. */
-	sp =3D ((sp + 4) & -16ul) - 4;
-	return (void __user *) sp;
-}
-
-int ia32_setup_frame(int sig, struct ksignal *ksig,
-		     compat_sigset_t *set, struct pt_regs *regs)
+int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
+	sigset32_t *set =3D (sigset32_t *) sigmask_to_save();
 	struct sigframe_ia32 __user *frame;
 	void __user *restorer;
 	void __user *fp =3D NULL;
@@ -264,7 +259,7 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
=20
-	unsafe_put_user(sig, &frame->sig, Efault);
+	unsafe_put_user(ksig->sig, &frame->sig, Efault);
 	unsafe_put_sigcontext32(&frame->sc, fp, regs, set, Efault);
 	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
 	unsafe_put_user(ptr_to_compat(restorer), &frame->pretcode, Efault);
@@ -280,15 +275,20 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	regs->ip =3D (unsigned long) ksig->ka.sa.sa_handler;
=20
 	/* Make -mregparm=3D3 work */
-	regs->ax =3D sig;
+	regs->ax =3D ksig->sig;
 	regs->dx =3D 0;
 	regs->cx =3D 0;
=20
-	loadsegment(ds, __USER32_DS);
-	loadsegment(es, __USER32_DS);
+#ifdef CONFIG_IA32_EMULATION
+	loadsegment(ds, __USER_DS);
+	loadsegment(es, __USER_DS);
+#else
+	regs->ds =3D __USER_DS;
+	regs->es =3D __USER_DS;
+#endif
=20
 	regs->cs =3D __USER32_CS;
-	regs->ss =3D __USER32_DS;
+	regs->ss =3D __USER_DS;
=20
 	return 0;
 Efault:
@@ -296,9 +296,9 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	return -EFAULT;
 }
=20
-int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
-			compat_sigset_t *set, struct pt_regs *regs)
+int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
+	sigset32_t *set =3D (sigset32_t *) sigmask_to_save();
 	struct rt_sigframe_ia32 __user *frame;
 	void __user *restorer;
 	void __user *fp =3D NULL;
@@ -321,7 +321,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
=20
-	unsafe_put_user(sig, &frame->sig, Efault);
+	unsafe_put_user(ksig->sig, &frame->sig, Efault);
 	unsafe_put_user(ptr_to_compat(&frame->info), &frame->pinfo, Efault);
 	unsafe_put_user(ptr_to_compat(&frame->uc), &frame->puc, Efault);
=20
@@ -331,7 +331,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	else
 		unsafe_put_user(0, &frame->uc.uc_flags, Efault);
 	unsafe_put_user(0, &frame->uc.uc_link, Efault);
-	unsafe_compat_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
+	unsafe_save_altstack32(&frame->uc.uc_stack, regs->sp, Efault);
=20
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer =3D ksig->ka.sa.sa_restorer;
@@ -357,15 +357,20 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	regs->ip =3D (unsigned long) ksig->ka.sa.sa_handler;
=20
 	/* Make -mregparm=3D3 work */
-	regs->ax =3D sig;
+	regs->ax =3D ksig->sig;
 	regs->dx =3D (unsigned long) &frame->info;
 	regs->cx =3D (unsigned long) &frame->uc;
=20
-	loadsegment(ds, __USER32_DS);
-	loadsegment(es, __USER32_DS);
+#ifdef CONFIG_IA32_EMULATION
+	loadsegment(ds, __USER_DS);
+	loadsegment(es, __USER_DS);
+#else
+	regs->ds =3D __USER_DS;
+	regs->es =3D __USER_DS;
+#endif
=20
 	regs->cs =3D __USER32_CS;
-	regs->ss =3D __USER32_DS;
+	regs->ss =3D __USER_DS;
=20
 	return 0;
 Efault:
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
new file mode 100644
index 000000000000..ff9c55064223
--- /dev/null
+++ b/arch/x86/kernel/signal_64.c
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *  Copyright (C) 2000, 2001, 2002 Andi Kleen SuSE Labs
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/unistd.h>
+#include <linux/uaccess.h>
+#include <linux/syscalls.h>
+
+#include <asm/ucontext.h>
+#include <asm/fpu/signal.h>
+#include <asm/sighandling.h>
+
+#include <asm/syscall.h>
+#include <asm/sigframe.h>
+#include <asm/signal.h>
+
+/*
+ * If regs->ss will cause an IRET fault, change it.  Otherwise leave it
+ * alone.  Using this generally makes no sense unless
+ * user_64bit_mode(regs) would return true.
+ */
+static void force_valid_ss(struct pt_regs *regs)
+{
+	u32 ar;
+	asm volatile ("lar %[old_ss], %[ar]\n\t"
+		      "jz 1f\n\t"		/* If invalid: */
+		      "xorl %[ar], %[ar]\n\t"	/* set ar =3D 0 */
+		      "1:"
+		      : [ar] "=3Dr" (ar)
+		      : [old_ss] "rm" ((u16)regs->ss));
+
+	/*
+	 * For a valid 64-bit user context, we need DPL 3, type
+	 * read-write data or read-write exp-down data, and S and P
+	 * set.  We can't use VERW because VERW doesn't check the
+	 * P bit.
+	 */
+	ar &=3D AR_DPL_MASK | AR_S | AR_P | AR_TYPE_MASK;
+	if (ar !=3D (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA) &&
+	    ar !=3D (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA_EXPDOWN))
+		regs->ss =3D __USER_DS;
+}
+
+static bool restore_sigcontext(struct pt_regs *regs,
+			       struct sigcontext __user *usc,
+			       unsigned long uc_flags)
+{
+	struct sigcontext sc;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current->restart_block.fn =3D do_no_restart_syscall;
+
+	if (copy_from_user(&sc, usc, offsetof(struct sigcontext, reserved1)))
+		return false;
+
+	regs->bx =3D sc.bx;
+	regs->cx =3D sc.cx;
+	regs->dx =3D sc.dx;
+	regs->si =3D sc.si;
+	regs->di =3D sc.di;
+	regs->bp =3D sc.bp;
+	regs->ax =3D sc.ax;
+	regs->sp =3D sc.sp;
+	regs->ip =3D sc.ip;
+	regs->r8 =3D sc.r8;
+	regs->r9 =3D sc.r9;
+	regs->r10 =3D sc.r10;
+	regs->r11 =3D sc.r11;
+	regs->r12 =3D sc.r12;
+	regs->r13 =3D sc.r13;
+	regs->r14 =3D sc.r14;
+	regs->r15 =3D sc.r15;
+
+	/* Get CS/SS and force CPL3 */
+	regs->cs =3D sc.cs | 0x03;
+	regs->ss =3D sc.ss | 0x03;
+
+	regs->flags =3D (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
+	/* disable syscall checks */
+	regs->orig_ax =3D -1;
+
+	/*
+	 * Fix up SS if needed for the benefit of old DOSEMU and
+	 * CRIU.
+	 */
+	if (unlikely(!(uc_flags & UC_STRICT_RESTORE_SS) && user_64bit_mode(regs)))
+		force_valid_ss(regs);
+
+	return fpu__restore_sig((void __user *)sc.fpstate, 0);
+}
+
+static __always_inline int
+__unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
+		     struct pt_regs *regs, unsigned long mask)
+{
+	unsafe_put_user(regs->di, &sc->di, Efault);
+	unsafe_put_user(regs->si, &sc->si, Efault);
+	unsafe_put_user(regs->bp, &sc->bp, Efault);
+	unsafe_put_user(regs->sp, &sc->sp, Efault);
+	unsafe_put_user(regs->bx, &sc->bx, Efault);
+	unsafe_put_user(regs->dx, &sc->dx, Efault);
+	unsafe_put_user(regs->cx, &sc->cx, Efault);
+	unsafe_put_user(regs->ax, &sc->ax, Efault);
+	unsafe_put_user(regs->r8, &sc->r8, Efault);
+	unsafe_put_user(regs->r9, &sc->r9, Efault);
+	unsafe_put_user(regs->r10, &sc->r10, Efault);
+	unsafe_put_user(regs->r11, &sc->r11, Efault);
+	unsafe_put_user(regs->r12, &sc->r12, Efault);
+	unsafe_put_user(regs->r13, &sc->r13, Efault);
+	unsafe_put_user(regs->r14, &sc->r14, Efault);
+	unsafe_put_user(regs->r15, &sc->r15, Efault);
+
+	unsafe_put_user(current->thread.trap_nr, &sc->trapno, Efault);
+	unsafe_put_user(current->thread.error_code, &sc->err, Efault);
+	unsafe_put_user(regs->ip, &sc->ip, Efault);
+	unsafe_put_user(regs->flags, &sc->flags, Efault);
+	unsafe_put_user(regs->cs, &sc->cs, Efault);
+	unsafe_put_user(0, &sc->gs, Efault);
+	unsafe_put_user(0, &sc->fs, Efault);
+	unsafe_put_user(regs->ss, &sc->ss, Efault);
+
+	unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);
+
+	/* non-iBCS2 extensions.. */
+	unsafe_put_user(mask, &sc->oldmask, Efault);
+	unsafe_put_user(current->thread.cr2, &sc->cr2, Efault);
+	return 0;
+Efault:
+	return -EFAULT;
+}
+
+#define unsafe_put_sigcontext(sc, fp, regs, set, label)			\
+do {									\
+	if (__unsafe_setup_sigcontext(sc, fp, regs, set->sig[0]))	\
+		goto label;						\
+} while(0);
+
+#define unsafe_put_sigmask(set, frame, label) \
+	unsafe_put_user(*(__u64 *)(set), \
+			(__u64 __user *)&(frame)->uc.uc_sigmask, \
+			label)
+
+static unsigned long frame_uc_flags(struct pt_regs *regs)
+{
+	unsigned long flags;
+
+	if (boot_cpu_has(X86_FEATURE_XSAVE))
+		flags =3D UC_FP_XSTATE | UC_SIGCONTEXT_SS;
+	else
+		flags =3D UC_SIGCONTEXT_SS;
+
+	if (likely(user_64bit_mode(regs)))
+		flags |=3D UC_STRICT_RESTORE_SS;
+
+	return flags;
+}
+
+int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+{
+	sigset_t *set =3D sigmask_to_save();
+	struct rt_sigframe __user *frame;
+	void __user *fp =3D NULL;
+	unsigned long uc_flags;
+
+	/* x86-64 should always use SA_RESTORER. */
+	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
+		return -EFAULT;
+
+	frame =3D get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp);
+	uc_flags =3D frame_uc_flags(regs);
+
+	if (!user_access_begin(frame, sizeof(*frame)))
+		return -EFAULT;
+
+	/* Create the ucontext.  */
+	unsafe_put_user(uc_flags, &frame->uc.uc_flags, Efault);
+	unsafe_put_user(0, &frame->uc.uc_link, Efault);
+	unsafe_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
+
+	/* Set up to return from userspace.  If provided, use a stub
+	   already in userspace.  */
+	unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);
+	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
+	unsafe_put_sigmask(set, frame, Efault);
+	user_access_end();
+
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
+		if (copy_siginfo_to_user(&frame->info, &ksig->info))
+			return -EFAULT;
+	}
+
+	/* Set up registers for signal handler */
+	regs->di =3D ksig->sig;
+	/* In case the signal handler was declared without prototypes */
+	regs->ax =3D 0;
+
+	/* This also works for non SA_SIGINFO handlers because they expect the
+	   next argument after the signal number on the stack. */
+	regs->si =3D (unsigned long)&frame->info;
+	regs->dx =3D (unsigned long)&frame->uc;
+	regs->ip =3D (unsigned long) ksig->ka.sa.sa_handler;
+
+	regs->sp =3D (unsigned long)frame;
+
+	/*
+	 * Set up the CS and SS registers to run signal handlers in
+	 * 64-bit mode, even if the handler happens to be interrupting
+	 * 32-bit or 16-bit code.
+	 *
+	 * SS is subtle.  In 64-bit mode, we don't need any particular
+	 * SS descriptor, but we do need SS to be valid.  It's possible
+	 * that the old SS is entirely bogus -- this can happen if the
+	 * signal we're trying to deliver is #GP or #SS caused by a bad
+	 * SS value.  We also have a compatibility issue here: DOSEMU
+	 * relies on the contents of the SS register indicating the
+	 * SS value at the time of the signal, even though that code in
+	 * DOSEMU predates sigreturn's ability to restore SS.  (DOSEMU
+	 * avoids relying on sigreturn to restore SS; instead it uses
+	 * a trampoline.)  So we do our best: if the old SS was valid,
+	 * we keep it.  Otherwise we replace it.
+	 */
+	regs->cs =3D __USER_CS;
+
+	if (unlikely(regs->ss !=3D __USER_DS))
+		force_valid_ss(regs);
+
+	return 0;
+
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
+
+/*
+ * Do a signal return; undo the signal stack.
+ */
+SYSCALL_DEFINE0(rt_sigreturn)
+{
+	struct pt_regs *regs =3D current_pt_regs();
+	struct rt_sigframe __user *frame;
+	sigset_t set;
+	unsigned long uc_flags;
+
+	frame =3D (struct rt_sigframe __user *)(regs->sp - sizeof(long));
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+	if (__get_user(*(__u64 *)&set, (__u64 __user *)&frame->uc.uc_sigmask))
+		goto badframe;
+	if (__get_user(uc_flags, &frame->uc.uc_flags))
+		goto badframe;
+
+	set_current_blocked(&set);
+
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+		goto badframe;
+
+	if (restore_altstack(&frame->uc.uc_stack))
+		goto badframe;
+
+	return regs->ax;
+
+badframe:
+	signal_fault(regs, frame, "rt_sigreturn");
+	return 0;
+}
+
+#ifdef CONFIG_X86_X32_ABI
+static int x32_copy_siginfo_to_user(struct compat_siginfo __user *to,
+		const struct kernel_siginfo *from)
+{
+	struct compat_siginfo new;
+
+	copy_siginfo_to_external32(&new, from);
+	if (from->si_signo =3D=3D SIGCHLD) {
+		new._sifields._sigchld_x32._utime =3D from->si_utime;
+		new._sifields._sigchld_x32._stime =3D from->si_stime;
+	}
+	if (copy_to_user(to, &new, sizeof(struct compat_siginfo)))
+		return -EFAULT;
+	return 0;
+}
+
+int copy_siginfo_to_user32(struct compat_siginfo __user *to,
+			   const struct kernel_siginfo *from)
+{
+	if (in_x32_syscall())
+		return x32_copy_siginfo_to_user(to, from);
+	return __copy_siginfo_to_user32(to, from);
+}
+
+int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+{
+	compat_sigset_t *set =3D (compat_sigset_t *) sigmask_to_save();
+	struct rt_sigframe_x32 __user *frame;
+	unsigned long uc_flags;
+	void __user *restorer;
+	void __user *fp =3D NULL;
+
+	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
+		return -EFAULT;
+
+	frame =3D get_sigframe(ksig, regs, sizeof(*frame), &fp);
+
+	uc_flags =3D frame_uc_flags(regs);
+
+	if (!user_access_begin(frame, sizeof(*frame)))
+		return -EFAULT;
+
+	/* Create the ucontext.  */
+	unsafe_put_user(uc_flags, &frame->uc.uc_flags, Efault);
+	unsafe_put_user(0, &frame->uc.uc_link, Efault);
+	unsafe_compat_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
+	unsafe_put_user(0, &frame->uc.uc__pad0, Efault);
+	restorer =3D ksig->ka.sa.sa_restorer;
+	unsafe_put_user(restorer, (unsigned long __user *)&frame->pretcode, Efault);
+	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
+	unsafe_put_sigmask(set, frame, Efault);
+	user_access_end();
+
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
+		if (x32_copy_siginfo_to_user(&frame->info, &ksig->info))
+			return -EFAULT;
+	}
+
+	/* Set up registers for signal handler */
+	regs->sp =3D (unsigned long) frame;
+	regs->ip =3D (unsigned long) ksig->ka.sa.sa_handler;
+
+	/* We use the x32 calling convention here... */
+	regs->di =3D ksig->sig;
+	regs->si =3D (unsigned long) &frame->info;
+	regs->dx =3D (unsigned long) &frame->uc;
+
+	loadsegment(ds, __USER_DS);
+	loadsegment(es, __USER_DS);
+
+	regs->cs =3D __USER_CS;
+	regs->ss =3D __USER_DS;
+
+	return 0;
+
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
+
+COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
+{
+	struct pt_regs *regs =3D current_pt_regs();
+	struct rt_sigframe_x32 __user *frame;
+	sigset_t set;
+	unsigned long uc_flags;
+
+	frame =3D (struct rt_sigframe_x32 __user *)(regs->sp - 8);
+
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+	if (__get_user(set.sig[0], (__u64 __user *)&frame->uc.uc_sigmask))
+		goto badframe;
+	if (__get_user(uc_flags, &frame->uc.uc_flags))
+		goto badframe;
+
+	set_current_blocked(&set);
+
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+		goto badframe;
+
+	if (compat_restore_altstack(&frame->uc.uc_stack))
+		goto badframe;
+
+	return regs->ax;
+
+badframe:
+	signal_fault(regs, frame, "x32 rt_sigreturn");
+	return 0;
+}
+#endif /* CONFIG_X86_X32_ABI */
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 6b4fdf6b9542..4a184f6e4e4d 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -262,10 +262,10 @@ SYM_CODE_START(xen_entry_SYSCALL_compat)
=20
 	/*
 	 * Neither Xen nor the kernel really knows what the old SS and
-	 * CS were.  The kernel expects __USER32_DS and __USER32_CS, so
+	 * CS were.  The kernel expects __USER_DS and __USER32_CS, so
 	 * report those values even though Xen will guess its own values.
 	 */
-	movq $__USER32_DS, 4*8(%rsp)
+	movq $__USER_DS, 4*8(%rsp)
 	movq $__USER32_CS, 1*8(%rsp)
=20
 	jmp entry_SYSCALL_compat_after_hwframe
@@ -284,10 +284,10 @@ SYM_CODE_START(xen_entry_SYSENTER_compat)
=20
 	/*
 	 * Neither Xen nor the kernel really knows what the old SS and
-	 * CS were.  The kernel expects __USER32_DS and __USER32_CS, so
+	 * CS were.  The kernel expects __USER_DS and __USER32_CS, so
 	 * report those values even though Xen will guess its own values.
 	 */
-	movq $__USER32_DS, 4*8(%rsp)
+	movq $__USER_DS, 4*8(%rsp)
 	movq $__USER32_CS, 1*8(%rsp)
=20
 	jmp entry_SYSENTER_compat_after_hwframe
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 594357881b0b..44b1736c95b5 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -126,11 +126,9 @@ struct compat_tms {
=20
 #define _COMPAT_NSIG_WORDS	(_COMPAT_NSIG / _COMPAT_NSIG_BPW)
=20
-#ifndef compat_sigset_t
 typedef struct {
 	compat_sigset_word	sig[_COMPAT_NSIG_WORDS];
 } compat_sigset_t;
-#endif
=20
 int set_compat_user_sigmask(const compat_sigset_t __user *umask,
 			    size_t sigsetsize);
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a34b0f9a9972..33a0ee3bcb2e 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -264,6 +264,7 @@ static inline int is_syscall_trace_event(struct trace_eve=
nt_call *tp_event)
 #define SC_VAL64(type, name) ((type) name##_hi << 32 | name##_lo)
=20
 #ifdef CONFIG_COMPAT
+#define SYSCALL32_DEFINE0 COMPAT_SYSCALL_DEFINE0
 #define SYSCALL32_DEFINE1 COMPAT_SYSCALL_DEFINE1
 #define SYSCALL32_DEFINE2 COMPAT_SYSCALL_DEFINE2
 #define SYSCALL32_DEFINE3 COMPAT_SYSCALL_DEFINE3
@@ -271,6 +272,7 @@ static inline int is_syscall_trace_event(struct trace_eve=
nt_call *tp_event)
 #define SYSCALL32_DEFINE5 COMPAT_SYSCALL_DEFINE5
 #define SYSCALL32_DEFINE6 COMPAT_SYSCALL_DEFINE6
 #else
+#define SYSCALL32_DEFINE0 SYSCALL_DEFINE0
 #define SYSCALL32_DEFINE1 SYSCALL_DEFINE1
 #define SYSCALL32_DEFINE2 SYSCALL_DEFINE2
 #define SYSCALL32_DEFINE3 SYSCALL_DEFINE3

