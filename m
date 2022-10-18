Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F8A602BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiJRMfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiJRMf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:35:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A89604B8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=s/2OoidSG8cI1q4hTwzfAsysrB6WSg4UF4HBlyHF0HE=; b=EVCSs2v2MdPbf9jUsruatbBGNA
        ARcxoTKnWA91LTzyrwUuPfe/XRlYVKVBzwZ1a4GueyCElPE9io1sli5c03m/n+W6gceAaanT9NyeE
        YFsp1fB/KDPsJf1Y5BT2CxRfP+hVgP20KkhwJzOR1tPwxewcxs0WtWhX5Gi9IahzyRIVdkusHEdcz
        DLdM45odJez/zaRNy5tZ57/R88LLfoVjC+KnjPqKb3bkyPhgx7QLO7GBl/O5ogzISYEoGfarIAAEG
        gGdl47Gp3tXs0ndpfT4TXIlntlUIKDiXEGr6Zu8f4bkJ2aSkN2/3mSUNcqs3IPendKaIYSxWBpQF6
        oI+hwt+g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1okloY-00Ak5M-CJ; Tue, 18 Oct 2022 12:35:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 382FE300431;
        Tue, 18 Oct 2022 14:35:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1424E2075A8C7; Tue, 18 Oct 2022 14:35:16 +0200 (CEST)
Date:   Tue, 18 Oct 2022 14:35:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH] ftrace,kcfi: Separate ftrace_stub() and ftrace_stub_graph()
Message-ID: <Y06dg4e1xF6JTdQq@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Different function signatures means they needs to be different
functions; otherwise CFI gets upset.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

Notable; this patch depends on eac828eaef29 ("x86/ftrace: Remove
ftrace_epilogue()") which can be cleanly picked on top of -rc1.

Since kCFI is upstream this should go into some /urgent tree.

 arch/arm64/kernel/entry-ftrace.S  |    7 ++++++-
 arch/x86/kernel/ftrace_64.S       |   17 +++++++++--------
 include/asm-generic/vmlinux.lds.h |   18 ++++++++++++------
 3 files changed, 27 insertions(+), 15 deletions(-)

--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -7,6 +7,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
 #include <asm/ftrace.h>
@@ -294,10 +295,14 @@ SYM_FUNC_END(ftrace_graph_caller)
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 
-SYM_FUNC_START(ftrace_stub)
+SYM_TYPED_FUNC_START(ftrace_stub)
 	ret
 SYM_FUNC_END(ftrace_stub)
 
+SYM_TYPED_FUNC_START(ftrace_stub_graph)
+	ret
+SYM_FUNC_END(ftrace_stub_graph)
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 /*
  * void return_to_handler(void)
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -4,6 +4,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/ptrace.h>
 #include <asm/ftrace.h>
 #include <asm/export.h>
@@ -129,6 +130,14 @@
 
 	.endm
 
+SYM_TYPED_FUNC_START(ftrace_stub)
+	RET
+SYM_FUNC_END(ftrace_stub)
+
+SYM_TYPED_FUNC_START(ftrace_stub_graph)
+	RET
+SYM_FUNC_END(ftrace_stub_graph)
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 
 SYM_FUNC_START(__fentry__)
@@ -176,11 +185,6 @@ SYM_INNER_LABEL(ftrace_caller_end, SYM_L
 SYM_FUNC_END(ftrace_caller);
 STACK_FRAME_NON_STANDARD_FP(ftrace_caller)
 
-SYM_FUNC_START(ftrace_stub)
-	UNWIND_HINT_FUNC
-	RET
-SYM_FUNC_END(ftrace_stub)
-
 SYM_FUNC_START(ftrace_regs_caller)
 	/* Save the current flags before any operations that can change them */
 	pushfq
@@ -282,9 +286,6 @@ STACK_FRAME_NON_STANDARD_FP(ftrace_regs_
 SYM_FUNC_START(__fentry__)
 	cmpq $ftrace_stub, ftrace_trace_function
 	jnz trace
-
-SYM_INNER_LABEL(ftrace_stub, SYM_L_GLOBAL)
-	ENDBR
 	RET
 
 trace:
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -162,6 +162,16 @@
 #define PATCHABLE_DISCARDS	*(__patchable_function_entries)
 #endif
 
+#ifndef ARCH_SUPPORTS_CFI_CLANG
+/*
+ * Simply points to ftrace_stub, but with the proper protocol.
+ * Defined by the linker script in linux/vmlinux.lds.h
+ */
+#define	FTRACE_STUB_HACK	ftrace_stub_graph = ftrace_stub;
+#else
+#define FTRACE_STUB_HACK
+#endif
+
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 /*
  * The ftrace call sites are logged to a section whose name depends on the
@@ -169,10 +179,6 @@
  * FTRACE_CALLSITE_SECTION. We capture all of them here to avoid header
  * dependencies for FTRACE_CALLSITE_SECTION's definition.
  *
- * Need to also make ftrace_stub_graph point to ftrace_stub
- * so that the same stub location may have different protocols
- * and not mess up with C verifiers.
- *
  * ftrace_ops_list_func will be defined as arch_ftrace_ops_list_func
  * as some archs will have a different prototype for that function
  * but ftrace_ops_list_func() will have a single prototype.
@@ -182,11 +188,11 @@
 			KEEP(*(__mcount_loc))			\
 			KEEP_PATCHABLE				\
 			__stop_mcount_loc = .;			\
-			ftrace_stub_graph = ftrace_stub;	\
+			FTRACE_STUB_HACK			\
 			ftrace_ops_list_func = arch_ftrace_ops_list_func;
 #else
 # ifdef CONFIG_FUNCTION_TRACER
-#  define MCOUNT_REC()	ftrace_stub_graph = ftrace_stub;	\
+#  define MCOUNT_REC()	FTRACE_STUB_HACK			\
 			ftrace_ops_list_func = arch_ftrace_ops_list_func;
 # else
 #  define MCOUNT_REC()

