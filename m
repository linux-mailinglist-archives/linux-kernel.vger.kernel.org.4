Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265C568CE5C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjBGEvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjBGEus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:50:48 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DF044BC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675745448; x=1707281448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=BhYkRtUf49Glw2ZU0a3Pjs3bki0DXfT9COx0nHL/qCw=;
  b=YDiE51cFVqLf62JsGMdpJchxCPazPEa9taxciml+UxNWEVPIcA387Y9j
   UH7SiGW7dUPaLVD4FNTHSz7wcEV4HQwAntBYK/vvsXcTfcy7znMlRqdLz
   /bAXyt6wxsLMuFoGXXt0Hd8y+XpOHfgUZwgMw8XevWJUGC1QJvjjZ6v0M
   0cxLIt21/6FKXhOnMrRjd5cGUsO1mCc85vjjv9F8uAGWpYckXHI07tglT
   S4OsdxcvJusnDo/fPLWUiPgOhSq9LvSTujYic9YdZw+WbZ0+4p4A59SYW
   vew3fVbz6tnRXI2Jzn8UDs3pePGt/g+fz9HmBQpit6AuaRNix0yWWlsQ9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415624005"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415624005"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 20:50:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668653789"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668653789"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 20:50:46 -0800
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
Subject: [PATCH v3 04/10] sched/fair: Let low-priority cores help high-priority busy SMT cores
Date:   Mon,  6 Feb 2023 20:58:32 -0800
Message-Id: <20230207045838.11243-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
References: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using asym_packing priorities within an SMT core is straightforward. Just
follow the priorities that hardware indicates.

When balancing load from an SMT core, also consider the idle of its
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
Cc: Len Brown <len.brown@intel.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 kernel/sched/fair.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 80c86462c6f6..c9d0ddfd11f2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10436,11 +10436,20 @@ static struct rq *find_busiest_queue(struct lb_env *env,
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
 		    sched_asym_prefer(i, env->dst_cpu) &&
-		    nr_running == 1)
-			continue;
+		    nr_running == 1) {
+			if (env->sd->flags & SD_SHARE_CPUCAPACITY ||
+			    (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && is_core_idle(i)))
+				continue;
+		}
 
 		switch (env->migration_type) {
 		case migrate_load:
@@ -10530,8 +10539,20 @@ asym_active_balance(struct lb_env *env)
 	 * lower priority CPUs in order to pack all tasks in the
 	 * highest priority CPUs.
 	 */
-	return env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING) &&
-	       sched_asym_prefer(env->dst_cpu, env->src_cpu);
+	if (env->idle != CPU_NOT_IDLE && (env->sd->flags & SD_ASYM_PACKING)) {
+		/* Always obey priorities between SMT siblings. */
+		if (env->sd->flags & SD_SHARE_CPUCAPACITY)
+			return sched_asym_prefer(env->dst_cpu, env->src_cpu);
+
+		/*
+		 * A lower priority CPU can help an SMT core with more than one
+		 * busy sibling.
+		 */
+		return sched_asym_prefer(env->dst_cpu, env->src_cpu) ||
+		       !is_core_idle(env->src_cpu);
+	}
+
+	return false;
 }
 
 static inline bool
-- 
2.25.1

