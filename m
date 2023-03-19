Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2235D6C0385
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjCSRmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCSRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:42:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D501C5BE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 10:42:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CA172B80B4A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 17:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AC5C433D2;
        Sun, 19 Mar 2023 17:42:18 +0000 (UTC)
Date:   Sun, 19 Mar 2023 13:42:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Gusev <aagusev@ispras.ru>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Sung-hun Kim <sfoon.kim@samsung.com>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        Tom Rix <trix@redhat.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] tracing: Updates for 6.3
Message-ID: <20230319134216.26d9dcf2@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes for 6.3:

- Fix setting affinity of hwlat threads in containers
  Using sched_set_affinity() has unwanted side effects when being
  called within a container. Use set_cpus_allowed_ptr() instead.

- Fix per cpu thread management of the hwlat tracer
  * Do not start per_cpu threads if one is already running for the CPU.
  * When starting per_cpu threads, do not clear the kthread variable
    as it may already be set to running per cpu threads

- Fix return value for test_gen_kprobe_cmd()
  On error the return value was overwritten by being set to
  the result of the call from kprobe_event_delete(), which would
  likely succeed, and thus have the function return success.

- Fix splice() reads from the trace file that was broken by
  36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")

- Remove obsolete and confusing comment in ring_buffer.c
  The original design of the ring buffer used struct page flags
  for tricks to optimize, which was shortly removed due to them
  being tricks. But a comment for those tricks remained.

- Set local functions and variables to static


Please pull the latest trace-v6.3-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.3-rc2

Tag SHA1: a9d1f246972b628488204ffb45d0e97bef7f5ce6
Head SHA1: 71c7a30442b724717a30d5e7d1662ba4904eb3d4


Anton Gusev (1):
      tracing: Fix wrong return in kprobe_event_gen_test.c

Costa Shulyupin (1):
      tracing/hwlat: Replace sched_setaffinity with set_cpus_allowed_ptr

Sung-hun Kim (1):
      tracing: Make splice_read available again

Tero Kristo (2):
      trace/hwlat: Do not wipe the contents of per-cpu thread data
      trace/hwlat: Do not start per-cpu thread if it is already running

Tom Rix (2):
      tracing/osnoise: set several trace_osnoise.c variables storage-class-specifier to static
      ftrace: Set direct_ops storage-class-specifier to static

Vlastimil Babka (1):
      ring-buffer: remove obsolete comment for free_buffer_page()

----
 kernel/trace/ftrace.c                |  2 +-
 kernel/trace/kprobe_event_gen_test.c |  4 ++--
 kernel/trace/ring_buffer.c           |  4 ----
 kernel/trace/trace.c                 |  2 ++
 kernel/trace/trace_hwlat.c           | 11 ++++++-----
 kernel/trace/trace_osnoise.c         | 10 +++++-----
 6 files changed, 16 insertions(+), 17 deletions(-)
---------------------------
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a47f7d93e32d..ec2897a76004 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2503,7 +2503,7 @@ static void call_direct_funcs(unsigned long ip, unsigned long pip,
 	arch_ftrace_set_direct_caller(fregs, addr);
 }
 
-struct ftrace_ops direct_ops = {
+static struct ftrace_ops direct_ops = {
 	.func		= call_direct_funcs,
 	.flags		= FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS
 			  | FTRACE_OPS_FL_PERMANENT,
diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
index 4850fdfe27f1..5a4b722b5045 100644
--- a/kernel/trace/kprobe_event_gen_test.c
+++ b/kernel/trace/kprobe_event_gen_test.c
@@ -146,7 +146,7 @@ static int __init test_gen_kprobe_cmd(void)
 	if (trace_event_file_is_valid(gen_kprobe_test))
 		gen_kprobe_test = NULL;
 	/* We got an error after creating the event, delete it */
-	ret = kprobe_event_delete("gen_kprobe_test");
+	kprobe_event_delete("gen_kprobe_test");
 	goto out;
 }
 
@@ -211,7 +211,7 @@ static int __init test_gen_kretprobe_cmd(void)
 	if (trace_event_file_is_valid(gen_kretprobe_test))
 		gen_kretprobe_test = NULL;
 	/* We got an error after creating the event, delete it */
-	ret = kprobe_event_delete("gen_kretprobe_test");
+	kprobe_event_delete("gen_kretprobe_test");
 	goto out;
 }
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 071184324d18..3c7cd135333f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -354,10 +354,6 @@ static void rb_init_page(struct buffer_data_page *bpage)
 	local_set(&bpage->commit, 0);
 }
 
-/*
- * Also stolen from mm/slob.c. Thanks to Mathieu Desnoyers for pointing
- * this issue out.
- */
 static void free_buffer_page(struct buffer_page *bpage)
 {
 	free_page((unsigned long)bpage->page);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index fbb602a8b64b..4e9a7a952025 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5164,6 +5164,8 @@ loff_t tracing_lseek(struct file *file, loff_t offset, int whence)
 static const struct file_operations tracing_fops = {
 	.open		= tracing_open,
 	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.write		= tracing_write_stub,
 	.llseek		= tracing_lseek,
 	.release	= tracing_release,
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index d440ddd5fd8b..2f37a6e68aa9 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -339,7 +339,7 @@ static void move_to_next_cpu(void)
 	cpumask_clear(current_mask);
 	cpumask_set_cpu(next_cpu, current_mask);
 
-	sched_setaffinity(0, current_mask);
+	set_cpus_allowed_ptr(current, current_mask);
 	return;
 
  change_mode:
@@ -446,7 +446,7 @@ static int start_single_kthread(struct trace_array *tr)
 
 	}
 
-	sched_setaffinity(kthread->pid, current_mask);
+	set_cpus_allowed_ptr(kthread, current_mask);
 
 	kdata->kthread = kthread;
 	wake_up_process(kthread);
@@ -492,6 +492,10 @@ static int start_cpu_kthread(unsigned int cpu)
 {
 	struct task_struct *kthread;
 
+	/* Do not start a new hwlatd thread if it is already running */
+	if (per_cpu(hwlat_per_cpu_data, cpu).kthread)
+		return 0;
+
 	kthread = kthread_run_on_cpu(kthread_fn, NULL, cpu, "hwlatd/%u");
 	if (IS_ERR(kthread)) {
 		pr_err(BANNER "could not start sampling thread\n");
@@ -584,9 +588,6 @@ static int start_per_cpu_kthreads(struct trace_array *tr)
 	 */
 	cpumask_and(current_mask, cpu_online_mask, tr->tracing_cpumask);
 
-	for_each_online_cpu(cpu)
-		per_cpu(hwlat_per_cpu_data, cpu).kthread = NULL;
-
 	for_each_cpu(cpu, current_mask) {
 		retval = start_cpu_kthread(cpu);
 		if (retval)
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 04f0fdae19a1..9176bb7a9bb4 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -217,7 +217,7 @@ struct osnoise_variables {
 /*
  * Per-cpu runtime information.
  */
-DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
+static DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
 
 /*
  * this_cpu_osn_var - Return the per-cpu osnoise_variables on its relative CPU
@@ -240,7 +240,7 @@ struct timerlat_variables {
 	u64			count;
 };
 
-DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
+static DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
 
 /*
  * this_cpu_tmr_var - Return the per-cpu timerlat_variables on its relative CPU
@@ -332,7 +332,7 @@ struct timerlat_sample {
 /*
  * Protect the interface.
  */
-struct mutex interface_lock;
+static struct mutex interface_lock;
 
 /*
  * Tracer data.
@@ -2239,8 +2239,8 @@ static struct trace_min_max_param osnoise_print_stack = {
 /*
  * osnoise/timerlat_period: min 100 us, max 1 s
  */
-u64 timerlat_min_period = 100;
-u64 timerlat_max_period = 1000000;
+static u64 timerlat_min_period = 100;
+static u64 timerlat_max_period = 1000000;
 static struct trace_min_max_param timerlat_period = {
 	.lock	= &interface_lock,
 	.val	= &osnoise_data.timerlat_period,
