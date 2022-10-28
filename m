Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A968C610A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiJ1Goc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiJ1Gmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:42:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF74B15B315;
        Thu, 27 Oct 2022 23:42:25 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:42:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939344;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7yEmpzaN1t9btkg2NtgE9PsI5QDLQQmxQ1eso1ao/6E=;
        b=RJpasJzNjNshEAyuQJXit7+MjeDnwkSk/CtNIBjbwz/kZn1BXYoYnrTXs73hXc6/ly7iGg
        jhvgwEyxKGsoen6dRfBjfIMQJkt+usX58C5nT+9Zr9zfoDmx9Spff4R2k0fKQjNZF2srTL
        JBV0UgWthJ0pVAWtBqyPptiWl+2XxMQ8V/MQT2OTDvtnQt/Q3LKuzIDw+fYMk/2+LxhrNw
        cE79jfXS0q4JJIbQL4RCGJtWxXibvPdnQdMlUMO6PjuoZaAAg90I4NZUTImd1krWOlFwMB
        olul3VnJCliP2EsMJDlUYARhFAAML9KuGCl+zNlBispG0kZZSi5XiV9F7giY2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939344;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7yEmpzaN1t9btkg2NtgE9PsI5QDLQQmxQ1eso1ao/6E=;
        b=Mlxo4UPiorAlA9NyobIHjRAXDY2aVsMkhxS8B8mhSHHXwSEZwPaxXvzSqgXgT6VV8rXjDU
        p/9lvk9F2+OXyUAQ==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Fix fits_capacity() check in feec()
Cc:     Yun Hsiang <hsiang023167@gmail.com>,
        Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220804143609.515789-4-qais.yousef@arm.com>
References: <20220804143609.515789-4-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <166693934327.29415.4454964066549531417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     244226035a1f9b2b6c326e55ae5188fab4f428cb
Gitweb:        https://git.kernel.org/tip/244226035a1f9b2b6c326e55ae5188fab4f428cb
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 04 Aug 2022 15:36:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 11:01:18 +02:00

sched/uclamp: Fix fits_capacity() check in feec()

As reported by Yun Hsiang [1], if a task has its uclamp_min >= 0.8 * 1024,
it'll always pick the previous CPU because fits_capacity() will always
return false in this case.

The new util_fits_cpu() logic should handle this correctly for us beside
more corner cases where similar failures could occur, like when using
UCLAMP_MAX.

We open code uclamp_rq_util_with() except for the clamp() part,
util_fits_cpu() needs the 'raw' values to be passed to it.

Also introduce uclamp_rq_{set, get}() shorthand accessors to get uclamp
value for the rq. Makes the code more readable and ensures the right
rules (use READ_ONCE/WRITE_ONCE) are respected transparently.

[1] https://lists.linaro.org/pipermail/eas-dev/2020-July/001488.html

Fixes: 1d42509e475c ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
Reported-by: Yun Hsiang <hsiang023167@gmail.com>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220804143609.515789-4-qais.yousef@arm.com
---
 kernel/sched/core.c  | 10 +++++-----
 kernel/sched/fair.c  | 26 ++++++++++++++++++++++++--
 kernel/sched/sched.h | 42 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cb2aa2b..069da4a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1392,7 +1392,7 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
 	if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
 		return;
 
-	WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
+	uclamp_rq_set(rq, clamp_id, clamp_value);
 }
 
 static inline
@@ -1543,8 +1543,8 @@ static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
 	if (bucket->tasks == 1 || uc_se->value > bucket->value)
 		bucket->value = uc_se->value;
 
-	if (uc_se->value > READ_ONCE(uc_rq->value))
-		WRITE_ONCE(uc_rq->value, uc_se->value);
+	if (uc_se->value > uclamp_rq_get(rq, clamp_id))
+		uclamp_rq_set(rq, clamp_id, uc_se->value);
 }
 
 /*
@@ -1610,7 +1610,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	if (likely(bucket->tasks))
 		return;
 
-	rq_clamp = READ_ONCE(uc_rq->value);
+	rq_clamp = uclamp_rq_get(rq, clamp_id);
 	/*
 	 * Defensive programming: this should never happen. If it happens,
 	 * e.g. due to future modification, warn and fixup the expected value.
@@ -1618,7 +1618,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
 	SCHED_WARN_ON(bucket->value > rq_clamp);
 	if (bucket->value >= rq_clamp) {
 		bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
-		WRITE_ONCE(uc_rq->value, bkt_clamp);
+		uclamp_rq_set(rq, clamp_id, bkt_clamp);
 	}
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index db6174b..c8eb5ff 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7169,6 +7169,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
 	unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
+	unsigned long p_util_min = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MIN) : 0;
+	unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
 	struct root_domain *rd = this_rq()->rd;
 	int cpu, best_energy_cpu, target = -1;
 	struct sched_domain *sd;
@@ -7201,6 +7203,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	for (; pd; pd = pd->next) {
 		unsigned long cpu_cap, cpu_thermal_cap, util;
 		unsigned long cur_delta, max_spare_cap = 0;
+		unsigned long rq_util_min, rq_util_max;
+		unsigned long util_min, util_max;
 		bool compute_prev_delta = false;
 		int max_spare_cap_cpu = -1;
 		unsigned long base_energy;
@@ -7237,8 +7241,26 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 * much capacity we can get out of the CPU; this is
 			 * aligned with sched_cpu_util().
 			 */
-			util = uclamp_rq_util_with(cpu_rq(cpu), util, p);
-			if (!fits_capacity(util, cpu_cap))
+			if (uclamp_is_used()) {
+				if (uclamp_rq_is_idle(cpu_rq(cpu))) {
+					util_min = p_util_min;
+					util_max = p_util_max;
+				} else {
+					/*
+					 * Open code uclamp_rq_util_with() except for
+					 * the clamp() part. Ie: apply max aggregation
+					 * only. util_fits_cpu() logic requires to
+					 * operate on non clamped util but must use the
+					 * max-aggregated uclamp_{min, max}.
+					 */
+					rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
+					rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
+
+					util_min = max(rq_util_min, p_util_min);
+					util_max = max(rq_util_max, p_util_max);
+				}
+			}
+			if (!util_fits_cpu(util, util_min, util_max, cpu))
 				continue;
 
 			lsub_positive(&cpu_cap, util);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0ab091b..d6d488e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2979,6 +2979,23 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
 #ifdef CONFIG_UCLAMP_TASK
 unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
 
+static inline unsigned long uclamp_rq_get(struct rq *rq,
+					  enum uclamp_id clamp_id)
+{
+	return READ_ONCE(rq->uclamp[clamp_id].value);
+}
+
+static inline void uclamp_rq_set(struct rq *rq, enum uclamp_id clamp_id,
+				 unsigned int value)
+{
+	WRITE_ONCE(rq->uclamp[clamp_id].value, value);
+}
+
+static inline bool uclamp_rq_is_idle(struct rq *rq)
+{
+	return rq->uclamp_flags & UCLAMP_FLAG_IDLE;
+}
+
 /**
  * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp values.
  * @rq:		The rq to clamp against. Must not be NULL.
@@ -3014,12 +3031,12 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 		 * Ignore last runnable task's max clamp, as this task will
 		 * reset it. Similarly, no need to read the rq's min clamp.
 		 */
-		if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
+		if (uclamp_rq_is_idle(rq))
 			goto out;
 	}
 
-	min_util = max_t(unsigned long, min_util, READ_ONCE(rq->uclamp[UCLAMP_MIN].value));
-	max_util = max_t(unsigned long, max_util, READ_ONCE(rq->uclamp[UCLAMP_MAX].value));
+	min_util = max_t(unsigned long, min_util, uclamp_rq_get(rq, UCLAMP_MIN));
+	max_util = max_t(unsigned long, max_util, uclamp_rq_get(rq, UCLAMP_MAX));
 out:
 	/*
 	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
@@ -3082,6 +3099,25 @@ static inline bool uclamp_is_used(void)
 {
 	return false;
 }
+
+static inline unsigned long uclamp_rq_get(struct rq *rq,
+					  enum uclamp_id clamp_id)
+{
+	if (clamp_id == UCLAMP_MIN)
+		return 0;
+
+	return SCHED_CAPACITY_SCALE;
+}
+
+static inline void uclamp_rq_set(struct rq *rq, enum uclamp_id clamp_id,
+				 unsigned int value)
+{
+}
+
+static inline bool uclamp_rq_is_idle(struct rq *rq)
+{
+	return false;
+}
 #endif /* CONFIG_UCLAMP_TASK */
 
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
