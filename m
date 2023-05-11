Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE326FF7B6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbjEKQps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbjEKQpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:45:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2BF7A80;
        Thu, 11 May 2023 09:45:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF6D964FCB;
        Thu, 11 May 2023 16:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81725C433D2;
        Thu, 11 May 2023 16:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683823530;
        bh=rS/seoN1+7P2xQ2x2xDH3JwrwIf+ALD+zNBvOwN/k84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gGhDrs0zKDL5WdeeRbee2+P+7nmNRUg8ffXzPlCkHBLiwrWi8Ef/1ImmmMN3i+Tzk
         /mqIQd/WRPYrRc+hlx0IE20R7Boi+00uyFv0B3BegteZhYsdxsyjIJwO5u/HmHj2sW
         PYhGtW8oCy6q6LSb25heIIG9641YZM9TOKuC9udHDWKZcLKbxvSyMlVsG+oJKJv1dV
         cmfKQ9I75PP4FPEogS7JGAEX7Ywg1UMSGD5z+IhCKxnwZot7AJ/dpB5Wv0QQr1kaLh
         4Lf/s7NmNkqQYJzxxt1jss1ygysVhUsT/l3vjw+i/RKuDb2U+QYkVefQcXVCLBsAbK
         mwYcmqa6VRtxQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/2] tracing/osnoise: Switch from PF_NO_SETAFFINITY to migrate_disable
Date:   Thu, 11 May 2023 18:45:19 +0200
Message-Id: <de45cbbaf2eb2795c4e1894db4fd0775dfc76f4b.1683823114.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1683823114.git.bristot@kernel.org>
References: <cover.1683823114.git.bristot@kernel.org>
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

