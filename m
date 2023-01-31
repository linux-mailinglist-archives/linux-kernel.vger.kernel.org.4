Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223E7683AA8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjAaXpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjAaXo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:44:58 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8744DE03;
        Tue, 31 Jan 2023 15:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675208697; x=1706744697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mvhv6zkaH9H97cKt0p0n94x4bwBzoDv9AW5TNmZ4ZsU=;
  b=T+/5KMmazvK4W1YlOvzqkYJ9oBt8KMXf/DCduU0FCxDTrUIdfJ6KjiZ8
   plEmjFj5n75xDgcb1QF/ypZIIVWE6NY5m4/Xx1fH3qtm0eUUyKDfGSmtJ
   ISUpjFpVvJ1jhwRvwgu6ChzQqzyTmkgh3LagLKnNg/+f3yKZ8GPjfSKR2
   xWkBJfP5fysz2A71BONdA403MMeRZk3K9Eft39nW5ncqKAFr9k11pVqhX
   n+s7CvHpiDn3MDg0pmdc7XWag66psftJY9dHoVLeD/agItXDj7JhzDH5t
   mm9RaqvwSmmx+Y/Bpd5BCAzjWyfLugPNyRHe9Wz4+Em1qxdT91RjiW5CY
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="390360422"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="390360422"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 15:44:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="773192027"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="773192027"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 15:44:55 -0800
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
Subject: [PATCH 2/5] platform/x86/intel/ifs: Introduce Array Scan test to IFS
Date:   Tue, 31 Jan 2023 15:42:59 -0800
Message-Id: <20230131234302.3997223-3-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230131234302.3997223-1-jithu.joseph@intel.com>
References: <20230131234302.3997223-1-jithu.joseph@intel.com>
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

