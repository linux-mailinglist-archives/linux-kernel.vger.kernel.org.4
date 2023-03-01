Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250AD6A653B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjCACBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCACBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:01:16 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6811116E;
        Tue, 28 Feb 2023 18:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677636075; x=1709172075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rJiDCSyygrrCuqVsYU6GkuSNqtQTTbAqcfks22kGVi0=;
  b=oHXmonnBw1vhAGMDNGuC8sITYKlolAhO4o9pgg7mlMKs15v8Bx9+gXn1
   UeYZ+HNmznYjr9IS6n4BfEGYW9ULLfuRkMZW/uqdeyg2pMeA/FMyxpGjG
   XdSJTF3dU3FAdbtVV/7M0Xio+TrDLtQBmNwhGbXUNstl4vyCoszrVsd36
   uZtRRzbFfYtMrnGS9UyGU1wo5y2byMdvZ5/J1ZiPf4amj7USpLABtTqJL
   y00IzUd6pU7DrGZXXGGlw21DmWdfYmIUjexC0EwETgV17oWvCKAx7Zx+Z
   nTl4/LNolmiJnX+AHvgZDcn+Q0hT9eAMdzXN21x8crrkYP6i/aGlg47xG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="420558449"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="420558449"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 18:01:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="704639956"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="704639956"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 18:01:12 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH v3 4/8] platform/x86/intel/ifs: Introduce Array Scan test to IFS
Date:   Tue, 28 Feb 2023 17:59:38 -0800
Message-Id: <20230301015942.462799-5-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301015942.462799-1-jithu.joseph@intel.com>
References: <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230301015942.462799-1-jithu.joseph@intel.com>
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

Array BIST is a new type of core test introduced under the Intel Infield
Scan (IFS) suite of tests.

Emerald Rapids (EMR) is the first CPU to support Array BIST.
Array BIST performs tests on some portions of the core logic such as
caches and register files. These are different portions of the silicon
compared to the parts tested by the first test type
i.e Scan at Field (SAF).

Make changes in the device driver init flow to register this new test
type with the device driver framework. Each test will have its own
sysfs directory (intel_ifs_0 , intel_ifs_1) under misc hierarchy to
accommodate for the differences in test type and how they are initiated.

Upcoming patches will add actual support.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h  |  3 +
 drivers/platform/x86/intel/ifs/core.c | 85 +++++++++++++++++++--------
 2 files changed, 62 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index ab168ddf28f1..b8b956e29653 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -137,6 +137,9 @@
 #define SCAN_TEST_PASS				1
 #define SCAN_TEST_FAIL				2
 
+#define IFS_TYPE_SAF			0
+#define IFS_TYPE_ARRAY_BIST		1
+
 /* MSR_SCAN_HASHES_STATUS bit fields */
 union ifs_scan_hashes_status {
 	u64	data;
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 62c44dbae757..2237aaba7078 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -16,6 +16,7 @@
 
 static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
 	X86_MATCH(SAPPHIRERAPIDS_X),
+	X86_MATCH(EMERALDRAPIDS_X),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
@@ -24,23 +25,51 @@ ATTRIBUTE_GROUPS(plat_ifs);
 
 bool *ifs_pkg_auth;
 
-static struct ifs_device ifs_device = {
-	.ro_data = {
-		.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
-		.test_num = 0,
+static struct ifs_device ifs_devices[] = {
+	[IFS_TYPE_SAF] = {
+		.ro_data = {
+			.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
+			.test_num = IFS_TYPE_SAF,
+		},
+		.misc = {
+			.name = "intel_ifs_0",
+			.minor = MISC_DYNAMIC_MINOR,
+			.groups = plat_ifs_groups,
+		},
 	},
-	.misc = {
-		.name = "intel_ifs_0",
-		.minor = MISC_DYNAMIC_MINOR,
-		.groups = plat_ifs_groups,
+	[IFS_TYPE_ARRAY_BIST] = {
+		.ro_data = {
+			.integrity_cap_bit = MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT,
+			.test_num = IFS_TYPE_ARRAY_BIST,
+		},
+		.misc = {
+			.name = "intel_ifs_1",
+			.minor = MISC_DYNAMIC_MINOR,
+		},
 	},
 };
 
+#define IFS_NUMTESTS ARRAY_SIZE(ifs_devices)
+
+static void ifs_cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < IFS_NUMTESTS; i++) {
+		if (ifs_devices[i].misc.this_device) {
+			misc_deregister(&ifs_devices[i].misc);
+			kfree(ifs_devices[i].rw_data);
+		}
+	}
+	kfree(ifs_pkg_auth);
+}
+
 static int __init ifs_init(void)
 {
 	const struct x86_cpu_id *m;
 	struct ifs_data *ifsd;
 	u64 msrval;
+	int i, ret;
 
 	m = x86_match_cpu(ifs_cpu_ids);
 	if (!m)
@@ -55,35 +84,39 @@ static int __init ifs_init(void)
 	if (rdmsrl_safe(MSR_INTEGRITY_CAPS, &msrval))
 		return -ENODEV;
 
-	if (!(msrval & BIT(ifs_device.ro_data.integrity_cap_bit)))
-		return -ENODEV;
-
 	ifs_pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
 	if (!ifs_pkg_auth)
 		return -ENOMEM;
 
-	ifsd = kzalloc(sizeof(*ifsd), GFP_KERNEL);
-	if (!ifsd)
-		return -ENOMEM;
-
-	ifsd->ro_info = &ifs_device.ro_data;
-	ifs_device.rw_data = ifsd;
-
-	if (misc_register(&ifs_device.misc)) {
-		kfree(ifsd);
-		kfree(ifs_pkg_auth);
-		return -ENODEV;
+	for (i = 0; i < IFS_NUMTESTS; i++) {
+		ifsd = NULL;
+		if (!(msrval & BIT(ifs_devices[i].ro_data.integrity_cap_bit)))
+			continue;
+
+		ifsd = kzalloc(sizeof(*ifsd), GFP_KERNEL);
+		if (!ifsd) {
+			ret = -ENOMEM;
+			goto err_exit;
+		}
+		ifsd->ro_info = &ifs_devices[i].ro_data;
+		ifs_devices[i].rw_data = ifsd;
+
+		if (misc_register(&ifs_devices[i].misc)) {
+			ret = -ENODEV;
+			kfree(ifsd);
+			goto err_exit;
+		}
 	}
-
 	return 0;
 
+err_exit:
+	ifs_cleanup();
+	return ret;
 }
 
 static void __exit ifs_exit(void)
 {
-	misc_deregister(&ifs_device.misc);
-	kfree(ifs_device.rw_data);
-	kfree(ifs_pkg_auth);
+	ifs_cleanup();
 }
 
 module_init(ifs_init);
-- 
2.25.1

