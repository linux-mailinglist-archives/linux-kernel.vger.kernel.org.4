Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9037660AF19
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJXPcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiJXPcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:32:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6242C3AE69
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 07:19:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADB281042;
        Mon, 24 Oct 2022 07:09:02 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 587483F792;
        Mon, 24 Oct 2022 07:08:55 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, mhiramat@kernel.org, revest@chromium.org,
        rostedt@goodmis.org, will@kernel.org
Subject: [PATCH 1/4] ftrace: pass fregs to arch_ftrace_set_direct_caller()
Date:   Mon, 24 Oct 2022 15:08:43 +0100
Message-Id: <20221024140846.3555435-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221024140846.3555435-1-mark.rutland@arm.com>
References: <20221024140846.3555435-1-mark.rutland@arm.com>
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

For x86, we need to move arch_ftrace_set_direct_caller() after the
definition of struct ftrace_regs. As arch_ftrace_set_direct_caller() is
always called with a non-NULL pt_regs by call_direct_funcs() whose ops
have FTRACE_OPS_FL_SAVE_REGS, it's not necessary to add an additional
NULL check.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 arch/s390/include/asm/ftrace.h |  3 ++-
 arch/x86/include/asm/ftrace.h  | 26 +++++++++++++-------------
 include/linux/ftrace.h         |  4 +++-
 kernel/trace/ftrace.c          |  3 +--
 4 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 6f80ec9c04be..53c4d1257549 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -67,8 +67,9 @@ static __always_inline void ftrace_instruction_pointer_set(struct ftrace_regs *f
  * place the direct caller in the ORIG_GPR2 part of pt_regs. This
  * tells the ftrace_caller that there's a direct caller.
  */
-static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
+static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
 {
+	struct pt_regs *regs = &fregs->regs;
 	regs->orig_gpr2 = addr;
 }
 
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 908d99b127d3..788e7c1f6463 100644
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
@@ -72,6 +59,19 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 #define FTRACE_GRAPH_TRAMP_ADDR FTRACE_GRAPH_ADDR
 #endif
 
+/*
+ * When a ftrace registered caller is tracing a function that is
+ * also set by a register_ftrace_direct() call, it needs to be
+ * differentiated in the ftrace_caller trampoline. To do this, we
+ * place the direct caller in the ORIG_AX part of pt_regs. This
+ * tells the ftrace_caller that there's a direct caller.
+ */
+static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs, unsigned long addr)
+{
+	/* Emulate a call */
+	fregs->regs.orig_ax = addr;
+}
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 struct dyn_arch_ftrace {
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 62557d4bffc2..5ca6c6680460 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -429,6 +429,7 @@ static inline int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsi
 }
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
+#ifdef CONFIG_FUNCTION_TRACER
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /*
  * This must be implemented by the architecture.
@@ -443,9 +444,10 @@ static inline int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsi
  * the return from the trampoline jump to the direct caller
  * instead of going back to the function it just traced.
  */
-static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs,
+static inline void arch_ftrace_set_direct_caller(struct ftrace_regs *fregs,
 						 unsigned long addr) { }
 #endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
+#endif /* CONFIG_FUNCTION_TRACER */
 
 #ifdef CONFIG_STACK_TRACER
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index fbf2543111c0..234c5414deee 100644
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

