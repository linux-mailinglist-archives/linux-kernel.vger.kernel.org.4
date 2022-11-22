Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F07D634825
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiKVU2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiKVU2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:28:14 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11EE1AD83
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669148893; x=1700684893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=0yHmKdRsV591tHGMnKRYVefaIOCtc6d0I/pJdG+LlvU=;
  b=VixAVveTTgBILU537x5lOBygOGbEtNITiTtO12/uMiymItMal26+/PfT
   EWaE9taAOryiZQ6bDPqaWr3nfsCf0VphmrraexHIxFL8sTO/zJld679p9
   g+BtA8xRQgcjsCVwlYe5hV/mBO56OETLCkqBk3XEIvP81yfF7wt5Z7WNG
   4B7c3G1gLvUn9oT0eIuM7Ai8jn4qPUVeJoOhz7pXI5HjeiHiRbq6lW7VZ
   OcLRgnPwvKooEJTPH1hpsI2JW6MGrIgGRQLxgRexjNnc954PMgPISKr+B
   abdROcQZJWxzIgBvFXP66hfbPPHvYVOS91j28vHgdmyQjzgT8TcHZL+LG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="293616500"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="293616500"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:28:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="816228121"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="816228121"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 22 Nov 2022 12:28:12 -0800
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
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v2 1/7] sched/fair: Generalize asym_packing logic for SMT local sched group
Date:   Tue, 22 Nov 2022 12:35:26 -0800
Message-Id: <20221122203532.15013-2-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When balancing load between two physical cores, an idle destination CPU can
help another core only if all of its SMT siblings are also idle. Otherwise,
there is not increase in throughput. It does not matter whether the other
core is composed of SMT siblings.

Simply check if there are any tasks running on the local group and the
other core has exactly one busy CPU before proceeding. Let
find_busiest_group() handle the case of more than one busy CPU. This is
true for SMT2, SMT4, SMT8, etc.

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
Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v1:
 * Reworded commit message and inline comments for clarity.
 * Stated that this changeset does not impact STM4 or SMT8.
---
 kernel/sched/fair.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e4a0b8bd941c..18c672ff39ef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8900,12 +8900,10 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
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
@@ -8926,25 +8924,16 @@ static bool asym_smt_can_pull_tasks(int dst_cpu, struct sd_lb_stats *sds,
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
-		return false;
-	}
-
 	/*
-	 * @sg does not have SMT siblings. Ensure that @sds::local does not end
-	 * up with more than one busy SMT sibling and only pull tasks if there
-	 * are not busy CPUs (i.e., no CPU has running tasks).
+	 * @dst_cpu has SMT siblings. Do asym_packing load balancing only if
+	 * all its siblings are idle (moving tasks between physical cores in
+	 * which some SMT siblings are busy results in the same throughput).
+	 *
+	 * If the difference in the number of busy CPUs is two or more, let
+	 * find_busiest_group() take care of it. We only care if @sg has
+	 * exactly one busy CPU. This covers SMT and non-SMT sched groups.
 	 */
-	if (!sds->local_stat.sum_nr_running)
+	if (sg_busy_cpus == 1 && !sds->local_stat.sum_nr_running)
 		return sched_asym_prefer(dst_cpu, sg->asym_prefer_cpu);
 
 	return false;
-- 
2.25.1

