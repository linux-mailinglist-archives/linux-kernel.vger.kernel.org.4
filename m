Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42486D20E1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjCaMtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjCaMtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:49:17 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D321721A8F;
        Fri, 31 Mar 2023 05:48:53 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 5001158015C;
        Fri, 31 Mar 2023 20:48:06 +0800 (CST)
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
To:     mhiramat@kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        rmk+kernel@armlinux.org.uk, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        bp@alien8.de, hpa@zytor.com, chenhuacai@kernel.org,
        zhangqing@loongson.cn, kernel@xen0n.name, mingo@redhat.com,
        peterz@infradead.org, xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com
Cc:     linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Donglin Peng <pengdonglin@sangfor.com.cn>
Subject: [PATCH v10 3/8] ARM: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
Date:   Fri, 31 Mar 2023 05:47:39 -0700
Message-Id: <4737b3d08e1a4a7218e16c99f8ac308881d695c9.1680265828.git.pengdonglin@sangfor.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1680265828.git.pengdonglin@sangfor.com.cn>
References: <cover.1680265828.git.pengdonglin@sangfor.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGRlIVh8dHR9NSklPQk9PTVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS0hKTFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OD46NTo5PD0OLU09QjkeITgW
        HUgKCj9VSlVKTUNLSU1NQ0NMQklIVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFNSE5MNwY+
X-HM-Tid: 0a8737b601162eb7kusn5001158015c
X-HM-MType: 1
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch ("function_graph: Support recording and printing
the return value of function") has laid the groundwork for the for
the funcgraph-retval, and this modification makes it available on
the ARM platform.

We introduce a new structure called fgraph_ret_regs for the ARM platform
to hold return registers and the frame pointer. We then fill its content
in the return_to_handler and pass its address to the function
ftrace_return_to_handler to record the return value.

Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
---
v10:
 - Use CONFIG_FUNCTION_GRAPH_TRACER to control fgraph_ret_regs definition

v9:
 - Fix stack pointer align issues
 - Update the commit message

v8:
 - Modify the control range of CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
---
 arch/arm/Kconfig               |  1 +
 arch/arm/include/asm/ftrace.h  | 22 ++++++++++++++++++++++
 arch/arm/kernel/asm-offsets.c  |  8 +++++++-
 arch/arm/kernel/entry-ftrace.S | 10 ++++++----
 4 files changed, 36 insertions(+), 5 deletions(-)

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
index 7e9251ca29fe..3c457902b355 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -77,4 +77,26 @@ static inline bool arch_syscall_match_sym_name(const char *sym,
 
 #endif /* ifndef __ASSEMBLY__ */
 
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+struct fgraph_ret_regs {
+	/* r0 - r3 */
+	unsigned long regs[4];
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
 #endif /* _ASM_ARM_FTRACE */
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 38121c59cbc2..18bb85115b21 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -23,6 +23,7 @@
 #include <asm/suspend.h>
 #include <asm/vdso_datapage.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/ftrace.h>
 #include <linux/kbuild.h>
 #include <linux/arm-smccc.h>
 #include "signal.h"
@@ -170,5 +171,10 @@ int main(void)
   DEFINE(KEXEC_INDIR_PAGE,	offsetof(struct kexec_relocate_data, kexec_indirection_page));
   DEFINE(KEXEC_MACH_TYPE,	offsetof(struct kexec_relocate_data, kexec_mach_type));
   DEFINE(KEXEC_R2,		offsetof(struct kexec_relocate_data, kexec_r2));
-  return 0; 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+  BLANK();
+  DEFINE(FGRET_REGS_SIZE,	sizeof(struct fgraph_ret_regs));
+  BLANK();
+#endif
+  return 0;
 }
diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
index 3e7bcaca5e07..d41a1676608c 100644
--- a/arch/arm/kernel/entry-ftrace.S
+++ b/arch/arm/kernel/entry-ftrace.S
@@ -257,11 +257,13 @@ ENDPROC(ftrace_graph_regs_caller)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 ENTRY(return_to_handler)
-	stmdb	sp!, {r0-r3}
-	add	r0, sp, #16		@ sp at exit of instrumented routine
+	mov	ip, sp				@ sp at exit of instrumented routine
+	stmdb	sp!, {r0-r3, ip, lr}		@ fill fgraph_ret_regs
+	mov	r0, sp
 	bl	ftrace_return_to_handler
-	mov	lr, r0			@ r0 has real ret addr
-	ldmia	sp!, {r0-r3}
+	mov	lr, r0				@ r0 has real ret addr
+	ldmia	sp, {r0-r3}
+	add	sp, sp, #FGRET_REGS_SIZE	@ restore stack pointer
 	ret	lr
 ENDPROC(return_to_handler)
 #endif
-- 
2.25.1

