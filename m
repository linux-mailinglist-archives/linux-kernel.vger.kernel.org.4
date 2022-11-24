Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B1A637BD8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiKXOv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKXOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:51:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6C4134118
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:50:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE47CB82846
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A27CC4314D;
        Thu, 24 Nov 2022 14:50:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oyDYs-001X50-1L;
        Thu, 24 Nov 2022 09:50:46 -0500
Message-ID: <20221124145046.301211304@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Nov 2022 09:50:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 06/11] tracing/osnoise: Add OSNOISE_WORKLOAD option
References: <20221124145019.782980678@goodmis.org>
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

From: Daniel Bristot de Oliveira <bristot@kernel.org>

The osnoise tracer is not only a tracer, and a set of tracepoints,
but also a workload dispatcher.

In preparation for having other workloads, e.g., in user-space,
add an option to avoid dispatching the workload.

By not dispatching the workload, the osnoise: tracepoints become
generic events to measure the execution time of *any* task on Linux.

For example:

  # cd /sys/kernel/tracing/
  # cat osnoise/options
  DEFAULTS OSNOISE_WORKLOAD
  # echo NO_OSNOISE_WORKLOAD > osnoise/options
  # cat osnoise/options
  NO_DEFAULTS NO_OSNOISE_WORKLOAD
  # echo osnoise > set_event
  # echo osnoise > current_tracer
  # tail -8 trace
      make-94722   [002] d..3.  1371.794507: thread_noise:     make:94722 start 1371.794302286 duration 200897 ns
        sh-121042  [020] d..3.  1371.794534: thread_noise:       sh:121042 start 1371.781610976 duration 8943683 ns
      make-121097  [005] d..3.  1371.794542: thread_noise:     make:121097 start 1371.794481522 duration 60444 ns
     <...>-40      [005] d..3.  1371.794550: thread_noise: migration/5:40 start 1371.794542256 duration 7154 ns
    <idle>-0       [018] dNh2.  1371.794554: irq_noise: reschedule:253 start 1371.794553547 duration 40 ns
    <idle>-0       [018] dNh2.  1371.794561: irq_noise: local_timer:236 start 1371.794556222 duration 4890 ns
    <idle>-0       [018] .Ns2.  1371.794563: softirq_noise:    SCHED:7 start 1371.794561803 duration 992 ns
    <idle>-0       [018] d..3.  1371.794566: thread_noise: swapper/18:0 start 1371.781368110 duration 13191798 ns

In preparation for the rtla exec_time tracer/tool and
rtla osnoise --user option.

Link: https://lkml.kernel.org/r/f5cfbd37aefd419eefe9243b4d2fc38ed5753fe4.1668692096.git.bristot@kernel.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 17b77fe3950b..3f10dd1f2f1c 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -53,12 +53,13 @@
  */
 enum osnoise_options_index {
 	OSN_DEFAULTS = 0,
+	OSN_WORKLOAD,
 	OSN_MAX
 };
 
-static const char * const osnoise_options_str[OSN_MAX] = { "DEFAULTS" };
+static const char * const osnoise_options_str[OSN_MAX] = { "DEFAULTS", "OSNOISE_WORKLOAD" };
 
-#define OSN_DEFAULT_OPTIONS	0
+#define OSN_DEFAULT_OPTIONS	0x2
 unsigned long osnoise_options	= OSN_DEFAULT_OPTIONS;
 
 /*
@@ -1186,11 +1187,12 @@ trace_sched_switch_callback(void *data, bool preempt,
 			    unsigned int prev_state)
 {
 	struct osnoise_variables *osn_var = this_cpu_osn_var();
+	int workload = test_bit(OSN_WORKLOAD, &osnoise_options);
 
-	if (p->pid != osn_var->pid)
+	if ((p->pid != osn_var->pid) || !workload)
 		thread_exit(osn_var, p);
 
-	if (n->pid != osn_var->pid)
+	if ((n->pid != osn_var->pid) || !workload)
 		thread_entry(osn_var, n);
 }
 
@@ -1723,9 +1725,16 @@ static void stop_kthread(unsigned int cpu)
 	struct task_struct *kthread;
 
 	kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
-	if (kthread)
+	if (kthread) {
 		kthread_stop(kthread);
-	per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
+		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
+	} else {
+		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
+			per_cpu(per_cpu_osnoise_var, cpu).sampling = false;
+			barrier();
+			return;
+		}
+	}
 }
 
 /*
@@ -1759,6 +1768,13 @@ static int start_kthread(unsigned int cpu)
 		snprintf(comm, 24, "timerlat/%d", cpu);
 		main = timerlat_main;
 	} else {
+		/* if no workload, just return */
+		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
+			per_cpu(per_cpu_osnoise_var, cpu).sampling = true;
+			barrier();
+			return 0;
+		}
+
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 
-- 
2.35.1


