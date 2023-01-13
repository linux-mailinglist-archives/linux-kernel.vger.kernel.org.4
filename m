Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3E466A162
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjAMSBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjAMSBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:01:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C83090E56
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:55:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54739FEC;
        Fri, 13 Jan 2023 09:55:59 -0800 (PST)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC6023F67D;
        Fri, 13 Jan 2023 09:55:14 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com
Subject: [PATCH v2 00/18] x86/resctrl: monitored closid+rmid together, separate arch/fs locking
Date:   Fri, 13 Jan 2023 17:54:41 +0000
Message-Id: <20230113175459.14825-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

(Changes since v1 are noted in each patch)

This series does two things, it changes resctrl to call resctrl_arch_rmid_read()
in a way that works for MPAM, and it separates the locking so that the arch code
and filesystem code don't have to share a mutex. I tried to split this as two
series, but these touch similar call sites, so it would create more work.

(What's MPAM? See the cover letter of the first series. [1])

On x86 the RMID is an independent number. MPAMs equivalent is PMG, but this
isn't an independent number - it extends the PARTID (same as CLOSID) space
with bits that aren't used to select the configuration. The monitors can
then be told to match specific PMG values, allowing monitor-groups to be
created.

But, MPAM expects the monitors to always monitor by PARTID. The
Cache-storage-utilisation counters can only work this way.
(In the MPAM spec not setting the MATCH_PARTID bit is made CONSTRAINED
UNPREDICTABLE - which is Arm's term to mean portable software can't rely on
this)

It gets worse, as some SoCs may have very few PMG bits. I've seen the
datasheet for one that has a single bit of PMG space.

To be usable, MPAM's counters always need the PARTID and the PMG.
For resctrl, this means always making the CLOSID available when the RMID
is used.

To ensure RMID are always unique, this series combines the CLOSID and RMID
into an index, and manages RMID based on that. For x86, the index and RMID
would always be the same.


Currently the architecture specific code in the cpuhp callbacks takes the
rdtgroup_mutex. This means the filesystem code would have to export this
lock, resulting in an ill-defined interface between the two, and the possibility
of cross-architecture lock-ordering head aches.

The second part of this series adds a domain_list_lock to protect writes to the
domain list, and protects the domain list with RCU - or read_cpus_lock().

Use of RCU is to allow lockless readers of the domain list, today resctrl only has
one, rdt_bit_usage_show(). But to get MPAMs monitors working, its very likely
they'll need to be plumbed up to perf. The uncore PMU driver would be a second
lockless reader of the domain list.

This series is based on v6.2-rc3, and can be retrieved from:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/monitors_and_locking/v2

Bugs welcome,


Thanks,

James


[1] https://lore.kernel.org/lkml/20210728170637.25610-1-james.morse@arm.com/
[v1] https://lore.kernel.org/all/20221021131204.5581-1-james.morse@arm.com/

James Morse (18):
  x86/resctrl: Track the closid with the rmid
  x86/resctrl: Access per-rmid structures by index
  x86/resctrl: Create helper for RMID allocation and mondata dir
    creation
  x86/resctrl: Move rmid allocation out of mkdir_rdt_prepare()
  x86/resctrl: Allow RMID allocation to be scoped by CLOSID
  x86/resctrl: Allow the allocator to check if a CLOSID can allocate
    clean RMID
  x86/resctrl: Move CLOSID/RMID matching and setting to use helpers
  x86/resctrl: Queue mon_event_read() instead of sending an IPI
  x86/resctrl: Allow resctrl_arch_rmid_read() to sleep
  x86/resctrl: Allow arch to allocate memory needed in
    resctrl_arch_rmid_read()
  x86/resctrl: Make resctrl_mounted checks explicit
  x86/resctrl: Move alloc/mon static keys into helpers
  x86/resctrl: Make rdt_enable_key the arch's decision to switch
  x86/resctrl: Add helpers for system wide mon/alloc capable
  x86/resctrl: Add cpu online callback for resctrl work
  x86/resctrl: Allow overflow/limbo handlers to be scheduled on any-but
    cpu
  x86/resctrl: Add cpu offline callback for resctrl work
  x86/resctrl: Separate arch and fs resctrl locks

 arch/x86/include/asm/resctrl.h            |  90 ++++++
 arch/x86/kernel/cpu/resctrl/core.c        |  71 ++---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  19 +-
 arch/x86/kernel/cpu/resctrl/internal.h    |  24 +-
 arch/x86/kernel/cpu/resctrl/monitor.c     | 342 ++++++++++++++++------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  15 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 297 +++++++++++++------
 include/linux/resctrl.h                   |  15 +-
 8 files changed, 637 insertions(+), 236 deletions(-)

-- 
2.30.2

