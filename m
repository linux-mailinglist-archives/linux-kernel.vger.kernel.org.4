Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1A96C7E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjCXMiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjCXMiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:38:04 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0679421E;
        Fri, 24 Mar 2023 05:38:02 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 099C358090C;
        Fri, 24 Mar 2023 20:37:45 +0800 (CST)
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
Subject: [PATCH v7 6/8] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
Date:   Fri, 24 Mar 2023 05:37:29 -0700
Message-Id: <20230324123731.3801920-7-pengdonglin@sangfor.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230324123731.3801920-1-pengdonglin@sangfor.com.cn>
References: <20230324123731.3801920-1-pengdonglin@sangfor.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDH08ZVh9JGkpDS09CSR9MTlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS09ISFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Njo6CDo5ET0THw8iCkgNEREt
        NTIaCxpVSlVKTUxCTU1KT01NTktJVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFOTUlMNwY+
X-HM-Tid: 0a8713a001d52eb7kusn099c358090c
X-HM-MType: 1
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d4815c5d1bbd ("function_graph: Support recording and
printing the return value of function") laid the groundwork for the
for the funcgraph-retval, and this modification makes it available
on the x86 platform.

We introduce a new structure called fgraph_ret_regs for the x86
platform to hold return registers and the frame pointer. We then
fill its content in the return_to_handler and pass its address
to the function ftrace_return_to_handler to record the return
value.

Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
---
 arch/x86/Kconfig              |  1 +
 arch/x86/include/asm/ftrace.h | 22 ++++++++++++++++++++++
 arch/x86/kernel/ftrace_32.S   |  8 +++++---
 arch/x86/kernel/ftrace_64.S   |  7 ++++---
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a825bf031f49..956cc988bdf9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -214,6 +214,7 @@ config X86
 	select HAVE_FAST_GUP
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_FUNCTION_GRAPH_RETVAL	if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER	if X86_32 || (X86_64 && DYNAMIC_FTRACE)
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 5061ac98ffa1..bb12f5b7505a 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -147,4 +147,26 @@ static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
 #endif /* !COMPILE_OFFSETS */
 #endif /* !__ASSEMBLY__ */
 
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
+struct fgraph_ret_regs {
+	unsigned long ax;
+	unsigned long dx;
+	unsigned long bp;
+};
+
+static inline unsigned long fgraph_ret_regs_return_value(struct fgraph_ret_regs *ret_regs)
+{
+	return ret_regs->ax;
+}
+
+static inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_ret_regs *ret_regs)
+{
+	return ret_regs->bp;
+}
+#endif
+
+#endif
+
 #endif /* _ASM_X86_FTRACE_H */
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index a0ed0e4a2c0c..5a9cc723f81f 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -182,12 +182,14 @@ SYM_CODE_END(ftrace_graph_caller)
 
 .globl return_to_handler
 return_to_handler:
-	pushl	%eax
+	pushl	$0
 	pushl	%edx
-	movl	$0, %eax
+	pushl	%eax
+	movl	%esp, %eax
 	call	ftrace_return_to_handler
 	movl	%eax, %ecx
-	popl	%edx
 	popl	%eax
+	popl	%edx
+	addl	$4, %esp		# skip ebp
 	JMP_NOSPEC ecx
 #endif
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index fb4f1e01b64a..ef78c0bbae62 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -344,12 +344,13 @@ STACK_FRAME_NON_STANDARD_FP(__fentry__)
 SYM_CODE_START(return_to_handler)
 	UNWIND_HINT_EMPTY
 	ANNOTATE_NOENDBR
-	subq  $16, %rsp
+	subq  $24, %rsp
 
 	/* Save the return values */
 	movq %rax, (%rsp)
 	movq %rdx, 8(%rsp)
-	movq %rbp, %rdi
+	movq %rbp, 16(%rsp)
+	movq %rsp, %rdi
 
 	call ftrace_return_to_handler
 
@@ -357,7 +358,7 @@ SYM_CODE_START(return_to_handler)
 	movq 8(%rsp), %rdx
 	movq (%rsp), %rax
 
-	addq $16, %rsp
+	addq $24, %rsp
 	/*
 	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi
 	 * since IBT would demand that contain ENDBR, which simply isn't so for
-- 
2.25.1

