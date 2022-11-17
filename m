Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E257C62D20B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 05:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239161AbiKQEBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 23:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiKQEA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 23:00:58 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4164B987;
        Wed, 16 Nov 2022 20:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668657657; x=1700193657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I+6q8OWkdcOdkqEfAt26lA7GoyOqUkvnJVI6O2aVclE=;
  b=KDLng98JYJ4nioBucOegbRpREMzuzxhBn18LM9B5JWTVyvHBPk383f2a
   4DPZbAPcrpRcYA7e1Q3cLBhRpuzYcg/MZjB84mOqc6gM4XTf+Arn39eNS
   F3WxFbfP3k+MPPM3WEEACseSuZxSBku/X76pyFlwQf3HsNfvWpfc+Miej
   LqV9pGRHAh854c84y/93m/KE5dBA9SgZIha5tJvepekRYtWg2qw5u5Ydb
   P5gYmhPNwlg9WyVw/624tr7E1PrUpdP8QH4Sssr82jdG0rrg6Jq0E7Hc0
   vkwHGpnNBkQWnK0ytW+axw2OVtWryld9sc1HBXbaM8I19jLzXJvUfdqpX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="292455958"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="292455958"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 20:00:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590462674"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="590462674"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 20:00:56 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: [PATCH v3 04/16] platform/x86/intel/ifs: Remove memory allocation from load path
Date:   Wed, 16 Nov 2022 19:59:23 -0800
Message-Id: <20221117035935.4136738-5-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221117035935.4136738-1-jithu.joseph@intel.com>
References: <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221117035935.4136738-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IFS requires tests to be authenticated once for each CPU socket
on a system.

scan_chunks_sanity_check() was dynamically allocating memory
to store the state of whether tests have been authenticated on
each socket for every load operation.

Move the memory allocation to init path.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h  |  2 ++
 drivers/platform/x86/intel/ifs/core.c | 13 +++++++++++--
 drivers/platform/x86/intel/ifs/load.c | 14 ++++----------
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 3ff1d9aaeaa9..3a051890d9e7 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -229,4 +229,6 @@ void ifs_load_firmware(struct device *dev);
 int do_core_test(int cpu, struct device *dev);
 const struct attribute_group **ifs_get_groups(void);
 
+extern bool *ifs_pkg_auth;
+
 #endif
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 5fb7f655c291..4b39f2359180 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -4,6 +4,7 @@
 #include <linux/module.h>
 #include <linux/kdev_t.h>
 #include <linux/semaphore.h>
+#include <linux/slab.h>
 
 #include <asm/cpu_device_id.h>
 
@@ -30,6 +31,8 @@ static struct ifs_device ifs_device = {
 	},
 };
 
+bool *ifs_pkg_auth;
+
 static int __init ifs_init(void)
 {
 	const struct x86_cpu_id *m;
@@ -51,8 +54,13 @@ static int __init ifs_init(void)
 	ifs_device.misc.groups = ifs_get_groups();
 
 	if ((msrval & BIT(ifs_device.data.integrity_cap_bit)) &&
-	    !misc_register(&ifs_device.misc))
-		return 0;
+	    !misc_register(&ifs_device.misc)) {
+		ifs_pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
+		if (!ifs_pkg_auth)
+			return -ENOMEM;
+		else
+			return 0;
+	}
 
 	return -ENODEV;
 }
@@ -60,6 +68,7 @@ static int __init ifs_init(void)
 static void __exit ifs_exit(void)
 {
 	misc_deregister(&ifs_device.misc);
+	kfree(ifs_pkg_auth);
 }
 
 module_init(ifs_init);
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 89ce265887ea..c914e4d359db 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -3,7 +3,6 @@
 
 #include <linux/firmware.h>
 #include <asm/cpu.h>
-#include <linux/slab.h>
 #include <asm/microcode_intel.h>
 
 #include "ifs.h"
@@ -118,16 +117,12 @@ static void copy_hashes_authenticate_chunks(struct work_struct *work)
  */
 static int scan_chunks_sanity_check(struct device *dev)
 {
-	int metadata_size, curr_pkg, cpu, ret = -ENOMEM;
+	int metadata_size, curr_pkg, cpu, ret;
 	struct ifs_data *ifsd = ifs_get_data(dev);
-	bool *package_authenticated;
 	struct ifs_work local_work;
 	char *test_ptr;
 
-	package_authenticated = kcalloc(topology_max_packages(), sizeof(bool), GFP_KERNEL);
-	if (!package_authenticated)
-		return ret;
-
+	memset(ifs_pkg_auth, 0, (topology_max_packages() * sizeof(bool)));
 	metadata_size = ifs_header_ptr->metadata_size;
 
 	/* Spec says that if the Meta Data Size = 0 then it should be treated as 2000 */
@@ -150,7 +145,7 @@ static int scan_chunks_sanity_check(struct device *dev)
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		curr_pkg = topology_physical_package_id(cpu);
-		if (package_authenticated[curr_pkg])
+		if (ifs_pkg_auth[curr_pkg])
 			continue;
 		reinit_completion(&ifs_done);
 		local_work.dev = dev;
@@ -161,12 +156,11 @@ static int scan_chunks_sanity_check(struct device *dev)
 			ret = -EIO;
 			goto out;
 		}
-		package_authenticated[curr_pkg] = 1;
+		ifs_pkg_auth[curr_pkg] = 1;
 	}
 	ret = 0;
 out:
 	cpus_read_unlock();
-	kfree(package_authenticated);
 
 	return ret;
 }
-- 
2.25.1

