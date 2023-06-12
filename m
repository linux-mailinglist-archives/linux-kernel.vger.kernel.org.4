Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B92672BA5A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjFLIYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjFLIYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:24:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6515DE67
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 01:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686558229; x=1718094229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dZ3qa1vTh1///kMKUTog8YoVjT3GWLH4LbO4Sq0wlqk=;
  b=N0/1gttRtXtYQdezO0OLcbvm6JGhQbHx+M6q4wngJr6orO2az8k+SPfR
   ysMOODZFp2d3rLZXFVTIU18Km1m+vAIEFCpP6oUgeYkFP/Y0prZsFOKvq
   GKJAdI9ipqhKBVsBCCAAJD1QpfDeWwDR5ELnKIQCzL4INM9w0+Ug7l4GJ
   rcvsk5B/faYa4wiYHeCH8Q20r40P+FCYIPU4XsNzZr6XAq6ywWmAZSmyl
   4kaGgh/auiIJb7F0ebrK7Xu9t7CoZguSlyTwgEijEWgFMrHBBAeQhWTsK
   hj9si/WLPqRxVwWuAuxSNcZZw5E2bRH3zEbxKD4rdJ0kZyQi23I+CBB97
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="421572595"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="421572595"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 01:23:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="1041232251"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="1041232251"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jun 2023 01:23:44 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [RFC PATCH 4/4] sched/fair: Throttle the busiest group scanning in idle load balance
Date:   Tue, 13 Jun 2023 00:19:13 +0800
Message-Id: <e873d01af6340976ba8d344caf824fd122d0a93d.1686554037.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686554037.git.yu.c.chen@intel.com>
References: <cover.1686554037.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scanning the whole sched domain to find the busiest group is time costly
during newidle_balance(). Limit the scan depth of newidle_balance()
to only scan for a limited number of sched groups to find a relatively
busy group, and pull from it. The scanning depth is suggested by
the previous periodic load balance based on its overall utilization.

Tested on top of sched/core v6.4-rc1,
Sapphire Rapids with 2 x 56C/112T = 224 CPUs,
cpufreq governor is set to performance, and C6 is disabled.

Overall some improvements were noticed when the system is underloaded
from tbench/netperf, and no noticeable difference from hackbench/schbench.
And the percentage of newidle_balance() has dropped accordingly.

[netperf]

Launches $nr instances of:
netperf -4 -H 127.0.0.1 -t $work_mode -c -C -l 100 &

nr: 56, 112, 168, 224, 280, 336, 392, 448
work_mode: TCP_RR UDP_RR

throughput
=======
case                    load            baseline(std%)  compare%( std%)
TCP_RR                  56-threads       1.00 (  1.98)  +18.45 ( 10.84)
TCP_RR                  112-threads      1.00 (  3.79)   +0.92 (  4.72)
TCP_RR                  168-threads      1.00 (  5.40)   -0.09 (  5.94)
TCP_RR                  224-threads      1.00 ( 42.40)   -1.37 ( 41.42)
TCP_RR                  280-threads      1.00 ( 15.95)   -0.30 ( 14.82)
TCP_RR                  336-threads      1.00 ( 27.84)   -0.08 ( 28.91)
TCP_RR                  392-threads      1.00 ( 41.85)   -0.56 ( 39.18)
TCP_RR                  448-threads      1.00 ( 45.95)   +1.62 ( 52.54)
UDP_RR                  56-threads       1.00 (  8.41)   +4.86 (  5.54)
UDP_RR                  112-threads      1.00 (  9.11)   -0.68 (  9.92)
UDP_RR                  168-threads      1.00 ( 10.48)   -0.15 ( 10.07)
UDP_RR                  224-threads      1.00 ( 40.98)   -3.80 ( 40.01)
UDP_RR                  280-threads      1.00 ( 23.50)   -0.53 ( 23.42)
UDP_RR                  336-threads      1.00 ( 35.87)   +0.38 ( 33.43)
UDP_RR                  392-threads      1.00 ( 49.47)   -0.27 ( 44.40)
UDP_RR                  448-threads      1.00 ( 53.09)   +1.81 ( 59.98)

[tbench]
tbench -t 100 $job 127.0.0.1
job: 56, 112, 168, 224, 280, 336, 392, 448

throughput
=========
loopback                56-threads       1.00 (  1.12)   +1.41 (  0.43)
loopback                112-threads      1.00 (  0.43)   +0.30 (  0.73)
loopback                168-threads      1.00 (  6.88)   -5.73 (  7.74)
loopback                224-threads      1.00 ( 12.99)  +31.32 (  0.22)
loopback                280-threads      1.00 (  0.38)   -0.94 (  0.99)
loopback                336-threads      1.00 (  0.13)   +0.06 (  0.18)
loopback                392-threads      1.00 (  0.06)   -0.09 (  0.16)
loopback                448-threads      1.00 (  0.10)   -0.13 (  0.18)

[hackbench]

hackbench -g $job --$work_type --pipe -l 200000 -s 100 -f 28
and
hackbench -g $job --$work_type -l 200000 -s 100 -f 28

job: 1, 2, 4, 8
work_type: process threads

throughput
=========
case                    load            baseline(std%)  compare%( std%)
process-pipe            1-groups         1.00 (  6.09)   +2.61 (  9.27)
process-pipe            2-groups         1.00 (  7.15)   +6.22 (  5.59)
process-pipe            4-groups         1.00 (  3.40)   +2.01 (  5.45)
process-pipe            8-groups         1.00 (  0.44)   -1.57 (  0.70)
process-sockets         1-groups         1.00 (  0.69)   +0.86 (  1.84)
process-sockets         2-groups         1.00 (  5.04)   -6.31 (  0.60)
process-sockets         4-groups         1.00 (  0.22)   +0.01 (  0.75)
process-sockets         8-groups         1.00 (  0.49)   +0.46 (  0.49)
threads-pipe            1-groups         1.00 (  1.96)   -4.86 (  6.90)
threads-pipe            2-groups         1.00 (  3.02)   +0.21 (  2.72)
threads-pipe            4-groups         1.00 (  4.83)   -1.08 (  6.41)
threads-pipe            8-groups         1.00 (  3.86)   +4.19 (  3.82)
threads-sockets         1-groups         1.00 (  2.20)   +1.65 (  1.85)
threads-sockets         2-groups         1.00 (  3.09)   -0.36 (  2.14)
threads-sockets         4-groups         1.00 (  0.99)   -2.54 (  1.86)
threads-sockets         8-groups         1.00 (  0.27)   -0.01 (  0.79)

[schbench]

schbench -m $job -t 56 -r 30
job: 1, 2, 4, 8
3 iterations

99.0th latency
========
case            	load    	baseline(std%)	compare%( std%)
normal                  1-mthreads       1.00 (  1.10)   +0.88 (  0.84)
normal                  2-mthreads       1.00 (  0.73)   +0.00 (  0.73)
normal                  4-mthreads       1.00 (  1.46)   -0.60 (  2.74)
normal                  8-mthreads       1.00 (  4.09)   +1.08 (  4.60)

Suggested-by: Tim Chen <tim.c.chen@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f999e838114e..272e6c224b96 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10168,7 +10168,12 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
 	unsigned long sum_util = 0;
-	int sg_status = 0;
+	int sg_status = 0, nr_scan_ilb;
+	bool ilb_util_enabled = sched_feat(ILB_UTIL) && env->idle == CPU_NEWLY_IDLE &&
+	    sd_share && READ_ONCE(sd_share->ilb_total_capacity);
+
+	if (ilb_util_enabled)
+		nr_scan_ilb = sd_share->ilb_nr_scan;
 
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
@@ -10186,6 +10191,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 		update_sg_lb_stats(env, sds, sg, sgs, &sg_status);
 
+		if (ilb_util_enabled && --nr_scan_ilb <= 0) {
+			/* borrow the statistic of previous periodic load balance */
+			sds->total_load = READ_ONCE(sd_share->ilb_total_load);
+			sds->total_capacity = READ_ONCE(sd_share->ilb_total_capacity);
+
+			break;
+		}
+
 		if (local_group)
 			goto next_group;
 
-- 
2.25.1

