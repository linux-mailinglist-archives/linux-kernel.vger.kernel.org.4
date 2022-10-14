Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C1C5FF45B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 22:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiJNUKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 16:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiJNUJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 16:09:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C84B60CE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 13:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665778180; x=1697314180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6cM75GDPnUUJqdYjmwAm7JmYWSS9Q+SvC5L064x5New=;
  b=aw5GyYd5w+RM8KVAEsGW7aV2Y06KywkZvowfQjkYUC5p0de2hVxt5o99
   fr7hV3hBq1z6gYX/W6qNQvBLJEYxEh5Zgl79mB0XlR8mjHA6kSv4Fj1PD
   NXC/K3+ON12rzkPm88j2m0Rd7s7Gfe8UspuQk/TJIfrknrcdoGNH9oAVA
   RHDvFAn3NduSSHzk5tiN2t8FNvfuFeUNvRIy7OJQcWa0eOaIlOn5QAhUK
   TL99gsq5gjwbJbS0mj+LgOjoFXz61JunzqNiJ/cHviLhNITb8Qqj7ooYJ
   tDpg3xkOZW09bYz+i/z4KP6Qhfwx5azqXUQrkY/SL4XAx8itNmDiFtOH7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="304202166"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="304202166"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:30 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="716870177"
X-IronPort-AV: E=Sophos;i="5.95,185,1661842800"; 
   d="scan'208";a="716870177"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 13:09:30 -0700
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
Subject: [PATCH 13/13] x86/microcode/intel: Add ability to update microcode even if rev is unchanged
Date:   Fri, 14 Oct 2022 13:09:13 -0700
Message-Id: <20221014200913.14644-14-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221014200913.14644-1-ashok.raj@intel.com>
References: <20221014200913.14644-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This comes in handy for testing without the need for a new microcode file.
It introduces a new boot parameter ucode_load_same, or it can be switched
dynamically at run time via debugfs file
/sys/kernel/debug/microcode/load_same.

NOT_FOR_INCLUSION:
Leave it to the discretion of Boris if its suitable for inclusion. It will
at least serve to validate some parts of the series without the need for a
new microcode.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/include/asm/microcode.h      |  2 ++
 arch/x86/kernel/cpu/microcode/amd.c   |  2 +-
 arch/x86/kernel/cpu/microcode/core.c  | 22 +++++++++++++++++-----
 arch/x86/kernel/cpu/microcode/intel.c |  4 ++--
 4 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 38b501d842de..4baca634c2f7 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -43,6 +43,8 @@ struct ucode_patch {
 extern struct list_head microcode_cache;
 extern int ucode_updating;
 
+extern bool ucode_load_same;
+
 struct cpu_signature {
 	unsigned int sig;
 	unsigned int pf;
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index c18d3f01a452..124461e2d7a1 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -694,7 +694,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
 
 	/* need to apply patch? */
-	if (rev >= mc_amd->hdr.patch_id) {
+	if (rev >= mc_amd->hdr.patch_id && !ucode_load_same) {
 		ret = UCODE_OK;
 		goto out;
 	}
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index eb2caa74de01..632c7a1fcffb 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -23,6 +23,7 @@
 #include <linux/miscdevice.h>
 #include <linux/capability.h>
 #include <linux/firmware.h>
+#include <linux/debugfs.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
@@ -46,6 +47,7 @@
 
 static struct microcode_ops	*microcode_ops;
 static bool dis_ucode_ldr = true;
+bool ucode_load_same;
 
 bool initrd_gone;
 
@@ -542,11 +544,12 @@ static int __reload_late(void *info)
 		goto wait_for_siblings;
 	}
 
-	if (err >= UCODE_NFOUND) {
-		if (err == UCODE_ERROR)
+	if (ret || err >= UCODE_NFOUND) {
+		if (err == UCODE_ERROR ||
+		    (err == UCODE_NFOUND && !ucode_load_same)) {
 			pr_warn("Error reloading microcode on CPU %d\n", cpu);
-
-		ret = -1;
+			ret = -1;
+		}
 	}
 
 wait_for_siblings:
@@ -636,9 +639,12 @@ static ssize_t reload_store(struct device *dev,
 	}
 
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
-	if (tmp_ret != UCODE_NEW)
+	if (tmp_ret != UCODE_NEW && !ucode_load_same)
 		goto put;
 
+	if (tmp_ret != UCODE_NEW)
+		pr_info("Force loading ucode\n");
+
 	mutex_lock(&microcode_mutex);
 	ret = microcode_reload_late();
 	mutex_unlock(&microcode_mutex);
@@ -841,6 +847,7 @@ static const struct attribute_group cpu_root_microcode_group = {
 static int __init microcode_init(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
+	static struct dentry *dentry_ucode;
 	int error;
 
 	if (dis_ucode_ldr)
@@ -884,7 +891,12 @@ static int __init microcode_init(void)
 	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
 				  mc_cpu_online, mc_cpu_down_prep);
 
+	dentry_ucode = debugfs_create_dir("microcode", NULL);
+	debugfs_create_bool("load_same", 0644, dentry_ucode, &ucode_load_same);
+
 	pr_info("Microcode Update Driver: v%s.", DRIVER_VERSION);
+	pr_info("ucode_load_same is %s\n",
+		ucode_load_same ? "enabled" : "disabled");
 
 	return 0;
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index c61aa661ac2f..c9f1e6f5e53b 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -763,7 +763,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	 * already.
 	 */
 	rev = intel_get_microcode_revision();
-	if (rev >= mc->hdr.rev) {
+	if (rev >= mc->hdr.rev && !ucode_load_same) {
 		ret = UCODE_OK;
 		goto out;
 	}
@@ -779,7 +779,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		return UCODE_ERROR;
 	}
 
-	if (bsp && rev != prev_rev) {
+	if (bsp && (rev != prev_rev || ucode_load_same)) {
 		pr_info("updated to revision 0x%x, date = %04x-%02x-%02x\n",
 			rev,
 			mc->hdr.date & 0xffff,
-- 
2.34.1

