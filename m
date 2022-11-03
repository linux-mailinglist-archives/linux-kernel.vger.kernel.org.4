Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605BD6186D1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiKCSA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiKCR73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:59:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B85F2BC9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667498360; x=1699034360;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ofiZPePB3pOVJyIuYvJbayrHFNZGL3ftaAhWziWnjE=;
  b=YNnUTjkjtWEyhiPdmQn1jOcGFpz4g2SC3SZEJFCkyuecQZ82RZSlnMxi
   fxXZquHrf2CVRmuNvigB2XDS9s4hbVv88oA7Rf/gWAXXwfMv0BNkE1k3M
   ARMMfQHe0ExTecK+0khIcJ4M2YSIvNgTKewyDQcysIaGhNCBc3L71gxSX
   OSwjNf1WBydMh+reLn7ft1kduv1d1FpB44+5PBKu5zAITaevEWIIozTmD
   zEbjCBJgRMQHJYknzl3x8Con9jkJX3DY0WbAUXyJO00mfUAahKmdif53/
   Du7fqoaUp7Km7RrcFw4JuFEHWjBRUJ34CPpIK+uoHZORmm99TqpuS5NlU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308476967"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="308476967"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809762550"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="809762550"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kai Huang <kai.huang@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [v2 04/13] x86/microcode: Fix microcode_check() compare after a new uCode update
Date:   Thu,  3 Nov 2022 17:58:52 +0000
Message-Id: <20221103175901.164783-5-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103175901.164783-1-ashok.raj@intel.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

microcode_check() seems to take a snapshot after an update to compare with
previously cached values of x86_capabilities. Some capabilities can be
turned off by OS as a result of certain command line parameters or due to
some configuration.

Even though there was no change in CPUID bits, reloading the same microcode
threw a warning, that some CPUID bits changed.

To eliminate the false warning, take a snapshot before the update and one
after the update. This eliminates the miscompare.

Also move the microcode_check() from cpu/common.c -> cpu/microcode/core.c

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/include/asm/processor.h     |  1 -
 arch/x86/kernel/cpu/common.c         | 32 -----------------
 arch/x86/kernel/cpu/microcode/core.c | 51 +++++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 67c9d73b31fa..2acc8ae0bf47 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -835,7 +835,6 @@ bool xen_set_default_idle(void);
 #endif
 
 void __noreturn stop_this_cpu(void *dummy);
-void microcode_check(void);
 
 enum l1tf_mitigations {
 	L1TF_MITIGATION_OFF,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3e508f239098..bbd362ead043 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2305,38 +2305,6 @@ void cpu_init_secondary(void)
 }
 #endif
 
-#ifdef CONFIG_MICROCODE_LATE_LOADING
-/*
- * The microcode loader calls this upon late microcode load to recheck features,
- * only when microcode has been updated. Caller holds microcode_mutex and CPU
- * hotplug lock.
- */
-void microcode_check(void)
-{
-	struct cpuinfo_x86 info;
-
-	perf_check_microcode();
-
-	/* Reload CPUID max function as it might've changed. */
-	info.cpuid_level = cpuid_eax(0);
-
-	/*
-	 * Copy all capability leafs to pick up the synthetic ones so that
-	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
-	 * get overwritten in get_cpu_cap().
-	 */
-	memcpy(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability));
-
-	get_cpu_cap(&info);
-
-	if (!memcmp(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability)))
-		return;
-
-	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
-	pr_warn("x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
-}
-#endif
-
 /*
  * Invoked from core CPU hotplug code after hotplug operations
  */
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 712aafff96e0..9ed1f6e138d6 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -40,6 +40,8 @@
 #include <asm/cmdline.h>
 #include <asm/setup.h>
 
+#include "../cpu.h"
+
 #define DRIVER_VERSION	"2.2"
 
 static struct microcode_ops	*microcode_ops;
@@ -431,6 +433,51 @@ static int __reload_late(void *info)
 	return ret;
 }
 
+static void copy_cpu_caps(struct cpuinfo_x86 *info)
+{
+	/* Reload CPUID max function as it might've changed. */
+	info->cpuid_level = cpuid_eax(0);
+
+	/*
+	 * Copy all capability leafs to pick up the synthetic ones so that
+	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
+	 * get overwritten in get_cpu_cap().
+	 */
+	memcpy(info->x86_capability, &boot_cpu_data.x86_capability, sizeof(info->x86_capability));
+
+	get_cpu_cap(info);
+}
+
+/*
+ * The microcode loader calls this upon late microcode load to recheck features,
+ * only when microcode has been updated. Caller holds microcode_mutex and CPU
+ * hotplug lock.
+ */
+static void microcode_check(struct cpuinfo_x86 *orig)
+{
+	struct cpuinfo_x86 info;
+
+	perf_check_microcode();
+
+	/* Reload CPUID max function as it might've changed. */
+	info.cpuid_level = cpuid_eax(0);
+
+	/*
+	 * Copy all capability leafs to pick up the synthetic ones so that
+	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
+	 * get overwritten in get_cpu_cap().
+	 */
+	memcpy(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability));
+
+	get_cpu_cap(&info);
+
+	if (!memcmp(info.x86_capability, &orig->x86_capability, sizeof(info.x86_capability)))
+		return;
+
+	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
+	pr_warn("x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
+}
+
 /*
  * Reload microcode late on all CPUs. Wait for a sec until they
  * all gather together.
@@ -438,6 +485,7 @@ static int __reload_late(void *info)
 static int microcode_reload_late(void)
 {
 	int old = boot_cpu_data.microcode, ret;
+	struct cpuinfo_x86 info;
 
 	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
 	pr_err("You should switch to early loading, if possible.\n");
@@ -445,9 +493,10 @@ static int microcode_reload_late(void)
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
+	copy_cpu_caps(&info);
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
 	if (ret == 0)
-		microcode_check();
+		microcode_check(&info);
 
 	pr_info("Reload completed, microcode revision: 0x%x -> 0x%x\n",
 		old, boot_cpu_data.microcode);
-- 
2.34.1

