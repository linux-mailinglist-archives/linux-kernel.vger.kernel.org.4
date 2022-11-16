Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6E862B467
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiKPH7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiKPH7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:59:40 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FA6C7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:59:39 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x11-20020a056a000bcb00b0056c6ec11eefso9352997pfu.14
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Yx3hruW+9J71DEKe9UfpU1h/qKMqxTS0D2Vr6oFr1g=;
        b=BeKPVtw938FgpE2fj5tbX0/xEYCMV7j4HPSZT9yK4HfbwlBapDncQLYGz0imOhWMRo
         nZ23AgSsBznN+yiJ4hnMJgwNvo8W3lmSmCVppq9zzTAdcjIs9VOHrTDisssRdWupkUiN
         GfG+lIvkJGiJ3kpfkc2xrnx9AebesJNqVqY6f0ovXKFavDz4SclJCEUeaF3sMtRm6DBh
         p/0ZhckxElVomontjl4KA9uZ9+y64hN8H9pdQP3FbgiwFsFKpl6rgYL7BSFpw3vBjd/v
         r4wJ9qGpBddA1NG9ocHfHdaM+6pQVlHzGnlwaxzxbQCIAwssvG2H2QV70xnmXU9luvVn
         G7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Yx3hruW+9J71DEKe9UfpU1h/qKMqxTS0D2Vr6oFr1g=;
        b=jkruDA4bmNf6P6Kt42Y88A6lACz+5zMJjq2I8B7wkPt7NfDvAt+p/Aoit1g0T46RO7
         NoBG5igJpvg0pkj4cKZQLBrhvaNaYFhF++XpdaO+04c7Q2t0lE8ukWdFljs6hC3jVXsn
         Q4H/FWjEOX9RtDz4VpfgB5DYe/t+yh7BhqJ6ZsGGd3qtMW6MmAfEjy/jE6etB86FRk+Q
         HuIGE9ggO2QMzRJxl6hcGSGR5RW3AUyXx/lRubxSNzgVztrMCSzo0+SNtcqbEf/3mKR+
         nOWukmZrLC9PDD2iGo/bRRDSHZDKqiUqlOSkEv+iSqPMA2U/z0r8btlud3av3tZjzumC
         yfmQ==
X-Gm-Message-State: ANoB5pnika6DibfLvtZiKELRCDCTOw2t4vZ8YhN+aKEwd34xRzhX9/oT
        nKRq5xSbgP1qeA8YuwzoWaaoSIrOTvmVGyE8NeWTCCyagMpBtMuaIM1Rt/O5jmgfrAf6IMhAd9j
        Psm2rRL9fiky754gNnrNv2LXEqqnMN8nfr9tHDG1BscInlV3icl9vX/2RgOC5lFRMfL3e9SQ=
X-Google-Smtp-Source: AA0mqf5REgd3La0c0BUKsNCQTlYjigyvXiB15pYfzbJ/8LOJjZ9R8v//NstnmmHG+svikd4dvpNnclE2cDnr
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a17:902:b183:b0:186:d5b9:fbcd with SMTP id
 s3-20020a170902b18300b00186d5b9fbcdmr8083893plr.64.1668585578685; Tue, 15 Nov
 2022 23:59:38 -0800 (PST)
Date:   Wed, 16 Nov 2022 07:59:27 +0000
In-Reply-To: <20221116075929.453876-1-jstultz@google.com>
Mime-Version: 1.0
References: <20221116075929.453876-1-jstultz@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221116075929.453876-3-jstultz@google.com>
Subject: [PATCH v5 2/3] sched: Avoid placing RT threads on cores handling long softirqs
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Connor O'Brien" <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qyousef@google.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        kernel-team@android.com, "J . Avila" <elavila@google.com>,
        John Stultz <jstultz@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Connor O'Brien <connoro@google.com>

In certain audio use cases, scheduling RT threads on cores that
are handling softirqs can lead to glitches. Prevent this
behavior in cases where the softirq is likely to take a long
time. To avoid unnecessary migrations, the old behavior is
preserved for RCU, SCHED and TIMER irqs which are expected to be
relatively quick.

This patch reworks and combines two related changes originally
by John Dias <joaodias@google.com>

Cc: John Dias <joaodias@google.com>
Cc: Connor O'Brien <connoro@google.com>
Cc: Rick Yiu <rickyiu@google.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Qais Yousef <qyousef@google.com>
Cc: Chris Redpath <chris.redpath@arm.com>
Cc: Abhijeet Dharmapurikar <adharmap@quicinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: kernel-team@android.com
Signed-off-by: John Dias <joaodias@google.com>
[elavila: Port to mainline, amend commit text]
Signed-off-by: J. Avila <elavila@google.com>
[connoro: Reworked, simplified, and merged two patches together]
Signed-off-by: Connor O'Brien <connoro@google.com>
[jstultz: Further simplified and fixed issues, reworded commit
 message, removed arm64-isms]
Signed-off-by: John Stultz <jstultz@google.com>
---
v2:
* Reformatted Kconfig entry to match coding style
  (Reported-by: Randy Dunlap <rdunlap@infradead.org>)
* Made rt_task_fits_capacity_and_may_preempt static to
  avoid warnings (Reported-by: kernel test robot <lkp@intel.com>)
* Rework to use preempt_count and drop kconfig dependency on ARM64
v3:
* Use introduced __cpu_softirq_pending() to avoid s390 build
  issues (Reported-by: kernel test robot <lkp@intel.com>)
v4:
* Drop TASKLET_SOFTIRQ from LONG_SOFTIRQS (suggested by Qais)
* Depend on !PREEMPT_RT (Suggested by Qais)
* Larger simplification of logic (suggested by Qais)
* Rework LONG_SOFTIRQS to use BIT() macros
* Rename task_may_preempt() to cpu_busy_with_softirqs()
v5:
* Conditionalize active_softirqs handling (suggested by Alexander
  Gordeev <agordeev@linux.ibm.com>)
* Reorder rt_task_fits_cpu to have the "fast" function first
  (Suggested by Alexander Gordeev <agordeev@linux.ibm.com>)
* Fix bug I introduced in v2 condensing
  task_thread_info(task)->preempt_count to preempt_count()
  (Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>)
* Tweak comment discription to remove the vauge "slow"
  descriptor of softirqs being run by ksoftirqd
  (Suggested by Alexander Gordeev <agordeev@linux.ibm.com>)
* Switch to using CONFIG_RT_SOFTIRQ_AWARE_SCHED (suggested by
  Joel Fernandes <joel@joelfernandes.org>)
* Simplify cpu_busy_with_softirqs() logic as pointed out by
  Alexander Gordeev <agordeev@linux.ibm.com>
* Switch to using IS_ENABLED rather then defining my own macro
  (suggsted by Joel Fernandes <joel@joelfernandes.org>)
---
 include/linux/interrupt.h |  9 +++++++
 init/Kconfig              | 10 ++++++++
 kernel/sched/rt.c         | 49 ++++++++++++++++++++++++++++++++-------
 kernel/softirq.c          | 17 ++++++++++++++
 4 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a749a8663841..7d09eb998d4c 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -582,6 +582,11 @@ enum
  * _ IRQ_POLL: irq_poll_cpu_dead() migrates the queue
  */
 #define SOFTIRQ_HOTPLUG_SAFE_MASK (BIT(RCU_SOFTIRQ) | BIT(IRQ_POLL_SOFTIRQ))
+/* Softirq's where the handling might be long: */
+#define LONG_SOFTIRQ_MASK (BIT(NET_TX_SOFTIRQ)    | \
+			   BIT(NET_RX_SOFTIRQ)    | \
+			   BIT(BLOCK_SOFTIRQ)     | \
+			   BIT(IRQ_POLL_SOFTIRQ))
 
 /* map softirq index to softirq name. update 'softirq_to_name' in
  * kernel/softirq.c when adding a new softirq.
@@ -618,6 +623,10 @@ extern void raise_softirq(unsigned int nr);
 
 DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
 
+#ifdef CONFIG_RT_SOFTIRQ_AWARE_SCHED
+DECLARE_PER_CPU(u32, active_softirqs);
+#endif
+
 static inline struct task_struct *this_cpu_ksoftirqd(void)
 {
 	return this_cpu_read(ksoftirqd);
diff --git a/init/Kconfig b/init/Kconfig
index abf65098f1b6..ce0f0be5759c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1291,6 +1291,16 @@ config SCHED_AUTOGROUP
 	  desktop applications.  Task group autogeneration is currently based
 	  upon task session.
 
+config RT_SOFTIRQ_AWARE_SCHED
+	bool "Improve RT scheduling during long softirq execution"
+	depends on SMP && !PREEMPT_RT
+	default n
+	help
+	  Enable an optimization which tries to avoid placing RT tasks on CPUs
+	  occupied by nonpreemptible tasks, such as a long softirq or CPUs
+	  which may soon block preemptions, such as a CPU running a ksoftirq
+	  thread which handles slow softirqs.
+
 config SYSFS_DEPRECATED
 	bool "Enable deprecated sysfs features to support old userspace tools"
 	depends on SYSFS
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index ed2a47e4ddae..152347c4394c 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1595,6 +1595,32 @@ static void yield_task_rt(struct rq *rq)
 #ifdef CONFIG_SMP
 static int find_lowest_rq(struct task_struct *task);
 
+#ifdef CONFIG_RT_SOFTIRQ_AWARE_SCHED
+/*
+ * Return whether the given cpu is currently non-preemptible
+ * while handling a potentially long softirq, or if the current
+ * task is likely to block preemptions soon because it is a
+ * ksoftirq thread that is handling softirqs.
+ */
+static bool cpu_busy_with_softirqs(int cpu)
+{
+	u32 softirqs = per_cpu(active_softirqs, cpu) |
+		       __cpu_softirq_pending(cpu);
+
+	return softirqs & LONG_SOFTIRQ_MASK;
+}
+#else
+static bool cpu_busy_with_softirqs(int cpu)
+{
+	return false;
+}
+#endif /* CONFIG_RT_SOFTIRQ_AWARE_SCHED */
+
+static bool rt_task_fits_cpu(struct task_struct *p, int cpu)
+{
+	return rt_task_fits_capacity(p, cpu) && !cpu_busy_with_softirqs(cpu);
+}
+
 static int
 select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 {
@@ -1633,22 +1659,24 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	 * This test is optimistic, if we get it wrong the load-balancer
 	 * will have to sort it out.
 	 *
-	 * We take into account the capacity of the CPU to ensure it fits the
-	 * requirement of the task - which is only important on heterogeneous
-	 * systems like big.LITTLE.
+	 * We use rt_task_fits_cpu() to evaluate if the CPU is busy with
+	 * potentially long-running softirq work, as well as take into
+	 * account the capacity of the CPU to ensure it fits the
+	 * requirement of the task - which is only important on
+	 * heterogeneous systems like big.LITTLE.
 	 */
 	test = curr &&
 	       unlikely(rt_task(curr)) &&
 	       (curr->nr_cpus_allowed < 2 || curr->prio <= p->prio);
 
-	if (test || !rt_task_fits_capacity(p, cpu)) {
+	if (test || !rt_task_fits_cpu(p, cpu)) {
 		int target = find_lowest_rq(p);
 
 		/*
 		 * Bail out if we were forcing a migration to find a better
 		 * fitting CPU but our search failed.
 		 */
-		if (!test && target != -1 && !rt_task_fits_capacity(p, target))
+		if (!test && target != -1 && !rt_task_fits_cpu(p, target))
 			goto out_unlock;
 
 		/*
@@ -1890,14 +1918,17 @@ static int find_lowest_rq(struct task_struct *task)
 		return -1; /* No other targets possible */
 
 	/*
-	 * If we're on asym system ensure we consider the different capacities
-	 * of the CPUs when searching for the lowest_mask.
+	 * If we're using the softirq optimization or if we are
+	 * on asym system, ensure we consider the softirq processing
+	 * or different capacities of the CPUs when searching for the
+	 * lowest_mask.
 	 */
-	if (sched_asym_cpucap_active()) {
+	if (IS_ENABLED(CONFIG_RT_SOFTIRQ_AWARE_SCHED) ||
+	    sched_asym_cpucap_active()) {
 
 		ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
 					  task, lowest_mask,
-					  rt_task_fits_capacity);
+					  rt_task_fits_cpu);
 	} else {
 
 		ret = cpupri_find(&task_rq(task)->rd->cpupri,
diff --git a/kernel/softirq.c b/kernel/softirq.c
index c8a6913c067d..dd92ce8f771b 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -60,6 +60,21 @@ static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp
 
 DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
 
+#ifdef CONFIG_RT_SOFTIRQ_AWARE_SCHED
+/*
+ * active_softirqs -- per cpu, a mask of softirqs that are being handled,
+ * with the expectation that approximate answers are acceptable and therefore
+ * no synchronization.
+ */
+DEFINE_PER_CPU(u32, active_softirqs);
+static inline void set_active_softirqs(u32 pending)
+{
+	__this_cpu_write(active_softirqs, pending);
+}
+#else /* CONFIG_RT_SOFTIRQ_AWARE_SCHED */
+static inline void set_active_softirqs(u32 pending) {};
+#endif /* CONFIG_RT_SOFTIRQ_AWARE_SCHED */
+
 const char * const softirq_to_name[NR_SOFTIRQS] = {
 	"HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "IRQ_POLL",
 	"TASKLET", "SCHED", "HRTIMER", "RCU"
@@ -551,6 +566,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 restart:
 	/* Reset the pending bitmask before enabling irqs */
 	set_softirq_pending(0);
+	set_active_softirqs(pending);
 
 	local_irq_enable();
 
@@ -580,6 +596,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		pending >>= softirq_bit;
 	}
 
+	set_active_softirqs(0);
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
 	    __this_cpu_read(ksoftirqd) == current)
 		rcu_softirq_qs();
-- 
2.38.1.431.g37b22c650d-goog

