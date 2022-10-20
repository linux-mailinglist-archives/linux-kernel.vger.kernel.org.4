Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6862260642D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiJTPUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJTPTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:19:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656352AC4E;
        Thu, 20 Oct 2022 08:19:41 -0700 (PDT)
Date:   Thu, 20 Oct 2022 15:17:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666279078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=//xLBR5alBn8XkfSNaxrrbKEegPJT9lyxYyOliszmSg=;
        b=Y/ecj0PlVinMbCRzsIrYfI1WJIYZVAeNgLeFV9YneqSMqMmXa5d7rGxWHT8+QXkbYjQBqv
        K3SlNaWedUMj+meIeqcYuJtk8kL9ZokNy6Mc3i7YqgyNDCHEp79T2XEf9V3RN7DCyG5p+3
        kl0wP1Bn9iZozXJQPVprTsrLgWZMYwL4PxgE04wL/HlG1d913OGLrzjzJHPtqWb380Iw43
        aoLKQT5khEpv9DxbAaE6oB2rZBsRcnmUMy/mcI+4mcfbpxPT1e9LSBgligSvSUXIVkDrdR
        iXdj7L+KVqfnd761OBQUBFdb0dQP2kD72iIaHpdpJgO3P0JA2AlRxYr0k8VCVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666279078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=//xLBR5alBn8XkfSNaxrrbKEegPJT9lyxYyOliszmSg=;
        b=0dhCBQYeO8u7E7RBKZdaShTbv/O30uTkBGQCbwOATJK8Vr9TqJVItGK3IF01C/giGN8MEh
        KKci5DRMQu3LuoBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] ftrace,kcfi: Separate ftrace_stub() and ftrace_stub_graph()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y06dg4e1xF6JTdQq@hirez.programming.kicks-ass.net>
References: <Y06dg4e1xF6JTdQq@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <166627907737.401.15310729251273334368.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     883bbbffa5a4ffd1915f8b42934dab81b7f87226
Gitweb:        https://git.kernel.org/tip/883bbbffa5a4ffd1915f8b42934dab81b7f87226
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 18 Oct 2022 13:49:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 20 Oct 2022 17:10:27 +02:00

ftrace,kcfi: Separate ftrace_stub() and ftrace_stub_graph()

Different function signatures means they needs to be different
functions; otherwise CFI gets upset.

As triggered by the ftrace boot tests:

  [] CFI failure at ftrace_return_to_handler+0xac/0x16c (target: ftrace_stub+0x0/0x14; expected type: 0x0a5d5347)

Fixes: 3c516f89e17e ("x86: Add support for CONFIG_CFI_CLANG")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lkml.kernel.org/r/Y06dg4e1xF6JTdQq@hirez.programming.kicks-ass.net
---
 arch/arm64/kernel/entry-ftrace.S  |  7 ++++++-
 arch/x86/kernel/ftrace_64.S       | 17 +++++++++--------
 include/asm-generic/vmlinux.lds.h | 18 ++++++++++++------
 3 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index bd5df50..795344a 100644
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
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index a90c55a..2a4be92 100644
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
@@ -176,11 +185,6 @@ SYM_INNER_LABEL(ftrace_caller_end, SYM_L_GLOBAL)
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
@@ -282,9 +286,6 @@ STACK_FRAME_NON_STANDARD_FP(ftrace_regs_caller)
 SYM_FUNC_START(__fentry__)
 	cmpq $ftrace_stub, ftrace_trace_function
 	jnz trace
-
-SYM_INNER_LABEL(ftrace_stub, SYM_L_GLOBAL)
-	ENDBR
 	RET
 
 trace:
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index c15de16..d06ada2 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -162,6 +162,16 @@
 #define PATCHABLE_DISCARDS	*(__patchable_function_entries)
 #endif
 
+#ifndef CONFIG_ARCH_SUPPORTS_CFI_CLANG
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
