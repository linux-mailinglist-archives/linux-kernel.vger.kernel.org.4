Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C33664E734
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiLPGIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLPGIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:08:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18B32EF5B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671170908; x=1702706908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LDypGX5BWlrJDf+sI3pcisid8OoMmHVrixjsj3OKuw0=;
  b=NA0XHdubFHv7dlh8vGGElBP5Ott0xcAH6qeidqBnLzl+6W7gM8Mhw27R
   810qQmJoyGdUHGI/WSRySnAUEsFMAskodzhH25jR6ekq9oVXHPIdQ01P2
   SIxoJI4W/YoKF/ndguo6qtcsgaMZEm5ikH15XfczMq3TDfl7TCfbdog7Z
   mEBbnrPV6+2Vn4TclQS/Re127Q0iSsFIlbvF4ZdLU5BGm5eu/KGe13nKJ
   deXGc5Gz1CMXR3Mlo+SvmXsUN5oyKClvPiIyqaPdpdiFvu9z1t/LHv1ES
   xOTPT+bUf+1dz+pnbEn6ek4WPNHkipDtJgAQ6BDUx6wZboyYMufmYcLGv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="320068894"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="320068894"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 22:08:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="680389248"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="680389248"
Received: from chenyu-dev.sh.intel.com ([10.239.158.170])
  by orsmga008.jf.intel.com with ESMTP; 15 Dec 2022 22:08:21 -0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org,
        Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH v4 0/2] sched/fair: Choose the CPU where short task is running during wake up
Date:   Fri, 16 Dec 2022 14:08:50 +0800
Message-Id: <cover.1671158588.git.yu.c.chen@intel.com>
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

The main purpose of this change is to avoid too many cross CPU
wake up when it is unnecessary. The frequent cross CPU wake up
brings significant damage to some workloads, especially on high
core count systems.

This patch set inhibits the cross CPU wake-up by placing the wakee
on waking CPU or previous CPU, if both the waker and wakee are
short-duration tasks.

The first patch is to introduce the definition of a short-duration
task. The second patch leverages the first patch to choose a local
or previous CPU for wakee.

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

This change brings overall improvement on some microbenchmarks, both on
Intel and AMD platforms.

v3: https://lore.kernel.org/lkml/cover.1669862147.git.yu.c.chen@intel.com/
v2: https://lore.kernel.org/all/cover.1666531576.git.yu.c.chen@intel.com/
v1: https://lore.kernel.org/lkml/20220915165407.1776363-1-yu.c.chen@intel.com/

Chen Yu (2):
  sched/fair: Introduce short duration task check
  sched/fair: Choose the CPU where short task is running during wake up

 include/linux/sched.h   |  3 +++
 kernel/sched/core.c     |  2 ++
 kernel/sched/debug.c    |  1 +
 kernel/sched/fair.c     | 32 ++++++++++++++++++++++++++++++++
 kernel/sched/features.h |  1 +
 5 files changed, 39 insertions(+)

-- 
2.25.1

