Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E9369A321
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjBQAu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjBQAuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:50:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B86B55E7D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 16:50:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E1F460C7A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DC3C433AF;
        Fri, 17 Feb 2023 00:50:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pSoxT-000qOr-1V;
        Thu, 16 Feb 2023 19:50:39 -0500
Message-ID: <20230217005039.277248689@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 16 Feb 2023 19:49:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 5/5] tracing/histogram: Fix stacktrace histogram Documententation
References: <20230217004954.719324747@goodmis.org>
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

From: Tom Zanussi <zanussi@kernel.org>

Fix a small problem with the histogram specification in the
Documentation, and change the example to show output using a
stacktrace field rather than the global stacktrace.

Link: https://lkml.kernel.org/r/f75f807dd4998249e513515f703a2ff7407605f4.1676063532.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/histogram.rst | 156 +++++++++++++++++-------------
 1 file changed, 90 insertions(+), 66 deletions(-)

diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 8e95295e39b6..c5cfc6e7baea 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -1993,82 +1993,106 @@ uninterruptible state::
 A synthetic event that has a stacktrace field may use it as a key in
 histogram::
 
-  # echo 'hist:delta.buckets=100,stack.stacktrace:sort=delta' > events/synthetic/block_lat/trigger
+  # echo 'hist:keys=delta.buckets=100,stack.stacktrace:sort=delta' > events/synthetic/block_lat/trigger
   # cat events/synthetic/block_lat/hist
 
   # event histogram
   #
-  # trigger info: hist:keys=delta.buckets=100,stacktrace:vals=hitcount:sort=delta.buckets=100:size=2048 [active]
+  # trigger info: hist:keys=delta.buckets=100,stack.stacktrace:vals=hitcount:sort=delta.buckets=100:size=2048 [active]
   #
-
-  { delta: ~ 0-99, stacktrace:
-           event_hist_trigger+0x464/0x480
-           event_triggers_call+0x52/0xe0
-           trace_event_buffer_commit+0x193/0x250
-           trace_event_raw_event_sched_switch+0xfc/0x150
-           __traceiter_sched_switch+0x41/0x60
-           __schedule+0x448/0x7b0
-           schedule_idle+0x26/0x40
-           cpu_startup_entry+0x19/0x20
-           start_secondary+0xed/0xf0
-           secondary_startup_64_no_verify+0xe0/0xeb
-  } hitcount:          6
-  { delta: ~ 0-99, stacktrace:
-           event_hist_trigger+0x464/0x480
-           event_triggers_call+0x52/0xe0
-           trace_event_buffer_commit+0x193/0x250
-           trace_event_raw_event_sched_switch+0xfc/0x150
-           __traceiter_sched_switch+0x41/0x60
-           __schedule+0x448/0x7b0
-           schedule_idle+0x26/0x40
-           cpu_startup_entry+0x19/0x20
-           __pfx_kernel_init+0x0/0x10
-           arch_call_rest_init+0xa/0x24
-           start_kernel+0x964/0x98d
-           secondary_startup_64_no_verify+0xe0/0xeb
+  { delta: ~ 0-99, stack.stacktrace         __schedule+0xa19/0x1520
+         schedule+0x6b/0x110
+         io_schedule+0x46/0x80
+         bit_wait_io+0x11/0x80
+         __wait_on_bit+0x4e/0x120
+         out_of_line_wait_on_bit+0x8d/0xb0
+         __wait_on_buffer+0x33/0x40
+         jbd2_journal_commit_transaction+0x155a/0x19b0
+         kjournald2+0xab/0x270
+         kthread+0xfa/0x130
+         ret_from_fork+0x29/0x50
+  } hitcount:          1
+  { delta: ~ 0-99, stack.stacktrace         __schedule+0xa19/0x1520
+         schedule+0x6b/0x110
+         io_schedule+0x46/0x80
+         rq_qos_wait+0xd0/0x170
+         wbt_wait+0x9e/0xf0
+         __rq_qos_throttle+0x25/0x40
+         blk_mq_submit_bio+0x2c3/0x5b0
+         __submit_bio+0xff/0x190
+         submit_bio_noacct_nocheck+0x25b/0x2b0
+         submit_bio_noacct+0x20b/0x600
+         submit_bio+0x28/0x90
+         ext4_bio_write_page+0x1e0/0x8c0
+         mpage_submit_page+0x60/0x80
+         mpage_process_page_bufs+0x16c/0x180
+         mpage_prepare_extent_to_map+0x23f/0x530
+  } hitcount:          1
+  { delta: ~ 0-99, stack.stacktrace         __schedule+0xa19/0x1520
+         schedule+0x6b/0x110
+         schedule_hrtimeout_range_clock+0x97/0x110
+         schedule_hrtimeout_range+0x13/0x20
+         usleep_range_state+0x65/0x90
+         __intel_wait_for_register+0x1c1/0x230 [i915]
+         intel_psr_wait_for_idle_locked+0x171/0x2a0 [i915]
+         intel_pipe_update_start+0x169/0x360 [i915]
+         intel_update_crtc+0x112/0x490 [i915]
+         skl_commit_modeset_enables+0x199/0x600 [i915]
+         intel_atomic_commit_tail+0x7c4/0x1080 [i915]
+         intel_atomic_commit_work+0x12/0x20 [i915]
+         process_one_work+0x21c/0x3f0
+         worker_thread+0x50/0x3e0
+         kthread+0xfa/0x130
   } hitcount:          3
-  { delta: ~ 0-99, stacktrace:
-           event_hist_trigger+0x464/0x480
-           event_triggers_call+0x52/0xe0
-           trace_event_buffer_commit+0x193/0x250
-           trace_event_raw_event_sched_switch+0xfc/0x150
-           __traceiter_sched_switch+0x41/0x60
-           __schedule+0x448/0x7b0
-           schedule+0x5a/0xb0
-           worker_thread+0xaf/0x380
-           kthread+0xe9/0x110
-           ret_from_fork+0x2c/0x50
+  { delta: ~ 0-99, stack.stacktrace         __schedule+0xa19/0x1520
+         schedule+0x6b/0x110
+         schedule_timeout+0x11e/0x160
+         __wait_for_common+0x8f/0x190
+         wait_for_completion+0x24/0x30
+         __flush_work.isra.0+0x1cc/0x360
+         flush_work+0xe/0x20
+         drm_mode_rmfb+0x18b/0x1d0 [drm]
+         drm_mode_rmfb_ioctl+0x10/0x20 [drm]
+         drm_ioctl_kernel+0xb8/0x150 [drm]
+         drm_ioctl+0x243/0x560 [drm]
+         __x64_sys_ioctl+0x92/0xd0
+         do_syscall_64+0x59/0x90
+         entry_SYSCALL_64_after_hwframe+0x72/0xdc
   } hitcount:          1
-  { delta: ~ 100-199, stacktrace:
-           event_hist_trigger+0x464/0x480
-           event_triggers_call+0x52/0xe0
-           trace_event_buffer_commit+0x193/0x250
-           trace_event_raw_event_sched_switch+0xfc/0x150
-           __traceiter_sched_switch+0x41/0x60
-           __schedule+0x448/0x7b0
-           schedule_idle+0x26/0x40
-           cpu_startup_entry+0x19/0x20
-           start_secondary+0xed/0xf0
-           secondary_startup_64_no_verify+0xe0/0xeb
-  } hitcount:         15
-  [..]
-  { delta: ~ 8500-8599, stacktrace:
-           event_hist_trigger+0x464/0x480
-           event_triggers_call+0x52/0xe0
-           trace_event_buffer_commit+0x193/0x250
-           trace_event_raw_event_sched_switch+0xfc/0x150
-           __traceiter_sched_switch+0x41/0x60
-           __schedule+0x448/0x7b0
-           schedule_idle+0x26/0x40
-           cpu_startup_entry+0x19/0x20
-           start_secondary+0xed/0xf0
-           secondary_startup_64_no_verify+0xe0/0xeb
+  { delta: ~ 0-99, stack.stacktrace         __schedule+0xa19/0x1520
+         schedule+0x6b/0x110
+         schedule_timeout+0x87/0x160
+         __wait_for_common+0x8f/0x190
+         wait_for_completion_timeout+0x1d/0x30
+         drm_atomic_helper_wait_for_flip_done+0x57/0x90 [drm_kms_helper]
+         intel_atomic_commit_tail+0x8ce/0x1080 [i915]
+         intel_atomic_commit_work+0x12/0x20 [i915]
+         process_one_work+0x21c/0x3f0
+         worker_thread+0x50/0x3e0
+         kthread+0xfa/0x130
+         ret_from_fork+0x29/0x50
+  } hitcount:          1
+  { delta: ~ 100-199, stack.stacktrace         __schedule+0xa19/0x1520
+         schedule+0x6b/0x110
+         schedule_hrtimeout_range_clock+0x97/0x110
+         schedule_hrtimeout_range+0x13/0x20
+         usleep_range_state+0x65/0x90
+         pci_set_low_power_state+0x17f/0x1f0
+         pci_set_power_state+0x49/0x250
+         pci_finish_runtime_suspend+0x4a/0x90
+         pci_pm_runtime_suspend+0xcb/0x1b0
+         __rpm_callback+0x48/0x120
+         rpm_callback+0x67/0x70
+         rpm_suspend+0x167/0x780
+         rpm_idle+0x25a/0x380
+         pm_runtime_work+0x93/0xc0
+         process_one_work+0x21c/0x3f0
   } hitcount:          1
 
   Totals:
-      Hits: 89
-      Entries: 11
-      Dropped: 0
+    Hits: 10
+    Entries: 7
+    Dropped: 0
 
 2.2.3 Hist trigger 'handlers' and 'actions'
 -------------------------------------------
-- 
2.39.1
