Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AE5634824
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234480AbiKVU2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbiKVU2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:28:14 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59FF1A20F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669148892; x=1700684892;
  h=from:to:cc:subject:date:message-id;
  bh=J1BQtcBqApkucH24WPBn73V4lZB7ym20ML96xoxE4Ok=;
  b=dfPKmL1dK5/xTBAcwVjv3y/WPzamyeoA2oCIsRqX1/4a2TqNGgp+f779
   HoRTuKcQCZw01Lt+xcL92KPHj+/wueoIET8sN2dTC0kJ9C24oX3wm17H8
   6SCH0+T7ggAvcSqSina4L2PZDMCYPbkKoESWIYc5McaRb5jA4mEfa8BRA
   7TpalXx0zm4E7wlLD5HP8YhgUzUq2OHjYFboFN6ABEF/cGf2gHphC08h7
   5O5P5Ko1q01rkLCDVc/K75pBVJhQz0b4JkHNmG7/DnmrpDStLEjt+3EO0
   4wj2jx5CIiBC+HgO6jC2YiH8pjLIwnMmVSHft3GEiM9nY5MK1fX8zoVUI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="293616499"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="293616499"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 12:28:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="816228118"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="816228118"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 22 Nov 2022 12:28:11 -0800
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
Subject: [PATCH v2 0/7] x86/sched: Avoid unnecessary migrations within SMT domains
Date:   Tue, 22 Nov 2022 12:35:25 -0800
Message-Id: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This v2 of this patchset. V1 can be found here [1]. In this version I took
the suggestion of Peter to teach arch_asym_cpu_priority() the CPU state.
Also, I reworded the cover letter to explain better the intent.

---

asym_packing load balancing is used to balance load among physical cores
with SMT (e.g., Intel processors that support Intel Turbo Boost Max 3.0 and
hybrid processors) and among SMT siblings of a physical cores (e.g.,
Power7).

The current implementation is sufficient for the latter case as it favors
higher-priority SMT siblings. In the former case, however, we must consider
the fact that the throughput of a CPU degrades if one or more of its SMT
siblings are busy. Hence, a lower-priority CPU that is fully idle is more
desirable than a high-priority CPU with busy SMT siblings. 

To fit the current implementation of asym_packing, x86 artificially assigns
a lower priority to the higher-numbered SMT siblings. In reality, there is
no difference between any of the SMT siblings of a core.

Do not use different priorities for each SMT sibling. Instead, tweak the
asym_packing load balancing logic to consider the idle state of the SMT
siblings of a CPU. 

Removing these artificial priorities avoids superfluous migrations and let
lower-priority cores inspect all SMT siblings for the busiest queue. The
latter is also necessary to support IPC classes of tasks [2], as the
destination CPU will need to inspect the tasks running on CPUs of equal
priority.

This patchset should not break Power7 SMT8. Functionality does not change
for architectures that do not implement the new check_smt parameter of
sched_prefer_asym().

These patches apply cleanly on today's tip tree.

Changes since v1:
 * Tweaked arch_asym_cpu_priority() and sched_asym_prefer() to handle
   the idle state of the SMT siblings of a CPU. (PeterZ)
 * Expose functionality of the scheduler that determines the idle state
   of the SMT siblings of a CPU.
 * Addressed concerns from Peter about SMT2 assumptions and breaking
   Power7.
 * Removed the SD_ASYM_PACKING flag from the "SMT" domain in x86.
 * Reworked x86's arch_asym_cpu_priority() to consider the idle state
   of the SMT siblings of a CPU.

[1]. https://lore.kernel.org/lkml/20220825225529.26465-1-ricardo.neri-calderon@linux.intel.com/
[2]. https://lore.kernel.org/lkml/20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com/

Ricardo Neri (7):
  sched/fair: Generalize asym_packing logic for SMT local sched group
  sched: Prepare sched_asym_prefer() to handle idle state of SMT
    siblings
  sched: Teach arch_asym_cpu_priority() the idle state of SMT siblings
  sched/fair: Introduce sched_smt_siblings_idle()
  x86/sched: Remove SD_ASYM_PACKING from the "SMT" domain
  x86/sched/itmt: Give all SMT siblings of a core the same priority
  x86/sched/itmt: Consider the idle state of SMT siblings

 arch/x86/kernel/itmt.c         | 30 ++++--------
 arch/x86/kernel/smpboot.c      |  2 +-
 include/linux/sched.h          |  2 +
 include/linux/sched/topology.h |  2 +-
 kernel/sched/fair.c            | 90 +++++++++++++++++-----------------
 kernel/sched/sched.h           | 11 +++--
 kernel/sched/topology.c        |  6 ++-
 7 files changed, 72 insertions(+), 71 deletions(-)

-- 
2.25.1

