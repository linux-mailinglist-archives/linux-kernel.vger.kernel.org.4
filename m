Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844B266D569
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 05:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjAQElZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 23:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbjAQElL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 23:41:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655211A48D;
        Mon, 16 Jan 2023 20:41:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F280C611B6;
        Tue, 17 Jan 2023 04:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D40C4339B;
        Tue, 17 Jan 2023 04:41:02 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pHdmP-001rt8-1K;
        Mon, 16 Jan 2023 23:41:01 -0500
Message-ID: <20230117044101.274203396@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 16 Jan 2023 23:40:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <zwisler@google.com>
Subject: [PATCH 4/5] tracing/histogram: Document variable stacktrace
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

Add a little documentation (and a useful example) of how a stacktrace can
be used within a histogram variable.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/histogram.rst | 49 +++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index f95459aa984f..5b7f985f35d9 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1786,6 +1786,8 @@ or assigned to a variable and referenced in a subsequent expression::
   # echo 'hist:keys=next_pid:us_per_sec=1000000 ...' >> event/trigger
   # echo 'hist:keys=next_pid:timestamp_secs=common_timestamp/$us_per_sec ...' >> event/trigger
 
+Variables can even hold stacktraces, which are useful with synthetic events.
+
 2.2.2 Synthetic Events
 ----------------------
 
@@ -1940,6 +1942,53 @@ the ".buckets" modifier and specify a size (in this case groups of 10).
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
 2.2.3 Hist trigger 'handlers' and 'actions'
 -------------------------------------------
 
-- 
2.39.0


