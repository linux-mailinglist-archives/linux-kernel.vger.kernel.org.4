Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B796FDF20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbjEJNuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbjEJNtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:49:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6FC4207;
        Wed, 10 May 2023 06:49:19 -0700 (PDT)
Date:   Wed, 10 May 2023 13:49:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683726553;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vV6EY/zAp79ASebZGCbej5mbTyZ97v0GfwOxZ6h5YBQ=;
        b=KeFoccBtnmREbbGYb6oi9pFGsAyfifaQSL38vE5pFDyrOOXKTkB3NsgG1c9jjbyeg/X9/C
        N9EnyZU/4MG6iJ4WH0nPuq7X9ia1Ch+D6Kl3PluLNlSAcDT5VpuvENqMnPSvZeCa+zsQBS
        JTasCbKIEosZeggKQMQqMUpzOr+Mddg5vlfEnWrJmW1IhbD5jJzhLjHMSV+Oz1ykoV2g8H
        aIXT2A+Cs1h07mIQ2uQzVd8lSDpWczyynRuO8Yzsoi9TzaQW/UTDQzRAYoNcYbA+lGUD3W
        pey/Wz5GH0BYs3/0UDZQU8Zk9UAHImWIcWF4UQgiAmOQ2dxiYTMG7SaWmBSkKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683726553;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vV6EY/zAp79ASebZGCbej5mbTyZ97v0GfwOxZ6h5YBQ=;
        b=2nyWwxDj1jJvdECq43xSfvLMAhldjlKWyR5C9YiY3CDuKiIteuxd4Gs1jvNAZZRDvv2t2l
        Bb3JXiNUlA2Gp9Bw==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Do not even the number of busy CPUs via
 asym_packing
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230406203148.19182-8-ricardo.neri-calderon@linux.intel.com>
References: <20230406203148.19182-8-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168372655261.404.9550789330158313193.tip-bot2@tip-bot2>
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

Commit-ID:     c9ca07886aaa40225a29e5c1e46ac31d2e14f53a
Gitweb:        https://git.kernel.org/tip/c9ca07886aaa40225a29e5c1e46ac31d2e14f53a
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Thu, 06 Apr 2023 13:31:43 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:36 +02:00

sched/fair: Do not even the number of busy CPUs via asym_packing

Now that find_busiest_group() triggers load balancing between a fully_
busy SMT2 core and an idle non-SMT core, it is no longer needed to force
balancing via asym_packing. Use asym_packing only as intended: when there
is high-priority CPU that is idle.

After this change, the same logic apply to SMT and non-SMT local groups.
It makes less sense having a separate function to deal specifically with
SMT. Fold the logic in asym_smt_can_pull_tasks() into sched_asym().

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406203148.19182-8-ricardo.neri-calderon@linux.intel.com
---
 kernel/sched/fair.c | 86 ++++++++++----------------------------------
 1 file changed, 21 insertions(+), 65 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3bb8934..48b6f0c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9350,74 +9350,26 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
 }
 
 /**
- * asym_smt_can_pull_tasks - Check whether the load balancing CPU can pull tasks
- * @dst_cpu:	Destination CPU of the load balancing
+ * sched_asym - Check if the destination CPU can do asym_packing load balance
+ * @env:	The load balancing environment
  * @sds:	Load-balancing data with statistics of the local group
  * @sgs:	Load-balancing statistics of the candidate busiest group
- * @sg:		The candidate busiest group
+ * @group:	The candidate busiest group
  *
- * Check the state of the SMT siblings of both @sds::local and @sg and decide
- * if @dst_cpu can pull tasks.
+ * @env::dst_cpu can do asym_packing if it has higher priority than the
+ * preferred CPU of @group.
  *
- * This function must be called only if all the SMT siblings of @dst_cpu are
- * idle, if any.
+ * SMT is a special case. If we are balancing load between cores, @env::dst_cpu
+ * can do asym_packing balance only if all its SMT siblings are idle. Also, it
+ * can only do it if @group is an SMT group and has exactly on busy CPU. Larger
+ * imbalances in the number of CPUS are dealt with in find_busiest_group().
  *
- * If @dst_cpu does not have SMT siblings, it can pull tasks if two or more of
- * the SMT siblings of @sg are busy. If only one CPU in @sg is busy, pull tasks
- * only if @dst_cpu has higher priority.
+ * If we are balancing load within an SMT core, or at DIE domain level, always
+ * proceed.
  *
- * When dealing with SMT cores, only use priorities if the SMT core has exactly
- * one busy sibling. find_busiest_group() will handle bigger imbalances in the
- * number of busy CPUs.
- *
- * Return: true if @dst_cpu can pull tasks, false otherwise.
+ * Return: true if @env::dst_cpu can do with asym_packing load balance. False
+ * otherwise.
  */
-static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
-				    struct sg_lb_stats *sgs,
-				    struct sched_group *sg)
-{
-#ifdef CONFIG_SCHED_SMT
-	bool local_is_smt;
-	int sg_busy_cpus;
-
-	local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
-	sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
-
-	if (!local_is_smt) {
-		/*
-		 * If we are here, @dst_cpu is idle and does not have SMT
-		 * siblings. Pull tasks if candidate group has two or more
-		 * busy CPUs.
-		 */
-		if (sg_busy_cpus >= 2) /* implies sg_is_smt */
-			return true;
-
-		/*
-		 * @dst_cpu does not have SMT siblings. @sg may have SMT
-		 * siblings and only one is busy. In such case, @dst_cpu
-		 * can help if it has higher priority and is idle (i.e.,
-		 * it has no running tasks).
-		 */
-		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
-	}
-
-	/*
-	 * If we are here @dst_cpu has SMT siblings and are also idle.
-	 *
-	 * CPU priorities does not make sense for SMT cores with more than one
-	 * busy sibling.
-	 */
-	if (group->flags & SD_SHARE_CPUCAPACITY && sg_busy_cpus != 1)
-		return false;
-
-	return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
-
-#else
-	/* Always return false so that callers deal with non-SMT cases. */
-	return false;
-#endif
-}
-
 static inline bool
 sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs,
 	   struct sched_group *group)
@@ -9426,10 +9378,14 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
 	if (!sched_use_asym_prio(env->sd, env->dst_cpu))
 		return false;
 
-	/* Only do SMT checks if either local or candidate have SMT siblings. */
-	if ((sds->local->flags & SD_SHARE_CPUCAPACITY) ||
-	    (group->flags & SD_SHARE_CPUCAPACITY))
-		return asym_smt_can_pull_tasks(env->dst_cpu, sds, sgs, group);
+	/*
+	 * CPU priorities does not make sense for SMT cores with more than one
+	 * busy sibling.
+	 */
+	if (group->flags & SD_SHARE_CPUCAPACITY) {
+		if (sgs->group_weight - sgs->idle_cpus != 1)
+			return false;
+	}
 
 	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
 }
