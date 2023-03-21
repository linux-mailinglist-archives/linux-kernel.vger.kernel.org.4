Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF416C2CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCUIsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjCUIr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:47:57 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9149A2FCC3;
        Tue, 21 Mar 2023 01:47:13 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 9A2385807BE;
        Tue, 21 Mar 2023 16:47:05 +0800 (CST)
From:   Donglin Peng <pengdonglin@sangfor.com.cn>
To:     mhiramat@kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        peterz@infradead.org, xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com
Cc:     linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Donglin Peng <pengdonglin@sangfor.com.cn>
Subject: [PATCH v6 1/2] function_graph: Support recording and printing the return value of function
Date:   Tue, 21 Mar 2023 01:46:49 -0700
Message-Id: <20230321084650.769212-2-pengdonglin@sangfor.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230321084650.769212-1-pengdonglin@sangfor.com.cn>
References: <20230321084650.769212-1-pengdonglin@sangfor.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGU4YVk4eThkYSUJMTB5OHVUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS09ISFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngw6Nyo5Qz0STBc2DyIWMAg1
        QgxPFBpVSlVKTUxCSENDT0lMS0hKVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFJS05DSjcG
X-HM-Tid: 0a870359c0d42eb7kusn9a2385807be
X-HM-MType: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the function_graph tracer to analyze system call failures,
it can be time-consuming to analyze the trace logs and locate the kernel
function that first returns an error. This change aims to simplify the
process by recording the function return value to the 'retval' member of
'ftrace_graph_ent' and printing it when outputing the trace log.

New trace options are introduced: funcgraph-retval and graph_retval_hex.
The former is used to control whether to display the return value, while
the latter is used to control the display format.

Note that even if a function's return type is void, a return value will
still be printed, so just ignore it.

Currently, this modification supports the following commonly used
processor architectures: x86_64, x86, arm64, arm, riscv.

Here is an example:

I want to attach the demo process to a cpu cgroup, but it failed:

echo `pidof demo` > /sys/fs/cgroup/cpu/test/tasks
-bash: echo: write error: Invalid argument

The strace logs tells that the write system call returned -EINVAL(-22):
...
write(1, "273\n", 4)                    = -1 EINVAL (Invalid argument)
...

Use the following commands to capture trace logs when calling the write
system call:

cd /sys/kernel/debug/tracing/
echo 0 > tracing_on
echo > trace
echo *sys_write > set_graph_function
echo *spin* > set_graph_notrace
echo *rcu* >> set_graph_notrace
echo *alloc* >> set_graph_notrace
echo preempt* >> set_graph_notrace
echo kfree* >> set_graph_notrace
echo $$ > set_ftrace_pid
echo function_graph > current_tracer
echo 1 > tracing_on
echo `pidof demo` > /sys/fs/cgroup/cpu/test/tasks
echo 0 > tracing_on
echo 1 > options/funcgraph-retval
cat trace > ~/trace.log

Search the error code -22 directly in the file trace.log and find the
first function that return -22, then read the function code to get the
root cause.

...

 1)          | cgroup_migrate() {
 1) 0.651 us |   cgroup_migrate_add_task(); /* = 0xffff93fcfd346c00 */
 1)          |   cgroup_migrate_execute() {
 1)          |     cpu_cgroup_can_attach() {
 1)          |       cgroup_taskset_first() {
 1) 0.732 us |         cgroup_taskset_next(); /* = 0xffff93fc8fb20000 */
 1) 1.232 us |       } /* cgroup_taskset_first = 0xffff93fc8fb20000 */
 1) 0.380 us |       sched_rt_can_attach(); /* = 0x0 */
 1) 2.335 us |     } /* cpu_cgroup_can_attach = -22 */
 1) 4.369 us |   } /* cgroup_migrate_execute = -22 */
 1) 7.143 us | } /* cgroup_migrate = -22 */

...

Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
---
v6:
 - Remove the conversion code for short and char types, because these
   two types are rarely used to store an error code.

v5:
 - Pass both the return values to ftrace_return_to_handler
 - Modify the parameter sequence of ftrace_return_to_handler to
   decrease the modification of assembly code, thanks to Russell King
 - Wrap __ftrace_return_to_handler with ftrace_return_to_handler
   for compatible

v4:
 - Modify commit message
 - Introduce new option graph_retval_hex to control display format
 - Introduce macro CONFIG_FUNCTION_GRAPH_RETVAL and
   CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
 - Add related arch maintainers to review

v3:
 - Modify the commit message: add trace logs processed with the btf tool

v2:
 - Modify the commit message: use BTF to get the return type of function
---
 arch/arm/Kconfig                     |  1 +
 arch/arm/kernel/entry-ftrace.S       |  8 +++
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/kernel/entry-ftrace.S     |  8 +++
 arch/riscv/Kconfig                   |  1 +
 arch/riscv/kernel/mcount.S           | 12 +++-
 arch/x86/Kconfig                     |  1 +
 arch/x86/kernel/ftrace_32.S          |  8 +++
 arch/x86/kernel/ftrace_64.S          | 10 +++
 include/linux/ftrace.h               |  3 +
 kernel/trace/Kconfig                 |  8 +++
 kernel/trace/fgraph.c                | 25 +++++++-
 kernel/trace/trace.h                 |  2 +
 kernel/trace/trace_entries.h         | 26 ++++++++
 kernel/trace/trace_functions_graph.c | 93 +++++++++++++++++++++++++---
 15 files changed, 195 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e24a9820e12f..ad03fc868f34 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -99,6 +99,7 @@ config ARM
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
diff --git a/arch/arm/kernel/entry-ftrace.S b/arch/arm/kernel/entry-ftrace.S
index 3e7bcaca5e07..ba1986e27af8 100644
--- a/arch/arm/kernel/entry-ftrace.S
+++ b/arch/arm/kernel/entry-ftrace.S
@@ -258,7 +258,15 @@ ENDPROC(ftrace_graph_regs_caller)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 ENTRY(return_to_handler)
 	stmdb	sp!, {r0-r3}
+#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
+	/*
+	 * Pass both the function return values in the register r0 and r1
+	 * to ftrace_return_to_handler
+	 */
+	add	r2, sp, #16		@ sp at exit of instrumented routine
+#else
 	add	r0, sp, #16		@ sp at exit of instrumented routine
+#endif
 	bl	ftrace_return_to_handler
 	mov	lr, r0			@ r0 has real ret addr
 	ldmia	sp!, {r0-r3}
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1023e896d46b..5ad53d565f2b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -196,6 +196,7 @@ config ARM64
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IOREMAP_PROT
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 350ed81324ac..d1a5d76e6d72 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -276,7 +276,15 @@ SYM_CODE_START(return_to_handler)
 	stp x4, x5, [sp, #32]
 	stp x6, x7, [sp, #48]
 
+#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
+	/*
+	 * Pass both the function return values in the register x0 and x1
+	 * to ftrace_return_to_handler.
+	 */
+	mov	x2, x29			//     parent's fp
+#else
 	mov	x0, x29			//     parent's fp
+#endif
 	bl	ftrace_return_to_handler// addr = ftrace_return_to_hander(fp);
 	mov	x30, x0			// restore the original return address
 
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index c5e42cc37604..3efa4f645a39 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -139,6 +139,7 @@ config RISCV
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
 	select HAVE_FUNCTION_GRAPH_TRACER
+	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
 
 config ARCH_MMAP_RND_BITS_MIN
diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
index 30102aadc4d7..bba2f3835592 100644
--- a/arch/riscv/kernel/mcount.S
+++ b/arch/riscv/kernel/mcount.S
@@ -69,8 +69,18 @@ ENTRY(return_to_handler)
 	mv	t6, s0
 #endif
 	SAVE_RET_ABI_STATE
-#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
+	/*
+	 * Pass both the function return values in the register a0 and a1
+	 * to ftrace_return_to_handler
+	 */
+	#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
+	mv	a2, t6
+	#endif
+#else
+	#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
 	mv	a0, t6
+	#endif
 #endif
 	call	ftrace_return_to_handler
 	mv	a2, a0
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a825bf031f49..af80f3c75a54 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -215,6 +215,7 @@ config X86
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER	if X86_32 || (X86_64 && DYNAMIC_FTRACE)
+	select HAVE_FUNCTION_GRAPH_RETVAL	if HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index a0ed0e4a2c0c..ae8f215d9820 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -184,7 +184,15 @@ SYM_CODE_END(ftrace_graph_caller)
 return_to_handler:
 	pushl	%eax
 	pushl	%edx
+#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
+	/*
+	 * Pass both the function return values in the register eax and edx
+	 * to ftrace_return_to_handler
+	 */
+	movl	$0, %ecx
+#else
 	movl	$0, %eax
+#endif
 	call	ftrace_return_to_handler
 	movl	%eax, %ecx
 	popl	%edx
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 1265ad519249..2eefa82814dc 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -347,7 +347,17 @@ SYM_CODE_START(return_to_handler)
 	/* Save the return values */
 	movq %rax, (%rsp)
 	movq %rdx, 8(%rsp)
+#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
+	/*
+	 * Pass both the function return values in the register rax and rdx
+	 * to ftrace_return_to_handler
+	 */
+	movq %rax, %rdi
+	movq %rdx, %rsi
+	movq %rbp, %rdx
+#else
 	movq %rbp, %rdi
+#endif
 
 	call ftrace_return_to_handler
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 366c730beaa3..be662a11cd13 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1032,6 +1032,9 @@ struct ftrace_graph_ent {
  */
 struct ftrace_graph_ret {
 	unsigned long func; /* Current function */
+#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
+	unsigned long retval;
+#endif
 	int depth;
 	/* Number of functions that overran the depth limit for current task */
 	unsigned int overrun;
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a856d4a34c67..319eb6dc2250 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -31,6 +31,9 @@ config HAVE_FUNCTION_GRAPH_TRACER
 	help
 	  See Documentation/trace/ftrace-design.rst
 
+config HAVE_FUNCTION_GRAPH_RETVAL
+	bool
+
 config HAVE_DYNAMIC_FTRACE
 	bool
 	help
@@ -227,6 +230,11 @@ config FUNCTION_GRAPH_TRACER
 	  the return value. This is done by setting the current return
 	  address on the current task structure into a stack of calls.
 
+config FUNCTION_GRAPH_RETVAL
+	def_bool y
+	depends on HAVE_FUNCTION_GRAPH_RETVAL
+	depends on FUNCTION_GRAPH_TRACER
+
 config DYNAMIC_FTRACE
 	bool "enable/disable function tracing dynamically"
 	depends on FUNCTION_TRACER
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 218cd95bf8e4..f40b10fc6561 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -238,14 +238,24 @@ static struct notifier_block ftrace_suspend_notifier = {
 
 /*
  * Send the trace to the ring-buffer.
+ *
+ * For double register return, need to pass both register values.
+ * However only the first one is saved currently.
+ *
+ * @retval_1st: the first return value
+ * @retval_2nd: the second return value
  * @return the original return address.
  */
-unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
+static unsigned long __ftrace_return_to_handler(unsigned long retval_1st,
+			unsigned long retval_2nd, unsigned long frame_pointer)
 {
 	struct ftrace_graph_ret trace;
 	unsigned long ret;
 
 	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
+#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
+	trace.retval = retval_1st;
+#endif
 	trace.rettime = trace_clock_local();
 	ftrace_graph_return(&trace);
 	/*
@@ -266,6 +276,19 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 	return ret;
 }
 
+#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
+unsigned long ftrace_return_to_handler(unsigned long retval_1st,
+			unsigned long retval_2nd, unsigned long frame_pointer)
+{
+	return __ftrace_return_to_handler(retval_1st, retval_2nd, frame_pointer);
+}
+#else
+unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
+{
+	return __ftrace_return_to_handler(0, 0, frame_pointer);
+}
+#endif
+
 /**
  * ftrace_graph_get_ret_stack - return the entry of the shadow stack
  * @task: The task to read the shadow stack from
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 616e1aa1c4da..0a3c4582df10 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -831,6 +831,8 @@ static __always_inline bool ftrace_hash_empty(struct ftrace_hash *hash)
 #define TRACE_GRAPH_PRINT_TAIL          0x100
 #define TRACE_GRAPH_SLEEP_TIME          0x200
 #define TRACE_GRAPH_GRAPH_TIME          0x400
+#define TRACE_GRAPH_PRINT_RETVAL        0x800
+#define TRACE_GRAPH_PRINT_RETVAL_HEX    0x1000
 #define TRACE_GRAPH_PRINT_FILL_SHIFT	28
 #define TRACE_GRAPH_PRINT_FILL_MASK	(0x3 << TRACE_GRAPH_PRINT_FILL_SHIFT)
 
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index cd41e863b51c..340b2fa98218 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -86,6 +86,30 @@ FTRACE_ENTRY_PACKED(funcgraph_entry, ftrace_graph_ent_entry,
 );
 
 /* Function return entry */
+#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
+
+FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
+
+	TRACE_GRAPH_RET,
+
+	F_STRUCT(
+		__field_struct(	struct ftrace_graph_ret,	ret	)
+		__field_packed(	unsigned long,	ret,		func	)
+		__field_packed(	unsigned long,	ret,		retval	)
+		__field_packed(	int,		ret,		depth	)
+		__field_packed(	unsigned int,	ret,		overrun	)
+		__field_packed(	unsigned long long, ret,	calltime)
+		__field_packed(	unsigned long long, ret,	rettime	)
+	),
+
+	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d retval: %lx",
+		 (void *)__entry->func, __entry->depth,
+		 __entry->calltime, __entry->rettime,
+		 __entry->depth, __entry->retval)
+);
+
+#else
+
 FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 
 	TRACE_GRAPH_RET,
@@ -105,6 +129,8 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 		 __entry->depth)
 );
 
+#endif
+
 /*
  * Context switch trace entry - which task (and prio) we switched from/to:
  *
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 203204cadf92..100973d25dfc 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -58,6 +58,12 @@ static struct tracer_opt trace_opts[] = {
 	{ TRACER_OPT(funcgraph-irqs, TRACE_GRAPH_PRINT_IRQS) },
 	/* Display function name after trailing } */
 	{ TRACER_OPT(funcgraph-tail, TRACE_GRAPH_PRINT_TAIL) },
+#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
+	/* Display function return value ? */
+	{ TRACER_OPT(funcgraph-retval, TRACE_GRAPH_PRINT_RETVAL) },
+	/* Display function return value in hexadecimal format ? */
+	{ TRACER_OPT(graph_retval_hex, TRACE_GRAPH_PRINT_RETVAL_HEX) },
+#endif
 	/* Include sleep time (scheduled out) between entry and return */
 	{ TRACER_OPT(sleep-time, TRACE_GRAPH_SLEEP_TIME) },
 
@@ -619,6 +625,56 @@ print_graph_duration(struct trace_array *tr, unsigned long long duration,
 	trace_seq_puts(s, "|  ");
 }
 
+#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
+
+#define __TRACE_GRAPH_PRINT_RETVAL TRACE_GRAPH_PRINT_RETVAL
+
+static void print_graph_retval(struct trace_seq *s, unsigned long retval,
+				bool leaf, void *func, bool hex_format)
+{
+	unsigned long err_code = 0;
+
+	if (retval == 0 || hex_format)
+		goto done;
+
+	/* Check if the return value matches the negative format */
+	if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
+		(((u64)retval) >> 32) == 0) {
+		/* sign extension */
+		err_code = (unsigned long)(s32)retval;
+	} else {
+		err_code = retval;
+	}
+
+	if (!IS_ERR_VALUE(err_code))
+		err_code = 0;
+
+done:
+	if (leaf) {
+		if (hex_format || (err_code == 0))
+			trace_seq_printf(s, "%ps(); /* = 0x%lx */\n",
+					func, retval);
+		else
+			trace_seq_printf(s, "%ps(); /* = %ld */\n",
+					func, err_code);
+	} else {
+		if (hex_format || (err_code == 0))
+			trace_seq_printf(s, "} /* %ps = 0x%lx */\n",
+					func, retval);
+		else
+			trace_seq_printf(s, "} /* %ps = %ld */\n",
+					func, err_code);
+	}
+}
+
+#else
+
+#define __TRACE_GRAPH_PRINT_RETVAL 0
+
+#define print_graph_retval(_seq, _retval, _leaf, _func, _format) do {} while (0)
+
+#endif
+
 /* Case of a leaf function on its call entry */
 static enum print_line_t
 print_graph_entry_leaf(struct trace_iterator *iter,
@@ -663,7 +719,15 @@ print_graph_entry_leaf(struct trace_iterator *iter,
 	for (i = 0; i < call->depth * TRACE_GRAPH_INDENT; i++)
 		trace_seq_putc(s, ' ');
 
-	trace_seq_printf(s, "%ps();\n", (void *)call->func);
+	/*
+	 * Write out the function return value if the option function-retval is
+	 * enabled.
+	 */
+	if (flags & __TRACE_GRAPH_PRINT_RETVAL)
+		print_graph_retval(s, graph_ret->retval, true, (void *)call->func,
+				!!(flags & TRACE_GRAPH_PRINT_RETVAL_HEX));
+	else
+		trace_seq_printf(s, "%ps();\n", (void *)call->func);
 
 	print_graph_irq(iter, graph_ret->func, TRACE_GRAPH_RET,
 			cpu, iter->ent->pid, flags);
@@ -942,16 +1006,25 @@ print_graph_return(struct ftrace_graph_ret *trace, struct trace_seq *s,
 		trace_seq_putc(s, ' ');
 
 	/*
-	 * If the return function does not have a matching entry,
-	 * then the entry was lost. Instead of just printing
-	 * the '}' and letting the user guess what function this
-	 * belongs to, write out the function name. Always do
-	 * that if the funcgraph-tail option is enabled.
+	 * Always write out the function name and its return value if the
+	 * function-retval option is enabled.
 	 */
-	if (func_match && !(flags & TRACE_GRAPH_PRINT_TAIL))
-		trace_seq_puts(s, "}\n");
-	else
-		trace_seq_printf(s, "} /* %ps */\n", (void *)trace->func);
+	if (flags & __TRACE_GRAPH_PRINT_RETVAL) {
+		print_graph_retval(s, trace->retval, false, (void *)trace->func,
+			!!(flags & TRACE_GRAPH_PRINT_RETVAL_HEX));
+	} else {
+		/*
+		 * If the return function does not have a matching entry,
+		 * then the entry was lost. Instead of just printing
+		 * the '}' and letting the user guess what function this
+		 * belongs to, write out the function name. Always do
+		 * that if the funcgraph-tail option is enabled.
+		 */
+		if (func_match && !(flags & TRACE_GRAPH_PRINT_TAIL))
+			trace_seq_puts(s, "}\n");
+		else
+			trace_seq_printf(s, "} /* %ps */\n", (void *)trace->func);
+	}
 
 	/* Overrun */
 	if (flags & TRACE_GRAPH_PRINT_OVERRUN)
-- 
2.25.1

