Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF7A6759BE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjATQTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjATQTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:19:41 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598577A8D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 08:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674231580; x=1705767580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ln3922WzqwFOb1wmU3cZl9JGmSn0AMZmtenFituTbpU=;
  b=MkftYn+UCfcO+kxC5k+jDEgT4mVAqDEKMkeb8bEF3nO532dkG4+bDE9r
   2h/VWMI24SErvTR6/d7E6S0OufJlzMhA97+b1wYVMZQeM5w6JHIt03QeE
   3xM5TnzQJ718syGrXUazdCiK+MF8MxwAPwxDFTinbbDgLXHajO2zZBUVR
   ZPANOt3QShUNevZj+sdstGCvvBzRtuEUwRpCZ+I7vmTmonIFlr1KtbgOE
   yG80onlwgtUo8fSrUspbTCBK0gFXoSxXfC+NIcYDMGFZOoC2F3fAq0rlM
   lXbO9duIdW7yG2JUQorGJTfXiema95JE/DNM3f4AfsldI4QjKzL7jn6O7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="411846555"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="411846555"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 08:19:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10596"; a="653836366"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="653836366"
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
Subject: [Patch v5 1/5] x86/microcode: Add a parameter to microcode_check() to store CPU capabilities
Date:   Fri, 20 Jan 2023 08:19:19 -0800
Message-Id: <20230120161923.118882-2-ashok.raj@intel.com>
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

Add a parameter to store CPU capabilities before performing a microcode
update so that the code later can compare CPU capabilities before and after
performing the update.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
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
Changes since V3

Boris:
- Fix commit log to drop "next patch".
- Add documentation to new parameter to microcode_check()
---
 arch/x86/include/asm/processor.h     |  2 +-
 arch/x86/kernel/cpu/common.c         | 21 +++++++++++++--------
 arch/x86/kernel/cpu/microcode/core.c |  3 ++-
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4e35c66edeb7..f256a4ddd25d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -697,7 +697,7 @@ bool xen_set_default_idle(void);
 #endif
 
 void __noreturn stop_this_cpu(void *dummy);
-void microcode_check(void);
+void microcode_check(struct cpuinfo_x86 *prev_info);
 
 enum l1tf_mitigations {
 	L1TF_MITIGATION_OFF,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9cfca3d7d0e2..0f5a173d0871 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2297,30 +2297,35 @@ void cpu_init_secondary(void)
 #endif
 
 #ifdef CONFIG_MICROCODE_LATE_LOADING
-/*
+/**
+ * microcode_check() - Check if any CPU capabilities changed after an update.
+ * @prev_info:	CPU capabilities stored before an update.
+ *
  * The microcode loader calls this upon late microcode load to recheck features,
  * only when microcode has been updated. Caller holds microcode_mutex and CPU
  * hotplug lock.
+ *
+ * Return: None
  */
-void microcode_check(void)
+void microcode_check(struct cpuinfo_x86 *prev_info)
 {
-	struct cpuinfo_x86 info;
-
 	perf_check_microcode();
 
 	/* Reload CPUID max function as it might've changed. */
-	info.cpuid_level = cpuid_eax(0);
+	prev_info->cpuid_level = cpuid_eax(0);
 
 	/*
 	 * Copy all capability leafs to pick up the synthetic ones so that
 	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
 	 * get overwritten in get_cpu_cap().
 	 */
-	memcpy(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability));
+	memcpy(&prev_info->x86_capability, &boot_cpu_data.x86_capability,
+	       sizeof(prev_info->x86_capability));
 
-	get_cpu_cap(&info);
+	get_cpu_cap(prev_info);
 
-	if (!memcmp(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability)))
+	if (!memcmp(&prev_info->x86_capability, &boot_cpu_data.x86_capability,
+		    sizeof(prev_info->x86_capability)))
 		return;
 
 	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index c4cd7328177b..e39d83be794b 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -439,6 +439,7 @@ static int __reload_late(void *info)
 static int microcode_reload_late(void)
 {
 	int old = boot_cpu_data.microcode, ret;
+	struct cpuinfo_x86 prev_info;
 
 	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
 	pr_err("You should switch to early loading, if possible.\n");
@@ -448,7 +449,7 @@ static int microcode_reload_late(void)
 
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
 	if (ret == 0)
-		microcode_check();
+		microcode_check(&prev_info);
 
 	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
 		old, boot_cpu_data.microcode);
-- 
2.34.1

