Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0727656E42
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiL0TYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiL0TX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:23:56 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6A27655
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672169035; x=1703705035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mmKFDsVIHTIc0c7YKddPATrNwY7UmiRaXdv65jV60NA=;
  b=OZVPXAt1n324jZ+5cnLuP1qxJkQgfwKmgYUfP+mMy9OwG+TKGQLRTt9v
   Ly3V76P2NDBWx94xPDedxO75pU0XBuGWhWVwDjxI6li1M7Wcpi+/3P5mU
   k4mmjPlZCo02LNMLxKIqx0j/SH7qSLcJ5ZnbimnoGB2dHMDWUkRUNkohr
   a2BzC9L5zGuqvjVlivpzGHnunlLAuTdtQn3Nb+/jN1vvanzpeYLlP2dr3
   atWtg7+GqJDFAc4TWf4KAIFuwKlPMRit9Ylqp/wl5cz2emcRLb7HOT5d1
   bum7TH5dLkXw18PpK5K6ofkccPtQuQ9JVXtB3eQtqTYspPOhyIaIBeDw8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="407011166"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="407011166"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 11:23:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="777234194"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="777234194"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 11:23:54 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v2 2/6] x86/microcode/core: Take a snapshot before and after applying microcode
Date:   Tue, 27 Dec 2022 11:23:36 -0800
Message-Id: <20221227192340.8358-3-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221227192340.8358-1-ashok.raj@intel.com>
References: <20221227192340.8358-1-ashok.raj@intel.com>
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

store_cpu_caps() basically stores the original CPU reported values and not
the OS modified values. This will avoid giving a false warning even if no
capabilities have changed.

Ignore the capabilities recorded at boot. Take a new snapshot before the
update and compare with a snapshot after the update to eliminate the false
warning.

Fixes: 1008c52c09dc ("x86/CPU: Add a microcode loader callback")
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: x86 <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
---
Changes since last post

- Boris  : Change function from copy_cpu_caps() -> store_cpu_caps()
- Thomas : Commit log changes.
---
 arch/x86/kernel/cpu/microcode/core.c | 42 +++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 0051ebf7c53e..e2cdf3e989e7 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -432,12 +432,28 @@ static int __reload_late(void *info)
 	return ret;
 }
 
+static void store_cpu_caps(struct cpuinfo_x86 *info)
+{
+	/* Reload CPUID max function as it might've changed. */
+	info->cpuid_level = cpuid_eax(0);
+
+	/*
+	 * Copy all capability leafs to pick up the synthetic ones so that
+	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
+	 * get overwritten in get_cpu_cap().
+	 */
+	memcpy(info->x86_capability, &boot_cpu_data.x86_capability,
+	       sizeof(info->x86_capability));
+
+	get_cpu_cap(info);
+}
+
 /*
  * The microcode loader calls this upon late microcode load to recheck features,
  * only when microcode has been updated. Caller holds microcode_mutex and CPU
  * hotplug lock.
  */
-static void microcode_check(void)
+static void microcode_check(struct cpuinfo_x86 *orig)
 {
 	struct cpuinfo_x86 info;
 
@@ -447,15 +463,13 @@ static void microcode_check(void)
 	info.cpuid_level = cpuid_eax(0);
 
 	/*
-	 * Copy all capability leafs to pick up the synthetic ones so that
-	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
-	 * get overwritten in get_cpu_cap().
-	 */
-	memcpy(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability));
+	* Copy all capability leafs to pick up the synthetic ones so that
+	* memcmp() below doesn't fail on that. The ones coming from CPUID will
+	* get overwritten in get_cpu_cap().
+	*/
+	store_cpu_caps(&info);
 
-	get_cpu_cap(&info);
-
-	if (!memcmp(&info.x86_capability, &boot_cpu_data.x86_capability,
+	if (!memcmp(&info.x86_capability, &orig->x86_capability,
 		    sizeof(info.x86_capability)))
 		return;
 
@@ -470,6 +484,7 @@ static void microcode_check(void)
 static int microcode_reload_late(void)
 {
 	int old = boot_cpu_data.microcode, ret;
+	struct cpuinfo_x86 info;
 
 	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
 	pr_err("You should switch to early loading, if possible.\n");
@@ -477,9 +492,16 @@ static int microcode_reload_late(void)
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
+	/*
+	 * Take a snapshot before the microcode update, so we can compare
+	 * them after the update is successful to check for any bits
+	 * changed.
+	 */
+	store_cpu_caps(&info);
+
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
 	if (ret == 0)
-		microcode_check();
+		microcode_check(&info);
 
 	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
 		old, boot_cpu_data.microcode);
-- 
2.34.1

