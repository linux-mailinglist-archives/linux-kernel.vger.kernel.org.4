Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B0B6DA284
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbjDFUVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238928AbjDFUVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:21:01 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C92F83D0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680812460; x=1712348460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UpPZ9Wr2ID6fVnMIXrYeJqlEArUgoKya/Nc91Ii6rZw=;
  b=G18mRTMyMNG0U0Bz4SPdL6U65IuCEsWN3pEFFkbGg1jdU1RTSOkOB12z
   GEZhfMN1ZOxAoEJtl/cZqcDfEyjeBnhAnG9XA7VJ3fbIKspJ83hGTRv+Y
   Ln7tbHP590BNrPOydL+Qa3R5WzkfdQyLkth7y/l2A1kSN4VJK91ThO1sx
   rybjck2lwakWoIooVSZvXeLx6DCSGzIsAaAf2Ky5w3Y4tdYgFaJ1PAaOv
   lBK1caq+5unCJaFxZRMj4YygfuAgrhI6mvfv7MeNxL4uh21ulba03+Y2f
   0guLaIH1pcQYfpOeHHcRVwIwNxvz4WEboQKmFKBqTtres8lbK3hwXXiad
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="407957729"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="407957729"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 13:20:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="861529875"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="861529875"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2023 13:20:58 -0700
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
Subject: [PATCH v4 04/12] sched/fair: Let low-priority cores help high-priority busy SMT cores
Date:   Thu,  6 Apr 2023 13:31:40 -0700
Message-Id: <20230406203148.19182-5-ricardo.neri-calderon@linux.intel.com>
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

Using asym_packing priorities within an SMT core is straightforward. Just
follow the priorities that hardware indicates.

When balancing load from an SMT core, also consider the idle state of its
siblings. Priorities do not reflect that an SMT core divides its throughput
among all its busy siblings. They only makes sense when exactly one sibling
is busy.

Indicate that active balance is needed if the destination CPU has lower
priority than the source CPU but the latter has busy SMT siblings.

Make find_busiest_queue() not skip higher-priority SMT cores with more than
busy sibling.

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
Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * Improved the logic to determine whether CPU priority should be followed.
   Also, wrapped this logic in a helper function. (Vincent G./ Peter)

Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 kernel/sched/fair.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b6bbe0300635..b151e93ec316 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10488,8 +10488,15 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		    nr_running == 1)
 			continue;
 
-		/* Make sure we only pull tasks from a CPU of lower priority */
+		/*
+		 * Make sure we only pull tasks from a CPU of lower priority
+		 * when balancing between SMT siblings.
+		 *
+		 * If balancing between cores, let lower priority CPUs help
+		 * SMT cores with more than one busy sibling.
+		 */
 		if ((env->sd->flags & SD_ASYM_PACKING) &&
+		    sched_use_asym_prio(env->sd, i) &&
 		    sched_asym_prefer(i, env->dst_cpu) &&
 		    nr_running == 1)
 			continue;
@@ -10582,10 +10589,15 @@ asym_active_balance(struct lb_env *env)
 	 * priority CPUs in order to pack all tasks in the highest priority
 	 * CPUs. When done between cores, do it only if the whole core if the
 	 * whole core is idle.
+	 *
+	 * If @env::src_cpu is an SMT core with busy siblings, let
+	 * the lower priority @env::dst_cpu help it. Do not follow
+	 * CPU priority.
 	 */
 	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
 	       sched_use_asym_prio(env->sd, env->dst_cpu) &&
-	       sched_asym_prefer(env->dst_cpu, env->src_cpu);
+	       (sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
+		!sched_use_asym_prio(env->sd, env->src_cpu));
 }
 
 static inline bool
-- 
2.25.1

