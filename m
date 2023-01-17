Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D47866E203
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjAQPXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjAQPWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:22:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29143212B;
        Tue, 17 Jan 2023 07:22:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD9DAB8165B;
        Tue, 17 Jan 2023 15:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6C8C433A8;
        Tue, 17 Jan 2023 15:22:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pHnnI-001vjd-1T;
        Tue, 17 Jan 2023 10:22:36 -0500
Message-ID: <20230117152236.320181354@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Jan 2023 10:21:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ross Zwisler <zwisler@google.com>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: [PATCH 5/6 v2] tracing/histogram: Document variable stacktrace
References: <20230117152125.268986282@goodmis.org>
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

Add a little documentation (and a useful example) of how a stacktrace can
be used within a histogram variable and synthetic event.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/histogram.rst | 129 ++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index f95459aa984f..5c391328b9bb 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -81,6 +81,7 @@ Documentation written by Tom Zanussi
 	.usecs         display a common_timestamp in microseconds
         .percent       display a number of percentage value
         .graph         display a bar-graph of a value
+	.stacktrace    display as a stacktrace (must by a long[] type)
 	=============  =================================================
 
   Note that in general the semantics of a given field aren't
@@ -1786,6 +1787,8 @@ or assigned to a variable and referenced in a subsequent expression::
   # echo 'hist:keys=next_pid:us_per_sec=1000000 ...' >> event/trigger
   # echo 'hist:keys=next_pid:timestamp_secs=common_timestamp/$us_per_sec ...' >> event/trigger
 
+Variables can even hold stacktraces, which are useful with synthetic events.
+
 2.2.2 Synthetic Events
 ----------------------
 
@@ -1940,6 +1943,132 @@ the ".buckets" modifier and specify a size (in this case groups of 10).
       Entries: 16
       Dropped: 0
 
+To save stacktraces, create a synthetic event with a field of type "unsigned long[]"
+or even just "long[]". For example, to see how long a task is blocked in an
+uninterruptible state:
+
+  # cd /sys/kernel/tracing
+  # echo 's:block_lat pid_t pid; u64 delta; unsigned long[] stack;' > dynamic_events
+  # echo 'hist:keys=next_pid:ts=common_timestamp.usecs,st=stacktrace  if prev_state == 2' >> events/sched/sched_switch/trigger
+  # echo 'hist:keys=prev_pid:delta=common_timestamp.usecs-$ts,s=$st:onmax($delta).trace(block_lat,prev_pid,$delta,$s)' >> events/sched/sched_switch/trigger
+  # echo 1 > events/synthetic/block_lat/enable
+  # cat trace
+
+  # tracer: nop
+  #
+  # entries-in-buffer/entries-written: 2/2   #P:8
+  #
+  #                                _-----=> irqs-off/BH-disabled
+  #                               / _----=> need-resched
+  #                              | / _---=> hardirq/softirq
+  #                              || / _--=> preempt-depth
+  #                              ||| / _-=> migrate-disable
+  #                              |||| /     delay
+  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
+  #              | |         |   |||||     |         |
+            <idle>-0       [005] d..4.   521.164922: block_lat: pid=0 delta=8322 stack=STACK:
+  => __schedule+0x448/0x7b0
+  => schedule+0x5a/0xb0
+  => io_schedule+0x42/0x70
+  => bit_wait_io+0xd/0x60
+  => __wait_on_bit+0x4b/0x140
+  => out_of_line_wait_on_bit+0x91/0xb0
+  => jbd2_journal_commit_transaction+0x1679/0x1a70
+  => kjournald2+0xa9/0x280
+  => kthread+0xe9/0x110
+  => ret_from_fork+0x2c/0x50
+
+             <...>-2       [004] d..4.   525.184257: block_lat: pid=2 delta=76 stack=STACK:
+  => __schedule+0x448/0x7b0
+  => schedule+0x5a/0xb0
+  => schedule_timeout+0x11a/0x150
+  => wait_for_completion_killable+0x144/0x1f0
+  => __kthread_create_on_node+0xe7/0x1e0
+  => kthread_create_on_node+0x51/0x70
+  => create_worker+0xcc/0x1a0
+  => worker_thread+0x2ad/0x380
+  => kthread+0xe9/0x110
+  => ret_from_fork+0x2c/0x50
+
+A synthetic event that has a stacktrace field may use it as a key in histogram:
+
+  # echo 'hist:delta.buckets=100,stack.stacktrace:sort=delta' > events/synthetic/block_lat/trigger
+  # cat events/synthetic/block_lat/hist
+
+  # event histogram
+  #
+  # trigger info: hist:keys=delta.buckets=100,stacktrace:vals=hitcount:sort=delta.buckets=100:size=2048 [active]
+  #
+
+  { delta: ~ 0-99, stacktrace:
+           event_hist_trigger+0x464/0x480
+           event_triggers_call+0x52/0xe0
+           trace_event_buffer_commit+0x193/0x250
+           trace_event_raw_event_sched_switch+0xfc/0x150
+           __traceiter_sched_switch+0x41/0x60
+           __schedule+0x448/0x7b0
+           schedule_idle+0x26/0x40
+           cpu_startup_entry+0x19/0x20
+           start_secondary+0xed/0xf0
+           secondary_startup_64_no_verify+0xe0/0xeb
+  } hitcount:          6
+  { delta: ~ 0-99, stacktrace:
+           event_hist_trigger+0x464/0x480
+           event_triggers_call+0x52/0xe0
+           trace_event_buffer_commit+0x193/0x250
+           trace_event_raw_event_sched_switch+0xfc/0x150
+           __traceiter_sched_switch+0x41/0x60
+           __schedule+0x448/0x7b0
+           schedule_idle+0x26/0x40
+           cpu_startup_entry+0x19/0x20
+           __pfx_kernel_init+0x0/0x10
+           arch_call_rest_init+0xa/0x24
+           start_kernel+0x964/0x98d
+           secondary_startup_64_no_verify+0xe0/0xeb
+  } hitcount:          3
+  { delta: ~ 0-99, stacktrace:
+           event_hist_trigger+0x464/0x480
+           event_triggers_call+0x52/0xe0
+           trace_event_buffer_commit+0x193/0x250
+           trace_event_raw_event_sched_switch+0xfc/0x150
+           __traceiter_sched_switch+0x41/0x60
+           __schedule+0x448/0x7b0
+           schedule+0x5a/0xb0
+           worker_thread+0xaf/0x380
+           kthread+0xe9/0x110
+           ret_from_fork+0x2c/0x50
+  } hitcount:          1
+  { delta: ~ 100-199, stacktrace:
+           event_hist_trigger+0x464/0x480
+           event_triggers_call+0x52/0xe0
+           trace_event_buffer_commit+0x193/0x250
+           trace_event_raw_event_sched_switch+0xfc/0x150
+           __traceiter_sched_switch+0x41/0x60
+           __schedule+0x448/0x7b0
+           schedule_idle+0x26/0x40
+           cpu_startup_entry+0x19/0x20
+           start_secondary+0xed/0xf0
+           secondary_startup_64_no_verify+0xe0/0xeb
+  } hitcount:         15
+  [..]
+  { delta: ~ 8500-8599, stacktrace:
+           event_hist_trigger+0x464/0x480
+           event_triggers_call+0x52/0xe0
+           trace_event_buffer_commit+0x193/0x250
+           trace_event_raw_event_sched_switch+0xfc/0x150
+           __traceiter_sched_switch+0x41/0x60
+           __schedule+0x448/0x7b0
+           schedule_idle+0x26/0x40
+           cpu_startup_entry+0x19/0x20
+           start_secondary+0xed/0xf0
+           secondary_startup_64_no_verify+0xe0/0xeb
+  } hitcount:          1
+
+  Totals:
+      Hits: 89
+      Entries: 11
+      Dropped: 0
+
 2.2.3 Hist trigger 'handlers' and 'actions'
 -------------------------------------------
 
-- 
2.39.0


