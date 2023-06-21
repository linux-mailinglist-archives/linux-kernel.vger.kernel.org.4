Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A4D738D50
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjFURkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFURki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:40:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576A8193;
        Wed, 21 Jun 2023 10:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687369237; x=1718905237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zscfrxdAKvIMfClhhYxsHjBzQxOHA2lu7MZycfa8Ovc=;
  b=f2P61yGfx7g1EHBMt8vPLEAelNTGqtjUp9uSEhbXOqkddFd+O7dE7xck
   j6Rm57knvfoGAAD86MCxHmSDkjD6nmq5nILNkRIt78KsW2D22mjFXAivi
   0xzcRvtxT7DvizSWD4gK8YJJ1YlqAEE2xMiVlukkAvvMgsuaQmjQfgwBN
   MD+xyP+bK0lKPKTh1Rq4Ak1gJnemVeSoYoGI708edD22gKcmVMQmz2gX0
   hFvMDTYoUZN540Er4piLuWQf8FoLRpfyCyoZDYL5ZhdElRSRYB5srO5+H
   znctQ7qtR3GhmhtCtkWpz+AWXzkcr5WYo8WyX9IV8MpY3jC/J3ST8/p5L
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="359120493"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="359120493"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:40:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="779921554"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="779921554"
Received: from agluck-desk3.sc.intel.com ([172.25.222.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 10:40:15 -0700
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
Subject: [PATCH v2 0/7] x86/resctrl: Add support for Sub-NUMA cluster (SNC) systems
Date:   Wed, 21 Jun 2023 10:39:59 -0700
Message-Id: <20230621174006.42533-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There isn't a simple hardware enumeration to indicate to software that
a system is running with Sub-NUMA Clustering enabled.

Compare the number of NUMA nodes with the number of L3 caches to calculate
the number of Sub-NUMA nodes per L3 cache.

When Sub-NUMA clustering mode is enabled in BIOS setup, the RMID counters
are distributed equally between the SNC nodes within each socket.

E.g. if there are 400 RMID counters, and the system is configured with
two SNC nodes per socket, then RMID counter 0..199 are used on SNC node
0 on the socket, and RMID counter 200..399 on SNC node 1.

A model specific MSR (0xca0) can change the configuration of the RMIDs
when SNC mode is enabled.

The MSR controls the interpretation of the RMID field in the
IA32_PQR_ASSOC MSR so that the appropriate hardware counters
within the SNC node are updated. If reconfigured from default, RMIDs
 are divided evenly across clusters.
.  

Also initialize a per-cpu RMID offset value. Use this
to calculate the value to write to the IA32_QM_EVTSEL MSR when
reading RMID event values.

N.B. this works well for well-behaved NUMA applications that access
memory predominantly from the local memory node. For applications that
access memory across multiple nodes it may be necessary for the user
to read counters for all SNC nodes on a socket and add the values to
get the actual LLC occupancy or memory bandwidth. Perhaps this isn't
all that different from applications that span across multiple sockets
in a legacy system.

Signed-off-by: Tony Luck <tony.luck@intel.com>

---

Changes since v1:

Re-based to tip/master (on June 21, 2023)

Fenghua:
+ Better comment for l3_mon_evt_init()
+ Don't need .fflags = RFTYPE_RES_MB for node resource. Use .fflags = 0

James:
+ Add helper function to choose resource based on snc_ways
+ Drop the info/snc_ways file. No current justification for it.
+ Typos s/Suffices/Suffixes/, s/Sun-NUMA/Sub-NUMA/
+ Expand SNC acronym on first use in Documentation/x86/resctrl.rst

Peter:
+ Add checks for cpu-less nodes.

Tony Luck (7):
  x86/resctrl: Refactor in preparation for node-scoped resources
  x86/resctrl: Remove hard code of RDT_RESOURCE_L3 in monitor.c
  x86/resctrl: Add a new node-scoped resource to rdt_resources_all[]
  x86/resctrl: Add code to setup monitoring at L3 or NODE scope.
  x86/resctrl: Add package scoped resource
  x86/resctrl: Update documentation with Sub-NUMA cluster changes
  x86/resctrl: Determine if Sub-NUMA Cluster is enabled and initialize.

 Documentation/arch/x86/resctrl.rst        |  10 +-
 include/linux/resctrl.h                   |   5 +-
 arch/x86/include/asm/resctrl.h            |   2 +
 arch/x86/kernel/cpu/resctrl/internal.h    |  20 +++
 arch/x86/kernel/cpu/resctrl/core.c        | 154 ++++++++++++++++++++--
 arch/x86/kernel/cpu/resctrl/monitor.c     |  24 ++--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |   4 +-
 8 files changed, 191 insertions(+), 30 deletions(-)


base-commit: 746d03317c1175666aad909ecc45384da42218aa
-- 
2.40.1

