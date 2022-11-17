Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE6562E315
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbiKQRbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240363AbiKQRb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:31:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3655679E14;
        Thu, 17 Nov 2022 09:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668706285; x=1700242285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JtQf+wYmqZJM4WTnOnjVIvXY+Y6w+bPb1VhRTxHhJIo=;
  b=lFxXl/OSPlowDb1TZ/3EanHK4jPxzalDpwC5+kkuqS+oeQiukHUv90Lj
   8clSZ4n9kuEWX1Bq2efSVbsBdRmF7/g7vLLG6/iZKlo6ecVlk87FuyoKV
   w2kQtaNaqRGRqmTeiIeeiNtevVyHFUlZuik3/91Q80no/Zh3xJF7VtNH5
   GS8Mg2wfWAYsWb7sCMGKBKXEKAX3je19ZnOGgctoMYj48xftLEVrFHKxk
   ev9qan+HXvXA68UOz/8JPjPwbiso4AV1bG0HSnzk1WQfze3ZFB1/r+9OO
   tscULHpoH3XcUd3njxiMF3sG3F8htpw7SyVqU120DMc1CUZewh7K4Seek
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="312934136"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="312934136"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 09:31:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="745632076"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="745632076"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 09:31:22 -0800
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
Date:   Thu, 17 Nov 2022 09:29:58 -0800
Message-Id: <20221117172958.4172029-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <77e9d0f2-12d9-fc7a-2161-c579b7bbd673@redhat.com>
References: <77e9d0f2-12d9-fc7a-2161-c579b7bbd673@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Move the memory allocation to init path and store the pointer
in ifs_data struct.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 - Replaced global pkg_auth pointer to struct ifs_data (Hans)
 - With this change there are conflicts in patches 11 and 12 (I will
    post the updated 11 and 12 if this is satisfactory)

 drivers/platform/x86/intel/ifs/ifs.h  |  2 ++
 drivers/platform/x86/intel/ifs/core.c | 12 ++++++++++--
 drivers/platform/x86/intel/ifs/load.c | 14 ++++----------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 3ff1d9aaeaa9..8de1952a1b7b 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -191,6 +191,7 @@ union ifs_status {
  * struct ifs_data - attributes related to intel IFS driver
  * @integrity_cap_bit: MSR_INTEGRITY_CAPS bit enumerating this test
  * @loaded_version: stores the currently loaded ifs image version.
+ * @pkg_auth: array of bool storing per package auth status
  * @loaded: If a valid test binary has been loaded into the memory
  * @loading_error: Error occurred on another CPU while loading image
  * @valid_chunks: number of chunks which could be validated.
@@ -199,6 +200,7 @@ union ifs_status {
  */
 struct ifs_data {
 	int	integrity_cap_bit;
+	bool	*pkg_auth;
 	int	loaded_version;
 	bool	loaded;
 	bool	loading_error;
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 5fb7f655c291..6980a31e9786 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -4,6 +4,7 @@
 #include <linux/module.h>
 #include <linux/kdev_t.h>
 #include <linux/semaphore.h>
+#include <linux/slab.h>
 
 #include <asm/cpu_device_id.h>
 
@@ -51,8 +52,14 @@ static int __init ifs_init(void)
 	ifs_device.misc.groups = ifs_get_groups();
 
 	if ((msrval & BIT(ifs_device.data.integrity_cap_bit)) &&
-	    !misc_register(&ifs_device.misc))
-		return 0;
+	    !misc_register(&ifs_device.misc)) {
+		ifs_device.data.pkg_auth = kmalloc_array(topology_max_packages(),
+							 sizeof(bool), GFP_KERNEL);
+		if (!ifs_device.data.pkg_auth)
+			return -ENOMEM;
+		else
+			return 0;
+	}
 
 	return -ENODEV;
 }
@@ -60,6 +67,7 @@ static int __init ifs_init(void)
 static void __exit ifs_exit(void)
 {
 	misc_deregister(&ifs_device.misc);
+	kfree(ifs_device.data.pkg_auth);
 }
 
 module_init(ifs_init);
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index 89ce265887ea..8423c486d11b 100644
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
+	memset(ifsd->pkg_auth, 0, (topology_max_packages() * sizeof(bool)));
 	metadata_size = ifs_header_ptr->metadata_size;
 
 	/* Spec says that if the Meta Data Size = 0 then it should be treated as 2000 */
@@ -150,7 +145,7 @@ static int scan_chunks_sanity_check(struct device *dev)
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		curr_pkg = topology_physical_package_id(cpu);
-		if (package_authenticated[curr_pkg])
+		if (ifsd->pkg_auth[curr_pkg])
 			continue;
 		reinit_completion(&ifs_done);
 		local_work.dev = dev;
@@ -161,12 +156,11 @@ static int scan_chunks_sanity_check(struct device *dev)
 			ret = -EIO;
 			goto out;
 		}
-		package_authenticated[curr_pkg] = 1;
+		ifsd->pkg_auth[curr_pkg] = 1;
 	}
 	ret = 0;
 out:
 	cpus_read_unlock();
-	kfree(package_authenticated);
 
 	return ret;
 }
-- 
2.25.1

