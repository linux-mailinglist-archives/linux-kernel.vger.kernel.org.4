Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DB3738B36
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjFUQad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjFUQ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:29:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AB9171C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:29:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C77961627
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D0DC433C0;
        Wed, 21 Jun 2023 16:29:47 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qC0iI-001ynt-1c;
        Wed, 21 Jun 2023 12:29:46 -0400
Message-ID: <20230621162946.318422585@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 21 Jun 2023 12:29:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 10/13] tracing/osnoise: Skip running osnoise if all instances are off
References: <20230621162923.953123395@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

In the case of all tracing instances being off, sleep for the entire
period.

 Q: Why not kill all threads so?
 A: It is valid and useful to start the threads with tracing off.
For example, rtla disables tracing, starts the tracer, applies the
scheduling setup to the threads, e.g., sched priority and cgroup,
and then begin tracing with all set.

Skipping the period helps to speed up rtla setup and save the
trace after a stop tracing.

Link: https://lkml.kernel.org/r/aa4dd9b7e76fcb63901fe5407e15ec002b318599.1686063934.git.bristot@kernel.org

Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: William White <chwhite@redhat.com>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index c265ec5f1726..220172cb874d 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1285,6 +1285,22 @@ static __always_inline void osnoise_stop_tracing(void)
 	rcu_read_unlock();
 }
 
+/*
+ * osnoise_has_tracing_on - Check if there is at least one instance on
+ */
+static __always_inline int osnoise_has_tracing_on(void)
+{
+	struct osnoise_instance *inst;
+	int trace_is_on = 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(inst, &osnoise_instances, list)
+		trace_is_on += tracer_tracing_is_on(inst->tr);
+	rcu_read_unlock();
+
+	return trace_is_on;
+}
+
 /*
  * notify_new_max_latency - Notify a new max latency via fsnotify interface.
  */
@@ -1517,13 +1533,16 @@ static struct cpumask save_cpumask;
 /*
  * osnoise_sleep - sleep until the next period
  */
-static void osnoise_sleep(void)
+static void osnoise_sleep(bool skip_period)
 {
 	u64 interval;
 	ktime_t wake_time;
 
 	mutex_lock(&interface_lock);
-	interval = osnoise_data.sample_period - osnoise_data.sample_runtime;
+	if (skip_period)
+		interval = osnoise_data.sample_period;
+	else
+		interval = osnoise_data.sample_period - osnoise_data.sample_runtime;
 	mutex_unlock(&interface_lock);
 
 	/*
@@ -1604,8 +1623,14 @@ static int osnoise_main(void *data)
 		if (osnoise_migration_pending())
 			break;
 
+		/* skip a period if tracing is off on all instances */
+		if (!osnoise_has_tracing_on()) {
+			osnoise_sleep(true);
+			continue;
+		}
+
 		run_osnoise();
-		osnoise_sleep();
+		osnoise_sleep(false);
 	}
 
 	migrate_enable();
-- 
2.39.2
