Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C9071420E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 04:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjE2Cc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 22:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2Ccz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 22:32:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53530A9
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 19:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9E4A6152F
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 02:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085DCC4339E;
        Mon, 29 May 2023 02:32:48 +0000 (UTC)
Date:   Sun, 28 May 2023 22:32:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [ GIT PULL] tracing: Fixes for v6.4-rc3
Message-ID: <20230528223244.02469586@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Linus,

[
   Note: The softlockup watchdog has been triggering more often for me,
   which causes my tests to fail. Some of the fixes in this pull
   request deal with it somewhat, but I had to also add:
     https://lore.kernel.org/all/20230528084652.5f3b48f0@rorschach.local.home/
   to get my tests to pass. The tests have a lot of kernel debugging
   enabled, and I'm guessing that with that and other various security
   mitigations, it's taking more time to run various kernel internals.
]

Tracing fixes:

User events:

 - Use long instead of int for storing the enable set/clear bit, as it was
   found that big endian machines could end up using the wrong bits.

 - Split allocating mm and attaching it. This keeps the allocation separate
   from the registration and avoids various races.

 - Remove RCU locking around pin_user_pages_remote() as that can schedule. The
   RCU protection is no longer needed with the above split of mm allocation and
   attaching.

 - Rename the "link" fields of the various structs to something more
   meaningful.

 - Add comments around user_event_mm struct usage and locking requirements.

Timerlat tracer:

 - Fix missed wakeup of timerlat thread caused by the timerlat interrupt
   triggering when tracing is off. The timer interrupt handler needs to always
   wake up the timerlat thread regardless if tracing is enabled or not,
   otherwise, it will never wake up.

Histograms:

 - Fix regression of breaking the "stacktrace" modifier for variables. That
   modifier cannot be used for values, but can be used for variables that are
   passed from one histogram to the next. This was broken when adding the
   restriction to values as the variable logic used the same code.

 - Rename the special field "stacktrace" to "common_stacktrace". Special fields
   (that are not actually part of the event, but can act just like event
   fields, like 'comm' and 'timestamp') should be prefixed with 'common_' for
   consistency. To keep backward compatibility, 'stacktrace' can still be used
   (as with the special field 'cpu'), but can be overridden if the event has a
   field called 'stacktrace'.

 - Update the synthetic event selftests to use the new name (synthetic events
   are created by histograms)

Tracing bootup selftests:

 - Reorganize the code to keep artifacts of the selftests not compiled in when
   selftests are not configured.

 - Add various cond_resched() around the selftest code, as the softlock
   watchdog was triggering much more often. It appears that the kernel runs
   slower now with full debugging enabled.

 - While debugging ftrace with ftrace (using an instance ring buffer instead of
   the top level one), I found that the selftests were disabling prints to the
   debug instance. This should not happen, as the selftests only disable
   printing to the main buffer as the selftests examine the main buffer to see
   if it has what it expects, and prints can make the tests fail. Make the
   selftests only disable printing to the toplevel buffer, and leave the
   instance buffers alone.


Please pull the latest trace-v6.4-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.4-rc3

Tag SHA1: 54fba9af747ab5f01a760fea871df723a78964cc
Head SHA1: a2d910f02231f33118647fc438157ae69c073f89


Beau Belgrave (3):
      tracing/user_events: Use long vs int for atomic bit ops
      tracing/user_events: Rename link fields for clarity
      tracing/user_events: Document user_event_mm one-shot list usage

Daniel Bristot de Oliveira (1):
      tracing/timerlat: Always wakeup the timerlat thread

Linus Torvalds (2):
      tracing/user_events: Split up mm alloc and attach
      tracing/user_events: Remove RCU lock while pinning pages

Steven Rostedt (Google) (8):
      tracing/histograms: Allow variables to have some modifiers
      tracing: Rename stacktrace field to common_stacktrace
      tracing/selftests: Update synthetic event selftest to use common_stacktrace
      tracing: Move setting of tracing_selftest_running out of register_tracer()
      tracing: Have tracer selftests call cond_resched() before running
      tracing: Make tracing_selftest_running/delete nops when not used
      tracing: Only make selftest conditionals affect the global_trace
      tracing: Have function_graph selftest call cond_resched()

----
 Documentation/trace/histogram.rst                  |  64 ++++++------
 include/linux/trace_events.h                       |   1 +
 include/linux/user_events.h                        |   3 +-
 kernel/trace/trace.c                               |  44 ++++++--
 kernel/trace/trace_events.c                        |   2 +
 kernel/trace/trace_events_hist.c                   |  39 ++++---
 kernel/trace/trace_events_user.c                   | 112 ++++++++++++++-------
 kernel/trace/trace_osnoise.c                       |   2 +
 kernel/trace/trace_selftest.c                      |  10 ++
 .../trigger-synthetic-event-stack-legacy.tc        |  24 +++++
 .../inter-event/trigger-synthetic-event-stack.tc   |   5 +-
 11 files changed, 210 insertions(+), 96 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack-legacy.tc
---------------------------
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
diff --git a/include/linux/user_events.h b/include/linux/user_events.h
index 2847f5a18a86..8afa8c3a0973 100644
--- a/include/linux/user_events.h
+++ b/include/linux/user_events.h
@@ -17,9 +17,10 @@
 
 #ifdef CONFIG_USER_EVENTS
 struct user_event_mm {
-	struct list_head	link;
+	struct list_head	mms_link;
 	struct list_head	enablers;
 	struct mm_struct	*mm;
+	/* Used for one-shot lists, protected by event_mutex */
 	struct user_event_mm	*next;
 	refcount_t		refcnt;
 	refcount_t		tasks;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ebc59781456a..64a4dde073ef 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -60,6 +60,7 @@
  */
 bool ring_buffer_expanded;
 
+#ifdef CONFIG_FTRACE_STARTUP_TEST
 /*
  * We need to change this state when a selftest is running.
  * A selftest will lurk into the ring-buffer to count the
@@ -75,7 +76,6 @@ static bool __read_mostly tracing_selftest_running;
  */
 bool __read_mostly tracing_selftest_disabled;
 
-#ifdef CONFIG_FTRACE_STARTUP_TEST
 void __init disable_tracing_selftest(const char *reason)
 {
 	if (!tracing_selftest_disabled) {
@@ -83,6 +83,9 @@ void __init disable_tracing_selftest(const char *reason)
 		pr_info("Ftrace startup test is disabled due to %s\n", reason);
 	}
 }
+#else
+#define tracing_selftest_running	0
+#define tracing_selftest_disabled	0
 #endif
 
 /* Pipe tracepoints to printk */
@@ -1051,7 +1054,10 @@ int __trace_array_puts(struct trace_array *tr, unsigned long ip,
 	if (!(tr->trace_flags & TRACE_ITER_PRINTK))
 		return 0;
 
-	if (unlikely(tracing_selftest_running || tracing_disabled))
+	if (unlikely(tracing_selftest_running && tr == &global_trace))
+		return 0;
+
+	if (unlikely(tracing_disabled))
 		return 0;
 
 	alloc = sizeof(*entry) + size + 2; /* possible \n added */
@@ -2041,6 +2047,24 @@ static int run_tracer_selftest(struct tracer *type)
 	return 0;
 }
 
+static int do_run_tracer_selftest(struct tracer *type)
+{
+	int ret;
+
+	/*
+	 * Tests can take a long time, especially if they are run one after the
+	 * other, as does happen during bootup when all the tracers are
+	 * registered. This could cause the soft lockup watchdog to trigger.
+	 */
+	cond_resched();
+
+	tracing_selftest_running = true;
+	ret = run_tracer_selftest(type);
+	tracing_selftest_running = false;
+
+	return ret;
+}
+
 static __init int init_trace_selftests(void)
 {
 	struct trace_selftests *p, *n;
@@ -2092,6 +2116,10 @@ static inline int run_tracer_selftest(struct tracer *type)
 {
 	return 0;
 }
+static inline int do_run_tracer_selftest(struct tracer *type)
+{
+	return 0;
+}
 #endif /* CONFIG_FTRACE_STARTUP_TEST */
 
 static void add_tracer_options(struct trace_array *tr, struct tracer *t);
@@ -2127,8 +2155,6 @@ int __init register_tracer(struct tracer *type)
 
 	mutex_lock(&trace_types_lock);
 
-	tracing_selftest_running = true;
-
 	for (t = trace_types; t; t = t->next) {
 		if (strcmp(type->name, t->name) == 0) {
 			/* already found */
@@ -2157,7 +2183,7 @@ int __init register_tracer(struct tracer *type)
 	/* store the tracer for __set_tracer_option */
 	type->flags->trace = type;
 
-	ret = run_tracer_selftest(type);
+	ret = do_run_tracer_selftest(type);
 	if (ret < 0)
 		goto out;
 
@@ -2166,7 +2192,6 @@ int __init register_tracer(struct tracer *type)
 	add_tracer_options(&global_trace, type);
 
  out:
-	tracing_selftest_running = false;
 	mutex_unlock(&trace_types_lock);
 
 	if (ret || !default_bootup_tracer)
@@ -3490,7 +3515,7 @@ __trace_array_vprintk(struct trace_buffer *buffer,
 	unsigned int trace_ctx;
 	char *tbuffer;
 
-	if (tracing_disabled || tracing_selftest_running)
+	if (tracing_disabled)
 		return 0;
 
 	/* Don't pollute graph traces with trace_vprintk internals */
@@ -3538,6 +3563,9 @@ __printf(3, 0)
 int trace_array_vprintk(struct trace_array *tr,
 			unsigned long ip, const char *fmt, va_list args)
 {
+	if (tracing_selftest_running && tr == &global_trace)
+		return 0;
+
 	return __trace_array_vprintk(tr->array_buffer.buffer, ip, fmt, args);
 }
 
@@ -5752,7 +5780,7 @@ static const char readme_msg[] =
 	"\t    table using the key(s) and value(s) named, and the value of a\n"
 	"\t    sum called 'hitcount' is incremented.  Keys and values\n"
 	"\t    correspond to fields in the event's format description.  Keys\n"
-	"\t    can be any field, or the special string 'stacktrace'.\n"
+	"\t    can be any field, or the special string 'common_stacktrace'.\n"
 	"\t    Compound keys consisting of up to two fields can be specified\n"
 	"\t    by the 'keys' keyword.  Values must correspond to numeric\n"
 	"\t    fields.  Sort keys consisting of up to two fields can be\n"
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
index 486cca3c2b75..b97d3ad832f1 100644
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
@@ -4238,13 +4242,19 @@ static int __create_val_field(struct hist_trigger_data *hist_data,
 		goto out;
 	}
 
-	/* Some types cannot be a value */
-	if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
-				 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2 |
-				 HIST_FIELD_FL_SYM | HIST_FIELD_FL_SYM_OFFSET |
-				 HIST_FIELD_FL_SYSCALL | HIST_FIELD_FL_STACKTRACE)) {
-		hist_err(file->tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(field_str));
-		ret = -EINVAL;
+	/* values and variables should not have some modifiers */
+	if (hist_field->flags & HIST_FIELD_FL_VAR) {
+		/* Variable */
+		if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
+					 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2))
+			goto err;
+	} else {
+		/* Value */
+		if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
+					 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2 |
+					 HIST_FIELD_FL_SYM | HIST_FIELD_FL_SYM_OFFSET |
+					 HIST_FIELD_FL_SYSCALL | HIST_FIELD_FL_STACKTRACE))
+			goto err;
 	}
 
 	hist_data->fields[val_idx] = hist_field;
@@ -4256,6 +4266,9 @@ static int __create_val_field(struct hist_trigger_data *hist_data,
 		ret = -EINVAL;
  out:
 	return ret;
+ err:
+	hist_err(file->tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(field_str));
+	return -EINVAL;
 }
 
 static int create_val_field(struct hist_trigger_data *hist_data,
@@ -5385,7 +5398,7 @@ static void hist_trigger_print_key(struct seq_file *m,
 			if (key_field->field)
 				seq_printf(m, "%s.stacktrace", key_field->field->name);
 			else
-				seq_puts(m, "stacktrace:\n");
+				seq_puts(m, "common_stacktrace:\n");
 			hist_trigger_stacktrace_print(m,
 						      key + key_field->offset,
 						      HIST_STACKTRACE_DEPTH);
@@ -5968,7 +5981,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 			if (field->field)
 				seq_printf(m, "%s.stacktrace", field->field->name);
 			else
-				seq_puts(m, "stacktrace");
+				seq_puts(m, "common_stacktrace");
 		} else
 			hist_field_print(m, field);
 	}
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index b1ecd7677642..dbb14705d0d3 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -96,12 +96,12 @@ struct user_event {
  * these to track enablement sites that are tied to an event.
  */
 struct user_event_enabler {
-	struct list_head	link;
+	struct list_head	mm_enablers_link;
 	struct user_event	*event;
 	unsigned long		addr;
 
 	/* Track enable bit, flags, etc. Aligned for bitops. */
-	unsigned int		values;
+	unsigned long		values;
 };
 
 /* Bits 0-5 are for the bit to update upon enable/disable (0-63 allowed) */
@@ -116,7 +116,9 @@ struct user_event_enabler {
 /* Only duplicate the bit value */
 #define ENABLE_VAL_DUP_MASK ENABLE_VAL_BIT_MASK
 
-#define ENABLE_BITOPS(e) ((unsigned long *)&(e)->values)
+#define ENABLE_BITOPS(e) (&(e)->values)
+
+#define ENABLE_BIT(e) ((int)((e)->values & ENABLE_VAL_BIT_MASK))
 
 /* Used for asynchronous faulting in of pages */
 struct user_event_enabler_fault {
@@ -153,7 +155,7 @@ struct user_event_file_info {
 #define VALIDATOR_REL (1 << 1)
 
 struct user_event_validator {
-	struct list_head	link;
+	struct list_head	user_event_link;
 	int			offset;
 	int			flags;
 };
@@ -259,7 +261,7 @@ static struct user_event_group
 
 static void user_event_enabler_destroy(struct user_event_enabler *enabler)
 {
-	list_del_rcu(&enabler->link);
+	list_del_rcu(&enabler->mm_enablers_link);
 
 	/* No longer tracking the event via the enabler */
 	refcount_dec(&enabler->event->refcnt);
@@ -423,9 +425,9 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 
 	/* Update bit atomically, user tracers must be atomic as well */
 	if (enabler->event && enabler->event->status)
-		set_bit(enabler->values & ENABLE_VAL_BIT_MASK, ptr);
+		set_bit(ENABLE_BIT(enabler), ptr);
 	else
-		clear_bit(enabler->values & ENABLE_VAL_BIT_MASK, ptr);
+		clear_bit(ENABLE_BIT(enabler), ptr);
 
 	kunmap_local(kaddr);
 	unpin_user_pages_dirty_lock(&page, 1, true);
@@ -437,11 +439,9 @@ static bool user_event_enabler_exists(struct user_event_mm *mm,
 				      unsigned long uaddr, unsigned char bit)
 {
 	struct user_event_enabler *enabler;
-	struct user_event_enabler *next;
 
-	list_for_each_entry_safe(enabler, next, &mm->enablers, link) {
-		if (enabler->addr == uaddr &&
-		    (enabler->values & ENABLE_VAL_BIT_MASK) == bit)
+	list_for_each_entry(enabler, &mm->enablers, mm_enablers_link) {
+		if (enabler->addr == uaddr && ENABLE_BIT(enabler) == bit)
 			return true;
 	}
 
@@ -451,23 +451,36 @@ static bool user_event_enabler_exists(struct user_event_mm *mm,
 static void user_event_enabler_update(struct user_event *user)
 {
 	struct user_event_enabler *enabler;
-	struct user_event_mm *mm = user_event_mm_get_all(user);
 	struct user_event_mm *next;
+	struct user_event_mm *mm;
 	int attempt;
 
+	lockdep_assert_held(&event_mutex);
+
+	/*
+	 * We need to build a one-shot list of all the mms that have an
+	 * enabler for the user_event passed in. This list is only valid
+	 * while holding the event_mutex. The only reason for this is due
+	 * to the global mm list being RCU protected and we use methods
+	 * which can wait (mmap_read_lock and pin_user_pages_remote).
+	 *
+	 * NOTE: user_event_mm_get_all() increments the ref count of each
+	 * mm that is added to the list to prevent removal timing windows.
+	 * We must always put each mm after they are used, which may wait.
+	 */
+	mm = user_event_mm_get_all(user);
+
 	while (mm) {
 		next = mm->next;
 		mmap_read_lock(mm->mm);
-		rcu_read_lock();
 
-		list_for_each_entry_rcu(enabler, &mm->enablers, link) {
+		list_for_each_entry(enabler, &mm->enablers, mm_enablers_link) {
 			if (enabler->event == user) {
 				attempt = 0;
 				user_event_enabler_write(mm, enabler, true, &attempt);
 			}
 		}
 
-		rcu_read_unlock();
 		mmap_read_unlock(mm->mm);
 		user_event_mm_put(mm);
 		mm = next;
@@ -495,7 +508,9 @@ static bool user_event_enabler_dup(struct user_event_enabler *orig,
 	enabler->values = orig->values & ENABLE_VAL_DUP_MASK;
 
 	refcount_inc(&enabler->event->refcnt);
-	list_add_rcu(&enabler->link, &mm->enablers);
+
+	/* Enablers not exposed yet, RCU not required */
+	list_add(&enabler->mm_enablers_link, &mm->enablers);
 
 	return true;
 }
@@ -513,6 +528,14 @@ static struct user_event_mm *user_event_mm_get_all(struct user_event *user)
 	struct user_event_enabler *enabler;
 	struct user_event_mm *mm;
 
+	/*
+	 * We use the mm->next field to build a one-shot list from the global
+	 * RCU protected list. To build this list the event_mutex must be held.
+	 * This lets us build a list without requiring allocs that could fail
+	 * when user based events are most wanted for diagnostics.
+	 */
+	lockdep_assert_held(&event_mutex);
+
 	/*
 	 * We do not want to block fork/exec while enablements are being
 	 * updated, so we use RCU to walk the current tasks that have used
@@ -525,23 +548,24 @@ static struct user_event_mm *user_event_mm_get_all(struct user_event *user)
 	 */
 	rcu_read_lock();
 
-	list_for_each_entry_rcu(mm, &user_event_mms, link)
-		list_for_each_entry_rcu(enabler, &mm->enablers, link)
+	list_for_each_entry_rcu(mm, &user_event_mms, mms_link) {
+		list_for_each_entry_rcu(enabler, &mm->enablers, mm_enablers_link) {
 			if (enabler->event == user) {
 				mm->next = found;
 				found = user_event_mm_get(mm);
 				break;
 			}
+		}
+	}
 
 	rcu_read_unlock();
 
 	return found;
 }
 
-static struct user_event_mm *user_event_mm_create(struct task_struct *t)
+static struct user_event_mm *user_event_mm_alloc(struct task_struct *t)
 {
 	struct user_event_mm *user_mm;
-	unsigned long flags;
 
 	user_mm = kzalloc(sizeof(*user_mm), GFP_KERNEL_ACCOUNT);
 
@@ -553,12 +577,6 @@ static struct user_event_mm *user_event_mm_create(struct task_struct *t)
 	refcount_set(&user_mm->refcnt, 1);
 	refcount_set(&user_mm->tasks, 1);
 
-	spin_lock_irqsave(&user_event_mms_lock, flags);
-	list_add_rcu(&user_mm->link, &user_event_mms);
-	spin_unlock_irqrestore(&user_event_mms_lock, flags);
-
-	t->user_event_mm = user_mm;
-
 	/*
 	 * The lifetime of the memory descriptor can slightly outlast
 	 * the task lifetime if a ref to the user_event_mm is taken
@@ -572,6 +590,17 @@ static struct user_event_mm *user_event_mm_create(struct task_struct *t)
 	return user_mm;
 }
 
+static void user_event_mm_attach(struct user_event_mm *user_mm, struct task_struct *t)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&user_event_mms_lock, flags);
+	list_add_rcu(&user_mm->mms_link, &user_event_mms);
+	spin_unlock_irqrestore(&user_event_mms_lock, flags);
+
+	t->user_event_mm = user_mm;
+}
+
 static struct user_event_mm *current_user_event_mm(void)
 {
 	struct user_event_mm *user_mm = current->user_event_mm;
@@ -579,10 +608,12 @@ static struct user_event_mm *current_user_event_mm(void)
 	if (user_mm)
 		goto inc;
 
-	user_mm = user_event_mm_create(current);
+	user_mm = user_event_mm_alloc(current);
 
 	if (!user_mm)
 		goto error;
+
+	user_event_mm_attach(user_mm, current);
 inc:
 	refcount_inc(&user_mm->refcnt);
 error:
@@ -593,7 +624,7 @@ static void user_event_mm_destroy(struct user_event_mm *mm)
 {
 	struct user_event_enabler *enabler, *next;
 
-	list_for_each_entry_safe(enabler, next, &mm->enablers, link)
+	list_for_each_entry_safe(enabler, next, &mm->enablers, mm_enablers_link)
 		user_event_enabler_destroy(enabler);
 
 	mmdrop(mm->mm);
@@ -630,7 +661,7 @@ void user_event_mm_remove(struct task_struct *t)
 
 	/* Remove the mm from the list, so it can no longer be enabled */
 	spin_lock_irqsave(&user_event_mms_lock, flags);
-	list_del_rcu(&mm->link);
+	list_del_rcu(&mm->mms_link);
 	spin_unlock_irqrestore(&user_event_mms_lock, flags);
 
 	/*
@@ -670,7 +701,7 @@ void user_event_mm_remove(struct task_struct *t)
 
 void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 {
-	struct user_event_mm *mm = user_event_mm_create(t);
+	struct user_event_mm *mm = user_event_mm_alloc(t);
 	struct user_event_enabler *enabler;
 
 	if (!mm)
@@ -678,16 +709,18 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 
 	rcu_read_lock();
 
-	list_for_each_entry_rcu(enabler, &old_mm->enablers, link)
+	list_for_each_entry_rcu(enabler, &old_mm->enablers, mm_enablers_link) {
 		if (!user_event_enabler_dup(enabler, mm))
 			goto error;
+	}
 
 	rcu_read_unlock();
 
+	user_event_mm_attach(mm, t);
 	return;
 error:
 	rcu_read_unlock();
-	user_event_mm_remove(t);
+	user_event_mm_destroy(mm);
 }
 
 static bool current_user_event_enabler_exists(unsigned long uaddr,
@@ -748,7 +781,7 @@ static struct user_event_enabler
 	 */
 	if (!*write_result) {
 		refcount_inc(&enabler->event->refcnt);
-		list_add_rcu(&enabler->link, &user_mm->enablers);
+		list_add_rcu(&enabler->mm_enablers_link, &user_mm->enablers);
 	}
 
 	mutex_unlock(&event_mutex);
@@ -904,8 +937,8 @@ static void user_event_destroy_validators(struct user_event *user)
 	struct user_event_validator *validator, *next;
 	struct list_head *head = &user->validators;
 
-	list_for_each_entry_safe(validator, next, head, link) {
-		list_del(&validator->link);
+	list_for_each_entry_safe(validator, next, head, user_event_link) {
+		list_del(&validator->user_event_link);
 		kfree(validator);
 	}
 }
@@ -959,7 +992,7 @@ static int user_event_add_field(struct user_event *user, const char *type,
 	validator->offset = offset;
 
 	/* Want sequential access when validating */
-	list_add_tail(&validator->link, &user->validators);
+	list_add_tail(&validator->user_event_link, &user->validators);
 
 add_field:
 	field->type = type;
@@ -1349,7 +1382,7 @@ static int user_event_validate(struct user_event *user, void *data, int len)
 	void *pos, *end = data + len;
 	u32 loc, offset, size;
 
-	list_for_each_entry(validator, head, link) {
+	list_for_each_entry(validator, head, user_event_link) {
 		pos = data + validator->offset;
 
 		/* Already done min_size check, no bounds check here */
@@ -2270,9 +2303,9 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 	 */
 	mutex_lock(&event_mutex);
 
-	list_for_each_entry_safe(enabler, next, &mm->enablers, link)
+	list_for_each_entry_safe(enabler, next, &mm->enablers, mm_enablers_link) {
 		if (enabler->addr == reg.disable_addr &&
-		    (enabler->values & ENABLE_VAL_BIT_MASK) == reg.disable_bit) {
+		    ENABLE_BIT(enabler) == reg.disable_bit) {
 			set_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler));
 
 			if (!test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)))
@@ -2281,6 +2314,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 			/* Removed at least one */
 			ret = 0;
 		}
+	}
 
 	mutex_unlock(&event_mutex);
 
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index efbbec2caff8..e97e3fa5cbed 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1652,6 +1652,8 @@ static enum hrtimer_restart timerlat_irq(struct hrtimer *timer)
 			osnoise_stop_tracing();
 			notify_new_max_latency(diff);
 
+			wake_up_process(tlat->kthread);
+
 			return HRTIMER_NORESTART;
 		}
 	}
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index a931d9aaea26..529590499b1f 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -848,6 +848,12 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	}
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	/*
+	 * These tests can take some time to run. Make sure on non PREEMPT
+	 * kernels, we do not trigger the softlockup detector.
+	 */
+	cond_resched();
+
 	tracing_reset_online_cpus(&tr->array_buffer);
 	set_graph_array(tr);
 
@@ -869,6 +875,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	if (ret)
 		goto out;
 
+	cond_resched();
+
 	ret = register_ftrace_graph(&fgraph_ops);
 	if (ret) {
 		warn_failed_init_tracer(trace, ret);
@@ -891,6 +899,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	if (ret)
 		goto out;
 
+	cond_resched();
+
 	tracing_start();
 
 	if (!ret && !count) {
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack-legacy.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack-legacy.tc
new file mode 100644
index 000000000000..d0cd91a93069
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack-legacy.tc
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test inter-event histogram trigger trace action with dynamic string param (legacy stack)
+# requires: set_event synthetic_events events/sched/sched_process_exec/hist "long[] stack' >> synthetic_events":README
+
+fail() { #msg
+    echo $1
+    exit_fail
+}
+
+echo "Test create synthetic event with stack"
+
+# Test the old stacktrace keyword (for backward compatibility)
+echo 's:wake_lat pid_t pid; u64 delta; unsigned long[] stack;' > dynamic_events
+echo 'hist:keys=next_pid:ts=common_timestamp.usecs,st=stacktrace  if prev_state == 1||prev_state == 2' >> events/sched/sched_switch/trigger
+echo 'hist:keys=prev_pid:delta=common_timestamp.usecs-$ts,s=$st:onmax($delta).trace(wake_lat,prev_pid,$delta,$s)' >> events/sched/sched_switch/trigger
+echo 1 > events/synthetic/wake_lat/enable
+sleep 1
+
+if ! grep -q "=>.*sched" trace; then
+    fail "Failed to create synthetic event with stack"
+fi
+
+exit 0
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc
index 755dbe94ccf4..8f1cc9a86a06 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test inter-event histogram trigger trace action with dynamic string param
-# requires: set_event synthetic_events events/sched/sched_process_exec/hist "long[]' >> synthetic_events":README
+# requires: set_event synthetic_events events/sched/sched_process_exec/hist "can be any field, or the special string 'common_stacktrace'":README
 
 fail() { #msg
     echo $1
@@ -10,9 +10,8 @@ fail() { #msg
 
 echo "Test create synthetic event with stack"
 
-
 echo 's:wake_lat pid_t pid; u64 delta; unsigned long[] stack;' > dynamic_events
-echo 'hist:keys=next_pid:ts=common_timestamp.usecs,st=stacktrace  if prev_state == 1||prev_state == 2' >> events/sched/sched_switch/trigger
+echo 'hist:keys=next_pid:ts=common_timestamp.usecs,st=common_stacktrace  if prev_state == 1||prev_state == 2' >> events/sched/sched_switch/trigger
 echo 'hist:keys=prev_pid:delta=common_timestamp.usecs-$ts,s=$st:onmax($delta).trace(wake_lat,prev_pid,$delta,$s)' >> events/sched/sched_switch/trigger
 echo 1 > events/synthetic/wake_lat/enable
 sleep 1
