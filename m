Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA06D6D20E8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjCaMuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjCaMt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:49:29 -0400
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67B42030E;
        Fri, 31 Mar 2023 05:49:08 -0700 (PDT)
Received: from ubuntu.localdomain (unknown [117.133.56.22])
        by mail-m118111.qiye.163.com (Hmail) with ESMTPA id 898ED5801A4;
        Fri, 31 Mar 2023 20:48:02 +0800 (CST)
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
        Donglin Peng <pengdonglin@sangfor.com.cn>,
        Florian Kauer <florian.kauer@linutronix.de>
Subject: [PATCH v10 1/8] function_graph: Support recording and printing the return value of function
Date:   Fri, 31 Mar 2023 05:47:37 -0700
Message-Id: <37831bc91d01ce2b80c7eb1e38e38238980dad15.1680265828.git.pengdonglin@sangfor.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1680265828.git.pengdonglin@sangfor.com.cn>
References: <cover.1680265828.git.pengdonglin@sangfor.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGUoZVkMdT05NTk5OTRkfGlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKTFVKSEhVTk1VSUlZV1kWGg8SFR0UWUFZT0tIVUpKS0hKTFVKS0tVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NU06GQw6Dz0SPU0ZDTkYIT80
        PU5PCilVSlVKTUNLSU1NQ0NPT0JPVTMWGhIXVQseFRwfFBUcFxIVOwgaFRwdFAlVGBQWVRgVRVlX
        WRILWUFZSkpMVUpISFVOTVVJSVlXWQgBWUFKTU5CTDcG
X-HM-Tid: 0a8737b5f2842eb7kusn898ed5801a4
X-HM-MType: 1
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Analyzing system call failures with the function_graph tracer can be a
time-consuming process, particularly when locating the kernel function
that first returns an error in the trace logs. This change aims to
simplify the process by recording the function return value to the
'retval' member of 'ftrace_graph_ent' and printing it when outputting
the trace log.

We have introduced new trace options: funcgraph-retval and
funcgraph-retval-hex. The former controls whether to display the return
value, while the latter controls the display format.

Please note that even if a function's return type is void, a return
value will still be printed. You can simply ignore it.

This patch only establishes the fundamental infrastructure. Subsequent
patches will make this feature available on some commonly used processor
architectures.

Here is an example:

I attempted to attach the demo process to a cpu cgroup, but it failed:

echo `pidof demo` > /sys/fs/cgroup/cpu/test/tasks
-bash: echo: write error: Invalid argument

The strace logs indicate that the write system call returned -EINVAL(-22):
...
write(1, "273\n", 4)                    = -1 EINVAL (Invalid argument)
...

To capture trace logs during a write system call, use the following
commands:

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
echo 1 > options/funcgraph-retval
echo 0 > options/funcgraph-retval-hex
echo 1 > tracing_on
echo `pidof demo` > /sys/fs/cgroup/cpu/test/tasks
echo 0 > tracing_on
cat trace > ~/trace.log

To locate the root cause, search for error code -22 directly in the file
trace.log and identify the first function that returned -22. Once you
have identified this function, examine its code to determine the root
cause.

For example, in the trace log below, cpu_cgroup_can_attach
returned -22 first, so we can focus our analysis on this function to
identify the root cause.

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

Tested-by: Florian Kauer <florian.kauer@linutronix.de>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
---
v9:
 - Update comments for ftrace_return_to_handler

v8:
 - Add some comments on CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
 - Make CONFIG_FUNCTION_GRAPH_RETVAL switable

v7:
 - Rename trace option 'graph_retval_hex' to 'funcgraph-retval-hex'
 - Separate each architecture modification info individual patches
 - Introduce a new structure fgraph_ret_regs for each architecture to
   hold return registers

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
 include/linux/ftrace.h               |  3 +
 kernel/trace/Kconfig                 | 15 +++++
 kernel/trace/fgraph.c                | 23 ++++++-
 kernel/trace/trace.h                 |  2 +
 kernel/trace/trace_entries.h         | 26 ++++++++
 kernel/trace/trace_functions_graph.c | 93 +++++++++++++++++++++++++---
 6 files changed, 151 insertions(+), 11 deletions(-)

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
index a856d4a34c67..87de5964c81d 100644
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
@@ -227,6 +230,18 @@ config FUNCTION_GRAPH_TRACER
 	  the return value. This is done by setting the current return
 	  address on the current task structure into a stack of calls.
 
+config FUNCTION_GRAPH_RETVAL
+	bool "Function Graph Return Value"
+	depends on HAVE_FUNCTION_GRAPH_RETVAL
+	depends on FUNCTION_GRAPH_TRACER
+	default n
+	help
+	  Support recording and printing the function return value when
+	  using function graph tracer. It can be helpful to locate functions
+	  that return errors. This feature is off by default, and you can
+	  enable it via the trace option funcgraph-retval.
+	  See Documentation/trace/ftrace.rst
+
 config DYNAMIC_FTRACE
 	bool "enable/disable function tracing dynamically"
 	depends on FUNCTION_TRACER
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 218cd95bf8e4..170ec9429efb 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -240,12 +240,16 @@ static struct notifier_block ftrace_suspend_notifier = {
  * Send the trace to the ring-buffer.
  * @return the original return address.
  */
-unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
+static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs,
+						unsigned long frame_pointer)
 {
 	struct ftrace_graph_ret trace;
 	unsigned long ret;
 
 	ftrace_pop_return_trace(&trace, &ret, frame_pointer);
+#ifdef CONFIG_FUNCTION_GRAPH_RETVAL
+	trace.retval = fgraph_ret_regs_return_value(ret_regs);
+#endif
 	trace.rettime = trace_clock_local();
 	ftrace_graph_return(&trace);
 	/*
@@ -266,6 +270,23 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 	return ret;
 }
 
+/*
+ * After all architecures have selected HAVE_FUNCTION_GRAPH_RETVAL, we can
+ * leave only ftrace_return_to_handler(ret_regs).
+ */
+#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
+unsigned long ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs)
+{
+	return __ftrace_return_to_handler(ret_regs,
+				fgraph_ret_regs_frame_pointer(ret_regs));
+}
+#else
+unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
+{
+	return __ftrace_return_to_handler(NULL, frame_pointer);
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
index 203204cadf92..c35fbaab2a47 100644
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
+	{ TRACER_OPT(funcgraph-retval-hex, TRACE_GRAPH_PRINT_RETVAL_HEX) },
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

