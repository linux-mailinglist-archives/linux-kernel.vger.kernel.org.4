Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5106186D2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiKCSAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiKCR73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:59:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5F15F48
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667498362; x=1699034362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mK6qh3yJ3vr/2ZaLvzn6GOkotoEzPEIyO1PLPBrI3fk=;
  b=LLMuadPUnawCndMTQqgJceku9Kl57nmuAAYCV5IT8W3HlAfZvfe+ZtX7
   6s5rci4S/N2UBod66MjupKWG+8O71OBHNa5ZH4voDZXv/jK/4zfMBS2oY
   xzeJ4dYipisAu9/PLD07ndN7a5bq4u44cTHigCHqkLWhn3kidg5JJUVt+
   lsWFUcn16rOIqmcyf3X4MTIAruPlgVL5XXRcqqS0ltWBhIu49UX2fLdCE
   09UjhKdo8EpoRHX98HUlP35qCElKytGC3Z55Ywhh/G5nqRKUQyCaSykIU
   UxybQhUHCr5hIO4IMir51GCG4xqV6sPPMrAOs7+qc9HVYdpus368vGF1J
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308476971"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="308476971"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809762562"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="809762562"
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
Subject: [v2 08/13] x86/mce: Warn of a microcode update is in progress when MCE arrives
Date:   Thu,  3 Nov 2022 17:58:56 +0000
Message-Id: <20221103175901.164783-9-ashok.raj@intel.com>
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

Due to the nature of microcode updates to long flow instructions, its
possible if an MCE is taken when microcode update is in progress could be
dangerous. There is nothing the kernel can do to mitigate safely.

Drop some bread crumbs to note that a MCE happened while a microcode update
is also in progress.

Suggested-by: Boris Petkov <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/include/asm/microcode.h     | 2 ++
 arch/x86/kernel/cpu/mce/core.c       | 5 +++++
 arch/x86/kernel/cpu/microcode/core.c | 9 +++++++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index ffb46f2b0354..f16973fb7330 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -167,8 +167,10 @@ static inline void microcode_bsp_resume(void)			{ }
 #endif
 
 #ifdef CONFIG_MICROCODE_LATE_LOADING
+extern int ucode_update_in_progress(void);
 extern void hold_sibling_in_nmi(void);
 #else
+static inline int ucode_update_in_progress(void) { return 0; }
 static inline void hold_sibling_in_nmi(void) { }
 #endif
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c8ec5c71712..67669686fab4 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -46,6 +46,7 @@
 #include <linux/hardirq.h>
 
 #include <asm/intel-family.h>
+#include <asm/microcode.h>
 #include <asm/processor.h>
 #include <asm/traps.h>
 #include <asm/tlbflush.h>
@@ -1425,6 +1426,10 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	else if (unlikely(!mca_cfg.initialized))
 		return unexpected_machine_check(regs);
 
+	instrumentation_begin();
+	if (ucode_update_in_progress())
+		pr_warn("MCE triggered while microcode update is in progress\n");
+	instrumentation_end();
 	if (mce_flags.skx_repmov_quirk && quirk_skylake_repmov())
 		goto clear;
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 6084a87ea8f3..6f59ffdf2881 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -327,6 +327,8 @@ void reload_early_microcode(void)
 static struct platform_device	*microcode_pdev;
 
 #ifdef CONFIG_MICROCODE_LATE_LOADING
+static int ucode_updating;
+
 /*
  * Late loading dance. Why the heavy-handed stomp_machine effort?
  *
@@ -556,6 +558,11 @@ static void microcode_check(struct cpuinfo_x86 *orig)
 	pr_warn("x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
 }
 
+int ucode_update_in_progress(void)
+{
+	return ucode_updating;
+}
+
 /*
  * Reload microcode late on all CPUs. Wait for a sec until they
  * all gather together.
@@ -578,7 +585,9 @@ static int microcode_reload_late(void)
 	}
 
 	copy_cpu_caps(&info);
+	ucode_updating = 1;
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
+	ucode_updating = 0;
 	if (ret == 0)
 		microcode_check(&info);
 
-- 
2.34.1

