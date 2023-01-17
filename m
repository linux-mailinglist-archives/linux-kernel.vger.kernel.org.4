Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB05966D56A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 05:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjAQEl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 23:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbjAQElL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 23:41:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FA81A4AE;
        Mon, 16 Jan 2023 20:41:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09501611B3;
        Tue, 17 Jan 2023 04:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D1CC43398;
        Tue, 17 Jan 2023 04:41:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pHdmP-001rse-0o;
        Mon, 16 Jan 2023 23:41:01 -0500
Message-ID: <20230117044101.111658742@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 16 Jan 2023 23:40:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH 3/5] tracing: Allow synthetic events to pass around stacktraces
References: <20230117044010.838685230@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Allow a stacktrace from one event to be displayed by the end event of a
synthetic event. This is very useful when looking for the longest latency
of a sleep or something blocked on I/O.

 # cd /sys/kernel/tracing/
 # echo 's:block_lat pid_t pid; u64 delta; unsigned long[] stack;' > dynamic_events
 # echo 'hist:keys=next_pid:ts=common_timestamp.usecs,st=stacktrace  if prev_state == 1||prev_state == 2' > events/sched/sched_switch/trigger
 # echo 'hist:keys=prev_pid:delta=common_timestamp.usecs-$ts,s=$st:onmax($delta).trace(block_lat,prev_pid,$delta,$s)' >> events/sched/sched_switch/trigger

The above creates a "block_lat" synthetic event that take the stacktrace of
when a task schedules out in either the interruptible or uninterruptible
states, and on a new per process max $delta (the time it was scheduled
out), will print the process id and the stacktrace.

  # echo 1 > events/synthetic/block_lat/enable
  # cat trace
 #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
 #              | |         |   |||||     |         |
    kworker/u16:0-767     [006] d..4.   560.645045: block_lat: pid=767 delta=66 stack=STACK:
 => __schedule
 => schedule
 => pipe_read
 => vfs_read
 => ksys_read
 => do_syscall_64
 => 0x966000aa

           <idle>-0       [003] d..4.   561.132117: block_lat: pid=0 delta=413787 stack=STACK:
 => __schedule
 => schedule
 => schedule_hrtimeout_range_clock
 => do_sys_poll
 => __x64_sys_poll
 => do_syscall_64
 => 0x966000aa

            <...>-153     [006] d..4.   562.068407: block_lat: pid=153 delta=54 stack=STACK:
 => __schedule
 => schedule
 => io_schedule
 => rq_qos_wait
 => wbt_wait
 => __rq_qos_throttle
 => blk_mq_submit_bio
 => submit_bio_noacct_nocheck
 => ext4_bio_write_page
 => mpage_submit_page
 => mpage_process_page_bufs
 => mpage_prepare_extent_to_map
 => ext4_do_writepages
 => ext4_writepages
 => do_writepages
 => __writeback_single_inode

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h              |  4 ++
 kernel/trace/trace_events_hist.c  |  7 ++-
 kernel/trace/trace_events_synth.c | 80 ++++++++++++++++++++++++++++++-
 kernel/trace/trace_synth.h        |  1 +
 4 files changed, 87 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a56b0b7d23ef..28294f6e15b9 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -113,6 +113,10 @@ enum trace_type {
 #define MEM_FAIL(condition, fmt, ...)					\
 	DO_ONCE_LITE_IF(condition, pr_err, "ERROR: " fmt, ##__VA_ARGS__)
 
+#define HIST_STACKTRACE_DEPTH	16
+#define HIST_STACKTRACE_SIZE	(HIST_STACKTRACE_DEPTH * sizeof(unsigned long))
+#define HIST_STACKTRACE_SKIP	5
+
 /*
  * syscalls are special, and need special handling, this is why
  * they are not included in trace_entries.h
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5cc7873983ee..d88c8e798ea4 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -480,10 +480,6 @@ DEFINE_HIST_FIELD_FN(u8);
 #define for_each_hist_key_field(i, hist_data)	\
 	for ((i) = (hist_data)->n_vals; (i) < (hist_data)->n_fields; (i)++)
 
-#define HIST_STACKTRACE_DEPTH	16
-#define HIST_STACKTRACE_SIZE	(HIST_STACKTRACE_DEPTH * sizeof(unsigned long))
-#define HIST_STACKTRACE_SKIP	5
-
 #define HITCOUNT_IDX		0
 #define HIST_KEY_SIZE_MAX	(MAX_FILTER_STR_VAL + HIST_STACKTRACE_SIZE)
 
@@ -3856,6 +3852,9 @@ static int check_synth_field(struct synth_event *event,
 	    && field->is_dynamic)
 		return 0;
 
+	if (strstr(hist_field->type, "long[") && field->is_stack)
+		return 0;
+
 	if (strcmp(field->type, hist_field->type) != 0) {
 		if (field->size != hist_field->size ||
 		    (!field->is_string && field->is_signed != hist_field->is_signed))
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 9f79cd689b79..1cfba626ea1e 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -173,6 +173,14 @@ static int synth_field_is_string(char *type)
 	return false;
 }
 
+static int synth_field_is_stack(char *type)
+{
+	if (strstr(type, "long[") != NULL)
+		return true;
+
+	return false;
+}
+
 static int synth_field_string_size(char *type)
 {
 	char buf[4], *end, *start;
@@ -248,6 +256,8 @@ static int synth_field_size(char *type)
 		size = sizeof(gfp_t);
 	else if (synth_field_is_string(type))
 		size = synth_field_string_size(type);
+	else if (synth_field_is_stack(type))
+		size = 0;
 
 	return size;
 }
@@ -292,6 +302,8 @@ static const char *synth_field_fmt(char *type)
 		fmt = "%x";
 	else if (synth_field_is_string(type))
 		fmt = "%.*s";
+	else if (synth_field_is_stack(type))
+		fmt = "%s";
 
 	return fmt;
 }
@@ -371,6 +383,23 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 			}
+		} else if (se->fields[i]->is_stack) {
+			u32 offset, data_offset, len;
+			unsigned long *p, *end;
+
+			offset = (u32)entry->fields[n_u64];
+			data_offset = offset & 0xffff;
+			len = offset >> 16;
+
+			p = (void *)entry + data_offset;
+			end = (void *)p + len - (sizeof(long) - 1);
+
+			trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
+
+			for (; *p && p < end; p++)
+				trace_seq_printf(s, "=> %pS\n", (void *)*p);
+			n_u64++;
+
 		} else {
 			struct trace_print_flags __flags[] = {
 			    __def_gfpflag_names, {-1, NULL} };
@@ -446,6 +475,43 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 	return len;
 }
 
+static unsigned int trace_stack(struct synth_trace_event *entry,
+				 struct synth_event *event,
+				 long *stack,
+				 unsigned int data_size,
+				 unsigned int *n_u64)
+{
+	unsigned int len;
+	u32 data_offset;
+	void *data_loc;
+
+	data_offset = struct_size(entry, fields, event->n_u64);
+	data_offset += data_size;
+
+	for (len = 0; len < HIST_STACKTRACE_DEPTH; len++) {
+		if (!stack[len])
+			break;
+	}
+
+	/* Include the zero'd element if it fits */
+	if (len < HIST_STACKTRACE_DEPTH)
+		len++;
+
+	len *= sizeof(long);
+
+	/* Find the dynamic section to copy the stack into. */
+	data_loc = (void *)entry + data_offset;
+	memcpy(data_loc, stack, len);
+
+	/* Fill in the field that holds the offset/len combo */
+	data_offset |= len << 16;
+	*(u32 *)&entry->fields[*n_u64] = data_offset;
+
+	(*n_u64)++;
+
+	return len;
+}
+
 static notrace void trace_event_raw_event_synth(void *__data,
 						u64 *var_ref_vals,
 						unsigned int *var_ref_idx)
@@ -498,6 +564,12 @@ static notrace void trace_event_raw_event_synth(void *__data,
 					   event->fields[i]->is_dynamic,
 					   data_size, &n_u64);
 			data_size += len; /* only dynamic string increments */
+		} if (event->fields[i]->is_stack) {
+		        long *stack = (long *)var_ref_vals[val_idx];
+
+			len = trace_stack(entry, event, stack,
+					   data_size, &n_u64);
+			data_size += len;
 		} else {
 			struct synth_field *field = event->fields[i];
 			u64 val = var_ref_vals[val_idx];
@@ -560,6 +632,9 @@ static int __set_synth_event_print_fmt(struct synth_event *event,
 		    event->fields[i]->is_dynamic)
 			pos += snprintf(buf + pos, LEN_OR_ZERO,
 				", __get_str(%s)", event->fields[i]->name);
+		else if (event->fields[i]->is_stack)
+			pos += snprintf(buf + pos, LEN_OR_ZERO,
+				", __get_stacktrace(%s)", event->fields[i]->name);
 		else
 			pos += snprintf(buf + pos, LEN_OR_ZERO,
 					", REC->%s", event->fields[i]->name);
@@ -696,7 +771,8 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 		ret = -EINVAL;
 		goto free;
 	} else if (size == 0) {
-		if (synth_field_is_string(field->type)) {
+		if (synth_field_is_string(field->type) ||
+		    synth_field_is_stack(field->type)) {
 			char *type;
 
 			len = sizeof("__data_loc ") + strlen(field->type) + 1;
@@ -727,6 +803,8 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
 
 	if (synth_field_is_string(field->type))
 		field->is_string = true;
+	else if (synth_field_is_stack(field->type))
+		field->is_stack = true;
 
 	field->is_signed = synth_field_signed(field->type);
  out:
diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
index b29595fe3ac5..43f6fb6078db 100644
--- a/kernel/trace/trace_synth.h
+++ b/kernel/trace/trace_synth.h
@@ -18,6 +18,7 @@ struct synth_field {
 	bool is_signed;
 	bool is_string;
 	bool is_dynamic;
+	bool is_stack;
 };
 
 struct synth_event {
-- 
2.39.0


