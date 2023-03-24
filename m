Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9613D6C7E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjCXMiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjCXMiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:38:05 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44667EC8;
        Fri, 24 Mar 2023 05:38:03 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 9011A580A40;
        Fri, 24 Mar 2023 20:37:46 +0800 (CST)
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
Subject: [PATCH v7 7/8] LoongArch: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
Date:   Fri, 24 Mar 2023 05:37:30 -0700
Message-Id: <20230324123731.3801920-8-pengdonglin@sangfor.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230324123731.3801920-1-pengdonglin@sangfor.com.cn>
References: <20230324123731.3801920-1-pengdonglin@sangfor.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTkxNVkJIS0IYSRpDTk4YTlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS09ISFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRw6Vhw5Fj0QVg8tME8jERMp
        LVYKCz9VSlVKTUxCTU1KT01DSEhKVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFOQ01ONwY+
X-HM-Tid: 0a8713a008dd2eb7kusn9011a580a40
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
on the LoongArch platform.

We introduce a new structure called fgraph_ret_regs for the LoongArch
platform to hold return registers and the frame pointer. We then fill
its content in the return_to_handler and pass its address to the
function ftrace_return_to_handler to record the return value.

Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
---
 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/include/asm/ftrace.h | 22 ++++++++++++++++++++++
 arch/loongarch/kernel/mcount.S      |  6 ++++--
 arch/loongarch/kernel/mcount_dyn.S  |  7 ++++---
 4 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 7fd51257e0ed..4bf60132869b 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -99,6 +99,7 @@ config LOONGARCH
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_ARG_ACCESS_API
+	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GENERIC_VDSO
diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index 3418d32d4fc7..b92e9133145b 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -63,4 +63,26 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 
 #endif /* CONFIG_FUNCTION_TRACER */
 
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
+struct fgraph_ret_regs {
+	unsigned long a0;
+	unsigned long a1;
+	unsigned long fp;
+};
+
+static inline unsigned long fgraph_ret_regs_return_value(struct fgraph_ret_regs *ret_regs)
+{
+	return ret_regs->a0;
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
 #endif /* _ASM_LOONGARCH_FTRACE_H */
diff --git a/arch/loongarch/kernel/mcount.S b/arch/loongarch/kernel/mcount.S
index 8cdc1563cd33..3e405c0212c0 100644
--- a/arch/loongarch/kernel/mcount.S
+++ b/arch/loongarch/kernel/mcount.S
@@ -79,10 +79,12 @@ SYM_FUNC_START(ftrace_graph_caller)
 SYM_FUNC_END(ftrace_graph_caller)
 
 SYM_FUNC_START(return_to_handler)
-	PTR_ADDI	sp, sp, -2 * SZREG
+	PTR_ADDI	sp, sp, -3 * SZREG
 	PTR_S		a0, sp, 0
 	PTR_S		a1, sp, SZREG
+	PTR_S		zero, sp, 2 * SZREG
 
+	move		a0, sp
 	bl		ftrace_return_to_handler
 
 	/* Restore the real parent address: a0 -> ra */
@@ -90,7 +92,7 @@ SYM_FUNC_START(return_to_handler)
 
 	PTR_L		a0, sp, 0
 	PTR_L		a1, sp, SZREG
-	PTR_ADDI	sp, sp, 2 * SZREG
+	PTR_ADDI	sp, sp, 3 * SZREG
 	jr		ra
 SYM_FUNC_END(return_to_handler)
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
index bbabf06244c2..ab85a953c6d3 100644
--- a/arch/loongarch/kernel/mcount_dyn.S
+++ b/arch/loongarch/kernel/mcount_dyn.S
@@ -131,18 +131,19 @@ SYM_CODE_END(ftrace_graph_caller)
 
 SYM_CODE_START(return_to_handler)
 	/* Save return value regs */
-	PTR_ADDI 	sp, sp, -2 * SZREG
+	PTR_ADDI 	sp, sp, -3 * SZREG
 	PTR_S		a0, sp, 0
 	PTR_S		a1, sp, SZREG
+	PTR_S		zero, sp, 2 * SZREG
 
-	move		a0, zero
+	move		a0, sp
 	bl		ftrace_return_to_handler
 	move		ra, a0
 
 	/* Restore return value regs */
 	PTR_L		a0, sp, 0
 	PTR_L		a1, sp, SZREG
-	PTR_ADDI 	sp, sp, 2 * SZREG
+	PTR_ADDI 	sp, sp, 3 * SZREG
 
 	jr		ra
 SYM_CODE_END(return_to_handler)
-- 
2.25.1

