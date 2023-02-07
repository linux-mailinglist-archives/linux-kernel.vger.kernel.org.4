Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6A268CE9F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjBGFDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjBGFB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:01:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C96BD52A;
        Mon,  6 Feb 2023 21:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675746117; x=1707282117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=JgRkYVFr3x01km8FwYfHaTTQU7Y65rdIHc+lrY4vxao=;
  b=KzWpAtfmumtSM1eYljIE9LJ+HZG/fiLSQ6asQ9NEnvVsdrO86a44bIfR
   ucZx3mq/QlB3WBkhbmbJFfi27J2EPn9boEGMkfRQZ2aP1JET4yecVEKcF
   TXVScFQ/duJxsTDlaZg54Yz1IRcUNo4RBOGaJn52atMXvwPR4gWe4boFi
   8O6PoK6H8gm0RLERj2ekOd0QPboQV2P4/dHaMGC8QtCQrbKuZe5FC5ipM
   Ueq3+i+6BAARmBdj7z8FuckEOPwDz8MV4jndHw+TcXCta18DMYarnom1l
   NVybexqFUzS8wfsDcRZpCUoXncthXd+zRZPjYjjR4GgYE4WhgJL0GlhkA
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415625927"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415625927"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 21:01:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668657762"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668657762"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 21:01:45 -0800
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
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Tim C . Chen" <tim.c.chen@intel.com>
Subject: [PATCH v3 18/24] sched/task_struct: Add helpers for IPC classification
Date:   Mon,  6 Feb 2023 21:10:59 -0800
Message-Id: <20230207051105.11575-19-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
References: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unprocessed classification that hardware provides for a task may not
be usable by the scheduler: the classification may change too frequently or
architectures may want to consider extra factors. For instance, some
processors with Intel Thread Director need to consider the state of the SMT
siblings of a core.

Provide per-task helper variables that architectures can use to post-
process the classification that hardware provides.

Cc: Ben Segall <bsegall@google.com>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tim C. Chen <tim.c.chen@intel.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 * None

Changes since v1:
 * Used bit-fields to fit all the IPC class data in 4 bytes. (PeterZ)
 * Shortened names of the helpers.
 * Renamed helpers with the ipcc_ prefix.
 * Reworded commit message for clarity
---
 include/linux/sched.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 10c6abdc3465..45f28a601b3d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1535,7 +1535,17 @@ struct task_struct {
 	 * A hardware-defined classification of task that reflects but is
 	 * not identical to the number of instructions per cycle.
 	 */
-	unsigned short			ipcc;
+	unsigned int			ipcc : 9;
+	/*
+	 * A candidate classification that arch-specific implementations
+	 * qualify for correctness.
+	 */
+	unsigned int			ipcc_tmp : 9;
+	/*
+	 * Counter to filter out transient candidate classifications
+	 * of a task.
+	 */
+	unsigned int			ipcc_cntr : 14;
 #endif
 
 	/*
-- 
2.25.1

