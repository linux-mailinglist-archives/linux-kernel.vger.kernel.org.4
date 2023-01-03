Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4C065C47A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbjACRDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbjACRAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:00:25 -0500
Received: from fx409.security-mail.net (smtpout253.security-mail.net [46.30.205.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CFD12AE8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:00:24 -0800 (PST)
Received: from localhost (fx409.security-mail.net [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id 774DA34989A
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:44:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1672764273;
        bh=lZWIdX21UTX9ve9MLDXTAEbB6rTrwd/xi58TRbDRty8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YA4weplVyhPfdwYdh3Jd79OilH7Fa4CCr3ePlNa/ug/hFD/FZU4wgQorySMTeG583
         oH/EP7Y/MRIfP5ofPd6341NN4lJ0yAQOj9AkAZkXKv0xhggh8CMQ7tw5142vxbZS32
         t7MXnzBd/iOYtYd7GHqOC2KP7oLcMh4OSTssKNpg=
Received: from fx409 (fx409.security-mail.net [127.0.0.1]) by
 fx409.security-mail.net (Postfix) with ESMTP id 528FB349898; Tue,  3 Jan
 2023 17:44:33 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx409.security-mail.net (Postfix) with ESMTPS id A90D434984A; Tue,  3 Jan
 2023 17:44:32 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 5290E27E0407; Tue,  3 Jan 2023
 17:44:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 3571727E0405; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 7J7bVzNCgGc6; Tue,  3 Jan 2023 17:44:32 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id 16FCD27E03FB; Tue,  3 Jan 2023
 17:44:32 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <c9ab.63b45b70.a6e8e.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 3571727E0405
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1672764272;
 bh=Zhuy2u38jJYcNgi+ZHVG5mM0Gbmiag1TvE1upEGHYsY=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=MWe0W+bIkprO7q3UjO/nm47iAEKp1g4pFI3+dxxnA1eoK9cgTdLbT0XZFOocAolCv
 jT/l5/tKbcaZouET1sHUZ6b63+lcaISIljDntfb7OiRQHHhcp8P55EvxvpOATUEfts
 y2LE0NtBKiwsJcjKPR7cCcuzwUOCWj05dUbsuErU=
From:   Yann Sionneau <ysionneau@kalray.eu>
Cc:     Yann Sionneau <ysionneau@kalray.eu>, linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Julian Vetter <jvetter@kalray.eu>
Subject: [RFC PATCH 13/25] kvx: Add signal handling support
Date:   Tue,  3 Jan 2023 17:43:47 +0100
Message-ID: <20230103164359.24347-14-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230103164359.24347-1-ysionneau@kalray.eu>
References: <20230103164359.24347-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sigcontext definition and signal handling support for
kvx.

CC: linux-kernel@vger.kernel.org
Co-developed-by: Clement Leger <clement.leger@bootlin.com>
Signed-off-by: Clement Leger <clement.leger@bootlin.com>
Co-developed-by: Jules Maselbas <jmaselbas@kalray.eu>
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 arch/kvx/include/uapi/asm/sigcontext.h |  16 ++
 arch/kvx/kernel/signal.c               | 266 +++++++++++++++++++++++++
 arch/kvx/kernel/vdso.c                 |  87 ++++++++
 3 files changed, 369 insertions(+)
 create mode 100644 arch/kvx/include/uapi/asm/sigcontext.h
 create mode 100644 arch/kvx/kernel/signal.c
 create mode 100644 arch/kvx/kernel/vdso.c

diff --git a/arch/kvx/include/uapi/asm/sigcontext.h b/arch/kvx/include/uapi/asm/sigcontext.h
new file mode 100644
index 000000000000..97ab4f78152a
--- /dev/null
+++ b/arch/kvx/include/uapi/asm/sigcontext.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _UAPI_ASM_KVX_SIGCONTEXT_H
+#define _UAPI_ASM_KVX_SIGCONTEXT_H
+
+#include <asm/ptrace.h>
+
+struct sigcontext {
+	struct user_pt_regs sc_regs;
+};
+
+#endif	/* _UAPI_ASM_KVX_SIGCONTEXT_H */
diff --git a/arch/kvx/kernel/signal.c b/arch/kvx/kernel/signal.c
new file mode 100644
index 000000000000..e52bbb30c336
--- /dev/null
+++ b/arch/kvx/kernel/signal.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/bug.h>
+#include <linux/syscalls.h>
+
+#include <asm/ucontext.h>
+#include <asm/processor.h>
+#include <asm/cacheflush.h>
+#include <linux/resume_user_mode.h>
+
+struct rt_sigframe {
+	struct siginfo info;
+	struct ucontext uc;
+};
+
+int __init setup_syscall_sigreturn_page(void *sigpage_addr)
+{
+	unsigned int frame_size = (uintptr_t) &user_scall_rt_sigreturn_end -
+				  (uintptr_t) &user_scall_rt_sigreturn;
+
+	/* Copy the sigreturn scall implementation */
+	memcpy(sigpage_addr, &user_scall_rt_sigreturn, frame_size);
+
+	flush_icache_range((unsigned long) sigpage_addr,
+			   (unsigned long) sigpage_addr + frame_size);
+
+	return 0;
+}
+
+static long restore_sigcontext(struct pt_regs *regs,
+			       struct sigcontext __user *sc)
+{
+	long err;
+
+	/* sc_regs is structured the same as the start of pt_regs */
+	err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
+
+	return err;
+}
+
+long _sys_rt_sigreturn(void)
+{
+	struct pt_regs *regs = current_pt_regs();
+	struct rt_sigframe __user *frame;
+	struct task_struct *task;
+	sigset_t set;
+
+	current->restart_block.fn = do_no_restart_syscall;
+
+	frame = (struct rt_sigframe __user *) user_stack_pointer(regs);
+
+	/*
+	 * Stack is not aligned but should be !
+	 * User probably did some malicious things.
+	 */
+	if (user_stack_pointer(regs) & STACK_ALIGN_MASK)
+		goto badframe;
+
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+
+	/* Restore sigmask */
+	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
+		goto badframe;
+
+	set_current_blocked(&set);
+
+	if (restore_sigcontext(regs, &frame->uc.uc_mcontext))
+		goto badframe;
+
+	if (restore_altstack(&frame->uc.uc_stack))
+		goto badframe;
+
+	return regs->r0;
+
+badframe:
+	task = current;
+	if (show_unhandled_signals) {
+		pr_info_ratelimited(
+			"%s[%d]: bad frame in %s: frame=%p pc=%p sp=%p\n",
+			task->comm, task_pid_nr(task), __func__,
+			frame, (void *) instruction_pointer(regs),
+			(void *) user_stack_pointer(regs));
+	}
+	force_sig(SIGSEGV);
+	return 0;
+}
+
+
+static long setup_sigcontext(struct rt_sigframe __user *frame,
+			     struct pt_regs *regs)
+{
+	struct sigcontext __user *sc = &frame->uc.uc_mcontext;
+	long err;
+
+	/* sc_regs is structured the same as the start of pt_regs */
+	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
+
+	return err;
+}
+
+static inline void __user *get_sigframe(struct ksignal *ksig,
+					struct pt_regs *regs, size_t framesize)
+{
+	unsigned long sp;
+	/* Default to using normal stack */
+	sp = regs->sp;
+
+	/*
+	 * If we are on the alternate signal stack and would overflow it, don't.
+	 * Return an always-bogus address instead so we will die with SIGSEGV.
+	 */
+	if (on_sig_stack(sp) && !likely(on_sig_stack(sp - framesize)))
+		return (void __user __force *)(-1UL);
+
+	/* This is the X/Open sanctioned signal stack switching. */
+	sp = sigsp(sp, ksig) - framesize;
+
+	/* Align the stack frame on 16bytes */
+	sp &= ~STACK_ALIGN_MASK;
+
+	return (void __user *)sp;
+}
+
+/* TODO: Use VDSO when ready ! */
+static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+			  struct pt_regs *regs)
+{
+	unsigned long sigpage = current->mm->context.sigpage;
+	struct rt_sigframe __user *frame;
+	long err = 0;
+
+	frame = get_sigframe(ksig, regs, sizeof(*frame));
+	if (!access_ok(frame, sizeof(*frame)))
+		return -EFAULT;
+
+	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
+
+	/* Create the ucontext. */
+	err |= __put_user(0, &frame->uc.uc_flags);
+	err |= __put_user(NULL, &frame->uc.uc_link);
+	err |= __save_altstack(&frame->uc.uc_stack, user_stack_pointer(regs));
+	err |= setup_sigcontext(frame, regs);
+	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
+	if (err)
+		return -EFAULT;
+
+	/*
+	 * When returning from the handler, we want to jump to the
+	 * sigpage which will execute the sigreturn scall.
+	 */
+	regs->ra = sigpage;
+	/* Return to signal handler */
+	regs->spc = (unsigned long)ksig->ka.sa.sa_handler;
+	regs->sp = (unsigned long) frame;
+
+	/* Parameters for signal handler */
+	regs->r0 = ksig->sig;                     /* r0: signal number */
+	regs->r1 = (unsigned long)(&frame->info); /* r1: siginfo pointer */
+	regs->r2 = (unsigned long)(&frame->uc);   /* r2: ucontext pointer */
+
+	return 0;
+}
+
+static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
+{
+	sigset_t *oldset = sigmask_to_save();
+	int ret;
+
+	/* Are we from a system call? */
+	if (in_syscall(regs)) {
+		/* If so, check system call restarting.. */
+		switch (regs->r0) {
+		case -ERESTART_RESTARTBLOCK:
+		case -ERESTARTNOHAND:
+			regs->r0 = -EINTR;
+			break;
+		case -ERESTARTSYS:
+			if (!(ksig->ka.sa.sa_flags & SA_RESTART)) {
+				regs->r0 = -EINTR;
+				break;
+			}
+			fallthrough;
+		case -ERESTARTNOINTR:
+			regs->r0 = regs->orig_r0;
+			regs->spc -= 0x4;
+			break;
+		}
+	}
+
+	ret = setup_rt_frame(ksig, oldset, regs);
+
+	signal_setup_done(ret, ksig, 0);
+}
+
+asmlinkage void do_signal(struct pt_regs *regs)
+{
+	struct ksignal ksig;
+
+	if (get_signal(&ksig)) {
+		handle_signal(&ksig, regs);
+		return;
+	}
+
+	/* Are we from a system call? */
+	if (in_syscall(regs)) {
+		/*
+		 * If we are here, this means there is no handler
+		 * present and we must restart the syscall.
+		 */
+		switch (regs->r0) {
+		case -ERESTART_RESTARTBLOCK:
+			/* Modify the syscall number in order to restart it */
+			regs->r6 = __NR_restart_syscall;
+			fallthrough;
+		case -ERESTARTNOHAND:
+		case -ERESTARTSYS:
+		case -ERESTARTNOINTR:
+			/* We are restarting the syscall */
+			regs->r0 = regs->orig_r0;
+			/*
+			 * scall instruction isn't bundled with anything else,
+			 * so we can just revert the spc to restart the syscall.
+			 */
+			regs->spc -= 0x4;
+			break;
+		}
+	}
+
+	/*
+	 * If there's no signal to deliver, we just put the saved sigmask
+	 * back.
+	 */
+	restore_saved_sigmask();
+}
+
+
+asmlinkage void do_work_pending(struct pt_regs *regs,
+				unsigned long thread_flags)
+{
+	/* We are called with IRQs disabled */
+	trace_hardirqs_off();
+
+	do {
+		if (thread_flags & _TIF_NEED_RESCHED) {
+			schedule();
+		} else {
+			local_irq_enable();
+			if (thread_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
+				do_signal(regs);
+
+			if (thread_flags & _TIF_NOTIFY_RESUME) {
+				clear_thread_flag(TIF_NOTIFY_RESUME);
+				resume_user_mode_work(regs);
+			}
+		}
+		/* Guarantee task flag atomic read */
+		local_irq_disable();
+		thread_flags = READ_ONCE(current_thread_info()->flags);
+	} while (thread_flags & _TIF_WORK_MASK);
+}
+
diff --git a/arch/kvx/kernel/vdso.c b/arch/kvx/kernel/vdso.c
new file mode 100644
index 000000000000..1515de15eb31
--- /dev/null
+++ b/arch/kvx/kernel/vdso.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/binfmts.h>
+
+#include <asm/syscall.h>
+
+static struct page *signal_page;
+
+static int __init init_sigreturn(void)
+{
+	struct page *sigpage;
+	void *mapped_sigpage;
+	int err;
+
+	sigpage = alloc_page(GFP_KERNEL);
+	if (!sigpage)
+		panic("Cannot allocate sigreturn page");
+
+	mapped_sigpage = vmap(&sigpage, 1, 0, PAGE_KERNEL);
+	if (!mapped_sigpage)
+		panic("Cannot map sigreturn page");
+
+	clear_page(mapped_sigpage);
+
+	err = setup_syscall_sigreturn_page(mapped_sigpage);
+	if (err)
+		panic("Cannot set signal return syscall, err: %x.", err);
+
+	vunmap(mapped_sigpage);
+
+	signal_page = sigpage;
+
+	return 0;
+}
+arch_initcall(init_sigreturn);
+
+static int sigpage_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	current->mm->context.sigpage = new_vma->vm_start;
+	return 0;
+}
+
+static const struct vm_special_mapping sigpage_mapping = {
+	.name = "[sigpage]",
+	.pages = &signal_page,
+	.mremap = sigpage_mremap,
+};
+
+int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+{
+	int ret = 0;
+	unsigned long addr;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+
+	mmap_write_lock(mm);
+
+	addr = get_unmapped_area(NULL, STACK_TOP, PAGE_SIZE, 0, 0);
+	if (IS_ERR_VALUE(addr)) {
+		ret = addr;
+		goto up_fail;
+	}
+
+	vma = _install_special_mapping(
+			mm,
+			addr,
+			PAGE_SIZE,
+			VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC,
+			&sigpage_mapping);
+	if (IS_ERR(vma)) {
+		ret = PTR_ERR(vma);
+		goto up_fail;
+	}
+
+	mm->context.sigpage = addr;
+
+up_fail:
+	mmap_write_unlock(mm);
+	return ret;
+}
-- 
2.37.2





