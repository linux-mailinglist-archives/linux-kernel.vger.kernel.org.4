Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820AB6044CA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiJSMOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbiJSMN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:13:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11251A2084;
        Wed, 19 Oct 2022 04:50:20 -0700 (PDT)
Date:   Wed, 19 Oct 2022 08:55:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666169745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G29mZsSDnyfBqk1YPL3lpVmXOQW96znUnkfWA0ulVBA=;
        b=a99hvSKbPbToV0TEAnN282NvIkLRIoDzGIkBg8Lw5iaj8Y7KZPPfojmRuv0C659E1jLqbV
        t8Jg1dWV5/VoWcJ9jWlAGAnBOhukU/VqX236igj2/C1dAu3kZazgvn+A5ZXngco/QG26dy
        yyA6nMGdiIsHu+MS8QUhetUdFis+QagaWrEpALoseDobqVbk8Ejz1CUDESBG/JVYBGOvDb
        VdB4xtj4styz2p4wjeqb7HfPOBFLXk5ecOTMPOMaSajPsxeVacJILcyd2p1gz+9q4ta6a7
        SkDTE6eDLXTpkxZBzZCfUjwunpk9Oo9swdC9vBK9U+BGfJd8dMswXT538u8+lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666169745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G29mZsSDnyfBqk1YPL3lpVmXOQW96znUnkfWA0ulVBA=;
        b=yKsSlVt1rRBLmA3pby+nYpMRBjsFgEeXqy6T/FJLDvq/WOV/8j1zuk4N0+yxZJvZqrD8uH
        o0tMml/a6Wrk3UAA==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/signal: Add ABI prefixes to frame setup functions
Cc:     Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220606203802.158958-7-brgerst@gmail.com>
References: <20220606203802.158958-7-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <166616974303.401.3021440066033788592.tip-bot2@tip-bot2>
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

Commit-ID:     c461ae39373a1ae21952dbb6e2668a693d9f761d
Gitweb:        https://git.kernel.org/tip/c461ae39373a1ae21952dbb6e2668a693d9f761d
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 06 Jun 2022 16:38:00 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 Oct 2022 09:58:49 +02:00

x86/signal: Add ABI prefixes to frame setup functions

Add ABI prefixes to the frame setup functions that didn't already have
them.  To avoid compiler warnings and prepare for moving these functions
to separate files, make them non-static.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lore.kernel.org/r/20220606203802.158958-7-brgerst@gmail.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fpu/signal.h  |  5 -----
 arch/x86/include/asm/sighandling.h |  5 +++++
 arch/x86/kernel/signal.c           | 18 +++++++-----------
 3 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 2f255ac..611fa41 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -13,14 +13,9 @@
 #ifdef CONFIG_X86_64
 # include <uapi/asm/sigcontext.h>
 # include <asm/user32.h>
-struct ksignal;
-int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
-int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs);
 #else
 # define user_i387_ia32_struct	user_i387_struct
 # define user32_fxsr_struct	user_fxsr_struct
-# define ia32_setup_frame	__setup_frame
-# define ia32_setup_rt_frame	__setup_rt_frame
 #endif
 
 extern void convert_from_fxsr(struct user_i387_ia32_struct *env,
diff --git a/arch/x86/include/asm/sighandling.h b/arch/x86/include/asm/sighandling.h
index c9e9784..e770c4f 100644
--- a/arch/x86/include/asm/sighandling.h
+++ b/arch/x86/include/asm/sighandling.h
@@ -19,4 +19,9 @@ void __user *
 get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	     void __user **fpstate);
 
+int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs);
+int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
+int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
+int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs);
+
 #endif /* _ASM_X86_SIGHANDLING_H */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 890ca05..0511e05 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -336,8 +336,7 @@ static const struct {
 	0
 };
 
-static int
-__setup_frame(struct ksignal *ksig, struct pt_regs *regs)
+int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
 	sigset_t *set = sigmask_to_save();
 	struct sigframe __user *frame;
@@ -392,7 +391,7 @@ Efault:
 	return -EFAULT;
 }
 
-static int __setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
 	sigset_t *set = sigmask_to_save();
 	struct rt_sigframe __user *frame;
@@ -471,7 +470,7 @@ static unsigned long frame_uc_flags(struct pt_regs *regs)
 	return flags;
 }
 
-static int __setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
 	sigset_t *set = sigmask_to_save();
 	struct rt_sigframe __user *frame;
@@ -571,11 +570,9 @@ int copy_siginfo_to_user32(struct compat_siginfo __user *to,
 		return x32_copy_siginfo_to_user(to, from);
 	return __copy_siginfo_to_user32(to, from);
 }
-#endif /* CONFIG_X86_X32_ABI */
 
-static int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
-#ifdef CONFIG_X86_X32_ABI
 	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
 	struct rt_sigframe_x32 __user *frame;
 	unsigned long uc_flags;
@@ -622,15 +619,14 @@ static int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 
 	regs->cs = __USER_CS;
 	regs->ss = __USER_DS;
-#endif	/* CONFIG_X86_X32_ABI */
 
 	return 0;
-#ifdef CONFIG_X86_X32_ABI
+
 Efault:
 	user_access_end();
 	return -EFAULT;
-#endif
 }
+#endif /* CONFIG_X86_X32_ABI */
 
 /*
  * Do a signal return; undo the signal stack.
@@ -770,7 +766,7 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	} else if (is_x32_frame(ksig)) {
 		return x32_setup_rt_frame(ksig, regs);
 	} else {
-		return __setup_rt_frame(ksig, regs);
+		return x64_setup_rt_frame(ksig, regs);
 	}
 }
 
