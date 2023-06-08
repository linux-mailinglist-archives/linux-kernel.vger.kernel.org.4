Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5A7728B20
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237152AbjFHWcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjFHWcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:32:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3592F210E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686263532; x=1717799532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lXmNQEqbDOUkIFKVHyDiQfRIZIeCKzJeGt81kUNaIFA=;
  b=XYeHIu0uqwYuYjx4pWoNvdonfD1SH+ZNXe1hk/oXu3z0CKfMcY9uBa5a
   3slBuobquc/laVWJSRChdywQglYGW5M385epmUG5jHmnQEZjsue9sdYtj
   E+d/Q4Fj27JFc2jYf3znvgwS+WS1dz9gByBSf7cEqi3UPjvFgzjEuJHxS
   xV+qA3dY+Ufb32r7Goe0rTmEUlLGBELfIElaO0uAu8/sUN/gTz+PcsKzd
   KqfHJPHfJyBnTaqrYEWczkEM9LLyxNaxNprdqHHS47+r44UeOmF7OEHSn
   Z936UAdFq3+zt+P3QXHFd/payfcFkguEXOlfS1JYe4dmd0DumTYjFlzC9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="347094693"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="347094693"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 15:32:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="956906433"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="956906433"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2023 15:32:10 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
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
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Subject: [Patch v2 0/6] Enable Cluster Scheduling for x86 Hybrid CPUs
Date:   Thu,  8 Jun 2023 15:32:26 -0700
Message-Id: <cover.1686263351.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
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

This is the second version of patches to fix issues to allow cluster
scheduling on x86 hybrid CPUs.  It addresses concerns by
reviewers in the first version:
https://lore.kernel.org/lkml/CAKfTPtD1W6vJQBsNKEt_4tn2EeAs=73CeH4LoCwENrh2JUDwnQ@mail.gmail.com/T/

The review comments were greatly appreciated.

Changes from v1:
1. Peter pointed out that the number of CPUs in a cluster could
also be modified by bringing CPU on or offline. Balance between the
sibling clusters should not just take into consideration of whether a
cluster has SMT CPUs or pure core CPUs.  In this version, I take the
approach to balance tasks between the clusters such that the
running_tasks/num_cores between the clusters are similar.  This would
accommodate balance between SMT clusters and non-SMT clusters,
or between the same clusters with different number of cores.

2. Vincent pointed out that special case logic in the general path
for detection of fully busy SMT can be simplified.  Fully busy SMT could
be detected during statistics gathering and will make the code cleaner
by detecting such cases there.  This version of the patch series makes
this change.

3. Suggestions by Chen Yu and Hillf Danton to improve commit logs. 

4. Patch by Peter to dump domain sched groups' flags and
include suggestions by Peter to simplify code.

The performance of this version is similar to the previous version for
other benchmarks, though kbuild is about a couple percents worse.
Experiments were done on Alder Lake with 6 P-cores and 8 E-cores,
organized in two clusters of 4 E-core each.

Single Threaded	6.3-rc5 		with cluster 	   Improvement
Benchmark				scheduling	   in Performance
		(run-run deviation) 	(run-run deviation)
-------------------------------------------------------------------------------------------
tjbench		(+/- 0.08%)		(+/- 0.51%)	   -0.34%
PhPbench	(+/- 0.31%)		(+/- 2.48%)	   -0.99%
flac		(+/- 0.58%)		(+/- 0.86%)	   +0.61%
pybench		(+/- 3.16%)		(+/- 3.36%)	   +1.36%


Multi Threaded	6.3-rc5 		with cluster 	   Improvement
Benchmark				scheduling	   in Performance
(-#threads)	(run-run deviation) 	(run-run deviation)
-------------------------------------------------------------------------------------------
Kbuild-8	(+/- 2.90%)		(+/- 0.24%)	   -1.63%
Kbuild-10	(+/- 3.08%)		(+/- 0.47%)	   -2.06%
Kbuild-12	(+/- 3.28%)		(+/- 0.28%)	   -1.38%
Tensor Lite-8	(+/- 4.84%)		(+/- 3.21%)	   -0.57%
Tensor Lite-10	(+/- 0.87%)		(+/- 1.21%)	   -1.00%
Tensor Lite-12	(+/- 1.37%)		(+/- 0.43%)	   -0.05%

Tim Chen

Ricardo Neri (1):
  sched/fair: Consider the idle state of the whole core for load balance

Tim C Chen (5):
  sched/fair: Determine active load balance for SMT sched groups
  sched/topology: Record number of cores in sched group
  sched/fair: Implement prefer sibling imbalance calculation between
    asymmetric groups
  sched/x86: Add cluster topology to hybrid CPU
  sched/debug: Dump domains' sched group flags

 arch/x86/kernel/smpboot.c |   3 +
 kernel/sched/debug.c      |   1 +
 kernel/sched/fair.c       | 151 ++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h      |   6 ++
 kernel/sched/topology.c   |  10 ++-
 5 files changed, 165 insertions(+), 6 deletions(-)

-- 
2.32.0

