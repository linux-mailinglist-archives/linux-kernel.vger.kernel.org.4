Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5086DA286
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbjDFUVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238941AbjDFUVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:21:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594B67EFA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680812461; x=1712348461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=RrhA94A2/nddG4vpw3Ppg0Ud5RaLqiCH+F/KULYfg8Q=;
  b=UnxOfUuvBAzWdiTIzRcD78lgdJ9ozgZYiv+nILi8ywLDwY4NAn8jnukr
   jzJm9Wo4q1q0yuP5olBfbouoR460ZpFUZmlKZ65eg3e/B6srhicRzHSIk
   iPV8Zq7kumpONTW6TvDFdZURg9J1nJGHXzFaGmm3M4cbz41ZzesPrmK56
   ImPrG/k7vPnv3mmHz4v6SKoOuWNkiLm3rCAlrEuqN5sbun6grZNIoc6pU
   ZzlpOe3lYQ5dSJEuPbQMrCsbU6ftbq2PBR54xNyh0huSu7WRLmIGRFpBl
   r29KGkAY6qWdAPQbBCA1mMO2Dswuv2yw46pHlUD+HGbx/t4bhgatVplaq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="407957758"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="407957758"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 13:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="861529882"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="861529882"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2023 13:20:59 -0700
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
Subject: [PATCH v4 06/12] sched/fair: Use the busiest group to set prefer_sibling
Date:   Thu,  6 Apr 2023 13:31:42 -0700
Message-Id: <20230406203148.19182-7-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
References: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prefer_sibling setting acts on the busiest group to move excess tasks
to the local group. This should be done as per request of the child of the
busiest group's sched domain, not the local group's.

Using the flags of the child domain of the local group works fortuitously
if both groups have child domains.

There are cases, however, in which the busiest group's sched domain has
child but the local group's does not. Consider, for instance a non-SMT
core (or an SMT core with only one online sibling) doing load balance with
an SMT core at the MC level. SD_PREFER_SIBLING of the busiest group's child
domain will not be honored. We are left with a fully busy SMT core and an
idle non-SMT core.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Tested-by: Zhang Rui <rui.zhang@intel.com>
Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * Dropped patch that set prefer_sibling from the current sched domain
   level. Instead, uses the flags of the busiest group's child sched
   domain. (Vincent G, PeterZ, Dietmar)

Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 kernel/sched/fair.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ea23a5163bfa..477cb5777036 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10056,7 +10056,6 @@ static void update_idle_cpu_scan(struct lb_env *env,
 
 static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sds)
 {
-	struct sched_domain *child = env->sd->child;
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
@@ -10097,8 +10096,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		sg = sg->next;
 	} while (sg != env->sd->groups);
 
-	/* Tag domain that child domain prefers tasks go to siblings first */
-	sds->prefer_sibling = child && child->flags & SD_PREFER_SIBLING;
+	/*
+	 * Indicate that the child domain of the busiest group prefers tasks
+	 * go to a child's sibling domains first. NB the flags of a sched group
+	 * are those of the child domain.
+	 */
+	if (sds->busiest)
+		sds->prefer_sibling = !!(sds->busiest->flags & SD_PREFER_SIBLING);
 
 
 	if (env->sd->flags & SD_NUMA)
@@ -10398,7 +10402,10 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 			goto out_balanced;
 	}
 
-	/* Try to move all excess tasks to child's sibling domain */
+	/*
+	 * Try to move all excess tasks to a sibling domain of the busiest
+	 * group's child domain.
+	 */
 	if (sds.prefer_sibling && local->group_type == group_has_spare &&
 	    busiest->sum_nr_running > local->sum_nr_running + 1)
 		goto force_balance;
-- 
2.25.1

