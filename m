Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85A2610A8D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJ1Gnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJ1GmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:42:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A606E1BA1DC;
        Thu, 27 Oct 2022 23:42:18 -0700 (PDT)
Date:   Fri, 28 Oct 2022 06:42:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1666939336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=usVaBD3S4YKESMxSvqwWUJhemM6IgHEeu1Rml8DoK3g=;
        b=m1WDaRQtZ5VHxdeYKJnYlc3o+Msa4daA3HS/QOsLmos3mWybxIEMy616GRsxg2xohiD7Xw
        GAZnCdehrwfOYTlpNzLYK2utaya+aKGHvs/tDO4sdYw9RlWF2jTihUB9ic7KXsi29lJT71
        FQs5gr7cIaF1abS49fL95oY0QPpcVcULt6aj2eHiKYn2QlEMjX3Q81I6u0lyFaSe4ivVHS
        QZq29NxkRDIQda7dAJbgjCHCuXeOZw/MJP7D30fqdoxg7wlaqw27PV9/BVAIWZNLlNYtVt
        3+yws8huxJCoWmvMUVa1BNF5AYR9JkOdqX16b5vq/1VyKaechDJz14IgIqjpEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1666939336;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=usVaBD3S4YKESMxSvqwWUJhemM6IgHEeu1Rml8DoK3g=;
        b=oQ1kM/QfI0A9SkdVbLmtATOyXzZTDUBbJi3ulYxmlga2nbrgW49pwrWwgJxBz0ksS9UoZG
        pyylGgoLhf9rgmBA==
From:   "tip-bot2 for Pierre Gondois" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Check if prev_cpu has highest spare cap
 in feec()
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221006081052.3862167-2-pierre.gondois@arm.com>
References: <20221006081052.3862167-2-pierre.gondois@arm.com>
MIME-Version: 1.0
Message-ID: <166693933555.29415.8010748161395990501.tip-bot2@tip-bot2>
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

Commit-ID:     ad841e569f5c88e3332b32a000f251f33ff32187
Gitweb:        https://git.kernel.org/tip/ad841e569f5c88e3332b32a000f251f33ff32187
Author:        Pierre Gondois <pierre.gondois@arm.com>
AuthorDate:    Thu, 06 Oct 2022 10:10:52 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 27 Oct 2022 11:01:20 +02:00

sched/fair: Check if prev_cpu has highest spare cap in feec()

When evaluating the CPU candidates in the perf domain (pd) containing
the previously used CPU (prev_cpu), find_energy_efficient_cpu()
evaluates the energy of the pd:
- without the task (base_energy)
- with the task placed on prev_cpu (if the task fits)
- with the task placed on the CPU with the highest spare capacity,
  prev_cpu being excluded from this set

If prev_cpu is already the CPU with the highest spare capacity,
max_spare_cap_cpu will be the CPU with the second highest spare
capacity.

On an Arm64 Juno-r2, with a workload of 10 tasks at a 10% duty cycle,
when prev_cpu and max_spare_cap_cpu are both valid candidates,
prev_spare_cap > max_spare_cap at ~82%.
Thus the energy of the pd when placing the task on max_spare_cap_cpu
is computed with no possible positive outcome 82% most of the time.

Do not consider max_spare_cap_cpu as a valid candidate if
prev_spare_cap > max_spare_cap.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20221006081052.3862167-2-pierre.gondois@arm.com
---
 kernel/sched/fair.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 919d016..4cc56c9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7221,7 +7221,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		unsigned long cur_delta, max_spare_cap = 0;
 		unsigned long rq_util_min, rq_util_max;
 		unsigned long util_min, util_max;
-		bool compute_prev_delta = false;
+		unsigned long prev_spare_cap = 0;
 		int max_spare_cap_cpu = -1;
 		unsigned long base_energy;
 
@@ -7283,18 +7283,19 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 			if (cpu == prev_cpu) {
 				/* Always use prev_cpu as a candidate. */
-				compute_prev_delta = true;
+				prev_spare_cap = cpu_cap;
 			} else if (cpu_cap > max_spare_cap) {
 				/*
 				 * Find the CPU with the maximum spare capacity
-				 * in the performance domain.
+				 * among the remaining CPUs in the performance
+				 * domain.
 				 */
 				max_spare_cap = cpu_cap;
 				max_spare_cap_cpu = cpu;
 			}
 		}
 
-		if (max_spare_cap_cpu < 0 && !compute_prev_delta)
+		if (max_spare_cap_cpu < 0 && prev_spare_cap == 0)
 			continue;
 
 		eenv_pd_busy_time(&eenv, cpus, p);
@@ -7302,7 +7303,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
 
 		/* Evaluate the energy impact of using prev_cpu. */
-		if (compute_prev_delta) {
+		if (prev_spare_cap > 0) {
 			prev_delta = compute_energy(&eenv, pd, cpus, p,
 						    prev_cpu);
 			/* CPU utilization has changed */
@@ -7313,7 +7314,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		}
 
 		/* Evaluate the energy impact of using max_spare_cap_cpu. */
-		if (max_spare_cap_cpu >= 0) {
+		if (max_spare_cap_cpu >= 0 && max_spare_cap > prev_spare_cap) {
 			cur_delta = compute_energy(&eenv, pd, cpus, p,
 						   max_spare_cap_cpu);
 			/* CPU utilization has changed */
