Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24BA656E44
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiL0TYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiL0TX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:23:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE4A7666
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672169036; x=1703705036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AkG2Hj1V9FOORMr1pc5kfG9A0Vq/BVt3h5MQvlr7sgw=;
  b=LrkODz25ghcqg4twwF7/7Wk/gaRrMlh3YETlc0E6gdPu36p0PuANPFkG
   VKwAKOM3g1uwzjSD+kVLXviWXjR0Xu9oQCJFyRDHXhfZkSbgw0HN2wryg
   Uqh/0SlRTIts+arFKQjM5ekEQHZzRY18zIFjHIisVxt9N3RmfTBZnWgow
   U99c6wiusDTGNfI4p7F/63VppoUgCPoBUwD+xikZFb6S00zb7EYlg1IoR
   16/VvIFZwcqluHgGgiDpXV02EYp4h4MA7RqC2ub7b30bo9pmBJOgVs8Ls
   vB0apBjUrennE1xOUJeYCrCc/Zg/lRAYZ1MFkUQZ5dOXQCjeHAX92W9Qy
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="407011175"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="407011175"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2022 11:23:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10573"; a="777234199"
X-IronPort-AV: E=Sophos;i="5.96,279,1665471600"; 
   d="scan'208";a="777234199"
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
Subject: [PATCH v2 1/6] x86/microcode/core: Move microcode_check() to cpu/microcode/core.c
Date:   Tue, 27 Dec 2022 11:23:35 -0800
Message-Id: <20221227192340.8358-2-ashok.raj@intel.com>
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

microcode_check() is only called from microcode/core.c. Move it and make
it static to prepare for upcoming fix for false negative when checking CPU
features after a microcode update. Also move get_cpu_cap() to processor.h
for general use outside of arch/x86/kernel/cpu/cpu.h

No functional change.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: x86 <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/processor.h     |  3 +--
 arch/x86/kernel/cpu/cpu.h            |  1 -
 arch/x86/kernel/cpu/common.c         | 32 ----------------------------
 arch/x86/kernel/cpu/microcode/core.c | 31 +++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4e35c66edeb7..70d01ecc39a4 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -182,8 +182,8 @@ extern const struct seq_operations cpuinfo_op;
 
 #define cache_line_size()	(boot_cpu_data.x86_cache_alignment)
 
+extern void get_cpu_cap(struct cpuinfo_x86 *c);
 extern void cpu_detect(struct cpuinfo_x86 *c);
-
 static inline unsigned long long l1tf_pfn_limit(void)
 {
 	return BIT_ULL(boot_cpu_data.x86_cache_bits - 1 - PAGE_SHIFT);
@@ -697,7 +697,6 @@ bool xen_set_default_idle(void);
 #endif
 
 void __noreturn stop_this_cpu(void *dummy);
-void microcode_check(void);
 
 enum l1tf_mitigations {
 	L1TF_MITIGATION_OFF,
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 7c9b5893c30a..a142b8d543a3 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -63,7 +63,6 @@ static inline void tsx_ap_init(void) { }
 
 extern void init_spectral_chicken(struct cpuinfo_x86 *c);
 
-extern void get_cpu_cap(struct cpuinfo_x86 *c);
 extern void get_cpu_address_sizes(struct cpuinfo_x86 *c);
 extern void cpu_detect_cache_sizes(struct cpuinfo_x86 *c);
 extern void init_scattered_cpuid_features(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9cfca3d7d0e2..7b06034eeddc 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2296,38 +2296,6 @@ void cpu_init_secondary(void)
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
index c4cd7328177b..0051ebf7c53e 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -432,6 +432,37 @@ static int __reload_late(void *info)
 	return ret;
 }
 
+/*
+ * The microcode loader calls this upon late microcode load to recheck features,
+ * only when microcode has been updated. Caller holds microcode_mutex and CPU
+ * hotplug lock.
+ */
+static void microcode_check(void)
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
+	if (!memcmp(&info.x86_capability, &boot_cpu_data.x86_capability,
+		    sizeof(info.x86_capability)))
+		return;
+
+	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
+	pr_warn("x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
+}
+
 /*
  * Reload microcode late on all CPUs. Wait for a sec until they
  * all gather together.
-- 
2.34.1

