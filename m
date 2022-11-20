Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B6D631655
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 21:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiKTU1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 15:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKTU1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 15:27:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED01DEFB
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 12:27:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BB7160D28
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 20:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DA7C433D6;
        Sun, 20 Nov 2022 20:27:31 +0000 (UTC)
Date:   Sun, 20 Nov 2022 15:27:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aashish Sharma <shraash@google.com>,
        Daniil Tatianin <d-tatianin@yandex-team.ru>,
        Qiujun Huang <hqjagain@gmail.com>,
        Shang XiaoJing <shangxiaojing@huawei.com>,
        Wang Wensheng <wangwensheng4@huawei.com>,
        Wang Yufen <wangyufen@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [GIT PULL] tracing: Fixes for v6.1
Message-ID: <20221120152730.4d2a512d@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes:

- Fix polling to block on watermark like the reads do, as user space
  applications get confused when the select says read is available, and then
  the read blocks.

- Fix accounting of ring buffer dropped pages as it is what is used to
  determine if the buffer is empty or not.

- Fix memory leak in tracing_read_pipe()

- Fix struct trace_array warning about being declared in parameters

- Fix accounting of ftrace pages used in output at start up.

- Fix allocation of dyn_ftrace pages by subtracting one from order instead of
  diving it by 2

- Static analyzer found a case were a pointer being used outside of a NULL
  check. (rb_head_page_deactivate())

- Fix possible NULL pointer dereference if kstrdup() fails in ftrace_add_mod()

- Fix memory leak in test_gen_synth_cmd() and test_empty_synth_event()

- Fix bad pointer dereference in register_synth_event() on error path.

- Remove unused __bad_type_size() method

- Fix possible NULL pointer dereference of entry in list 'tr->err_log'

- Fix NULL pointer deference race if eprobe is called before the event setup


Please pull the latest trace-v6.1-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.1-rc5

Tag SHA1: 841b9a46b1091224f5a111bd248ee55309bd38ce
Head SHA1: 94eedf3dded5fb472ce97bfaf3ac1c6c29c35d26


Aashish Sharma (1):
      tracing: Fix warning on variable 'struct trace_array'

Daniil Tatianin (1):
      ring_buffer: Do not deactivate non-existant pages

Qiujun Huang (1):
      tracing: Remove unused __bad_type_size() method

Shang XiaoJing (2):
      tracing: Fix memory leak in test_gen_synth_cmd() and test_empty_synth_event()
      tracing: Fix wild-memory-access in register_synth_event()

Steven Rostedt (Google) (3):
      tracing/ring-buffer: Have polling block on watermark
      ring-buffer: Include dropped pages in counting dirty patches
      tracing: Fix race where eprobes can be called before the event

Wang Wensheng (2):
      ftrace: Fix the possible incorrect kernel message
      ftrace: Optimize the allocation for mcount entries

Wang Yufen (1):
      tracing: Fix memory leak in tracing_read_pipe()

Xiu Jianfeng (1):
      ftrace: Fix null pointer dereference in ftrace_add_mod()

Zheng Yejian (1):
      tracing: Fix potential null-pointer-access of entry in list 'tr->err_log'

----
 include/linux/ring_buffer.h         |  2 +-
 include/linux/trace.h               |  4 +--
 kernel/trace/ftrace.c               |  5 +--
 kernel/trace/ring_buffer.c          | 71 ++++++++++++++++++++++++++-----------
 kernel/trace/synth_event_gen_test.c | 16 ++++-----
 kernel/trace/trace.c                | 12 ++++---
 kernel/trace/trace_eprobe.c         |  3 ++
 kernel/trace/trace_events_synth.c   |  5 ++-
 kernel/trace/trace_syscalls.c       |  2 --
 9 files changed, 74 insertions(+), 46 deletions(-)
---------------------------
diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index 2504df9a0453..3c7d295746f6 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -100,7 +100,7 @@ __ring_buffer_alloc(unsigned long size, unsigned flags, struct lock_class_key *k
 
 int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full);
 __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
-			  struct file *filp, poll_table *poll_table);
+			  struct file *filp, poll_table *poll_table, int full);
 void ring_buffer_wake_waiters(struct trace_buffer *buffer, int cpu);
 
 #define RING_BUFFER_ALL_CPUS -1
diff --git a/include/linux/trace.h b/include/linux/trace.h
index b5e16e438448..80ffda871749 100644
--- a/include/linux/trace.h
+++ b/include/linux/trace.h
@@ -26,13 +26,13 @@ struct trace_export {
 	int flags;
 };
 
+struct trace_array;
+
 #ifdef CONFIG_TRACING
 
 int register_ftrace_export(struct trace_export *export);
 int unregister_ftrace_export(struct trace_export *export);
 
-struct trace_array;
-
 void trace_printk_init_buffers(void);
 __printf(3, 4)
 int trace_array_printk(struct trace_array *tr, unsigned long ip,
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7dc023641bf1..33236241f236 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1289,6 +1289,7 @@ static int ftrace_add_mod(struct trace_array *tr,
 	if (!ftrace_mod)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&ftrace_mod->list);
 	ftrace_mod->func = kstrdup(func, GFP_KERNEL);
 	ftrace_mod->module = kstrdup(module, GFP_KERNEL);
 	ftrace_mod->enable = enable;
@@ -3190,7 +3191,7 @@ static int ftrace_allocate_records(struct ftrace_page *pg, int count)
 		/* if we can't allocate this size, try something smaller */
 		if (!order)
 			return -ENOMEM;
-		order >>= 1;
+		order--;
 		goto again;
 	}
 
@@ -7391,7 +7392,7 @@ void __init ftrace_init(void)
 	}
 
 	pr_info("ftrace: allocating %ld entries in %ld pages\n",
-		count, count / ENTRIES_PER_PAGE + 1);
+		count, DIV_ROUND_UP(count, ENTRIES_PER_PAGE));
 
 	ret = ftrace_process_locs(NULL,
 				  __start_mcount_loc,
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9712083832f4..b21bf14bae9b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -519,6 +519,7 @@ struct ring_buffer_per_cpu {
 	local_t				committing;
 	local_t				commits;
 	local_t				pages_touched;
+	local_t				pages_lost;
 	local_t				pages_read;
 	long				last_pages_touch;
 	size_t				shortest_full;
@@ -894,10 +895,18 @@ size_t ring_buffer_nr_pages(struct trace_buffer *buffer, int cpu)
 size_t ring_buffer_nr_dirty_pages(struct trace_buffer *buffer, int cpu)
 {
 	size_t read;
+	size_t lost;
 	size_t cnt;
 
 	read = local_read(&buffer->buffers[cpu]->pages_read);
+	lost = local_read(&buffer->buffers[cpu]->pages_lost);
 	cnt = local_read(&buffer->buffers[cpu]->pages_touched);
+
+	if (WARN_ON_ONCE(cnt < lost))
+		return 0;
+
+	cnt -= lost;
+
 	/* The reader can read an empty page, but not more than that */
 	if (cnt < read) {
 		WARN_ON_ONCE(read > cnt + 1);
@@ -907,6 +916,21 @@ size_t ring_buffer_nr_dirty_pages(struct trace_buffer *buffer, int cpu)
 	return cnt - read;
 }
 
+static __always_inline bool full_hit(struct trace_buffer *buffer, int cpu, int full)
+{
+	struct ring_buffer_per_cpu *cpu_buffer = buffer->buffers[cpu];
+	size_t nr_pages;
+	size_t dirty;
+
+	nr_pages = cpu_buffer->nr_pages;
+	if (!nr_pages || !full)
+		return true;
+
+	dirty = ring_buffer_nr_dirty_pages(buffer, cpu);
+
+	return (dirty * 100) > (full * nr_pages);
+}
+
 /*
  * rb_wake_up_waiters - wake up tasks waiting for ring buffer input
  *
@@ -1046,22 +1070,20 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
 		    !ring_buffer_empty_cpu(buffer, cpu)) {
 			unsigned long flags;
 			bool pagebusy;
-			size_t nr_pages;
-			size_t dirty;
+			bool done;
 
 			if (!full)
 				break;
 
 			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 			pagebusy = cpu_buffer->reader_page == cpu_buffer->commit_page;
-			nr_pages = cpu_buffer->nr_pages;
-			dirty = ring_buffer_nr_dirty_pages(buffer, cpu);
+			done = !pagebusy && full_hit(buffer, cpu, full);
+
 			if (!cpu_buffer->shortest_full ||
 			    cpu_buffer->shortest_full > full)
 				cpu_buffer->shortest_full = full;
 			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-			if (!pagebusy &&
-			    (!nr_pages || (dirty * 100) > full * nr_pages))
+			if (done)
 				break;
 		}
 
@@ -1087,6 +1109,7 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
  * @cpu: the cpu buffer to wait on
  * @filp: the file descriptor
  * @poll_table: The poll descriptor
+ * @full: wait until the percentage of pages are available, if @cpu != RING_BUFFER_ALL_CPUS
  *
  * If @cpu == RING_BUFFER_ALL_CPUS then the task will wake up as soon
  * as data is added to any of the @buffer's cpu buffers. Otherwise
@@ -1096,14 +1119,15 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
  * zero otherwise.
  */
 __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
-			  struct file *filp, poll_table *poll_table)
+			  struct file *filp, poll_table *poll_table, int full)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	struct rb_irq_work *work;
 
-	if (cpu == RING_BUFFER_ALL_CPUS)
+	if (cpu == RING_BUFFER_ALL_CPUS) {
 		work = &buffer->irq_work;
-	else {
+		full = 0;
+	} else {
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			return -EINVAL;
 
@@ -1111,8 +1135,14 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 		work = &cpu_buffer->irq_work;
 	}
 
-	poll_wait(filp, &work->waiters, poll_table);
-	work->waiters_pending = true;
+	if (full) {
+		poll_wait(filp, &work->full_waiters, poll_table);
+		work->full_waiters_pending = true;
+	} else {
+		poll_wait(filp, &work->waiters, poll_table);
+		work->waiters_pending = true;
+	}
+
 	/*
 	 * There's a tight race between setting the waiters_pending and
 	 * checking if the ring buffer is empty.  Once the waiters_pending bit
@@ -1128,6 +1158,9 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 	 */
 	smp_mb();
 
+	if (full)
+		return full_hit(buffer, cpu, full) ? EPOLLIN | EPOLLRDNORM : 0;
+
 	if ((cpu == RING_BUFFER_ALL_CPUS && !ring_buffer_empty(buffer)) ||
 	    (cpu != RING_BUFFER_ALL_CPUS && !ring_buffer_empty_cpu(buffer, cpu)))
 		return EPOLLIN | EPOLLRDNORM;
@@ -1769,9 +1802,9 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 
 	free_buffer_page(cpu_buffer->reader_page);
 
-	rb_head_page_deactivate(cpu_buffer);
-
 	if (head) {
+		rb_head_page_deactivate(cpu_buffer);
+
 		list_for_each_entry_safe(bpage, tmp, head, list) {
 			list_del_init(&bpage->list);
 			free_buffer_page(bpage);
@@ -2007,6 +2040,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 			 */
 			local_add(page_entries, &cpu_buffer->overrun);
 			local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
+			local_inc(&cpu_buffer->pages_lost);
 		}
 
 		/*
@@ -2491,6 +2525,7 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 		 */
 		local_add(entries, &cpu_buffer->overrun);
 		local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
+		local_inc(&cpu_buffer->pages_lost);
 
 		/*
 		 * The entries will be zeroed out when we move the
@@ -3155,10 +3190,6 @@ static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer,
 static __always_inline void
 rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 {
-	size_t nr_pages;
-	size_t dirty;
-	size_t full;
-
 	if (buffer->irq_work.waiters_pending) {
 		buffer->irq_work.waiters_pending = false;
 		/* irq_work_queue() supplies it's own memory barriers */
@@ -3182,10 +3213,7 @@ rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 
 	cpu_buffer->last_pages_touch = local_read(&cpu_buffer->pages_touched);
 
-	full = cpu_buffer->shortest_full;
-	nr_pages = cpu_buffer->nr_pages;
-	dirty = ring_buffer_nr_dirty_pages(buffer, cpu_buffer->cpu);
-	if (full && nr_pages && (dirty * 100) <= full * nr_pages)
+	if (!full_hit(buffer, cpu_buffer->cpu, cpu_buffer->shortest_full))
 		return;
 
 	cpu_buffer->irq_work.wakeup_full = true;
@@ -5248,6 +5276,7 @@ rb_reset_cpu(struct ring_buffer_per_cpu *cpu_buffer)
 	local_set(&cpu_buffer->committing, 0);
 	local_set(&cpu_buffer->commits, 0);
 	local_set(&cpu_buffer->pages_touched, 0);
+	local_set(&cpu_buffer->pages_lost, 0);
 	local_set(&cpu_buffer->pages_read, 0);
 	cpu_buffer->last_pages_touch = 0;
 	cpu_buffer->shortest_full = 0;
diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index 0b15e975d2c2..8d77526892f4 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -120,15 +120,13 @@ static int __init test_gen_synth_cmd(void)
 
 	/* Now generate a gen_synth_test event */
 	ret = synth_event_trace_array(gen_synth_test, vals, ARRAY_SIZE(vals));
- out:
+ free:
+	kfree(buf);
 	return ret;
  delete:
 	/* We got an error after creating the event, delete it */
 	synth_event_delete("gen_synth_test");
- free:
-	kfree(buf);
-
-	goto out;
+	goto free;
 }
 
 /*
@@ -227,15 +225,13 @@ static int __init test_empty_synth_event(void)
 
 	/* Now trace an empty_synth_test event */
 	ret = synth_event_trace_array(empty_synth_test, vals, ARRAY_SIZE(vals));
- out:
+ free:
+	kfree(buf);
 	return ret;
  delete:
 	/* We got an error after creating the event, delete it */
 	synth_event_delete("empty_synth_test");
- free:
-	kfree(buf);
-
-	goto out;
+	goto free;
 }
 
 static struct synth_field_desc create_synth_test_fields[] = {
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 47a44b055a1d..a7fe0e115272 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6657,6 +6657,7 @@ static int tracing_release_pipe(struct inode *inode, struct file *file)
 	mutex_unlock(&trace_types_lock);
 
 	free_cpumask_var(iter->started);
+	kfree(iter->fmt);
 	mutex_destroy(&iter->mutex);
 	kfree(iter);
 
@@ -6681,7 +6682,7 @@ trace_poll(struct trace_iterator *iter, struct file *filp, poll_table *poll_tabl
 		return EPOLLIN | EPOLLRDNORM;
 	else
 		return ring_buffer_poll_wait(iter->array_buffer->buffer, iter->cpu_file,
-					     filp, poll_table);
+					     filp, poll_table, iter->tr->buffer_percent);
 }
 
 static __poll_t
@@ -7802,6 +7803,7 @@ static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr,
 						   int len)
 {
 	struct tracing_log_err *err;
+	char *cmd;
 
 	if (tr->n_err_log_entries < TRACING_LOG_ERRS_MAX) {
 		err = alloc_tracing_log_err(len);
@@ -7810,12 +7812,12 @@ static struct tracing_log_err *get_tracing_log_err(struct trace_array *tr,
 
 		return err;
 	}
-
+	cmd = kzalloc(len, GFP_KERNEL);
+	if (!cmd)
+		return ERR_PTR(-ENOMEM);
 	err = list_first_entry(&tr->err_log, struct tracing_log_err, list);
 	kfree(err->cmd);
-	err->cmd = kzalloc(len, GFP_KERNEL);
-	if (!err->cmd)
-		return ERR_PTR(-ENOMEM);
+	err->cmd = cmd;
 	list_del(&err->list);
 
 	return err;
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 5dd0617e5df6..9cda9a38422c 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -563,6 +563,9 @@ static void eprobe_trigger_func(struct event_trigger_data *data,
 {
 	struct eprobe_data *edata = data->private_data;
 
+	if (unlikely(!rec))
+		return;
+
 	__eprobe_trace_func(edata, rec);
 }
 
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e310052dc83c..29fbfb27c2b2 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -828,10 +828,9 @@ static int register_synth_event(struct synth_event *event)
 	}
 
 	ret = set_synth_event_print_fmt(call);
-	if (ret < 0) {
+	/* unregister_trace_event() will be called inside */
+	if (ret < 0)
 		trace_remove_event_call(call);
-		goto err;
-	}
  out:
 	return ret;
  err:
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index b69e207012c9..942ddbdace4a 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -201,8 +201,6 @@ print_syscall_exit(struct trace_iterator *iter, int flags,
 	return trace_handle_return(s);
 }
 
-extern char *__bad_type_size(void);
-
 #define SYSCALL_FIELD(_type, _name) {					\
 	.type = #_type, .name = #_name,					\
 	.size = sizeof(_type), .align = __alignof__(_type),		\
