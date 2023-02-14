Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0078E697207
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjBNXqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBNXp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:45:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FFB2914A;
        Tue, 14 Feb 2023 15:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676418356; x=1707954356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FZhdytTplH8hafL4/6++wppoH2ryGQJ9fu1jV9238GY=;
  b=eWjEPY2gqEvbANrEkPWUVxpFjBToTT1qtAw6tRUCJqu7G6CMSBqXBWn+
   gOA8LlA64JK83YyDwEjQhOwBQ1DRph0UOswlEH2mvVRzNHK4RbgcZZCUg
   ki2WqZzQvqf6tEJ5Skjt/5DILN9y1+51mRdG8kxh+J1WdxsEzEQ/1n0ml
   LFPCfRTZPHkWWIAk1Kx1xfDJYrIC+ZA7C+q4wdfzc3ITYSLVFpyLxFv8h
   Qi5qulSIrtNj7KkuHf76jp6Uw8uoVkFzJB7v+3kY4af9YVDnIPdKvhgJx
   vPRpp33IBl5y7QwqjXfTnuDI64M0uUck/uTbQx+qd1UPuxIz3Y5dL7/aN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="417523018"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="417523018"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 15:45:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="669391014"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="669391014"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 15:45:55 -0800
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
Subject: [PATCH v2 3/7] platform/x86/intel/ifs: Sysfs interface for Array BIST
Date:   Tue, 14 Feb 2023 15:44:22 -0800
Message-Id: <20230214234426.344960-4-jithu.joseph@intel.com>
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

The interface to trigger Array BIST test and obtain its result
is similar to the existing scan test. The only notable
difference is that, Array BIST doesn't require any test content
to be loaded. So binary load related options are not needed for
this test.

Add sysfs interface for array BIST test, the testing support will
be added by subsequent patch.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h     |  1 +
 drivers/platform/x86/intel/ifs/core.c    | 21 ++++++++++++++++-----
 drivers/platform/x86/intel/ifs/runtest.c | 11 ++++++++++-
 drivers/platform/x86/intel/ifs/sysfs.c   | 10 +++++++++-
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 2cef88a88aa9..a0cb2696c1d9 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -249,5 +249,6 @@ static inline struct ifs_data *ifs_get_data(struct device *dev)
 int ifs_load_firmware(struct device *dev);
 int do_core_test(int cpu, struct device *dev);
 const struct attribute_group **ifs_get_groups(void);
+extern struct attribute *plat_ifs_array_attrs[];
 
 #endif
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index ab234620ef4c..d0d4e1fb62f6 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -25,6 +25,7 @@ static struct ifs_device ifs_devices[] = {
 	[IFS_SAF] = {
 		.data = {
 			.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
+			.pkg_auth = NULL,
 			.test_num = IFS_SAF,
 		},
 		.misc = {
@@ -36,6 +37,7 @@ static struct ifs_device ifs_devices[] = {
 	[IFS_ARRAY] = {
 		.data = {
 			.integrity_cap_bit = MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT,
+			.pkg_auth = NULL,
 			.test_num = IFS_ARRAY,
 		},
 		.misc = {
@@ -48,6 +50,8 @@ static struct ifs_device ifs_devices[] = {
 
 #define IFS_NUMTESTS ARRAY_SIZE(ifs_devices)
 
+ATTRIBUTE_GROUPS(plat_ifs_array);
+
 static int __init ifs_init(void)
 {
 	const struct x86_cpu_id *m;
@@ -72,11 +76,18 @@ static int __init ifs_init(void)
 		if (!(msrval & BIT(ifs_devices[i].data.integrity_cap_bit)))
 			continue;
 
-		ifs_devices[i].data.pkg_auth = kmalloc_array(topology_max_packages(),
-							     sizeof(bool), GFP_KERNEL);
-		if (!ifs_devices[i].data.pkg_auth)
-			continue;
-		ifs_devices[i].misc.groups = ifs_get_groups();
+		switch (ifs_devices[i].data.test_num) {
+		case IFS_SAF:
+			ifs_devices[i].data.pkg_auth = kmalloc_array(topology_max_packages(),
+								     sizeof(bool), GFP_KERNEL);
+			if (!ifs_devices[i].data.pkg_auth)
+				continue;
+			ifs_devices[i].misc.groups = ifs_get_groups();
+			break;
+		case IFS_ARRAY:
+			ifs_devices[i].misc.groups = plat_ifs_array_groups;
+			break;
+		}
 
 		if (misc_register(&ifs_devices[i].misc))
 			kfree(ifs_devices[i].data.pkg_auth);
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 0bfd8fcdd7e8..65e08af70994 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -236,6 +236,7 @@ static void ifs_test_core(int cpu, struct device *dev)
  */
 int do_core_test(int cpu, struct device *dev)
 {
+	struct ifs_data *ifsd = ifs_get_data(dev);
 	int ret = 0;
 
 	/* Prevent CPUs from being taken offline during the scan test */
@@ -247,7 +248,15 @@ int do_core_test(int cpu, struct device *dev)
 		goto out;
 	}
 
-	ifs_test_core(cpu, dev);
+	switch (ifsd->test_num) {
+	case IFS_SAF:
+		ifs_test_core(cpu, dev);
+		break;
+	case IFS_ARRAY:
+	default:
+		return -EINVAL;
+	}
+
 out:
 	cpus_read_unlock();
 	return ret;
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index ee636a76b083..3e205fead7ab 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -75,7 +75,7 @@ static ssize_t run_test_store(struct device *dev,
 	if (down_interruptible(&ifs_sem))
 		return -EINTR;
 
-	if (!ifsd->loaded)
+	if (ifsd->test_num != IFS_ARRAY && !ifsd->loaded)
 		rc = -EPERM;
 	else
 		rc = do_core_test(cpu, dev);
@@ -156,3 +156,11 @@ const struct attribute_group **ifs_get_groups(void)
 {
 	return plat_ifs_groups;
 }
+
+/* global array sysfs attributes */
+struct attribute *plat_ifs_array_attrs[] = {
+	&dev_attr_details.attr,
+	&dev_attr_status.attr,
+	&dev_attr_run_test.attr,
+	NULL
+};
-- 
2.25.1

