Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD9C65C59E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbjACSCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238421AbjACSC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:02:27 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442C311A27
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672768944; x=1704304944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zSTaTcLJbOegMxQuinD52HPOguvdV7463+YMjh/di6M=;
  b=gS1mBIFdV+iLsRUbZkPigoJC98vubC4xmYwuZ2LAZqDeEmgKyaKXL+tA
   jD3ncXCxsVQeEa6F3GSTieLcJMuO52XCjnLk543bi1usHN0qXqeOBtlMZ
   Fyzu9F2GLpxw8JgRKPArQS+csxo7qBYOXA2jNmsQwcauMAoumASARNs97
   2wkTvmETDTjKxa8dm4xFGMdemXzDSuC+9ley+RwixTLdDNyYk9RdKzgb5
   CnTTmsbyv7B5d0ou4QyJeImzmiCD9zt5qWE/OSyKmbYX6U1EdHO/cg1Bb
   FOetxIIU3UHj5rg4a7jx+cFZwhl4Nzgb5dv+U5zIw2F14EQlwZqAsxbEq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="384010636"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="384010636"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 10:02:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="654876879"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="654876879"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 10:02:24 -0800
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
Subject: [PATCH v3 1/6] x86/microcode: Add a parameter to microcode_check() to store CPU capabilities
Date:   Tue,  3 Jan 2023 10:02:07 -0800
Message-Id: <20230103180212.333496-2-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103180212.333496-1-ashok.raj@intel.com>
References: <20230103180212.333496-1-ashok.raj@intel.com>
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

This is a preparation before the next patch uses this to compare CPU
capabilities after performing an update.

Add a parameter to store CPU capabilities before performing a microcode
update.

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
 arch/x86/include/asm/processor.h     |  2 +-
 arch/x86/kernel/cpu/common.c         | 12 +++++-------
 arch/x86/kernel/cpu/microcode/core.c |  3 ++-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4e35c66edeb7..387578049de0 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -697,7 +697,7 @@ bool xen_set_default_idle(void);
 #endif
 
 void __noreturn stop_this_cpu(void *dummy);
-void microcode_check(void);
+void microcode_check(struct cpuinfo_x86 *info);
 
 enum l1tf_mitigations {
 	L1TF_MITIGATION_OFF,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9cfca3d7d0e2..b9c7529c920e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2302,25 +2302,23 @@ void cpu_init_secondary(void)
  * only when microcode has been updated. Caller holds microcode_mutex and CPU
  * hotplug lock.
  */
-void microcode_check(void)
+void microcode_check(struct cpuinfo_x86 *info)
 {
-	struct cpuinfo_x86 info;
-
 	perf_check_microcode();
 
 	/* Reload CPUID max function as it might've changed. */
-	info.cpuid_level = cpuid_eax(0);
+	info->cpuid_level = cpuid_eax(0);
 
 	/*
 	 * Copy all capability leafs to pick up the synthetic ones so that
 	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
 	 * get overwritten in get_cpu_cap().
 	 */
-	memcpy(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability));
+	memcpy(&info->x86_capability, &boot_cpu_data.x86_capability, sizeof(info->x86_capability));
 
-	get_cpu_cap(&info);
+	get_cpu_cap(info);
 
-	if (!memcmp(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability)))
+	if (!memcmp(&info->x86_capability, &boot_cpu_data.x86_capability, sizeof(info->x86_capability)))
 		return;
 
 	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index c4cd7328177b..d86a4f910a6b 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -439,6 +439,7 @@ static int __reload_late(void *info)
 static int microcode_reload_late(void)
 {
 	int old = boot_cpu_data.microcode, ret;
+	struct cpuinfo_x86 info;
 
 	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
 	pr_err("You should switch to early loading, if possible.\n");
@@ -448,7 +449,7 @@ static int microcode_reload_late(void)
 
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
 	if (ret == 0)
-		microcode_check();
+		microcode_check(&info);
 
 	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
 		old, boot_cpu_data.microcode);
-- 
2.34.1

