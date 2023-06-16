Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34AD733974
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344479AbjFPTRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345839AbjFPTQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:16:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BCF35A7;
        Fri, 16 Jun 2023 12:16:57 -0700 (PDT)
Date:   Fri, 16 Jun 2023 19:16:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686943015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=M7XgB0OGOPsFYGZZ/z92GXf6OToxqzkZZ/QyKcnapfA=;
        b=m4LgpEbvAnD1kwsPyHzUSqpcpG7d9yQS9Waa71AMHD313rokVUXM5vqiH+ZfwDdsVVvpQl
        UXJ6EC+D6CIxdO/6IKt4FtyJDNrUdCn6O7bYkVsHJcsSWlgQhlrza6a2n7SbAjUvo5JAaR
        /dfDPtG+zYVmqL0DycDChQ5FxFDYc9Ui3AUbPlspN5NAyXZrg5czBQ6iUMgflXScccm5kO
        vGk+KNy3ob+3SufeLA2G4pTEGIUxP2bss7793mUqAhAEwpeXStBCL6WZvLJSVAchYgSYq5
        goZePbwSEf2AOKFcHpQBLqrfnGMwKKKxp0k0z/1QyF9RF42hT+XZdfr0s/a+Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686943015;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=M7XgB0OGOPsFYGZZ/z92GXf6OToxqzkZZ/QyKcnapfA=;
        b=jg/s4nfRE0XqdpVY47ZmhiSG8LdadL2/d0eAFuGYktZzrMNA9wkWJ8/Uqs5NyDawNwPPgS
        bZRk7lw5Huw7bIDQ==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] x86/shstk: Handle signals for shadow stack
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168694301534.404.9273402624964751657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     6bf19cec9a198b8f6af939b5f7bd5d3e721c9e7e
Gitweb:        https://git.kernel.org/tip/6bf19cec9a198b8f6af939b5f7bd5d3e721c9e7e
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:10:57 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 15 Jun 2023 16:31:34 -07:00

x86/shstk: Handle signals for shadow stack

When a signal is handled, the context is pushed to the stack before
handling it. For shadow stacks, since the shadow stack only tracks return
addresses, there isn't any state that needs to be pushed. However, there
are still a few things that need to be done. These things are visible to
userspace and which will be kernel ABI for shadow stacks.

One is to make sure the restorer address is written to shadow stack, since
the signal handler (if not changing ucontext) returns to the restorer, and
the restorer calls sigreturn. So add the restorer on the shadow stack
before handling the signal, so there is not a conflict when the signal
handler returns to the restorer.

The other thing to do is to place some type of checkable token on the
thread's shadow stack before handling the signal and check it during
sigreturn. This is an extra layer of protection to hamper attackers
calling sigreturn manually as in SROP-like attacks.

For this token the shadow stack data format defined earlier can be used.
Have the data pushed be the previous SSP. In the future the sigreturn
might want to return back to a different stack. Storing the SSP (instead
of a restore offset or something) allows for future functionality that
may want to restore to a different stack.

So, when handling a signal push
 - the SSP pointing in the shadow stack data format
 - the restorer address below the restore token.

In sigreturn, verify SSP is stored in the data format and pop the shadow
stack.

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-32-rick.p.edgecombe%40intel.com
---
 arch/x86/include/asm/shstk.h |  5 ++-
 arch/x86/kernel/shstk.c      | 95 +++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/signal.c     |  1 +-
 arch/x86/kernel/signal_64.c  |  6 ++-
 4 files changed, 107 insertions(+)

diff --git a/arch/x86/include/asm/shstk.h b/arch/x86/include/asm/shstk.h
index d4a5c7b..ecb23a8 100644
--- a/arch/x86/include/asm/shstk.h
+++ b/arch/x86/include/asm/shstk.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 struct task_struct;
+struct ksignal;
 
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 struct thread_shstk {
@@ -18,6 +19,8 @@ void reset_thread_features(void);
 unsigned long shstk_alloc_thread_stack(struct task_struct *p, unsigned long clone_flags,
 				       unsigned long stack_size);
 void shstk_free(struct task_struct *p);
+int setup_signal_shadow_stack(struct ksignal *ksig);
+int restore_signal_shadow_stack(void);
 #else
 static inline long shstk_prctl(struct task_struct *task, int option,
 			       unsigned long arg2) { return -EINVAL; }
@@ -26,6 +29,8 @@ static inline unsigned long shstk_alloc_thread_stack(struct task_struct *p,
 						     unsigned long clone_flags,
 						     unsigned long stack_size) { return 0; }
 static inline void shstk_free(struct task_struct *p) {}
+static inline int setup_signal_shadow_stack(struct ksignal *ksig) { return 0; }
+static inline int restore_signal_shadow_stack(void) { return 0; }
 #endif /* CONFIG_X86_USER_SHADOW_STACK */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index e22928c..f02e8ea 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -232,6 +232,101 @@ static int get_shstk_data(unsigned long *data, unsigned long __user *addr)
 	return 0;
 }
 
+static int shstk_push_sigframe(unsigned long *ssp)
+{
+	unsigned long target_ssp = *ssp;
+
+	/* Token must be aligned */
+	if (!IS_ALIGNED(target_ssp, 8))
+		return -EINVAL;
+
+	*ssp -= SS_FRAME_SIZE;
+	if (put_shstk_data((void *__user)*ssp, target_ssp))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int shstk_pop_sigframe(unsigned long *ssp)
+{
+	unsigned long token_addr;
+	int err;
+
+	err = get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
+	if (unlikely(err))
+		return err;
+
+	/* Restore SSP aligned? */
+	if (unlikely(!IS_ALIGNED(token_addr, 8)))
+		return -EINVAL;
+
+	/* SSP in userspace? */
+	if (unlikely(token_addr >= TASK_SIZE_MAX))
+		return -EINVAL;
+
+	*ssp = token_addr;
+
+	return 0;
+}
+
+int setup_signal_shadow_stack(struct ksignal *ksig)
+{
+	void __user *restorer = ksig->ka.sa.sa_restorer;
+	unsigned long ssp;
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
+	    !features_enabled(ARCH_SHSTK_SHSTK))
+		return 0;
+
+	if (!restorer)
+		return -EINVAL;
+
+	ssp = get_user_shstk_addr();
+	if (unlikely(!ssp))
+		return -EINVAL;
+
+	err = shstk_push_sigframe(&ssp);
+	if (unlikely(err))
+		return err;
+
+	/* Push restorer address */
+	ssp -= SS_FRAME_SIZE;
+	err = write_user_shstk_64((u64 __user *)ssp, (u64)restorer);
+	if (unlikely(err))
+		return -EFAULT;
+
+	fpregs_lock_and_load();
+	wrmsrl(MSR_IA32_PL3_SSP, ssp);
+	fpregs_unlock();
+
+	return 0;
+}
+
+int restore_signal_shadow_stack(void)
+{
+	unsigned long ssp;
+	int err;
+
+	if (!cpu_feature_enabled(X86_FEATURE_USER_SHSTK) ||
+	    !features_enabled(ARCH_SHSTK_SHSTK))
+		return 0;
+
+	ssp = get_user_shstk_addr();
+	if (unlikely(!ssp))
+		return -EINVAL;
+
+	err = shstk_pop_sigframe(&ssp);
+	if (unlikely(err))
+		return err;
+
+	fpregs_lock_and_load();
+	wrmsrl(MSR_IA32_PL3_SSP, ssp);
+	fpregs_unlock();
+
+	return 0;
+}
+
 void shstk_free(struct task_struct *tsk)
 {
 	struct thread_shstk *shstk = &tsk->thread.shstk;
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 004cb30..356253e 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -40,6 +40,7 @@
 #include <asm/syscall.h>
 #include <asm/sigframe.h>
 #include <asm/signal.h>
+#include <asm/shstk.h>
 
 static inline int is_ia32_compat_frame(struct ksignal *ksig)
 {
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 0e808c7..cacf2ed 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -175,6 +175,9 @@ int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp);
 	uc_flags = frame_uc_flags(regs);
 
+	if (setup_signal_shadow_stack(ksig))
+		return -EFAULT;
+
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
@@ -260,6 +263,9 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
+	if (restore_signal_shadow_stack())
+		goto badframe;
+
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
