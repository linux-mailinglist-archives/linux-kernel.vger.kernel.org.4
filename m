Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C606D7FD6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbjDEOo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbjDEOo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:44:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3034EFB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 07:44:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C14CD62412
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BD1C4339B;
        Wed,  5 Apr 2023 14:44:53 +0000 (UTC)
Date:   Wed, 5 Apr 2023 10:44:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        John Keeping <john@metanate.com>,
        Tze-nan Wu <Tze-nan.Wu@mediatek.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [GIT PULL] tracing: Fixes for 6.3-rc5
Message-ID: <20230405104451.185da06e@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes for 6.3:

- Fix timerlat notification, as it was not triggering the
  notify to users when a new max latency was hit.

- Do not trigger max latency if the tracing is off.
  When tracing is off, the ring buffer is not updated, it
  does not make sense to notify when there's a new max latency
  detected by the tracer, as why that latency happened is not available.
  The tracing logic still runs when the ring buffer is disabled, but
  it should not be triggering notifications.

- Fix race on freeing the synthetic event "last_cmd" variable by
  adding a mutex around it.

- Fix race between reader and writer of the ring buffer by adding
  memory barriers. When the writer is still on the reader page
  it must have its content visible on the buffer before it moves
  the commit index that the reader uses to know how much content is
  on the page.

- Make get_lock_parent_ip() always inlined, as it uses _THIS_IP_
  and _RET_IP_, which gets broken if it is not inlined.

- Make __field(int, arr[5]) in a TRACE_EVENT() macro fail to build.
  The field formats of trace events are calculated by using sizeof(type)
  and other means by what is passed into the structure macros like
  __field(). The __field() macro is only meant for atom types like
  int, long, short, pointer, etc. It is not meant for arrays. But
  the code will currently compile with arrays, but then the format
  produced will be inaccurate, and user space parsing tools will break.
  Two bugs have already been fixed, now add code that will make the
  kernel fail to build if another trace event includes this buggy
  field format.

- Fix boot up snapshot code:

  Boot snapshots were triggering when not even asked for on the
  kernel command line. This was caused by two bugs.

  1) It would trigger a snapshot on any instance if one was created
     from the kernel command line.

  2) The error handling would only affect the top level instance.
     So the fact that a snapshot was done on a instance that didn't
     allocate a buffer triggered a warning written into the top level
     buffer, and worse yet, disabled the top level buffer.

- Fix memory leak that was caused when an error was logged in a
  trace buffer instance, and then the buffer instance was removed.
  The allocated error log messages still need to be freed.


Please pull the latest trace-v6.3-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.3-rc5

Tag SHA1: b87985bf57ce1deffd75878b8ecccba809530034
Head SHA1: 3357c6e429643231e60447b52ffbb7ac895aca22


Daniel Bristot de Oliveira (2):
      tracing/timerlat: Notify new max thread latency
      tracing/osnoise: Fix notify new tracing_max_latency

John Keeping (1):
      ftrace: Mark get_lock_parent_ip() __always_inline

Steven Rostedt (Google) (4):
      tracing: Error if a trace event has an array for a __field()
      tracing: Have tracing_snapshot_instance_cond() write errors to the appropriate instance
      tracing: Fix ftrace_boot_snapshot command line logic
      tracing: Free error logs of tracing instances

Tze-nan Wu (1):
      tracing/synthetic: Fix races on freeing last_cmd

Zheng Yejian (1):
      ring-buffer: Fix race while reader and writer are on the same page

----
 include/linux/ftrace.h                    |  2 +-
 include/trace/stages/stage5_get_offsets.h | 21 +++++++++++++++++----
 kernel/trace/ring_buffer.c                | 13 ++++++++++++-
 kernel/trace/trace.c                      | 28 +++++++++++++++-------------
 kernel/trace/trace_events_synth.c         | 19 +++++++++++++++----
 kernel/trace/trace_osnoise.c              |  4 +++-
 6 files changed, 63 insertions(+), 24 deletions(-)
---------------------------
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 366c730beaa3..402fc061de75 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -980,7 +980,7 @@ static inline void __ftrace_enabled_restore(int enabled)
 #define CALLER_ADDR5 ((unsigned long)ftrace_return_address(5))
 #define CALLER_ADDR6 ((unsigned long)ftrace_return_address(6))
 
-static inline unsigned long get_lock_parent_ip(void)
+static __always_inline unsigned long get_lock_parent_ip(void)
 {
 	unsigned long addr = CALLER_ADDR0;
 
diff --git a/include/trace/stages/stage5_get_offsets.h b/include/trace/stages/stage5_get_offsets.h
index ac5c24d3beeb..e30a13be46ba 100644
--- a/include/trace/stages/stage5_get_offsets.h
+++ b/include/trace/stages/stage5_get_offsets.h
@@ -9,17 +9,30 @@
 #undef __entry
 #define __entry entry
 
+/*
+ * Fields should never declare an array: i.e. __field(int, arr[5])
+ * If they do, it will cause issues in parsing and possibly corrupt the
+ * events. To prevent that from happening, test the sizeof() a fictitious
+ * type called "struct _test_no_array_##item" which will fail if "item"
+ * contains array elements (like "arr[5]").
+ *
+ * If you hit this, use __array(int, arr, 5) instead.
+ */
 #undef __field
-#define __field(type, item)
+#define __field(type, item)					\
+	{ (void)sizeof(struct _test_no_array_##item *); }
 
 #undef __field_ext
-#define __field_ext(type, item, filter_type)
+#define __field_ext(type, item, filter_type)			\
+	{ (void)sizeof(struct _test_no_array_##item *); }
 
 #undef __field_struct
-#define __field_struct(type, item)
+#define __field_struct(type, item)				\
+	{ (void)sizeof(struct _test_no_array_##item *); }
 
 #undef __field_struct_ext
-#define __field_struct_ext(type, item, filter_type)
+#define __field_struct_ext(type, item, filter_type)		\
+	{ (void)sizeof(struct _test_no_array_##item *); }
 
 #undef __array
 #define __array(type, item, len)
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c6f47b6cfd5f..76a2d91eecad 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3098,6 +3098,10 @@ rb_set_commit_to_write(struct ring_buffer_per_cpu *cpu_buffer)
 		if (RB_WARN_ON(cpu_buffer,
 			       rb_is_reader_page(cpu_buffer->tail_page)))
 			return;
+		/*
+		 * No need for a memory barrier here, as the update
+		 * of the tail_page did it for this page.
+		 */
 		local_set(&cpu_buffer->commit_page->page->commit,
 			  rb_page_write(cpu_buffer->commit_page));
 		rb_inc_page(&cpu_buffer->commit_page);
@@ -3107,6 +3111,8 @@ rb_set_commit_to_write(struct ring_buffer_per_cpu *cpu_buffer)
 	while (rb_commit_index(cpu_buffer) !=
 	       rb_page_write(cpu_buffer->commit_page)) {
 
+		/* Make sure the readers see the content of what is committed. */
+		smp_wmb();
 		local_set(&cpu_buffer->commit_page->page->commit,
 			  rb_page_write(cpu_buffer->commit_page));
 		RB_WARN_ON(cpu_buffer,
@@ -4684,7 +4690,12 @@ rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
 
 	/*
 	 * Make sure we see any padding after the write update
-	 * (see rb_reset_tail())
+	 * (see rb_reset_tail()).
+	 *
+	 * In addition, a writer may be writing on the reader page
+	 * if the page has not been fully filled, so the read barrier
+	 * is also needed to make sure we see the content of what is
+	 * committed by the writer (see rb_set_commit_to_write()).
 	 */
 	smp_rmb();
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 937e9676dfd4..36a6037823cd 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1149,22 +1149,22 @@ static void tracing_snapshot_instance_cond(struct trace_array *tr,
 	unsigned long flags;
 
 	if (in_nmi()) {
-		internal_trace_puts("*** SNAPSHOT CALLED FROM NMI CONTEXT ***\n");
-		internal_trace_puts("*** snapshot is being ignored        ***\n");
+		trace_array_puts(tr, "*** SNAPSHOT CALLED FROM NMI CONTEXT ***\n");
+		trace_array_puts(tr, "*** snapshot is being ignored        ***\n");
 		return;
 	}
 
 	if (!tr->allocated_snapshot) {
-		internal_trace_puts("*** SNAPSHOT NOT ALLOCATED ***\n");
-		internal_trace_puts("*** stopping trace here!   ***\n");
-		tracing_off();
+		trace_array_puts(tr, "*** SNAPSHOT NOT ALLOCATED ***\n");
+		trace_array_puts(tr, "*** stopping trace here!   ***\n");
+		tracer_tracing_off(tr);
 		return;
 	}
 
 	/* Note, snapshot can not be used when the tracer uses it */
 	if (tracer->use_max_tr) {
-		internal_trace_puts("*** LATENCY TRACER ACTIVE ***\n");
-		internal_trace_puts("*** Can not use snapshot (sorry) ***\n");
+		trace_array_puts(tr, "*** LATENCY TRACER ACTIVE ***\n");
+		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
 		return;
 	}
 
@@ -9516,6 +9516,7 @@ static int __remove_instance(struct trace_array *tr)
 	tracefs_remove(tr->dir);
 	free_percpu(tr->last_func_repeats);
 	free_trace_buffers(tr);
+	clear_tracing_err_log(tr);
 
 	for (i = 0; i < tr->nr_topts; i++) {
 		kfree(tr->topts[i].topts);
@@ -10393,19 +10394,20 @@ __init static int tracer_alloc_buffers(void)
 
 void __init ftrace_boot_snapshot(void)
 {
+#ifdef CONFIG_TRACER_MAX_TRACE
 	struct trace_array *tr;
 
-	if (snapshot_at_boot) {
-		tracing_snapshot();
-		internal_trace_puts("** Boot snapshot taken **\n");
-	}
+	if (!snapshot_at_boot)
+		return;
 
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
-		if (tr == &global_trace)
+		if (!tr->allocated_snapshot)
 			continue;
-		trace_array_puts(tr, "** Boot snapshot taken **\n");
+
 		tracing_snapshot_instance(tr);
+		trace_array_puts(tr, "** Boot snapshot taken **\n");
 	}
+#endif
 }
 
 void __init early_trace_init(void)
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 46d0abb32d0f..f0ff730125bf 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -44,14 +44,21 @@ enum { ERRORS };
 
 static const char *err_text[] = { ERRORS };
 
+DEFINE_MUTEX(lastcmd_mutex);
 static char *last_cmd;
 
 static int errpos(const char *str)
 {
+	int ret = 0;
+
+	mutex_lock(&lastcmd_mutex);
 	if (!str || !last_cmd)
-		return 0;
+		goto out;
 
-	return err_pos(last_cmd, str);
+	ret = err_pos(last_cmd, str);
+ out:
+	mutex_unlock(&lastcmd_mutex);
+	return ret;
 }
 
 static void last_cmd_set(const char *str)
@@ -59,18 +66,22 @@ static void last_cmd_set(const char *str)
 	if (!str)
 		return;
 
+	mutex_lock(&lastcmd_mutex);
 	kfree(last_cmd);
-
 	last_cmd = kstrdup(str, GFP_KERNEL);
+	mutex_unlock(&lastcmd_mutex);
 }
 
 static void synth_err(u8 err_type, u16 err_pos)
 {
+	mutex_lock(&lastcmd_mutex);
 	if (!last_cmd)
-		return;
+		goto out;
 
 	tracing_log_err(NULL, "synthetic_events", last_cmd, err_text,
 			err_type, err_pos);
+ out:
+	mutex_unlock(&lastcmd_mutex);
 }
 
 static int create_synth_event(const char *raw_command);
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 9176bb7a9bb4..4496975f2029 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1296,7 +1296,7 @@ static void notify_new_max_latency(u64 latency)
 	rcu_read_lock();
 	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
 		tr = inst->tr;
-		if (tr->max_latency < latency) {
+		if (tracer_tracing_is_on(tr) && tr->max_latency < latency) {
 			tr->max_latency = latency;
 			latency_fsnotify(tr);
 		}
@@ -1738,6 +1738,8 @@ static int timerlat_main(void *data)
 
 		trace_timerlat_sample(&s);
 
+		notify_new_max_latency(diff);
+
 		timerlat_dump_stack(time_to_us(diff));
 
 		tlat->tracing_thread = false;
