Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B223266E201
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjAQPXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjAQPWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:22:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643AC302A0;
        Tue, 17 Jan 2023 07:22:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21C01B8164F;
        Tue, 17 Jan 2023 15:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17B7C433EF;
        Tue, 17 Jan 2023 15:22:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pHnnH-001vhB-2A;
        Tue, 17 Jan 2023 10:22:35 -0500
Message-ID: <20230117152125.268986282@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Jan 2023 10:21:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ross Zwisler <zwisler@google.com>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: [PATCH 0/6 v2] tracing/histograms: Pass stacktrace from synthetic start event to end event
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I finally got around to implementing what I've been wanting to do for a long
time! That is to pass stacktraces from the start to the end event of a
synthetic event. Specifically, I need to get the stacktrace of a task as it
schedules out, but I don't want to see it until it schedules back in and I
check the timings to show that it is longer than normal. That is now done
with:

 # echo 's:block_lat pid_t pid; u64 delta; unsigned long[] stack;' > dynamic_events
 # echo 'hist:keys=next_pid:ts=common_timestamp.usecs,st=stacktrace  if prev_state == 2' >> events/sched/sched_switch/trigger
 # echo 'hist:keys=prev_pid:delta=common_timestamp.usecs-$ts,s=$st:onmax($delta).trace(block_lat,prev_pid,$delta,$s)' >> events/sched/sched_switch/trigger

The above creates a synthetic event that will trigger on the max delta of a
task blocked in an uninterruptible state. It will show you the stack trace
of where that occurred!

 # echo 1 > events/synthetic/block_lat/enable
 # ls -lR > /dev/null
 # cat trace

# tracer: nop
#
# entries-in-buffer/entries-written: 2/2   #P:8
#
#                                _-----=> irqs-off/BH-disabled
#                               / _----=> need-resched
#                              | / _---=> hardirq/softirq
#                              || / _--=> preempt-depth
#                              ||| / _-=> migrate-disable
#                              |||| /     delay
#           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
#              | |         |   |||||     |         |
          <idle>-0       [005] d..4.   521.164922: block_lat: pid=0 delta=8322 stack=STACK:
=> __schedule+0x448/0x7b0
=> schedule+0x5a/0xb0
=> io_schedule+0x42/0x70
=> bit_wait_io+0xd/0x60
=> __wait_on_bit+0x4b/0x140
=> out_of_line_wait_on_bit+0x91/0xb0
=> jbd2_journal_commit_transaction+0x1679/0x1a70
=> kjournald2+0xa9/0x280
=> kthread+0xe9/0x110
=> ret_from_fork+0x2c/0x50  

           <...>-2       [004] d..4.   525.184257: block_lat: pid=2 delta=76 stack=STACK:
=> __schedule+0x448/0x7b0
=> schedule+0x5a/0xb0
=> schedule_timeout+0x11a/0x150
=> wait_for_completion_killable+0x144/0x1f0
=> __kthread_create_on_node+0xe7/0x1e0
=> kthread_create_on_node+0x51/0x70
=> create_worker+0xcc/0x1a0
=> worker_thread+0x2ad/0x380
=> kthread+0xe9/0x110
=> ret_from_fork+0x2c/0x50

Changes since v1: https://lore.kernel.org/linux-trace-kernel/20230117044010.838685230@goodmis.org/

- Fixed an issue with passing a stacktrace variable to another variable.

- Can now use the stacktrace in the histogram as well:

  # echo 'hist:delta.buckets=100,stack.stacktrace:sort=delta' > events/synthetic/block_lat/trigger
  # cat events/synthetic/block_lat/hist
  
  # event histogram
  # 
  # trigger info: hist:keys=delta.buckets=100,stacktrace:vals=hitcount:sort=delta.buckets=100:size=2048 [active]
  # 
    
  { delta: ~ 0-99, stacktrace:      
           event_hist_trigger+0x464/0x480
           event_triggers_call+0x52/0xe0
           trace_event_buffer_commit+0x193/0x250
           trace_event_raw_event_sched_switch+0xfc/0x150
           __traceiter_sched_switch+0x41/0x60 
           __schedule+0x448/0x7b0
           schedule_idle+0x26/0x40
           cpu_startup_entry+0x19/0x20
           start_secondary+0xed/0xf0
           secondary_startup_64_no_verify+0xe0/0xeb
  } hitcount:          6
  { delta: ~ 0-99, stacktrace:
           event_hist_trigger+0x464/0x480
           event_triggers_call+0x52/0xe0
           trace_event_buffer_commit+0x193/0x250
           trace_event_raw_event_sched_switch+0xfc/0x150
           __traceiter_sched_switch+0x41/0x60
           __schedule+0x448/0x7b0
           schedule_idle+0x26/0x40
           cpu_startup_entry+0x19/0x20
           __pfx_kernel_init+0x0/0x10
           arch_call_rest_init+0xa/0x24
           start_kernel+0x964/0x98d
           secondary_startup_64_no_verify+0xe0/0xeb
  } hitcount:          3
[..]
  { delta: ~ 8500-8599, stacktrace:
           event_hist_trigger+0x464/0x480
           event_triggers_call+0x52/0xe0
           trace_event_buffer_commit+0x193/0x250
           trace_event_raw_event_sched_switch+0xfc/0x150
           __traceiter_sched_switch+0x41/0x60
           __schedule+0x448/0x7b0
           schedule_idle+0x26/0x40
           cpu_startup_entry+0x19/0x20
           start_secondary+0xed/0xf0
           secondary_startup_64_no_verify+0xe0/0xeb
  } hitcount:          1

  Totals:
      Hits: 89 
      Entries: 11
      Dropped: 0



Steven Rostedt (Google) (6):
      tracing: Simplify calculating entry size using struct_size()
      tracing: Allow stacktraces to be saved as histogram variables
      tracing: Allow synthetic events to pass around stacktraces
      tracing/histogram: Add stacktrace type
      tracing/histogram: Document variable stacktrace
      tracing/histogram: Add simple tests for stacktrace usage of synthetic events

----
 Documentation/trace/histogram.rst                  | 129 +++++++++++++++++++++
 kernel/trace/trace.c                               |   2 +-
 kernel/trace/trace.h                               |   4 +
 kernel/trace/trace_events_hist.c                   |  63 +++++++---
 kernel/trace/trace_events_synth.c                  |  83 ++++++++++++-
 kernel/trace/trace_synth.h                         |   1 +
 .../inter-event/trigger-synthetic-event-stack.tc   |  24 ++++
 .../inter-event/trigger-synthetic-event-syntax.tc  |   6 +
 8 files changed, 294 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc
