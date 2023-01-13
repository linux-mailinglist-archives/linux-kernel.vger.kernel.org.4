Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3A766A0EE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjAMRoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjAMRnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:43:11 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF93E6C051
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673630974; x=1705166974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=13rDlRrWtSaYMdkY5P+PHEVg2xd/vRWLrnc0TqjnqHE=;
  b=n+hglCmV/37XU2riL74OQcmOZM991MxKDJpEGn5ml/qbCDfK3Sbt8ZLd
   Uzl6cZcT9PyNV6/RK0+4dRghKO8Q6R1UAJCn8AZQtc5CQ9CN4ZZA42Dj1
   Mt9s8uyu2U8oRkHCAuaJNIXbleg8zubpqXrTFJfBxzJMcNh/iF93+QGVC
   G2AUYwSM/mLrcfelYbdbnNqZIIgxeTl9S8nVRpkEXpRH+9aBybiKOaVfR
   ca+ecaWqEkpHOoVShHTZq25v9dqlBZbrrlxtTb/MyLskc5NXj8SrvrrLk
   krM2SPwYNFjfsuygVYb28zzUbv6pY6dnvGfDbAXktY0V73cK4vCWCvbEZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="304430038"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="304430038"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:29:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10589"; a="766089937"
X-IronPort-AV: E=Sophos;i="5.97,214,1669104000"; 
   d="scan'208";a="766089937"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 09:29:33 -0800
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
Subject: [PATCH v1 Part2 5/5] x86/microcode: Provide an option to override minrev enforcement
Date:   Fri, 13 Jan 2023 09:29:20 -0800
Message-Id: <20230113172920.113612-6-ashok.raj@intel.com>
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
This patch is optional.
---
 arch/x86/include/asm/microcode.h      |  2 ++
 arch/x86/kernel/cpu/microcode/core.c  | 13 ++++++++++++-
 arch/x86/kernel/cpu/microcode/intel.c |  8 ++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

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
index 446ddf3fcc29..5ed60c6c8e8d 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -24,6 +24,7 @@
 #include <linux/miscdevice.h>
 #include <linux/capability.h>
 #include <linux/firmware.h>
+#include <linux/debugfs.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
@@ -44,7 +45,9 @@
 #define DRIVER_VERSION	"2.2"
 
 static struct microcode_ops	*microcode_ops;
+static struct dentry		*dentry_ucode;
 static bool dis_ucode_ldr = true;
+bool override_minrev;
 
 bool initrd_gone;
 
@@ -497,7 +500,11 @@ static ssize_t reload_store(struct device *dev,
 		pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
 		pr_err("You should switch to early loading, if possible.\n");
 		ret = -EINVAL;
-		goto put;
+
+		if (!override_minrev)
+			goto put;
+
+		pr_err("Overriding minrev\n");
 	}
 
 	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
@@ -688,7 +695,11 @@ static int __init microcode_init(void)
 	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
 				  mc_cpu_online, mc_cpu_down_prep);
 
+	dentry_ucode = debugfs_create_dir("microcode", NULL);
+	debugfs_create_bool("override_minrev", 0644, dentry_ucode, &override_minrev);
+
 	pr_info("Microcode Update Driver: v%s.", DRIVER_VERSION);
+	pr_info("Override minrev %s\n", override_minrev ? "enabled" : "disabled");
 
 	return 0;
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 68a3c5569cd2..172e1f166844 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -141,6 +141,14 @@ static int is_lateload_safe(struct microcode_header_intel *mc_header)
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
2.34.1

