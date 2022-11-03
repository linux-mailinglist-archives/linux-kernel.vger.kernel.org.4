Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2AB6185C0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKCRGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiKCRF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:05:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CEDFFE1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:05:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C79223A;
        Thu,  3 Nov 2022 10:05:38 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 85DB73F5A1;
        Thu,  3 Nov 2022 10:05:30 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, mhiramat@kernel.org, revest@chromium.org,
        rostedt@goodmis.org, will@kernel.org
Subject: [PATCH v2 1/4] ftrace: pass fregs to arch_ftrace_set_direct_caller()
Date:   Thu,  3 Nov 2022 17:05:17 +0000
Message-Id: <20221103170520.931305-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221103170520.931305-1-mark.rutland@arm.com>
References: <20221103170520.931305-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In subsequent patches we'll arrange for architectures to have an
ftrace_regs which is entirely distinct from pt_regs. In preparation for
this, we need to minimize the use of pt_regs to where strictly
necessary in the core ftrace code.

This patch changes the prototype of arch_ftrace_set_direct_caller() to
take ftrace_regs rather than pt_regs, and moves the extraction of the
pt_regs into arch_ftrace_set_direct_caller().

On x86, arch_ftrace_set_direct_caller() can be used even when
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=n, and <linux/ftrace.h> defines
struct ftrace_regs. Due to this, it's necessary to define
arch_ftrace_set_direct_caller() as a macro to avoid using an incomplete
type. I've also moved the body of arch_ftrace_set_direct_caller() after
the CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y defineidion of struct
ftrace_regs.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 arch/s390/include/asm/ftrace.h |  5 ++++-
 arch/x86/include/asm/ftrace.h  | 31 ++++++++++++++++++-------------
 include/linux/ftrace.h         |  9 ++++-----
 kernel/trace/ftrace.c          |  3 +--
 4 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 6f80ec9c04be9..85bc26ccdb872 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -60,6 +60,7 @@ static __always_inline void ftrace_instruction_pointer_set(struct ftrace_regs *f
 	fregs->regs.psw.addr = ip;
 }
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /*
  * When an ftrace registered caller is tracing a function that is
  * also set by a register_ftrace_direct() call, it needs to be
@@ -67,10 +68,12 @@ static __always_inline void ftrace_instruction_pointer_set(struct ftrace_regs *f
  * place the direct caller in the ORIG_GPR2 part of pt_regs. This
  * tells the ftrace_caller that there's a direct caller.
  */
-static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
+static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
 {
+	struct pt_regs *regs = &fregs->regs;
 	regs->orig_gpr2 = addr;
 }
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /*
  * Even though the system call numbers are identical for s390/s390x a
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 908d99b127d31..d2350a8351fa4 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -34,19 +34,6 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
-/*
- * When a ftrace registered caller is tracing a function that is
- * also set by a register_ftrace_direct() call, it needs to be
- * differentiated in the ftrace_caller trampoline. To do this, we
- * place the direct caller in the ORIG_AX part of pt_regs. This
- * tells the ftrace_caller that there's a direct caller.
- */
-static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
-{
-	/* Emulate a call */
-	regs->orig_ax = addr;
-}
-
 #ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 struct ftrace_regs {
 	struct pt_regs		regs;
@@ -72,6 +59,24 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 #define FTRACE_GRAPH_TRAMP_ADDR FTRACE_GRAPH_ADDR
 #endif
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+/*
+ * When a ftrace registered caller is tracing a function that is
+ * also set by a register_ftrace_direct() call, it needs to be
+ * differentiated in the ftrace_caller trampoline. To do this, we
+ * place the direct caller in the ORIG_AX part of pt_regs. This
+ * tells the ftrace_caller that there's a direct caller.
+ */
+static inline void
+__arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
+{
+	/* Emulate a call */
+	regs->orig_ax = addr;
+}
+#define arch_ftrace_set_direct_caller(fregs, addr) \
+	__arch_ftrace_set_direct_caller(&(fregs)->regs, addr)
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 struct dyn_arch_ftrace {
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 62557d4bffc2b..f201fcbfffb07 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -37,9 +37,10 @@ extern void ftrace_boot_snapshot(void);
 static inline void ftrace_boot_snapshot(void) { }
 #endif
 
-#ifdef CONFIG_FUNCTION_TRACER
 struct ftrace_ops;
 struct ftrace_regs;
+
+#ifdef CONFIG_FUNCTION_TRACER
 /*
  * If the arch's mcount caller does not support all of ftrace's
  * features, then it must call an indirect function that
@@ -427,9 +428,7 @@ static inline int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsi
 {
 	return -ENODEV;
 }
-#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
-#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /*
  * This must be implemented by the architecture.
  * It is the way the ftrace direct_ops helper, when called
@@ -443,9 +442,9 @@ static inline int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsi
  * the return from the trampoline jump to the direct caller
  * instead of going back to the function it just traced.
  */
-static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs,
+static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
 						 unsigned long addr) { }
-#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #ifdef CONFIG_STACK_TRACER
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fbf2543111c05..234c5414deeeb 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2487,14 +2487,13 @@ ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
-	struct pt_regs *regs = ftrace_get_regs(fregs);
 	unsigned long addr;
 
 	addr = ftrace_find_rec_direct(ip);
 	if (!addr)
 		return;
 
-	arch_ftrace_set_direct_caller(regs, addr);
+	arch_ftrace_set_direct_caller(fregs, addr);
 }
 
 struct ftrace_ops direct_ops = {
-- 
2.30.2

