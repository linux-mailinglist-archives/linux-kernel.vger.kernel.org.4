Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4BD6B673E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjCLOla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCLOlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:41:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDABD457EA;
        Sun, 12 Mar 2023 07:41:16 -0700 (PDT)
Date:   Sun, 12 Mar 2023 14:41:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678632075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ibnjpqknbd/BV0ptLJW3NCZXE4/K0EsGAPtfYJyjFyA=;
        b=PYadZxq8WKhygdPM7ofVQPwZrm2RtGVU9UFJO/dnic9jPSRS/8Nt6W+WrbVHDLpIHKzit1
        vkzrwP+nqzd+J3sPy2IqMxEJrsXHRBpHRPy9M5+2DnTp88T3XYMf7F+UKGllZ7wXqvn3vr
        KIq1JDNnDwmPpOmV1ok7SPjN4UuC1vWDaf0ZErPphsWtsKK1mpQvL6vnnYO0MfI6LlU7Ez
        YEQFvF4T+NDEfDks0oCFLyN5lUnr/OCgdkFrkdQOaYgg7sHHoCcKT5II47u/D6aRGnzZ+M
        m5Bb03TIPcjaIrChckiBf1hhov5kDbh7Ef8/5OrgWo7J+8skfjfs6YL7puTpow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678632075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ibnjpqknbd/BV0ptLJW3NCZXE4/K0EsGAPtfYJyjFyA=;
        b=NJfp8G19ClG5sC5jhbcVioZYDdAjm0IO/HA0UkWD9wfJW2RSyGUnOCuJjVCpW3NsIzrMJt
        nxB/5MR/uCTnnBBA==
From:   "tip-bot2 for Andrzej Hajda" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] arch/*/uprobes: simplify
 arch_uretprobe_hijack_return_addr
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Shyti <andi.shyti@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230118154450.73842-3-andrzej.hajda@intel.com>
References: <20230118154450.73842-3-andrzej.hajda@intel.com>
MIME-Version: 1.0
Message-ID: <167863207454.5837.3204445359425962539.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     26ace5d28d3645efe735c3c2ff0b80dd17c85cb2
Gitweb:        https://git.kernel.org/tip/26ace5d28d3645efe735c3c2ff0b80dd17c85cb2
Author:        Andrzej Hajda <andrzej.hajda@intel.com>
AuthorDate:    Wed, 18 Jan 2023 16:44:46 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 11 Mar 2023 14:03:59 +01:00

arch/*/uprobes: simplify arch_uretprobe_hijack_return_addr

In all architectures, except x86, arch_uretprobe_hijack_return_addr
is just __xchg.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://lore.kernel.org/r/20230118154450.73842-3-andrzej.hajda@intel.com
---
 arch/arm/probes/uprobes/core.c     |  8 ++------
 arch/arm64/kernel/probes/uprobes.c |  9 ++-------
 arch/csky/kernel/probes/uprobes.c  |  9 ++-------
 arch/mips/kernel/uprobes.c         | 10 ++--------
 arch/powerpc/kernel/uprobes.c      | 10 ++--------
 arch/riscv/kernel/probes/uprobes.c |  9 ++-------
 arch/s390/kernel/uprobes.c         |  7 ++-----
 arch/sparc/kernel/uprobes.c        |  7 ++-----
 8 files changed, 16 insertions(+), 53 deletions(-)

diff --git a/arch/arm/probes/uprobes/core.c b/arch/arm/probes/uprobes/core.c
index f5f790c..77ce8ae 100644
--- a/arch/arm/probes/uprobes/core.c
+++ b/arch/arm/probes/uprobes/core.c
@@ -9,6 +9,7 @@
 #include <linux/highmem.h>
 #include <linux/sched.h>
 #include <linux/uprobes.h>
+#include <linux/non-atomic/xchg.h>
 #include <linux/notifier.h>
 
 #include <asm/opcodes.h>
@@ -61,12 +62,7 @@ unsigned long
 arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
 				  struct pt_regs *regs)
 {
-	unsigned long orig_ret_vaddr;
-
-	orig_ret_vaddr = regs->ARM_lr;
-	/* Replace the return addr with trampoline addr */
-	regs->ARM_lr = trampoline_vaddr;
-	return orig_ret_vaddr;
+	return __xchg(&regs->ARM_lr, trampoline_vaddr);
 }
 
 int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index d49aef2..d7171d3 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2014-2016 Pratyush Anand <panand@redhat.com>
  */
 #include <linux/highmem.h>
+#include <linux/non-atomic/xchg.h>
 #include <linux/ptrace.h>
 #include <linux/uprobes.h>
 #include <asm/cacheflush.h>
@@ -150,13 +151,7 @@ unsigned long
 arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
 				  struct pt_regs *regs)
 {
-	unsigned long orig_ret_vaddr;
-
-	orig_ret_vaddr = procedure_link_pointer(regs);
-	/* Replace the return addr with trampoline addr */
-	procedure_link_pointer_set(regs, trampoline_vaddr);
-
-	return orig_ret_vaddr;
+	return __xchg(&procedure_link_pointer(regs), trampoline_vaddr);
 }
 
 int arch_uprobe_exception_notify(struct notifier_block *self,
diff --git a/arch/csky/kernel/probes/uprobes.c b/arch/csky/kernel/probes/uprobes.c
index 2d31a12..775fe88 100644
--- a/arch/csky/kernel/probes/uprobes.c
+++ b/arch/csky/kernel/probes/uprobes.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2014-2016 Pratyush Anand <panand@redhat.com>
  */
 #include <linux/highmem.h>
+#include <linux/non-atomic/xchg.h>
 #include <linux/ptrace.h>
 #include <linux/uprobes.h>
 #include <asm/cacheflush.h>
@@ -123,13 +124,7 @@ unsigned long
 arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
 				  struct pt_regs *regs)
 {
-	unsigned long ra;
-
-	ra = regs->lr;
-
-	regs->lr = trampoline_vaddr;
-
-	return ra;
+	return __xchg(&regs->lr, trampoline_vaddr);
 }
 
 int arch_uprobe_exception_notify(struct notifier_block *self,
diff --git a/arch/mips/kernel/uprobes.c b/arch/mips/kernel/uprobes.c
index 6c063aa..2b1f375 100644
--- a/arch/mips/kernel/uprobes.c
+++ b/arch/mips/kernel/uprobes.c
@@ -2,6 +2,7 @@
 #include <linux/highmem.h>
 #include <linux/kdebug.h>
 #include <linux/types.h>
+#include <linux/non-atomic/xchg.h>
 #include <linux/notifier.h>
 #include <linux/sched.h>
 #include <linux/uprobes.h>
@@ -197,14 +198,7 @@ void arch_uprobe_abort_xol(struct arch_uprobe *aup,
 unsigned long arch_uretprobe_hijack_return_addr(
 	unsigned long trampoline_vaddr, struct pt_regs *regs)
 {
-	unsigned long ra;
-
-	ra = regs->regs[31];
-
-	/* Replace the return address with the trampoline address */
-	regs->regs[31] = trampoline_vaddr;
-
-	return ra;
+	return __xchg(&regs->regs[31], trampoline_vaddr);
 }
 
 /**
diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
index 95a41ae..3c15c32 100644
--- a/arch/powerpc/kernel/uprobes.c
+++ b/arch/powerpc/kernel/uprobes.c
@@ -7,6 +7,7 @@
  * Adapted from the x86 port by Ananth N Mavinakayanahalli <ananth@in.ibm.com>
  */
 #include <linux/kernel.h>
+#include <linux/non-atomic/xchg.h>
 #include <linux/sched.h>
 #include <linux/ptrace.h>
 #include <linux/uprobes.h>
@@ -197,14 +198,7 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
 unsigned long
 arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs *regs)
 {
-	unsigned long orig_ret_vaddr;
-
-	orig_ret_vaddr = regs->link;
-
-	/* Replace the return addr with trampoline addr */
-	regs->link = trampoline_vaddr;
-
-	return orig_ret_vaddr;
+	return __xchg(&regs->link, trampoline_vaddr);
 }
 
 bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index c976a21..5c8415e 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/highmem.h>
+#include <linux/non-atomic/xchg.h>
 #include <linux/ptrace.h>
 #include <linux/uprobes.h>
 
@@ -122,13 +123,7 @@ unsigned long
 arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
 				  struct pt_regs *regs)
 {
-	unsigned long ra;
-
-	ra = regs->ra;
-
-	regs->ra = trampoline_vaddr;
-
-	return ra;
+	return __xchg(&regs->ra, trampoline_vaddr);
 }
 
 int arch_uprobe_exception_notify(struct notifier_block *self,
diff --git a/arch/s390/kernel/uprobes.c b/arch/s390/kernel/uprobes.c
index b88345e..18591ca 100644
--- a/arch/s390/kernel/uprobes.c
+++ b/arch/s390/kernel/uprobes.c
@@ -11,6 +11,7 @@
 #include <linux/compat.h>
 #include <linux/kdebug.h>
 #include <linux/sched/task_stack.h>
+#include <linux/non-atomic/xchg.h>
 
 #include <asm/switch_to.h>
 #include <asm/facility.h>
@@ -144,11 +145,7 @@ void arch_uprobe_abort_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 unsigned long arch_uretprobe_hijack_return_addr(unsigned long trampoline,
 						struct pt_regs *regs)
 {
-	unsigned long orig;
-
-	orig = regs->gprs[14];
-	regs->gprs[14] = trampoline;
-	return orig;
+	return __xchg(&regs->gprs[14], trampoline);
 }
 
 bool arch_uretprobe_is_alive(struct return_instance *ret, enum rp_check ctx,
diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
index 1a06002..1c02653 100644
--- a/arch/sparc/kernel/uprobes.c
+++ b/arch/sparc/kernel/uprobes.c
@@ -11,6 +11,7 @@
 
 #include <linux/kernel.h>
 #include <linux/highmem.h>
+#include <linux/non-atomic/xchg.h>
 #include <linux/uprobes.h>
 #include <linux/uaccess.h>
 #include <linux/sched.h> /* For struct task_struct */
@@ -310,9 +311,5 @@ unsigned long
 arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
 				  struct pt_regs *regs)
 {
-	unsigned long orig_ret_vaddr = regs->u_regs[UREG_I7];
-
-	regs->u_regs[UREG_I7] = trampoline_vaddr-8;
-
-	return orig_ret_vaddr + 8;
+	return __xchg(&regs->u_regs[UREG_I7], trampoline_vaddr - 8) + 8;
 }
