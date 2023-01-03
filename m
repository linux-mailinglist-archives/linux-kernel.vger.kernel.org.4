Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FBC65C052
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjACMyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbjACMte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:49:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7FE7BF7;
        Tue,  3 Jan 2023 04:49:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 438D51570;
        Tue,  3 Jan 2023 04:50:14 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B11173F587;
        Tue,  3 Jan 2023 04:49:31 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, mhiramat@kernel.org, revest@chromium.org,
        rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ftrace: Add sample with custom ops
Date:   Tue,  3 Jan 2023 12:49:12 +0000
Message-Id: <20230103124912.2948963-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230103124912.2948963-1-mark.rutland@arm.com>
References: <20230103124912.2948963-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reworking core ftrace code or architectural ftrace code, it's often
necessary to test/analyse/benchmark a number of ftrace_ops
configurations. This patch adds a module which can be used to explore
some of those configurations.

I'm using this to benchmark various options for changing the way
trampolines and handling of ftrace_ops work on arm64, and ensuring other
architectures aren't adversely affected.

For example, in a QEMU+KVM VM running on a 2GHz Xeon E5-2660
workstation, loading the module in various configurations produces:

| # insmod ftrace-ops.ko
| ftrace_ops: registering:
|   relevant ops: 1
|     tracee: tracee_relevant [ftrace_ops]
|     tracer: ops_func_nop [ftrace_ops]
|   irrelevant ops: 0
|     tracee: tracee_irrelevant [ftrace_ops]
|     tracer: ops_func_nop [ftrace_ops]
|   saving registers: NO
|   assist recursion: NO
|   assist RCU: NO
| ftrace_ops: Attempted 100000 calls to tracee_relevant [ftrace_ops] in 1681558ns (16ns / call)

| # insmod ftrace-ops.ko nr_ops_irrelevant=5
| ftrace_ops: registering:
|   relevant ops: 1
|     tracee: tracee_relevant [ftrace_ops]
|     tracer: ops_func_nop [ftrace_ops]
|   irrelevant ops: 5
|     tracee: tracee_irrelevant [ftrace_ops]
|     tracer: ops_func_nop [ftrace_ops]
|   saving registers: NO
|   assist recursion: NO
|   assist RCU: NO
| ftrace_ops: Attempted 100000 calls to tracee_relevant [ftrace_ops] in 1693042ns (16ns / call)

| # insmod ftrace-ops.ko nr_ops_relevant=2
| ftrace_ops: registering:
|   relevant ops: 2
|     tracee: tracee_relevant [ftrace_ops]
|     tracer: ops_func_nop [ftrace_ops]
|   irrelevant ops: 0
|     tracee: tracee_irrelevant [ftrace_ops]
|     tracer: ops_func_nop [ftrace_ops]
|   saving registers: NO
|   assist recursion: NO
|   assist RCU: NO
| ftrace_ops: Attempted 100000 calls to tracee_relevant [ftrace_ops] in 11965582ns (119ns / call)

| # insmod ftrace-ops.ko save_regs=true
| ftrace_ops: registering:
|   relevant ops: 1
|     tracee: tracee_relevant [ftrace_ops]
|     tracer: ops_func_nop [ftrace_ops]
|   irrelevant ops: 0
|     tracee: tracee_irrelevant [ftrace_ops]
|     tracer: ops_func_nop [ftrace_ops]
|   saving registers: YES
|   assist recursion: NO
|   assist RCU: NO
| ftrace_ops: Attempted 100000 calls to tracee_relevant [ftrace_ops] in 4459624ns (44ns / call)

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Florent Revest <revest@chromium.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 samples/Kconfig             |   7 +
 samples/Makefile            |   1 +
 samples/ftrace/Makefile     |   1 +
 samples/ftrace/ftrace-ops.c | 252 ++++++++++++++++++++++++++++++++++++
 4 files changed, 261 insertions(+)
 create mode 100644 samples/ftrace/ftrace-ops.c

diff --git a/samples/Kconfig b/samples/Kconfig
index 0d81c00289ee3..daf14c35f071d 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -46,6 +46,13 @@ config SAMPLE_FTRACE_DIRECT_MULTI
 	  that hooks to wake_up_process and schedule, and prints
 	  the function addresses.
 
+config SAMPLE_FTRACE_OPS
+	tristate "Build custom ftrace ops example"
+	depends on FUNCTION_TRACER
+	help
+	  This builds an ftrace ops example that hooks two functions and
+	  measures the time taken to invoke one function a number of times.
+
 config SAMPLE_TRACE_ARRAY
         tristate "Build sample module for kernel access to Ftrace instancess"
 	depends on EVENT_TRACING && m
diff --git a/samples/Makefile b/samples/Makefile
index 9832ef3f8fcba..7cb632ef88eeb 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS) += trace_events/
 obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT)	+= ftrace/
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT_MULTI) += ftrace/
+obj-$(CONFIG_SAMPLE_FTRACE_OPS)		+= ftrace/
 obj-$(CONFIG_SAMPLE_TRACE_ARRAY)	+= ftrace/
 subdir-$(CONFIG_SAMPLE_UHID)		+= uhid
 obj-$(CONFIG_VIDEO_PCI_SKELETON)	+= v4l/
diff --git a/samples/ftrace/Makefile b/samples/ftrace/Makefile
index faf8cdb79c5f4..589baf2ec4e3d 100644
--- a/samples/ftrace/Makefile
+++ b/samples/ftrace/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-too.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT) += ftrace-direct-modify.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT_MULTI) += ftrace-direct-multi.o
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT_MULTI) += ftrace-direct-multi-modify.o
+obj-$(CONFIG_SAMPLE_FTRACE_OPS) += ftrace-ops.o
 
 CFLAGS_sample-trace-array.o := -I$(src)
 obj-$(CONFIG_SAMPLE_TRACE_ARRAY) += sample-trace-array.o
diff --git a/samples/ftrace/ftrace-ops.c b/samples/ftrace/ftrace-ops.c
new file mode 100644
index 0000000000000..24deb51c72618
--- /dev/null
+++ b/samples/ftrace/ftrace-ops.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt)       KBUILD_MODNAME ": " fmt
+
+#include <linux/ftrace.h>
+#include <linux/ktime.h>
+#include <linux/module.h>
+
+#include <asm/barrier.h>
+
+/*
+ * Arbitrary large value chosen to be sufficiently large to minimize noise but
+ * sufficiently small to complete quickly.
+ */
+unsigned int nr_function_calls = 100000;
+module_param(nr_function_calls, uint, 0);
+MODULE_PARM_DESC(nr_function_calls, "How many times to call the relevant tracee");
+
+/*
+ * The number of ops associated with a call site affects whether a tracer can
+ * be called directly or whether it's necessary to go via the list func, which
+ * can be significantly more expensive.
+ */
+unsigned int nr_ops_relevant = 1;
+module_param(nr_ops_relevant, uint, 0);
+MODULE_PARM_DESC(nr_ops_relevant, "How many ftrace_ops to associate with the relevant tracee");
+
+/*
+ * On architectures where all call sites share the same trampoline, having
+ * tracers enabled for distinct functions can force the use of the list func
+ * and incur overhead for all call sites.
+ */
+unsigned int nr_ops_irrelevant = 0;
+module_param(nr_ops_irrelevant, uint, 0);
+MODULE_PARM_DESC(nr_ops_irrelevant, "How many ftrace_ops to associate with the irrelevant tracee");
+
+/*
+ * On architectures with DYNAMIC_FTRACE_WITH_REGS, saving the full pt_regs can
+ * be more expensive than only saving the minimal necessary regs.
+ */
+bool save_regs = false;
+module_param(save_regs, bool, 0);
+MODULE_PARM_DESC(save_regs, "Register ops with FTRACE_OPS_FL_SAVE_REGS (save all registers in the trampoline)");
+
+bool assist_recursion = false;
+module_param(assist_recursion, bool, 0);
+MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RECURSION");
+
+bool assist_rcu = false;
+module_param(assist_rcu, bool, 0);
+MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RCU");
+
+/*
+ * By default, a trivial tracer is used which immediately returns to mimimize
+ * overhead. Sometimes a consistency check using a more expensive tracer is
+ * desireable.
+ */
+bool check_count = false;
+module_param(check_count, bool, 0);
+MODULE_PARM_DESC(check_count, "Check that tracers are called the expected number of times\n");
+
+/*
+ * Usually it's not interesting to leave the ops registered after the test
+ * runs, but sometimes it can be useful to leave them registered so that they
+ * can be inspected through the tracefs 'enabled_functions' file.
+ */
+bool persist = false;
+module_param(persist, bool, 0);
+MODULE_PARM_DESC(persist, "Successfully load module and leave ftrace ops registered after test completes\n");
+
+/*
+ * Marked as noinline to ensure that an out-of-line traceable copy is
+ * generated by the compiler.
+ *
+ * The barrier() ensures the compiler won't elide calls by determining there
+ * are no side-effects.
+ */
+static noinline void tracee_relevant(void)
+{
+	barrier();
+}
+
+/*
+ * Marked as noinline to ensure that an out-of-line traceable copy is
+ * generated by the compiler.
+ *
+ * The barrier() ensures the compiler won't elide calls by determining there
+ * are no side-effects.
+ */
+static noinline void tracee_irrelevant(void)
+{
+	barrier();
+}
+
+struct sample_ops {
+	struct ftrace_ops ops;
+	unsigned int count;
+};
+
+static void ops_func_nop(unsigned long ip, unsigned long parent_ip,
+			 struct ftrace_ops *op,
+			 struct ftrace_regs *fregs)
+{
+	/* do nothing */
+}
+
+static void ops_func_count(unsigned long ip, unsigned long parent_ip,
+			   struct ftrace_ops *op,
+			   struct ftrace_regs *fregs)
+{
+	struct sample_ops *self;
+
+	self = container_of(op, struct sample_ops, ops);
+	self->count++;
+}
+
+struct sample_ops *ops_relevant;
+struct sample_ops *ops_irrelevant;
+
+static struct sample_ops *ops_alloc_init(void *tracee, ftrace_func_t func,
+					 unsigned long flags, int nr)
+{
+	struct sample_ops *ops;
+
+	ops = kcalloc(nr, sizeof(*ops), GFP_KERNEL);
+	if (WARN_ON_ONCE(!ops))
+		return NULL;
+
+	for (unsigned int i = 0; i < nr; i++) {
+		ops[i].ops.func = func;
+		ops[i].ops.flags = flags;
+		WARN_ON_ONCE(ftrace_set_filter_ip(&ops[i].ops, (unsigned long)tracee, 0, 0));
+		WARN_ON_ONCE(register_ftrace_function(&ops[i].ops));
+	}
+
+	return ops;
+}
+
+static void ops_destroy(struct sample_ops *ops, int nr)
+{
+	if (!ops)
+		return;
+
+	for (unsigned int i = 0; i < nr; i++) {
+		WARN_ON_ONCE(unregister_ftrace_function(&ops[i].ops));
+		ftrace_free_filter(&ops[i].ops);
+	}
+
+	kfree(ops);
+}
+
+static void ops_check(struct sample_ops *ops, int nr,
+		      unsigned int expected_count)
+{
+	if (!ops || !check_count)
+		return;
+
+	for (unsigned int i = 0; i < nr; i++) {
+		if (ops->count == expected_count)
+			continue;
+		pr_warn("Counter called %u times (expected %u)\n",
+			ops->count, expected_count);
+	}
+}
+
+ftrace_func_t tracer_relevant = ops_func_nop;
+ftrace_func_t tracer_irrelevant = ops_func_nop;
+
+static int __init ftrace_ops_sample_init(void)
+{
+	unsigned long flags = 0;
+	ktime_t start, end;
+	u64 period;
+
+	if (!IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_REGS) && save_regs) {
+		pr_info("this kernel does not support saving registers\n");
+		save_regs = false;
+	} else if (save_regs) {
+		flags |= FTRACE_OPS_FL_SAVE_REGS;
+	}
+
+	if (assist_recursion)
+		flags |= FTRACE_OPS_FL_RECURSION;
+
+	if (assist_rcu)
+		flags |= FTRACE_OPS_FL_RCU;
+
+	if (check_count) {
+		tracer_relevant = ops_func_count;
+		tracer_irrelevant = ops_func_count;
+	}
+
+	pr_info("registering:\n"
+		"  relevant ops: %u\n"
+		"    tracee: %ps\n"
+		"    tracer: %ps\n"
+		"  irrelevant ops: %u\n"
+		"    tracee: %ps\n"
+		"    tracer: %ps\n"
+		"  saving registers: %s\n"
+		"  assist recursion: %s\n"
+		"  assist RCU: %s\n",
+		nr_ops_relevant, tracee_relevant, tracer_relevant,
+		nr_ops_irrelevant, tracee_irrelevant, tracer_irrelevant,
+		save_regs ? "YES" : "NO",
+		assist_recursion ? "YES" : "NO",
+		assist_rcu ? "YES" : "NO");
+
+	ops_relevant = ops_alloc_init(tracee_relevant, tracer_relevant,
+				      flags, nr_ops_relevant);
+	ops_irrelevant = ops_alloc_init(tracee_irrelevant, tracer_irrelevant,
+					flags, nr_ops_irrelevant);
+
+	start = ktime_get();
+	for (unsigned int i = 0; i < nr_function_calls; i++)
+		tracee_relevant();
+	end = ktime_get();
+
+	ops_check(ops_relevant, nr_ops_relevant, nr_function_calls);
+	ops_check(ops_irrelevant, nr_ops_irrelevant, 0);
+
+	period = ktime_to_ns(ktime_sub(end, start));
+
+	pr_info("Attempted %u calls to %ps in %lluns (%lluns / call)\n",
+		nr_function_calls, tracee_relevant,
+		period, period / nr_function_calls);
+
+	if (persist)
+		return 0;
+
+	ops_destroy(ops_relevant, nr_ops_relevant);
+	ops_destroy(ops_irrelevant, nr_ops_irrelevant);
+
+	/*
+	 * The benchmark completed sucessfully, but there's no reason to keep
+	 * the module around. Return an error do the user doesn't have to
+	 * manually unload the module.
+	 */
+	return -EINVAL;
+}
+module_init(ftrace_ops_sample_init);
+
+static void __exit ftrace_ops_sample_exit(void)
+{
+	ops_destroy(ops_relevant, nr_ops_relevant);
+	ops_destroy(ops_irrelevant, nr_ops_irrelevant);
+}
+module_exit(ftrace_ops_sample_exit);
+
+MODULE_AUTHOR("Mark Rutland");
+MODULE_DESCRIPTION("Example of using custom ftrace_ops");
+MODULE_LICENSE("GPL");
-- 
2.30.2

