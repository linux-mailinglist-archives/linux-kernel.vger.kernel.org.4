Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC6674B9B9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjGGW44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjGGW4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:56:54 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB1F1997
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 15:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688770613; x=1720306613;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HVXRmj/J734LlcosDZLbFzKEkqCUDWQNtSlrKyrH6kU=;
  b=Xgp4Vyl6YBofjt40ZVb/CYm5b7MwqTLPj4V7qkUr7VctVNR9MAdONWwy
   DiKj13rZ7ncD7cjmtRuOoqALIQvwShPg/DOgfC2qeB5Ol7a+yfF1hDppW
   vQ93do6NZA3ombu/tmuLdM4MHxS5ZC9jm3Jix88ms6BW1MqQ5dY4hwvcu
   tkAKL1q5sL3YBFkXT4Rgec2AT0gpMNw3awIUSo6cz8gKZkU67fO3ijGMq
   jnrY3OFxhHiLp1RR/2hqODelTqiPkQmCLJohcajqcg/MICYtsN/5+fVYU
   93e5e5YC7MMOphHStJDg6Gt3+RL/fCrG8fQsAgP9Wu84F+6TXKtlz/3NN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="427683425"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="427683425"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 15:56:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="714176648"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="714176648"
Received: from b04f130c83f2.jf.intel.com ([10.165.154.98])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2023 15:56:52 -0700
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
Subject: [Patch v3 0/6] Enable Cluster Scheduling for x86 Hybrid CPUs
Date:   Fri,  7 Jul 2023 15:56:59 -0700
Message-Id: <cover.1688770494.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third version of patches to fix issues to allow cluster
scheduling on x86 hybrid CPUs.  They address concerns raised by
Peter on the second version.  Please refer to the cover letter in the
first version for the motivation behind this patch series.

Changes from v2:
1. Peter pointed out that biasing asym packing in sibling imbalance
computation is unnecessary.  We will negate extra turbo headroom
advantage by concentrating tasks in the preferred group.  In v3, we
simplify computing sibling imbalance only in proportion to the number
of cores, and remove asym packing bias. We do not lose any performance
and do a bit better than v2.

2. Peter asked the question of whether it is better to round the
sibling_imbalance() computation or floor the sibling_imbalanace()
as in the v2 implementation.  I did find the rounding to be
better in threaded tensor computation, hence v3 adopt rounding
in sibling_imbalance().  The performance of both versions are
listed in the performance data below.

3. Fix patch 1 to take SMT thread number more than 2 into consideration.  

4. Various style clean ups suggested by Peter.

Past Versions:
[v1] https://lore.kernel.org/lkml/CAKfTPtD1W6vJQBsNKEt_4tn2EeAs=73CeH4LoCwENrh2JUDwnQ@mail.gmail.com/T/
[v2] https://lore.kernel.org/all/cover.1686263351.git.tim.c.chen@linux.intel.com/ 

v3 Performance numbers:

                                     This version                            
Single Threaded	6.3-rc5              with cluster         Improvement     Alternative        Improvement    
Benchmark 	Baseline             scheduling	          in Performance  implementation     in Performance 
                                     (round imbalance)                    (floor imbalance)	          
               (run-run deviation)   (run-run deviation)                  (run-run deviation)               
------------------------------------------------------------------------------------------------------------
tjbench		(+/- 0.08%)          (+/- 0.12%)           0.03%          (+/- 0.11%)         0.00%	  
PhPbench	(+/- 0.31%)          (+/- 0.50%)          +0.19%          (+/- 0.87%)        +0.21%         
flac		(+/- 0.58%)          (+/- 0.41%)          +0.48%          (+/- 0.41%)        +1.02%         
pybench		(+/- 3.16%)          (+/- 2.87%)          +2.04%          (+/- 2.22%)        +4.25%         
                                                                                                            

                                     This version                         
                                     with cluster         Improvement     Alternative        Improvement				  
Multi Threaded	6.3-rc5              scheduling           in Performance  implementation     in Performance 
Benchmark       Baseline             (round imbalance)                    (floor imbalance)
(-#threads)     (run-run deviation)  (run-run deviation)                  (run-run deviation)               
------------------------------------------------------------------------------------------------------------
Kbuild-8	(+/- 2.90%)          (+/- 0.23%)          -1.10%          (+/- 0.40%)        -1.01%         
Kbuild-10	(+/- 3.08%)          (+/- 0.51%)          -1.93%          (+/- 0.49%)        -1.57%
Kbuild-12	(+/- 3.28%)          (+/- 0.39%)          -1.10%          (+/- 0.23%)        -0.98%
Tensor Lite-8	(+/- 4.84%)          (+/- 0.86%)          -1.32%          (+/- 0.58%)        -0.78%
Tensor Lite-10	(+/- 0.87%)          (+/- 0.30%)          +0.68%          (+/- 1.24%)        -0.13%
Tensor Lite-12	(+/- 1.37%)          (+/- 0.82%)          +4.16%          (+/- 1.65%)        +1.19%         

Tim


Peter Zijlstra (Intel) (1):
  sched/debug: Dump domains' sched group flags

Ricardo Neri (1):
  sched/fair: Consider the idle state of the whole core for load balance

Tim C Chen (4):
  sched/fair: Determine active load balance for SMT sched groups
  sched/topology: Record number of cores in sched group
  sched/fair: Implement prefer sibling imbalance calculation between
    asymmetric groups
  sched/x86: Add cluster topology to hybrid CPU

 arch/x86/kernel/smpboot.c |   3 +
 kernel/sched/debug.c      |   1 +
 kernel/sched/fair.c       | 137 +++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h      |   1 +
 kernel/sched/topology.c   |  10 ++-
 5 files changed, 143 insertions(+), 9 deletions(-)

-- 
2.32.0

