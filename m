Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A7A68CE8C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjBGFCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjBGFBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:01:55 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43E4901F;
        Mon,  6 Feb 2023 21:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675746113; x=1707282113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=XBeyrfeapZSrbuAay+AhGt8TNoIKKt2H5iHcCn0WtSs=;
  b=dhD9I/7mLVj2Pggklg/grywvghBoSKaHwulbTuRAAHYuSm415n4FAEfV
   tYcSr+xDP+sso3ijlWudcK+qfujjfWET/RZHe5mWc7Rcarq7kwPwyaejx
   47TbMWIgSkkkWrwRxyQj36YO2mQVrMudO8wQ6VkRhb3nBeHdigjm46e/P
   UcpJL10fI5HT6suN3NwaKLGJj+pvhcYvFoR/acBhYiGK6LiYaVum9sCkr
   0eA0Q3jPQDP1zUSOpT3mVTJ6y95Mj7Ri7Ecd6mFaDJPs4JiLYb/8bPE2h
   Gacexu2m7mQUSjj3I1fzWPF+F+YLmpc4k+EivlWM2dlB1gDdZCQDiMkc1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415625837"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415625837"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 21:01:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668657723"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668657723"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 21:01:42 -0800
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
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v3 09/24] sched/fair: Use IPCC stats to break ties between fully_busy SMT groups
Date:   Mon,  6 Feb 2023 21:10:50 -0800
Message-Id: <20230207051105.11575-10-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPCC statistics are used during idle load balancing. After balancing one
of the siblings of an SMT core will become idle. The rest of the busy
siblings will enjoy increased throughput. The IPCC statistics provide
a measure of the increased throughput. Use them to pick a busiest group
from otherwise identical fully_busy scheduling groups (of which the
avg_load is equal - and zero).

Using IPCC scores to break ties with non-SMT fully_busy sched groups
is not necessary. SMT sched groups always need more help.

Add a stub sched_asym_ipcc_prefer() for !CONFIG_IPC_CLASSES.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 kernel/sched/fair.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 841927b9b192..72d88270b320 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9415,6 +9415,12 @@ static void update_sg_lb_stats_scores(struct sg_lb_stats *sgs,
 {
 }
 
+static bool sched_asym_ipcc_prefer(struct sg_lb_stats *a,
+				   struct sg_lb_stats *b)
+{
+	return false;
+}
+
 static bool sched_asym_ipcc_pick(struct sched_group *a,
 				 struct sched_group *b,
 				 struct sg_lb_stats *a_stats,
@@ -9698,10 +9704,21 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 		if (sgs->avg_load == busiest->avg_load) {
 			/*
 			 * SMT sched groups need more help than non-SMT groups.
-			 * If @sg happens to also be SMT, either choice is good.
 			 */
-			if (sds->busiest->flags & SD_SHARE_CPUCAPACITY)
-				return false;
+			if (sds->busiest->flags & SD_SHARE_CPUCAPACITY) {
+				if (!(sg->flags & SD_SHARE_CPUCAPACITY))
+					return false;
+
+				/*
+				 * Between two SMT groups, use IPCC scores to pick the
+				 * one that would improve throughput the most (only
+				 * asym_packing uses IPCC scores for now).
+				 */
+				if (sched_ipcc_enabled() &&
+				    env->sd->flags & SD_ASYM_PACKING &&
+				    sched_asym_ipcc_prefer(busiest, sgs))
+					return false;
+			}
 		}
 
 		break;
-- 
2.25.1

