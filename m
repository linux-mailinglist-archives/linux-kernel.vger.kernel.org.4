Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0857681CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjA3Vkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjA3Vk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:40:27 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4995B3A848
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675114818; x=1706650818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iIQEszT1vO2aPTOWcm3Liobv4FND6X8rf9yqm6IiYKw=;
  b=I+8f5VlsB2TvnSZiS98a+BmZ65dKJr1JcSuBd5jDeJNHAt7F7qCqWoJN
   1azwrfnwbVgvaR0EeP+por4b2eLJ9l2pl3creRONjdx9sMOklzmWnZOa4
   44OWR+Q6p253THgFQMmjZwKe0csNiXwjblyP4xWpF0mbnIzTZcfL+ovk1
   Bk32EHpv0EVKaNyTE4i43ripob/b8oLgjyFPtAjCbNzc9A4fab2FJP8vF
   9/2LWnhTphtZqRQ2GUC/u8NSHAM3yF6sY7VjAyvtzte7k5AUpxIvH/FSU
   uPFCzRzPpg2bl8KoGJzErnnfk/EehDWekekb9GSogsSZaRhrHbtJoSoew
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="328955574"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="328955574"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:40:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="696571882"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="696571882"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 13:40:13 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ashok Raj <ashok.raj@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
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
Subject: [Patch v3 Part2 9/9] x86/microcode: Provide an option to override minrev enforcement
Date:   Mon, 30 Jan 2023 13:39:55 -0800
Message-Id: <20230130213955.6046-10-ashok.raj@intel.com>
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

Minimum Required Revision (minrev) is enforced strictly. All new patches
will have a minrev that is not zero. But there might be a transition time
for some that need this enforcement to be relaxed.

When the override is enabled, the kernel will be tainted.

Provide a debugfs variable to override the minrev enforcement.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
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
 arch/x86/kernel/cpu/microcode/core.c  | 15 +++++++++++++--
 arch/x86/kernel/cpu/microcode/intel.c |  8 ++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 3d48143e84a9..d82f22d50ebd 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -16,6 +16,8 @@ struct ucode_patch {
 
 extern struct list_head microcode_cache;
 
+extern bool override_minrev;
+
 struct cpu_signature {
 	unsigned int sig;
 	unsigned int pf;
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index be5d70396b79..dbcccbd46ab8 100644
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
@@ -43,7 +44,9 @@
 #define DRIVER_VERSION	"2.2"
 
 static struct microcode_ops	*microcode_ops;
+static struct dentry		*dentry_ucode;
 static bool dis_ucode_ldr = true;
+bool override_minrev;
 
 bool initrd_gone;
 
@@ -494,7 +497,11 @@ static ssize_t reload_store(struct device *dev,
 		pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
 		pr_err("You should switch to early loading, if possible.\n");
 		ret = -EINVAL;
-		goto put;
+
+		if (!override_minrev)
+			goto put;
+
+		pr_info("Overriding minrev\n");
 	}
 
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
@@ -519,7 +526,7 @@ static ssize_t reload_store(struct device *dev,
 	 */
 	if (load_ret == 0) {
 		ret = size;
-		if (!safe_late_load) {
+		if (!safe_late_load || override_minrev) {
 			add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
 			pr_warn("Microcode late loading tainted the kernel\n");
 		}
@@ -692,7 +699,11 @@ static int __init microcode_init(void)
 	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
 				  mc_cpu_online, mc_cpu_down_prep);
 
+	dentry_ucode = debugfs_create_dir("microcode", NULL);
+	debugfs_create_bool("override_minrev", 0644, dentry_ucode, &override_minrev);
+
 	pr_info("Microcode Update Driver: v%s.", DRIVER_VERSION);
+	pr_info("Override minrev %s\n", override_minrev ? "enabled" : "disabled");
 
 	return 0;
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 601c586be7b6..ec5a29ebee8e 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -139,6 +139,14 @@ static int is_lateload_safe(struct microcode_header_intel *mc_header)
 {
 	struct ucode_cpu_info uci;
 
+	/*
+	 * If minrev is bypassed via debugfs, then allow late-load.
+	 */
+	if (override_minrev) {
+		pr_info("Bypassing minrev enforcement via debugfs\n");
+		return 0;
+	}
+
 	/*
 	 * When late-loading, ensure the header declares a minimum revision
 	 * required to perform a late-load.
-- 
2.37.2

