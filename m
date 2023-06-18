Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8F5734729
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 19:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjFRRDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 13:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjFRRDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 13:03:04 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CC0B7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 10:02:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VlMn5WT_1687107761;
Received: from rt2b04371.sqa.tbc.tbsite.net(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VlMn5WT_1687107761)
          by smtp.aliyun-inc.com;
          Mon, 19 Jun 2023 01:02:54 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, nsaenzju@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: fix inaccurate idle stat in /proc/stat when force idle
Date:   Mon, 19 Jun 2023 01:02:40 +0800
Message-Id: <1687107760-111340-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When force idle, rq->curr == rq->idle but rq->nr_running > 0, results
that idle_cpu() returns 0. In function tick_irq_exit(), if idle_cpu()
is 0, tick_nohz_irq_exit() will not be called, and ts->idle_active will
not become 1, which became 0 in tick_nohz_irq_enter().
ts->idle_sleeptime won't update in function update_ts_time_stats(), if
ts->idle_active is 0, which should be 1. And this bug will result that
ts->idle_sleeptime is less than the actual value, and finally will
result that the idle time in /proc/stat is less than the actual value.

To fix this problem, we introduce sched_core_idle_cpu(), which returns
true when force idle, and we change the judgment criteria from
idle_cpu() to sched_core_idle_cpu() in function tick_irq_exit().

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 include/linux/sched.h |  2 ++
 kernel/sched/core.c   | 13 +++++++++++++
 kernel/softirq.c      |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b09a83bfad8b..73e61c0f10a7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2430,9 +2430,11 @@ extern void sched_core_free(struct task_struct *tsk);
 extern void sched_core_fork(struct task_struct *p);
 extern int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 				unsigned long uaddr);
+extern int sched_core_idle_cpu(int cpu);
 #else
 static inline void sched_core_free(struct task_struct *tsk) { }
 static inline void sched_core_fork(struct task_struct *p) { }
+static inline int sched_core_idle_cpu(int cpu) { return idle_cpu(cpu); }
 #endif
 
 extern void sched_set_stop_task(int cpu, struct task_struct *stop);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 71c1a0f232b4..c80088956987 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7286,6 +7286,19 @@ struct task_struct *idle_task(int cpu)
 	return cpu_rq(cpu)->idle;
 }
 
+#ifdef CONFIG_SCHED_CORE
+int sched_core_idle_cpu(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	if (sched_core_enabled(rq) && rq->curr == rq->idle)
+		return 1;
+
+	return idle_cpu(cpu);
+}
+
+#endif
+
 #ifdef CONFIG_SMP
 /*
  * This function computes an effective utilization for the given CPU, to be
diff --git a/kernel/softirq.c b/kernel/softirq.c
index c8a6913c067d..98b98991ce45 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -630,7 +630,7 @@ static inline void tick_irq_exit(void)
 	int cpu = smp_processor_id();
 
 	/* Make sure that timer wheel updates are propagated */
-	if ((idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
+	if ((sched_core_idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
 		if (!in_hardirq())
 			tick_nohz_irq_exit();
 	}
-- 
2.27.0

