Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AB5610A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiJ1Go0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJ1Gm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:42:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6F11BB579;
        Thu, 27 Oct 2022 23:42:23 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:42:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paomVjnwcOpcLbLpq2hi1hHo+xtC3pC3+oxZmc1/UX0=;
        b=I2fyfSxHPu7Ipw2MBvPqrpHK8kRU32SZ2o+UzAZ8DE+vMrErnRyKV0Yx0wU8LnsvdoxFJq
        ommpQYFnS5MbccHtIXZ9B2ppNk97imU+gSp5YAoGGYHA3OPAZZExd7/sRwC8lzYTI45vdO
        Z/ZrhZ3PuTAQ6Z7yz5ym4HAAU9tnZkZwbQzvWS4b7eLR6uidavMeQbMKps5KSQ+JrGE5FN
        PEb7cPWU6+SvVWJPE7gYIrxGLcuCtwAA3ogqn4CP5vsFZ65/B2+f0t5b6P4ZL58PlHc0wS
        cnnsxy6b2T87cRAKVl0vQ2Rv981/Ec61wc9rjioA7vUsi47CWzRngVLMjsGBDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=paomVjnwcOpcLbLpq2hi1hHo+xtC3pC3+oxZmc1/UX0=;
        b=HEJuKJMFMlkLe0RX0maIGNNynpAkWiSCsdh1UtpWN/iVXW6AQwT8j5RrM5orVxHltBfYkQ
        ghHD9Nio6kftKnBg==
From:   "tip-bot2 for Qais Yousef" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamp: Make asym_fits_capacity() use util_fits_cpu()
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220804143609.515789-6-qais.yousef@arm.com>
References: <20220804143609.515789-6-qais.yousef@arm.com>
MIME-Version: 1.0
Message-ID: <166693934105.29415.595582803729187121.tip-bot2@tip-bot2>
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

Commit-ID:     a2e7f03ed28fce26c78b985f87913b6ce3accf9d
Gitweb:        https://git.kernel.org/tip/a2e7f03ed28fce26c78b985f87913b6ce3accf9d
Author:        Qais Yousef <qais.yousef@arm.com>
AuthorDate:    Thu, 04 Aug 2022 15:36:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 11:01:19 +02:00

sched/uclamp: Make asym_fits_capacity() use util_fits_cpu()

Use the new util_fits_cpu() to ensure migration margin and capacity
pressure are taken into account correctly when uclamp is being used
otherwise we will fail to consider CPUs as fitting in scenarios where
they should.

s/asym_fits_capacity/asym_fits_cpu/ to better reflect what it does now.

Fixes: b4c9c9f15649 ("sched/fair: Prefer prev cpu in asymmetric wakeup path")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220804143609.515789-6-qais.yousef@arm.com
---
 kernel/sched/fair.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c877bbf..cabbdac 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6807,10 +6807,13 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	return best_cpu;
 }
 
-static inline bool asym_fits_capacity(unsigned long task_util, int cpu)
+static inline bool asym_fits_cpu(unsigned long util,
+				 unsigned long util_min,
+				 unsigned long util_max,
+				 int cpu)
 {
 	if (sched_asym_cpucap_active())
-		return fits_capacity(task_util, capacity_of(cpu));
+		return util_fits_cpu(util, util_min, util_max, cpu);
 
 	return true;
 }
@@ -6822,7 +6825,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
 	bool has_idle_core = false;
 	struct sched_domain *sd;
-	unsigned long task_util;
+	unsigned long task_util, util_min, util_max;
 	int i, recent_used_cpu;
 
 	/*
@@ -6831,7 +6834,9 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	if (sched_asym_cpucap_active()) {
 		sync_entity_load_avg(&p->se);
-		task_util = uclamp_task_util(p);
+		task_util = task_util_est(p);
+		util_min = uclamp_eff_value(p, UCLAMP_MIN);
+		util_max = uclamp_eff_value(p, UCLAMP_MAX);
 	}
 
 	/*
@@ -6840,7 +6845,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	lockdep_assert_irqs_disabled();
 
 	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
-	    asym_fits_capacity(task_util, target))
+	    asym_fits_cpu(task_util, util_min, util_max, target))
 		return target;
 
 	/*
@@ -6848,7 +6853,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	 */
 	if (prev != target && cpus_share_cache(prev, target) &&
 	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
-	    asym_fits_capacity(task_util, prev))
+	    asym_fits_cpu(task_util, util_min, util_max, prev))
 		return prev;
 
 	/*
@@ -6863,7 +6868,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    in_task() &&
 	    prev == smp_processor_id() &&
 	    this_rq()->nr_running <= 1 &&
-	    asym_fits_capacity(task_util, prev)) {
+	    asym_fits_cpu(task_util, util_min, util_max, prev)) {
 		return prev;
 	}
 
@@ -6875,7 +6880,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    cpus_share_cache(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
-	    asym_fits_capacity(task_util, recent_used_cpu)) {
+	    asym_fits_cpu(task_util, util_min, util_max, recent_used_cpu)) {
 		return recent_used_cpu;
 	}
 
