Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F3F6043B2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiJSLqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiJSLq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:46:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C85816698D;
        Wed, 19 Oct 2022 04:26:03 -0700 (PDT)
Date:   Wed, 19 Oct 2022 08:55:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666169746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpE7JN0J712AZTmfXkF1mMEdtzSAWR1Ait6md6beY2w=;
        b=u7aTr816RwOQh5w9fJySbVsQwV6gPRlsXYJOmolI9WU75Idy5l+xC/CKfXS17W2ruBXzlz
        2Palsakd/SStzVhBJOQa5JgJWYo9T7mPb27QEZKtJ9yf8Xe50btsFHVfs5RT/Y13C2EsTp
        zHNME6A8d/OutJnJIvqWPeVsMC9DLV3mwNOxQZ9OIUA7AMJsWPuojKBUCNA+Ef9HuMVy47
        I1Fg4NM277XLY1pPk99t1HhRz32O667qRmWF0e7dDXUoKr+gMV7TTMHt3qS2pMVq+vQEDd
        e1G56R0MxM3vMbIQULMP4OZWOPA39f44Cvg4j5XQsyg0lrDDGajByMBg2P+lSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666169746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpE7JN0J712AZTmfXkF1mMEdtzSAWR1Ait6md6beY2w=;
        b=X4zC+5oxSegXisLdnb3HqqYpDYSPe938MJDpEM0v1/TMBR0zP2rgtpU3qnGW/QKEqP+d+x
        iZdbSZXXVN6DLLBw==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/signal/32: Merge native and compat 32-bit signal code
Cc:     Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220606203802.158958-8-brgerst@gmail.com>
References: <20220606203802.158958-8-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <166616974172.401.10111186283861148120.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     24e6dc35ccd825de7c71751610ff8f3295347e5b
Gitweb:        https://git.kernel.org/tip/24e6dc35ccd825de7c71751610ff8f3295347e5b
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 06 Jun 2022 16:38:01 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 Oct 2022 09:58:49 +02:00

x86/signal/32: Merge native and compat 32-bit signal code

There are significant differences between signal handling on 32-bit vs.
64-bit, like different structure layouts and legacy syscalls.  Instead
of duplicating that code for native and compat, merge both versions
into one file.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lore.kernel.org/r/20220606203802.158958-8-brgerst@gmail.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/ia32/Makefile         |   2 +-
 arch/x86/ia32/ia32_signal.c    | 340 +-----------------------------
 arch/x86/include/asm/segment.h |   1 +-
 arch/x86/kernel/Makefile       |   4 +-
 arch/x86/kernel/signal.c       | 219 +------------------
 arch/x86/kernel/signal_32.c    | 379 ++++++++++++++++++++++++++++++++-
 include/linux/syscalls.h       |   2 +-
 7 files changed, 390 insertions(+), 557 deletions(-)
 delete mode 100644 arch/x86/ia32/ia32_signal.c
 create mode 100644 arch/x86/kernel/signal_32.c

diff --git a/arch/x86/ia32/Makefile b/arch/x86/ia32/Makefile
index e481056..333556a 100644
--- a/arch/x86/ia32/Makefile
+++ b/arch/x86/ia32/Makefile
@@ -3,7 +3,5 @@
 # Makefile for the ia32 kernel emulation subsystem.
 #
 
-obj-$(CONFIG_IA32_EMULATION) := ia32_signal.o
-
 audit-class-$(CONFIG_AUDIT) := audit.o
 obj-$(CONFIG_IA32_EMULATION) += $(audit-class-y)
diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
deleted file mode 100644
index e28421f..0000000
--- a/arch/x86/ia32/ia32_signal.c
+++ /dev/null
@@ -1,340 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *  linux/arch/x86_64/ia32/ia32_signal.c
- *
- *  Copyright (C) 1991, 1992  Linus Torvalds
- *
- *  1997-11-28  Modified for POSIX.1b signals by Richard Henderson
- *  2000-06-20  Pentium III FXSR, SSE support by Gareth Hughes
- *  2000-12-*   x86-64 compatibility mode signal handling by Andi Kleen
- */
-
-#include <linux/sched.h>
-#include <linux/sched/task_stack.h>
-#include <linux/mm.h>
-#include <linux/smp.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/wait.h>
-#include <linux/unistd.h>
-#include <linux/stddef.h>
-#include <linux/personality.h>
-#include <linux/compat.h>
-#include <linux/binfmts.h>
-#include <linux/syscalls.h>
-#include <asm/ucontext.h>
-#include <linux/uaccess.h>
-#include <asm/fpu/signal.h>
-#include <asm/ptrace.h>
-#include <asm/ia32_unistd.h>
-#include <asm/user32.h>
-#include <uapi/asm/sigcontext.h>
-#include <asm/proto.h>
-#include <asm/vdso.h>
-#include <asm/sigframe.h>
-#include <asm/sighandling.h>
-#include <asm/smap.h>
-
-static inline void reload_segments(struct sigcontext_32 *sc)
-{
-	unsigned int cur;
-
-	savesegment(gs, cur);
-	if ((sc->gs | 0x03) != cur)
-		load_gs_index(sc->gs | 0x03);
-	savesegment(fs, cur);
-	if ((sc->fs | 0x03) != cur)
-		loadsegment(fs, sc->fs | 0x03);
-	savesegment(ds, cur);
-	if ((sc->ds | 0x03) != cur)
-		loadsegment(ds, sc->ds | 0x03);
-	savesegment(es, cur);
-	if ((sc->es | 0x03) != cur)
-		loadsegment(es, sc->es | 0x03);
-}
-
-/*
- * Do a signal return; undo the signal stack.
- */
-static bool ia32_restore_sigcontext(struct pt_regs *regs,
-				    struct sigcontext_32 __user *usc)
-{
-	struct sigcontext_32 sc;
-
-	/* Always make any pending restarted system calls return -EINTR */
-	current->restart_block.fn = do_no_restart_syscall;
-
-	if (unlikely(copy_from_user(&sc, usc, sizeof(sc))))
-		return false;
-
-	/* Get only the ia32 registers. */
-	regs->bx = sc.bx;
-	regs->cx = sc.cx;
-	regs->dx = sc.dx;
-	regs->si = sc.si;
-	regs->di = sc.di;
-	regs->bp = sc.bp;
-	regs->ax = sc.ax;
-	regs->sp = sc.sp;
-	regs->ip = sc.ip;
-
-	/* Get CS/SS and force CPL3 */
-	regs->cs = sc.cs | 0x03;
-	regs->ss = sc.ss | 0x03;
-
-	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
-	/* disable syscall checks */
-	regs->orig_ax = -1;
-
-	/*
-	 * Reload fs and gs if they have changed in the signal
-	 * handler.  This does not handle long fs/gs base changes in
-	 * the handler, but does not clobber them at least in the
-	 * normal case.
-	 */
-	reload_segments(&sc);
-	return fpu__restore_sig(compat_ptr(sc.fpstate), 1);
-}
-
-COMPAT_SYSCALL_DEFINE0(sigreturn)
-{
-	struct pt_regs *regs = current_pt_regs();
-	struct sigframe_ia32 __user *frame = (struct sigframe_ia32 __user *)(regs->sp-8);
-	sigset_t set;
-
-	if (!access_ok(frame, sizeof(*frame)))
-		goto badframe;
-	if (__get_user(set.sig[0], &frame->sc.oldmask)
-	    || __get_user(((__u32 *)&set)[1], &frame->extramask[0]))
-		goto badframe;
-
-	set_current_blocked(&set);
-
-	if (!ia32_restore_sigcontext(regs, &frame->sc))
-		goto badframe;
-	return regs->ax;
-
-badframe:
-	signal_fault(regs, frame, "32bit sigreturn");
-	return 0;
-}
-
-COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
-{
-	struct pt_regs *regs = current_pt_regs();
-	struct rt_sigframe_ia32 __user *frame;
-	sigset_t set;
-
-	frame = (struct rt_sigframe_ia32 __user *)(regs->sp - 4);
-
-	if (!access_ok(frame, sizeof(*frame)))
-		goto badframe;
-	if (__get_user(set.sig[0], (__u64 __user *)&frame->uc.uc_sigmask))
-		goto badframe;
-
-	set_current_blocked(&set);
-
-	if (!ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
-		goto badframe;
-
-	if (compat_restore_altstack(&frame->uc.uc_stack))
-		goto badframe;
-
-	return regs->ax;
-
-badframe:
-	signal_fault(regs, frame, "32bit rt sigreturn");
-	return 0;
-}
-
-/*
- * Set up a signal frame.
- */
-
-#define get_user_seg(seg)	({ unsigned int v; savesegment(seg, v); v; })
-
-static __always_inline int
-__unsafe_setup_sigcontext32(struct sigcontext_32 __user *sc,
-			    void __user *fpstate,
-			    struct pt_regs *regs, unsigned int mask)
-{
-	unsafe_put_user(get_user_seg(gs), (unsigned int __user *)&sc->gs, Efault);
-	unsafe_put_user(get_user_seg(fs), (unsigned int __user *)&sc->fs, Efault);
-	unsafe_put_user(get_user_seg(ds), (unsigned int __user *)&sc->ds, Efault);
-	unsafe_put_user(get_user_seg(es), (unsigned int __user *)&sc->es, Efault);
-
-	unsafe_put_user(regs->di, &sc->di, Efault);
-	unsafe_put_user(regs->si, &sc->si, Efault);
-	unsafe_put_user(regs->bp, &sc->bp, Efault);
-	unsafe_put_user(regs->sp, &sc->sp, Efault);
-	unsafe_put_user(regs->bx, &sc->bx, Efault);
-	unsafe_put_user(regs->dx, &sc->dx, Efault);
-	unsafe_put_user(regs->cx, &sc->cx, Efault);
-	unsafe_put_user(regs->ax, &sc->ax, Efault);
-	unsafe_put_user(current->thread.trap_nr, &sc->trapno, Efault);
-	unsafe_put_user(current->thread.error_code, &sc->err, Efault);
-	unsafe_put_user(regs->ip, &sc->ip, Efault);
-	unsafe_put_user(regs->cs, (unsigned int __user *)&sc->cs, Efault);
-	unsafe_put_user(regs->flags, &sc->flags, Efault);
-	unsafe_put_user(regs->sp, &sc->sp_at_signal, Efault);
-	unsafe_put_user(regs->ss, (unsigned int __user *)&sc->ss, Efault);
-
-	unsafe_put_user(ptr_to_compat(fpstate), &sc->fpstate, Efault);
-
-	/* non-iBCS2 extensions.. */
-	unsafe_put_user(mask, &sc->oldmask, Efault);
-	unsafe_put_user(current->thread.cr2, &sc->cr2, Efault);
-	return 0;
-
-Efault:
-	return -EFAULT;
-}
-
-#define unsafe_put_sigcontext32(sc, fp, regs, set, label)		\
-do {									\
-	if (__unsafe_setup_sigcontext32(sc, fp, regs, set->sig[0]))	\
-		goto label;						\
-} while(0)
-
-int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
-{
-	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
-	struct sigframe_ia32 __user *frame;
-	void __user *restorer;
-	void __user *fp = NULL;
-
-	/* copy_to_user optimizes that into a single 8 byte store */
-	static const struct {
-		u16 poplmovl;
-		u32 val;
-		u16 int80;
-	} __attribute__((packed)) code = {
-		0xb858,		 /* popl %eax ; movl $...,%eax */
-		__NR_ia32_sigreturn,
-		0x80cd,		/* int $0x80 */
-	};
-
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
-
-	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
-		restorer = ksig->ka.sa.sa_restorer;
-	} else {
-		/* Return stub is in 32bit vsyscall page */
-		if (current->mm->context.vdso)
-			restorer = current->mm->context.vdso +
-				vdso_image_32.sym___kernel_sigreturn;
-		else
-			restorer = &frame->retcode;
-	}
-
-	if (!user_access_begin(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	unsafe_put_user(ksig->sig, &frame->sig, Efault);
-	unsafe_put_sigcontext32(&frame->sc, fp, regs, set, Efault);
-	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
-	unsafe_put_user(ptr_to_compat(restorer), &frame->pretcode, Efault);
-	/*
-	 * These are actually not used anymore, but left because some
-	 * gdb versions depend on them as a marker.
-	 */
-	unsafe_put_user(*((u64 *)&code), (u64 __user *)frame->retcode, Efault);
-	user_access_end();
-
-	/* Set up registers for signal handler */
-	regs->sp = (unsigned long) frame;
-	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
-
-	/* Make -mregparm=3 work */
-	regs->ax = ksig->sig;
-	regs->dx = 0;
-	regs->cx = 0;
-
-	loadsegment(ds, __USER_DS);
-	loadsegment(es, __USER_DS);
-
-	regs->cs = __USER32_CS;
-	regs->ss = __USER_DS;
-
-	return 0;
-Efault:
-	user_access_end();
-	return -EFAULT;
-}
-
-int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
-{
-	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
-	struct rt_sigframe_ia32 __user *frame;
-	void __user *restorer;
-	void __user *fp = NULL;
-
-	/* unsafe_put_user optimizes that into a single 8 byte store */
-	static const struct {
-		u8 movl;
-		u32 val;
-		u16 int80;
-		u8  pad;
-	} __attribute__((packed)) code = {
-		0xb8,
-		__NR_ia32_rt_sigreturn,
-		0x80cd,
-		0,
-	};
-
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
-
-	if (!user_access_begin(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	unsafe_put_user(ksig->sig, &frame->sig, Efault);
-	unsafe_put_user(ptr_to_compat(&frame->info), &frame->pinfo, Efault);
-	unsafe_put_user(ptr_to_compat(&frame->uc), &frame->puc, Efault);
-
-	/* Create the ucontext.  */
-	if (static_cpu_has(X86_FEATURE_XSAVE))
-		unsafe_put_user(UC_FP_XSTATE, &frame->uc.uc_flags, Efault);
-	else
-		unsafe_put_user(0, &frame->uc.uc_flags, Efault);
-	unsafe_put_user(0, &frame->uc.uc_link, Efault);
-	unsafe_compat_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
-
-	if (ksig->ka.sa.sa_flags & SA_RESTORER)
-		restorer = ksig->ka.sa.sa_restorer;
-	else
-		restorer = current->mm->context.vdso +
-			vdso_image_32.sym___kernel_rt_sigreturn;
-	unsafe_put_user(ptr_to_compat(restorer), &frame->pretcode, Efault);
-
-	/*
-	 * Not actually used anymore, but left because some gdb
-	 * versions need it.
-	 */
-	unsafe_put_user(*((u64 *)&code), (u64 __user *)frame->retcode, Efault);
-	unsafe_put_sigcontext32(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask, Efault);
-	user_access_end();
-
-	if (__copy_siginfo_to_user32(&frame->info, &ksig->info))
-		return -EFAULT;
-
-	/* Set up registers for signal handler */
-	regs->sp = (unsigned long) frame;
-	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
-
-	/* Make -mregparm=3 work */
-	regs->ax = ksig->sig;
-	regs->dx = (unsigned long) &frame->info;
-	regs->cx = (unsigned long) &frame->uc;
-
-	loadsegment(ds, __USER_DS);
-	loadsegment(es, __USER_DS);
-
-	regs->cs = __USER32_CS;
-	regs->ss = __USER_DS;
-
-	return 0;
-Efault:
-	user_access_end();
-	return -EFAULT;
-}
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index e056c29..c390a67 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -135,6 +135,7 @@
 #define __KERNEL_DS			(GDT_ENTRY_KERNEL_DS*8)
 #define __USER_DS			(GDT_ENTRY_DEFAULT_USER_DS*8 + 3)
 #define __USER_CS			(GDT_ENTRY_DEFAULT_USER_CS*8 + 3)
+#define __USER32_CS			__USER_CS
 #define __ESPFIX_SS			(GDT_ENTRY_ESPFIX_SS*8)
 
 /* segment for calling fn: */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f901658..72e1371 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -53,8 +53,8 @@ obj-y			+= setup.o x86_init.o i8259.o irqinit.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_IRQ_WORK)  += irq_work.o
 obj-y			+= probe_roms.o
-obj-$(CONFIG_X86_32)	+= sys_ia32.o
-obj-$(CONFIG_IA32_EMULATION)	+= sys_ia32.o
+obj-$(CONFIG_X86_32)	+= sys_ia32.o signal_32.o
+obj-$(CONFIG_IA32_EMULATION)	+= sys_ia32.o signal_32.o
 obj-$(CONFIG_X86_64)	+= sys_x86_64.o
 obj-$(CONFIG_X86_ESPFIX64)	+= espfix_64.o
 obj-$(CONFIG_SYSFS)	+= ksysfs.o
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 0511e05..962cfd8 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -92,10 +92,6 @@ static void force_valid_ss(struct pt_regs *regs)
 	    ar != (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA_EXPDOWN))
 		regs->ss = __USER_DS;
 }
-# define CONTEXT_COPY_SIZE	offsetof(struct sigcontext, reserved1)
-#else
-# define CONTEXT_COPY_SIZE	sizeof(struct sigcontext)
-#endif
 
 static bool restore_sigcontext(struct pt_regs *regs,
 			       struct sigcontext __user *usc,
@@ -106,16 +102,9 @@ static bool restore_sigcontext(struct pt_regs *regs,
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
-	if (copy_from_user(&sc, usc, CONTEXT_COPY_SIZE))
+	if (copy_from_user(&sc, usc, offsetof(struct sigcontext, reserved1)))
 		return false;
 
-#ifdef CONFIG_X86_32
-	loadsegment(gs, sc.gs);
-	regs->fs = sc.fs;
-	regs->es = sc.es;
-	regs->ds = sc.ds;
-#endif /* CONFIG_X86_32 */
-
 	regs->bx = sc.bx;
 	regs->cx = sc.cx;
 	regs->dx = sc.dx;
@@ -125,8 +114,6 @@ static bool restore_sigcontext(struct pt_regs *regs,
 	regs->ax = sc.ax;
 	regs->sp = sc.sp;
 	regs->ip = sc.ip;
-
-#ifdef CONFIG_X86_64
 	regs->r8 = sc.r8;
 	regs->r9 = sc.r9;
 	regs->r10 = sc.r10;
@@ -135,7 +122,6 @@ static bool restore_sigcontext(struct pt_regs *regs,
 	regs->r13 = sc.r13;
 	regs->r14 = sc.r14;
 	regs->r15 = sc.r15;
-#endif /* CONFIG_X86_64 */
 
 	/* Get CS/SS and force CPL3 */
 	regs->cs = sc.cs | 0x03;
@@ -145,33 +131,20 @@ static bool restore_sigcontext(struct pt_regs *regs,
 	/* disable syscall checks */
 	regs->orig_ax = -1;
 
-#ifdef CONFIG_X86_64
 	/*
 	 * Fix up SS if needed for the benefit of old DOSEMU and
 	 * CRIU.
 	 */
 	if (unlikely(!(uc_flags & UC_STRICT_RESTORE_SS) && user_64bit_mode(regs)))
 		force_valid_ss(regs);
-#endif
 
-	return fpu__restore_sig((void __user *)sc.fpstate,
-			       IS_ENABLED(CONFIG_X86_32));
+	return fpu__restore_sig((void __user *)sc.fpstate, 0);
 }
 
 static __always_inline int
 __unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 		     struct pt_regs *regs, unsigned long mask)
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
 	unsafe_put_user(regs->di, &sc->di, Efault);
 	unsafe_put_user(regs->si, &sc->si, Efault);
 	unsafe_put_user(regs->bp, &sc->bp, Efault);
@@ -180,7 +153,6 @@ __unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 	unsafe_put_user(regs->dx, &sc->dx, Efault);
 	unsafe_put_user(regs->cx, &sc->cx, Efault);
 	unsafe_put_user(regs->ax, &sc->ax, Efault);
-#ifdef CONFIG_X86_64
 	unsafe_put_user(regs->r8, &sc->r8, Efault);
 	unsafe_put_user(regs->r9, &sc->r9, Efault);
 	unsafe_put_user(regs->r10, &sc->r10, Efault);
@@ -189,23 +161,15 @@ __unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 	unsafe_put_user(regs->r13, &sc->r13, Efault);
 	unsafe_put_user(regs->r14, &sc->r14, Efault);
 	unsafe_put_user(regs->r15, &sc->r15, Efault);
-#endif /* CONFIG_X86_64 */
 
 	unsafe_put_user(current->thread.trap_nr, &sc->trapno, Efault);
 	unsafe_put_user(current->thread.error_code, &sc->err, Efault);
 	unsafe_put_user(regs->ip, &sc->ip, Efault);
-#ifdef CONFIG_X86_32
-	unsafe_put_user(regs->cs, (unsigned int __user *)&sc->cs, Efault);
-	unsafe_put_user(regs->flags, &sc->flags, Efault);
-	unsafe_put_user(regs->sp, &sc->sp_at_signal, Efault);
-	unsafe_put_user(regs->ss, (unsigned int __user *)&sc->ss, Efault);
-#else /* !CONFIG_X86_32 */
 	unsafe_put_user(regs->flags, &sc->flags, Efault);
 	unsafe_put_user(regs->cs, &sc->cs, Efault);
 	unsafe_put_user(0, &sc->gs, Efault);
 	unsafe_put_user(0, &sc->fs, Efault);
 	unsafe_put_user(regs->ss, &sc->ss, Efault);
-#endif /* CONFIG_X86_32 */
 
 	unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);
 
@@ -228,6 +192,8 @@ do {									\
 			(__u64 __user *)&(frame)->uc.uc_sigmask, \
 			label)
 
+#endif /* CONFIG_X86_64 */
+
 /*
  * Set up a signal frame.
  */
@@ -313,148 +279,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	return (void __user *)sp;
 }
 
-#ifdef CONFIG_X86_32
-static const struct {
-	u16 poplmovl;
-	u32 val;
-	u16 int80;
-} __attribute__((packed)) retcode = {
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
-} __attribute__((packed)) rt_retcode = {
-	0xb8,		/* movl $..., %eax */
-	__NR_rt_sigreturn,
-	0x80cd,		/* int $0x80 */
-	0
-};
-
-int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
-{
-	sigset_t *set = sigmask_to_save();
-	struct sigframe __user *frame;
-	void __user *restorer;
-	void __user *fp = NULL;
-
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
-
-	if (!user_access_begin(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	unsafe_put_user(ksig->sig, &frame->sig, Efault);
-	unsafe_put_sigcontext(&frame->sc, fp, regs, set, Efault);
-	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
-	if (current->mm->context.vdso)
-		restorer = current->mm->context.vdso +
-			vdso_image_32.sym___kernel_sigreturn;
-	else
-		restorer = &frame->retcode;
-	if (ksig->ka.sa.sa_flags & SA_RESTORER)
-		restorer = ksig->ka.sa.sa_restorer;
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
-	regs->sp = (unsigned long)frame;
-	regs->ip = (unsigned long)ksig->ka.sa.sa_handler;
-	regs->ax = (unsigned long)ksig->sig;
-	regs->dx = 0;
-	regs->cx = 0;
-
-	regs->ds = __USER_DS;
-	regs->es = __USER_DS;
-	regs->ss = __USER_DS;
-	regs->cs = __USER_CS;
-
-	return 0;
-
-Efault:
-	user_access_end();
-	return -EFAULT;
-}
-
-int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
-{
-	sigset_t *set = sigmask_to_save();
-	struct rt_sigframe __user *frame;
-	void __user *restorer;
-	void __user *fp = NULL;
-
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
-
-	if (!user_access_begin(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	unsafe_put_user(ksig->sig, &frame->sig, Efault);
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
-	restorer = current->mm->context.vdso +
-		vdso_image_32.sym___kernel_rt_sigreturn;
-	if (ksig->ka.sa.sa_flags & SA_RESTORER)
-		restorer = ksig->ka.sa.sa_restorer;
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
-	
-	if (copy_siginfo_to_user(&frame->info, &ksig->info))
-		return -EFAULT;
-
-	/* Set up registers for signal handler */
-	regs->sp = (unsigned long)frame;
-	regs->ip = (unsigned long)ksig->ka.sa.sa_handler;
-	regs->ax = (unsigned long)ksig->sig;
-	regs->dx = (unsigned long)&frame->info;
-	regs->cx = (unsigned long)&frame->uc;
-
-	regs->ds = __USER_DS;
-	regs->es = __USER_DS;
-	regs->ss = __USER_DS;
-	regs->cs = __USER_CS;
-
-	return 0;
-Efault:
-	user_access_end();
-	return -EFAULT;
-}
-#else /* !CONFIG_X86_32 */
+#ifdef CONFIG_X86_64
 static unsigned long frame_uc_flags(struct pt_regs *regs)
 {
 	unsigned long flags;
@@ -545,7 +370,6 @@ Efault:
 	user_access_end();
 	return -EFAULT;
 }
-#endif /* CONFIG_X86_32 */
 
 #ifdef CONFIG_X86_X32_ABI
 static int x32_copy_siginfo_to_user(struct compat_siginfo __user *to,
@@ -631,38 +455,6 @@ Efault:
 /*
  * Do a signal return; undo the signal stack.
  */
-#ifdef CONFIG_X86_32
-SYSCALL_DEFINE0(sigreturn)
-{
-	struct pt_regs *regs = current_pt_regs();
-	struct sigframe __user *frame;
-	sigset_t set;
-
-	frame = (struct sigframe __user *)(regs->sp - 8);
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
 SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
@@ -692,6 +484,7 @@ badframe:
 	signal_fault(regs, frame, "rt_sigreturn");
 	return 0;
 }
+#endif /* CONFIG_X86_64 */
 
 /*
  * There are four different struct types for signal frame: sigframe_ia32,
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
new file mode 100644
index 0000000..2553136
--- /dev/null
+++ b/arch/x86/kernel/signal_32.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *
+ *  1997-11-28  Modified for POSIX.1b signals by Richard Henderson
+ *  2000-06-20  Pentium III FXSR, SSE support by Gareth Hughes
+ *  2000-12-*   x86-64 compatibility mode signal handling by Andi Kleen
+ */
+
+#include <linux/sched.h>
+#include <linux/sched/task_stack.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/wait.h>
+#include <linux/unistd.h>
+#include <linux/stddef.h>
+#include <linux/personality.h>
+#include <linux/compat.h>
+#include <linux/binfmts.h>
+#include <linux/syscalls.h>
+#include <asm/ucontext.h>
+#include <linux/uaccess.h>
+#include <asm/fpu/signal.h>
+#include <asm/ptrace.h>
+#include <asm/user32.h>
+#include <uapi/asm/sigcontext.h>
+#include <asm/proto.h>
+#include <asm/vdso.h>
+#include <asm/sigframe.h>
+#include <asm/sighandling.h>
+#include <asm/smap.h>
+
+#ifdef CONFIG_IA32_EMULATION
+#include <asm/ia32_unistd.h>
+
+static inline void reload_segments(struct sigcontext_32 *sc)
+{
+	unsigned int cur;
+
+	savesegment(gs, cur);
+	if ((sc->gs | 0x03) != cur)
+		load_gs_index(sc->gs | 0x03);
+	savesegment(fs, cur);
+	if ((sc->fs | 0x03) != cur)
+		loadsegment(fs, sc->fs | 0x03);
+	savesegment(ds, cur);
+	if ((sc->ds | 0x03) != cur)
+		loadsegment(ds, sc->ds | 0x03);
+	savesegment(es, cur);
+	if ((sc->es | 0x03) != cur)
+		loadsegment(es, sc->es | 0x03);
+}
+
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
+/*
+ * Do a signal return; undo the signal stack.
+ */
+static bool ia32_restore_sigcontext(struct pt_regs *regs,
+				    struct sigcontext_32 __user *usc)
+{
+	struct sigcontext_32 sc;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current->restart_block.fn = do_no_restart_syscall;
+
+	if (unlikely(copy_from_user(&sc, usc, sizeof(sc))))
+		return false;
+
+	/* Get only the ia32 registers. */
+	regs->bx = sc.bx;
+	regs->cx = sc.cx;
+	regs->dx = sc.dx;
+	regs->si = sc.si;
+	regs->di = sc.di;
+	regs->bp = sc.bp;
+	regs->ax = sc.ax;
+	regs->sp = sc.sp;
+	regs->ip = sc.ip;
+
+	/* Get CS/SS and force CPL3 */
+	regs->cs = sc.cs | 0x03;
+	regs->ss = sc.ss | 0x03;
+
+	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
+	/* disable syscall checks */
+	regs->orig_ax = -1;
+
+#ifdef CONFIG_IA32_EMULATION
+	/*
+	 * Reload fs and gs if they have changed in the signal
+	 * handler.  This does not handle long fs/gs base changes in
+	 * the handler, but does not clobber them at least in the
+	 * normal case.
+	 */
+	reload_segments(&sc);
+#else
+	loadsegment(gs, sc.gs);
+	regs->fs = sc.fs;
+	regs->es = sc.es;
+	regs->ds = sc.ds;
+#endif
+
+	return fpu__restore_sig(compat_ptr(sc.fpstate), 1);
+}
+
+SYSCALL32_DEFINE0(sigreturn)
+{
+	struct pt_regs *regs = current_pt_regs();
+	struct sigframe_ia32 __user *frame = (struct sigframe_ia32 __user *)(regs->sp-8);
+	sigset_t set;
+
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+	if (__get_user(set.sig[0], &frame->sc.oldmask)
+	    || __get_user(((__u32 *)&set)[1], &frame->extramask[0]))
+		goto badframe;
+
+	set_current_blocked(&set);
+
+	if (!ia32_restore_sigcontext(regs, &frame->sc))
+		goto badframe;
+	return regs->ax;
+
+badframe:
+	signal_fault(regs, frame, "32bit sigreturn");
+	return 0;
+}
+
+SYSCALL32_DEFINE0(rt_sigreturn)
+{
+	struct pt_regs *regs = current_pt_regs();
+	struct rt_sigframe_ia32 __user *frame;
+	sigset_t set;
+
+	frame = (struct rt_sigframe_ia32 __user *)(regs->sp - 4);
+
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+	if (__get_user(*(__u64 *)&set, (__u64 __user *)&frame->uc.uc_sigmask))
+		goto badframe;
+
+	set_current_blocked(&set);
+
+	if (!ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
+		goto badframe;
+
+	if (restore_altstack32(&frame->uc.uc_stack))
+		goto badframe;
+
+	return regs->ax;
+
+badframe:
+	signal_fault(regs, frame, "32bit rt sigreturn");
+	return 0;
+}
+
+/*
+ * Set up a signal frame.
+ */
+
+#define get_user_seg(seg)	({ unsigned int v; savesegment(seg, v); v; })
+
+static __always_inline int
+__unsafe_setup_sigcontext32(struct sigcontext_32 __user *sc,
+			    void __user *fpstate,
+			    struct pt_regs *regs, unsigned int mask)
+{
+	unsafe_put_user(get_user_seg(gs), (unsigned int __user *)&sc->gs, Efault);
+#ifdef CONFIG_IA32_EMULATION
+	unsafe_put_user(get_user_seg(fs), (unsigned int __user *)&sc->fs, Efault);
+	unsafe_put_user(get_user_seg(ds), (unsigned int __user *)&sc->ds, Efault);
+	unsafe_put_user(get_user_seg(es), (unsigned int __user *)&sc->es, Efault);
+#else
+	unsafe_put_user(regs->fs, (unsigned int __user *)&sc->fs, Efault);
+	unsafe_put_user(regs->es, (unsigned int __user *)&sc->es, Efault);
+	unsafe_put_user(regs->ds, (unsigned int __user *)&sc->ds, Efault);
+#endif
+
+	unsafe_put_user(regs->di, &sc->di, Efault);
+	unsafe_put_user(regs->si, &sc->si, Efault);
+	unsafe_put_user(regs->bp, &sc->bp, Efault);
+	unsafe_put_user(regs->sp, &sc->sp, Efault);
+	unsafe_put_user(regs->bx, &sc->bx, Efault);
+	unsafe_put_user(regs->dx, &sc->dx, Efault);
+	unsafe_put_user(regs->cx, &sc->cx, Efault);
+	unsafe_put_user(regs->ax, &sc->ax, Efault);
+	unsafe_put_user(current->thread.trap_nr, &sc->trapno, Efault);
+	unsafe_put_user(current->thread.error_code, &sc->err, Efault);
+	unsafe_put_user(regs->ip, &sc->ip, Efault);
+	unsafe_put_user(regs->cs, (unsigned int __user *)&sc->cs, Efault);
+	unsafe_put_user(regs->flags, &sc->flags, Efault);
+	unsafe_put_user(regs->sp, &sc->sp_at_signal, Efault);
+	unsafe_put_user(regs->ss, (unsigned int __user *)&sc->ss, Efault);
+
+	unsafe_put_user(ptr_to_compat(fpstate), &sc->fpstate, Efault);
+
+	/* non-iBCS2 extensions.. */
+	unsafe_put_user(mask, &sc->oldmask, Efault);
+	unsafe_put_user(current->thread.cr2, &sc->cr2, Efault);
+	return 0;
+
+Efault:
+	return -EFAULT;
+}
+
+#define unsafe_put_sigcontext32(sc, fp, regs, set, label)		\
+do {									\
+	if (__unsafe_setup_sigcontext32(sc, fp, regs, set->sig[0]))	\
+		goto label;						\
+} while(0)
+
+int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
+{
+	sigset32_t *set = (sigset32_t *) sigmask_to_save();
+	struct sigframe_ia32 __user *frame;
+	void __user *restorer;
+	void __user *fp = NULL;
+
+	/* copy_to_user optimizes that into a single 8 byte store */
+	static const struct {
+		u16 poplmovl;
+		u32 val;
+		u16 int80;
+	} __attribute__((packed)) code = {
+		0xb858,		 /* popl %eax ; movl $...,%eax */
+		__NR_ia32_sigreturn,
+		0x80cd,		/* int $0x80 */
+	};
+
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
+
+	if (ksig->ka.sa.sa_flags & SA_RESTORER) {
+		restorer = ksig->ka.sa.sa_restorer;
+	} else {
+		/* Return stub is in 32bit vsyscall page */
+		if (current->mm->context.vdso)
+			restorer = current->mm->context.vdso +
+				vdso_image_32.sym___kernel_sigreturn;
+		else
+			restorer = &frame->retcode;
+	}
+
+	if (!user_access_begin(frame, sizeof(*frame)))
+		return -EFAULT;
+
+	unsafe_put_user(ksig->sig, &frame->sig, Efault);
+	unsafe_put_sigcontext32(&frame->sc, fp, regs, set, Efault);
+	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
+	unsafe_put_user(ptr_to_compat(restorer), &frame->pretcode, Efault);
+	/*
+	 * These are actually not used anymore, but left because some
+	 * gdb versions depend on them as a marker.
+	 */
+	unsafe_put_user(*((u64 *)&code), (u64 __user *)frame->retcode, Efault);
+	user_access_end();
+
+	/* Set up registers for signal handler */
+	regs->sp = (unsigned long) frame;
+	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
+
+	/* Make -mregparm=3 work */
+	regs->ax = ksig->sig;
+	regs->dx = 0;
+	regs->cx = 0;
+
+#ifdef CONFIG_IA32_EMULATION
+	loadsegment(ds, __USER_DS);
+	loadsegment(es, __USER_DS);
+#else
+	regs->ds = __USER_DS;
+	regs->es = __USER_DS;
+#endif
+
+	regs->cs = __USER32_CS;
+	regs->ss = __USER_DS;
+
+	return 0;
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
+
+int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+{
+	sigset32_t *set = (sigset32_t *) sigmask_to_save();
+	struct rt_sigframe_ia32 __user *frame;
+	void __user *restorer;
+	void __user *fp = NULL;
+
+	/* unsafe_put_user optimizes that into a single 8 byte store */
+	static const struct {
+		u8 movl;
+		u32 val;
+		u16 int80;
+		u8  pad;
+	} __attribute__((packed)) code = {
+		0xb8,
+		__NR_ia32_rt_sigreturn,
+		0x80cd,
+		0,
+	};
+
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
+
+	if (!user_access_begin(frame, sizeof(*frame)))
+		return -EFAULT;
+
+	unsafe_put_user(ksig->sig, &frame->sig, Efault);
+	unsafe_put_user(ptr_to_compat(&frame->info), &frame->pinfo, Efault);
+	unsafe_put_user(ptr_to_compat(&frame->uc), &frame->puc, Efault);
+
+	/* Create the ucontext.  */
+	if (static_cpu_has(X86_FEATURE_XSAVE))
+		unsafe_put_user(UC_FP_XSTATE, &frame->uc.uc_flags, Efault);
+	else
+		unsafe_put_user(0, &frame->uc.uc_flags, Efault);
+	unsafe_put_user(0, &frame->uc.uc_link, Efault);
+	unsafe_save_altstack32(&frame->uc.uc_stack, regs->sp, Efault);
+
+	if (ksig->ka.sa.sa_flags & SA_RESTORER)
+		restorer = ksig->ka.sa.sa_restorer;
+	else
+		restorer = current->mm->context.vdso +
+			vdso_image_32.sym___kernel_rt_sigreturn;
+	unsafe_put_user(ptr_to_compat(restorer), &frame->pretcode, Efault);
+
+	/*
+	 * Not actually used anymore, but left because some gdb
+	 * versions need it.
+	 */
+	unsafe_put_user(*((u64 *)&code), (u64 __user *)frame->retcode, Efault);
+	unsafe_put_sigcontext32(&frame->uc.uc_mcontext, fp, regs, set, Efault);
+	unsafe_put_user(*(__u64 *)set, (__u64 __user *)&frame->uc.uc_sigmask, Efault);
+	user_access_end();
+
+	if (__copy_siginfo_to_user32(&frame->info, &ksig->info))
+		return -EFAULT;
+
+	/* Set up registers for signal handler */
+	regs->sp = (unsigned long) frame;
+	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
+
+	/* Make -mregparm=3 work */
+	regs->ax = ksig->sig;
+	regs->dx = (unsigned long) &frame->info;
+	regs->cx = (unsigned long) &frame->uc;
+
+#ifdef CONFIG_IA32_EMULATION
+	loadsegment(ds, __USER_DS);
+	loadsegment(es, __USER_DS);
+#else
+	regs->ds = __USER_DS;
+	regs->es = __USER_DS;
+#endif
+
+	regs->cs = __USER32_CS;
+	regs->ss = __USER_DS;
+
+	return 0;
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a34b0f9..33a0ee3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -264,6 +264,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 #define SC_VAL64(type, name) ((type) name##_hi << 32 | name##_lo)
 
 #ifdef CONFIG_COMPAT
+#define SYSCALL32_DEFINE0 COMPAT_SYSCALL_DEFINE0
 #define SYSCALL32_DEFINE1 COMPAT_SYSCALL_DEFINE1
 #define SYSCALL32_DEFINE2 COMPAT_SYSCALL_DEFINE2
 #define SYSCALL32_DEFINE3 COMPAT_SYSCALL_DEFINE3
@@ -271,6 +272,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 #define SYSCALL32_DEFINE5 COMPAT_SYSCALL_DEFINE5
 #define SYSCALL32_DEFINE6 COMPAT_SYSCALL_DEFINE6
 #else
+#define SYSCALL32_DEFINE0 SYSCALL_DEFINE0
 #define SYSCALL32_DEFINE1 SYSCALL_DEFINE1
 #define SYSCALL32_DEFINE2 SYSCALL_DEFINE2
 #define SYSCALL32_DEFINE3 SYSCALL_DEFINE3
