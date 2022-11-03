Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD6D6186D7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiKCSA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiKCR7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:59:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B1B60CE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667498363; x=1699034363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=99EX+KA4C5DAnZxHjIR5rQZoeQgiDfbcKnY78sWqUNw=;
  b=EPdtqU23Iur7VVr/x6qJUeCZIQFc4qTv4YYz6tiAFTKMpfAo7TOEt9PM
   kbcFKi5f9xcQPfRpDwzVDTU+sXXDce1acraUx5tIL+6YUFRPcR7QhLMrh
   yYHhDrjcnP+J6uW8GZQrmBBXqD5dKZEgZI8KFw0dXC8VGdIeN4t+PADYB
   yh+eFfluvw+DIESm8zxSujC9FfOpVQyCQ6D+P7XFIv5PHlIsZ573A+KTz
   lTJRrqdtrRadiEzoW2RyE+LVCVDsofIciRwCbdYW055ub/bh0jWcc3K4B
   CJe702jqRsP+5sA3LWsWA6RADQPwtaG0o3NjyxluABliZAOe9+2++oD6s
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308476975"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="308476975"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 10:59:19 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="809762577"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="809762577"
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
Subject: [v2 13/13] x86/microcode/intel: Add ability to update microcode even if rev is unchanged
Date:   Thu,  3 Nov 2022 17:59:01 +0000
Message-Id: <20221103175901.164783-14-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103175901.164783-1-ashok.raj@intel.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This comes in handy for testing without the need for a new microcode file.
Default is OFF. It can be switched dynamically at run time via debugfs file
/sys/kernel/debug/microcode/load_same.

NOT_FOR_INCLUSION:
Leave it to the discretion of Boris if its suitable for inclusion. It will
at least serve to validate some parts of the series without the need for a
new microcode, since it goes through all the renedezvous parts except not
updating the microcode itself.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/include/asm/microcode.h      |  2 ++
 arch/x86/kernel/cpu/microcode/amd.c   |  2 +-
 arch/x86/kernel/cpu/microcode/core.c  | 23 ++++++++++++++++++-----
 arch/x86/kernel/cpu/microcode/intel.c |  4 ++--
 4 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 6286b4056792..a356a6a5207e 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -47,6 +47,8 @@ struct ucode_patch {
 
 extern struct list_head microcode_cache;
 
+extern bool ucode_load_same;
+
 struct cpu_signature {
 	unsigned int sig;
 	unsigned int pf;
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index b103d5e5f447..802212e194b3 100644
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
index a7d0cbbb2505..2d0cd8ca3ea2 100644
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
@@ -48,6 +49,7 @@
 
 static struct microcode_ops	*microcode_ops;
 static bool dis_ucode_ldr = true;
+bool ucode_load_same;
 
 bool initrd_gone;
 
@@ -490,11 +492,12 @@ static int __reload_late(void *info)
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
@@ -632,9 +635,13 @@ static ssize_t reload_store(struct device *dev,
 	}
 
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
-	if (tmp_ret != UCODE_NEW)
+	if (tmp_ret == UCODE_ERROR ||
+	    (tmp_ret != UCODE_NEW && !ucode_load_same))
 		goto put;
 
+	if (tmp_ret != UCODE_NEW)
+		pr_info("Force loading ucode\n");
+
 	mutex_lock(&microcode_mutex);
 	ret = microcode_reload_late();
 	mutex_unlock(&microcode_mutex);
@@ -781,6 +788,7 @@ static const struct attribute_group cpu_root_microcode_group = {
 static int __init microcode_init(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
+	static struct dentry *dentry_ucode;
 	int error;
 
 	if (dis_ucode_ldr)
@@ -815,7 +823,12 @@ static int __init microcode_init(void)
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
index 7086670da606..08ba6e009d54 100644
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
@@ -782,7 +782,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		return UCODE_ERROR;
 	}
 
-	if (bsp && rev != prev_rev) {
+	if (bsp && (rev != prev_rev || ucode_load_same)) {
 		pr_info("update 0x%x -> 0x%x, date = %04x-%02x-%02x\n",
 			prev_rev, rev,
 			mc->hdr.date & 0xffff,
-- 
2.34.1

