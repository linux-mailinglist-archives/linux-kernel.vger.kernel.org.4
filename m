Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014D168CE5E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjBGEvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjBGEut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:50:49 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E344ECC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675745448; x=1707281448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ulLn873Z56iFQvxm4YOPwOFsRDQ7WudOQQX77xthURc=;
  b=SzkE43STwpMyQxRVXh1tqpIqgXttsqg5ePJ5eHfmPIEUGXPrrKS4B6fJ
   7aQALzxucFatxuMoEd9qzkLhSOKpFVn83NMhDa4C7VrydQoHLMG3Pma4d
   kik/WQkjKVXSYYmBYdk9TtfuRnXd5w8BRNlSlcml6KQItel0s8YZAbB/J
   dJbt8dgzFh/i9LrG+g0LlT09oxmCQcTyHOTrXkdJUkSWtCUfRjF1qiuKs
   vdyKT3yDTCQBqF+rCeoqLJiJKT9AVjJoqqQQWe+bPwfOuedn/ftc9FQ8v
   LBe3R4fkrT0nIacAadNbrimb5ZYe6hdtGs+G6hJT+REbElVRsNFsdx1Hg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415624014"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415624014"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 20:50:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668653792"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668653792"
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
Subject: [PATCH v3 05/10] sched/fair: Keep a fully_busy SMT sched group as busiest
Date:   Mon,  6 Feb 2023 20:58:33 -0800
Message-Id: <20230207045838.11243-6-ricardo.neri-calderon@linux.intel.com>
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

When comparing two fully_busy scheduling groups, keep the current busiest
group if it represents an SMT core. Tasks in such scheduling group share
CPU resources and need more help than tasks in a non-SMT fully_busy group.

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
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 kernel/sched/fair.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c9d0ddfd11f2..df7bcbf634a8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9514,10 +9514,22 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 		 * contention when accessing shared HW resources.
 		 *
 		 * XXX for now avg_load is not computed and always 0 so we
-		 * select the 1st one.
+		 * select the 1st one, except if @sg is composed of SMT
+		 * siblings.
 		 */
-		if (sgs->avg_load <= busiest->avg_load)
+
+		if (sgs->avg_load < busiest->avg_load)
 			return false;
+
+		if (sgs->avg_load == busiest->avg_load) {
+			/*
+			 * SMT sched groups need more help than non-SMT groups.
+			 * If @sg happens to also be SMT, either choice is good.
+			 */
+			if (sds->busiest->flags & SD_SHARE_CPUCAPACITY)
+				return false;
+		}
+
 		break;
 
 	case group_has_spare:
-- 
2.25.1

