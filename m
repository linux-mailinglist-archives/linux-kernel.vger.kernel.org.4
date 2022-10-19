Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86326044CB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiJSMOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbiJSMOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:14:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DE910D69F;
        Wed, 19 Oct 2022 04:50:39 -0700 (PDT)
Date:   Wed, 19 Oct 2022 08:55:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666169747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0e0EJwI9J0sxrSJRvH+ESuT6kJOraQVQ9ELcUCEdGwk=;
        b=3fIfcwMX6bgVcR5gMDQ3Qh0yG9+OLpCql3K/RRsIDdytMtYBouBSVyeNqVx7O3y3E1kfkW
        dfdYw9dIlvBCqY0X5bZpL7krHTAWtnLef48PEhcxjLV0qsn7hynTENfoXC4NgPuD+PWaG2
        kDjypSrIyoJNUFGKB69zuvrr9Wi3jUdxjpWvbFOFKzUY0C3Lk4JrpNXr7cvmrAgas1GiYu
        f+JlulmLOzRCCjMushcrBuKf8+WaxV2Ww6bokpRxjg58xg0vCzJA3yAKM10qJzRLeGzdlW
        lv9XHPA6RP8eDKMwVcqye0bPmwPsx67g+tgXpRcuIvC9cZZ4cRGcYRb4dTYNxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666169747;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0e0EJwI9J0sxrSJRvH+ESuT6kJOraQVQ9ELcUCEdGwk=;
        b=O7kKl+W2mJf81ESWHF4eLFm/zHqWzKEwoM/6xu1kixwqAdDQKx94ANrTMta138Rl6Zyv6y
        QlFQIHC+XNlFpxAA==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86: Remove __USER32_DS
Cc:     Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220606203802.158958-5-brgerst@gmail.com>
References: <20220606203802.158958-5-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <166616974560.401.6029072469431902672.tip-bot2@tip-bot2>
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

Commit-ID:     695c39bc5b8686a6b27254e60fb830f4989f322d
Gitweb:        https://git.kernel.org/tip/695c39bc5b8686a6b27254e60fb830f4989f322d
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 06 Jun 2022 16:37:58 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 Oct 2022 09:58:49 +02:00

x86: Remove __USER32_DS

Replace all users with the equivalent __USER_DS, which will make merging
native and compat code simpler.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Link: https://lore.kernel.org/r/20220606203802.158958-5-brgerst@gmail.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/entry/entry_64_compat.S |  4 ++--
 arch/x86/ia32/ia32_signal.c      | 14 +++++++-------
 arch/x86/include/asm/elf.h       |  4 ----
 arch/x86/include/asm/segment.h   |  1 -
 arch/x86/xen/xen-asm.S           |  8 ++++----
 5 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 4dd1981..59b9390 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -61,7 +61,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 	/* Construct struct pt_regs on stack */
-	pushq	$__USER32_DS		/* pt_regs->ss */
+	pushq	$__USER_DS		/* pt_regs->ss */
 	pushq	$0			/* pt_regs->sp = 0 (placeholder) */
 
 	/*
@@ -197,7 +197,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 
 	/* Construct struct pt_regs on stack */
-	pushq	$__USER32_DS		/* pt_regs->ss */
+	pushq	$__USER_DS		/* pt_regs->ss */
 	pushq	%r8			/* pt_regs->sp */
 	pushq	%r11			/* pt_regs->flags */
 	pushq	$__USER32_CS		/* pt_regs->cs */
diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index b67e276..a78885e 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -212,7 +212,7 @@ static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 	if (ksig->ka.sa.sa_flags & SA_ONSTACK)
 		sp = sigsp(sp, ksig);
 	/* This is the legacy signal stack switching. */
-	else if (regs->ss != __USER32_DS &&
+	else if (regs->ss != __USER_DS &&
 		!(ksig->ka.sa.sa_flags & SA_RESTORER) &&
 		 ksig->ka.sa.sa_restorer)
 		sp = (unsigned long) ksig->ka.sa.sa_restorer;
@@ -284,11 +284,11 @@ int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 	regs->dx = 0;
 	regs->cx = 0;
 
-	loadsegment(ds, __USER32_DS);
-	loadsegment(es, __USER32_DS);
+	loadsegment(ds, __USER_DS);
+	loadsegment(es, __USER_DS);
 
 	regs->cs = __USER32_CS;
-	regs->ss = __USER32_DS;
+	regs->ss = __USER_DS;
 
 	return 0;
 Efault:
@@ -361,11 +361,11 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	regs->dx = (unsigned long) &frame->info;
 	regs->cx = (unsigned long) &frame->uc;
 
-	loadsegment(ds, __USER32_DS);
-	loadsegment(es, __USER32_DS);
+	loadsegment(ds, __USER_DS);
+	loadsegment(es, __USER_DS);
 
 	regs->cs = __USER32_CS;
-	regs->ss = __USER32_DS;
+	regs->ss = __USER_DS;
 
 	return 0;
 Efault:
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index cb0ff10..be8b58d 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -152,10 +152,6 @@ do {						\
 	(elf_check_arch_ia32(x) ||					\
 	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64))
 
-#if __USER32_DS != __USER_DS
-# error "The following code assumes __USER32_DS == __USER_DS"
-#endif
-
 static inline void elf_common_init(struct thread_struct *t,
 				   struct pt_regs *regs, const u16 ds)
 {
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 2e7890d..e056c29 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -210,7 +210,6 @@
 #define __KERNEL_DS			(GDT_ENTRY_KERNEL_DS*8)
 #define __USER32_CS			(GDT_ENTRY_DEFAULT_USER32_CS*8 + 3)
 #define __USER_DS			(GDT_ENTRY_DEFAULT_USER_DS*8 + 3)
-#define __USER32_DS			__USER_DS
 #define __USER_CS			(GDT_ENTRY_DEFAULT_USER_CS*8 + 3)
 #define __CPUNODE_SEG			(GDT_ENTRY_CPUNODE*8 + 3)
 
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 6b4fdf6..4a184f6 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -262,10 +262,10 @@ SYM_CODE_START(xen_entry_SYSCALL_compat)
 
 	/*
 	 * Neither Xen nor the kernel really knows what the old SS and
-	 * CS were.  The kernel expects __USER32_DS and __USER32_CS, so
+	 * CS were.  The kernel expects __USER_DS and __USER32_CS, so
 	 * report those values even though Xen will guess its own values.
 	 */
-	movq $__USER32_DS, 4*8(%rsp)
+	movq $__USER_DS, 4*8(%rsp)
 	movq $__USER32_CS, 1*8(%rsp)
 
 	jmp entry_SYSCALL_compat_after_hwframe
@@ -284,10 +284,10 @@ SYM_CODE_START(xen_entry_SYSENTER_compat)
 
 	/*
 	 * Neither Xen nor the kernel really knows what the old SS and
-	 * CS were.  The kernel expects __USER32_DS and __USER32_CS, so
+	 * CS were.  The kernel expects __USER_DS and __USER32_CS, so
 	 * report those values even though Xen will guess its own values.
 	 */
-	movq $__USER32_DS, 4*8(%rsp)
+	movq $__USER_DS, 4*8(%rsp)
 	movq $__USER32_CS, 1*8(%rsp)
 
 	jmp entry_SYSENTER_compat_after_hwframe
