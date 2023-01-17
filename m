Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF57D66E200
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjAQPW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbjAQPWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:22:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A9B3C39;
        Tue, 17 Jan 2023 07:22:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C606D61484;
        Tue, 17 Jan 2023 15:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363BBC4339E;
        Tue, 17 Jan 2023 15:22:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pHnnI-001vj9-0y;
        Tue, 17 Jan 2023 10:22:36 -0500
Message-ID: <20230117152236.167046397@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 17 Jan 2023 10:21:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ross Zwisler <zwisler@google.com>,
        Ching-lin Yu <chinglinyu@google.com>
Subject: [PATCH 4/6 v2] tracing/histogram: Add stacktrace type
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

Now that stacktraces can be part of synthetic events, allow a key to be
typed as a stacktrace.

  # cd /sys/kernel/tracing
  # echo 's:block_lat u64 delta; unsigned long stack[];' >> dynamic_events
  # echo 'hist:keys=next_pid:ts=common_timestamp.usecs,st=stacktrace if prev_state == 2' >> events/sched/sched_switch/trigger
  # echo 'hist:keys=prev_pid:delta=common_timestamp.usecs-$ts,st2=$st:onmatch(sched.sched_switch).trace(block_lat,$delta,$st2)' >> events/sched/sched_switch/trigger
  # echo 'hist:keys=delta.buckets=100,stack.stacktrace:sort=delta' > events/synthetic/block_lat/trigger

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
  { delta: ~ 0-99, stacktrace:
           event_hist_trigger+0x464/0x480
           event_triggers_call+0x52/0xe0
           trace_event_buffer_commit+0x193/0x250
           trace_event_raw_event_sched_switch+0xfc/0x150
           __traceiter_sched_switch+0x41/0x60
           __schedule+0x448/0x7b0
           schedule+0x5a/0xb0
           worker_thread+0xaf/0x380
           kthread+0xe9/0x110
           ret_from_fork+0x2c/0x50
  } hitcount:          1
  { delta: ~ 100-199, stacktrace:
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
  } hitcount:         15
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

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 599c056b6048..888b7a394ce5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1716,6 +1716,8 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 		flags_str = "percent";
 	else if (hist_field->flags & HIST_FIELD_FL_GRAPH)
 		flags_str = "graph";
+	else if (hist_field->flags & HIST_FIELD_FL_STACKTRACE)
+		flags_str = "stacktrace";
 
 	return flags_str;
 }
@@ -2312,6 +2314,8 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 			*flags |= HIST_FIELD_FL_EXECNAME;
 		else if (strcmp(modifier, "syscall") == 0)
 			*flags |= HIST_FIELD_FL_SYSCALL;
+		else if (strcmp(modifier, "stacktrace") == 0)
+			*flags |= HIST_FIELD_FL_STACKTRACE;
 		else if (strcmp(modifier, "log2") == 0)
 			*flags |= HIST_FIELD_FL_LOG2;
 		else if (strcmp(modifier, "usecs") == 0)
-- 
2.39.0


