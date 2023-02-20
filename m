Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A2F69C480
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 04:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjBTD3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 22:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjBTD3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 22:29:17 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E1DEB59
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 19:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676863756; x=1708399756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OVq9oAd5QD0ENighwhiYLDkNS/J1VuFUQxbIz93W3Ew=;
  b=Y1wpXkfUb/xNy5z71Dk+xjv4ctUrOISHHy1UDIOCLTPSfrBSTD/6+WWF
   DjobiUZPgVXpPTCj3blh/JM1nooS3wtLPEM/997/uYe0M5UJmienOiOPi
   SigEr1VHXN1BUvcZusET99XDeRrscHg8jj17PSS4XyW7cDy+iQvzJoMx/
   W4h1zezSKuf05sJiqCpKbuD/iM7eNIsDsRDwhyVefPN9g4UJ0ldQeMWxQ
   tlH1B63i3eZ0NIoXmKRuwXlJuEzQRq0tfBhovrS4w4MBpa4sNhYC7MIIq
   P1+kPop7rFY85G4pCE9pSsX343gNkDZRtBVvhIeFM4ogFpUhwZdlgL+cT
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="418537681"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="418537681"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 19:29:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="813986517"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000"; 
   d="scan'208";a="813986517"
Received: from cyi-mobl.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.255.29.242])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2023 19:29:13 -0800
From:   Zhang Rui <rui.zhang@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        zhang.jia@linux.alibaba.com, len.brown@intel.com,
        rui.zhang@intel.com
Subject: [PATCH V2 1/1] x86/topology: fix erroneous smp_num_siblings on Intel Hybrid platform
Date:   Mon, 20 Feb 2023 11:28:56 +0800
Message-Id: <20230220032856.661884-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230220032856.661884-1-rui.zhang@intel.com>
References: <20230220032856.661884-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Ensure that smp_num_siblings represents the system-wide maximum number
of siblings by always increasing its value. Never allow it to decrease.

On MeteorLake-P platform, this fixes a problem that the Ecore CPUs are
not updated in any cpu sibling map because the system is treated as an
UP system when probing Ecore CPUs.

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

