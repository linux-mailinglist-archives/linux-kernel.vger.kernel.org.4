Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB276FDF26
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 15:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbjEJNuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 09:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237259AbjEJNtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 09:49:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0131C3C1D;
        Wed, 10 May 2023 06:49:20 -0700 (PDT)
Date:   Wed, 10 May 2023 13:49:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683726555;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5KWL8v0ixfY0NlNRBcOGPLg+m+d8q7mWOOfrcxNPlM=;
        b=YDk4Xryi3YAgS+dcO/VnHPjM9uZem+ylCINzD5y3XjmMdre19QJBYLfs36IHn9rQbNYlI2
        iHuPz53WkLlOFlxbtad6PESgH+VYbt2SV/LeYBFuhN6WwCbIP6/OsYtfnNem59Lthjhu8X
        EzGmH/rMLqe++TpbV5rXID1zmiPO/IjJXZ9njnE5mgOFIWEs0vEsjEImQideYLjbzuQnNW
        RVTDP8XpfHL+LxHnTRnioMf28ZNlx1yyo4QJ0zz+DaiMQwlQ2jwfQQxRnNcJ97X7LYtb9H
        xdX/nSLMrQM4qd8mUIOn6O+Vu+svQui5zX3BxdfyslxJXhgTtyvv8X3cmuiPdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683726555;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5KWL8v0ixfY0NlNRBcOGPLg+m+d8q7mWOOfrcxNPlM=;
        b=LQ8YPMf59YjtZpjNmQom3O34WjRfPT7VIjE6dUP+hIVxPreCnQcs5GbEW5wmQyliMl70bo
        nhJzfR+9oglkezBQ==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Simplify asym_packing logic for SMT cores
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230406203148.19182-4-ricardo.neri-calderon@linux.intel.com>
References: <20230406203148.19182-4-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Message-ID: <168372655464.404.14584349567074700892.tip-bot2@tip-bot2>
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

Commit-ID:     ef7657d4d2d6a8456aa624010de456c32a135fe9
Gitweb:        https://git.kernel.org/tip/ef7657d4d2d6a8456aa624010de456c32a135fe9
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Thu, 06 Apr 2023 13:31:39 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 08 May 2023 10:58:34 +02:00

sched/fair: Simplify asym_packing logic for SMT cores

Callers of asym_smt_can_pull_tasks() check the idle state of the
destination CPU and its SMT siblings, if any. No extra checks are needed
in such function.

Since SMT cores divide capacity among its siblings, priorities only really
make sense if only one sibling is active. This is true for SMT2, SMT4,
SMT8, etc. Do not use asym_packing load balance for this case. Instead,
let find_busiest_group() handle imbalances.

When balancing non-SMT cores or at higher scheduling domains (e.g.,
between MC scheduling groups), continue using priorities.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Len Brown <len.brown@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20230406203148.19182-4-ricardo.neri-calderon@linux.intel.com
---
 kernel/sched/fair.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 713d03e..a8a02ae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9366,12 +9366,9 @@ static bool sched_use_asym_prio(struct sched_domain *sd, int cpu)
  * the SMT siblings of @sg are busy. If only one CPU in @sg is busy, pull tasks
  * only if @dst_cpu has higher priority.
  *
- * If both @dst_cpu and @sg have SMT siblings, and @sg has exactly one more
- * busy CPU than @sds::local, let @dst_cpu pull tasks if it has higher priority.
- * Bigger imbalances in the number of busy CPUs will be dealt with in
- * update_sd_pick_busiest().
- *
- * If @sg does not have SMT siblings, only pull tasks if @sg has lower priority.
+ * When dealing with SMT cores, only use priorities if the SMT core has exactly
+ * one busy sibling. find_busiest_group() will handle bigger imbalances in the
+ * number of busy CPUs.
  *
  * Return: true if @dst_cpu can pull tasks, false otherwise.
  */
@@ -9380,12 +9377,10 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
 				    struct sched_group *sg)
 {
 #ifdef CONFIG_SCHED_SMT
-	bool local_is_smt, sg_is_smt;
+	bool local_is_smt;
 	int sg_busy_cpus;
 
 	local_is_smt = sds->local->flags & SD_SHARE_CPUCAPACITY;
-	sg_is_smt = sg->flags & SD_SHARE_CPUCAPACITY;
-
 	sg_busy_cpus = sgs->group_weight - sgs->idle_cpus;
 
 	if (!local_is_smt) {
@@ -9406,21 +9401,17 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
 		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
 	}
 
-	/* @dst_cpu has SMT siblings. */
-
-	if (sg_is_smt) {
-		int local_busy_cpus = sds->local->group_weight -
-				      sds->local_stat.idle_cpus;
-		int busy_cpus_delta = sg_busy_cpus - local_busy_cpus;
-
-		if (busy_cpus_delta == 1)
-			return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
-
+	/*
+	 * If we are here @dst_cpu has SMT siblings and are also idle.
+	 *
+	 * CPU priorities does not make sense for SMT cores with more than one
+	 * busy sibling.
+	 */
+	if (group->flags & SD_SHARE_CPUCAPACITY && sg_busy_cpus != 1)
 		return false;
-	}
 
-	/* If we are here @dst_cpu has SMT siblings and are also idle. */
 	return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
+
 #else
 	/* Always return false so that callers deal with non-SMT cases. */
 	return false;
