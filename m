Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5245772475B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbjFFPMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238391AbjFFPMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:12:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4776EE40;
        Tue,  6 Jun 2023 08:12:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDCF9629C8;
        Tue,  6 Jun 2023 15:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E38DC4339B;
        Tue,  6 Jun 2023 15:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686064364;
        bh=TUuQCM3jhirEhMqYofGh/R4e0sG21Hal+fI5biqfXTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uJJRuHpvRKBZaGY1ZkGv4N2KFZAchtA2sM4jT01xcS7mPrI5y0sXKZkLB4ACtqLQ/
         asvk9jxSTJhN69F4LxkrmmzxF+4QaUXZmmeaSmIBT5ahi02mIWxVqHNpiDqUH30Te4
         reoHmnOc4riJd0lEQa9+vmZ5lddeXBXVgQiCoYl85mr1It2s6h8k2GTjrNjQeqybbp
         Ilqan/az9p3aM4S8LV2+ZLVe2mKWc1VXnwIL0FuAKFkeFCGcUtqa59ug4uqs4/K9/W
         2DSzKNZfejUtyOc2mjMaPya/XVXEBRkH0C55R0shaAeOeh6JNia/vm/0Fx9SofYHAe
         SVcJrGAliFiKw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V3 2/3] tracing/osnoise: Skip running osnoise if all instances are off
Date:   Tue,  6 Jun 2023 17:12:26 +0200
Message-Id: <aa4dd9b7e76fcb63901fe5407e15ec002b318599.1686063934.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1686063934.git.bristot@kernel.org>
References: <cover.1686063934.git.bristot@kernel.org>
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

In the case of all tracing instances being off, sleep for the entire
period.

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
Cc: Jonathan Corbet <corbet@lwn.net>
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

