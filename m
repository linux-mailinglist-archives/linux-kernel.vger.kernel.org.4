Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A81D72D873
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbjFMEWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239335AbjFMEV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:21:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB28C10FE;
        Mon, 12 Jun 2023 21:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630107; x=1718166107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ci6rEw05hh+1ShG1mMr7Z5qVrukY7SAsqk+7oT7Fwys=;
  b=AXE4E/C/FhFhBS8MBhZqnDWnzmDW9/197iXZc4yPGxUlt+Bvpk3DbLLN
   CaApxDPwC9aArUDsI5IER2iZVcFeXnUwNNh4qHOAOx8F2EskuVaHTPeZX
   lcTqDYsL2YEM8H0bhOYzO14/yykl+X3xKPFcFzZxkyiTD8VQrME/7bWhS
   aK5BUge6GxoDK3Hb1jm0ZJxcES4emPsQkHVaFZWpWnsUieZpjzvrK0vnI
   lEzUOK7EC4smoWAOnMotpQ884yeZjCnxumWLCmyt+gVIuHPGGFxvheV5D
   6p553UIbaciMJu5FyVFMtDNAHwlwOcfUjI2wGp3fuw+IZY5UCJcuoAiFS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222131"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222131"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:21:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854959"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854959"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:45 -0700
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
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Subject: [PATCH v4 09/24] sched/fair: Use IPCC stats to break ties between fully_busy SMT groups
Date:   Mon, 12 Jun 2023 21:24:07 -0700
Message-Id: <20230613042422.5344-10-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
References: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPCC statistics are used during idle load balancing. After balancing one
of the siblings of an SMT core becomes idle. The remaining busy siblings
experience increased throughput. The IPCC statistics provide a measure of
the increased throughput. Use them to select the busiest group between
otherwise identical fully_busy scheduling groups. (The avg_load is not
computed in this case and is zero for both groups).

IPCC scores are not needed to break ties with non-SMT fully_busy sched
groups. SMT sched groups always need more help.

Add a stub sched_asym_ipcc_prefer() to handle !CONFIG_IPC_CLASSES.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Perry Yuan <Perry.Yuan@amd.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * None

Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 kernel/sched/fair.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fb3d793fe9ad..fcec791ede4f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9580,6 +9580,12 @@ static void update_sg_lb_stats_scores(struct sg_lb_stats *sgs,
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
@@ -9861,10 +9867,21 @@ static bool update_sd_pick_busiest(struct lb_env *env,
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

