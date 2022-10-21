Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84F6606E37
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 05:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJUDOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 23:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbiJUDOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:14:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF43B85C;
        Thu, 20 Oct 2022 20:14:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AC3CB828B5;
        Fri, 21 Oct 2022 03:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790D6C433D6;
        Fri, 21 Oct 2022 03:14:22 +0000 (UTC)
Date:   Thu, 20 Oct 2022 23:14:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Primiano Tucci <primiano@google.com>
Subject: [PATCH] tracing/ring-buffer: Have polling block on watermark
Message-ID: <20221020231427.41be3f26@gandalf.local.home>
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Currently the way polling works on the ring buffer is broken. It will
return immediately if there's any data in the ring buffer whereas a read
will block until the watermark (defined by the tracefs buffer_percent file)
is hit.

That is, a select() or poll() will return as if there's data available,
but then the following read will block. This is broken for the way
select()s and poll()s are supposed to work.

Have the polling on the ring buffer also block the same way reads and
splice does on the ring buffer.

Cc: stable@vger.kernel.org
Fixes: 1e0d6714aceb7 ("ring-buffer: Do not wake up a splice waiter when page is not full")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  2 +-
 kernel/trace/ring_buffer.c  | 55 ++++++++++++++++++++++++-------------
 kernel/trace/trace.c        |  2 +-
 3 files changed, 38 insertions(+), 21 deletions(-)

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
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 199759c73519..b60047de897e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -907,6 +907,21 @@ size_t ring_buffer_nr_dirty_pages(struct trace_buffer *buffer, int cpu)
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
@@ -1035,22 +1050,20 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
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
 
@@ -1076,6 +1089,7 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
  * @cpu: the cpu buffer to wait on
  * @filp: the file descriptor
  * @poll_table: The poll descriptor
+ * @full: wait until the percentage of pages are available, if @cpu != RING_BUFFER_ALL_CPUS
  *
  * If @cpu == RING_BUFFER_ALL_CPUS then the task will wake up as soon
  * as data is added to any of the @buffer's cpu buffers. Otherwise
@@ -1085,14 +1099,15 @@ int ring_buffer_wait(struct trace_buffer *buffer, int cpu, int full)
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
 
@@ -1100,8 +1115,14 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
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
@@ -1117,6 +1138,9 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 	 */
 	smp_mb();
 
+	if (full)
+		return full_hit(buffer, cpu, full) ? EPOLLIN | EPOLLRDNORM : 0;
+
 	if ((cpu == RING_BUFFER_ALL_CPUS && !ring_buffer_empty(buffer)) ||
 	    (cpu != RING_BUFFER_ALL_CPUS && !ring_buffer_empty_cpu(buffer, cpu)))
 		return EPOLLIN | EPOLLRDNORM;
@@ -3144,10 +3168,6 @@ static void rb_commit(struct ring_buffer_per_cpu *cpu_buffer,
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
@@ -3171,10 +3191,7 @@ rb_wakeups(struct trace_buffer *buffer, struct ring_buffer_per_cpu *cpu_buffer)
 
 	cpu_buffer->last_pages_touch = local_read(&cpu_buffer->pages_touched);
 
-	full = cpu_buffer->shortest_full;
-	nr_pages = cpu_buffer->nr_pages;
-	dirty = ring_buffer_nr_dirty_pages(buffer, cpu_buffer->cpu);
-	if (full && nr_pages && (dirty * 100) <= full * nr_pages)
+	if (!full_hit(buffer, cpu_buffer->cpu, cpu_buffer->shortest_full))
 		return;
 
 	cpu_buffer->irq_work.wakeup_full = true;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 47a44b055a1d..c6c7a0af3ed2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6681,7 +6681,7 @@ trace_poll(struct trace_iterator *iter, struct file *filp, poll_table *poll_tabl
 		return EPOLLIN | EPOLLRDNORM;
 	else
 		return ring_buffer_poll_wait(iter->array_buffer->buffer, iter->cpu_file,
-					     filp, poll_table);
+					     filp, poll_table, iter->tr->buffer_percent);
 }
 
 static __poll_t
-- 
2.35.1

