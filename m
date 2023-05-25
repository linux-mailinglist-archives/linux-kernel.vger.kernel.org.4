Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468C87111AB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbjEYRIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238954AbjEYRIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:08:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB15B6;
        Thu, 25 May 2023 10:08:14 -0700 (PDT)
Date:   Thu, 25 May 2023 17:08:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685034491;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PqN7pZM5Ne2hSJTJYt7bvR5U0D9tiJx20qbHFDDiomM=;
        b=M29zIeZPAeEIFUsGdpk+pnVeFO5Sp0da+exV0FRHweaoDcU8rhgdzgxdlP3FOJ8ZBgXJ1x
        Req8nvBNtbz1mVeWr5Geig6Ij/fAGp+M64fAYVwULIk4pJJI3POnr900qWhPH7Sy9xSFX6
        pCb11YCcf9HHXWh8LNqAwdseDUihP+QQIRhjfO8z6/O1Dn/uhwiShgW934vkDo4I0Cg7qL
        l5ATdjRFM5s6ceotC7MyFW/wpLtZFtf1kLVT9GXApSBUhnELBr5LYt7mXP64YuUjxW3WQr
        GKgT1mJyEwI0ASsUlqY+wDI/xs/zrvNLvPLBqOrfg1318qwb9CFbL+4kK/7CQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685034491;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=PqN7pZM5Ne2hSJTJYt7bvR5U0D9tiJx20qbHFDDiomM=;
        b=xIi/eEuAIM1piVbikJx5cBm6dVfZd866mZ0MmtMMw9gEplXQXsp4+b+Eo8Qjk/yVf1RbU/
        aztFtz2B95QXqnCA==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/topology: Fix erroneous smp_num_siblings on
 Intel Hybrid platforms
Cc:     Len Brown <len.brown@intel.com>, Zhang Rui <rui.zhang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168503449068.404.11918466864756004526.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     55f63fd6d4cfcaf2f5fc385bf7a80c459fe1d165
Gitweb:        https://git.kernel.org/tip/55f63fd6d4cfcaf2f5fc385bf7a80c459fe1d165
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Thu, 23 Mar 2023 09:56:40 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 25 May 2023 10:03:03 -07:00

x86/topology: Fix erroneous smp_num_siblings on Intel Hybrid platforms

Traditionally, all CPUs in a system have identical numbers of SMT
siblings.  That changes with hybrid processors where some logical CPUs
have a sibling and others have none.

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

[ dhansen: remove CPUID detail from changelog ]

CC: stable@kernel.org
Fixes: bbb65d2d365e ("x86: use cpuid vector 0xb when available for detecting cpu topology")
Fixes: 95f3d39ccf7a ("x86/cpu/topology: Provide detect_extended_topology_early()")
Suggested-by: Len Brown <len.brown@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20230323015640.27906-1-rui.zhang%40intel.com
---
 arch/x86/kernel/cpu/topology.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 5e868b6..0270925 100644
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
