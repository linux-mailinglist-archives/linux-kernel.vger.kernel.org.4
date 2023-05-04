Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9396F6FA3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjEDQL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjEDQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:11:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8173059FD
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683216706; x=1714752706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ANLVK8aGjwhHbRgoOYlF8yr5cQW6kQOxy/7cKUTzhtI=;
  b=AKhtHDaTqnI3q9FkNny0/iIZkoNcWskQW+D00P/3v6CtmNHJol8WJ84R
   QZsMYXfKWyzD6lBodkYwLnFIQpwj8k34hDi568RcQdftIvnt1zCUCje54
   AlQI22luslkyWQeJR955Or/QPAVtYdHpnEfYBNnsr/QZcEA7RH9BhgTJ/
   FGZ/VfvyobJVefTLZttAS4Fjh4NiHwAG4Qvz7+fyJ/EDR8f360YwA489X
   gMIEIPIiTP6wTQGELywuPW9f1f6rBSACOciEpVHYJ/9sBuO5fP5sQFwLm
   kdjSExdVzqU1mIGRhEqz472zSxyzZKq9tLJW6VbZ0UoMWjJYdVKnErwGS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="377049113"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="377049113"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 09:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766633546"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766633546"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga004.fm.intel.com with ESMTP; 04 May 2023 09:09:35 -0700
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
        Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH 5/6] sched/fair: Consider the idle state of the whole core for load balance
Date:   Thu,  4 May 2023 09:09:55 -0700
Message-Id: <849d3fee51d218de71ecc9d557667ff6b137ac2d.1683156492.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1683156492.git.tim.c.chen@linux.intel.com>
References: <cover.1683156492.git.tim.c.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

should_we_balance() traverses the group_balance_mask (AND'ed with lb_env::
cpus) starting from lower numbered CPUs looking for the first idle CPU.

In hybrid x86 systems, the siblings of SMT cores get CPU numbers, before
non-SMT cores:

	[0, 1] [2, 3] [4, 5] 5 6 7 8
         b  i   b  i   b  i  b i i i

In the figure above, CPUs in brackets are siblings of an SMT core. The
rest are non-SMT cores. 'b' indicates a busy CPU, 'i' indicates an
idle CPU.

We should let a CPU on a fully idle core get the first chance to idle
load balance as it has more CPU capacity than a CPU on an idle SMT
CPU with busy sibling.  So for the figure above, if we are running
should_we_balance() to CPU 1, we should return false to let CPU 6 on
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
 kernel/sched/fair.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 58ef7d529731..c77fadba063d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10683,7 +10683,7 @@ static int active_load_balance_cpu_stop(void *data);
 static int should_we_balance(struct lb_env *env)
 {
 	struct sched_group *sg = env->sd->groups;
-	int cpu;
+	int cpu, idle_smt = -1;
 
 	/*
 	 * Ensure the balancing environment is consistent; can happen
@@ -10709,11 +10709,26 @@ static int should_we_balance(struct lb_env *env)
 	for_each_cpu_and(cpu, group_balance_mask(sg), env->cpus) {
 		if (!idle_cpu(cpu))
 			continue;
+		else {
+			/*
+			 * Don't balance to idle SMT in busy core right away when
+			 * balancing cores, but remember the first idle SMT CPU for
+			 * later consideration.  Find CPU on an idle core first.
+			 */
+			if (!(env->sd->flags & SD_SHARE_CPUCAPACITY) && !is_core_idle(cpu)) {
+				if (idle_smt == -1)
+					idle_smt = cpu;
+				continue;
+			}
+		}
 
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

