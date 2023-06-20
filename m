Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97125736234
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 05:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjFTDhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 23:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFTDhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 23:37:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067A7E61
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 20:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687232231; x=1718768231;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s/6FNJ36cpKkGIIN6K6tf6WHqI24nU6huhp3TGsVNG8=;
  b=gMDlpPcfuo/7gTdJBl1U+YZ5bFRtuCEcqH7Ky4wc+Atcsbj8/bt0jdtZ
   //uh3biltm51yNOpwpCS9gJf2fFPgQcGtfDmaoBCrpZNv20jLBnfuxZwl
   Q4Ch6Oc1D56W5cjckPksZgFu00WE0X4e+MynZzMIhAqJyZxln7z/9P4jM
   hr0bxm2v/+9SznnyW4lfMCs2Ai1r2d7sYmDkFrZ8eRDnBO7ma/SJFJGVe
   oRZrItzDT6Sw2gkXwEMHajK1un90uJMEOnln8+9ayPm2Xun6kcjEsOUpU
   /TfGQ/UsvEYn9mnexa/+KIxDzDf+tXDK1FsWl97AXHSx3a21YyV9QCiCK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="344501375"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="344501375"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 20:37:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="717079115"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="717079115"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 20:37:09 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     James Morse <james.morse@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Peter Newman <peternewman@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Nicolas Pitre <npitre@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, aricciardi@baylibre.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [RFC PATCH 0/2] Resctrl - rewrite (WIP)
Date:   Mon, 19 Jun 2023 20:37:00 -0700
Message-Id: <20230620033702.33344-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back in April I posted some RFC patches that added a "driver
registration" interface to the core resctrl code so that additional
resource control and monitor features could be added without further
complicating the core code. Link to that discussion:

https://lore.kernel.org/all/20230420220636.53527-1-tony.luck@intel.com/

Reinette gave the feedback that it would be better to base the module
registration on the resctrl resource structure. Reinette also pointed
me to work from James Morse, and some additional discussion happened
here:

https://lore.kernel.org/all/ZG%2FMZVrWYrCHm%2Ffr@agluck-desk3/

James provided details on where ARM's MPAM has similarities and
differences from the Intel Resource Director Technology and AMD's
similar implementation. Drew Fustini was also pulled into that
conversation to comment on RISC-V CBQRI.

From those discussions I believed we need a do-over on the core
/sys/fs/resctrl implementation to make it friendlier for architecural
variations. Here's what I have so far.

=========================================================================
| N.B. This is a general direction check. There are many obvious        |
| rough edges (e.g. some careful thought needs to happen on locking     |
| for the files in /sys/fs/resctrl that are "owned" by modules that     |
| can be unloaded). I'm mostly looking for feedback from AMD, ARM and   |
| RISCV on whether this is a foundation to build on, whether some small |
| tweaks could make it better, or if this is still going to be really   |
| hard for architectures that have radical divergence from the Intel    |
| model.                                                                |
=========================================================================

First patch is my attempt at architecture neutral code. All mention
of "RDT", "CLOSID" and "RMID" have been expunged. When creating a
new group this code calls arch_alloc_resctrl_ids() to allocate an
opaque "resctrl_ids" value.

Q: I made this a "u64" because that neatly allows storage of both an
x86 CLOSID and RMID (in a handy representation that matches the bit
layout of the Intel IA32_PQR_ASSOC model specific register). If other
architectures need something more complex it could be a "typedef
resctrl_id_t" ... there are a couple of places where we would need
a comparison function.

I broke the code into several source files that handle different
sub-functions of core code to make it easier to navigate. Much of
the code here should look familiar as I did a lot of
s/rdtgroup/resctrl_group/ on functions from the original resctrl
code.

By itself the core code is useless. Cannot even be built as the
controlling Kconfig option "CONFIG_RESCTRL2_FS" must be invoked by
a "select" request from architecture specific code that provides
the necessary "arch_*()" functions to make everything work.

Module registration is handled in fs/resctrl2/resources.c and
can be done before or after mounting /sys/fs/resctrl. Current
code won't let you make any new resource groups until a module
implementing a control function is loaded to supply the information
on how many groups the architecture supports.

Second patch is all the Intel X86 code (with some of the AMD bits
included, but by no means all of them).

I've implemented modules for most of the legacy Intel control
and monitor functions. Many of these share common code (by means
of a symlinked source file ... I couldn't figure out how to make
Kconfig build both rdt_l3_cat.ko and rdt_l3_cdp.ko from the same
source file with a different set of $(CFLAGS)).

Users can pick which features they want by loading modules that
implement the bits they want. E.g. CDP is enabled by loading 
that rdt_l3_cdp.ko module instead of rdt_l3_cat.ko (there's some
code to prevent both being loaded together).

I started on the hooks for the "mba_MBps" feedback from MBM driver,
but in this code drop I just have a simple module that reports the
bandwidth for each group instead of the byte count. I just need to
create a module that has both MBA control and MBM monitoring resources
with a periodic comparison of actual bandwidth with desired, that
then tweaks the MBA controls up/down as needed.

I haven't ventured to read all the pseudo-locking code, but it looks
as though providing the driver with a way to tell core code that a
group is exclusive instead of shared (which tells core code not to
allow assignment of tasks or CPUs to the group) may be all the
surgery needed to core code. The x86 module will be more complex
that the toys I've produced so far, but should be able to leverage
much from the existing resctrl implementation.


Tony Luck (2):
  resctrl2: Add all the generic code
  resctrl2: Arch x86 modules for most of the legacy control/monitor
    functions

 include/linux/resctrl.h                    | 107 +++++
 include/linux/sched.h                      |   3 +
 arch/x86/include/asm/resctrl.h             |  38 ++
 fs/resctrl2/arch/x86/rdt.h                 |  22 +
 fs/resctrl2/internal.h                     | 110 +++++
 arch/x86/kernel/cpu/amd.c                  |   3 +
 arch/x86/kernel/cpu/intel.c                |   3 +
 arch/x86/kernel/process_32.c               |   1 +
 arch/x86/kernel/process_64.c               |   3 +
 fs/resctrl2/arch/x86/alloc.c               | 119 +++++
 fs/resctrl2/arch/x86/rdt_l2_cat.c          |   1 +
 fs/resctrl2/arch/x86/rdt_l2_cdp.c          |   1 +
 fs/resctrl2/arch/x86/rdt_l3_cat.c          | 349 +++++++++++++++
 fs/resctrl2/arch/x86/rdt_l3_cdp.c          |   1 +
 fs/resctrl2/arch/x86/rdt_l3_mba.c          | 251 +++++++++++
 fs/resctrl2/arch/x86/rdt_llc_occupancy.c   | 100 +++++
 fs/resctrl2/arch/x86/rdt_mbm_adjust.c      |  91 ++++
 fs/resctrl2/arch/x86/rdt_mbm_local_bytes.c |   1 +
 fs/resctrl2/arch/x86/rdt_mbm_local_rate.c  |   1 +
 fs/resctrl2/arch/x86/rdt_mbm_total_bytes.c |   1 +
 fs/resctrl2/arch/x86/rdt_mbm_total_rate.c  |   1 +
 fs/resctrl2/arch/x86/rdt_monitor.c         | 491 +++++++++++++++++++++
 fs/resctrl2/cpu.c                          | 315 +++++++++++++
 fs/resctrl2/directory.c                    | 295 +++++++++++++
 fs/resctrl2/domain.c                       |  99 +++++
 fs/resctrl2/info.c                         |  99 +++++
 fs/resctrl2/kernfs.c                       |  58 +++
 fs/resctrl2/locking.c                      |  52 +++
 fs/resctrl2/resources.c                    |  85 ++++
 fs/resctrl2/root.c                         | 173 ++++++++
 fs/resctrl2/schemata.c                     | 110 +++++
 fs/resctrl2/tasks.c                        | 193 ++++++++
 arch/x86/Kconfig                           |  81 +++-
 fs/Kconfig                                 |   1 +
 fs/Makefile                                |   1 +
 fs/resctrl2/Kconfig                        |   5 +
 fs/resctrl2/Makefile                       |  14 +
 fs/resctrl2/arch/x86/Makefile              |  29 ++
 38 files changed, 3306 insertions(+), 2 deletions(-)
 create mode 100644 fs/resctrl2/arch/x86/rdt.h
 create mode 100644 fs/resctrl2/internal.h
 create mode 100644 fs/resctrl2/arch/x86/alloc.c
 create mode 120000 fs/resctrl2/arch/x86/rdt_l2_cat.c
 create mode 120000 fs/resctrl2/arch/x86/rdt_l2_cdp.c
 create mode 100644 fs/resctrl2/arch/x86/rdt_l3_cat.c
 create mode 120000 fs/resctrl2/arch/x86/rdt_l3_cdp.c
 create mode 100644 fs/resctrl2/arch/x86/rdt_l3_mba.c
 create mode 100644 fs/resctrl2/arch/x86/rdt_llc_occupancy.c
 create mode 100644 fs/resctrl2/arch/x86/rdt_mbm_adjust.c
 create mode 120000 fs/resctrl2/arch/x86/rdt_mbm_local_bytes.c
 create mode 120000 fs/resctrl2/arch/x86/rdt_mbm_local_rate.c
 create mode 120000 fs/resctrl2/arch/x86/rdt_mbm_total_bytes.c
 create mode 120000 fs/resctrl2/arch/x86/rdt_mbm_total_rate.c
 create mode 100644 fs/resctrl2/arch/x86/rdt_monitor.c
 create mode 100644 fs/resctrl2/cpu.c
 create mode 100644 fs/resctrl2/directory.c
 create mode 100644 fs/resctrl2/domain.c
 create mode 100644 fs/resctrl2/info.c
 create mode 100644 fs/resctrl2/kernfs.c
 create mode 100644 fs/resctrl2/locking.c
 create mode 100644 fs/resctrl2/resources.c
 create mode 100644 fs/resctrl2/root.c
 create mode 100644 fs/resctrl2/schemata.c
 create mode 100644 fs/resctrl2/tasks.c
 create mode 100644 fs/resctrl2/Kconfig
 create mode 100644 fs/resctrl2/Makefile
 create mode 100644 fs/resctrl2/arch/x86/Makefile


base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
-- 
2.40.1

