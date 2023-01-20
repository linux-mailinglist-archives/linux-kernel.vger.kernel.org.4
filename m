Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629276759BF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjATQTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjATQTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:19:42 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB117EE4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674231581; x=1705767581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hW/mmXgPQePcN9cL5PTH19NmnMicaiGlNPe23TbIMaw=;
  b=mTaCr0s2hXTtgqShq53vdSEki0tHmt2u0+v66aukOIPrlXjZDLLEJszM
   O+Pr+XDZ6hDqcR0HIwd1eOlk5UPE7UNldnkv8V8E8sCqfKMvtZfSUoCqi
   bmY8akH3GDDKSQ4Pj9vfiX6DpyjeJj6Z3nuI80/W0nLocp+6Wrc3J59kh
   i3FunUBdZcnnQ04rTaJ5oMdz624nVsu4kgyPg0UaU7gLAaJBQehwqTDMb
   I18QmbuKTrdCpPCTrjghPEIWIPR0sKtXK58eKmCTFIX/E/AWPuY/4ps0e
   4cn1Gt2ibHZ66MXHmVa0z0miG7p9rMIH+oiCig+xy8i3n2pclco9IC3Mu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="411846562"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="411846562"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 08:19:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="653836369"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="653836369"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 08:19:37 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [Patch v5 2/5] x86/microcode/core: Take a snapshot before and after applying microcode
Date:   Fri, 20 Jan 2023 08:19:20 -0800
Message-Id: <20230120161923.118882-3-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120161923.118882-1-ashok.raj@intel.com>
References: <20230120161923.118882-1-ashok.raj@intel.com>
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

The kernel caches features about each CPU's features at boot in an
x86_capability[] structure. The microcode update takes one snapshot and
compares it with the saved copy at boot.

However, the capabilities in the boot copy can be turned off as a result of
certain command line parameters or configuration restrictions. This can
cause a mismatch when comparing the values before and after the microcode
update.

microcode_check() is called after an update to report any previously
cached CPUID bits might have changed due to the update.

store_cpu_caps() basically stores the original CPU reported
values and not the OS modified values. This will avoid giving a false
warning even when no capabilities have changed.

Ignore the capabilities recorded at boot. Take a new snapshot before the
update and compare with a snapshot after the update to eliminate the false
warning.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Fixes: 1008c52c09dc ("x86/CPU: Add a microcode loader callback")
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: x86 <x86@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner (Intel) <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Stefan Talpalaru <stefantalpalaru@yahoo.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Peter Zilstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
Changes since V3:
- Boris
	- Change function from microcode_store_cpu_caps -> store_cpu_caps
	- Split comments in store_cpu_caps().

- Dave Hansen
	- Change parameters names to something meaninful.
	- Cleaned up some commit log.

Changes since V2:

- Boris
	- Keep microcode_check() inside cpu/common.c and not bleed
	  get_cpu_caps() outside of core code.

- Thomas
	- Commit log changes.
---
 arch/x86/include/asm/processor.h     |  1 +
 arch/x86/kernel/cpu/common.c         | 39 ++++++++++++++++++++--------
 arch/x86/kernel/cpu/microcode/core.c |  7 +++++
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index f256a4ddd25d..a77dee6a2bf2 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -698,6 +698,7 @@ bool xen_set_default_idle(void);
 
 void __noreturn stop_this_cpu(void *dummy);
 void microcode_check(struct cpuinfo_x86 *prev_info);
+void store_cpu_caps(struct cpuinfo_x86 *info);
 
 enum l1tf_mitigations {
 	L1TF_MITIGATION_OFF,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0f5a173d0871..f5c6feed6c26 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2297,6 +2297,29 @@ void cpu_init_secondary(void)
 #endif
 
 #ifdef CONFIG_MICROCODE_LATE_LOADING
+/**
+ * store_cpu_caps() - Store a snapshot of CPU capabilities
+ *
+ * Returns: None
+ */
+void store_cpu_caps(struct cpuinfo_x86 *curr_info)
+{
+	/* Reload CPUID max function as it might've changed. */
+	curr_info->cpuid_level = cpuid_eax(0);
+
+	/*
+	 * Copy all capability leafs to pick up the synthetic ones
+	 */
+	memcpy(&curr_info->x86_capability, &boot_cpu_data.x86_capability,
+	       sizeof(curr_info->x86_capability));
+
+	/*
+	 * Capabilities copied from BSP will get overwritten
+	 * with the snapshot below
+	 */
+	get_cpu_cap(curr_info);
+}
+
 /**
  * microcode_check() - Check if any CPU capabilities changed after an update.
  * @prev_info:	CPU capabilities stored before an update.
@@ -2309,22 +2332,16 @@ void cpu_init_secondary(void)
  */
 void microcode_check(struct cpuinfo_x86 *prev_info)
 {
-	perf_check_microcode();
+	struct cpuinfo_x86 curr_info;
 
-	/* Reload CPUID max function as it might've changed. */
-	prev_info->cpuid_level = cpuid_eax(0);
+	perf_check_microcode();
 
 	/*
-	 * Copy all capability leafs to pick up the synthetic ones so that
-	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
-	 * get overwritten in get_cpu_cap().
+	 * Get a snapshot of CPU capabilities
 	 */
-	memcpy(&prev_info->x86_capability, &boot_cpu_data.x86_capability,
-	       sizeof(prev_info->x86_capability));
-
-	get_cpu_cap(prev_info);
+	store_cpu_caps(&curr_info);
 
-	if (!memcmp(&prev_info->x86_capability, &boot_cpu_data.x86_capability,
+	if (!memcmp(&prev_info->x86_capability, &curr_info.x86_capability,
 		    sizeof(prev_info->x86_capability)))
 		return;
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index e39d83be794b..bb943a91a364 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -447,6 +447,13 @@ static int microcode_reload_late(void)
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
+	/*
+	 * Take a snapshot before the microcode update, so we can compare
+	 * them after the update is successful to check for any bits
+	 * changed.
+	 */
+	store_cpu_caps(&prev_info);
+
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
 	if (ret == 0)
 		microcode_check(&prev_info);
-- 
2.34.1

