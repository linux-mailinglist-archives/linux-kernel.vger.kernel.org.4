Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826686F6FA0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjEDQLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEDQLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:11:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0B7468D
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683216701; x=1714752701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vT2vIVEfkCpmJviU9tKqD9nJ8NrFNPIaPN26mFs6XY8=;
  b=ICtA9VFwhr1jJDs2TGz+ZQnzIXWAYOTyxDek8P97uJHdOtw/f5447arR
   7ZMF5IlKpWB25atk0Nkumxmy3k8nEOL1gOO6v5oeE5AR2zI0xntJzs13V
   S81fmOrANW0d3S+LV1VfJ5y0ky8opJpn5+c+9yIFjQmj8M1pZHLG8JeIR
   rPIY44cPo2d9bm1Xd7qYSDM7AXwwCxLU7v7+uPprCt7PnBdjk6X8tlrlw
   khnvCml6V/KonO5I8oR2eGUbOcXBRvKh8uZX03qPDlam4dRFxh13K/yrm
   cFr98wTy+HDCqgJrLrzfv6fcHgy2m9iaKfcUM4rqcMi9GcQxc8meO4eE/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="377049040"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="377049040"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 09:09:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766633515"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766633515"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga004.fm.intel.com with ESMTP; 04 May 2023 09:09:31 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tim C Chen <tim.c.chen@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 2/6] sched/fair: Check whether active load balance is needed in busiest group
Date:   Thu,  4 May 2023 09:09:52 -0700
Message-Id: <231cf298efb8627499bb42788588a6108c7b8f7c.1683156492.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1683156492.git.tim.c.chen@linux.intel.com>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim C Chen <tim.c.chen@linux.intel.com>

In the busiest group, we need to consider whether active load balance
to a local group is needed even when it is not overloaded.  For example,
when the busiest group is a SMT group that's fully busy and the destination group
is a cluster group with idle CPU.  Such condition is considered by
asym_active_balance() in load balancing but not when looking for busiest
group and load imbalance.  Add this consideration in find_busiest_group()
and calculate_imbalance().

Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 87317634fab2..bde962aa160a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9433,6 +9433,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 				sgs->group_capacity;
 }
 
+/* One group is SMT while the other group is not */
+static inline bool asymmetric_groups(struct sched_group *sg1,
+				    struct sched_group *sg2)
+{
+	if (!sg1 || !sg2)
+		return false;
+
+	return (sg1->flags & SD_SHARE_CPUCAPACITY) !=
+		(sg2->flags & SD_SHARE_CPUCAPACITY);
+}
+
 /**
  * update_sd_pick_busiest - return 1 on busiest group
  * @env: The load balancing environment.
@@ -10079,6 +10090,31 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	update_idle_cpu_scan(env, sum_util);
 }
 
+static inline bool asym_active_balance_busiest(struct lb_env *env, struct sd_lb_stats *sds)
+{
+	/*
+	 * Don't balance to a group without spare capacity.
+	 *
+	 * Skip non asymmetric sched group balancing. That check
+	 * is handled by code path handling imbalanced load between
+	 * similar groups.
+	 */
+	if (env->idle == CPU_NOT_IDLE ||
+	    sds->local_stat.group_type != group_has_spare ||
+	    !asymmetric_groups(sds->local, sds->busiest))
+		return false;
+
+	/*
+	 * For SMT source group, pull when there are two or more
+	 * tasks over-utilizing a core.
+	 */
+	if (sds->busiest->flags & SD_SHARE_CPUCAPACITY &&
+	    sds->busiest_stat.sum_h_nr_running > 1)
+		return true;
+
+	return false;
+}
+
 /**
  * calculate_imbalance - Calculate the amount of imbalance present within the
  *			 groups of a given sched_domain during load balance.
@@ -10164,6 +10200,12 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 			return;
 		}
 
+		if (asym_active_balance_busiest(env, sds)) {
+			env->migration_type = migrate_task;
+			env->imbalance = 1;
+			return;
+		}
+
 		if (busiest->group_weight == 1 || sds->prefer_sibling) {
 			unsigned int nr_diff = busiest->sum_nr_running;
 			/*
@@ -10371,6 +10413,9 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 			 */
 			goto out_balanced;
 
+		if (asym_active_balance_busiest(env, &sds))
+			goto force_balance;
+
 		if (busiest->group_weight > 1 &&
 		    local->idle_cpus <= (busiest->idle_cpus + 1))
 			/*
-- 
2.32.0

