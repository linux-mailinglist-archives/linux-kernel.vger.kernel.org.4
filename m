Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF06F1B54
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346160AbjD1PUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjD1PUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:20:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9B72109
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682695243; x=1714231243;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=geOWADtIr/X6yJyStUIGmxf2Rf+0LYbb/uDeFXpP+oU=;
  b=aNJP0dyAqJvHE+zAVhsOZgNb5Fz63FV/mZvYSpCnn5AwDELZU9bW3zGa
   vPe3IpRPAodOLX2mN9h+afFVzMn2oA0Fg57dFo29cE2fAb9XvN8RfN/Sz
   PvV2EcX2rZ4nzJSAVmZYfmnqAqj6Fc3+HMVpxQH+guLkcIn++yLq9gZvq
   qidedtOxgY3mBaCff6mc0mCclBIIzm0nxIKsRuuEL8axjX3wJ6zjk4UAh
   cQ4l5RhWXqDeDbNLo6fINnGZUoLTeKbW4FZx6cz1TEvbAy5KcNncRLuB/
   Pzy4fu3iRATQ3kvbrOVBo013dKugHZJICXGtSnQyY1lcjeneluLCWdHD9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="375768796"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="375768796"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 08:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="672224122"
X-IronPort-AV: E=Sophos;i="5.99,234,1677571200"; 
   d="scan'208";a="672224122"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by orsmga006.jf.intel.com with ESMTP; 28 Apr 2023 08:20:36 -0700
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
        Josh Don <joshdon@google.com>,
        kernel test robot <yujie.liu@intel.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v8 0/2] sched/fair: Introduce SIS_CURRENT to wake up short task on current CPU
Date:   Sat, 29 Apr 2023 07:15:59 +0800
Message-Id: <cover.1682661027.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main purpose is to avoid too many cross CPU wake up when it is
unnecessary. The frequent cross CPU wakeup brings significant damage
to some workloads, especially on high core count systems:
1. The cross CPU wakeup triggers race condition that, some wakers are
   stacked on 1 CPU which delays the wakeup of their wakees.
2. The cross CPU wakeup brings c2c overhead if the waker and wakee share
   cache resource. 

Inhibits the cross CPU wake-up by placing the wakee on waking CPU,
if both the waker and wakee are short-duration tasks, and when the
waker and wakee wake up each other.

The first patch introduces the definition of a short-duration task.
The second patch leverages the first patch to choose a local CPU for wakee.

Overall there is performance improvement when the benchmark has
close 1:1 waker/wakee relationship, such as will-it-scale, netperf, tbench.
And for netperf, it has a universal performance improvement under many
different utilization. And there is no noticeable impact on schbench, hackbench,
or a OLTP workload with a commercial RDBMS, according to the test on
Intel Sapphire Rapids, which has 2 x 56C/112T = 224 CPUs.

Per the test on Zen3 from Prateek on v7,  tbench/netperf shows good
improvement at 128 clients, SPECjbb2015 shows improvement in max-jOPS.
And the result of v8 should not be quite different from v7 because
the threshold in v7 and v8 are comparable.

Changes since v7:
1. Replace sysctl_sched_min_granularity with sysctl_sched_migration_cost
   to determine if a task is a short duration one, according to Peter's
   suggestion.

Changes since v6:
1. Rename SIS_SHORT to SIS_CURRENT, which better describes this feature.
2. Remove the 50% utilization threshold. Removes the has_idle_cores check.
   After this change, SIS_CURRENT is applicable to all system utilization.
3. Add a condition that only waker and wakee wake up each other would enable
   the SIS_CURRENT. That is, A->last_wakee = B and B->last_wakee = A.

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

v6: https://lore.kernel.org/lkml/cover.1677069490.git.yu.c.chen@intel.com/
v5: https://lore.kernel.org/lkml/cover.1675361144.git.yu.c.chen@intel.com/
v4: https://lore.kernel.org/lkml/cover.1671158588.git.yu.c.chen@intel.com/
v3: https://lore.kernel.org/lkml/cover.1669862147.git.yu.c.chen@intel.com/
v2: https://lore.kernel.org/all/cover.1666531576.git.yu.c.chen@intel.com/
v1: https://lore.kernel.org/lkml/20220915165407.1776363-1-yu.c.chen@intel.com/

Chen Yu (2):
  sched/fair: Record the average duration of a task
  sched/fair: Introduce SIS_CURRENT to wake up short task on current CPU

 include/linux/sched.h   |  3 +++
 kernel/sched/core.c     |  2 ++
 kernel/sched/debug.c    |  1 +
 kernel/sched/fair.c     | 59 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  1 +
 5 files changed, 66 insertions(+)

-- 
2.25.1

