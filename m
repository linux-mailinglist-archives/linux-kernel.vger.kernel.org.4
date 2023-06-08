Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E9A728B22
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237188AbjFHWcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbjFHWcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:32:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D73C2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686263535; x=1717799535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GtHT20V983sr8n3O3e7GEiqoyfK5vMEHBMPj3byjlrM=;
  b=DOgZyUuipnZmO8SgyaUmEcIwqlYn1hfR/rC929YszL40yF6fEcaJdd87
   Sd8fjK3UZR/RjM//DKXIloMGivn/b3kAilP6oe9kEV5BKssw7HzPkVorg
   jAlTdChubMIIfRKqtkqamE1tyjF7ObywrVn0JGsxWVYISAiOiBUHUHlji
   amIP3kp8eLe8nmc0azBdpkodkg/ud60bMTkp8K2YxP7WA2JcDAoISQE1E
   cSCK65LpkaPi1Og8vjZwbnPbBtes5SnIXHiq1jxJF2x/g7ijhtIJxuGVR
   Ko8E8rCA4CClUreck7jHnPq/pK94gBrS1AoX1bTPAONRlz/yAV//s+loz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="347094722"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="347094722"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 15:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="956906445"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="956906445"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2023 15:32:13 -0700
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
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Subject: [Patch v2 2/6] sched/topology: Record number of cores in sched group
Date:   Thu,  8 Jun 2023 15:32:28 -0700
Message-Id: <a8acc91631a1c044ee16081bc80c1b044827c7b2.1686263351.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1686263351.git.tim.c.chen@linux.intel.com>
References: <cover.1686263351.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim C Chen <tim.c.chen@linux.intel.com>

When balancing sibling domains that have different number of cores,
tasks in respective sibling domain should be proportional to the number
of cores in each domain. In preparation of implementing such a policy,
record the number of tasks in a scheduling group.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/sched.h    |  1 +
 kernel/sched/topology.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3d0eb36350d2..5f7f36e45b87 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1860,6 +1860,7 @@ struct sched_group {
 	atomic_t		ref;
 
 	unsigned int		group_weight;
+	unsigned int		cores;
 	struct sched_group_capacity *sgc;
 	int			asym_prefer_cpu;	/* CPU of highest priority in group */
 	int			flags;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6d5628fcebcf..6b099dbdfb39 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1275,14 +1275,22 @@ build_sched_groups(struct sched_domain *sd, int cpu)
 static void init_sched_groups_capacity(int cpu, struct sched_domain *sd)
 {
 	struct sched_group *sg = sd->groups;
+	struct cpumask *mask = sched_domains_tmpmask2;
 
 	WARN_ON(!sg);
 
 	do {
-		int cpu, max_cpu = -1;
+		int cpu, cores = 0, max_cpu = -1;
 
 		sg->group_weight = cpumask_weight(sched_group_span(sg));
 
+		cpumask_copy(mask, sched_group_span(sg));
+		for_each_cpu(cpu, mask) {
+			cores++;
+			cpumask_andnot(mask, mask, cpu_smt_mask(cpu));
+		}
+		sg->cores = cores;
+
 		if (!(sd->flags & SD_ASYM_PACKING))
 			goto next;
 
-- 
2.32.0

