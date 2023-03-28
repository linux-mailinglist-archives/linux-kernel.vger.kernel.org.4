Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814606CCA46
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 20:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjC1SwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 14:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjC1SwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 14:52:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64AE26A5;
        Tue, 28 Mar 2023 11:52:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5291AB81E46;
        Tue, 28 Mar 2023 18:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCE4C433EF;
        Tue, 28 Mar 2023 18:51:58 +0000 (UTC)
Date:   Tue, 28 Mar 2023 14:51:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [PATCH] tracing: Add "fields" option to show raw trace event fields
Message-ID: <20230328145156.497651be@gandalf.local.home>
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

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The hex, raw and bin formats come from the old PREEMPT_RT patch set
latency tracer. That actually gave real alternatives to reading the ascii
buffer. But they have started to bit rot and they do not give a good
representation of the tracing data.

Add "fields" option that will read the trace event fields and parse the
data from how the fields are defined:

With "fields" = 0 (default)

 echo 1 > events/sched/sched_switch/enable
 cat trace
         <idle>-0       [003] d..2.   540.078653: sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/3:1 next_pid=83 next_prio=120
     kworker/3:1-83      [003] d..2.   540.078860: sched_switch: prev_comm=kworker/3:1 prev_pid=83 prev_prio=120 prev_state=I ==> next_comm=swapper/3 next_pid=0 next_prio=120
          <idle>-0       [003] d..2.   540.206423: sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=sshd next_pid=807 next_prio=120
            sshd-807     [003] d..2.   540.206531: sched_switch: prev_comm=sshd prev_pid=807 prev_prio=120 prev_state=S ==> next_comm=swapper/3 next_pid=0 next_prio=120
          <idle>-0       [001] d..2.   540.206597: sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/u16:4 next_pid=58 next_prio=120
   kworker/u16:4-58      [001] d..2.   540.206617: sched_switch: prev_comm=kworker/u16:4 prev_pid=58 prev_prio=120 prev_state=I ==> next_comm=bash next_pid=830 next_prio=120
            bash-830     [001] d..2.   540.206678: sched_switch: prev_comm=bash prev_pid=830 prev_prio=120 prev_state=R ==> next_comm=kworker/u16:4 next_pid=58 next_prio=120
   kworker/u16:4-58      [001] d..2.   540.206696: sched_switch: prev_comm=kworker/u16:4 prev_pid=58 prev_prio=120 prev_state=I ==> next_comm=bash next_pid=830 next_prio=120
            bash-830     [001] d..2.   540.206713: sched_switch: prev_comm=bash prev_pid=830 prev_prio=120 prev_state=R ==> next_comm=kworker/u16:4 next_pid=58 next_prio=120

 echo 1 > options/fields
           <...>-998     [002] d..2.   538.643732: sched_switch: next_prio=0x78 (120) next_pid=0x0 (0) next_comm=swapper/2 prev_state=0x20 (32) prev_prio=0x78 (120) prev_pid=0x3e6 (998) prev_comm=trace-cmd
          <idle>-0       [001] d..2.   538.643806: sched_switch: next_prio=0x78 (120) next_pid=0x33e (830) next_comm=bash prev_state=0x0 (0) prev_prio=0x78 (120) prev_pid=0x0 (0) prev_comm=swapper/1
            bash-830     [001] d..2.   538.644106: sched_switch: next_prio=0x78 (120) next_pid=0x3a (58) next_comm=kworker/u16:4 prev_state=0x0 (0) prev_prio=0x78 (120) prev_pid=0x33e (830) prev_comm=bash
   kworker/u16:4-58      [001] d..2.   538.644130: sched_switch: next_prio=0x78 (120) next_pid=0x33e (830) next_comm=bash prev_state=0x80 (128) prev_prio=0x78 (120) prev_pid=0x3a (58) prev_comm=kworker/u16:4
            bash-830     [001] d..2.   538.644180: sched_switch: next_prio=0x78 (120) next_pid=0x3a (58) next_comm=kworker/u16:4 prev_state=0x0 (0) prev_prio=0x78 (120) prev_pid=0x33e (830) prev_comm=bash
   kworker/u16:4-58      [001] d..2.   538.644185: sched_switch: next_prio=0x78 (120) next_pid=0x33e (830) next_comm=bash prev_state=0x80 (128) prev_prio=0x78 (120) prev_pid=0x3a (58) prev_comm=kworker/u16:4
            bash-830     [001] d..2.   538.644204: sched_switch: next_prio=0x78 (120) next_pid=0x0 (0) next_comm=swapper/1 prev_state=0x1 (1) prev_prio=0x78 (120) prev_pid=0x33e (830) prev_comm=bash
          <idle>-0       [003] d..2.   538.644211: sched_switch: next_prio=0x78 (120) next_pid=0x327 (807) next_comm=sshd prev_state=0x0 (0) prev_prio=0x78 (120) prev_pid=0x0 (0) prev_comm=swapper/3
            sshd-807     [003] d..2.   538.644340: sched_switch: next_prio=0x78 (120) next_pid=0x0 (0) next_comm=swapper/3 prev_state=0x1 (1) prev_prio=0x78 (120) prev_pid=0x327 (807) prev_comm=sshd

It traces the data safely without using the trace print formatting.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst |   6 ++
 kernel/trace/trace.c           |   7 +-
 kernel/trace/trace.h           |   2 +
 kernel/trace/trace_output.c    | 168 +++++++++++++++++++++++++++++++++
 kernel/trace/trace_output.h    |   2 +
 5 files changed, 183 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index b927fb2b94dc..aaebb821912e 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1027,6 +1027,7 @@ To see what is available, simply cat the file::
 	nohex
 	nobin
 	noblock
+	nofields
 	trace_printk
 	annotate
 	nouserstacktrace
@@ -1110,6 +1111,11 @@ Here are the available options:
   block
 	When set, reading trace_pipe will not block when polled.
 
+  fields
+	Print the fields as described by their types. This is a better
+	option than using hex, bin or raw, as it gives a better parsing
+	of the content of the event.
+
   trace_printk
 	Can disable trace_printk() from writing into the buffer.
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 937e9676dfd4..076d893d2965 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3726,7 +3726,7 @@ __find_next_entry(struct trace_iterator *iter, int *ent_cpu,
 #define STATIC_FMT_BUF_SIZE	128
 static char static_fmt_buf[STATIC_FMT_BUF_SIZE];
 
-static char *trace_iter_expand_format(struct trace_iterator *iter)
+char *trace_iter_expand_format(struct trace_iterator *iter)
 {
 	char *tmp;
 
@@ -4446,8 +4446,11 @@ static enum print_line_t print_trace_fmt(struct trace_iterator *iter)
 	if (trace_seq_has_overflowed(s))
 		return TRACE_TYPE_PARTIAL_LINE;
 
-	if (event)
+	if (event) {
+		if (tr->trace_flags & TRACE_ITER_FIELDS)
+			return print_event_fields(iter, event);
 		return event->funcs->trace(iter, sym_flags, event);
+	}
 
 	trace_seq_printf(s, "Unknown type %d\n", entry->type);
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 616e1aa1c4da..79bdefe9261b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -619,6 +619,7 @@ bool trace_is_tracepoint_string(const char *str);
 const char *trace_event_format(struct trace_iterator *iter, const char *fmt);
 void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 			 va_list ap) __printf(2, 0);
+char *trace_iter_expand_format(struct trace_iterator *iter);
 
 int trace_empty(struct trace_iterator *iter);
 
@@ -1199,6 +1200,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(HEX,			"hex"),			\
 		C(BIN,			"bin"),			\
 		C(BLOCK,		"block"),		\
+		C(FIELDS,		"fields"),		\
 		C(PRINTK,		"trace_printk"),	\
 		C(ANNOTATE,		"annotate"),		\
 		C(USERSTACKTRACE,	"userstacktrace"),	\
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index bd475a00f96d..780c6971c944 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -808,6 +808,174 @@ EXPORT_SYMBOL_GPL(unregister_trace_event);
  * Standard events
  */
 
+static void print_array(struct trace_iterator *iter, void *pos,
+			struct ftrace_event_field *field)
+{
+	int offset;
+	int len;
+	int i;
+
+	offset = *(int *)pos & 0xffff;
+	len = *(int *)pos >> 16;
+
+	if (field)
+		offset += field->offset;
+
+	if (offset + len >= iter->ent_size) {
+		trace_seq_puts(&iter->seq, "<OVERFLOW>");
+		return;
+	}
+
+	for (i = 0; i < len; i++, pos++) {
+		if (i)
+			trace_seq_putc(&iter->seq, ',');
+		trace_seq_printf(&iter->seq, "%02x", *(unsigned char *)pos);
+	}
+}
+
+static void print_fields(struct trace_iterator *iter, struct trace_event_call *call,
+			 struct list_head *head)
+{
+	struct ftrace_event_field *field;
+	int offset;
+	int len;
+	int ret;
+	void *pos;
+
+	list_for_each_entry(field, head, link) {
+		trace_seq_printf(&iter->seq, " %s=", field->name);
+		if (field->offset + field->size > iter->ent_size) {
+			trace_seq_puts(&iter->seq, "<OVERFLOW>");
+			continue;
+		}
+		pos = (void *)iter->ent + field->offset;
+
+		switch (field->filter_type) {
+		case FILTER_COMM:
+		case FILTER_STATIC_STRING:
+			trace_seq_printf(&iter->seq, "%.*s", field->size, (char *)pos);
+			break;
+		case FILTER_RDYN_STRING:
+		case FILTER_DYN_STRING:
+			offset = *(int *)pos & 0xffff;
+			len = *(int *)pos >> 16;
+
+			if (field->filter_type == FILTER_RDYN_STRING)
+				offset += field->offset;
+
+			if (offset + len >= iter->ent_size) {
+				trace_seq_puts(&iter->seq, "<OVERFLOW>");
+				break;
+			}
+			pos = (void *)iter->ent + offset;
+			trace_seq_printf(&iter->seq, "%.*s", len, (char *)pos);
+			break;
+		case FILTER_PTR_STRING:
+			if (!iter->fmt_size)
+				trace_iter_expand_format(iter);
+			pos = *(void **)pos;
+			ret = strncpy_from_kernel_nofault(iter->fmt, pos,
+							  iter->fmt_size);
+			if (ret < 0)
+				trace_seq_printf(&iter->seq, "(0x%px)", pos);
+			else
+				trace_seq_printf(&iter->seq, "(0x%px:%s)",
+						 pos, iter->fmt);
+			break;
+		case FILTER_TRACE_FN:
+			pos = *(void **)pos;
+			trace_seq_printf(&iter->seq, "%pS", pos);
+			break;
+		case FILTER_CPU:
+		case FILTER_OTHER:
+			switch (field->size) {
+			case 1:
+				if (isprint(*(char *)pos)) {
+					trace_seq_printf(&iter->seq, "'%c'",
+						 *(unsigned char *)pos);
+				}
+				trace_seq_printf(&iter->seq, "(%d)",
+						 *(unsigned char *)pos);
+				break;
+			case 2:
+				trace_seq_printf(&iter->seq, "0x%x (%d)",
+						 *(unsigned short *)pos,
+						 *(unsigned short *)pos);
+				break;
+			case 4:
+				/* dynamic array info is 4 bytes */
+				if (strstr(field->type, "__data_loc")) {
+					print_array(iter, pos, NULL);
+					break;
+				}
+
+				if (strstr(field->type, "__rel_loc")) {
+					print_array(iter, pos, field);
+					break;
+				}
+
+				trace_seq_printf(&iter->seq, "0x%x (%d)",
+						 *(unsigned int *)pos,
+						 *(unsigned int *)pos);
+				break;
+			case 8:
+				trace_seq_printf(&iter->seq, "0x%llx (%lld)",
+						 *(unsigned long long *)pos,
+						 *(unsigned long long *)pos);
+				break;
+			default:
+				trace_seq_puts(&iter->seq, "<INVALID-SIZE>");
+				break;
+			}
+			break;
+		default:
+			trace_seq_puts(&iter->seq, "<INVALID-TYPE>");
+		}
+	}
+	trace_seq_putc(&iter->seq, '\n');
+}
+
+enum print_line_t print_event_fields(struct trace_iterator *iter,
+				     struct trace_event *event)
+{
+	struct trace_event_call *call;
+	struct list_head *head;
+
+	/* ftrace defined events have separate call structures */
+	if (event->type <= __TRACE_LAST_TYPE) {
+		bool found = false;
+
+		down_read(&trace_event_sem);
+		list_for_each_entry(call, &ftrace_events, list) {
+			if (call->event.type == event->type) {
+				found = true;
+				break;
+			}
+			/* No need to search all events */
+			if (call->event.type > __TRACE_LAST_TYPE)
+				break;
+		}
+		up_read(&trace_event_sem);
+		if (!found) {
+			trace_seq_printf(&iter->seq, "UNKNOWN TYPE %d\n", event->type);
+			goto out;
+		}
+	} else {
+		call = container_of(event, struct trace_event_call, event);
+	}
+	head = trace_get_fields(call);
+
+	trace_seq_printf(&iter->seq, "%s:", trace_event_name(call));
+
+	if (head && !list_empty(head))
+		print_fields(iter, call, head);
+	else
+		trace_seq_puts(&iter->seq, "No fields found\n");
+
+ out:
+	return trace_handle_return(&iter->seq);
+}
+
 enum print_line_t trace_nop_print(struct trace_iterator *iter, int flags,
 				  struct trace_event *event)
 {
diff --git a/kernel/trace/trace_output.h b/kernel/trace/trace_output.h
index 4c954636caf0..dca40f1f1da4 100644
--- a/kernel/trace/trace_output.h
+++ b/kernel/trace/trace_output.h
@@ -19,6 +19,8 @@ seq_print_ip_sym(struct trace_seq *s, unsigned long ip,
 extern void trace_seq_print_sym(struct trace_seq *s, unsigned long address, bool offset);
 extern int trace_print_context(struct trace_iterator *iter);
 extern int trace_print_lat_context(struct trace_iterator *iter);
+extern enum print_line_t print_event_fields(struct trace_iterator *iter,
+					    struct trace_event *event);
 
 extern void trace_event_read_lock(void);
 extern void trace_event_read_unlock(void);
-- 
2.39.1

