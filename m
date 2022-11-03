Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3C16185C5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiKCRGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiKCRGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:06:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39E7C38A9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:05:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 006AB12FC;
        Thu,  3 Nov 2022 10:05:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F6303F5A1;
        Thu,  3 Nov 2022 10:05:35 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, mhiramat@kernel.org, revest@chromium.org,
        rostedt@goodmis.org, will@kernel.org
Subject: [PATCH v2 3/4] ftrace: abstract DYNAMIC_FTRACE_WITH_ARGS accesses
Date:   Thu,  3 Nov 2022 17:05:19 +0000
Message-Id: <20221103170520.931305-4-mark.rutland@arm.com>
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
this, we need to minimize the use of pt_regs to where strictly necessary
in the core ftrace code.

This patch adds new ftrace_regs_{get,set}_*() helpers which can be used
to manipulate ftrace_regs. When CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y,
these can always be used on any ftrace_regs, and when
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=n these can be used when regs are
available. A new ftrace_regs_has_args(fregs) helper is added which code
can use to check when these are usable.

Co-developed-by: Florent Revest <revest@chromium.org>
Signed-off-by: Florent Revest <revest@chromium.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 arch/powerpc/include/asm/ftrace.h | 19 +++++++++++++++++++
 arch/s390/include/asm/ftrace.h    | 19 +++++++++++++++++++
 arch/x86/include/asm/ftrace.h     | 16 ++++++++++++++++
 include/linux/ftrace.h            | 29 +++++++++++++++++++++++++++++
 kernel/trace/Kconfig              |  6 +++---
 5 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
index c3eb48f675669..259b9dd5fe1c5 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -44,6 +44,25 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 	regs_set_return_ip(&fregs->regs, ip);
 }
 
+static __always_inline unsigned long
+ftrace_regs_get_instruction_pointer(struct ftrace_regs *fregs)
+{
+	return instruction_pointer(&fregs->regs);
+}
+
+#define ftrace_regs_get_argument(fregs, n) \
+	regs_get_kernel_argument(&(fregs)->regs, n)
+#define ftrace_regs_get_stack_pointer(fregs) \
+	kernel_stack_pointer(&(fregs)->regs)
+#define ftrace_regs_return_value(fregs) \
+	regs_return_value(&(fregs)->regs)
+#define ftrace_regs_set_return_value(fregs, ret) \
+	regs_set_return_value(&(fregs)->regs, ret)
+#define ftrace_override_function_with_return(fregs) \
+	override_function_with_return(&(fregs)->regs)
+#define ftrace_regs_query_register_offset(name) \
+	regs_query_register_offset(name)
+
 struct ftrace_ops;
 
 #define ftrace_graph_func ftrace_graph_func
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 113d194acea01..e5c5cb1207e2c 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -54,6 +54,12 @@ static __always_inline struct pt_regs *arch_ftrace_get_regs(struct ftrace_regs *
 	return NULL;
 }
 
+static __always_inline unsigned long
+ftrace_regs_get_instruction_pointer(const struct ftrace_regs *fregs)
+{
+	return fregs->regs.psw.addr;
+}
+
 static __always_inline void
 ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 				    unsigned long ip)
@@ -61,6 +67,19 @@ ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
 	fregs->regs.psw.addr = ip;
 }
 
+#define ftrace_regs_get_argument(fregs, n) \
+	regs_get_kernel_argument(&(fregs)->regs, n)
+#define ftrace_regs_get_stack_pointer(fregs) \
+	kernel_stack_pointer(&(fregs)->regs)
+#define ftrace_regs_return_value(fregs) \
+	regs_return_value(&(fregs)->regs)
+#define ftrace_regs_set_return_value(fregs, ret) \
+	regs_set_return_value(&(fregs)->regs, ret)
+#define ftrace_override_function_with_return(fregs) \
+	override_function_with_return(&(fregs)->regs)
+#define ftrace_regs_query_register_offset(name) \
+	regs_query_register_offset(name)
+
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 /*
  * When an ftrace registered caller is tracing a function that is
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index b2925d342c650..5061ac98ffa16 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -51,6 +51,22 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 #define ftrace_regs_set_instruction_pointer(fregs, _ip)	\
 	do { (fregs)->regs.ip = (_ip); } while (0)
 
+#define ftrace_regs_get_instruction_pointer(fregs) \
+	((fregs)->regs.ip)
+
+#define ftrace_regs_get_argument(fregs, n) \
+	regs_get_kernel_argument(&(fregs)->regs, n)
+#define ftrace_regs_get_stack_pointer(fregs) \
+	kernel_stack_pointer(&(fregs)->regs)
+#define ftrace_regs_return_value(fregs) \
+	regs_return_value(&(fregs)->regs)
+#define ftrace_regs_set_return_value(fregs, ret) \
+	regs_set_return_value(&(fregs)->regs, ret)
+#define ftrace_override_function_with_return(fregs) \
+	override_function_with_return(&(fregs)->regs)
+#define ftrace_regs_query_register_offset(name) \
+	regs_query_register_offset(name)
+
 struct ftrace_ops;
 #define ftrace_graph_func ftrace_graph_func
 void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ec3657a60f850..99f1146614c04 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -126,6 +126,35 @@ static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs
 	return arch_ftrace_get_regs(fregs);
 }
 
+/*
+ * When true, the ftrace_regs_{get,set}_*() functions may be used on fregs.
+ * Note: this can be true even when ftrace_get_regs() cannot provide a pt_regs.
+ */
+static __always_inline bool ftrace_regs_has_args(struct ftrace_regs *fregs)
+{
+	if (IS_ENABLED(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS))
+		return true;
+
+	return ftrace_get_regs(fregs) != NULL;
+}
+
+#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+#define ftrace_regs_get_instruction_pointer(fregs) \
+	instruction_pointer(ftrace_get_regs(fregs))
+#define ftrace_regs_get_argument(fregs, n) \
+	regs_get_kernel_argument(ftrace_get_regs(fregs), n)
+#define ftrace_regs_get_stack_pointer(fregs) \
+	kernel_stack_pointer(ftrace_get_regs(fregs))
+#define ftrace_regs_return_value(fregs) \
+	regs_return_value(ftrace_get_regs(fregs))
+#define ftrace_regs_set_return_value(fregs, ret) \
+	regs_set_return_value(ftrace_get_regs(fregs), ret)
+#define ftrace_override_function_with_return(fregs) \
+	override_function_with_return(ftrace_get_regs(fregs))
+#define ftrace_regs_query_register_offset(name) \
+	regs_query_register_offset(name)
+#endif
+
 typedef void (*ftrace_func_t)(unsigned long ip, unsigned long parent_ip,
 			      struct ftrace_ops *op, struct ftrace_regs *fregs);
 
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e9e95c790b8ee..2c6611c13f99e 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -46,10 +46,10 @@ config HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	bool
 	help
 	 If this is set, then arguments and stack can be found from
-	 the pt_regs passed into the function callback regs parameter
+	 the ftrace_regs passed into the function callback regs parameter
 	 by default, even without setting the REGS flag in the ftrace_ops.
-	 This allows for use of regs_get_kernel_argument() and
-	 kernel_stack_pointer().
+	 This allows for use of ftrace_regs_get_argument() and
+	 ftrace_regs_get_stack_pointer().
 
 config HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
 	bool
-- 
2.30.2

