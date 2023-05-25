Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1CC7112E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbjEYRxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjEYRxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:53:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCF597;
        Thu, 25 May 2023 10:53:40 -0700 (PDT)
Date:   Thu, 25 May 2023 17:53:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685037218;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oZIJ944O+77XG1tBqABBNpbuyoFIQ90Ml03G5VCwmns=;
        b=gcztliWmrO0p2gx6UtKjkH7IoiB7JNVSeXzrBOCqz2fWCdOUY4km7OsO3SkyqaDtPvpmzo
        O0BEGk3Xicx2z/gaAKr/CtZiMfN2UnEtdHgrPRBrogvkBZkqDTdnkzqX1FVye10jVfUIxF
        j4ODaiIEhEkWSUdSpCXpaGIHwN6XhEiV37PHFdXHqcgoZIz0UsTc45mohV+le2AsMWhAr9
        rfSYfNlcw100NFmhn57a68vEmXw/0FPVntNbwxVAigg9tpnajdxVF7ZJYV3ytGOSRLvA1s
        sZ68wZ23Bb5zrwT6D/Q6gprKh2nTuaw1fGbF+u7RR7H+NXQdSvZ03HxwOnfcbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685037218;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=oZIJ944O+77XG1tBqABBNpbuyoFIQ90Ml03G5VCwmns=;
        b=9cOE9CF6lPkY7Mj+jwqaRToW+EgMt0Lvrfcn9Dj9fBo61OxdKjBLJUPQMFf/POZNpIXUT9
        4eijTwSdRATS0mDQ==
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
Message-ID: <168503721832.404.4706329081986329618.tip-bot2@tip-bot2>
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

Commit-ID:     edc0a2b5957652f4685ef3516f519f84807087db
Gitweb:        https://git.kernel.org/tip/edc0a2b5957652f4685ef3516f519f84807087db
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Thu, 23 Mar 2023 09:56:40 +08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 25 May 2023 10:48:42 -07:00

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

Notice that the "before" 'package_cpus_list' has only one CPU.  This
means that userspace tools like lscpu will see a little laptop like
an 11-socket system:

-Core(s) per socket:  1
-Socket(s):           11
+Core(s) per socket:  16
+Socket(s):           1

This is also expected to make the scheduler do rather wonky things
too.

[ dhansen: remove CPUID detail from changelog, add end user effects ]

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
