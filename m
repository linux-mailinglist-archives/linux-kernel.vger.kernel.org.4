Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA1266D567
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 05:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbjAQElP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 23:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbjAQElH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 23:41:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D60318AAE;
        Mon, 16 Jan 2023 20:41:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD0FC60FCA;
        Tue, 17 Jan 2023 04:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15649C433F1;
        Tue, 17 Jan 2023 04:41:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pHdmO-001rrA-2V;
        Mon, 16 Jan 2023 23:41:00 -0500
Message-ID: <20230117044010.838685230@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 16 Jan 2023 23:40:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH 0/5] tracing/histograms: Pass stacktrace from synthetic start event to end event
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

Steven Rostedt (Google) (5):
      tracing: Simplify calculating entry size using struct_size()
      tracing: Allow stacktraces to be saved as histogram variables
      tracing: Allow synthetic events to pass around stacktraces
      tracing/histogram: Document variable stacktrace
      tracing/histogram: Add simple tests for stacktrace usage of synthetic events

----
 Documentation/trace/histogram.rst                  | 49 +++++++++++++
 kernel/trace/trace.c                               |  2 +-
 kernel/trace/trace.h                               |  4 ++
 kernel/trace/trace_events_hist.c                   | 42 ++++++++---
 kernel/trace/trace_events_synth.c                  | 83 +++++++++++++++++++++-
 kernel/trace/trace_synth.h                         |  1 +
 .../inter-event/trigger-synthetic-event-stack.tc   | 24 +++++++
 .../inter-event/trigger-synthetic-event-syntax.tc  |  6 ++
 8 files changed, 196 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc
