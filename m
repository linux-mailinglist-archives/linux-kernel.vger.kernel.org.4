Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9D86BD742
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 18:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCPRjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 13:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjCPRi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:38:57 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA32462FFD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:38:45 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g18so1837793wmk.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678988324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMn2X0pVjGcM1Rx/07U3BIPDRphxQJGYTZujBYSKg+w=;
        b=RPgCbQ6PyVQjxLGL0IcvB1gVuQH9t/1i/oM/+DkpLnArJ2ArIUJcA85LzplHaS3nGV
         c4zOiU+41Vuq0zfPh+rw3F1/kBt+En94aW5wbzQmlXQvl+FMMV2xH6SBHz14IMvL91nr
         G4vyDsDpFgycD8boH4ck4HD6tOn4kUlx1vyQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678988324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMn2X0pVjGcM1Rx/07U3BIPDRphxQJGYTZujBYSKg+w=;
        b=i/1KxUYZNSsR1gGhoxyr6CncsOfgDOhQPR9tT4e8IojEy6yhp3CJPkIcc1FVigpDlb
         /WkWUKxZFYOgLyuUgLSk3/o8y8GxarD10ttV2GkkjQToG8Vhb0V20fa7vpRWshgkTOiV
         hCRdrG/WwGNJErBT+wIsW/y40s0MdFBbRCA/FWsUekvOEIJmkMgszIyjLGE8zIC2pemQ
         GQ9qNKTAhozRKsiQw2WNLUcmTUsx13GrxBZQmoRl++pEo9SJnZlPVA/oxx1BkYuK7bhf
         2TOEAHMkDeohJXCpSEHuMGmWSACYKArnAk4tSTZShla7TpxgBF/+ROQjtK7aGloP0aQo
         /6vA==
X-Gm-Message-State: AO0yUKXPaWddngKG2M5cBg4BQPCRbScMIXQkksdS0U6ZofXJQ4HSRGnZ
        ryCVg1MT19QbFIXw17hxLLK08Zj7ZV3YsDArlHQ=
X-Google-Smtp-Source: AK7set/s+VI8Ri5FGPF2tCoLAXysJ+jb38EY5MW7Qm4I+MiprbSI9j1/0+C+R6y0otHe07m74zugTg==
X-Received: by 2002:a7b:c053:0:b0:3eb:f59f:6daf with SMTP id u19-20020a7bc053000000b003ebf59f6dafmr21593709wmc.34.1678988323864;
        Thu, 16 Mar 2023 10:38:43 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:24ff:9ff7:736e:20a6])
        by smtp.gmail.com with ESMTPSA id t14-20020a1c770e000000b003daf7721bb3sm5596436wmi.12.2023.03.16.10.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 10:38:43 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        revest@chromium.org, jolsa@kernel.org,
        Li Huafei <lihuafei1@huawei.com>,
        Xu Kuohai <xukuohai@huawei.com>
Subject: [PATCH 7/7] ftrace: selftest: remove broken trace_direct_tramp
Date:   Thu, 16 Mar 2023 18:38:11 +0100
Message-Id: <20230316173811.1223508-8-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
In-Reply-To: <20230316173811.1223508-1-revest@chromium.org>
References: <20230316173811.1223508-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Li Huafei <lihuafei1@huawei.com>
Cc: Xu Kuohai <xukuohai@huawei.com>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Florent Revest <revest@chromium.org>
Signed-off-by: Florent Revest <revest@chromium.org>
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
index 1265ad519249..8fc77e3e039c 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -307,6 +307,10 @@ SYM_INNER_LABEL(ftrace_regs_caller_end, SYM_L_GLOBAL)
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
2.40.0.rc2.332.ga46443480c-goog

