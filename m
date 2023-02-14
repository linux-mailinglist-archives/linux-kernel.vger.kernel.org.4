Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F4069720C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjBNXqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjBNXp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:45:56 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86272BF18;
        Tue, 14 Feb 2023 15:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676418355; x=1707954355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mvhv6zkaH9H97cKt0p0n94x4bwBzoDv9AW5TNmZ4ZsU=;
  b=Cqq0Gxw76Sylkd4H9mN2Uv+Qoi4mCb+hcCOxr+zFyxtGtbEESUfE6gWL
   HNrsxiwcvAHu8bITbrZQwiYTD9kqMf7oqZlUJ9g+AS+JE7UaU2taYdtuA
   4zYUo/fXS7KuKozxt0vrfkKf5zJAX7EbnQEa0wwXGA/J7BFKqphZIsba8
   1TI4mqxAbXhawB6EyRTWaeGN8V59Cj3i2ZotVmPEEaUp0arzVnEbWCXeZ
   hgpRzl0W2G8KjgSram1AFD4kNvkUWJO9REJfOnwf4fNfnSXAUafWiH/vO
   11IFtiozbbWG/v/feXMsZ7WTD1y25fQV8gtoDj9uDN5EKlM23Jd2UmzvN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="417523003"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="417523003"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 15:45:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="669391011"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="669391011"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 15:45:54 -0800
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
Subject: [PATCH v2 2/7] platform/x86/intel/ifs: Introduce Array Scan test to IFS
Date:   Tue, 14 Feb 2023 15:44:21 -0800
Message-Id: <20230214234426.344960-3-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230214234426.344960-1-jithu.joseph@intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
 <20230214234426.344960-1-jithu.joseph@intel.com>
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
 drivers/platform/x86/intel/ifs/ifs.h  |  5 ++
 drivers/platform/x86/intel/ifs/core.c | 70 ++++++++++++++++++---------
 2 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 046e39304fd5..2cef88a88aa9 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -137,6 +137,11 @@
 #define SCAN_TEST_PASS				1
 #define SCAN_TEST_FAIL				2
 
+enum test_types {
+	IFS_SAF,
+	IFS_ARRAY,
+};
+
 /* MSR_SCAN_HASHES_STATUS bit fields */
 union ifs_scan_hashes_status {
 	u64	data;
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 206a617c2e02..ab234620ef4c 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -16,27 +16,44 @@
 
 static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
 	X86_MATCH(SAPPHIRERAPIDS_X),
+	X86_MATCH(EMERALDRAPIDS_X),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
 
-static struct ifs_device ifs_device = {
-	.data = {
-		.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
-		.test_num = 0,
+static struct ifs_device ifs_devices[] = {
+	[IFS_SAF] = {
+		.data = {
+			.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
+			.test_num = IFS_SAF,
+		},
+		.misc = {
+			.name = "intel_ifs_0",
+			.nodename = "intel_ifs/0",
+			.minor = MISC_DYNAMIC_MINOR,
+		},
 	},
-	.misc = {
-		.name = "intel_ifs_0",
-		.nodename = "intel_ifs/0",
-		.minor = MISC_DYNAMIC_MINOR,
+	[IFS_ARRAY] = {
+		.data = {
+			.integrity_cap_bit = MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT,
+			.test_num = IFS_ARRAY,
+		},
+		.misc = {
+			.name = "intel_ifs_1",
+			.nodename = "intel_ifs/1",
+			.minor = MISC_DYNAMIC_MINOR,
+		},
 	},
 };
 
+#define IFS_NUMTESTS ARRAY_SIZE(ifs_devices)
+
 static int __init ifs_init(void)
 {
 	const struct x86_cpu_id *m;
+	int ndevices = 0;
 	u64 msrval;
-	int ret;
+	int i;
 
 	m = x86_match_cpu(ifs_cpu_ids);
 	if (!m)
@@ -51,28 +68,35 @@ static int __init ifs_init(void)
 	if (rdmsrl_safe(MSR_INTEGRITY_CAPS, &msrval))
 		return -ENODEV;
 
-	ifs_device.misc.groups = ifs_get_groups();
-
-	if (!(msrval & BIT(ifs_device.data.integrity_cap_bit)))
-		return -ENODEV;
+	for (i = 0; i < IFS_NUMTESTS; i++) {
+		if (!(msrval & BIT(ifs_devices[i].data.integrity_cap_bit)))
+			continue;
 
-	ifs_device.data.pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
-	if (!ifs_device.data.pkg_auth)
-		return -ENOMEM;
+		ifs_devices[i].data.pkg_auth = kmalloc_array(topology_max_packages(),
+							     sizeof(bool), GFP_KERNEL);
+		if (!ifs_devices[i].data.pkg_auth)
+			continue;
+		ifs_devices[i].misc.groups = ifs_get_groups();
 
-	ret = misc_register(&ifs_device.misc);
-	if (ret) {
-		kfree(ifs_device.data.pkg_auth);
-		return ret;
+		if (misc_register(&ifs_devices[i].misc))
+			kfree(ifs_devices[i].data.pkg_auth);
+		else
+			ndevices++;
 	}
 
-	return 0;
+	return ndevices ? 0 : -ENODEV;
 }
 
 static void __exit ifs_exit(void)
 {
-	misc_deregister(&ifs_device.misc);
-	kfree(ifs_device.data.pkg_auth);
+	int i;
+
+	for (i = 0; i < IFS_NUMTESTS; i++) {
+		if (ifs_devices[i].misc.this_device) {
+			misc_deregister(&ifs_devices[i].misc);
+			kfree(ifs_devices[i].data.pkg_auth);
+		}
+	}
 }
 
 module_init(ifs_init);
-- 
2.25.1

