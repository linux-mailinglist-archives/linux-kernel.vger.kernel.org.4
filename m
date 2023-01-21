Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0A56766D4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 15:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjAUOyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 09:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjAUOyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 09:54:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FC11CF51;
        Sat, 21 Jan 2023 06:54:30 -0800 (PST)
Date:   Sat, 21 Jan 2023 14:54:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674312868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tviks/J/EhGnGES0ZBsMF2sMXoCqvreJDLs4MH673yQ=;
        b=yb1atlKBcMl1eqSIofDTF7QRQ7q2K/wJJkYUog0XbM/nBoZDM+4K+zJ4FqUFEckxDn/8JI
        /aEoRRmihGc23LGTPYZjdFhlRS8axGGMkUGQJ0RvUjLLcWXffjXOXdHNX4CLoS36ZptnKN
        a062ED3twwc980S0sMfBzPqTOsZbZTIBrRnrMq/c42jcPyaKnRvDKdzbEs+ji63dSbTC9k
        frWiXIw1Jm7dHVRk3VZj4Vkn670NysPlgpdh7zgdbxeNmi7zL/3vFtVSykGAcCi5YI4SrT
        dIaOzV67Eyz6G1hlLy8hy6oOLMg1lV3Jy8OpYcfcjJqDhyJ0RSiubV2ygSp7xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674312868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tviks/J/EhGnGES0ZBsMF2sMXoCqvreJDLs4MH673yQ=;
        b=TjjTK32FPOqPxbLTzU/1vK4y7g9ocPSmDtuWbtS5U5JA6x5FrBmdifSRghtRRqFXodddGi
        yTtGWhIxjdxsHMCQ==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Check CPU capabilities after late
 microcode update correctly
Cc:     Ashok Raj <ashok.raj@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230109153555.4986-3-ashok.raj@intel.com>
References: <20230109153555.4986-3-ashok.raj@intel.com>
MIME-Version: 1.0
Message-ID: <167431286848.4906.17390634765238999200.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     c0dd9245aa9e25a697181f6085692272c9ec61bc
Gitweb:        https://git.kernel.org/tip/c0dd9245aa9e25a697181f6085692272c9ec61bc
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Mon, 09 Jan 2023 07:35:51 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 21 Jan 2023 14:53:20 +01:00

x86/microcode: Check CPU capabilities after late microcode update correctly

The kernel caches each CPU's feature bits at boot in an x86_capability[]
structure. However, the capabilities in the BSP's copy can be turned off
as a result of certain command line parameters or configuration
restrictions, for example the SGX bit. This can cause a mismatch when
comparing the values before and after the microcode update.

Another example is X86_FEATURE_SRBDS_CTRL which gets added only after
microcode update:

  --- cpuid.before	2023-01-21 14:54:15.652000747 +0100
  +++ cpuid.after	2023-01-21 14:54:26.632001024 +0100
  @@ -10,7 +10,7 @@ CPU:
      0x00000004 0x04: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
      0x00000005 0x00: eax=0x00000040 ebx=0x00000040 ecx=0x00000003 edx=0x11142120
      0x00000006 0x00: eax=0x000027f7 ebx=0x00000002 ecx=0x00000001 edx=0x00000000
  -   0x00000007 0x00: eax=0x00000000 ebx=0x029c6fbf ecx=0x40000000 edx=0xbc002400
  +   0x00000007 0x00: eax=0x00000000 ebx=0x029c6fbf ecx=0x40000000 edx=0xbc002e00
  									     ^^^

and which proves for a gazillionth time that late loading is a bad bad
idea.

microcode_check() is called after an update to report any previously
cached CPUID bits which might have changed due to the update.

Therefore, store the cached CPU caps before the update and compare them
with the CPU caps after the microcode update has succeeded.

Thus, the comparison is done between the CPUID *hardware* bits before
and after the upgrade instead of using the cached, possibly runtime
modified values in BSP's boot_cpu_data copy.

As a result, false warnings about CPUID bits changes are avoided.

  [ bp:
  	- Massage.
	- Add SRBDS_CTRL example.
	- Add kernel-doc.
	- Incorporate forgotten review feedback from dhansen.
	]

Fixes: 1008c52c09dc ("x86/CPU: Add a microcode loader callback")
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230109153555.4986-3-ashok.raj@intel.com
---
 arch/x86/include/asm/processor.h     |  1 +-
 arch/x86/kernel/cpu/common.c         | 36 +++++++++++++++++----------
 arch/x86/kernel/cpu/microcode/core.c |  6 +++++-
 3 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index f256a4d..a77dee6 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -698,6 +698,7 @@ bool xen_set_default_idle(void);
 
 void __noreturn stop_this_cpu(void *dummy);
 void microcode_check(struct cpuinfo_x86 *prev_info);
+void store_cpu_caps(struct cpuinfo_x86 *info);
 
 enum l1tf_mitigations {
 	L1TF_MITIGATION_OFF,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0f5a173..5ff73ba 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2298,6 +2298,25 @@ void cpu_init_secondary(void)
 
 #ifdef CONFIG_MICROCODE_LATE_LOADING
 /**
+ * store_cpu_caps() - Store a snapshot of CPU capabilities
+ * @curr_info: Pointer where to store it
+ *
+ * Returns: None
+ */
+void store_cpu_caps(struct cpuinfo_x86 *curr_info)
+{
+	/* Reload CPUID max function as it might've changed. */
+	curr_info->cpuid_level = cpuid_eax(0);
+
+	/* Copy all capability leafs and pick up the synthetic ones. */
+	memcpy(&curr_info->x86_capability, &boot_cpu_data.x86_capability,
+	       sizeof(curr_info->x86_capability));
+
+	/* Get the hardware CPUID leafs */
+	get_cpu_cap(curr_info);
+}
+
+/**
  * microcode_check() - Check if any CPU capabilities changed after an update.
  * @prev_info:	CPU capabilities stored before an update.
  *
@@ -2309,22 +2328,13 @@ void cpu_init_secondary(void)
  */
 void microcode_check(struct cpuinfo_x86 *prev_info)
 {
-	perf_check_microcode();
-
-	/* Reload CPUID max function as it might've changed. */
-	prev_info->cpuid_level = cpuid_eax(0);
+	struct cpuinfo_x86 curr_info;
 
-	/*
-	 * Copy all capability leafs to pick up the synthetic ones so that
-	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
-	 * get overwritten in get_cpu_cap().
-	 */
-	memcpy(&prev_info->x86_capability, &boot_cpu_data.x86_capability,
-	       sizeof(prev_info->x86_capability));
+	perf_check_microcode();
 
-	get_cpu_cap(prev_info);
+	store_cpu_caps(&curr_info);
 
-	if (!memcmp(&prev_info->x86_capability, &boot_cpu_data.x86_capability,
+	if (!memcmp(&prev_info->x86_capability, &curr_info.x86_capability,
 		    sizeof(prev_info->x86_capability)))
 		return;
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index dc5dfba..8ec38c1 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -446,6 +446,12 @@ static int microcode_reload_late(void)
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
+	/*
+	 * Take a snapshot before the microcode update in order to compare and
+	 * check whether any bits changed after an update.
+	 */
+	store_cpu_caps(&prev_info);
+
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
 	if (ret == 0)
 		microcode_check(&prev_info);
