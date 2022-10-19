Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DD66044CF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiJSMPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiJSMOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:14:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B741C2EA1;
        Wed, 19 Oct 2022 04:50:57 -0700 (PDT)
Date:   Wed, 19 Oct 2022 08:55:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666169751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQ5DMmbfHzNYcXPZAhtE/eVm3dkudM99QWV4vaM1NtA=;
        b=QylOY3gzUnX4OaR5VsL7q8WNt4TkjzzCjH/0nGHs5XTMHFVpFj8tEFfKo0u291vLDxww2z
        6dd0y5pcnjNztySpMhaJB1et58/AWRxRvh2hTnQd0l4ZDsD5vMAJjSQSHkw28ZRuEXUtDd
        O7hF/jyr8Leth99LuTmDbNR2aHDgfjigMl2aRfmvDxlek10sogxo0WW0aGSaHe3V6Jja38
        BYyBziZ80W20stuBLM3eCNL2kXDZiX4OKvgYiwuhgRx962fZbs0VtX4CwUfldYo6RxkUU4
        Kn1LGnifVLM0Vjm2Ujom/m7UWBApgCo67nAkiQ+8t7qJIpI8cB/OPjtPYQdOWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666169751;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQ5DMmbfHzNYcXPZAhtE/eVm3dkudM99QWV4vaM1NtA=;
        b=jG6um6GjEY6NS35mSe0Yc5e6epXDaYYZFk56h5Lj38TV6lelWNeM4FcDRVRVOyjad8N/2f
        hLupGzUIXNt7YUBw==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/signal: Remove sig parameter from frame setup functions
Cc:     Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220606203802.158958-2-brgerst@gmail.com>
References: <20220606203802.158958-2-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <166616975030.401.1631367477728769611.tip-bot2@tip-bot2>
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

Commit-ID:     8bb2d28e2b92ef220e82369ff31a22f39831cf2f
Gitweb:        https://git.kernel.org/tip/8bb2d28e2b92ef220e82369ff31a22f39831cf2f
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 06 Jun 2022 16:37:55 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 Oct 2022 09:58:48 +02:00

x86/signal: Remove sig parameter from frame setup functions

Passing the signal number as a separate parameter is unnecessary, since
it is always ksig->sig.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lore.kernel.org/r/20220606203802.158958-2-brgerst@gmail.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/ia32/ia32_signal.c       | 12 ++++++------
 arch/x86/include/asm/fpu/signal.h |  4 ++--
 arch/x86/kernel/signal.c          | 23 +++++++++++------------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index c9c3859..390347a 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -230,7 +230,7 @@ static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 	return (void __user *) sp;
 }
 
-int ia32_setup_frame(int sig, struct ksignal *ksig,
+int ia32_setup_frame(struct ksignal *ksig,
 		     compat_sigset_t *set, struct pt_regs *regs)
 {
 	struct sigframe_ia32 __user *frame;
@@ -264,7 +264,7 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
-	unsafe_put_user(sig, &frame->sig, Efault);
+	unsafe_put_user(ksig->sig, &frame->sig, Efault);
 	unsafe_put_sigcontext32(&frame->sc, fp, regs, set, Efault);
 	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
 	unsafe_put_user(ptr_to_compat(restorer), &frame->pretcode, Efault);
@@ -280,7 +280,7 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
 
 	/* Make -mregparm=3 work */
-	regs->ax = sig;
+	regs->ax = ksig->sig;
 	regs->dx = 0;
 	regs->cx = 0;
 
@@ -296,7 +296,7 @@ Efault:
 	return -EFAULT;
 }
 
-int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
+int ia32_setup_rt_frame(struct ksignal *ksig,
 			compat_sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe_ia32 __user *frame;
@@ -321,7 +321,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
-	unsafe_put_user(sig, &frame->sig, Efault);
+	unsafe_put_user(ksig->sig, &frame->sig, Efault);
 	unsafe_put_user(ptr_to_compat(&frame->info), &frame->pinfo, Efault);
 	unsafe_put_user(ptr_to_compat(&frame->uc), &frame->puc, Efault);
 
@@ -357,7 +357,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
 
 	/* Make -mregparm=3 work */
-	regs->ax = sig;
+	regs->ax = ksig->sig;
 	regs->dx = (unsigned long) &frame->info;
 	regs->cx = (unsigned long) &frame->uc;
 
diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index e1c9df9..08826ad 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -14,9 +14,9 @@
 # include <uapi/asm/sigcontext.h>
 # include <asm/user32.h>
 struct ksignal;
-int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
+int ia32_setup_rt_frame(struct ksignal *ksig,
 			compat_sigset_t *set, struct pt_regs *regs);
-int ia32_setup_frame(int sig, struct ksignal *ksig,
+int ia32_setup_frame(struct ksignal *ksig,
 		     compat_sigset_t *set, struct pt_regs *regs);
 #else
 # define user_i387_ia32_struct	user_i387_struct
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 9c7265b..40b1373 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -324,7 +324,7 @@ static const struct {
 };
 
 static int
-__setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
+__setup_frame(struct ksignal *ksig, sigset_t *set,
 	      struct pt_regs *regs)
 {
 	struct sigframe __user *frame;
@@ -336,7 +336,7 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
-	unsafe_put_user(sig, &frame->sig, Efault);
+	unsafe_put_user(ksig->sig, &frame->sig, Efault);
 	unsafe_put_sigcontext(&frame->sc, fp, regs, set, Efault);
 	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
 	if (current->mm->context.vdso)
@@ -363,7 +363,7 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	/* Set up registers for signal handler */
 	regs->sp = (unsigned long)frame;
 	regs->ip = (unsigned long)ksig->ka.sa.sa_handler;
-	regs->ax = (unsigned long)sig;
+	regs->ax = (unsigned long)ksig->sig;
 	regs->dx = 0;
 	regs->cx = 0;
 
@@ -379,7 +379,7 @@ Efault:
 	return -EFAULT;
 }
 
-static int __setup_rt_frame(int sig, struct ksignal *ksig,
+static int __setup_rt_frame(struct ksignal *ksig,
 			    sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
@@ -391,7 +391,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	if (!user_access_begin(frame, sizeof(*frame)))
 		return -EFAULT;
 
-	unsafe_put_user(sig, &frame->sig, Efault);
+	unsafe_put_user(ksig->sig, &frame->sig, Efault);
 	unsafe_put_user(&frame->info, &frame->pinfo, Efault);
 	unsafe_put_user(&frame->uc, &frame->puc, Efault);
 
@@ -428,7 +428,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	/* Set up registers for signal handler */
 	regs->sp = (unsigned long)frame;
 	regs->ip = (unsigned long)ksig->ka.sa.sa_handler;
-	regs->ax = (unsigned long)sig;
+	regs->ax = (unsigned long)ksig->sig;
 	regs->dx = (unsigned long)&frame->info;
 	regs->cx = (unsigned long)&frame->uc;
 
@@ -458,7 +458,7 @@ static unsigned long frame_uc_flags(struct pt_regs *regs)
 	return flags;
 }
 
-static int __setup_rt_frame(int sig, struct ksignal *ksig,
+static int __setup_rt_frame(struct ksignal *ksig,
 			    sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
@@ -493,7 +493,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	}
 
 	/* Set up registers for signal handler */
-	regs->di = sig;
+	regs->di = ksig->sig;
 	/* In case the signal handler was declared without prototypes */
 	regs->ax = 0;
 
@@ -763,7 +763,6 @@ static inline int is_x32_frame(struct ksignal *ksig)
 static int
 setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
-	int usig = ksig->sig;
 	sigset_t *set = sigmask_to_save();
 	compat_sigset_t *cset = (compat_sigset_t *) set;
 
@@ -773,13 +772,13 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	/* Set up the stack frame */
 	if (is_ia32_frame(ksig)) {
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO)
-			return ia32_setup_rt_frame(usig, ksig, cset, regs);
+			return ia32_setup_rt_frame(ksig, cset, regs);
 		else
-			return ia32_setup_frame(usig, ksig, cset, regs);
+			return ia32_setup_frame(ksig, cset, regs);
 	} else if (is_x32_frame(ksig)) {
 		return x32_setup_rt_frame(ksig, cset, regs);
 	} else {
-		return __setup_rt_frame(ksig->sig, ksig, set, regs);
+		return __setup_rt_frame(ksig, set, regs);
 	}
 }
 
