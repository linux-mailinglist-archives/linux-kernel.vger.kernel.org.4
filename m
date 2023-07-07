Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D494A74B9BB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjGGW5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjGGW4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:56:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DCC1997
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688770614; x=1720306614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GtHT20V983sr8n3O3e7GEiqoyfK5vMEHBMPj3byjlrM=;
  b=DW44dRz7PP7qXGzmS0qu36AVxPOX/tWHCYhmHNNhwBvXgo02ykRyF853
   +KJ0gjLdLL7cT9Gx4OXQfcNWcWvTXRLdh3BhgG4+UleE7IbUmb2nYmfcE
   HvF0z40i1c/wwagL/P1FqKleyPzyznrO7VkgKy6qsUhGbRBIJJURQ2pXY
   9jSX97WBjxejfoHbgBZfKVzgMovp82Ia1GKrvvleuvOBSgui43EoBjZt1
   GuIhAhZxFhX8FBBvO2CnGNDlBQAcuZ+6JaF0iM+3RXbFllfSOS6UizjGP
   mC651krSCGxP0tjfX3mhjg8nCx22KmGcvt9ZyJfyf31wowwmTkywVbYXC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="427683460"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="427683460"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 15:56:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="714176664"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="714176664"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2023 15:56:54 -0700
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
Subject: [Patch v3 2/6] sched/topology: Record number of cores in sched group
Date:   Fri,  7 Jul 2023 15:57:01 -0700
Message-Id: <04641eeb0e95c21224352f5743ecb93dfac44654.1688770494.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1688770494.git.tim.c.chen@linux.intel.com>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

