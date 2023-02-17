Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7FF69B115
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjBQQhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBQQhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:37:39 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A8161AE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676651857; x=1708187857;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D6Orv75NqJyAAXLfMKOLHKPKyxSEy35VbIvTb0A7lhw=;
  b=cWFehKXqkCToxliiwLC2n10YF2CVTgmA5eqIjj4Y/V/3v2+cOUV1ourz
   33x4noVxIgtaGKzGaxWsZoVGcoIAM3bxu0W6oayUXCfNAHS4TytWzDSZK
   st1+/H77Mi37oWcn4fcXK/L2lPNPqtdvAtkWxbKlGSdtNDtEH3A0T/oFn
   o2tG/CKuJZe8HxBgrMoo7IDTwE1Z24r2+/ZQGbF86uJ8pJR9XcH13Tk8p
   2PzC5vNr6Fkzxd9i7F949cr2eJ29bcELGntgJ6lqsBRhFqvdOjKmDokuQ
   NQ7xUVxdSPzdu0bFpH7QVj7/8iPmlLk6KJVqhVx3gFWoXkKAPg/ggF8wY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="311655934"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="311655934"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 08:37:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="670598338"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="670598338"
Received: from hany-desk.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.254.214.18])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 08:37:34 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        zhang.jia@linux.alibaba.com, len.brown@intel.com,
        rui.zhang@intel.com
Subject: [RFC PATCH 0/1] x86: cpu topology fix and question on x86_max_cores
Date:   Sat, 18 Feb 2023 00:37:23 +0800
Message-Id: <20230217163724.581513-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
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

Hi, All,

There are two kernel issues observed on Intel Hybrid platform named
MeteorLake. And these two issues altogether bring broken CPU topology.

This patch series aims to
1. provide a solution for the first issue, as an urgent fix and -stable
   candidate, so that this problem is not exposed to end users.
2. get feedback on how to fix the second issue.

Any comments on this are really appreciated.

Problem details on MeteorLake
-----------------------------

On Intel Hybrid platforms like AlderLake-P/S, both smp_num_siblings
and cpuinfo_x86.x86_max_cores are broken like below
 
[    0.201005] detect_extended_topology: CPU APICID 0x0, smp_num_siblings 2, x86_max_cores 10
[    0.201117] start_kernel->check_bugs->cpu_smt_check_topology: smp_num_siblings 2
...
[    0.010146] detect_extended_topology: CPU APICID 0x8, smp_num_siblings 2, x86_max_cores 10
...
[    0.010146] detect_extended_topology: CPU APICID 0x39, smp_num_siblings 2, x86_max_cores 10
[    0.010146] detect_extended_topology: CPU APICID 0x48, smp_num_siblings 1, x86_max_cores 20
...
[    0.010146] detect_extended_topology: CPU APICID 0x4e, smp_num_siblings 1, x86_max_cores 20
[    2.583800] sched_set_itmt_core_prio: smp_num_siblings 1

This is because the SMT siblings value returned by CPUID.1F SMT level
EBX differs among CPUs. It returns 2 for Pcore CPUs which have HT
sibling and returns 1 for Ecore CPUs which do not have SMT sibling.

This brings several potential issues:
1. some kernel configuration like cpu_smt_control, as set in
   start_kernel()->check_bugs()->cpu_smt_check_topology(), depends on
   smp_num_siblings set by boot cpu.
   It is pure luck that all the current hybrid platforms use Pcore as cpu0
   and hide this problem.
2. some per CPU data like cpuinfo_x86.x86_max_cores that depends on
   smp_num_siblings becomes inconsistent and bogus.
3. the final smp_num_siblings value after boot depends on the last CPU
   enumerated, which could either be Pcore or Ecore CPU.

Previously, there is no functional issue observed on AlderLake-P/S.

However, on MeteorLake, this becomes worse.
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

Solution for fix smp_num_sibling
--------------------------------

Patch 1/1 ensures that smp_num_siblings represents the system-wide maximum
number of siblings by always increasing its value. Never allow it to
decrease.

It is sufficient to make the problem go away.

However, there is a pontenial problem left. That is, when boot CPU is an
Ecore CPU, smp_num_sibling is set to 1 during BSP probe, kernel disables
SMT support by setting cpu_smt_control to CPU_SMT_NOT_SUPPORTED in
start_kernel()->check_bugs()->cpu_smt_check_topology().
So far, we don't have such platforms.

Questions on how to fix cpuinfo_x86.x86_max_cores
-------------------------------------------------

Fixing x86_max_cores is more complex. Current kernel uses below logic to
get x86_max_cores
	x86_max_cores = cpus_in_a_package / smp_num_siblings
But
1. There is a known bug in CPUID.1F handling code. Thus cpus_in_a_package
   can be bogus. To fix it, I will add CPUID.1F Module level support.
2. x86_max_cores is set and used in an inconsistent way in current kernel.
   In short, smp_num_siblings/x86_max_cores
   2.1 represents the number of maximum *addressable* threads/cores in a
       core/package when retrieved via CPUID 1 and 4 on old platforms.
       CPUID.1 EBX 23:16 "Maximum number of addressable IDs for logical
       processors in this physical package".
       CPUID.4 EAX 31:26 "Maximum number of addressable IDs for processor
       cores in the physical package".
   2.2 represents the number of maximum *possible* threads/cores in a
       core/package, when retrieved via CPUID.B/1F on non-Hybrid platforms.
       CPUID.B/1F EBX 15:0 "Number of logical processors at this level type.
       The number reflects configuration as shipped by Intel".
       For example, in calc_llc_size_per_core()
          do_div(llc_size, c->x86_max_cores);
       x86_max_cores is used as the max *possible* cores in a package.
   2.3 is used in a conflict way on other vendors like AMD by checking the
       code. I need help on confirming the proper behavior for AMD.
       For example, in amd_get_topology(),
          c->x86_coreid_bits = get_count_order(c->x86_max_cores);
       x86_max_cores is used as the max *addressable* cores in a package.
       in get_nbc_for_node(),
          cores_per_node = (c->x86_max_cores * smp_num_siblings) / amd_get_nodes_per_socket();
       x86_max_cores is used as the max *possible* cores in a package.
3. using
      x86_max_cores = cpus_in_a_package / smp_num_siblings
   to get the number of maximum *possible* cores in a package during boot
   cpu bringup is not applicable on platforms with asymmetric cores.
   Because, for a given number of threads, we don't know how many of the
   threads are the master thread or the only thread of a core, and how
   many of them are SMT siblings.
   For example, on a platform with 6 Pcore and 8 Ecore, there are 20
   threads. But setting x86_max_cores to 10 is apparently wrong.

Given the above situation, I have below question and any input is really
appreciated.

Is this inconsistency a problem or not?

If we want to keep it consistent, it has to represent the max
*addressable* cores in a package. Because max *possible* cores in a
package is not available on Intel Hybrid platform.

I have proposed a patch for this purpose, but gave up because I didn't
address the above scenarios that uses x86_max_core differently.
https://lore.kernel.org/all/20220922133800.12918-7-rui.zhang@intel.com/

Does this break the expectation on AMD platforms using CPUID.B?
If yes, what should we do?

BTW, this also fixes the potential issue that kernel runs as SMT disabled
when cpu0 is a Ecore cpu.

The downside is that, on a platform that does not have SMT, like
AlderLake-N, which has Ecore CPUs only, kernel will still run as
SMT-capable with this solution. Because SMT ID still takes 1 bit in
APIC-ID and smp_num_siblings is set to 2. But given that kernel has
already optimized for non-SMT case at runtime in places like scheduler,
by checking sibling maps, so my current understanding is that the overhead
won't be big.

thanks,
rui
