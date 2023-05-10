Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241C86FDF25
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbjEJNuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbjEJNtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:49:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48BA26BA;
        Wed, 10 May 2023 06:49:21 -0700 (PDT)
Date:   Wed, 10 May 2023 13:49:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683726555;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=12RqxTXD23jfP8OhPD7PthHvdRXaxuBo3sJAeKCNGmI=;
        b=sLdc3t2Vqnz6LAtGp5Zl7ljeDjRSUJAieoDK2D8GEyGUe50mxHsmdgctH7HNs1KVW0w+eb
        1ponAx8e+tXnNLeLMIyJ6iu0ZqWMd+IR3OKgxp5/FqLJkN3R3C+FM8HXcxCtkaWB/lqgp+
        ysVW8BxB4UiYZqolk+xcWsIGnEZ2LtSqK+sp0pxRdTbAPqundAuzl8OG7VR07F7PRKoZ2n
        c1/jPamivDE+VC9QmWNWzFpmg2YbLAk37UfzcZMv066TMk6YYgo++KtgLT393WagY3w659
        N/R8Mz1DWPDn2P1M7INPbpDdnh19LP4oZ1I20PmkAgQd4wqfFtCPu+ejN71jsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683726555;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=12RqxTXD23jfP8OhPD7PthHvdRXaxuBo3sJAeKCNGmI=;
        b=KA6k/oN/vDYurry1wKrpi4IhCu8Ss0obdjtFCT3Jdc9ATupLKLXIaI5tkuqKqK+5ULoI0m
        NCTjyTUa9zfTe5Cw==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Only do asym_packing load balancing
 from fully idle SMT cores
Cc:     Valentin Schneider <vschneid@redhat.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230406203148.19182-3-ricardo.neri-calderon@linux.intel.com>
References: <20230406203148.19182-3-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168372655512.404.6669732203728997075.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     eefefa716c9fa6aa73159f09954b7eeba4cafd09
Gitweb:        https://git.kernel.org/tip/eefefa716c9fa6aa73159f09954b7eeba4cafd09
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Thu, 06 Apr 2023 13:31:38 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:34 +02:00

sched/fair: Only do asym_packing load balancing from fully idle SMT cores

When balancing load between cores, all the SMT siblings of the destination
CPU, if any, must be idle. Otherwise, pulling new tasks degrades the
throughput of the busy SMT siblings. The overall throughput of the system
remains the same.

When balancing load within an SMT core this consideration is not relevant.
Follow the priorities that hardware indicates.

Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406203148.19182-3-ricardo.neri-calderon@linux.intel.com
---
 kernel/sched/fair.c | 56 +++++++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a47208d..713d03e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9331,6 +9331,25 @@ group_type group_classify(unsigned int imbalance_pct,
 }
 
 /**
+ * sched_use_asym_prio - Check whether asym_packing priority must be used
+ * @sd:		The scheduling domain of the load balancing
+ * @cpu:	A CPU
+ *
+ * Always use CPU priority when balancing load between SMT siblings. When
+ * balancing load between cores, it is not sufficient that @cpu is idle. Only
+ * use CPU priority if the whole core is idle.
+ *
+ * Returns: True if the priority of @cpu must be followed. False otherwise.
+ */
+static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
+{
+	if (!sched_smt_active())
+		return true;
+
+	return sd->flags & SD_SHARE_CPUCAPACITY || is_core_idle(cpu);
+}
+
+/**
  * asym_smt_can_pull_tasks - Check whether the load balancing CPU can pull tasks
  * @dst_cpu:	Destination CPU of the load balancing
  * @sds:	Load-balancing data with statistics of the local group
@@ -9340,6 +9359,9 @@ group_type group_classify(unsigned int imbalance_pct,
  * Check the state of the SMT siblings of both @sds::local and @sg and decide
  * if @dst_cpu can pull tasks.
  *
+ * This function must be called only if all the SMT siblings of @dst_cpu are
+ * idle, if any.
+ *
  * If @dst_cpu does not have SMT siblings, it can pull tasks if two or more of
  * the SMT siblings of @sg are busy. If only one CPU in @sg is busy, pull tasks
  * only if @dst_cpu has higher priority.
@@ -9349,8 +9371,7 @@ group_type group_classify(unsigned int imbalance_pct,
  * Bigger imbalances in the number of busy CPUs will be dealt with in
  * update_sd_pick_busiest().
  *
- * If @sg does not have SMT siblings, only pull tasks if all of the SMT siblings
- * of @dst_cpu are idle and @sg has lower priority.
+ * If @sg does not have SMT siblings, only pull tasks if @sg has lower priority.
  *
  * Return: true if @dst_cpu can pull tasks, false otherwise.
  */
@@ -9398,15 +9419,8 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
 		return false;
 	}
 
-	/*
-	 * @sg does not have SMT siblings. Ensure that @sds::local does not end
-	 * up with more than one busy SMT sibling and only pull tasks if there
-	 * are not busy CPUs (i.e., no CPU has running tasks).
-	 */
-	if (!sds->local_stat.sum_nr_running)
-		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
-
-	return false;
+	/* If we are here @dst_cpu has SMT siblings and are also idle. */
+	return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
 #else
 	/* Always return false so that callers deal with non-SMT cases. */
 	return false;
@@ -9417,7 +9431,11 @@ static inline bool
 sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
 	   struct sched_group *group)
 {
-	/* Only do SMT checks if either local or candidate have SMT siblings */
+	/* Ensure that the whole local core is idle, if applicable. */
+	if (!sched_use_asym_prio(env->sd, env->dst_cpu))
+		return false;
+
+	/* Only do SMT checks if either local or candidate have SMT siblings. */
 	if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
 	    (group->flags & SD_SHARE_CPUCAPACITY))
 		return asym_smt_can_pull_tasks(env->dst_cpu, sds, sgs, group);
@@ -10632,11 +10650,13 @@ static inline bool
 asym_active_balance(struct lb_env *env)
 {
 	/*
-	 * ASYM_PACKING needs to force migrate tasks from busy but
-	 * lower priority CPUs in order to pack all tasks in the
-	 * highest priority CPUs.
+	 * ASYM_PACKING needs to force migrate tasks from busy but lower
+	 * priority CPUs in order to pack all tasks in the highest priority
+	 * CPUs. When done between cores, do it only if the whole core if the
+	 * whole core is idle.
 	 */
 	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
+	       sched_use_asym_prio(env->sd, env->dst_cpu) &&
 	       sched_asym_prefer(env->dst_cpu, env->src_cpu);
 }
 
@@ -11371,9 +11391,13 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * When ASYM_PACKING; see if there's a more preferred CPU
 		 * currently idle; in which case, kick the ILB to move tasks
 		 * around.
+		 *
+		 * When balancing betwen cores, all the SMT siblings of the
+		 * preferred CPU must be idle.
 		 */
 		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
-			if (sched_asym_prefer(i, cpu)) {
+			if (sched_use_asym_prio(sd, i) &&
+			    sched_asym_prefer(i, cpu)) {
 				flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 				goto unlock;
 			}
