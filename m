Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51E968CE5F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBGEvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjBGEut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:50:49 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3EE4224
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675745448; x=1707281448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=YXCyBdAQ0Q8XIVxjs4jHd98vK+N1vGYP5jLh9y5xDlw=;
  b=SsRNjdSSrN7/Pechmo0lvFWLJlMbcut3thdz6lEyVulzntW2fqLGpEoe
   MMkA8ZZaZm7UY5JjrC3MgQurO7pLd8nchhy2nvRcdbeSRX/+H1zyNOROI
   m/oeS9/hUPgDoB9lr/ygETgGQkP908ws2naKl6ZxTqurrtVUMfBWe2i46
   lJDNrkgebccArGTGSv199qzuQe86DMEIoH/6b2XuSIyNOMG52aCZyEVsS
   dlytJghiMrliO3eIkbWhw8XncPTJIacKdqsAwW+HPED8dmWR3pNrPhpAk
   pKm7+WaPb14KjKcFqrvnpWvLkyO+qIZkhId8cBKdNNsNBkaRWonDW2VnD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415624023"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415624023"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 20:50:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668653796"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668653796"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 20:50:47 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v3 06/10] sched/fair: Use the prefer_sibling flag of the current sched domain
Date:   Mon,  6 Feb 2023 20:58:34 -0800
Message-Id: <20230207045838.11243-7-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD_PREFER_SIBLING is set from the SMT scheduling domain up to the first
non-NUMA domain (the exception is systems with SD_ASYM_CPUCAPACITY).

Above the SMT sched domain, all domains have a child. The SD_PREFER_
SIBLING is honored always regardless of the scheduling domain at which the
load balance takes place.

There are cases, however, in which the busiest CPU's sched domain has
child but the destination CPU's does not. Consider, for instance a non-SMT
core (or an SMT core with only one online sibling) doing load balance with
an SMT core at the MC level. SD_PREFER_SIBLING will not be honored. We are
left with a fully busy SMT core and an idle non-SMT core.

Avoid inconsistent behavior. Use the prefer_sibling behavior at the current
scheduling domain, not its child.

The NUMA sched domain does not have the SD_PREFER_SIBLING flag. Thus, we
will not spread load among NUMA sched groups, as desired.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 kernel/sched/fair.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df7bcbf634a8..a37ad59f20ea 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10004,7 +10004,6 @@ static void update_idle_cpu_scan(struct lb_env *env,
 
 static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sds)
 {
-	struct sched_domain *child = env->sd->child;
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
@@ -10045,9 +10044,11 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		sg = sg->next;
 	} while (sg != env->sd->groups);
 
-	/* Tag domain that child domain prefers tasks go to siblings first */
-	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
-
+	/*
+	 * Tag domain that @env::sd prefers to spread excess tasks among
+	 * sibling sched groups.
+	 */
+	sds->prefer_sibling = env->sd->flags & SD_PREFER_SIBLING;
 
 	if (env->sd->flags & SD_NUMA)
 		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
@@ -10346,7 +10347,6 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 			goto out_balanced;
 	}
 
-	/* Try to move all excess tasks to child's sibling domain */
 	if (sds.prefer_sibling && local->group_type == group_has_spare &&
 	    busiest->sum_nr_running > local->sum_nr_running + 1)
 		goto force_balance;
-- 
2.25.1

