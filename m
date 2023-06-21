Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E44738B32
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjFUQaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjFUQ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:29:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E164C1718
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:29:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BAE1615FC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC3BC433CC;
        Wed, 21 Jun 2023 16:29:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qC0iH-001yld-2E;
        Wed, 21 Jun 2023 12:29:45 -0400
Message-ID: <20230621162945.518247784@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 21 Jun 2023 12:29:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Donglin Peng <pengdonglin@sangfor.com.cn>
Subject: [for-next][PATCH 06/13] LoongArch: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
References: <20230621162923.953123395@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Donglin Peng <pengdonglin@sangfor.com.cn>

The previous patch ("function_graph: Support recording and printing
the return value of function") has laid the groundwork for the for
the funcgraph-retval, and this modification makes it available on
the LoongArch platform.

We introduce a new structure called fgraph_ret_regs for the LoongArch
platform to hold return registers and the frame pointer. We then fill
its content in the return_to_handler and pass its address to the
function ftrace_return_to_handler to record the return value.

Link: https://lkml.kernel.org/r/c5462255e435fab363895c2d7433bc0f5a140411.1680954589.git.pengdonglin@sangfor.com.cn

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/include/asm/ftrace.h | 22 ++++++++++++++++++++++
 arch/loongarch/kernel/asm-offsets.c | 15 ++++++++++++++-
 arch/loongarch/kernel/mcount.S      | 14 ++++++++------
 arch/loongarch/kernel/mcount_dyn.S  | 15 ++++++++-------
 5 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d38b066fc931..6c465619b43d 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -103,6 +103,7 @@ config LOONGARCH
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
+	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GENERIC_VDSO
diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index 23e2ba78dcb0..a11996eb5892 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -100,4 +100,26 @@ __arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
 
 #endif /* CONFIG_FUNCTION_TRACER */
 
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+struct fgraph_ret_regs {
+	/* a0 - a1 */
+	unsigned long regs[2];
+
+	unsigned long fp;
+	unsigned long __unused;
+};
+
+static inline unsigned long fgraph_ret_regs_return_value(struct fgraph_ret_regs *ret_regs)
+{
+	return ret_regs->regs[0];
+}
+
+static inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_ret_regs *ret_regs)
+{
+	return ret_regs->fp;
+}
+#endif /* ifdef CONFIG_FUNCTION_GRAPH_TRACER */
+#endif
+
 #endif /* _ASM_LOONGARCH_FTRACE_H */
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 4bdb203fc66e..505e4bf59603 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -12,6 +12,7 @@
 #include <asm/cpu-info.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
+#include <asm/ftrace.h>
 
 void output_ptreg_defines(void)
 {
@@ -264,7 +265,7 @@ void output_smpboot_defines(void)
 #ifdef CONFIG_HIBERNATION
 void output_pbe_defines(void)
 {
-	COMMENT(" Linux struct pbe offsets. ");
+	COMMENT("Linux struct pbe offsets.");
 	OFFSET(PBE_ADDRESS, pbe, address);
 	OFFSET(PBE_ORIG_ADDRESS, pbe, orig_address);
 	OFFSET(PBE_NEXT, pbe, next);
@@ -272,3 +273,15 @@ void output_pbe_defines(void)
 	BLANK();
 }
 #endif
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+void output_fgraph_ret_regs_defines(void)
+{
+	COMMENT("LoongArch fgraph_ret_regs offsets.");
+	OFFSET(FGRET_REGS_A0, fgraph_ret_regs, regs[0]);
+	OFFSET(FGRET_REGS_A1, fgraph_ret_regs, regs[1]);
+	OFFSET(FGRET_REGS_FP, fgraph_ret_regs, fp);
+	DEFINE(FGRET_REGS_SIZE, sizeof(struct fgraph_ret_regs));
+	BLANK();
+}
+#endif
diff --git a/arch/loongarch/kernel/mcount.S b/arch/loongarch/kernel/mcount.S
index 8cdc1563cd33..cb8e5803de4b 100644
--- a/arch/loongarch/kernel/mcount.S
+++ b/arch/loongarch/kernel/mcount.S
@@ -79,18 +79,20 @@ SYM_FUNC_START(ftrace_graph_caller)
 SYM_FUNC_END(ftrace_graph_caller)
 
 SYM_FUNC_START(return_to_handler)
-	PTR_ADDI	sp, sp, -2 * SZREG
-	PTR_S		a0, sp, 0
-	PTR_S		a1, sp, SZREG
+	PTR_ADDI	sp, sp, -FGRET_REGS_SIZE
+	PTR_S		a0, sp, FGRET_REGS_A0
+	PTR_S		a1, sp, FGRET_REGS_A1
+	PTR_S		zero, sp, FGRET_REGS_FP
 
+	move		a0, sp
 	bl		ftrace_return_to_handler
 
 	/* Restore the real parent address: a0 -> ra */
 	move		ra, a0
 
-	PTR_L		a0, sp, 0
-	PTR_L		a1, sp, SZREG
-	PTR_ADDI	sp, sp, 2 * SZREG
+	PTR_L		a0, sp, FGRET_REGS_A0
+	PTR_L		a1, sp, FGRET_REGS_A1
+	PTR_ADDI	sp, sp, FGRET_REGS_SIZE
 	jr		ra
 SYM_FUNC_END(return_to_handler)
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
index c7d961fc72c2..e16ab0b98e5a 100644
--- a/arch/loongarch/kernel/mcount_dyn.S
+++ b/arch/loongarch/kernel/mcount_dyn.S
@@ -136,18 +136,19 @@ SYM_CODE_END(ftrace_graph_caller)
 
 SYM_CODE_START(return_to_handler)
 	/* Save return value regs */
-	PTR_ADDI 	sp, sp, -2 * SZREG
-	PTR_S		a0, sp, 0
-	PTR_S		a1, sp, SZREG
+	PTR_ADDI	sp, sp, -FGRET_REGS_SIZE
+	PTR_S		a0, sp, FGRET_REGS_A0
+	PTR_S		a1, sp, FGRET_REGS_A1
+	PTR_S		zero, sp, FGRET_REGS_FP
 
-	move		a0, zero
+	move		a0, sp
 	bl		ftrace_return_to_handler
 	move		ra, a0
 
 	/* Restore return value regs */
-	PTR_L		a0, sp, 0
-	PTR_L		a1, sp, SZREG
-	PTR_ADDI 	sp, sp, 2 * SZREG
+	PTR_L		a0, sp, FGRET_REGS_A0
+	PTR_L		a1, sp, FGRET_REGS_A1
+	PTR_ADDI	sp, sp, FGRET_REGS_SIZE
 
 	jr		ra
 SYM_CODE_END(return_to_handler)
-- 
2.39.2
