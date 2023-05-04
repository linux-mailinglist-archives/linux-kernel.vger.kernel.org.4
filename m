Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167026F6FA2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjEDQLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjEDQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:11:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129655BA0
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683216703; x=1714752703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EFWPb4ErsWepqS9IbJJhFL7X3JBr0JI87KPptB5lfEU=;
  b=huA/9Z3tzI/RWDegC/CErzjjCExCt/7xHb9Pz7+53dzoVHgv+5MtRXKR
   lpkZjB9T7vgQTqI+CD5kS7NhuP1w1XFB0hR8NftHa3nYhx/75wZqqEr3h
   fIVckMtTiNEZ0HuA2u+NAY+K68Us0bHfuEiyjom2bEwH4qcmMyqcX1GaO
   WPi0BKIO5kUcJ5kHWANFThrWYa9H+Jl1DE1fx8et19S0oFTf0sq+3PO6w
   Bh7W/mPZMKZV7TwNPukIpHLHpkOLKshMK2I6+qF8JTuD3SzNT9qPiZXb2
   GFtqC9hXlRyz7AX93f7Nl8YRFlE8d/FZ/1ml5JDY/a3UoHSCDrxL8WyfT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="377049065"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="377049065"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 09:09:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766633528"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766633528"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga004.fm.intel.com with ESMTP; 04 May 2023 09:09:32 -0700
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
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 3/6] sched/fair: Fix busiest group selection for asym groups
Date:   Thu,  4 May 2023 09:09:53 -0700
Message-Id: <2e2e6844fb3ed28594d86c5e45295df7c4335c08.1683156492.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1683156492.git.tim.c.chen@linux.intel.com>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim C Chen <tim.c.chen@linux.intel.com>

For two groups that have spare capacity and are partially busy, the
busier group should be the group with pure CPUs rather than the group
with SMT CPUs.  We do not want to make the SMT group the busiest one to
pull task off the SMT and makes the whole core empty.

Otherwise suppose in the search for busiest group,
we first encounter an SMT group with 1 task and set it as the busiest.
The local group is an atom cluster with 1 task and we then encounter an atom
cluster group with 3 tasks, we will not pick this atom cluster group over the
SMT group, even though we should.  As a result, we do not load balance
the busier Atom cluster (with 3 tasks) towards the local Atom cluster
(with 1 task).  And it doesn't make sense to pick the 1 task SMT group
as the busier group as we also should not pull task off the SMT towards
the 1 task atom cluster and make the SMT core completely empty.

Fix this case.

Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bde962aa160a..8a325db34b02 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9548,6 +9548,18 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 		break;
 
 	case group_has_spare:
+		/*
+		 * Do not pick sg with SMT CPUs over sg with pure CPUs,
+		 * as we do not want to pull task off half empty SMT core
+		 * and make the core idle.
+		 */
+		if (asymmetric_groups(sds->busiest, sg)) {
+			if (sds->busiest->flags & SD_SHARE_CPUCAPACITY)
+				return true;
+			else
+				return false;
+		}
+
 		/*
 		 * Select not overloaded group with lowest number of idle cpus
 		 * and highest number of running tasks. We could also compare
-- 
2.32.0

