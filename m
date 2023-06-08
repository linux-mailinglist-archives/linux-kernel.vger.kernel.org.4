Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81620728B24
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbjFHWcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjFHWcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:32:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE441FDF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686263538; x=1717799538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ImFQiTEZpK9q1fTPCz1keqGvgU8HWGODuGAImJ+kNTY=;
  b=U8KEp0ddVaTsDeC2ssLmwZO3ToR5dmq9O4cy3OtaGi/noIpeK66Ydzt/
   ioSAyTx2X259xkgU57DBvBuU4XqQ+lMKiV5Rv9Hh8djLiPfaI3bw3Y9fO
   NfBTus5ozdhdDBlnbEfkdYHrd843DtCL4/SW6Nh7C4/xyCAKY29TIDzmx
   3El4xhtrFsHV5+CIHdhe28ZWfoCmtzVbvWA8uEaadIe9kZhUY3lTcgrKr
   ND7aaCV8zwxAQV0y7UohKaXNqxSCcBlFGSUyYoeZkYkm7LcX3S9BdWeEP
   mY4s2CWgITKzlATJiFb/JV9KcHJ53O4RagjiUQpqi/RibhMp163ATTzLO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="347094765"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="347094765"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 15:32:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="956906451"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="956906451"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2023 15:32:17 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
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
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Subject: [Patch v2 4/6] sched/fair: Consider the idle state of the whole core for load balance
Date:   Thu,  8 Jun 2023 15:32:30 -0700
Message-Id: <40a57d36792622bc21bdcc09d5f6429e9c3e665c.1686263351.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1686263351.git.tim.c.chen@linux.intel.com>
References: <cover.1686263351.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

should_we_balance() traverses the group_balance_mask (AND'ed with lb_env::
cpus) starting from lower numbered CPUs looking for the first idle CPU.

In hybrid x86 systems, the siblings of SMT cores get CPU numbers, before
non-SMT cores:

	[0, 1] [2, 3] [4, 5] 6 7 8 9
         b  i   b  i   b  i  b i i i

In the figure above, CPUs in brackets are siblings of an SMT core. The
rest are non-SMT cores. 'b' indicates a busy CPU, 'i' indicates an
idle CPU.

We should let a CPU on a fully idle core get the first chance to idle
load balance as it has more CPU capacity than a CPU on an idle SMT
CPU with busy sibling.  So for the figure above, if we are running
should_we_balance() to CPU 1, we should return false to let CPU 7 on
idle core to have a chance first to idle load balance.

A partially busy (i.e., of type group_has_spare) local group with SMT 
cores will often have only one SMT sibling busy. If the destination CPU
is a non-SMT core, partially busy, lower-numbered, SMT cores should not
be considered when finding the first idle CPU. 

However, in should_we_balance(), when we encounter idle SMT first in partially
busy core, we prematurely break the search for the first idle CPU.

Higher-numbered, non-SMT cores is not given the chance to have
idle balance done on their behalf. Those CPUs will only be considered
for idle balancing by chance via CPU_NEWLY_IDLE.

Instead, consider the idle state of the whole SMT core.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Co-developed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0b0904263d51..33246dce10db 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10749,7 +10749,7 @@ static int active_load_balance_cpu_stop(void *data);
 static int should_we_balance(struct lb_env *env)
 {
 	struct sched_group *sg = env->sd->groups;
-	int cpu;
+	int cpu, idle_smt = -1;
 
 	/*
 	 * Ensure the balancing environment is consistent; can happen
@@ -10776,10 +10776,24 @@ static int should_we_balance(struct lb_env *env)
 		if (!idle_cpu(cpu))
 			continue;
 
+		/*
+		 * Don't balance to idle SMT in busy core right away when
+		 * balancing cores, but remember the first idle SMT CPU for
+		 * later consideration.  Find CPU on an idle core first.
+		 */
+		if (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && !is_core_idle(cpu)) {
+			if (idle_smt == -1)
+				idle_smt = cpu;
+			continue;
+		}
+
 		/* Are we the first idle CPU? */
 		return cpu == env->dst_cpu;
 	}
 
+	if (idle_smt == env->dst_cpu)
+		return true;
+
 	/* Are we the first CPU of this group ? */
 	return group_balance_cpu(sg) == env->dst_cpu;
 }
-- 
2.32.0

