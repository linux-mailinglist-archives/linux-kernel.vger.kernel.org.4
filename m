Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB44B65E214
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjAEAzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjAEAyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:54:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9658B4D725;
        Wed,  4 Jan 2023 16:51:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3592B61883;
        Thu,  5 Jan 2023 00:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E93C433F0;
        Thu,  5 Jan 2023 00:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672879887;
        bh=NWSPmqPtnSB+GjAOqFi44AyevCau+gcT+vefcRYY03w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M50iFfXGCcAnPZ8l78Kh9X49SXipU0UAVMQiAoCz6DVJ/5bbAMvbnMUjFloCWG99A
         PWodxkEnTq5cFcsKYdoAnOf/STsamLmqIIuvo99/KUcQ07KHGLM8SqDWqoXYQ4C3qf
         Ca86GmQLIPXlgSHqGiVGX3hxPzBjB9E9eClyITbBuJEqqwwJM9RloW0wRoN+3+ss9C
         GTsZFuLom8WXnGJ4JA8Z9MQYZPuCXYTUexMSx1kCoPGu4wnTpWGl3ts1Xv1dojOLso
         1UZj4nEAf8vV3u7NFKwzzETkbQNtEprR4kObiFXnivZtFVhyXRdA4GgXexsm0TjR/Q
         J670JA8N63SJQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5340F5C1456; Wed,  4 Jan 2023 16:51:27 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Zhen Lei <thunder.leizhen@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/6] sched: Add helper nr_context_switches_cpu()
Date:   Wed,  4 Jan 2023 16:51:23 -0800
Message-Id: <20230105005126.1772294-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105005105.GA1772125@paulmck-ThinkPad-P17-Gen-1>
References: <20230105005105.GA1772125@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Add a function nr_context_switches_cpu() that returns  number of context
switches since boot on the specified CPU.  This information will be used
to diagnose RCU CPU stalls.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kernel_stat.h | 1 +
 kernel/sched/core.c         | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 898076e173a92..9935f7ecbfb9e 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -52,6 +52,7 @@ DECLARE_PER_CPU(struct kernel_cpustat, kernel_cpustat);
 #define kstat_cpu(cpu) per_cpu(kstat, cpu)
 #define kcpustat_cpu(cpu) per_cpu(kernel_cpustat, cpu)
 
+extern unsigned long long nr_context_switches_cpu(int cpu);
 extern unsigned long long nr_context_switches(void);
 
 extern unsigned int kstat_irqs_cpu(unsigned int irq, int cpu);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 25b582b6ee5f7..2e40a6c116e1c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5282,6 +5282,11 @@ bool single_task_running(void)
 }
 EXPORT_SYMBOL(single_task_running);
 
+unsigned long long nr_context_switches_cpu(int cpu)
+{
+	return cpu_rq(cpu)->nr_switches;
+}
+
 unsigned long long nr_context_switches(void)
 {
 	int i;
-- 
2.31.1.189.g2e36527f23

