Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30BB681CFC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjA3Vkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjA3VkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:40:18 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE1410413
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675114817; x=1706650817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HcSaC88LySiU87nVNq6tS5eJMTjnQLKhunjdjxrCwrw=;
  b=MBT0Ii+4iWY/DX0eRrG6QCMjwtcad1sq7lFMDVspShz8/u1H6fW5Dua8
   6faPPy/pVkXBItuTW8c04YoKfGfhdCZrHxWxQXY8bTJmhSDapRknX3Ud6
   ogpp/X+/VwJWI7KO8Awc2U9BXZjFfy5mRmMbA4Fi/PKatRkVQ4+q40jxQ
   ugXtbcAnW7f1V2UGifsG3eW+Ov0QRqKnhWA7w6LZzpeh5mZBkNQxNKeM6
   4xyfxuQeLciRxbC9wwIznICzhNPJ9IzKbvQe3kNjesUx8F5P5mr0Oe4xv
   FEy3ALnA/GBVT19UJW1PW29iMzvRZDNM2BRfk3wLRSZ+6yR/KhFpPul5h
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="328955554"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="328955554"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:40:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="696571876"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="696571876"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:40:12 -0800
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
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>
Subject: [Patch v3 Part2 7/9] x86/microcode: Add a generic mechanism to declare support for minrev
Date:   Mon, 30 Jan 2023 13:39:53 -0800
Message-Id: <20230130213955.6046-8-ashok.raj@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230130213955.6046-1-ashok.raj@intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

Also make CONFIG_MICROCODE_LOADING by default, now that kernel enforces the
"minrev" requirement strictly.

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
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Martin Pohlack <mpohlack@amazon.de>
---
 arch/x86/include/asm/microcode.h      |  2 ++
 arch/x86/kernel/cpu/microcode/core.c  | 26 +++++++++++++++++++++-----
 arch/x86/kernel/cpu/microcode/intel.c |  1 +
 arch/x86/Kconfig                      |  7 ++++---
 4 files changed, 28 insertions(+), 8 deletions(-)

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
index bff566c05f46..be5d70396b79 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -470,6 +470,7 @@ static ssize_t reload_store(struct device *dev,
 {
 	enum ucode_state tmp_ret = UCODE_OK;
 	int bsp = boot_cpu_data.cpu_index;
+	bool safe_late_load = false;
 	unsigned long val;
 	int load_ret = -1;
 	ssize_t ret;
@@ -484,12 +485,25 @@ static ssize_t reload_store(struct device *dev,
 	if (ret)
 		goto put;
 
-	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
-	pr_err("You should switch to early loading, if possible.\n");
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
 
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
 	if (tmp_ret != UCODE_NEW) {
-		ret = size;
+		/*
+		 * If loading fails for some other reason,
+		 * inform user appropriately
+		 */
+		ret = (tmp_ret == UCODE_ERROR) ? -EINVAL : size;
 		goto put;
 	}
 
@@ -505,8 +519,10 @@ static ssize_t reload_store(struct device *dev,
 	 */
 	if (load_ret == 0) {
 		ret = size;
-		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
-		pr_warn("Microcode late loading tainted the kernel\n");
+		if (!safe_late_load) {
+			add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+			pr_warn("Microcode late loading tainted the kernel\n");
+		}
 	}
 
 	return ret;
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 4b3df85f2ca6..98c92b9affa2 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -814,6 +814,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device)
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
2.37.2

