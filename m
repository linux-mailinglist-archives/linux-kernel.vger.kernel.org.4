Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CA86DA289
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbjDFUVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238981AbjDFUVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:21:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AD793D8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680812462; x=1712348462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=kHnMH+5Ty9vpOYHxJB9coCCq990ixF1Ymwjs8OZoq8o=;
  b=XszhB/p1ihVVFu09cV1MpN5gVhbhCDzklnyT4oAhE+6sET8v3rmyeRb8
   udbUAfSwD71gm72bs/fypaRHMH4+JQrecuwyx4gpjKxcW7i4rPoThcT8y
   j76DZ//nJJDtkfEhaDSxr4/4v8To2npoQEazub0zJC6JG1whTNlKgqM8O
   pLLG5PZx86g3d6KDhZswEhxWnxzukImYTALKTlK1SI2HwNNu3vr6HtbWg
   5FkNsPBI9btxJa2GvHASvFGzTHUAbgk0OVz4hPZl5GE+lBpGveflkD5ou
   uj187HVApBxcivibLxoQKWe9uDR7sxF/yPB3VrWP9cnipq4yRCTkLwAIA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="407957784"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="407957784"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 13:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="861529890"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="861529890"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2023 13:21:00 -0700
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
Subject: [PATCH v4 08/12] sched/topology: Check SDF_SHARED_CHILD in highest_flag_domain()
Date:   Thu,  6 Apr 2023 13:31:44 -0700
Message-Id: <20230406203148.19182-9-ricardo.neri-calderon@linux.intel.com>
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

Do not assume that all the children of a scheduling domain have a given
flag. Check whether it has the SDF_SHARED_CHILD meta flag.

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
Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * Introduced this patch.

Changes since v2:
 * N/A

Changes since v1:
 * N/A
---
 kernel/sched/sched.h | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 060616944d7a..70abce91b549 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1772,6 +1772,13 @@ queue_balance_callback(struct rq *rq,
 	for (__sd = rcu_dereference_check_sched_domain(cpu_rq(cpu)->sd); \
 			__sd; __sd = __sd->parent)
 
+/* A mask of all the SD flags that have the SDF_SHARED_CHILD metaflag */
+#define SD_FLAG(name, mflags) (name * !!((mflags) & SDF_SHARED_CHILD)) |
+static const unsigned int SD_SHARED_CHILD_MASK =
+#include <linux/sched/sd_flags.h>
+0;
+#undef SD_FLAG
+
 /**
  * highest_flag_domain - Return highest sched_domain containing flag.
  * @cpu:	The CPU whose highest level of sched domain is to
@@ -1779,16 +1786,25 @@ queue_balance_callback(struct rq *rq,
  * @flag:	The flag to check for the highest sched_domain
  *		for the given CPU.
  *
- * Returns the highest sched_domain of a CPU which contains the given flag.
+ * Returns the highest sched_domain of a CPU which contains @flag. If @flag has
+ * the SDF_SHARED_CHILD metaflag, all the children domains also have @flag.
  */
 static inline struct sched_domain *highest_flag_domain(int cpu, int flag)
 {
 	struct sched_domain *sd, *hsd = NULL;
 
 	for_each_domain(cpu, sd) {
-		if (!(sd->flags & flag))
+		if (sd->flags & flag) {
+			hsd = sd;
+			continue;
+		}
+
+		/*
+		 * Stop the search if @flag is known to be shared at lower
+		 * levels. It will not be found further up.
+		 */
+		if (flag & SD_SHARED_CHILD_MASK)
 			break;
-		hsd = sd;
 	}
 
 	return hsd;
-- 
2.25.1

