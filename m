Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E6C72BA51
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjFLIXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjFLIXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:23:24 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E158171F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686558182; x=1718094182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=74mS8zfJCxwIJez6rBlG1jbdweme2WYHaeh5GQle0UU=;
  b=C1w5zqoJLtpTFB3zK3tp6ZKOeWi7CRu1A6iNOpqqQrJ0/eipAt4KXDFn
   BheCazUS2oiz1tfFbDATT/bZoXWJArgLcQsd1QjnoKLWhzph9J74sa20P
   imVBIsu9aAMGUGc0zsxgdIXBB9MzMeDdBi6pmLaReSiPsLqoWIS9zSu39
   ThfnJN4v3PCBUCmV/lsEeJhbBn0c9Qk7VTkz70VRt3pycXM2Je12TE97w
   FkfFalL+aefUF3Tb7tkOUB7h0xaEoWPhxBjy06b4ZTS07qIPgA8fOZ9cj
   IMqxeN52qvaqb2lYtgsdAGlXuJAhmxf7p/USj0NKtv7UgbXD9Nuz3+Zle
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="356861561"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="356861561"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 01:23:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="823892226"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="823892226"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jun 2023 01:22:56 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH 1/4] sched/fair: Extract the function to get the sd_llc_shared
Date:   Tue, 13 Jun 2023 00:18:19 +0800
Message-Id: <49789cee643fcef7827d2602af35f1198e8a28d0.1686554037.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686554037.git.yu.c.chen@intel.com>
References: <cover.1686554037.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce get_llc_shared() to get the sd_llc_shared of dst_cpu, if
the current domain is in LLC. Let SIS_UTIL be the first user to use
this function. Prepare for later use by ILB_UTIL.

No functional change is intended.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6189d1a45635..b3a24aead848 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10043,10 +10043,21 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 	return idlest;
 }
 
+/* Get the LLC shared information of dst CPU if doing balance in LLC */
+static struct sched_domain_shared *get_llc_shared(struct lb_env *env)
+{
+	struct sched_domain_shared *sd_share = NULL;
+
+	if (per_cpu(sd_llc_size, env->dst_cpu) == env->sd->span_weight)
+		sd_share = rcu_dereference(per_cpu(sd_llc_shared, env->dst_cpu));
+
+	return sd_share;
+}
+
 static void update_idle_cpu_scan(struct lb_env *env,
-				 unsigned long sum_util)
+				 unsigned long sum_util,
+				 struct sched_domain_shared *sd_share)
 {
-	struct sched_domain_shared *sd_share;
 	int llc_weight, pct;
 	u64 x, y, tmp;
 	/*
@@ -10060,14 +10071,11 @@ static void update_idle_cpu_scan(struct lb_env *env,
 	if (!sched_feat(SIS_UTIL) || env->idle == CPU_NEWLY_IDLE)
 		return;
 
-	llc_weight = per_cpu(sd_llc_size, env->dst_cpu);
-	if (env->sd->span_weight != llc_weight)
-		return;
-
-	sd_share = rcu_dereference(per_cpu(sd_llc_shared, env->dst_cpu));
 	if (!sd_share)
 		return;
 
+	llc_weight = per_cpu(sd_llc_size, env->dst_cpu);
+
 	/*
 	 * The number of CPUs to search drops as sum_util increases, when
 	 * sum_util hits 85% or above, the scan stops.
@@ -10122,6 +10130,7 @@ static void update_idle_cpu_scan(struct lb_env *env,
 
 static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sds)
 {
+	struct sched_domain_shared *sd_share = get_llc_shared(env);
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
@@ -10190,7 +10199,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
 	}
 
-	update_idle_cpu_scan(env, sum_util);
+	update_idle_cpu_scan(env, sum_util, sd_share);
 }
 
 /**
-- 
2.25.1

