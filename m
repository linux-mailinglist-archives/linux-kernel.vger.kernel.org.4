Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB9E738B34
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjFUQah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjFUQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:29:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E087710CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:29:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 673EC61625
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4185AC433C9;
        Wed, 21 Jun 2023 16:29:47 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qC0iI-001ynJ-0y;
        Wed, 21 Jun 2023 12:29:46 -0400
Message-ID: <20230621162946.120464083@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 21 Jun 2023 12:29:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 09/13] tracing/osnoise: Switch from PF_NO_SETAFFINITY to migrate_disable
References: <20230621162923.953123395@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Currently, osnoise/timerlat threads run with PF_NO_SETAFFINITY set.
It works well, however, cgroups do not allow PF_NO_SETAFFINITY threads
to be accepted, and this creates a limitation to osnoise/timerlat.

To avoid this limitation, disable migration of the threads as soon
as they start to run, and then clean the PF_NO_SETAFFINITY flag (still)
used during thread creation.

If for some reason a thread migration is requested, e.g., via
sched_settafinity, the tracer thread will notice and exit.

Link: https://lkml.kernel.org/r/8ba8bc9c15b3ea40cf73cf67a9bc061a264609f0.1686063934.git.bristot@kernel.org

Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: William White <chwhite@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 68 ++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index e97e3fa5cbed..c265ec5f1726 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1545,6 +1545,39 @@ static void osnoise_sleep(void)
 	}
 }
 
+/*
+ * osnoise_migration_pending - checks if the task needs to migrate
+ *
+ * osnoise/timerlat threads are per-cpu. If there is a pending request to
+ * migrate the thread away from the current CPU, something bad has happened.
+ * Play the good citizen and leave.
+ *
+ * Returns 0 if it is safe to continue, 1 otherwise.
+ */
+static inline int osnoise_migration_pending(void)
+{
+	if (!current->migration_pending)
+		return 0;
+
+	/*
+	 * If migration is pending, there is a task waiting for the
+	 * tracer to enable migration. The tracer does not allow migration,
+	 * thus: taint and leave to unblock the blocked thread.
+	 */
+	osnoise_taint("migration requested to osnoise threads, leaving.");
+
+	/*
+	 * Unset this thread from the threads managed by the interface.
+	 * The tracers are responsible for cleaning their env before
+	 * exiting.
+	 */
+	mutex_lock(&interface_lock);
+	this_cpu_osn_var()->kthread = NULL;
+	mutex_unlock(&interface_lock);
+
+	return 1;
+}
+
 /*
  * osnoise_main - The osnoise detection kernel thread
  *
@@ -1553,12 +1586,29 @@ static void osnoise_sleep(void)
  */
 static int osnoise_main(void *data)
 {
+	unsigned long flags;
+
+	/*
+	 * This thread was created pinned to the CPU using PF_NO_SETAFFINITY.
+	 * The problem is that cgroup does not allow PF_NO_SETAFFINITY thread.
+	 *
+	 * To work around this limitation, disable migration and remove the
+	 * flag.
+	 */
+	migrate_disable();
+	raw_spin_lock_irqsave(&current->pi_lock, flags);
+	current->flags &= ~(PF_NO_SETAFFINITY);
+	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
 
 	while (!kthread_should_stop()) {
+		if (osnoise_migration_pending())
+			break;
+
 		run_osnoise();
 		osnoise_sleep();
 	}
 
+	migrate_enable();
 	return 0;
 }
 
@@ -1706,6 +1756,7 @@ static int timerlat_main(void *data)
 	struct timerlat_variables *tlat = this_cpu_tmr_var();
 	struct timerlat_sample s;
 	struct sched_param sp;
+	unsigned long flags;
 	u64 now, diff;
 
 	/*
@@ -1714,6 +1765,18 @@ static int timerlat_main(void *data)
 	sp.sched_priority = DEFAULT_TIMERLAT_PRIO;
 	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
 
+	/*
+	 * This thread was created pinned to the CPU using PF_NO_SETAFFINITY.
+	 * The problem is that cgroup does not allow PF_NO_SETAFFINITY thread.
+	 *
+	 * To work around this limitation, disable migration and remove the
+	 * flag.
+	 */
+	migrate_disable();
+	raw_spin_lock_irqsave(&current->pi_lock, flags);
+	current->flags &= ~(PF_NO_SETAFFINITY);
+	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
+
 	tlat->count = 0;
 	tlat->tracing_thread = false;
 
@@ -1731,6 +1794,7 @@ static int timerlat_main(void *data)
 	osn_var->sampling = 1;
 
 	while (!kthread_should_stop()) {
+
 		now = ktime_to_ns(hrtimer_cb_get_time(&tlat->timer));
 		diff = now - tlat->abs_period;
 
@@ -1749,10 +1813,14 @@ static int timerlat_main(void *data)
 			if (time_to_us(diff) >= osnoise_data.stop_tracing_total)
 				osnoise_stop_tracing();
 
+		if (osnoise_migration_pending())
+			break;
+
 		wait_next_period(tlat);
 	}
 
 	hrtimer_cancel(&tlat->timer);
+	migrate_enable();
 	return 0;
 }
 #else /* CONFIG_TIMERLAT_TRACER */
-- 
2.39.2
