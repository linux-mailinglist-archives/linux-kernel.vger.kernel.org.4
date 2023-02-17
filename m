Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2797569B116
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjBQQhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjBQQhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:37:43 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F6A718ED
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676651862; x=1708187862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ble9Qvx//Q2xEWAbJvNGkPJLN/eT48lfTbbNkwkxdrU=;
  b=BNQyYA0pmDNNXNEUNl3lzKBbgrBts8tzwYAp1H9OR2rpjtv/+9xOb/2K
   RGhBbp1tgwGXDqFiPl1QtU71esBr+kERqFAGKKmDSg6Gh0PsCjo1JJWaL
   ttHca0OV2ztpbHU7BdVSpgxtffNP59BTvHBZZmN/yFmf6k8rcA0bDH9sJ
   k3yz34M7Xav5HdyWTfS1fgmG5riOTgEG6IdT83sMPtCZK9S0C1f5DdYHo
   VrN1rDiyxmyeMZaHebA5tnj4NsNCWoqhNdEBfuCol1EQVM/yvqqD94Hy4
   cGxeIF41IRnDJwyVM006vMSdcxY3pMmSvU5on5l+SW/jzGjBwnFqYCfzF
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="311655943"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="311655943"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 08:37:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="670598347"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="670598347"
Received: from hany-desk.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.254.214.18])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 08:37:39 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        zhang.jia@linux.alibaba.com, len.brown@intel.com,
        rui.zhang@intel.com
Subject: [PATCH 1/1] x86/topology: fix erroneous smp_num_siblings on Intel Hybrid platform
Date:   Sat, 18 Feb 2023 00:37:24 +0800
Message-Id: <20230217163724.581513-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230217163724.581513-1-rui.zhang@intel.com>
References: <20230217163724.581513-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMT siblings value returned by CPUID.1F SMT level EBX differs
among CPUs on Intel Hybrid platforms like AlderLake and MeteorLake.
It returns 2 for Pcore CPUs which have SMT siblings and returns 1 for
Ecore CPUs which do not have SMT siblings.

Today, the CPU boot code sets the global variable smp_num_siblings when
every CPU thread is brought up. The last thread to boot will overwrite
it with the number of siblings of *that* thread. That last thread to
boot will "win". If the thread is a Pcore, smp_num_siblings == 2.  If it
is an Ecore, smp_num_siblings == 1.

smp_num_siblings describes if the *system* supports SMT.  It should
specify the maximum number of SMT threads among all cores.

On AlderLake-P/S platforms, it does not cause any functional issues so
far.
But on MeteorLake-P platform, when probing an Ecore CPU,
a). smp_num_siblings varies like AlderLake and it is set to 1 for Ecore.
b). x86_max_cores is totally broken and it is set to 1 for the boot cpu.
Altogether, these two issues make the system being treated as an UP
system in set_cpu_sibling_map() when probing Ecore CPUs, and the Ecore
CPUs are not updated in any cpu sibling maps erroneously.

Below shows part of the CPU topology information before and after the
fix, for both Pcore and Ecore CPU (cpu0 is Pcore, cpu 12 is Ecore).
...
-/sys/devices/system/cpu/cpu0/topology/package_cpus:000fff
-/sys/devices/system/cpu/cpu0/topology/package_cpus_list:0-11
+/sys/devices/system/cpu/cpu0/topology/package_cpus:3fffff
+/sys/devices/system/cpu/cpu0/topology/package_cpus_list:0-21
...
-/sys/devices/system/cpu/cpu12/topology/package_cpus:001000
-/sys/devices/system/cpu/cpu12/topology/package_cpus_list:12
+/sys/devices/system/cpu/cpu12/topology/package_cpus:3fffff
+/sys/devices/system/cpu/cpu12/topology/package_cpus_list:0-21

And this also breaks userspace tools like lscpu
-Core(s) per socket:  1
-Socket(s):           11
+Core(s) per socket:  16
+Socket(s):           1

To fix the first issue, ensure that smp_num_siblings represents the
system-wide maximum number of siblings by always increasing its value.
Never allow it to decrease.

Note that this fix is sufficient to make set_cpu_sibling_map() work
correctly. And how to fix the bogus cpuinfo_x86.x86_max_cores will be
addressed separately.

CC: stable@kernel.org
Suggested-by: Len Brown <len.brown@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/cpu/topology.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 5e868b62a7c4..0270925fe013 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -79,7 +79,7 @@ int detect_extended_topology_early(struct cpuinfo_x86 *c)
 	 * initial apic id, which also represents 32-bit extended x2apic id.
 	 */
 	c->initial_apicid = edx;
-	smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 #endif
 	return 0;
 }
@@ -109,7 +109,8 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	 */
 	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
 	c->initial_apicid = edx;
-	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
+	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
 	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 	die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
 	pkg_mask_width = die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
-- 
2.25.1

