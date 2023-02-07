Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDC168CE59
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjBGEut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBGEur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:50:47 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90E3D3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675745445; x=1707281445;
  h=from:to:cc:subject:date:message-id;
  bh=7GgVi6GPMAG8QUql3A3GPf6CEBkQu2TkL/xf7cGOBbc=;
  b=XWhu1K9W7toK7evthc3s9YCiRyU9PzdlnrxK9aIedxnDKBgHkZmsNBdo
   PvcKvjAGIUofKm7uLx6BsQutbm+ilBwFvocAWnEAH/Ljt6JlGO/3YSRcH
   qaDbb/7m/Ig2iBKYtFJJtLJO85yrvJfuSeMT9ho98AKBSwi8gl8T6Xypy
   fcjl3nlVpgAvCInkwLv9v84uaWQVOryZwVIzMgGFnAC85y1hV+l3wcwI2
   OakzkD/RW8ezvYqHD/n7WMDUhd2YhClizC3CjHCtYTL6/XFAW9RAk38NG
   1RqHx4Uba8lr8m8h9PGajtgKC5poFww09cKlABAwWKAGlYz3tEynkMicM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="415623967"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="415623967"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 20:50:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="668653775"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="668653775"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Feb 2023 20:50:45 -0800
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
Subject: [PATCH v3 00/10] sched/fair: Avoid unnecessary migrations within SMT domains
Date:   Mon,  6 Feb 2023 20:58:28 -0800
Message-Id: <20230207045838.11243-1-ricardo.neri-calderon@linux.intel.com>
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

This is v3 of this series. Previous versions can be found here [1] and
here [2]. To avoid duplication, I do not include the cover letter of the
original submission. You can read it in [1].

Changes since v2:

Vincent correctly indicated that I was abusing asym_packing to force load
balances unrelated to CPU priority. The underlying issue is that the
scheduler cannot not handle load balances between SMT and non-SMT cores
correctly. I added several prework patches to fix it... and I removed the
abuse of asym_packing.

Dietmar helped me to realize that there is a better way to check the idle
state of SMT cores. Now I give the task to the scheduler instead of
architecture-specific overrides. I unconditionally obey CPU priorities
at the SMT level. This keeps Power7 happy. At upper levels (i.e., when
balancing load between cores) the scheduler also considers the idle state
of the core in addition to CPU priority. This satisfies x86.

Ionela spotted a violation of the scheduler topology sanity checks. We did
not find a check that suits both Power7 and x86. For now, I removed the
NEEDS_CHILD flag of SD_ASYM_PACKING.

Hopefully, these patches are in sufficiently good shape to be merged.

Thank you for your feedback and I look forward to getting more of it!

New patches 2, 3, 4, 5, 6, 7, 8
Updated patches: 1
Unchanged patches: 9, 10

BR,
Ricardo

[1]. https://lore.kernel.org/lkml/20220825225529.26465-1-ricardo.neri-calderon@linux.intel.com/
[2]. https://lore.kernel.org/lkml/20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com/


Ricardo Neri (10):
  sched/fair: Generalize asym_packing logic for SMT cores
  sched/fair: Move is_core_idle() out of CONFIG_NUMA
  sched/fair: Only do asym_packing load balancing from fully idle SMT
    cores
  sched/fair: Let low-priority cores help high-priority busy SMT cores
  sched/fair: Keep a fully_busy SMT sched group as busiest
  sched/fair: Use the prefer_sibling flag of the current sched domain
  sched/fair: Do not even the number of busy CPUs via asym_packing
  sched/topology: Remove SHARED_CHILD from ASYM_PACKING
  x86/sched: Remove SD_ASYM_PACKING from the SMT domain flags
  x86/sched/itmt: Give all SMT siblings of a core the same priority

 arch/x86/kernel/itmt.c         |  23 +----
 arch/x86/kernel/smpboot.c      |   2 +-
 include/linux/sched/sd_flags.h |   5 +-
 kernel/sched/fair.c            | 175 +++++++++++++++++----------------
 4 files changed, 99 insertions(+), 106 deletions(-)

-- 
2.25.1

