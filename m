Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA016C7E26
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjCXMiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjCXMiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:38:00 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E29358E;
        Fri, 24 Mar 2023 05:37:57 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id E2B81580A5C;
        Fri, 24 Mar 2023 20:37:41 +0800 (CST)
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
Subject: [PATCH v7 4/8] arm64: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
Date:   Fri, 24 Mar 2023 05:37:27 -0700
Message-Id: <20230324123731.3801920-5-pengdonglin@sangfor.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230324123731.3801920-1-pengdonglin@sangfor.com.cn>
References: <20230324123731.3801920-1-pengdonglin@sangfor.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZHkMfVk5JH00aHUIYTkxMHlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS09ISFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NCI6Aww6LT0NCw89MElCERUI
        SDJPCUJVSlVKTUxCTU1KT01IT0pCVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFOSkJMNwY+
X-HM-Tid: 0a87139ff5ad2eb7kusne2b81580a5c
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
on the ARM64 platform.

We introduce a new structure called fgraph_ret_regs for the ARM64
platform to hold return registers and the frame pointer. We then
fill its content in the return_to_handler and pass its address to
the function ftrace_return_to_handler to record the return value.

Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/ftrace.h  | 23 +++++++++++++++++++++++
 arch/arm64/kernel/entry-ftrace.S |  9 +++++----
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1023e896d46b..48856d230800 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -195,6 +195,7 @@ config ARM64
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
+	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index 1c2672bbbf37..f68dcc41be3b 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -170,4 +170,27 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
 }
 #endif /* ifndef __ASSEMBLY__ */
 
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
+struct fgraph_ret_regs {
+	/* x0 - x7 */
+	u64 regs[8];
+
+	u64 fp;
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
 #endif /* __ASM_FTRACE_H */
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 350ed81324ac..8ac6f952e68f 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -270,14 +270,15 @@ SYM_FUNC_END(ftrace_stub_graph)
  */
 SYM_CODE_START(return_to_handler)
 	/* save return value regs */
-	sub sp, sp, #64
+	sub sp, sp, #72
 	stp x0, x1, [sp]
 	stp x2, x3, [sp, #16]
 	stp x4, x5, [sp, #32]
 	stp x6, x7, [sp, #48]
+	str x29,    [sp, #64]		//     parent's fp
 
-	mov	x0, x29			//     parent's fp
-	bl	ftrace_return_to_handler// addr = ftrace_return_to_hander(fp);
+	mov	x0, sp
+	bl	ftrace_return_to_handler// addr = ftrace_return_to_hander(regs);
 	mov	x30, x0			// restore the original return address
 
 	/* restore return value regs */
@@ -285,7 +286,7 @@ SYM_CODE_START(return_to_handler)
 	ldp x2, x3, [sp, #16]
 	ldp x4, x5, [sp, #32]
 	ldp x6, x7, [sp, #48]
-	add sp, sp, #64
+	add sp, sp, #72
 
 	ret
 SYM_CODE_END(return_to_handler)
-- 
2.25.1

