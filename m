Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2302604184
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiJSKpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbiJSKnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:43:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421D4B5FF7;
        Wed, 19 Oct 2022 03:20:49 -0700 (PDT)
Date:   Wed, 19 Oct 2022 08:55:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666169750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qcApPFNPof4JyRnCxYWKlA1/9FtTi7A5R8T88Sz/KLc=;
        b=fm+fWlnYpS7XS+myDdk1J06EbQ5NFU78ocjHzR/Sf50xLUhw7uzmXMl/lkme9aGWaDfBHP
        UwmOIHBjKGOS9y5SB3m/O3/BPzTtwI0RkU6541Mc3aSym7ZJ/VBwWo6NwrlOS13ijDvn7n
        pAcVdVuRPCGrVw82yCh9FzCIusNlQzrcc4EHc5iex5apFZ4uCKN7cBfMqRrcd6d5pteLgJ
        loTxAFA3ppoOg+3nrWBghib+FKQiTvIXFSMW5uhe5MIn73BPoGKd4CgLIvA1ChD/E3N/eV
        AtbrTdePG3ymzbo37SohPjMOjGn4Rj1TWwhZzUTBx0uJjU/t/2jEIYNEEDlLBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666169750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qcApPFNPof4JyRnCxYWKlA1/9FtTi7A5R8T88Sz/KLc=;
        b=807mWOIPQNGJTjP4/aId+83y8F1dZziizxaxwtVe5N/e32vUO1npNYqStr516U3AkEsAF4
        LxdpJjT8YGj0LMBw==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/signal: Remove sigset_t parameter from frame
 setup functions
Cc:     Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220606203802.158958-3-brgerst@gmail.com>
References: <20220606203802.158958-3-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <166616974818.401.5661686003687651870.tip-bot2@tip-bot2>
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

Commit-ID:     f544822ea587ce08932640d5ba3978261148cbc7
Gitweb:        https://git.kernel.org/tip/f544822ea587ce08932640d5ba3978261148cbc7
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 06 Jun 2022 16:37:56 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 Oct 2022 09:58:48 +02:00

x86/signal: Remove sigset_t parameter from frame setup functions

Push down the call to sigmask_to_save() into the frame setup functions.
Thus, remove the use of compat_sigset_t outside of the compat code.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lore.kernel.org/r/20220606203802.158958-3-brgerst@gmail.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/ia32/ia32_signal.c       |  8 ++++----
 arch/x86/include/asm/fpu/signal.h |  6 ++----
 arch/x86/include/asm/signal.h     |  5 -----
 arch/x86/kernel/signal.c          | 28 ++++++++++++----------------
 4 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 390347a..b67e276 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -230,9 +230,9 @@ static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 	return (void __user *) sp;
 }
 
-int ia32_setup_frame(struct ksignal *ksig,
-		     compat_sigset_t *set, struct pt_regs *regs)
+int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
+	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
 	struct sigframe_ia32 __user *frame;
 	void __user *restorer;
 	void __user *fp = NULL;
@@ -296,9 +296,9 @@ Efault:
 	return -EFAULT;
 }
 
-int ia32_setup_rt_frame(struct ksignal *ksig,
-			compat_sigset_t *set, struct pt_regs *regs)
+int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
+	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
 	struct rt_sigframe_ia32 __user *frame;
 	void __user *restorer;
 	void __user *fp = NULL;
diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 08826ad..2f255ac 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -14,10 +14,8 @@
 # include <uapi/asm/sigcontext.h>
 # include <asm/user32.h>
 struct ksignal;
-int ia32_setup_rt_frame(struct ksignal *ksig,
-			compat_sigset_t *set, struct pt_regs *regs);
-int ia32_setup_frame(struct ksignal *ksig,
-		     compat_sigset_t *set, struct pt_regs *regs);
+int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
+int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs);
 #else
 # define user_i387_ia32_struct	user_i387_struct
 # define user32_fxsr_struct	user_fxsr_struct
diff --git a/arch/x86/include/asm/signal.h b/arch/x86/include/asm/signal.h
index 2dfb5fe..4a4043c 100644
--- a/arch/x86/include/asm/signal.h
+++ b/arch/x86/include/asm/signal.h
@@ -28,11 +28,6 @@ typedef struct {
 #define SA_IA32_ABI	0x02000000u
 #define SA_X32_ABI	0x01000000u
 
-#ifndef CONFIG_COMPAT
-#define compat_sigset_t compat_sigset_t
-typedef sigset_t compat_sigset_t;
-#endif
-
 #endif /* __ASSEMBLY__ */
 #include <uapi/asm/signal.h>
 #ifndef __ASSEMBLY__
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 40b1373..489a085 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -324,9 +324,9 @@ static const struct {
 };
 
 static int
-__setup_frame(struct ksignal *ksig, sigset_t *set,
-	      struct pt_regs *regs)
+__setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
+	sigset_t *set = sigmask_to_save();
 	struct sigframe __user *frame;
 	void __user *restorer;
 	void __user *fp = NULL;
@@ -379,9 +379,9 @@ Efault:
 	return -EFAULT;
 }
 
-static int __setup_rt_frame(struct ksignal *ksig,
-			    sigset_t *set, struct pt_regs *regs)
+static int __setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
+	sigset_t *set = sigmask_to_save();
 	struct rt_sigframe __user *frame;
 	void __user *restorer;
 	void __user *fp = NULL;
@@ -458,9 +458,9 @@ static unsigned long frame_uc_flags(struct pt_regs *regs)
 	return flags;
 }
 
-static int __setup_rt_frame(struct ksignal *ksig,
-			    sigset_t *set, struct pt_regs *regs)
+static int __setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
+	sigset_t *set = sigmask_to_save();
 	struct rt_sigframe __user *frame;
 	void __user *fp = NULL;
 	unsigned long uc_flags;
@@ -560,11 +560,10 @@ int copy_siginfo_to_user32(struct compat_siginfo __user *to,
 }
 #endif /* CONFIG_X86_X32_ABI */
 
-static int x32_setup_rt_frame(struct ksignal *ksig,
-			      compat_sigset_t *set,
-			      struct pt_regs *regs)
+static int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_X32_ABI
+	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
 	struct rt_sigframe_x32 __user *frame;
 	unsigned long uc_flags;
 	void __user *restorer;
@@ -763,22 +762,19 @@ static inline int is_x32_frame(struct ksignal *ksig)
 static int
 setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
-	sigset_t *set = sigmask_to_save();
-	compat_sigset_t *cset = (compat_sigset_t *) set;
-
 	/* Perform fixup for the pre-signal frame. */
 	rseq_signal_deliver(ksig, regs);
 
 	/* Set up the stack frame */
 	if (is_ia32_frame(ksig)) {
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
-			return ia32_setup_rt_frame(ksig, cset, regs);
+			return ia32_setup_rt_frame(ksig, regs);
 		else
-			return ia32_setup_frame(ksig, cset, regs);
+			return ia32_setup_frame(ksig, regs);
 	} else if (is_x32_frame(ksig)) {
-		return x32_setup_rt_frame(ksig, cset, regs);
+		return x32_setup_rt_frame(ksig, regs);
 	} else {
-		return __setup_rt_frame(ksig, set, regs);
+		return __setup_rt_frame(ksig, regs);
 	}
 }
 
