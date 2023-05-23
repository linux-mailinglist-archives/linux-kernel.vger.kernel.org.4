Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04B270E3D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbjEWRXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbjEWRXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:23:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6061390;
        Tue, 23 May 2023 10:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91B6063510;
        Tue, 23 May 2023 17:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007E3C4339C;
        Tue, 23 May 2023 17:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684862578;
        bh=byVxc842f341YKhh/NiVACrDBf3a2XL1VPHU0WLutWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7sjBh6vtLNKIOluj10arzB7akVjLk7/GZtNyp6H9vVDXtCOj2B+/Uf3SLnJ2s2un
         fipDDmjP/8LHJqucnYO0xn8fjYqKSl7uu9c0tQg0FrzaA8+zFnTbNWGnPppCMxW8EN
         uUvJNLsf6iFjHHXqBf/kResL5ElwD0AI5N7yPAbM+JuXdRP7CoBKVy1MbLeplP0y7W
         cqan4hpey5X+09b/5v3VyN4JhhhITxp+lTwFrH1PEo1Vyj7BqFKpiBVit9gGVNHdxu
         Dlfdu2QDjteTx8yEHrVs6lQx7RqLZjfx1pGD3Ox2pIYMsRHmGr9cYUforSpaTsv4vo
         4o6IrGzJCHlPg==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V2 1/3] tracing/osnoise: Switch from PF_NO_SETAFFINITY to migrate_disable
Date:   Tue, 23 May 2023 19:22:46 +0200
Message-Id: <da3faafe33b0757c38c1e714346710d8551d7bff.1684860626.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1684860626.git.bristot@kernel.org>
References: <cover.1684860626.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, osnoise/timerlat threads run with PF_NO_SETAFFINITY set.
It works well, however, cgroups do not allow PF_NO_SETAFFINITY threads
to be accepted, and this creates a limitation to osnoise/timerlat.

To avoid this limitation, disable migration of the threads as soon
as they start to run, and then clean the PF_NO_SETAFFINITY flag (still)
used during thread creation.

If for some reason a thread migration is requested, e.g., via
sched_settafinity, the tracer thread will notice and exit.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
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
2.38.1

