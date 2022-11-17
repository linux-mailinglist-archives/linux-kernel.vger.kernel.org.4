Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D16D62E590
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 21:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbiKQUBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 15:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiKQUBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 15:01:25 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F2A7EC9A;
        Thu, 17 Nov 2022 12:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668715284; x=1700251284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JZAqYHXX3Zowv4qFiLkNY0ZQXmYsKWrL4YoY5pdFWWs=;
  b=V3/9tyNNkFj8QO6S5WoFOi+iFaAR5ys3GCC7F8LD8iBjxzjeoycMGimt
   BRnTUMG1UV8zb0O4ebvGLkEYGUxnwUKFfnT9Y45EXSYQ97biN8oX84f/H
   JwdMVkrKCZM52E4Pkhhuhclo4A61yc99m7bE/gxBGsnYE9zEzCTUlydIy
   OTZaDWfvv+rwVjo3/YZTCW5h+jguCIizlQP5lFaTJPHEdCizdhtJ6oVbY
   08BiUj0JCYxBKMnRV2BXO0cFLpBL4HeVMQNZqHUnw/OTPo5aXDpvXx+zB
   l2LzzrjjAvEis7peCM82Lt8jGXWk3J5Kb9YWWY+2DiFgfemhWzJy9UO+m
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="292664330"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="292664330"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 12:01:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="782372429"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="782372429"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 12:01:20 -0800
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
Date:   Thu, 17 Nov 2022 11:59:57 -0800
Message-Id: <20221117195957.28225-1-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c7414e8b-c113-eff8-b435-ddde705a6f6c@redhat.com>
References: <c7414e8b-c113-eff8-b435-ddde705a6f6c@redhat.com>
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

Move the memory allocation to init path and store the pointer
in ifs_data struct.

Also rearrange the adjacent error checking in init for a
more simplified and natural flow.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
---
 - Replaced global pkg_auth pointer to struct ifs_data (Hans)
 - Rearrange the adjacent error checking flow in ifs_init (Hans)
 - With this change there are conflicts in patches 11 and 12 (I will
    post the updated 11 and 12 if this is satisfactory)

 drivers/platform/x86/intel/ifs/ifs.h  |  2 ++
 drivers/platform/x86/intel/ifs/core.c | 20 ++++++++++++++++----
 drivers/platform/x86/intel/ifs/load.c | 14 ++++----------
 3 files changed, 22 insertions(+), 14 deletions(-)

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
index 5fb7f655c291..943eb2a17c64 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -4,6 +4,7 @@
 #include <linux/module.h>
 #include <linux/kdev_t.h>
 #include <linux/semaphore.h>
+#include <linux/slab.h>
 
 #include <asm/cpu_device_id.h>
 
@@ -34,6 +35,7 @@ static int __init ifs_init(void)
 {
 	const struct x86_cpu_id *m;
 	u64 msrval;
+	int ret;
 
 	m = x86_match_cpu(ifs_cpu_ids);
 	if (!m)
@@ -50,16 +52,26 @@ static int __init ifs_init(void)
 
 	ifs_device.misc.groups = ifs_get_groups();
 
-	if ((msrval & BIT(ifs_device.data.integrity_cap_bit)) &&
-	    !misc_register(&ifs_device.misc))
-		return 0;
+	if (!(msrval & BIT(ifs_device.data.integrity_cap_bit)))
+		return -ENODEV;
+
+	ifs_device.data.pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
+	if (!ifs_device.data.pkg_auth)
+		return -ENOMEM;
+
+	ret = misc_register(&ifs_device.misc);
+	if (ret) {
+		kfree(ifs_device.data.pkg_auth);
+		return ret;
+	}
 
-	return -ENODEV;
+	return 0;
 }
 
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

