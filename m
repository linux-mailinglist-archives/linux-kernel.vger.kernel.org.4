Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168FE656AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiL0MPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiL0MOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:14:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43862C0D;
        Tue, 27 Dec 2022 04:13:50 -0800 (PST)
Date:   Tue, 27 Dec 2022 12:13:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672143228;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q7yIwW2C4vTS9nE5J/vohwDRg28vIjPeDuu0aA9qzRs=;
        b=sqHM2Omjpl42Btum1n/7F+ni5V8vv5bqWjaUTSjF8VJlDAR9Cl+nKqVnBGv2ihB+O3Cz/b
        IJbsR301hj+lqordHz2XjE9TR1amC03H28JYQRXCG0IKP8afNevW8k4vmtnjra9RIzEjob
        Yb1bo8A2TQQpfo2YGU6889IHmnonppM6IffFhn1gRnRG5nxfEQAyO+6bgXjXLwjC5WueJX
        DRyhkVCtm6RlQRMXLmCxCuihZ5q3VhI11XmGWJXcwQVDl4P6fy9QIskHpoes/d/MRpY6xq
        G40DtJDCaDkgOgKmeax/ORTk5lY9ia12DWb3USzMuagINRhJvKoxg1jF0wCmHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672143228;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q7yIwW2C4vTS9nE5J/vohwDRg28vIjPeDuu0aA9qzRs=;
        b=bcMlxszv5Wz3vzphoUqIXMxHUEjduSRt5O7X3dZkT4mMQmOKzb4zy9WCLQzZiGMw5hns+2
        Eh2Vha4HeQiFF9BQ==
From:   "tip-bot2 for Hao Jia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Adjusting the order of scanning CPU
Cc:     Hao Jia <jiahao.os@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221216062406.7812-3-jiahao.os@bytedance.com>
References: <20221216062406.7812-3-jiahao.os@bytedance.com>
MIME-Version: 1.0
Message-ID: <167214322851.4906.17513805621573281162.tip-bot2@tip-bot2>
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

Commit-ID:     8589018acc65e5ddfd111f0a7ee85f9afde3a830
Gitweb:        https://git.kernel.org/tip/8589018acc65e5ddfd111f0a7ee85f9afde3a830
Author:        Hao Jia <jiahao.os@bytedance.com>
AuthorDate:    Fri, 16 Dec 2022 14:24:06 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 27 Dec 2022 12:52:17 +01:00

sched/core: Adjusting the order of scanning CPU

When select_idle_capacity() starts scanning for an idle CPU, it starts
with target CPU that has already been checked in select_idle_sibling().
So we start checking from the next CPU and try the target CPU at the end.
Similarly for task_numa_assign(), we have just checked numa_migrate_on
of dst_cpu, so start from the next CPU. This also works for
steal_cookie_task(), the first scan must fail and start directly
from the next one.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lore.kernel.org/r/20221216062406.7812-3-jiahao.os@bytedance.com
---
 kernel/sched/core.c | 2 +-
 kernel/sched/fair.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1f3259c..048ec24 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6209,7 +6209,7 @@ static bool steal_cookie_task(int cpu, struct sched_domain *sd)
 {
 	int i;
 
-	for_each_cpu_wrap(i, sched_domain_span(sd), cpu) {
+	for_each_cpu_wrap(i, sched_domain_span(sd), cpu + 1) {
 		if (i == cpu)
 			continue;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aaff209..e9d906a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1836,7 +1836,7 @@ static void task_numa_assign(struct task_numa_env *env,
 		int start = env->dst_cpu;
 
 		/* Find alternative idle CPU. */
-		for_each_cpu_wrap(cpu, cpumask_of_node(env->dst_nid), start) {
+		for_each_cpu_wrap(cpu, cpumask_of_node(env->dst_nid), start + 1) {
 			if (cpu == env->best_cpu || !idle_cpu(cpu) ||
 			    !cpumask_test_cpu(cpu, env->p->cpus_ptr)) {
 				continue;
@@ -6935,7 +6935,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	util_min = uclamp_eff_value(p, UCLAMP_MIN);
 	util_max = uclamp_eff_value(p, UCLAMP_MAX);
 
-	for_each_cpu_wrap(cpu, cpus, target) {
+	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		unsigned long cpu_cap = capacity_of(cpu);
 
 		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
