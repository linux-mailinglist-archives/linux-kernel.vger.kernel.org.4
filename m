Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DF873CC5D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 20:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbjFXS2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 14:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjFXS2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 14:28:30 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C581BC1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 11:28:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0VlplJJJ_1687631295;
Received: from rt2b04371.sqa.tbc.tbsite.net(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0VlplJJJ_1687631295)
          by smtp.aliyun-inc.com;
          Sun, 25 Jun 2023 02:28:23 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        josh@joshtriplett.org, boqun.feng@gmail.com,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang1.zhang@intel.com, jstultz@google.com,
        clingutla@codeaurora.org, nsaenzju@redhat.com, tglx@linutronix.de,
        frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/core: introduce sched_core_idle_cpu()
Date:   Sun, 25 Jun 2023 02:28:15 +0800
Message-Id: <1687631295-126383-1-git-send-email-CruzZhao@linux.alibaba.com>
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

As core scheduling introduced, a new state of idle is defined as
force idle, running idle task but nr_running greater than zero.

If a cpu is in force idle state, idle_cpu() will return zero. This
result makes sense in certain scenarios, e.g., load balance. but
this will cause error in other scenarios, e.g., tick_irq_exit()
will not change ts->idle_active back to 1 because idle_cpu() returns
0 when force idle.

To solve this problem, we introduce sched_core_idle_cpu(), which
returns 1 when force idle. We audit all users of idle_cpu(), and
change idle_cpu() into sched_core_idle_cpu() in the following
functions:
  - showacpu()
  - rcu_is_rcuc_kthread_starving()
  - tick_irq_exit()

v1-->v2: replace idle_cpu() with sched_core_idle_cpu() in function
showacpu() and rcu_is_rcuc_kthread_starving()

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 drivers/tty/sysrq.c     |  2 +-
 include/linux/sched.h   |  2 ++
 kernel/rcu/tree_stall.h |  2 +-
 kernel/sched/core.c     | 13 +++++++++++++
 kernel/softirq.c        |  2 +-
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index b6e70c5cfa17..8a6586800385 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -232,7 +232,7 @@ static void showacpu(void *dummy)
 	unsigned long flags;
 
 	/* Idle CPUs have no interesting backtrace. */
-	if (idle_cpu(smp_processor_id())) {
+	if (sched_core_idle_cpu(smp_processor_id())) {
 		pr_info("CPU%d: backtrace skipped as idling\n", smp_processor_id());
 		return;
 	}
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
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b10b8349bb2a..6169faf30ecd 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -418,7 +418,7 @@ static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp
 		return false;
 
 	cpu = task_cpu(rcuc);
-	if (cpu_is_offline(cpu) || idle_cpu(cpu))
+	if (cpu_is_offline(cpu) || sched_core_idle_cpu(cpu))
 		return false;
 
 	j = jiffies - READ_ONCE(rdp->rcuc_activity);
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

