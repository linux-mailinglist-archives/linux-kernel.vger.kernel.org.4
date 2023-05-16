Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814D370374E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244042AbjEORT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243914AbjEORTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:19:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2780DD84D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684171030; x=1715707030;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=leywsTZOe0+ob5IXhfBkHqWqLVpnjhaPQaJYjTDu39o=;
  b=Lq7N14ZdDzmG9N9WYBYeKpPyYEYuSO+P+JyCWCd4Vj5oUpoQaIhbosJd
   14Vv3RoOBgeX+nmCscqAwBGMSvHCABW67I/TGVoGE3bDOFyMDYNAOhxxu
   DPWz/qL8lNyRlsdiguPL7lp5jBLqSgp4GAvqnTZ1Tl1QwcexTVMpifhHy
   Sh38kLjA5EZEwBud2HnqYtKcyVryEO4RYAiroMrdDjxTsfhDsNtagQalg
   1mheIwTXdufm+9Ga1/91+QUA4WoKPzDcFbU8WfXqJwN2yn2z4BDY/b9Qu
   9Qqq9A79MQc2npdidcHCLSFrqZPl0oOZ9R37hBnOPnPe9bvDtipRq3roW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="416915867"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="416915867"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 10:17:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="766034722"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="766034722"
Received: from chenyu-dev.sh.intel.com ([10.239.62.164])
  by fmsmga008.fm.intel.com with ESMTP; 15 May 2023 10:17:04 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, Barry Song <baohua@kernel.org>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH] sched/fair: Introduce SIS_PAIR to wakeup task on local idle core first
Date:   Tue, 16 May 2023 09:11:59 +0800
Message-Id: <20230516011159.4552-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Problem Statement]

High core count system running a lot of frequent context switch
workloads suffers from performance downgrading due to Cache-to-Cache
latency.

The will-it-scale context_switch1 test case exposes the issue. The
test platform has 2 x 56C/112T and 224 CPUs in total. To evaluate the
C2C overhead within 1 LLC, will-it-scale was tested with 1 socket/node
online, so there are 56C/112T CPUs when running will-it-scale.

will-it-scale launches 112 instances. Each instance is composed of
2 tasks, and each pair of tasks would do ping-pong scheduling via
pipe_read() and pipe_write(). No task is bound to any CPU.

According to the perf profile, update_cfs_group() and update_load_avg()
have taken a lot of cycles:

20.26%    19.89%  [kernel.kallsyms]          [k] update_cfs_group
13.53%    12.15%  [kernel.kallsyms]          [k] update_load_avg

And the perf c2c result indicates a high average cost of C2C overhead
from HITM events, between the reader update_cfs_group() and the writer
update_load_avg(). Both compete for the same cache line of tg->load_avg.
This issue has been investigated and root caused by Aaron Lu[1], and it
becomes more severe if there are too many cross-core task migrations
during wakeup.

[Proposal]

Scan for an idle sibling within the SMT domain first.

In a previous context switch cycle, if the waker and the wakee wake up
each other, then it is possible that they have shared resources, and
the wakee can be put on an idle sibling next to the waker to avoid the C2C
overhead.

Mike Galbraith helped me test the SIS_CURRENT[2], which wakes up the
short task on the current CPU. But it seems that although SIS_CURRENT brings
improvement on high-end platforms, it could raise the risk of stacking
tasks and hurt latency on low-end system. Such system has a smaller number of
CPUs in the LLC, and the reduction of C2C can not offset the hurt to
latency on such platforms. Thanks Mike for providing a lot of test data
and suggesting choosing an idle shared L2 to mitigate C2C. Also Tim and
Len has mentioned that we do have cluster domains, and maybe the cluster
wakeup patch from Yicong and Barry could be leveraged to mitigate C2C[3].
However, in the current code, the SMT domain does not have SD_CLUSTER flag
so the above patch can not be reused for now.

The current patch only deals with SMT domain, but since C2C is mainly about
cache sync between Cores sharing the L2,the cluster-based wakeup could
be enhanced to include SMT domain as well.

[Benchmark]

The baseline is on sched/core branch on top of
commit a6fcdd8d95f7 ("sched/debug: Correct printing for rq->nr_uninterruptible")

Tested will-it-scale context_switch1 case, it shows good improvement
both on a server and a desktop:

Intel(R) Xeon(R) Platinum 8480+, Sapphire Rapids 2 x 56C/112T = 224 CPUs
context_switch1_processes -s 100 -t 112 -n
baseline                   SIS_PAIR
1.0                        +68.13%

Intel Core(TM) i9-10980XE, Cascade Lake 18C/36T
context_switch1_processes -s 100 -t 18 -n
baseline                   SIS_PAIR
1.0                        +45.2%


[Limitations]
This patch only brings benefits when there is an idle sibling in the SMT domain.
If every CPU in the system is saturated, this patch makes no difference(unlike
SIS_CURRENT)
An optimized way should detect the saturated case, and try its best to put
cache-friendly task pairs within 1 Core.

Before starting the full test, it would be appreciated to have suggestions
on whether this is in the right direction. Thanks.

[1] https://lore.kernel.org/lkml/20230327053955.GA570404@ziqianlu-desk2/ 
[2] https://lore.kernel.org/lkml/cover.1682661027.git.yu.c.chen@intel.com/
[3] https://lore.kernel.org/lkml/20220915073423.25535-3-yangyicong@huawei.com/

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c     | 15 +++++++++++++++
 kernel/sched/features.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 48b6f0ca13ac..e65028dcd6a6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7125,6 +7125,21 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    asym_fits_cpu(task_util, util_min, util_max, target))
 		return target;
 
+	/*
+	 * If the waker and the wakee are good friends to each other,
+	 * putting them within the same SMT domain could reduce C2C
+	 * overhead. SMT idle sibling should be preferred to wakee's
+	 * previous CPU, because the latter could still have the risk of C2C
+	 * overhead.
+	 */
+	if (sched_feat(SIS_PAIR) && sched_smt_active() &&
+	    current->last_wakee == p && p->last_wakee == current) {
+		i = select_idle_smt(p, smp_processor_id());
+
+		if ((unsigned int)i < nr_cpumask_bits)
+			return i;
+	}
+
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..86b5c4f16199 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  */
 SCHED_FEAT(SIS_PROP, false)
 SCHED_FEAT(SIS_UTIL, true)
+SCHED_FEAT(SIS_PAIR, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
-- 
2.25.1

