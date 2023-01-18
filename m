Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932316721D7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjARPq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjARPps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:45:48 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3206303FE;
        Wed, 18 Jan 2023 07:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674056725; x=1705592725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IoX/kF38Qga/F2UYdmKAGq8FqJZa9jj/dHs6SRvXaKU=;
  b=YamH6x8Pr5CqejiXlKwEt70CCQ7O8G6EARpuByBLHxolMzBPiNyteWYf
   SNem98Uu29WE5ImermGd9gLdpUk6MrQ6Fl/+KSmTuwcYeTCUvOW/qbtDt
   C2bdnVtBWk0kfn47ROSg0bt+WlRByQt+p5aihlNtQL8wrnVXAZx4ioncv
   30sU95ir+fFGFrgd5u4fzWKlf86ckHsEkJSvA/p990WSZmc4cipuQFW/6
   qUprJIRiCoOiFXSBcykSI4xDgKDysbvJHGrFO0dFMKl74bc6utXEWG/LV
   x+Zf1umXnoaRzF1lqP/qad1NghSE8EpgJ/iMFZd16HnHDNqsnrXJwh0ox
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322701272"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322701272"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 07:45:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="661759296"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="661759296"
Received: from lab-ah.igk.intel.com ([10.102.42.211])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 07:45:20 -0800
From:   Andrzej Hajda <andrzej.hajda@intel.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v5 3/7] arch/*/uprobes: simplify arch_uretprobe_hijack_return_addr
Date:   Wed, 18 Jan 2023 16:44:46 +0100
Message-Id: <20230118154450.73842-3-andrzej.hajda@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118154450.73842-1-andrzej.hajda@intel.com>
References: <20230118153529.57695-1-andrzej.hajda@intel.com>
 <20230118154450.73842-1-andrzej.hajda@intel.com>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In all architectures, except x86, arch_uretprobe_hijack_return_addr
is just __xchg.

Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
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
index f5f790c6e5f896..77ce8ae431376d 100644
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
index d49aef2657cdf7..d7171d30ea6681 100644
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
index 2d31a12e46cfee..775fe88b5f0016 100644
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
index 6c063aa188e626..2b1f375c407b87 100644
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
index 95a41ae9dfa755..3c15c320315e6c 100644
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
index c976a21cd4bd5b..5c8415e216536d 100644
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
index b88345ef8bd9ed..18591ca40ae7e5 100644
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
index 1a0600206bf5c2..1c02653d6de3ba 100644
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
-- 
2.34.1

