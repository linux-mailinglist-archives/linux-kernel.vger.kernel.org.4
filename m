Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C985D5FF459
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiJNUKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiJNUJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:09:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06B81DA37C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665778173; x=1697314173;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cFJU+EWuF6ICxOqV1eb2P+F38ins8YONFjIm4oOMQXA=;
  b=AT0Yqrmb+xWRh3xy7CfcAePGDtTa20nwZf1dxfMjd9OzRbkKfYyCGscV
   JXCnBMu2kY8HivKOBZ16i3Zdx/sJw+GkMux+wtNR6dentesPSJu624qgj
   xw4cq2hRMe4QWc88HkgSq6Pu9lgT1SwQcFNBsma9ZFOpTTeze+PWyUolx
   L8iquCFYd4MN3oyE4XXQgDfZUM5P82rMhYOoETWmE2lXAQz/YyWGXt+qQ
   dVOz/j5rnqPD0oEETvyzaUaKQNkClvTlDuXZ8KMBttAkzil9xSFbPedt2
   8T4pRXBdOMshtod5sMQa7hudhnmyw1zvRhw/iDs/JJIHSnHBymihbUbq1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="304202162"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="304202162"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:29 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="716870165"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="716870165"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:29 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan van de Ven <arjan.van.de.ven@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 09/13] x86/microcode: Add a generic mechanism to declare support for minrev
Date:   Fri, 14 Oct 2022 13:09:09 -0700
Message-Id: <20221014200913.14644-10-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221014200913.14644-1-ashok.raj@intel.com>
References: <20221014200913.14644-1-ashok.raj@intel.com>
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

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/include/asm/microcode.h      |  1 +
 arch/x86/kernel/cpu/microcode/core.c  | 14 +++++++++++---
 arch/x86/kernel/cpu/microcode/intel.c |  6 ++++++
 arch/x86/Kconfig                      |  7 ++++---
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 401213fb2e4a..0c0bbc26560f 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -59,6 +59,7 @@ enum ucode_state {
 };
 
 struct microcode_ops {
+	int (*check_minrev) (void);
 	enum ucode_state (*request_microcode_fw) (int cpu, struct device *,
 						  bool late_loading);
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7a8fcb914b6a..46e9c2d8fae0 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -606,6 +606,7 @@ static ssize_t reload_store(struct device *dev,
 	enum ucode_state tmp_ret = UCODE_OK;
 	int bsp = boot_cpu_data.cpu_index;
 	unsigned long val;
+	int minrev;
 	ssize_t ret = 0;
 
 	ret = kstrtoul(buf, 0, &val);
@@ -621,8 +622,14 @@ static ssize_t reload_store(struct device *dev,
 	if (ret)
 		goto put;
 
-	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
-	pr_err("You should switch to early loading, if possible.\n");
+	if (microcode_ops->check_minrev())
+		minrev = microcode_ops->check_minrev();
+
+	if (!minrev) {
+		pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
+		pr_err("You should switch to early loading, if possible.\n");
+	}
+
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
 	if (tmp_ret != UCODE_NEW)
 		goto put;
@@ -637,7 +644,8 @@ static ssize_t reload_store(struct device *dev,
 	if (ret == 0)
 		ret = size;
 
-	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	if (!minrev)
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
 
 	return ret;
 }
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 46edce811c69..c8ee53fcf04d 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -950,7 +950,13 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
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
index f9920f1341c8..a01fce1092ce 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1336,15 +1336,16 @@ config MICROCODE_AMD
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

