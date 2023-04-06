Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737EC6DA285
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbjDFUVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238930AbjDFUVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:21:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ADB7692
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680812461; x=1712348461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=q9lpW5CCgNjM7DsoYSjF+xIt0wsd4M8NGDVcidOL3Zk=;
  b=fG3dgqz0XrIPgnB8hjiqX40HhKIUSiAPVwljN64n4WDm7mO7PSakvvmZ
   Lt/nG1JtzU9ZoBxolgS4OSw30gjmw6xhaen9JLOY0VMz0wTHZwiMUaxwI
   HCKqpvwC6yzl3RnWqXLmHr0AGN8KjSKK/CsbXAS/l4BJMlAy02MYnE0DF
   K4VooKYfQc6pIRiINDZAb/+6TvzctMhIQzfFInDAlITl0HMY8bhFTHAvw
   NGBv5OqkleKHyHCsVzqumVEcdQ/3BQONvKeducAz0LTixW+9S9PNa86uW
   mHYTJaCxBAq8AYh7I3Vx+ZEwk11xlzAlAIIbxrKx9w6Qr2FB3rJnYmHQK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="407957743"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="407957743"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 13:20:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="861529878"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="861529878"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2023 13:20:59 -0700
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
Subject: [PATCH v4 05/12] sched/fair: Keep a fully_busy SMT sched group as busiest
Date:   Thu,  6 Apr 2023 13:31:41 -0700
Message-Id: <20230406203148.19182-6-ricardo.neri-calderon@linux.intel.com>
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

When comparing two fully_busy scheduling groups, keep the current busiest
group if it represents an SMT core. Tasks in such scheduling group share
CPU resources and need more help than tasks in a non-SMT fully_busy group.

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
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 * None

Changes since v2:
 * Introduced this patch.

Changes since v1:
 * N/A
---
 kernel/sched/fair.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b151e93ec316..ea23a5163bfa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9566,10 +9566,22 @@ static bool update_sd_pick_busiest(struct lb_env *env,
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

