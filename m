Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF03C6FF7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 18:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbjEKQpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 12:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238393AbjEKQpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:45:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D887DBC;
        Thu, 11 May 2023 09:45:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F3B164FCE;
        Thu, 11 May 2023 16:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D379FC4339E;
        Thu, 11 May 2023 16:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683823532;
        bh=QN31lfcfV4O5vC4vDBplSjYRBUdS3kX3MOlPv3M48gA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qlWBJQzL3XbMbfNHEK7VwFmY+piyLj0vKqtx5D3w8PA1M74Sg+Q7yveaaxCmZii0l
         8gEU22I8FauCQ0j+cnmMrfVCSA6A/k7EkImr8QgHbpaTIN6MU75D45JHWF5YmRggAN
         OzdxxczcXuMIPDuuWc0vpwPlTj8SHw0k6tayK6bfykq96TO7BPimV+iO7gd+W840eq
         +gDjtLmD4eofrvzT67REcg2TsMvoXg+Jv4nBXVn0/WjM0ZGghoCdcVW02UDrBGZw1z
         tvJSq+9wTO2VMeCJ+OVmguVdxxvPdC7zl2oyjFyiPlZHWpKofFFlKESSEWaBhKwFgi
         /Kn/i5cgrv38w==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/2] tracing/osnoise: Skip running osnoise if all instances are off
Date:   Thu, 11 May 2023 18:45:20 +0200
Message-Id: <c052d44430b3756e06ae852aa1830f07dfbdaf14.1683823114.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1683823114.git.bristot@kernel.org>
References: <cover.1683823114.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of all tracing instances being off, sleep for the entire period.

 Q: Why not kill all threads so?
 A: It is valid and useful to start the threads with tracing off.
For example, rtla disables tracing, starts the tracer, applies the
scheduling setup to the threads, e.g., sched priority and cgroup,
and then begin tracing with all set.

Skipping the period helps to speed up rtla setup and save the
trace after a stop tracing.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
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
2.38.1

