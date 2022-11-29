Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56E663CA19
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236810AbiK2VJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbiK2VJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:09:06 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4233E63CE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669756145; x=1701292145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=70gwJLJLXs2AZIFAvJaft9GRLf9mjU7YlemJkv6J9xI=;
  b=cTLMGliBoVKRr8h8wPJMK6afJnp3psQ5cnPAQPqMHQmBEaxBBC0WVPQv
   +pf0UOsjJ4ARnfVsRstQDNwrszRIIGypF+5BrgTBdvvFZmcCf/yOkR8fv
   0y23bo9a/j9pIcgjBRXLtI9NPM24QYhZd9srk+yUaiSld8b7tgISXR0z6
   yH0nCBLebd6VzNA2dLR+uEZsaDHnDRNDa7d/dBfAzlTYaazpgHlxAmpqf
   YzZQ8gWiGQc7CignNfCrr8xGHKI5H4Qhwf0da39CU6ubUbjVOUFPLWg2E
   X3zmp/MirquVkEWg2cCj0l011bR2+8WKwd3NC58zgYDn9HyqDK4SzEJpr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="317083136"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="317083136"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 13:09:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="646066208"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="646066208"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 13:09:04 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: [Patch V1 3/7] x86/microcode/core: Move microcode_check() to cpu/microcode/core.c
Date:   Tue, 29 Nov 2022 13:08:28 -0800
Message-Id: <20221129210832.107850-4-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221129210832.107850-1-ashok.raj@intel.com>
References: <20221129210832.107850-1-ashok.raj@intel.com>
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
it static to prepare for upcoming fix of false negative when checking CPU
features after a microcode update. Also move get_cpu_cap() to processor.h
for general use outside of kernel/cpu.h

No functional change.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
Tony
	Add movement of get_cpu_cap() to commit log
Reinette
	Avoid including ../cpu.h and move to more general header.
Alison
	Split patch to just move the function before use inside microcode
	files.
---
 arch/x86/include/asm/processor.h     |  3 +--
 arch/x86/kernel/cpu/cpu.h            |  1 -
 arch/x86/kernel/cpu/common.c         | 32 ----------------------------
 arch/x86/kernel/cpu/microcode/core.c | 31 +++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 67c9d73b31fa..f5380806f3fa 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -192,8 +192,8 @@ extern const struct seq_operations cpuinfo_op;
 
 #define cache_line_size()	(boot_cpu_data.x86_cache_alignment)
 
+extern void get_cpu_cap(struct cpuinfo_x86 *c);
 extern void cpu_detect(struct cpuinfo_x86 *c);
-
 static inline unsigned long long l1tf_pfn_limit(void)
 {
 	return BIT_ULL(boot_cpu_data.x86_cache_bits - 1 - PAGE_SHIFT);
@@ -835,7 +835,6 @@ bool xen_set_default_idle(void);
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
index 712aafff96e0..ef24e1d228d0 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -431,6 +431,37 @@ static int __reload_late(void *info)
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

