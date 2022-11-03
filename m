Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ADA6186D8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiKCSBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiKCR7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:59:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AB72BEB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667498363; x=1699034363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R6mbf+XQukOLH0HwR/RFX95V03exlKMqldLbjsezTU0=;
  b=TpVF8ONV/NqmFCRuw1KRWTbXePZgr7Ls59h1x33l4riKVeW6K4X1mftW
   0eCdMAXQwMwVfQGmb03lcBJee8WH5N1mYY7u8K3loZDd32lJX/4hs5XLF
   VEDULS+uTn936FBOfjPI8H6Ztw/9tEyJoPTdX9DrgfWnSVPq0leZ3EG4T
   eCrbAtQI4oRnkH+ghkdeh5FlMsD5jU4jSjPpMFsBUZziq4PeqBOxbpl9E
   Ow3ZNY/XqNj7IFZ6e7Zy04MDPShe60x4ME/uYoxqTOfkQrdIIi9BKucey
   TZiCwHtnKLa5ZjTl5rBdPJ70irkxXmi4AOkCrPXvqWAuxJ4UNDiMxcAgZ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308476974"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="308476974"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809762568"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="809762568"
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
Subject: [v2 10/13] x86/microcode: Add a generic mechanism to declare support for minrev
Date:   Thu,  3 Nov 2022 17:58:58 +0000
Message-Id: <20221103175901.164783-11-ashok.raj@intel.com>
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

Intel microcode adds some meta-data to report a minimum required revision
before this new microcode can be late-loaded. There are no generic mechanism
to declare support for all vendors.

Add generic support to microcode to declare support, so the tainting and
late-loading can be permitted in those architectures that support reporting
a minrev in some form.

Late loading has added support for

- New images declaring a required minimum base version before a late-load
  is performed.
- Improved NMI handling during update to avoid sibling threads taking NMI's
  while primary is still not complete with the microcode update.

With these changes, late-loading can be re-enabled. Tainting only happens
on architectures that don't support minimum required version reporting.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
v2: (Kai) Add missing initialization local variable minrev

 arch/x86/include/asm/microcode.h      |  2 ++
 arch/x86/kernel/cpu/microcode/core.c  | 15 +++++++++++----
 arch/x86/kernel/cpu/microcode/intel.c |  6 ++++++
 arch/x86/Kconfig                      |  7 ++++---
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index f16973fb7330..6286b4056792 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -64,6 +64,8 @@ enum ucode_state {
 };
 
 struct microcode_ops {
+	int (*check_minrev) (void);
+
 	enum ucode_state (*request_microcode_fw) (int cpu, struct device *);
 
 	void (*microcode_fini_cpu) (int cpu);
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 6f59ffdf2881..17dba13d397d 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -607,6 +607,7 @@ static ssize_t reload_store(struct device *dev,
 	enum ucode_state tmp_ret = UCODE_OK;
 	int bsp = boot_cpu_data.cpu_index;
 	unsigned long val;
+	int minrev = 0;
 	ssize_t ret = 0;
 
 	ret = kstrtoul(buf, 0, &val);
@@ -622,13 +623,18 @@ static ssize_t reload_store(struct device *dev,
 	if (ret)
 		goto put;
 
+	if (microcode_ops->check_minrev)
+		minrev = microcode_ops->check_minrev();
+
+	if (!minrev) {
+		pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
+		pr_err("You should switch to early loading, if possible.\n");
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
@@ -639,7 +645,8 @@ static ssize_t reload_store(struct device *dev,
 	if (ret == 0)
 		ret = size;
 
-	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	if (!minrev)
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
 
 	return ret;
 }
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 020d0feed3cc..5d2ee76cd36c 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -956,7 +956,13 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device)
 	return ret;
 }
 
+static int intel_check_minrev(void)
+{
+	return 1;
+}
+
 static struct microcode_ops microcode_intel_ops = {
+	.check_minrev			  = intel_check_minrev,
 	.request_microcode_fw             = request_microcode_fw,
 	.collect_cpu_info                 = collect_cpu_info,
 	.apply_microcode                  = apply_microcode_intel,
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6d1879ef933a..b53626bff5f7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1353,15 +1353,16 @@ config MICROCODE_AMD
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

