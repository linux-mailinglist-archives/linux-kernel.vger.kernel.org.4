Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679B672BB93
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 11:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjFLJBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 05:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjFLI7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:59:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F0A4C2C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686560203; x=1718096203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3WaBk3ipuUhPJfycoWD1IThEDoF7rWzFGbKxq/ZZIWk=;
  b=IB0RhV3mt20qESCUUItJwuNT/t18h30Jb7KKXZQKps/+oq0vAHvAp7O7
   Je2NGRwruZAAO9Hp0WmWSSkQIw5pTjyeDyuDeXGSQEnyYHF0PLiB/hPvw
   ywK8WG4qTldIIXtQ3F2AYjJyhLUTnDAq29RuVCQxPXGuHKnOJmuaVFpPK
   21iI8Bvzjdztv6jq/Qdx2Hncf5yfADTwbJPTDe2oSoi8wTZGG00AOC5Ps
   TiTECX5MlvXYZYIfLVdlB3nz19wSwxrSnEScvhq52baJ4E74nOiP4NKSc
   LwYaI3h6LW8KdS5j6vsbNTvRuAZsV+6P08ES0wjf2qCJaSEeb7Q5pZ5zc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="361339526"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="361339526"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 01:23:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="705297130"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="705297130"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orsmga007.jf.intel.com with ESMTP; 12 Jun 2023 01:23:13 -0700
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
Subject: [RFC PATCH 2/4] sched/topology: Introduce nr_groups in sched_domain to indicate the number of groups
Date:   Tue, 13 Jun 2023 00:18:42 +0800
Message-Id: <4f7926d0d392ae88ae57815cca6a0369c8cf7cb8.1686554037.git.yu.c.chen@intel.com>
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

Record the number of sched groups within each sched domain. Prepare for
newidle_balance() scan depth calculation.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched/topology.h |  1 +
 kernel/sched/topology.c        | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 816df6cc444e..1faececd5694 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -152,6 +152,7 @@ struct sched_domain {
 	struct sched_domain_shared *shared;
 
 	unsigned int span_weight;
+	unsigned int nr_groups;
 	/*
 	 * Span of all CPUs in this domain.
 	 *
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index ca4472281c28..255606e88956 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1023,7 +1023,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 	struct cpumask *covered = sched_domains_tmpmask;
 	struct sd_data *sdd = sd->private;
 	struct sched_domain *sibling;
-	int i;
+	int i, nr_groups = 0;
 
 	cpumask_clear(covered);
 
@@ -1087,6 +1087,8 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		if (!sg)
 			goto fail;
 
+		nr_groups++;
+
 		sg_span = sched_group_span(sg);
 		cpumask_or(covered, covered, sg_span);
 
@@ -1100,6 +1102,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		last->next = first;
 	}
 	sd->groups = first;
+	sd->nr_groups = nr_groups;
 
 	return 0;
 
@@ -1233,7 +1236,7 @@ build_sched_groups(struct sched_domain *sd, int cpu)
 	struct sd_data *sdd = sd->private;
 	const struct cpumask *span = sched_domain_span(sd);
 	struct cpumask *covered;
-	int i;
+	int i, nr_groups = 0;
 
 	lockdep_assert_held(&sched_domains_mutex);
 	covered = sched_domains_tmpmask;
@@ -1248,6 +1251,8 @@ build_sched_groups(struct sched_domain *sd, int cpu)
 
 		sg = get_group(i, sdd);
 
+		nr_groups++;
+
 		cpumask_or(covered, covered, sched_group_span(sg));
 
 		if (!first)
@@ -1258,6 +1263,7 @@ build_sched_groups(struct sched_domain *sd, int cpu)
 	}
 	last->next = first;
 	sd->groups = first;
+	sd->nr_groups = nr_groups;
 
 	return 0;
 }
-- 
2.25.1

