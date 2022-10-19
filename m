Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BF46044C7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiJSMPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiJSMN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:13:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CD91A0C3F;
        Wed, 19 Oct 2022 04:50:20 -0700 (PDT)
Date:   Wed, 19 Oct 2022 08:55:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666169745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCzmTbq4r43wjIn/py5KHc+3GhKMqor1GDB145cTHNs=;
        b=JTmLR5D5SvLruYe0VZsGZPUwitN3zwJo+tibbtWZB0WFVdi/xkTW3CuZxQPiKsmWapYx3o
        IMltVeqvOfSaNHAy+ARVZaVaByz3YygvgOVzIX/fHq6mPeEt/a57JgWX2fdoG0tRWQaC3t
        X3uzgNymt9L21JPWaOnZJcvFQGm9J2TEcZofL9Xq1j/Q2v/bHUMNT60CvuFuH2dhzdPPWb
        3dSPctoGljvz9Gjgkexh6qqskZgGLVEzo2YlamaqvyBq4t6JeZwTdSSZao5a9VmPqB52gW
        R05YSEN8yy0o0sa3lYA7RVRLWPJKHVmY3DDSoOti36fkmekSLehPtImX57eWLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666169745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UCzmTbq4r43wjIn/py5KHc+3GhKMqor1GDB145cTHNs=;
        b=1fhRfaC1zGj7b/GUEsTQN1dokj0ObiF0fN3AMcWX5ZVskaEiPFhKl3Q+017FuX2/irowWb
        e/aZBdClHgNkRrAA==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/signal: Merge get_sigframe()
Cc:     Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220606203802.158958-6-brgerst@gmail.com>
References: <20220606203802.158958-6-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <166616974430.401.6070578013275608826.tip-bot2@tip-bot2>
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

Commit-ID:     9c36e592b3f899c90b9d0d46ae29fcc065051b96
Gitweb:        https://git.kernel.org/tip/9c36e592b3f899c90b9d0d46ae29fcc065051b96
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 06 Jun 2022 16:37:59 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 Oct 2022 09:58:49 +02:00

x86/signal: Merge get_sigframe()

Adapt the native get_sigframe() function so that the compat signal code
can use it.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lore.kernel.org/r/20220606203802.158958-6-brgerst@gmail.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/ia32/ia32_signal.c        | 34 +------------
 arch/x86/include/asm/sighandling.h |  4 +-
 arch/x86/kernel/signal.c           | 80 +++++++++++++----------------
 3 files changed, 42 insertions(+), 76 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index a78885e..e28421f 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -196,40 +196,6 @@ do {									\
 		goto label;						\
 } while(0)
 
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
-	sp = regs->sp;
-
-	/* This is the X/Open sanctioned signal stack switching.  */
-	if (ksig->ka.sa.sa_flags & SA_ONSTACK)
-		sp = sigsp(sp, ksig);
-	/* This is the legacy signal stack switching. */
-	else if (regs->ss != __USER_DS &&
-		!(ksig->ka.sa.sa_flags & SA_RESTORER) &&
-		 ksig->ka.sa.sa_restorer)
-		sp = (unsigned long) ksig->ka.sa.sa_restorer;
-
-	sp = fpu__alloc_mathframe(sp, 1, &fx_aligned, &math_size);
-	*fpstate = (struct _fpstate_32 __user *) sp;
-	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)fx_aligned,
-				      math_size))
-		return (void __user *) -1L;
-
-	sp -= frame_size;
-	/* Align the stack pointer according to the i386 ABI,
-	 * i.e. so that on function entry ((sp + 4) & 15) == 0. */
-	sp = ((sp + 4) & -16ul) - 4;
-	return (void __user *) sp;
-}
-
 int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
 	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index 65e6672..c9e9784 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -15,4 +15,8 @@
 
 void signal_fault(struct pt_regs *regs, void __user *frame, char *where);
 
+void __user *
+get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
+	     void __user **fpstate);
+
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 489a085..890ca05 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -48,6 +48,23 @@
 #include <asm/sigframe.h>
 #include <asm/signal.h>
 
+static inline int is_ia32_compat_frame(struct ksignal *ksig)
+{
+	return IS_ENABLED(CONFIG_IA32_EMULATION) &&
+		ksig->ka.sa.sa_flags & SA_IA32_ABI;
+}
+
+static inline int is_ia32_frame(struct ksignal *ksig)
+{
+	return IS_ENABLED(CONFIG_X86_32) || is_ia32_compat_frame(ksig);
+}
+
+static inline int is_x32_frame(struct ksignal *ksig)
+{
+	return IS_ENABLED(CONFIG_X86_X32_ABI) &&
+		ksig->ka.sa.sa_flags & SA_X32_ABI;
+}
+
 #ifdef CONFIG_X86_64
 /*
  * If regs->ss will cause an IRET fault, change it.  Otherwise leave it
@@ -223,24 +240,12 @@ do {									\
 /*
  * Determine which stack to use..
  */
-static unsigned long align_sigframe(unsigned long sp)
-{
-#ifdef CONFIG_X86_32
-	/*
-	 * Align the stack pointer according to the i386 ABI,
-	 * i.e. so that on function entry ((sp + 4) & 15) == 0.
-	 */
-	sp = ((sp + 4) & -FRAME_ALIGNMENT) - 4;
-#else /* !CONFIG_X86_32 */
-	sp = round_down(sp, FRAME_ALIGNMENT) - 8;
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
+	struct k_sigaction *ka = &ksig->ka;
+	int ia32_frame = is_ia32_frame(ksig);
 	/* Default to using normal stack */
 	bool nested_altstack = on_sig_stack(regs->sp);
 	bool entering_altstack = false;
@@ -249,7 +254,7 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	unsigned long buf_fx = 0;
 
 	/* redzone */
-	if (IS_ENABLED(CONFIG_X86_64))
+	if (!ia32_frame)
 		sp -= 128;
 
 	/* This is the X/Open sanctioned signal stack switching.  */
@@ -263,7 +268,7 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 			sp = current->sas_ss_sp + current->sas_ss_size;
 			entering_altstack = true;
 		}
-	} else if (IS_ENABLED(CONFIG_X86_32) &&
+	} else if (ia32_frame &&
 		   !nested_altstack &&
 		   regs->ss != __USER_DS &&
 		   !(ka->sa.sa_flags & SA_RESTORER) &&
@@ -273,11 +278,19 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 		entering_altstack = true;
 	}
 
-	sp = fpu__alloc_mathframe(sp, IS_ENABLED(CONFIG_X86_32),
-				  &buf_fx, &math_size);
+	sp = fpu__alloc_mathframe(sp, ia32_frame, &buf_fx, &math_size);
 	*fpstate = (void __user *)sp;
 
-	sp = align_sigframe(sp - frame_size);
+	sp -= frame_size;
+
+	if (ia32_frame)
+		/*
+		 * Align the stack pointer according to the i386 ABI,
+		 * i.e. so that on function entry ((sp + 4) & 15) == 0.
+		 */
+		sp = ((sp + 4) & -FRAME_ALIGNMENT) - 4;
+	else
+		sp = round_down(sp, FRAME_ALIGNMENT) - 8;
 
 	/*
 	 * If we are on the alternate signal stack and would overflow it, don't.
@@ -331,7 +344,7 @@ __setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 	void __user *restorer;
 	void __user *fp = NULL;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
 
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
@@ -386,7 +399,7 @@ static int __setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	void __user *restorer;
 	void __user *fp = NULL;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
 
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
@@ -469,7 +482,7 @@ static int __setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
 		return -EFAULT;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(struct rt_sigframe), &fp);
+	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp);
 	uc_flags = frame_uc_flags(regs);
 
 	if (!user_access_begin(frame, sizeof(*frame)))
@@ -572,7 +585,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
 		return -EFAULT;
 
-	frame = get_sigframe(&ksig->ka, regs, sizeof(*frame), &fp);
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
 
 	uc_flags = frame_uc_flags(regs);
 
@@ -742,23 +755,6 @@ unsigned long get_sigframe_size(void)
 	return max_frame_size;
 }
 
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
