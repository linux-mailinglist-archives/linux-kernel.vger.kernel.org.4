Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EDF648F16
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 14:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiLJN7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 08:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiLJN6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 08:58:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6DF186FA
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 05:58:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C30160C1A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 13:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB354C433F1;
        Sat, 10 Dec 2022 13:58:27 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1p40N1-000kwM-0E;
        Sat, 10 Dec 2022 08:58:27 -0500
Message-ID: <20221210135826.943530120@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 10 Dec 2022 08:58:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Suggested-by: Clark Williams" <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 24/25] tracing/osnoise: Add preempt and/or irq disabled options
References: <20221210135750.425719934@goodmis.org>
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

The osnoise workload runs with preemption and IRQs enabled in such
a way as to allow all sorts of noise to disturb osnoise's execution.
hwlat tracer has a similar workload but works with irq disabled,
allowing only NMIs and the hardware to generate noise.

While thinking about adding an options file to hwlat tracer to
allow the system to panic, and other features I was thinking
to add, like having a tracepoint at each noise detection, it
came to my mind that is easier to make osnoise and also do
hardware latency detection than making hwlat "feature compatible"
with osnoise.

Other points are:
 - osnoise already has an independent cpu file.
 - osnoise has a more intuitive interface, e.g., runtime/period vs.
   window/width (and people often need help remembering what it is).
 - osnoise: tracepoints
 - osnoise stop options
 - osnoise options file itself

Moreover, the user-space side (in rtla) is simplified by reusing the
existing osnoise code.

Finally, people have been asking me about using osnoise for hw latency
detection, and I have to explain that it was sufficient but not
necessary. These options make it sufficient and necessary.

Adding a Suggested-by Clark, as he often asked me about this
possibility.

Link: https://lkml.kernel.org/r/d9c6c19135497054986900f94c8e47410b15316a.1670623111.git.bristot@kernel.org

Cc: Suggested-by: Clark Williams <williams@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 48 ++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 5a7613942223..94c1b5eb1dc0 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -55,10 +55,17 @@ enum osnoise_options_index {
 	OSN_DEFAULTS = 0,
 	OSN_WORKLOAD,
 	OSN_PANIC_ON_STOP,
+	OSN_PREEMPT_DISABLE,
+	OSN_IRQ_DISABLE,
 	OSN_MAX
 };
 
-static const char * const osnoise_options_str[OSN_MAX] = { "DEFAULTS", "OSNOISE_WORKLOAD", "PANIC_ON_STOP" };
+static const char * const osnoise_options_str[OSN_MAX] = {
+							"DEFAULTS",
+							"OSNOISE_WORKLOAD",
+							"PANIC_ON_STOP",
+							"OSNOISE_PREEMPT_DISABLE",
+							"OSNOISE_IRQ_DISABLE" };
 
 #define OSN_DEFAULT_OPTIONS		0x2
 static unsigned long osnoise_options	= OSN_DEFAULT_OPTIONS;
@@ -1308,18 +1315,26 @@ static void notify_new_max_latency(u64 latency)
  */
 static int run_osnoise(void)
 {
+	bool disable_irq = test_bit(OSN_IRQ_DISABLE, &osnoise_options);
 	struct osnoise_variables *osn_var = this_cpu_osn_var();
 	u64 start, sample, last_sample;
 	u64 last_int_count, int_count;
 	s64 noise = 0, max_noise = 0;
 	s64 total, last_total = 0;
 	struct osnoise_sample s;
+	bool disable_preemption;
 	unsigned int threshold;
 	u64 runtime, stop_in;
 	u64 sum_noise = 0;
 	int hw_count = 0;
 	int ret = -1;
 
+	/*
+	 * Disabling preemption is only required if IRQs are enabled,
+	 * and the options is set on.
+	 */
+	disable_preemption = !disable_irq && test_bit(OSN_PREEMPT_DISABLE, &osnoise_options);
+
 	/*
 	 * Considers the current thread as the workload.
 	 */
@@ -1335,6 +1350,15 @@ static int run_osnoise(void)
 	 */
 	threshold = tracing_thresh ? : 5000;
 
+	/*
+	 * Apply PREEMPT and IRQ disabled options.
+	 */
+	if (disable_irq)
+		local_irq_disable();
+
+	if (disable_preemption)
+		preempt_disable();
+
 	/*
 	 * Make sure NMIs see sampling first
 	 */
@@ -1422,16 +1446,21 @@ static int run_osnoise(void)
 		 * cond_resched()
 		 */
 		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
-			local_irq_disable();
+			if (!disable_irq)
+				local_irq_disable();
+
 			rcu_momentary_dyntick_idle();
-			local_irq_enable();
+
+			if (!disable_irq)
+				local_irq_enable();
 		}
 
 		/*
 		 * For the non-preemptive kernel config: let threads runs, if
-		 * they so wish.
+		 * they so wish, unless set not do to so.
 		 */
-		cond_resched();
+		if (!disable_irq && !disable_preemption)
+			cond_resched();
 
 		last_sample = sample;
 		last_int_count = int_count;
@@ -1450,6 +1479,15 @@ static int run_osnoise(void)
 	 */
 	barrier();
 
+	/*
+	 * Return to the preemptive state.
+	 */
+	if (disable_preemption)
+		preempt_enable();
+
+	if (disable_irq)
+		local_irq_enable();
+
 	/*
 	 * Save noise info.
 	 */
-- 
2.35.1


