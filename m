Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9876A6536
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCACBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjCACBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:01:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EFB1C333;
        Tue, 28 Feb 2023 18:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677636072; x=1709172072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8uVqk5jgAaGyZ47qhmWNzlU6s2zEuRvU+z9XkLL6LXs=;
  b=AT56iUkEtKiQ0OrdhJ/hNLNlOTrTy9w4Yega06OnDdaxh8DWd2Tw8JeJ
   znF7kZk04LPARNN8rggq9SWttBIgvzYIiVVP6zn2U2jEPbWaswuwhlZob
   mHL0KFcyLYHFpgLyn8eQYfUPAWRSNTJeyhZKeG+ZoABTBnXpGu5oyjv1k
   msvUg5/jfSSw2kK6QnsexS0UunNZm5LRZo+kKr6MntuSezt9rhM7lY5GA
   7YDS+yAB7+6/M3R6iAzwEeKOoR+SXBqQvkGuxQmUCqWfPg+usPmpy1Wgf
   kEab0lrBP/+Vj8w/Mmyq6R74JZmkuzgyddhm6RgZvj50eVzEY838+A9As
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="420558411"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="420558411"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 18:01:11 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="704639937"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="704639937"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 18:01:10 -0800
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
Subject: [PATCH v3 1/8] platform/x86/intel/ifs: Reorganize driver data
Date:   Tue, 28 Feb 2023 17:59:35 -0800
Message-Id: <20230301015942.462799-2-jithu.joseph@intel.com>
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

The struct holding device driver data contained both read only(ro)
and read write(rw) fields.

Separating ro fields from rw fields was recommended as
a preferable design pattern during review[1].

Group the rw fields into a separate struct whose memory is allocated
during driver_init(). Associate it to the miscdevice being registered
by keeping it in the same container struct as the miscdevice.

Also in prepration to supporting additional tests, move ifs_pkg_auth
to a global as it is only applicable for the first test type.

Link: https://lore.kernel.org/lkml/Y+9H9otxLYPqMkUh@kroah.com/ [1]

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h  | 19 +++++++++-------
 drivers/platform/x86/intel/ifs/core.c | 31 ++++++++++++++++++---------
 drivers/platform/x86/intel/ifs/load.c |  8 +++----
 3 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 046e39304fd5..e07463c794d4 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -197,22 +197,23 @@ union ifs_status {
 #define IFS_SW_TIMEOUT				0xFD
 #define IFS_SW_PARTIAL_COMPLETION		0xFE
 
+struct ifs_const_data {
+	int	integrity_cap_bit;
+	int	test_num;
+};
+
 /**
  * struct ifs_data - attributes related to intel IFS driver
- * @integrity_cap_bit: MSR_INTEGRITY_CAPS bit enumerating this test
  * @loaded_version: stores the currently loaded ifs image version.
- * @pkg_auth: array of bool storing per package auth status
  * @loaded: If a valid test binary has been loaded into the memory
  * @loading_error: Error occurred on another CPU while loading image
  * @valid_chunks: number of chunks which could be validated.
  * @status: it holds simple status pass/fail/untested
  * @scan_details: opaque scan status code from h/w
  * @cur_batch: number indicating the currently loaded test file
- * @test_num: number indicating the test type
+ * @ro_info: ptr to struct holding fixed details
  */
 struct ifs_data {
-	int	integrity_cap_bit;
-	bool	*pkg_auth;
 	int	loaded_version;
 	bool	loaded;
 	bool	loading_error;
@@ -220,7 +221,7 @@ struct ifs_data {
 	int	status;
 	u64	scan_details;
 	u32	cur_batch;
-	int	test_num;
+	struct ifs_const_data *ro_info;
 };
 
 struct ifs_work {
@@ -229,7 +230,8 @@ struct ifs_work {
 };
 
 struct ifs_device {
-	struct ifs_data data;
+	struct ifs_const_data ro_data;
+	struct ifs_data *rw_data;
 	struct miscdevice misc;
 };
 
@@ -238,9 +240,10 @@ static inline struct ifs_data *ifs_get_data(struct device *dev)
 	struct miscdevice *m = dev_get_drvdata(dev);
 	struct ifs_device *d = container_of(m, struct ifs_device, misc);
 
-	return &d->data;
+	return d->rw_data;
 }
 
+extern bool *ifs_pkg_auth;
 int ifs_load_firmware(struct device *dev);
 int do_core_test(int cpu, struct device *dev);
 const struct attribute_group **ifs_get_groups(void);
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 206a617c2e02..b518b661daf0 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -20,8 +20,10 @@ static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
 };
 MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
 
+bool *ifs_pkg_auth;
+
 static struct ifs_device ifs_device = {
-	.data = {
+	.ro_data = {
 		.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
 		.test_num = 0,
 	},
@@ -35,8 +37,8 @@ static struct ifs_device ifs_device = {
 static int __init ifs_init(void)
 {
 	const struct x86_cpu_id *m;
+	struct ifs_data *ifsd;
 	u64 msrval;
-	int ret;
 
 	m = x86_match_cpu(ifs_cpu_ids);
 	if (!m)
@@ -53,26 +55,35 @@ static int __init ifs_init(void)
 
 	ifs_device.misc.groups = ifs_get_groups();
 
-	if (!(msrval & BIT(ifs_device.data.integrity_cap_bit)))
+	if (!(msrval & BIT(ifs_device.ro_data.integrity_cap_bit)))
 		return -ENODEV;
 
-	ifs_device.data.pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
-	if (!ifs_device.data.pkg_auth)
+	ifs_pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
+	if (!ifs_pkg_auth)
+		return -ENOMEM;
+
+	ifsd = kzalloc(sizeof(*ifsd), GFP_KERNEL);
+	if (!ifsd)
 		return -ENOMEM;
 
-	ret = misc_register(&ifs_device.misc);
-	if (ret) {
-		kfree(ifs_device.data.pkg_auth);
-		return ret;
+	ifsd->ro_info = &ifs_device.ro_data;
+	ifs_device.rw_data = ifsd;
+
+	if (misc_register(&ifs_device.misc)) {
+		kfree(ifsd);
+		kfree(ifs_pkg_auth);
+		return -ENODEV;
 	}
 
 	return 0;
+
 }
 
 static void __exit ifs_exit(void)
 {
 	misc_deregister(&ifs_device.misc);
-	kfree(ifs_device.data.pkg_auth);
+	kfree(ifs_device.rw_data);
+	kfree(ifs_pkg_auth);
 }
 
 module_init(ifs_init);
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index c5c24e6fdc43..cdec3316c08d 100644
--- a/drivers/platform/x86/intel/ifs/load.c
+++ b/drivers/platform/x86/intel/ifs/load.c
@@ -192,7 +192,7 @@ static int scan_chunks_sanity_check(struct device *dev)
 	struct ifs_work local_work;
 	int curr_pkg, cpu, ret;
 
-	memset(ifsd->pkg_auth, 0, (topology_max_packages() * sizeof(bool)));
+	memset(ifs_pkg_auth, 0, (topology_max_packages() * sizeof(bool)));
 	ret = validate_ifs_metadata(dev);
 	if (ret)
 		return ret;
@@ -204,7 +204,7 @@ static int scan_chunks_sanity_check(struct device *dev)
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		curr_pkg = topology_physical_package_id(cpu);
-		if (ifsd->pkg_auth[curr_pkg])
+		if (ifs_pkg_auth[curr_pkg])
 			continue;
 		reinit_completion(&ifs_done);
 		local_work.dev = dev;
@@ -215,7 +215,7 @@ static int scan_chunks_sanity_check(struct device *dev)
 			ret = -EIO;
 			goto out;
 		}
-		ifsd->pkg_auth[curr_pkg] = 1;
+		ifs_pkg_auth[curr_pkg] = 1;
 	}
 	ret = 0;
 out:
@@ -263,7 +263,7 @@ int ifs_load_firmware(struct device *dev)
 	int ret = -EINVAL;
 
 	snprintf(scan_path, sizeof(scan_path), "intel/ifs_%d/%02x-%02x-%02x-%02x.scan",
-		 ifsd->test_num, boot_cpu_data.x86, boot_cpu_data.x86_model,
+		 ifsd->ro_info->test_num, boot_cpu_data.x86, boot_cpu_data.x86_model,
 		 boot_cpu_data.x86_stepping, ifsd->cur_batch);
 
 	ret = request_firmware_direct(&fw, scan_path, dev);
-- 
2.25.1

