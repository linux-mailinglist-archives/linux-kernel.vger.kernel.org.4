Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0AE5B42DC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiIIXIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbiIIXGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAFC116B5F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662764804; x=1694300804;
  h=from:to:cc:subject:date:message-id;
  bh=LdJRsGR2OiQ9tX1pJHtSJ2poqL5uwV1h4OZKqo38uOg=;
  b=gEiwDSiXzZMRcJJh59DLA2MyqT4ueWiWs+CE6VKtzwCiHk3X2B6BhuXC
   oUOu8yP2/lsFdbjBFS4c+vnpQSafAr5SnnPWQCyo02kni5M4VQWSgBa4f
   8oslMejLivkYu1kT9iW4gLwgVFt6esa0Ds2qt2MXVj/y1eRsI/m6XqLAL
   lp3YO7o8Eb3t1gV7MByKufdLHyezF4TgU3EfweVjyVCGdc3lLqkBofWQy
   HldrcQPcTtOavyrnmIkw9R0XsZoCGkJ54G1SIJM5tsHW1Q+CebcQ7UNTU
   mTJ28xzv1RTxaNHsHne9h3ErD9g4zjszI65PeZopRetXyx7WlJuU2ol63
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="296325071"
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="296325071"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 16:06:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,304,1654585200"; 
   d="scan'208";a="677354961"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga008.fm.intel.com with ESMTP; 09 Sep 2022 16:06:31 -0700
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
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [RFC PATCH 00/23] sched: Introduce classes of tasks for load balance
Date:   Fri,  9 Sep 2022 16:11:42 -0700
Message-Id: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Introduction

On hybrid processors, the microarchitectural properties of the different
types of CPUs cause them to have different instruction-per-cycle (IPC)
capabilities. IPC can be higher on some CPUs for advanced instructions
Figure 1 illustrates this concept. It plots hypothetical workloads
grouped by classes of instructions vs the IPC ratio between high and low
performance CPUs.

IPC ratio
  ^
  | Class0 .             Class1               .   ClassN-1    .  ClassN
  |        .                                  .               .   +
  |        .                                  .               .  +
  |        .                                  .               . +
  |        .                                  . + + + + + + + +
  |        .                                  .               .
  |        .                                  .               .
  |        .             + + + + + + + + + + +                .
  |        + + + + + + +                      .               .
  |      + .                                  .               .
  |     +  .                                  .               .
  |    +   .                                  .               .
  |   +    .                                  .               .
1 |-------------------------------------------//---------------------------->
  |                                                      wokloads of interest
															
            Figure 1. Hypothetical workloads sorted by IPC ratio


The load balancer can discover the use of advanced instructions and prefer
CPUs with higher IPC for tasks running those instructions.

Hardware is free to partition its instruction set into an arbitrary number
of classes. It must provide a mechanism identify the class of the
currently running task and inform the kernel about the performance of each
class of task on each type of CPU.

This patchset introduces the concept of classes of tasks, proposes the
interfaces that hardware needs to implement and proposes changes to the
load balancer to leverage this extra information in combination with
asymmetric packing.

This patchset includes a full implementation for Intel hybrid processors
using Intel Thread Director technology [1].


+++ Structure of this series

Patches 1-6 introduce the concept of classes of tasks. They also introduce
interfaces that architectures implement to update the class of a task and
to inform the scheduler about the class-specific performance scores.

Patches 7-9 use the class of the current task of each runqueue to break
ties between two otherwise identical group_asym_packing scheduling groups.

Patches 10-16 implement support for classes of tasks on Intel hybrid
processors using Intel Thread Director technology.

Patches 17-19 introduce extra helper members to task_struct to deal with
transient classification of tasks and arch-specific implementation
vagaries.

Patches 20-22 are specific to Intel Thread Director. They reset the
classification hardware when switching to a new task.


+++ Classes of tasks

The first step to leverage the asymmetries in IPC ratios is to assign a
class label to each individual task. Hardware can monitor the instruction
stream and classify a task as it runs. At user tick, the kernel reads the
resulting classification and assigns it to the currently running task. It
stores the class in the proposed task_struct::class.


+++ Balancing load using classes of tasks. Theory of operation

Intel hybrid processors rely on asymmetric packing to place tasks on
higher performance CPUs first. The class of the current task on each
runqueue can be used to break ties between two otherwise identical
scheduling groups.

Consider these scenarios (for simplicity, assume that task-class
performance score is such that

score(Cl0) < score(Cl1) < ... < score(Cl(n-1)) < score(Cln)). (Eq I)

Boxes depict scheduling groups being considered during load balance.
Labels inside the box depict the class of rq->curr, or the CPU being
idle.

    asym
    packing
    priorities    50    50           30           30
                _____________
                |  i  .  i  |
                |  d  .  d  |
                |  l  .  l  |      _______      _______
                |  e  .  e  |      | Cl0 |      | Cl1 |
                |___________|      |_____|      |_____|

                         ^
                      dst_cpu        sgA          sgB
                                                   ^
                                                busiest

                           Figure 2. Scenario A
	
In Figure 2, dst_cpu is a group of SMT siblings, has become idle, has
higher priority, and is identifying the busiest group. sgA and sgB are of
group_asym_packing type, have the same priority, have a single CPU, and
have the same number of running tasks. By checking the class of the task
currently running on both scheduling groups, it selects sgB as the busiest
because it has a class of task higher performance score if placed on
dst_cpu.

    asym
    packing
    priorities    50    50           50    50           30
                _____________     _____________
                |     .     |     |     .     |
                |     .     |     |     .     |       idle
                | cl0 . cl1 |     | cl0 . cl2 |      _______
                |     .     |     |     .     |      |     |
                |___________|     |___________|      |_____|

                                                        ^
                     sgA                sgB          dst_cpu
                                         ^
                                    busiest group

                                     ^
                                  busiest queue

                           Figure 3. Scenario B

In Figure 3, dst_cpu has become idle, has lower priority and is identifying
a busiest group. sgA and sgB are groups of SMT siblings. Both siblings are
busy and, therefore, classified as group_asym_packing [2], have the same
priority and the same number of running tasks. The load balancer computes
the class-specific performance score (scaled by the number of busy
siblings) by observing the currently running task on each runqueue.

As per Eq. I, cl0+cl2 has a higher throughput than cl0+cl1. So, it selects
sgB as the busiest group. If cl2 is left to run with the whole big core to
itself, it would deliver higher throughput than cl0. Hence, the runqueue of
cl0 is selected as the busiest.


+++ Dependencies
These patches assume that both SMT siblings of a core have the same
priority, as proposed in [3]. Also, they rely on the existing support for
the Hardware Feedback Interface [4].


I look forward to your review and thank you in advance!

These patches have been Acked-by: Len Brown <len.brown@intel.com>

Thanks and BR,
Ricardo

[1]. Intel Software Developer Manual, Volume 3, Section 14.6
     https://intel.com/sdm
[2]. https://lkml.kernel.org/r/20210911011819.12184-7-ricardo.neri-calderon@linux.intel.com
[3]. https://lore.kernel.org/lkml/20220825225529.26465-1-ricardo.neri-calderon@linux.intel.com/
[4]. https://lore.kernel.org/linux-pm/20220127193454.12814-1-ricardo.neri-calderon@linux.intel.com/

Ricardo Neri (23):
  sched/task_struct: Introduce classes of tasks
  sched: Add interfaces for classes of tasks
  sched/core: Initialize the class of a new task
  sched/core: Add user_tick as argument to scheduler_tick()
  sched/core: Move is_core_idle() out of fair.c
  sched/core: Update the classification of the current task
  sched/fair: Collect load-balancing stats for task classes
  sched/fair: Compute task-class performance scores for load balancing
  sched/fair: Use task-class performance score to pick the busiest group
  sched/fair: Use classes of tasks when selecting a busiest runqueue
  thermal: intel: hfi: Introduce Hardware Feedback Interface classes
  thermal: intel: hfi: Convert table_lock to use flags-handling variants
  x86/cpufeatures: Add the Intel Thread Director feature definitions
  thermal: intel: hfi: Update the class of the current task
  thermal: intel: hfi: Report per-cpu class-specific performance scores
  thermal: intel: hfi: Define a default classification for unclassified
    tasks
  thermal: intel: hfi: Enable the Intel Thread Director
  sched/task_struct: Add helpers for task classification
  sched/core: Initialize helpers of task classification
  thermal: intel: hfi: Implement model-specific checks for task
    classification
  x86/cpufeatures: Add feature bit for HRESET
  x86/hreset: Configure history reset
  x86/process: Reset hardware history in context switch

 arch/x86/include/asm/cpufeatures.h       |   2 +
 arch/x86/include/asm/disabled-features.h |   8 +-
 arch/x86/include/asm/hreset.h            |  30 ++++
 arch/x86/include/asm/msr-index.h         |   4 +
 arch/x86/include/asm/topology.h          |  10 ++
 arch/x86/kernel/cpu/common.c             |  35 +++-
 arch/x86/kernel/cpu/cpuid-deps.c         |   1 +
 arch/x86/kernel/cpu/scattered.c          |   1 +
 arch/x86/kernel/process_32.c             |   3 +
 arch/x86/kernel/process_64.c             |   3 +
 drivers/thermal/intel/Kconfig            |  12 ++
 drivers/thermal/intel/intel_hfi.c        | 215 +++++++++++++++++++++--
 include/linux/sched.h                    |  19 +-
 init/Kconfig                             |   9 +
 kernel/sched/core.c                      |  10 +-
 kernel/sched/fair.c                      | 214 ++++++++++++++++++++--
 kernel/sched/sched.h                     |  81 +++++++++
 kernel/sched/topology.c                  |   8 +
 kernel/time/timer.c                      |   2 +-
 19 files changed, 635 insertions(+), 32 deletions(-)
 create mode 100644 arch/x86/include/asm/hreset.h

-- 
2.25.1

