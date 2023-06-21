Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B79738B37
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjFUQap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjFUQ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:29:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D6410C2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:29:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 968CA6162D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4FCC433CC;
        Wed, 21 Jun 2023 16:29:48 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qC0iJ-001ypa-0O;
        Wed, 21 Jun 2023 12:29:47 -0400
Message-ID: <20230621162946.937067675@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 21 Jun 2023 12:29:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Donglin Peng <pengdonglin@sangfor.com.cn>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [for-next][PATCH 13/13] riscv: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
References: <20230621162923.953123395@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
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
the RISC-V platform.

We introduce a new structure called fgraph_ret_regs for the RISC-V
platform to hold return registers and the frame pointer. We then
fill its content in the return_to_handler and pass its address to
the function ftrace_return_to_handler to record the return value.

Link: https://lore.kernel.org/linux-trace-kernel/a8d71b12259f90e7e63d0ea654fcac95b0232bbc.1680954589.git.pengdonglin@sangfor.com.cn

Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/ftrace.h | 21 +++++++++++++++++++++
 arch/riscv/kernel/mcount.S      |  7 +------
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 2bb0c38419ff..62c1e375183c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -146,6 +146,7 @@ config RISCV
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
 
 config CLANG_SUPPORTS_DYNAMIC_FTRACE
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index d47d87c2d7e3..740a979171e5 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -111,4 +111,25 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
 
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+struct fgraph_ret_regs {
+	unsigned long a1;
+	unsigned long a0;
+	unsigned long s0;
+	unsigned long ra;
+};
+
+static inline unsigned long fgraph_ret_regs_return_value(struct fgraph_ret_regs *ret_regs)
+{
+	return ret_regs->a0;
+}
+
+static inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_ret_regs *ret_regs)
+{
+	return ret_regs->s0;
+}
+#endif /* ifdef CONFIG_FUNCTION_GRAPH_TRACER */
+#endif
+
 #endif /* _ASM_RISCV_FTRACE_H */
diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
index 30102aadc4d7..8a6e5a9e842a 100644
--- a/arch/riscv/kernel/mcount.S
+++ b/arch/riscv/kernel/mcount.S
@@ -65,13 +65,8 @@ ENTRY(return_to_handler)
  * So alternatively we check the *old* frame pointer position, that is, the
  * value stored in -16(s0) on entry, and the s0 on return.
  */
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	mv	t6, s0
-#endif
 	SAVE_RET_ABI_STATE
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
-	mv	a0, t6
-#endif
+	mv	a0, sp
 	call	ftrace_return_to_handler
 	mv	a2, a0
 	RESTORE_RET_ABI_STATE
-- 
2.39.2
