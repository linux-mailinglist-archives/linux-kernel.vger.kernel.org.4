Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51BD5F39BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 01:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJCXVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 19:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJCXUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 19:20:45 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850221A07C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 16:20:43 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id cb7-20020a056a00430700b00561b86e0265so737765pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 16:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=pDv9MbuxBmAy2p481/S839KuNUaJqK+qEEyKDH/P8jg=;
        b=YSUB9TS7tzwXSKdgDan4fTK5RCStmviw55WtSOVirbTzeNG9zZgycj6x093YZnliQa
         eKRVGd/QYPTYv+xmQAdqRK4jkf+X9gjBw+JuXexA21V6QeoInDKIwudm9wUDJZgd/Hbb
         rJoCOE43zTaYeGP2Tu1z5QThKxrTVGugSDoUonSrMdkFvoCH50QOhw4kfWQ0XOZWD1rp
         XyHGRGdYj37CokAojWtXOFOTiSK+mjo/oKtn+g8351cEgRlowKRRDuGsWa7rekrEgaf3
         SdWpCpG39DCBhaSgLEdlciqAA9TamZkAMV18EZovFiXEbONSRqcHC9iwRHiRo+TZLO6S
         TYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=pDv9MbuxBmAy2p481/S839KuNUaJqK+qEEyKDH/P8jg=;
        b=WpCLQJUmTX0RwzSfxCowDweoUNXGs7dwLHiWf9HDYRqX/FeS4EyHyEdJxAGaLP1bJs
         7LQHtcoOJR0pczvGhuJiboZpsQ77UAEVqid1/vlicTFQ6vxAif6VmHwp0UBCM3Senrjb
         z4OEYSKdPcpDYA0whH+xUj2tIayM3hjy06LgbTpUQjys/p7p3lluAp5Pm0dmYmNciYps
         hhjRsd11kSi1g9/I9LeBIRP3Aqi/KABX9bfet9lvtOXG+2y+OhduwGgRF3k1tLAuUD7N
         9BBqQQOSSOOLAbIH8qE+8QTTX2crgTI/SKwetM8BobE2WmPz2tC/zjY3L4fED/jYENd+
         z82Q==
X-Gm-Message-State: ACrzQf34SXSi98r3aFB/7YqvuxWHfvE7SC0ojOZ+/wzELCczu8n4tCI2
        xZVyZLTYwibgROsgol2bO4utNwz0f6SAU+HAxlYpumgSu2eL95BXsga6/re1baeDR1Et2Eip3sK
        10Lt1pQtYVoNdangN+daIw2bjdjFvHaK2sUw25AmVvuI0Y1KKDZXADGvHKc3wg4oGnsx3+3g=
X-Google-Smtp-Source: AMsMyM7/GszLcL2nhEgb3xESlCVVH8SUddXYPRoi9TxQqvwlmio10xzBe1RFug1usvzBWmxXkdzhKhjbORe7
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:aa7:8543:0:b0:54b:6ea4:7a12 with SMTP id
 y3-20020aa78543000000b0054b6ea47a12mr24678596pfn.33.1664839242759; Mon, 03
 Oct 2022 16:20:42 -0700 (PDT)
Date:   Mon,  3 Oct 2022 23:20:32 +0000
In-Reply-To: <20221003232033.3404802-1-jstultz@google.com>
Mime-Version: 1.0
References: <20221003232033.3404802-1-jstultz@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221003232033.3404802-3-jstultz@google.com>
Subject: [RFC PATCH v4 2/3] sched: Avoid placing RT threads on cores handling
 long softirqs
From:   John Stultz <jstultz@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Connor O'Brien" <connoro@google.com>,
        John Dias <joaodias@google.com>, Rick Yiu <rickyiu@google.com>,
        John Kacur <jkacur@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Chris Redpath <chris.redpath@arm.com>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        "J . Avila" <elavila@google.com>, John Stultz <jstultz@google.com>
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
Cc: Qais Yousef <qais.yousef@arm.com>
Cc: Chris Redpath <chris.redpath@arm.com>
Cc: Abhijeet Dharmapurikar <adharmap@quicinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
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
---
 include/linux/interrupt.h |  6 ++++
 init/Kconfig              | 10 +++++++
 kernel/sched/rt.c         | 61 +++++++++++++++++++++++++++++++++------
 kernel/softirq.c          |  9 ++++++
 4 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a749a8663841..e3a4add67e8c 100644
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
@@ -617,6 +622,7 @@ extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
 
 DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
+DECLARE_PER_CPU(u32, active_softirqs);
 
 static inline struct task_struct *this_cpu_ksoftirqd(void)
 {
diff --git a/init/Kconfig b/init/Kconfig
index 532362fcfe31..3d1de6edcfa1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1284,6 +1284,16 @@ config SCHED_AUTOGROUP
 	  desktop applications.  Task group autogeneration is currently based
 	  upon task session.
 
+config RT_SOFTIRQ_OPTIMIZATION
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
index 55f39c8f4203..3c628db807c8 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1599,6 +1599,44 @@ static void yield_task_rt(struct rq *rq)
 #ifdef CONFIG_SMP
 static int find_lowest_rq(struct task_struct *task);
 
+#ifdef CONFIG_RT_SOFTIRQ_OPTIMIZATION
+#define __use_softirq_opt 1
+/*
+ * Return whether the given cpu is currently non-preemptible
+ * while handling a potentially long softirq, or if the current
+ * task is likely to block preemptions soon because it is a
+ * ksoftirq thread that is handling slow softirq.
+ */
+static bool cpu_busy_with_softirqs(int cpu)
+{
+	u32 softirqs = per_cpu(active_softirqs, cpu) |
+		       __cpu_softirq_pending(cpu);
+	struct task_struct *cpu_ksoftirqd = per_cpu(ksoftirqd, cpu);
+	struct task_struct *curr;
+	struct rq *rq = cpu_rq(cpu);
+	int ret;
+
+	rcu_read_lock();
+	curr = READ_ONCE(rq->curr); /* unlocked access */
+	ret = (softirqs & LONG_SOFTIRQ_MASK) &&
+		 (curr == cpu_ksoftirqd ||
+		  preempt_count() & SOFTIRQ_MASK);
+	rcu_read_unlock();
+	return ret;
+}
+#else
+#define __use_softirq_opt 0
+static bool cpu_busy_with_softirqs(int cpu)
+{
+	return false;
+}
+#endif /* CONFIG_RT_SOFTIRQ_OPTIMIZATION */
+
+static bool rt_task_fits_cpu(struct task_struct *p, int cpu)
+{
+	return !cpu_busy_with_softirqs(cpu) && rt_task_fits_capacity(p, cpu);
+}
+
 static int
 select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 {
@@ -1637,22 +1675,24 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
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
@@ -1894,14 +1934,17 @@ static int find_lowest_rq(struct task_struct *task)
 		return -1; /* No other targets possible */
 
 	/*
-	 * If we're on asym system ensure we consider the different capacities
-	 * of the CPUs when searching for the lowest_mask.
+	 * If we're using the softirq optimization or if we are
+	 * on asym system, ensure we consider the softirq processing
+	 * or different capacities of the CPUs when searching for the
+	 * lowest_mask.
 	 */
-	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+	if (__use_softirq_opt ||
+	    static_branch_unlikely(&sched_asym_cpucapacity)) {
 
 		ret = cpupri_find_fitness(&task_rq(task)->rd->cpupri,
 					  task, lowest_mask,
-					  rt_task_fits_capacity);
+					  rt_task_fits_cpu);
 	} else {
 
 		ret = cpupri_find(&task_rq(task)->rd->cpupri,
diff --git a/kernel/softirq.c b/kernel/softirq.c
index c8a6913c067d..35ee79dd8786 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -60,6 +60,13 @@ static struct softirq_action softirq_vec[NR_SOFTIRQS] __cacheline_aligned_in_smp
 
 DEFINE_PER_CPU(struct task_struct *, ksoftirqd);
 
+/*
+ * active_softirqs -- per cpu, a mask of softirqs that are being handled,
+ * with the expectation that approximate answers are acceptable and therefore
+ * no synchronization.
+ */
+DEFINE_PER_CPU(u32, active_softirqs);
+
 const char * const softirq_to_name[NR_SOFTIRQS] = {
 	"HI", "TIMER", "NET_TX", "NET_RX", "BLOCK", "IRQ_POLL",
 	"TASKLET", "SCHED", "HRTIMER", "RCU"
@@ -551,6 +558,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 restart:
 	/* Reset the pending bitmask before enabling irqs */
 	set_softirq_pending(0);
+	__this_cpu_write(active_softirqs, pending);
 
 	local_irq_enable();
 
@@ -580,6 +588,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		pending >>= softirq_bit;
 	}
 
+	__this_cpu_write(active_softirqs, 0);
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
 	    __this_cpu_read(ksoftirqd) == current)
 		rcu_softirq_qs();
-- 
2.38.0.rc1.362.ged0d419d3c-goog

