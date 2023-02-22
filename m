Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8E569F61D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbjBVOII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:08:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjBVOIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:08:06 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0018A1E5E3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677074885; x=1708610885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/WChs04TOpiPyMixWyBFXbVf2n7RMApTH/W5yJtaeXE=;
  b=Km/TvdBc2YK8JcWkPOUJGeMulC0vLfPeibo/f00wjty5DCXr20l8mSoc
   n9wndx1LYGAJ8H5NVe9Uy8Yl5juI7KJLbDa8B/dD4imgDMz/qBSqYA2JQ
   gn1zuspG0/z5ALoQvWx8uYT2Jpohv7Z2EXp621lBqu2GAa0r6I+RViHN5
   IUB+amqwJfmKq4Wjw9i4DJKAKqXgidTA1IhUiDCtRv1S2Hf+NKpiLqoDh
   SjLJlH7+uUm7yjXgMQ0DK4rSDnEO8/YcLgSYxdA6p2FmiTeQhybeMaZAT
   DPN97mZ0ookqLujwsAZoEYoG/NvToX58nRLt4Ax1V6EE57R9kKMH8MECj
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="334294782"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="334294782"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 06:07:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="814945910"
X-IronPort-AV: E=Sophos;i="5.97,318,1669104000"; 
   d="scan'208";a="814945910"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2023 06:07:49 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, Hillf Danton <hdanton@sina.com>,
        kernel test robot <yujie.liu@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v6 0/2] sched/fair: Wake short task on current CPU
Date:   Wed, 22 Feb 2023 22:09:10 +0800
Message-Id: <cover.1677069490.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main purpose is to avoid too many cross CPU wake up when it is
unnecessary. The frequent cross CPU wake up brings significant damage
to some workloads, especially on high core count systems.

Inhibits the cross CPU wake-up by placing the wakee on waking CPU,
if both the waker and wakee are short-duration tasks. The short
duration task could become a trouble maker on high-load system,
because it could bring frequent context switch. This strategy
only takes effect when the system is busy. Because it is unreasonable
to inhibit the idle CPU scan when there are still idle CPUs.

First, introduce the definition of a short-duration task. Then
leverages the first patch to choose a local CPU for wakee.

Overall there is performance improvement on some overloaded case.
Such as will-it-scale, netperf. And no noticeable impact on
schbench, hackbench, tbench and a OLTP workload with a commercial
RDBMS, tested on a Intel Xeon 2 x 56C machine.

Per the test on Zen3 from Prateek, most benchmarks result saw small
wins or are comparable to sched:tip. SpecJBB Critical-jOps improved while
Max-jOPS saw a small hit, but it might be in the expected range.
ycsb-mongodb saw small uplift in NPS1 mode.

Throughput improvement of netperf(localhost) was observed on a
Rome 2 x 64C machine, when the number of clients equals the CPUs.

Abel reported against a latency regression from Redis on an overloaded
system. Inspired by his description, v5 added the check of wakee_flips
to mitigate task stacking.

Changes since v5:
1. Check the wakee_flips of the waker/wakee. If the wakee_flips
   of waker/wakee are both 0, it indicates that the waker and the wakee
   are waking up each other. In this case, put them together on the
   same CPU. This is to avoid that too many wakees are stacked on
   one CPU, which might cause regression on redis.

Changes since v4:
1. Dietmar has commented on the task duration calculation. So refined
   the commit log to reduce confusion.
2. Change [PATCH 1/2] to only record the average duration of a task.
   So this change could benefit UTIL_EST_FASTER[1].
3. As v4 reported regression on Zen3 and Kunpeng Arm64, add back
   the system average utilization restriction that, if the system
   is not busy, do not enable the short wake up. Above logic has
   shown improvment on Zen3[2].
4. Restrict the wakeup target to be current CPU, rather than both
   current CPU and task's previous CPU. This could also benefit
   wakeup optimization from interrupt in the future, which is
   suggested by Yicong.

Changes since v3:
1. Honglei and Josh have concern that the threshold of short
   task duration could be too long. Decreased the threshold from
   sysctl_sched_min_granularity to (sysctl_sched_min_granularity / 8),
   and the '8' comes from get_update_sysctl_factor().
2. Export p->se.dur_avg to /proc/{pid}/sched per Yicong's suggestion.
3. Move the calculation of average duration from put_prev_task_fair()
   to dequeue_task_fair(). Because there is an issue in v3 that,
   put_prev_task_fair() will not be invoked by pick_next_task_fair()
   in fast path, thus the dur_avg could not be updated timely.
4. Fix the comment in PATCH 2/2, that "WRITE_ONCE(CPU1->ttwu_pending, 1);"
   on CPU0 is earlier than CPU1 getting "ttwu_list->p0", per Tianchen.
5. Move the scan for CPU with short duration task from select_idle_cpu()
   to select_idle_siblings(), because there is no CPU scan involved, per
   Yicong.

Changes since v2:

1. Peter suggested comparing the duration of waker and the cost to
   scan for an idle CPU: If the cost is higher than the task duration,
   do not waste time finding an idle CPU, choose the local or previous
   CPU directly. A prototype was created based on this suggestion.
   However, according to the test result, this prototype does not inhibit
   the cross CPU wakeup and did not bring improvement. Because the cost
   to find an idle CPU is small in the problematic scenario. The root
   cause of the problem is a race condition between scanning for an idle
   CPU and task enqueue(please refer to the commit log in PATCH 2/2).
   So v3 does not change the core logic of v2, with some refinement based
   on Peter's suggestion.

2. Simplify the logic to record the task duration per Peter and Abel's suggestion.


[1] https://lore.kernel.org/lkml/c56855a7-14fd-4737-fc8b-8ea21487c5f6@arm.com/
[2] https://lore.kernel.org/all/cover.1666531576.git.yu.c.chen@intel.com/

v5: https://lore.kernel.org/lkml/cover.1675361144.git.yu.c.chen@intel.com/
v4: https://lore.kernel.org/lkml/cover.1671158588.git.yu.c.chen@intel.com/
v3: https://lore.kernel.org/lkml/cover.1669862147.git.yu.c.chen@intel.com/
v2: https://lore.kernel.org/all/cover.1666531576.git.yu.c.chen@intel.com/
v1: https://lore.kernel.org/lkml/20220915165407.1776363-1-yu.c.chen@intel.com/

Chen Yu (2):
  sched/fair: Record the average duration of a task
  sched/fair: Introduce SIS_SHORT to wake up short task on current CPU

 include/linux/sched.h   |  3 +++
 kernel/sched/core.c     |  2 ++
 kernel/sched/debug.c    |  1 +
 kernel/sched/fair.c     | 49 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  1 +
 5 files changed, 56 insertions(+)

-- 
2.25.1

