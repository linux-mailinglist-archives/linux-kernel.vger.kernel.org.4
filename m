Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6716DA280
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbjDFUVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDFUU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:20:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B39E7290
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680812458; x=1712348458;
  h=from:to:cc:subject:date:message-id;
  bh=/06f2/VoR62Cez76CRiQwmaXi5qrhzhT3GrTHNItenA=;
  b=H6bRMHvmQ5qq6PpvgznXUOjodaWgV4lzMhCy4EyWMDZB3roA+q6C7ZrA
   Whg+cc+PU9/uAntj3SFM5xbQ74HL7cvy49kItALrFhExdEO4d8mcWoOwq
   tBB+bYhbhDEzVrSUdLB3l/qndMEuiZTtT7PIL6XbWGf8tGefCeD2BJfvT
   KAm1YdfiZz5/WxEjOB5SxAvdXOHxy1ZIDVe4Lv2Cajq5+FYnrKbskXupt
   +FpaH1YXD3SBzPpiCkFqg5CwacE8CssCyAEtHozetCzFub+mUFA5FaNBH
   TmUqVCuFmIswe6QstwnIWQE9wfZspZoAKFSoTavEioWqvC1sROC1u7uGE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="407957683"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="407957683"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 13:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="861529862"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="861529862"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga005.jf.intel.com with ESMTP; 06 Apr 2023 13:20:56 -0700
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
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH v4 00/12] sched: Avoid unnecessary migrations within SMT domains
Date:   Thu,  6 Apr 2023 13:31:36 -0700
Message-Id: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is v4 of this series. Previous versions can be found here [1], [2],
and here [3]. To avoid duplication, I do not include the cover letter of
the original submission. You can read it in [1].

This patchset applies cleanly on today's master branch of the tip tree.

Changes since v3:

Nobody liked the proposed changes to the setting of prefer_sibling.
Instead, I tweaked the solution that Dietmar proposed. Now the busiest
group, not the local group, determines the setting of prefer_sibling.

Vincent suggested improvements to the logic to decide whether to follow
asym_packing priorities. Peter suggested to wrap that in a helper function.
I added sched_use_asym_prio().

Ionela found that removing SD_ASYM_PACKING from the SMT domain in x86
rendered sd_asym_packing NULL in SMT cores. Now highest_flag_domain()
does not assume that all child domains have the requested flag.

Tim found that asym_active_balance() needs to also check for the idle
states of the SMT siblings of lb_env::dst_cpu. I added such check.

I wrongly assumed that asym_packing could only be used when the busiest
group had exactly one busy CPU. This broke asym_packing balancing at the
DIE domain. I limited this check to balances between cores at the MC
level.

As per suggestion from Dietmar, I removed sched_asym_smt_can_pull_tasks()
and placed its logic in sched_asym(). Also, sched_asym() uses
sched_smt_active() to skip checks when not needed.

I also added a patch from Chen Yu to enable asym_packing balancing in
Meteor Lake, which has CPUs of different maximum frequency in more than
one die.

Hopefully, these patches are in sufficiently good shape to be merged?

Thank you for your feedback and I look forward to getting more of it!

New patches: 8, 12
Updated patches: 2, 3, 4, 6, 7
Unchanged patches: 1, 5, 9, 10, 11

BR,
Ricardo

[1]. https://lore.kernel.org/lkml/20220825225529.26465-1-ricardo.neri-calderon@linux.intel.com/
[2]. https://lore.kernel.org/lkml/20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com/
[3]. https://lore.kernel.org/lkml/20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com/

Chen Yu (1):
  x86/sched: Add the SD_ASYM_PACKING flag to the die domain of hybrid
    processors

Ricardo Neri (11):
  sched/fair: Move is_core_idle() out of CONFIG_NUMA
  sched/fair: Only do asym_packing load balancing from fully idle SMT
    cores
  sched/fair: Simplify asym_packing logic for SMT cores
  sched/fair: Let low-priority cores help high-priority busy SMT cores
  sched/fair: Keep a fully_busy SMT sched group as busiest
  sched/fair: Use the busiest group to set prefer_sibling
  sched/fair: Do not even the number of busy CPUs via asym_packing
  sched/topology: Check SDF_SHARED_CHILD in highest_flag_domain()
  sched/topology: Remove SHARED_CHILD from ASYM_PACKING
  x86/sched: Remove SD_ASYM_PACKING from the SMT domain flags
  x86/sched/itmt: Give all SMT siblings of a core the same priority

 arch/x86/kernel/itmt.c         |  23 +---
 arch/x86/kernel/smpboot.c      |   4 +-
 include/linux/sched/sd_flags.h |   5 +-
 kernel/sched/fair.c            | 216 +++++++++++++++++----------------
 kernel/sched/sched.h           |  22 +++-
 5 files changed, 138 insertions(+), 132 deletions(-)

-- 
2.25.1

