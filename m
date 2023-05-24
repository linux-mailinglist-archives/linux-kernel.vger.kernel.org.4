Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54DE70EB50
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbjEXCZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjEXCZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:25:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B1E1A6;
        Tue, 23 May 2023 19:25:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C67EF6327C;
        Wed, 24 May 2023 02:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9677DC433EF;
        Wed, 24 May 2023 02:25:10 +0000 (UTC)
Date:   Tue, 23 May 2023 22:24:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] tracing: Rename stacktrace field to common_stacktrace
Message-ID: <20230523222458.16c5d9db@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The histogram and synthetic events can use a pseudo event called
"stacktrace" that will create a stacktrace at the time of the event and
use it just like it was a normal field. We have other pseudo events such
as "common_cpu" and "common_timestamp". To stay consistent with that,
convert "stacktrace" to "common_stacktrace". As this was used in older
kernels, to keep backward compatibility, this will act just like
"common_cpu" did with "cpu". That is, "cpu" will be the same as
"common_cpu" unless the event has a "cpu" field. In which case, the
event's field is used. The same is true with "stacktrace".

Also update the documentation to reflect this change.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/histogram.rst | 64 +++++++++++++++----------------
 include/linux/trace_events.h      |  1 +
 kernel/trace/trace_events.c       |  2 +
 kernel/trace/trace_events_hist.c  | 16 +++++---
 4 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 479c9eac6335..3c9b263de9c2 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -35,7 +35,7 @@ Documentation written by Tom Zanussi
   in place of an explicit value field - this is simply a count of
   event hits.  If 'values' isn't specified, an implicit 'hitcount'
   value will be automatically created and used as the only value.
-  Keys can be any field, or the special string 'stacktrace', which
+  Keys can be any field, or the special string 'common_stacktrace', which
   will use the event's kernel stacktrace as the key.  The keywords
   'keys' or 'key' can be used to specify keys, and the keywords
   'values', 'vals', or 'val' can be used to specify values.  Compound
@@ -54,7 +54,7 @@ Documentation written by Tom Zanussi
   'compatible' if the fields named in the trigger share the same
   number and type of fields and those fields also have the same names.
   Note that any two events always share the compatible 'hitcount' and
-  'stacktrace' fields and can therefore be combined using those
+  'common_stacktrace' fields and can therefore be combined using those
   fields, however pointless that may be.
 
   'hist' triggers add a 'hist' file to each event's subdirectory.
@@ -547,9 +547,9 @@ Extended error information
   the hist trigger display symbolic call_sites, we can have the hist
   trigger additionally display the complete set of kernel stack traces
   that led to each call_site.  To do that, we simply use the special
-  value 'stacktrace' for the key parameter::
+  value 'common_stacktrace' for the key parameter::
 
-    # echo 'hist:keys=stacktrace:values=bytes_req,bytes_alloc:sort=bytes_alloc' > \
+    # echo 'hist:keys=common_stacktrace:values=bytes_req,bytes_alloc:sort=bytes_alloc' > \
            /sys/kernel/tracing/events/kmem/kmalloc/trigger
 
   The above trigger will use the kernel stack trace in effect when an
@@ -561,9 +561,9 @@ Extended error information
   every callpath to a kmalloc for a kernel compile)::
 
     # cat /sys/kernel/tracing/events/kmem/kmalloc/hist
-    # trigger info: hist:keys=stacktrace:vals=bytes_req,bytes_alloc:sort=bytes_alloc:size=2048 [active]
+    # trigger info: hist:keys=common_stacktrace:vals=bytes_req,bytes_alloc:sort=bytes_alloc:size=2048 [active]
 
-    { stacktrace:
+    { common_stacktrace:
          __kmalloc_track_caller+0x10b/0x1a0
          kmemdup+0x20/0x50
          hidraw_report_event+0x8a/0x120 [hid]
@@ -581,7 +581,7 @@ Extended error information
          cpu_startup_entry+0x315/0x3e0
          rest_init+0x7c/0x80
     } hitcount:          3  bytes_req:         21  bytes_alloc:         24
-    { stacktrace:
+    { common_stacktrace:
          __kmalloc_track_caller+0x10b/0x1a0
          kmemdup+0x20/0x50
          hidraw_report_event+0x8a/0x120 [hid]
@@ -596,7 +596,7 @@ Extended error information
          do_IRQ+0x5a/0xf0
          ret_from_intr+0x0/0x30
     } hitcount:          3  bytes_req:         21  bytes_alloc:         24
-    { stacktrace:
+    { common_stacktrace:
          kmem_cache_alloc_trace+0xeb/0x150
          aa_alloc_task_context+0x27/0x40
          apparmor_cred_prepare+0x1f/0x50
@@ -608,7 +608,7 @@ Extended error information
     .
     .
     .
-    { stacktrace:
+    { common_stacktrace:
          __kmalloc+0x11b/0x1b0
          i915_gem_execbuffer2+0x6c/0x2c0 [i915]
          drm_ioctl+0x349/0x670 [drm]
@@ -616,7 +616,7 @@ Extended error information
          SyS_ioctl+0x81/0xa0
          system_call_fastpath+0x12/0x6a
     } hitcount:      17726  bytes_req:   13944120  bytes_alloc:   19593808
-    { stacktrace:
+    { common_stacktrace:
          __kmalloc+0x11b/0x1b0
          load_elf_phdrs+0x76/0xa0
          load_elf_binary+0x102/0x1650
@@ -625,7 +625,7 @@ Extended error information
          SyS_execve+0x3a/0x50
          return_from_execve+0x0/0x23
     } hitcount:      33348  bytes_req:   17152128  bytes_alloc:   20226048
-    { stacktrace:
+    { common_stacktrace:
          kmem_cache_alloc_trace+0xeb/0x150
          apparmor_file_alloc_security+0x27/0x40
          security_file_alloc+0x16/0x20
@@ -636,7 +636,7 @@ Extended error information
          SyS_open+0x1e/0x20
          system_call_fastpath+0x12/0x6a
     } hitcount:    4766422  bytes_req:    9532844  bytes_alloc:   38131376
-    { stacktrace:
+    { common_stacktrace:
          __kmalloc+0x11b/0x1b0
          seq_buf_alloc+0x1b/0x50
          seq_read+0x2cc/0x370
@@ -1026,7 +1026,7 @@ Extended error information
   First we set up an initially paused stacktrace trigger on the
   netif_receive_skb event::
 
-    # echo 'hist:key=stacktrace:vals=len:pause' > \
+    # echo 'hist:key=common_stacktrace:vals=len:pause' > \
            /sys/kernel/tracing/events/net/netif_receive_skb/trigger
 
   Next, we set up an 'enable_hist' trigger on the sched_process_exec
@@ -1060,9 +1060,9 @@ Extended error information
     $ wget https://www.kernel.org/pub/linux/kernel/v3.x/patch-3.19.xz
 
     # cat /sys/kernel/tracing/events/net/netif_receive_skb/hist
-    # trigger info: hist:keys=stacktrace:vals=len:sort=hitcount:size=2048 [paused]
+    # trigger info: hist:keys=common_stacktrace:vals=len:sort=hitcount:size=2048 [paused]
 
-    { stacktrace:
+    { common_stacktrace:
          __netif_receive_skb_core+0x46d/0x990
          __netif_receive_skb+0x18/0x60
          netif_receive_skb_internal+0x23/0x90
@@ -1079,7 +1079,7 @@ Extended error information
          kthread+0xd2/0xf0
          ret_from_fork+0x42/0x70
     } hitcount:         85  len:      28884
-    { stacktrace:
+    { common_stacktrace:
          __netif_receive_skb_core+0x46d/0x990
          __netif_receive_skb+0x18/0x60
          netif_receive_skb_internal+0x23/0x90
@@ -1097,7 +1097,7 @@ Extended error information
          irq_thread+0x11f/0x150
          kthread+0xd2/0xf0
     } hitcount:         98  len:     664329
-    { stacktrace:
+    { common_stacktrace:
          __netif_receive_skb_core+0x46d/0x990
          __netif_receive_skb+0x18/0x60
          process_backlog+0xa8/0x150
@@ -1115,7 +1115,7 @@ Extended error information
          inet_sendmsg+0x64/0xa0
          sock_sendmsg+0x3d/0x50
     } hitcount:        115  len:      13030
-    { stacktrace:
+    { common_stacktrace:
          __netif_receive_skb_core+0x46d/0x990
          __netif_receive_skb+0x18/0x60
          netif_receive_skb_internal+0x23/0x90
@@ -1142,14 +1142,14 @@ Extended error information
   into the histogram.  In order to avoid having to set everything up
   again, we can just clear the histogram first::
 
-    # echo 'hist:key=stacktrace:vals=len:clear' >> \
+    # echo 'hist:key=common_stacktrace:vals=len:clear' >> \
            /sys/kernel/tracing/events/net/netif_receive_skb/trigger
 
   Just to verify that it is in fact cleared, here's what we now see in
   the hist file::
 
     # cat /sys/kernel/tracing/events/net/netif_receive_skb/hist
-    # trigger info: hist:keys=stacktrace:vals=len:sort=hitcount:size=2048 [paused]
+    # trigger info: hist:keys=common_stacktrace:vals=len:sort=hitcount:size=2048 [paused]
 
     Totals:
         Hits: 0
@@ -1485,12 +1485,12 @@ Extended error information
 
   And here's an example that shows how to combine histogram data from
   any two events even if they don't share any 'compatible' fields
-  other than 'hitcount' and 'stacktrace'.  These commands create a
+  other than 'hitcount' and 'common_stacktrace'.  These commands create a
   couple of triggers named 'bar' using those fields::
 
-    # echo 'hist:name=bar:key=stacktrace:val=hitcount' > \
+    # echo 'hist:name=bar:key=common_stacktrace:val=hitcount' > \
            /sys/kernel/tracing/events/sched/sched_process_fork/trigger
-    # echo 'hist:name=bar:key=stacktrace:val=hitcount' > \
+    # echo 'hist:name=bar:key=common_stacktrace:val=hitcount' > \
           /sys/kernel/tracing/events/net/netif_rx/trigger
 
   And displaying the output of either shows some interesting if
@@ -1501,16 +1501,16 @@ Extended error information
 
     # event histogram
     #
-    # trigger info: hist:name=bar:keys=stacktrace:vals=hitcount:sort=hitcount:size=2048 [active]
+    # trigger info: hist:name=bar:keys=common_stacktrace:vals=hitcount:sort=hitcount:size=2048 [active]
     #
 
-    { stacktrace:
+    { common_stacktrace:
              kernel_clone+0x18e/0x330
              kernel_thread+0x29/0x30
              kthreadd+0x154/0x1b0
              ret_from_fork+0x3f/0x70
     } hitcount:          1
-    { stacktrace:
+    { common_stacktrace:
              netif_rx_internal+0xb2/0xd0
              netif_rx_ni+0x20/0x70
              dev_loopback_xmit+0xaa/0xd0
@@ -1528,7 +1528,7 @@ Extended error information
              call_cpuidle+0x3b/0x60
              cpu_startup_entry+0x22d/0x310
     } hitcount:          1
-    { stacktrace:
+    { common_stacktrace:
              netif_rx_internal+0xb2/0xd0
              netif_rx_ni+0x20/0x70
              dev_loopback_xmit+0xaa/0xd0
@@ -1543,7 +1543,7 @@ Extended error information
              SyS_sendto+0xe/0x10
              entry_SYSCALL_64_fastpath+0x12/0x6a
     } hitcount:          2
-    { stacktrace:
+    { common_stacktrace:
              netif_rx_internal+0xb2/0xd0
              netif_rx+0x1c/0x60
              loopback_xmit+0x6c/0xb0
@@ -1561,7 +1561,7 @@ Extended error information
              sock_sendmsg+0x38/0x50
              ___sys_sendmsg+0x14e/0x270
     } hitcount:         76
-    { stacktrace:
+    { common_stacktrace:
              netif_rx_internal+0xb2/0xd0
              netif_rx+0x1c/0x60
              loopback_xmit+0x6c/0xb0
@@ -1579,7 +1579,7 @@ Extended error information
              sock_sendmsg+0x38/0x50
              ___sys_sendmsg+0x269/0x270
     } hitcount:         77
-    { stacktrace:
+    { common_stacktrace:
              netif_rx_internal+0xb2/0xd0
              netif_rx+0x1c/0x60
              loopback_xmit+0x6c/0xb0
@@ -1597,7 +1597,7 @@ Extended error information
              sock_sendmsg+0x38/0x50
              SYSC_sendto+0xef/0x170
     } hitcount:         88
-    { stacktrace:
+    { common_stacktrace:
              kernel_clone+0x18e/0x330
              SyS_clone+0x19/0x20
              entry_SYSCALL_64_fastpath+0x12/0x6a
@@ -1949,7 +1949,7 @@ uninterruptible state::
 
   # cd /sys/kernel/tracing
   # echo 's:block_lat pid_t pid; u64 delta; unsigned long[] stack;' > dynamic_events
-  # echo 'hist:keys=next_pid:ts=common_timestamp.usecs,st=stacktrace  if prev_state == 2' >> events/sched/sched_switch/trigger
+  # echo 'hist:keys=next_pid:ts=common_timestamp.usecs,st=common_stacktrace  if prev_state == 2' >> events/sched/sched_switch/trigger
   # echo 'hist:keys=prev_pid:delta=common_timestamp.usecs-$ts,s=$st:onmax($delta).trace(block_lat,prev_pid,$delta,$s)' >> events/sched/sched_switch/trigger
   # echo 1 > events/synthetic/block_lat/enable
   # cat trace
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 0e373222a6df..7c4a0b72334e 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -806,6 +806,7 @@ enum {
 	FILTER_TRACE_FN,
 	FILTER_COMM,
 	FILTER_CPU,
+	FILTER_STACKTRACE,
 };
 
 extern int trace_event_raw_init(struct trace_event_call *call);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 654ffa40457a..57e539d47989 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -194,6 +194,8 @@ static int trace_define_generic_fields(void)
 	__generic_field(int, common_cpu, FILTER_CPU);
 	__generic_field(char *, COMM, FILTER_COMM);
 	__generic_field(char *, comm, FILTER_COMM);
+	__generic_field(char *, stacktrace, FILTER_STACKTRACE);
+	__generic_field(char *, STACKTRACE, FILTER_STACKTRACE);
 
 	return ret;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 543cb7dc84ad..b97d3ad832f1 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1364,7 +1364,7 @@ static const char *hist_field_name(struct hist_field *field,
 		if (field->field)
 			field_name = field->field->name;
 		else
-			field_name = "stacktrace";
+			field_name = "common_stacktrace";
 	} else if (field->flags & HIST_FIELD_FL_HITCOUNT)
 		field_name = "hitcount";
 
@@ -2367,7 +2367,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 		hist_data->enable_timestamps = true;
 		if (*flags & HIST_FIELD_FL_TIMESTAMP_USECS)
 			hist_data->attrs->ts_in_usecs = true;
-	} else if (strcmp(field_name, "stacktrace") == 0) {
+	} else if (strcmp(field_name, "common_stacktrace") == 0) {
 		*flags |= HIST_FIELD_FL_STACKTRACE;
 	} else if (strcmp(field_name, "common_cpu") == 0)
 		*flags |= HIST_FIELD_FL_CPU;
@@ -2378,11 +2378,15 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 		if (!field || !field->size) {
 			/*
 			 * For backward compatibility, if field_name
-			 * was "cpu", then we treat this the same as
-			 * common_cpu. This also works for "CPU".
+			 * was "cpu" or "stacktrace", then we treat this
+			 * the same as common_cpu and common_stacktrace
+			 * respectively. This also works for "CPU", and
+			 * "STACKTRACE".
 			 */
 			if (field && field->filter_type == FILTER_CPU) {
 				*flags |= HIST_FIELD_FL_CPU;
+			} else if (field && field->filter_type == FILTER_STACKTRACE) {
+				*flags |= HIST_FIELD_FL_STACKTRACE;
 			} else {
 				hist_err(tr, HIST_ERR_FIELD_NOT_FOUND,
 					 errpos(field_name));
@@ -5394,7 +5398,7 @@ static void hist_trigger_print_key(struct seq_file *m,
 			if (key_field->field)
 				seq_printf(m, "%s.stacktrace", key_field->field->name);
 			else
-				seq_puts(m, "stacktrace:\n");
+				seq_puts(m, "common_stacktrace:\n");
 			hist_trigger_stacktrace_print(m,
 						      key + key_field->offset,
 						      HIST_STACKTRACE_DEPTH);
@@ -5977,7 +5981,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 			if (field->field)
 				seq_printf(m, "%s.stacktrace", field->field->name);
 			else
-				seq_puts(m, "stacktrace");
+				seq_puts(m, "common_stacktrace");
 		} else
 			hist_field_print(m, field);
 	}
-- 
2.39.2

