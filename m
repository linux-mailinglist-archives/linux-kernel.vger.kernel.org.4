Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401296C7E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjCXMiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjCXMiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:38:00 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BC9421E;
        Fri, 24 Mar 2023 05:37:58 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 56892580A58;
        Fri, 24 Mar 2023 20:37:40 +0800 (CST)
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
To:     mhiramat@kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        chenhuacai@kernel.org, zhangqing@loongson.cn, kernel@xen0n.name,
        mingo@redhat.com, peterz@infradead.org, xiehuan09@gmail.com,
        dinghui@sangfor.com.cn, huangcun@sangfor.com.cn,
        dolinux.peng@gmail.com
Cc:     linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Donglin Peng <pengdonglin@sangfor.com.cn>
Subject: [PATCH v7 3/8] ARM: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
Date:   Fri, 24 Mar 2023 05:37:26 -0700
Message-Id: <20230324123731.3801920-4-pengdonglin@sangfor.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230324123731.3801920-1-pengdonglin@sangfor.com.cn>
References: <20230324123731.3801920-1-pengdonglin@sangfor.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTUJDVk4ZTU8fTBgYGR8YGVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS09ISFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Oj46DAw5Sj0IMQ88CkgtEQ8U
        DD8KCxhVSlVKTUxCTU1KT01KQ09JVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFPQ05LNwY+
X-HM-Tid: 0a87139fefa02eb7kusn56892580a58
X-HM-MType: 1
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d4815c5d1bbd ("function_graph: Support recording and printing
the return value of function") laid the groundwork for the for the
funcgraph-retval, and this modification makes it available on the
ARM platform.

We introduce a new structure called fgraph_ret_regs for the ARM platform
to hold return registers and the frame pointer. We then fill its content
in the return_to_handler and pass its address to the function
ftrace_return_to_handler to record the return value.

Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
---
 arch/arm/Kconfig               |  1 +
 arch/arm/include/asm/ftrace.h  | 22 ++++++++++++++++++++++
 arch/arm/kernel/entry-ftrace.S |  6 +++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e24a9820e12f..73061379855a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -98,6 +98,7 @@ config ARM
 	select HAVE_FAST_GUP if ARM_LPAE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_ERROR_INJECTION
+	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
 	select HAVE_GCC_PLUGINS
diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index 7e9251ca29fe..e3bed4949558 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -77,4 +77,26 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
 
 #endif /* ifndef __ASSEMBLY__ */
 
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
+struct fgraph_ret_regs {
+	unsigned long regs[4];
+	unsigned long fp;
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
+#endif
+
+#endif
+
 #endif /* _ASM_ARM_FTRACE */
diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
index 3e7bcaca5e07..5f1e74555b25 100644
--- a/arch/arm/kernel/entry-ftrace.S
+++ b/arch/arm/kernel/entry-ftrace.S
@@ -257,11 +257,15 @@ ENDPROC(ftrace_graph_regs_caller)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 ENTRY(return_to_handler)
+	sub	sp, sp, #4
 	stmdb	sp!, {r0-r3}
-	add	r0, sp, #16		@ sp at exit of instrumented routine
+	add	r0, sp, #20		@ sp at exit of instrumented routine
+	str	r0, [sp, #16]
+	mov	r0, sp
 	bl	ftrace_return_to_handler
 	mov	lr, r0			@ r0 has real ret addr
 	ldmia	sp!, {r0-r3}
+	add	sp, sp, #4		@ skip fp
 	ret	lr
 ENDPROC(return_to_handler)
 #endif
-- 
2.25.1

