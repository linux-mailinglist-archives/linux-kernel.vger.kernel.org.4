Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6B76F6F9F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 18:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjEDQLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 12:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDQLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 12:11:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FB9468D
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683216699; x=1714752699;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VSiKjnZ61F0v6DE7GJgg9qUd+JwsVClA6cgxpoVYAds=;
  b=CNoNvPUcXBt8YlC1pR8nQQSR1QfTze0jO18SxIq5eKg6cGD3aun0b6Zr
   6yJLJ58ukkJVyi+iTwgcpdBE47wP1sM5sdPFqdq8T5YtorJ8lPS4LVn8V
   DrVchJyomIyGpe24S0OP8vPSNY00w+YjKd1BDkLlRFlWVKrceVr56SrXr
   pmRx/qxUAnk4QJCByxG8eDQ1WYFETQV0/Qx5LOUI0MG/KOKIDahYu6jw0
   dVCUFmq2zsk2xI6iP3soP5aeru3HxmNvtqxWYri0IPn/1bgBYO0kIcvKI
   RyEQOE4+CgWRE/XODwc6k+9KhQPTo9TjI7Dgs8gMpHx8n5jSdX6At2JiG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="377049000"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="377049000"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 09:09:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="766633500"
X-IronPort-AV: E=Sophos;i="5.99,249,1677571200"; 
   d="scan'208";a="766633500"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by fmsmga004.fm.intel.com with ESMTP; 04 May 2023 09:09:28 -0700
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
        Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH 0/6] Enable Cluster Scheduling for x86 Hybrid CPUs
Date:   Thu,  4 May 2023 09:09:50 -0700
Message-Id: <cover.1683156492.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
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

Cluster scheduling domain is not enabled on x86 hybrid CPUs as the logic
is missing to do proper load balancing between a cluster
with SMT CPUs in single core and a cluster with multiple Atom CPUs.

When cluster scheduling was first introduced to x86, it was noticed
that with cluster scheduling on hybrid CPU, single threaded task often
ended up on Atom core (or E-core) instead on idle Big core (or P-core),
resulting in lower performance.  Hence cluster scheduling was disabled 
on x86 hybrid CPU.  (See: https://www.phoronix.com/review/linux-516-regress)

Ricardo recently introduced a patch series that greatly improved
the load balancing logic between P-cores and E-cores on x86 hybrid
CPUs.
https://lore.kernel.org/lkml/20230429153219.GC1495785@hirez.programming.kicks-ass.net/T/#m16ebc8de64dbf4c54adebab701b42b47805105f4

However, that patch series is not enough to allow the enabling of cluster
scheduling on hybrid x86 CPUs.  This patch series provides some additional
fixes needed for load balancing between cluster sched group consisting
of SMT CPUs of Big cores and cluster sched group consisting of Atom CPUs.
With these patches applied on top of Ricardo's patch series, load is
properly balanced between the P-core and E-core clusters.  Idle CPUs
are used in the proper order:

1) SMT CPU on an idle P-core, 
2) idle E-core,
3) unused SMT CPU with a busy sibling.

On x86, CPUs in a cluster share L2 cache. Load is now balanced
between the clusters with cluster enabled, for potentially less L2 cache
contention.

I did some experiments on an Alder Lake with 6 P-cores and 8 E-cores,
organized in two clusters of 4 E-core each.

I tested some single threaded benchmarks in Phoronix suite that previously
have shown regressions when cluster scheduling was first enabled. Cluster
scheduling using this patch series performs as well as vanilla kernel.

Single Threaded	6.3-rc5 		with cluster 	Improvement
Benchmark				scheduling	in Performance
		(run-run deviation) 	
-------------------------------------------------------------------------------------------
tjbench		(+/- 0.08%)		(+/- 0.23%)	-0.23%
PhPbench	(+/- 0.31%)		(+/- 0.89%)	-0.39%
flac		(+/- 0.58%)		(+/- 0.22%)	+0.17%
pybench		(+/- 3.16%)		(+/- 0.27%)	+2.55%

For multi-threaded benchmarks, I tried kernel build and tensor flow lite.
Cluster scheduling did best for the 10 thread case where 6 threads run on
the P-cores, 2 threads on one Atom cluster and 2 threads on the other Atom
cluster. Whereas the vanilla kernel will have 6 threads on the P-cores,
4 threads on one Atom cluster.  Though the differences are small and
fall within run variations.

Multi Threaded	6.3-rc5 		with cluster 	Improvement
Benchmark				scheduling	in Performance
(-#threads)	(run-run deviation) 	
-------------------------------------------------------------------------------------------
Kbuild-8	(+/- 2.90%)		(+/- 1.16%)	-0.76%
Kbuild-10	(+/- 3.08%)		(+/- 3.09%)	+0.64%
Kbuild-12	(+/- 3.28%)		(+/- 3.55%)	+0.91%
Tensor Lite-8	(+/- 4.84%)		(+/- 4.61%)	-0.23%
Tensor Lite-10	(+/- 0.87%)		(+/- 1.45%)	+0.47%
Tensor Lite-12	(+/- 1.37%)		(+/- 1.04%)	-0.12%

Thanks for reviewing these patches.

Tim Chen

Ricardo Neri (1):
  sched/fair: Consider the idle state of the whole core for load balance

Tim C Chen (5):
  sched/topology: Propagate SMT flags when removing degenerate domain
  sched/fair: Check whether active load balance is needed in busiest
    group
  sched/fair: Fix busiest group selection for asym groups
  sched/fair: Skip prefer sibling move between SMT group and non-SMT
    group
  sched/x86: Add cluster topology to hybrid CPU

 arch/x86/kernel/smpboot.c |  3 ++
 kernel/sched/fair.c       | 78 ++++++++++++++++++++++++++++++++++++++-
 kernel/sched/topology.c   |  7 +++-
 3 files changed, 86 insertions(+), 2 deletions(-)

-- 
2.32.0

