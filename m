Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5D863A91C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiK1NNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbiK1NNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:13:35 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833951C434;
        Mon, 28 Nov 2022 05:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669641213; x=1701177213;
  h=from:to:cc:subject:date:message-id;
  bh=N11m/EEYgplD58Na2HfYD26Pe7WWecYIErE7gp3zhwk=;
  b=LYC5e2pJt/dp+h6wfFQQzppkvIim9SOjTo+tvxnGrjOPSrAwr6jiYiSI
   iPFrYZOWVlqkYlCX1eHLBKuyd/7v4gVxQyQFaXvFapfIMEWEaQqMg3uvO
   H/3NOHV4vSlxjkhgtgkF8IBUOgmtldyn4+WqMTxo9lSPd5hNGF/FLZzf0
   M9MuHVxcvoBw+WGxBF77CpAbbRvpY2g9eAnkoe6XD1Z/pJjMYmSIHSC5H
   1goGcXjzPt5wuyA/aYJEyL3m7o0iGHMxlP7xfJudupA60vLnqMBRHgsDC
   zCd9+m+H+4q7IyqkqH5/5tGEUfH5fh45sfxDbVbJzhj9TTFmfvA2MUWYr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="401117041"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="401117041"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 05:13:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10544"; a="749381315"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="749381315"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2022 05:13:30 -0800
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
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v2 00/22] sched: Introduce IPC classes for load balance
Date:   Mon, 28 Nov 2022 05:20:38 -0800
Message-Id: <20221128132100.30253-1-ricardo.neri-calderon@linux.intel.com>
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

This is the v2 of the patchset. Since it did not receive strong objections
on the design, I took the liberty of promoting the series from RFC to
PATCH :)

The problem statement and design do not change in this version. Thus, I did
not repeat the cover letter. It can be retrieved here [1].

This series depends on my other patches to use identical asym_packing CPU
priorities on all the SMT siblings of a physical core on x86 [2].

These patches apply cleanly on top of [2]. For convenience, these patches
and [2] can be found here:

	https://github.com/ricardon/tip.git rneri/ipc_classes_v2 

Thanks and BR,
Ricardo

Changes since v1 (sorted by significance):
 * Renamed task_struct::class as task::struct_ipcc. (Joel)
 * Use task_struct::ipcc = 0 for unclassified tasks. (PeterZ)
 * Renamed CONFIG_SCHED_TASK_CLASSES as CONFIG_IPC_CLASSES. (PeterZ, Joel)
 * Dropped patch to take spin lock to read the HFI table from the
 * scheduler and from the HFI enabling code.
 * Implemented per-CPU variables to store the IPCC scores of each class.
   These can be read without holding a lock. (PeterZ).
 * Dropped patch to expose is_core_idle() outside the scheduler. It is
   now exposed as part of [2].
 * Implemented cleanups and reworks from PeterZ when collecting IPCC
   statistics. I took all his suggestions, except the computation of the
   total IPC score of two physical cores.
 * Quantified the cost of HRESET.
 * Use an ALTERNATIVE macro instead of static_cpu_has() to execute HRESET
   when supported. (PeterZ)
 * Fixed a bug when selecting a busiest runqueue: when comparing two
   runqueues with equal nr_running, we must compute the IPCC score delta
   of both runqueues.
 * Fixed the bit number DISABLE_ITD to the correct DISABLE_MASK: 14 instead
   of 13.
 * Redefined union hfi_thread_feedback_char_msr to ensure all
   bit-fields are packed. (PeterZ)
 * Use bit-fields to fit all the ipcc members of task_struct in 4 bytes.
   (PeterZ)
 * Shortened the names of the IPCC interfaces (PeterZ):
   sched_task_classes_enabled >> sched_ipcc_enabled
   arch_has_task_classes >> arch_has_ipc_classes
   arch_update_task_class >> arch_update_ipcc
   arch_get_task_class_score >> arch_get_ipcc_score
 * Removed smt_siblings_idle argument from arch_update_ipcc(). (PeterZ)
 * Added a comment to clarify why sched_asym_prefer() needs a tie breaker
   only in update_sd_pick_busiest(). (PeterZ)
 * Renamed functions for accuracy:
   sched_asym_class_prefer() >> sched_asym_ipcc_prefer()
   sched_asym_class_pick() >> sched_asym_ipcc_pick()
 * Renamed local variables to improve the layout of the code block I added
   in find_busiest_queue(). (PeterZ)
 * Removed proposed CONFIG_INTEL_THREAD_DIRECTOR Kconfig option.
 * Mark hardware_history_features as __ro_after_init instead of
   __read_mostly. (PeterZ)
 
[1]. https://lore.kernel.org/lkml/20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com/
[2]. https://lore.kernel.org/lkml/20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com/

Ricardo Neri (22):
  sched/task_struct: Introduce IPC classes of tasks
  sched: Add interfaces for IPC classes
  sched/core: Initialize the IPC class of a new task
  sched/core: Add user_tick as argument to scheduler_tick()
  sched/core: Update the IPC class of the current task
  sched/fair: Collect load-balancing stats for IPC classes
  sched/fair: Compute IPC class scores for load balancing
  sched/fair: Use IPC class to pick the busiest group
  sched/fair: Use IPC class score to select a busiest runqueue
  thermal: intel: hfi: Introduce Intel Thread Director classes
  thermal: intel: hfi: Store per-CPU IPCC scores
  x86/cpufeatures: Add the Intel Thread Director feature definitions
  thermal: intel: hfi: Update the IPC class of the current task
  thermal: intel: hfi: Report the IPC class score of a CPU
  thermal: intel: hfi: Define a default class for unclassified tasks
  thermal: intel: hfi: Enable the Intel Thread Director
  sched/task_struct: Add helpers for IPC classification
  sched/core: Initialize helpers of task classification
  thermal: intel: hfi: Implement model-specific checks for task
    classification
  x86/cpufeatures: Add feature bit for HRESET
  x86/hreset: Configure history reset
  x86/process: Reset hardware history in context switch

 arch/x86/include/asm/cpufeatures.h       |   2 +
 arch/x86/include/asm/disabled-features.h |   8 +-
 arch/x86/include/asm/hreset.h            |  30 +++
 arch/x86/include/asm/msr-index.h         |   6 +-
 arch/x86/include/asm/topology.h          |  10 +
 arch/x86/kernel/cpu/common.c             |  30 ++-
 arch/x86/kernel/cpu/cpuid-deps.c         |   1 +
 arch/x86/kernel/cpu/scattered.c          |   1 +
 arch/x86/kernel/process_32.c             |   3 +
 arch/x86/kernel/process_64.c             |   3 +
 drivers/thermal/intel/intel_hfi.c        | 229 ++++++++++++++++++++++-
 include/linux/sched.h                    |  22 ++-
 init/Kconfig                             |  12 ++
 kernel/sched/core.c                      |  10 +-
 kernel/sched/fair.c                      | 229 ++++++++++++++++++++++-
 kernel/sched/sched.h                     |  60 ++++++
 kernel/sched/topology.c                  |   8 +
 kernel/time/timer.c                      |   2 +-
 18 files changed, 653 insertions(+), 13 deletions(-)
 create mode 100644 arch/x86/include/asm/hreset.h

-- 
2.25.1

