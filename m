Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE5566A0EC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjAMRnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjAMRnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:43:10 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFAF6C04C
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673630974; x=1705166974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+uJwRo55xEtpfWrqsz+KfZkuGz/Ne+Z1O6pvkdQS4hM=;
  b=T/Wz+cVBLImMHu2qVkshVH917Ai7jZBLsLLaGj1MPQRapkPFvB5Or/rB
   Wl3oQFN96dmcOJOfmehWUIVzNiHnc0ism5qjgzEXkfgwgH+7twL6aCy9y
   v8JFi7z9rSB/5K501AUnm28bGI1UaZ5Rwr7k6DzGPswQoguUoSwPXK38R
   fyaNRRK3C5E610U0wVgvvcWCMBcM6IrIRa6t/A7+PBT768uynkZMUQY8O
   f4U8G+RGY3SBXPlTeyBOOeXr+QppFRzr5hU0Un6gDerDals3UoUQuUive
   V2M8BX9c4AiLHPnLGNniGvzHMOdi0rAKHFywPLSBBiQ/q193pvNbOtGJe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="304430017"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="304430017"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:29:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="766089924"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="766089924"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:29:32 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
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
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Subject: [PATCH v1 Part2 3/5] x86/microcode: Add a generic mechanism to declare support for minrev
Date:   Fri, 13 Jan 2023 09:29:18 -0800
Message-Id: <20230113172920.113612-4-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113172920.113612-1-ashok.raj@intel.com>
References: <20230113172920.113612-1-ashok.raj@intel.com>
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

Intel microcode adds some meta-data to report a minimum required revision
before this new microcode can be safely late loaded. There are no generic
mechanism to declare support for all vendors.

Add generic support to microcode core to declare such support, this allows
late-loading to be permitted in those architectures that report support
for safe late loading.

Late loading has added support for

- New images declaring a required minimum base version before a late-load
  is performed.

Tainting only happens on architectures that don't support minimum required
version reporting.

Add a new variable in microcode_ops to allow an architecture to declare
support for safe microcode late loading.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
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
---
 arch/x86/include/asm/microcode.h      |  2 ++
 arch/x86/kernel/cpu/microcode/core.c  | 25 ++++++++++++++++++++-----
 arch/x86/kernel/cpu/microcode/intel.c |  1 +
 arch/x86/Kconfig                      |  7 ++++---
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index d5a58bde091c..3d48143e84a9 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -33,6 +33,8 @@ enum ucode_state {
 };
 
 struct microcode_ops {
+	bool safe_late_load;
+
 	enum ucode_state (*request_microcode_fw) (int cpu, struct device *);
 
 	void (*microcode_fini_cpu) (int cpu);
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index c361882baf63..446ddf3fcc29 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -472,6 +472,7 @@ static ssize_t reload_store(struct device *dev,
 	enum ucode_state tmp_ret = UCODE_OK;
 	int bsp = boot_cpu_data.cpu_index;
 	unsigned long val;
+	bool safe_late_load = false;
 	ssize_t ret = 0;
 
 	ret = kstrtoul(buf, 0, &val);
@@ -487,13 +488,22 @@ static ssize_t reload_store(struct device *dev,
 	if (ret)
 		goto put;
 
+	safe_late_load = microcode_ops->safe_late_load;
+
+	/*
+	 * If safe loading indication isn't present, bail out.
+	 */
+	if (!safe_late_load) {
+		pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
+		pr_err("You should switch to early loading, if possible.\n");
+		ret = -EINVAL;
+		goto put;
+	}
+
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
 	if (tmp_ret != UCODE_NEW)
 		goto put;
 
-	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
-	pr_err("You should switch to early loading, if possible.\n");
-
 	mutex_lock(&microcode_mutex);
 	ret = microcode_reload_late();
 	mutex_unlock(&microcode_mutex);
@@ -501,11 +511,16 @@ static ssize_t reload_store(struct device *dev,
 put:
 	cpus_read_unlock();
 
+	/*
+	 * Only taint if a successful load and vendor doesn't support
+	 * safe_late_load
+	 */
+	if (!(ret && safe_late_load))
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+
 	if (ret == 0)
 		ret = size;
 
-	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
-
 	return ret;
 }
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 6046f90a47b2..eba4f463ef1c 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -806,6 +806,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device)
 }
 
 static struct microcode_ops microcode_intel_ops = {
+	.safe_late_load			  = true,
 	.request_microcode_fw             = request_microcode_fw,
 	.collect_cpu_info                 = collect_cpu_info,
 	.apply_microcode                  = apply_microcode_intel,
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..ddc4130e6f8c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1352,15 +1352,16 @@ config MICROCODE_AMD
 	  processors will be enabled.
 
 config MICROCODE_LATE_LOADING
-	bool "Late microcode loading (DANGEROUS)"
-	default n
+	bool "Late microcode loading"
+	default y
 	depends on MICROCODE
 	help
 	  Loading microcode late, when the system is up and executing instructions
 	  is a tricky business and should be avoided if possible. Just the sequence
 	  of synchronizing all cores and SMT threads is one fragile dance which does
 	  not guarantee that cores might not softlock after the loading. Therefore,
-	  use this at your own risk. Late loading taints the kernel too.
+	  use this at your own risk. Late loading taints the kernel, if it
+	  doesn't support a minimum required base version before an update.
 
 config X86_MSR
 	tristate "/dev/cpu/*/msr - Model-specific register support"
-- 
2.34.1

