Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7219372D861
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239063AbjFMEVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFMEVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:21:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E2010DA;
        Mon, 12 Jun 2023 21:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686630095; x=1718166095;
  h=from:to:cc:subject:date:message-id;
  bh=njgdb0ONdSGtfhuhBYq+P+GvUryOJP3BffdwQYUOC4M=;
  b=ZoKib7oUwnSnBOdpRJuRSdTwYu19GH+DtmIrnzCDlBApwMRzrk3nT5eg
   8DYVkg2APmiV+ntl9qPnhW+ft27FSwMVgz5254u78dQHUUf8LdbsriQpq
   7SX564FYQ3pnG3ZMXIWvyvSgKxbD/+D0kJeLxUjtDdV4HJw5f7ucnQDD3
   tnx7TIit9YgjmZ78il9q2a1CC4Ol6aCOJixf9SRijtg1GCdvZ/L1xgVa9
   9nuJ6y5yEZOD89JkQscV7Be+ApwDmsmAbUcqX39WJ8OWlD1bDEyoCBmNO
   TkWz6jJqW21H5b9ZMoGGR6ZSkQMZA7+FFmhuDSw72aibmnx+SGORvZUYL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="358222018"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="358222018"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 21:21:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="661854919"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="661854919"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 21:21:33 -0700
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
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>, x86@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v4 00/24] sched: Introduce classes of tasks for load balance
Date:   Mon, 12 Jun 2023 21:23:58 -0700
Message-Id: <20230613042422.5344-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the fourth version of this patchset. Previous versions can be found
here [1], here [2], and here[3]. For brevity, I did not include the cover
letter from the original posting. You can read it here [1].

This patchset depends on a separate patchset to handle better asym_packing
between SMT cores [4]. This patchset was recently merged into the tip tree.

For your convenience, you can retrieve this patchset from [5], and is based
on the master branch of the tip tree as on 12th June 2023.

Changes since v3:

Vincent highlighted the issue of using the current tasks of runqueues to
collect IPCC statistics. Since these are the last tasks to be pulled during
load balance, the proposed tie breakers would have little effect. Instead,
I have reworked the collection of IPCC statistics to look at the back of
the runqueues. This makes the IPCC scores more useful, as these are the
first tasks to be pulled during load balance.

Rafael argued that the HFI driver should not handle tasks directly. I have
reworked the code to let the HFI driver read the classification result.
A new sched_ipcc.c file under arch/x86 is in charge or handling tasks and
postprocess classification.

Rafael also raised concerns about the need for a memory barrier to order
reads and writes of the cached IPCC scores that the scheduler can access
without holding the HFI lock. I decided to use a seqcount. The seqcount
provides store-release and load-acquire semantics, ensuring proper
ordering of reads and writes of the cached IPCC scores. It also provides a
compiler barrier. A CPU memory barrier is not needed.

Zhao noticed that there is a new CPUID_7_1_EAX leaf and using cpuid_bits[]
in scattered.c is not needed. I fixed it.

lkp@intel.com found a build break due to a misplaced definition of
MSR_IA32_HW_FEEDBACK_CHAR. I moved the definition to patch 13.

Updated patches: 6, 10, 13, 14, 15, 17, 21, 22
New patches: none
Unchanged patches: 1, 2, 3, 4, 5, 7, 8, 9, 11, 12, 16, 18, 19, 20, 23, 24

Thanks in advance for your kind feedback!
BR,
Ricardo

[1]. https://lore.kernel.org/lkml/20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com/
[2]. https://lore.kernel.org/lkml/20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com/
[3]. https://lore.kernel.org/all/20230207051105.11575-1-ricardo.neri-calderon@linux.intel.com/
[4]. https://lore.kernel.org/all/20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com/
[5]. https://github.com/ricardon/tip/tree/rneri/ipc_classes_v4

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
  x86/sched: Update the IPC class of the current task
  thermal: intel: hfi: Store per-CPU IPCC scores
  thermal: intel: hfi: Report the IPC class score of a CPU
  thermal: intel: hfi: Define a default class for unclassified tasks
  thermal: intel: hfi: Enable the Intel Thread Director
  sched/task_struct: Add helpers for IPC classification
  sched/core: Initialize helpers of task classification
  sched/fair: Introduce sched_smt_siblings_idle()
  x86/sched/ipcc: Implement model-specific checks for task
    classification
  x86/cpufeatures: Add feature bit for HRESET
  x86/hreset: Configure history reset
  x86/process: Reset hardware history in context switch

 arch/x86/include/asm/cpufeatures.h       |   2 +
 arch/x86/include/asm/disabled-features.h |   8 +-
 arch/x86/include/asm/hreset.h            |  30 +++
 arch/x86/include/asm/msr-index.h         |   5 +
 arch/x86/include/asm/topology.h          |  15 ++
 arch/x86/kernel/Makefile                 |   2 +
 arch/x86/kernel/cpu/common.c             |  30 ++-
 arch/x86/kernel/cpu/cpuid-deps.c         |   1 +
 arch/x86/kernel/process_32.c             |   3 +
 arch/x86/kernel/process_64.c             |   3 +
 arch/x86/kernel/sched_ipcc.c             |  93 +++++++
 drivers/thermal/intel/Kconfig            |   1 +
 drivers/thermal/intel/intel_hfi.c        | 219 +++++++++++++++-
 include/linux/sched.h                    |  24 +-
 include/linux/sched/topology.h           |   6 +
 init/Kconfig                             |  12 +
 kernel/sched/core.c                      |  10 +-
 kernel/sched/fair.c                      | 316 ++++++++++++++++++++++-
 kernel/sched/sched.h                     |  66 +++++
 kernel/sched/topology.c                  |   9 +
 kernel/time/timer.c                      |   2 +-
 21 files changed, 840 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/include/asm/hreset.h
 create mode 100644 arch/x86/kernel/sched_ipcc.c

-- 
2.25.1

