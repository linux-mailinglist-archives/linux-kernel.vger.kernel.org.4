Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921D25F6250
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiJFILI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJFILD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:11:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A2273BC4A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 01:11:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F4E71BF7;
        Thu,  6 Oct 2022 01:11:08 -0700 (PDT)
Received: from pierre123.arm.com (unknown [10.57.35.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 587A33F792;
        Thu,  6 Oct 2022 01:10:59 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH v2 1/1] sched/fair: Check if prev_cpu has highest spare cap in feec()
Date:   Thu,  6 Oct 2022 10:10:52 +0200
Message-Id: <20221006081052.3862167-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006081052.3862167-1-pierre.gondois@arm.com>
References: <20221006081052.3862167-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 kernel/sched/fair.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 914096c5b1ae..bcae7bdd5582 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6900,7 +6900,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	for (; pd; pd = pd->next) {
 		unsigned long cpu_cap, cpu_thermal_cap, util;
 		unsigned long cur_delta, max_spare_cap = 0;
-		bool compute_prev_delta = false;
+		unsigned long prev_spare_cap = 0;
 		int max_spare_cap_cpu = -1;
 		unsigned long base_energy;
 
@@ -6944,18 +6944,19 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
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
@@ -6963,7 +6964,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		base_energy = compute_energy(&eenv, pd, cpus, p, -1);
 
 		/* Evaluate the energy impact of using prev_cpu. */
-		if (compute_prev_delta) {
+		if (prev_spare_cap > 0) {
 			prev_delta = compute_energy(&eenv, pd, cpus, p,
 						    prev_cpu);
 			/* CPU utilization has changed */
@@ -6974,7 +6975,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		}
 
 		/* Evaluate the energy impact of using max_spare_cap_cpu. */
-		if (max_spare_cap_cpu >= 0) {
+		if (max_spare_cap_cpu >= 0 && max_spare_cap > prev_spare_cap) {
 			cur_delta = compute_energy(&eenv, pd, cpus, p,
 						   max_spare_cap_cpu);
 			/* CPU utilization has changed */
-- 
2.25.1

