Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A356C53F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCVSoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 14:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCVSnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:43:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF19F298D2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 11:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5658F6227B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 18:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2CAC43445;
        Wed, 22 Mar 2023 18:43:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pf3Qt-000pZf-0P;
        Wed, 22 Mar 2023 14:43:35 -0400
Message-ID: <20230322184334.946813393@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 22 Mar 2023 14:42:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Huafei <lihuafei1@huawei.com>,
        Xu Kuohai <xukuohai@huawei.com>,
        Florent Revest <revest@chromium.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: [for-next][PATCH 07/11] ftrace: selftest: remove broken trace_direct_tramp
References: <20230322184239.594953818@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

The ftrace selftest code has a trace_direct_tramp() function which it
uses as a direct call trampoline. This happens to work on x86, since the
direct call's return address is in the usual place, and can be returned
to via a RET, but in general the calling convention for direct calls is
different from regular function calls, and requires a trampoline written
in assembly.

On s390, regular function calls place the return address in %r14, and an
ftrace patch-site in an instrumented function places the trampoline's
return address (which is within the instrumented function) in %r0,
preserving the original %r14 value in-place. As a regular C function
will return to the address in %r14, using a C function as the trampoline
results in the trampoline returning to the caller of the instrumented
function, skipping the body of the instrumented function.

Note that the s390 issue is not detcted by the ftrace selftest code, as
the instrumented function is trivial, and returning back into the caller
happens to be equivalent.

On arm64, regular function calls place the return address in x30, and
an ftrace patch-site in an instrumented function saves this into r9
and places the trampoline's return address (within the instrumented
function) in x30. A regular C function will return to the address in
x30, but will not restore x9 into x30. Consequently, using a C function
as the trampoline results in returning to the trampoline's return
address having corrupted x30, such that when the instrumented function
returns, it will return back into itself.

To avoid future issues in this area, remove the trace_direct_tramp()
function, and require that each architecture with direct calls provides
a stub trampoline, named ftrace_stub_direct_tramp. This can be written
to handle the architecture's trampoline calling convention, and in
future could be used elsewhere (e.g. in the ftrace ops sample, to
measure the overhead of direct calls), so we may as well always build it
in.

Link: https://lkml.kernel.org/r/20230321140424.345218-8-revest@chromium.org

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Li Huafei <lihuafei1@huawei.com>
Cc: Xu Kuohai <xukuohai@huawei.com>
Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/s390/kernel/mcount.S     |  5 +++++
 arch/x86/kernel/ftrace_32.S   |  5 +++++
 arch/x86/kernel/ftrace_64.S   |  4 ++++
 include/linux/ftrace.h        |  2 ++
 kernel/trace/trace_selftest.c | 12 ++----------
 5 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 43ff91073d2a..6c10da43b538 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -32,6 +32,11 @@ ENTRY(ftrace_stub)
 	BR_EX	%r14
 ENDPROC(ftrace_stub)
 
+SYM_CODE_START(ftrace_stub_direct_tramp)
+	lgr	%r1, %r0
+	BR_EX	%r1
+SYM_CODE_END(ftrace_stub_direct_tramp)
+
 	.macro	ftrace_regs_entry, allregs=0
 	stg	%r14,(__SF_GPRS+8*8)(%r15)	# save traced function caller
 
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index a0ed0e4a2c0c..0d9a14528176 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -163,6 +163,11 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	jmp	.Lftrace_ret
 SYM_CODE_END(ftrace_regs_caller)
 
+SYM_FUNC_START(ftrace_stub_direct_tramp)
+	CALL_DEPTH_ACCOUNT
+	RET
+SYM_FUNC_END(ftrace_stub_direct_tramp)
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 SYM_CODE_START(ftrace_graph_caller)
 	pushl	%eax
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index fb4f1e01b64a..970d8445fdc4 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -309,6 +309,10 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
 SYM_FUNC_END(ftrace_regs_caller)
 STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
 
+SYM_FUNC_START(ftrace_stub_direct_tramp)
+	CALL_DEPTH_ACCOUNT
+	RET
+SYM_FUNC_END(ftrace_stub_direct_tramp)
 
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 31f1e1df2af3..931f3d904529 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -413,6 +413,8 @@ int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
 int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr);
 int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
+void ftrace_stub_direct_tramp(void);
+
 #else
 struct ftrace_ops;
 # define ftrace_direct_func_count 0
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 84cd7ba31d27..a931d9aaea26 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -786,14 +786,6 @@ static struct fgraph_ops fgraph_ops __initdata  = {
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 static struct ftrace_ops direct;
-#ifndef CALL_DEPTH_ACCOUNT
-#define CALL_DEPTH_ACCOUNT ""
-#endif
-
-noinline __noclone static void trace_direct_tramp(void)
-{
-	asm(CALL_DEPTH_ACCOUNT);
-}
 #endif
 
 /*
@@ -873,7 +865,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	 */
 	ftrace_set_filter_ip(&direct, (unsigned long)DYN_FTRACE_TEST_NAME, 0, 0);
 	ret = register_ftrace_direct(&direct,
-				     (unsigned long)trace_direct_tramp);
+				     (unsigned long)ftrace_stub_direct_tramp);
 	if (ret)
 		goto out;
 
@@ -894,7 +886,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	unregister_ftrace_graph(&fgraph_ops);
 
 	ret = unregister_ftrace_direct(&direct,
-				       (unsigned long) trace_direct_tramp,
+				       (unsigned long)ftrace_stub_direct_tramp,
 				       true);
 	if (ret)
 		goto out;
-- 
2.39.1
