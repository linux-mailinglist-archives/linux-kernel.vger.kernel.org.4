Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749D368CE74
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 06:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjBGFB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 00:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjBGFBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 00:01:44 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4C325B81;
        Mon,  6 Feb 2023 21:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675746100; x=1707282100;
  h=from:to:cc:subject:date:message-id;
  bh=ZcEep9xkcBrk9S44jeEAN2JseyllVZnKllZerSHp70A=;
  b=lDpzrHHmOaIyVhnPM6txPxzgFsPgsH7AjwA91gfNNjMK5S0QNu9NbjhY
   9bTd9abfXduBpkdB2EjV52NfssxgwjRevpOiPIKYsWJs+s+/Cj2KCHPlb
   f2yhS0GGCUhnTzCTGmRCji8lyOzoguqAKv1lDpGPLwQRkeVgac/bgKRtQ
   7+yg4QMJsH8l0OPK5YVJyDv/qveKwO7YdS7kbC/kxCYpBR7HyCBNQ5WKD
   GXR5/hRI7oAIVX+W9TvG65j5awd2zJSDdz7PyuzrK4ZKiUOKbv1QgcIvo
   cVeLAXuNKWSv7Qa5dfY4y47cPy19ZFl+4T39uNHp5UYIVCkkJ/4jjnHJD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415625728"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415625728"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 21:01:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668657685"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668657685"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 21:01:39 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v3 00/24] sched: Introduce classes of tasks for load balance
Date:   Mon,  6 Feb 2023 21:10:41 -0800
Message-Id: <20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is third version of this patchset. Previous versions can be found
here [1] and here [2]. For brevity, I did not include the cover letter
from the original posting. You can read it here [1].

This patchset depends on a separate series to handle better asym_packing
between SMT cores [3].

For convenience, this patchset and [3] can be retrieved from [4] and are
based on the tip tree as on Feb 6th, 2023.

Changes since v2:

Ionela pointed out that the IPCC performance score was vague. I provided
a clearer definition and guidance on how architectures should implement
support for it.

Ionela mentioned that other architectures or scheduling schemes may want
to use IPC classes differently. I restricted its current use to
asym_packing.

Lukasz raised the issue that hardware may not be ready to support IPC
classes early after boot. I added a new interface that drivers or
enablement code can call to enable the use of IPC classes when ready.

Vincent provided multiple suggestions on how to balance non-SMT and SMT
sched groups. His feedback was incorporated in [3]. As a result, now
IPCC statistics are also used to break ties between fully_busy groups.

Dietmar indicated that real-time nor deadline tasks should influence the
CFS load balancing. I implemented such change. Also, as per his suggestion,
I folded the IPCC statistics into the existing struct sg_lb_stats.

Updated patches: 2, 6, 7, 10, 13, 14, 17
New patches: 9, 20
Unchanged patches: 1, 3, 4, 5, 8, 11, 12, 15, 16, 18, 19, 21, 22, 23, 24

Hopefully, this series is one step closer to be merged.

Thanks in advance for your kind feedback!

BR,
Ricardo

[1]. https://lore.kernel.org/lkml/20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com/
[2]. https://lore.kernel.org/lkml/20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com/
[3]. https://lore.kernel.org/lkml/20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com/
[4]. https://github.com/ricardon/tip/tree/rneri/ipc_classes_v3

Ricardo Neri (24):
  sched/task_struct: Introduce IPC classes of tasks
  sched: Add interfaces for IPC classes
  sched/core: Initialize the IPC class of a new task
  sched/core: Add user_tick as argument to scheduler_tick()
  sched/core: Update the IPC class of the current task
  sched/fair: Collect load-balancing stats for IPC classes
  sched/fair: Compute IPC class scores for load balancing
  sched/fair: Use IPCC stats to break ties between asym_packing sched
    groups
  sched/fair: Use IPCC stats to break ties between fully_busy SMT groups
  sched/fair: Use IPCC scores to select a busiest runqueue
  thermal: intel: hfi: Introduce Intel Thread Director classes
  x86/cpufeatures: Add the Intel Thread Director feature definitions
  thermal: intel: hfi: Store per-CPU IPCC scores
  thermal: intel: hfi: Update the IPC class of the current task
  thermal: intel: hfi: Report the IPC class score of a CPU
  thermal: intel: hfi: Define a default class for unclassified tasks
  thermal: intel: hfi: Enable the Intel Thread Director
  sched/task_struct: Add helpers for IPC classification
  sched/core: Initialize helpers of task classification
  sched/fair: Introduce sched_smt_siblings_idle()
  thermal: intel: hfi: Implement model-specific checks for task
    classification
  x86/cpufeatures: Add feature bit for HRESET
  x86/hreset: Configure history reset
  x86/process: Reset hardware history in context switch

 arch/x86/include/asm/cpufeatures.h       |   2 +
 arch/x86/include/asm/disabled-features.h |   8 +-
 arch/x86/include/asm/hreset.h            |  30 +++
 arch/x86/include/asm/msr-index.h         |   6 +-
 arch/x86/include/asm/topology.h          |   8 +
 arch/x86/kernel/cpu/common.c             |  30 ++-
 arch/x86/kernel/cpu/cpuid-deps.c         |   1 +
 arch/x86/kernel/cpu/scattered.c          |   1 +
 arch/x86/kernel/process_32.c             |   3 +
 arch/x86/kernel/process_64.c             |   3 +
 drivers/thermal/intel/intel_hfi.c        | 242 +++++++++++++++++-
 include/linux/sched.h                    |  24 +-
 include/linux/sched/topology.h           |   6 +
 init/Kconfig                             |  12 +
 kernel/sched/core.c                      |  10 +-
 kernel/sched/fair.c                      | 309 ++++++++++++++++++++++-
 kernel/sched/sched.h                     |  66 +++++
 kernel/sched/topology.c                  |   9 +
 kernel/time/timer.c                      |   2 +-
 19 files changed, 751 insertions(+), 21 deletions(-)
 create mode 100644 arch/x86/include/asm/hreset.h

-- 
2.25.1

