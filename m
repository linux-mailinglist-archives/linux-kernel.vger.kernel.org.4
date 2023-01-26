Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C64B67D483
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjAZSmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjAZSmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:42:33 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B312C3EFC6;
        Thu, 26 Jan 2023 10:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674758551; x=1706294551;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S3DfwWWHVjW08Y4Sj57WtWmKbuBdHRvdkYJVizXcOyE=;
  b=aH5mUwCy+ipIhItezfxNJ9gWnOXNs/oI/sAqRuUUicTwGa33Uq+ocIF/
   yqXnlRUp0tmGEzvH/WjWr3QzFoHLk1REd+lnko0ADcJM9aknRv9sdIrM/
   8yQuCtkSyf4hpc5HzhgH6ltCdW4FlUnjQ/8mQmZGyeKGsUdKewi4Hua/c
   DPVJaSgDXxI5k7PlmSPiHBrO+v0GF3dhHyCGWfkZSJ2G/bz8+dcGlDRPj
   YHfzgflN0xxHxjmxVSUyEKvLvaAiM0BmaIxpwcRiVez14tYNli6eNIU2M
   e74EUMj9i+16SRuGbHpawiswFNBGnYK6rOY4/Z354NJUJU71hydAyFMdb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="354203308"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="354203308"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 10:42:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="991745435"
X-IronPort-AV: E=Sophos;i="5.97,249,1669104000"; 
   d="scan'208";a="991745435"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2023 10:42:05 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 0/7] x86/resctrl: Add support for Sub-NUMA cluster (SNC) systems
Date:   Thu, 26 Jan 2023 10:41:50 -0800
Message-Id: <20230126184157.27626-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.39.1
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

Intel server systems starting with Skylake support a mode that logically
partitions each socket. E.g. when partitioned two ways, half the cores,
L3 cache, and memory controllers are allocated to each of the partitions.
This may reduce average latency to access L3 cache and memory, with the
tradeoff that only half the L3 cache is available for subnode-local memory
access.

The existing Linux resctrl system mishandles RDT monitoring on systems
with SNC mode enabled.

But, with some simple changes, this can be fixed. When SNC mode is
enabled, the RDT RMID counters are also partitioned with the low numbered
counters going to the first partition, and the high numbered counters
to the second partition[1]. The key is to adjust the RMID value written
to the IA32_PQR_ASSOC MSR on context switch, and the value written to
the IA32_QM_EVTSEL when reading out counters, and to change the scaling
factor that was read from CPUID(0xf,1).EBX

E.g. in 2-way Sub-NUMA cluster with 200 RMID counters there are only
100 available counters to the resctrl code. When running on the first
SNC node RMID values 0..99 are used as before. But when running on the
second node, a task that is assigned resctrl rmid=10 must load 10+100
into IA32_PQR_ASSOC to use RMID counter 110.

There should be no changes to functionality on other architectures,
or on Intel systems with SNC disabled, where snc_ways == 1.

-Tony

[1] Some systems also support a 4-way split. All the above still
applies, just need to account for cores, cache, memory controllers
and RMID counters being divided four ways instead of two.

Tony Luck (7):
  x86/resctrl: Refactor in preparation for node-scoped resources
  x86/resctrl: Remove hard code of RDT_RESOURCE_L3 in monitor.c
  x86/resctrl: Add a new node-scoped resource to rdt_resources_all[]
  x86/resctrl: Add code to setup monitoring at L3 or NODE scope.
  x86/resctrl: Add a new "snc_ways" file to the monitoring info
    directory.
  x86/resctrl: Update documentation with Sub-NUMA cluster changes
  x86/resctrl: Determine if Sub-NUMA Cluster is enabled and initialize.

 Documentation/x86/resctrl.rst             | 15 +++-
 include/linux/resctrl.h                   |  4 +-
 arch/x86/include/asm/resctrl.h            |  4 +-
 arch/x86/kernel/cpu/resctrl/internal.h    |  9 +++
 arch/x86/kernel/cpu/resctrl/core.c        | 83 ++++++++++++++++++++---
 arch/x86/kernel/cpu/resctrl/monitor.c     | 24 ++++---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 22 +++++-
 8 files changed, 136 insertions(+), 27 deletions(-)

-- 
2.39.1

