Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A155B6C3F28
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 01:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjCVAiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 20:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCVAiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 20:38:05 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956B45261;
        Tue, 21 Mar 2023 17:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679445483; x=1710981483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KQ8B+/SmB6Ps2PdDC2JGIJkpyzpOfVhnUhlP4BJLxJY=;
  b=ewoJ5mwPuOpNSeHzXqVQcq5Lh6qT+fRPqymVgq6EvET0DvTctEP2/MUh
   KlPd88o+YKu0pBIxFb1vHaLnu/VdTKlpE/x2j6SnDWpwQH7LnC7J2Ho7J
   l0YsQqopT/iNL6HM4PaUUtpwF86JZD6/KBHP4rbvpetN1aagEXZAUHzlR
   1ezUxJHrD+EimeZ+ZYBnjXekTo5cDanQf5V4/gv143dBl10SB51fQ1rN4
   cjg91gMFxJvFoKQe1k7RWKZ5XErCitb6e16Q1oNyLrZShFVOdAIIFWF0t
   NnVsTCrF2W8BRcjXaJUBv1lLS+GWwQoJhqGXcX/CDWVYumkQYMlDhf+Sr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="322934890"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="322934890"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:38:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="675076027"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="675076027"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:38:01 -0700
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
Subject: [PATCH v4 1/9] platform/x86/intel/ifs: Separate ifs_pkg_auth from ifs_data
Date:   Tue, 21 Mar 2023 17:33:51 -0700
Message-Id: <20230322003359.213046-2-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322003359.213046-1-jithu.joseph@intel.com>
References: <20230301015942.462799-1-jithu.joseph@intel.com>
 <20230322003359.213046-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to supporting additional tests, remove ifs_pkg_auth
from per-test scope, as it is only applicable for one test type.

This will simplify ifs_init() flow when multiple tests are added.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h  |  3 +--
 drivers/platform/x86/intel/ifs/core.c | 10 ++++++----
 drivers/platform/x86/intel/ifs/load.c |  6 +++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 046e39304fd5..221413b79281 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -201,7 +201,6 @@ union ifs_status {
  * struct ifs_data - attributes related to intel IFS driver
  * @integrity_cap_bit: MSR_INTEGRITY_CAPS bit enumerating this test
  * @loaded_version: stores the currently loaded ifs image version.
- * @pkg_auth: array of bool storing per package auth status
  * @loaded: If a valid test binary has been loaded into the memory
  * @loading_error: Error occurred on another CPU while loading image
  * @valid_chunks: number of chunks which could be validated.
@@ -212,7 +211,6 @@ union ifs_status {
  */
 struct ifs_data {
 	int	integrity_cap_bit;
-	bool	*pkg_auth;
 	int	loaded_version;
 	bool	loaded;
 	bool	loading_error;
@@ -241,6 +239,7 @@ static inline struct ifs_data *ifs_get_data(struct device *dev)
 	return &d->data;
 }
 
+extern bool *ifs_pkg_auth;
 int ifs_load_firmware(struct device *dev);
 int do_core_test(int cpu, struct device *dev);
 const struct attribute_group **ifs_get_groups(void);
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 206a617c2e02..3176d94b1fe5 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -20,6 +20,8 @@ static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
 };
 MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
 
+bool *ifs_pkg_auth;
+
 static struct ifs_device ifs_device = {
 	.data = {
 		.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
@@ -56,13 +58,13 @@ static int __init ifs_init(void)
 	if (!(msrval & BIT(ifs_device.data.integrity_cap_bit)))
 		return -ENODEV;
 
-	ifs_device.data.pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
-	if (!ifs_device.data.pkg_auth)
+	ifs_pkg_auth = kmalloc_array(topology_max_packages(), sizeof(bool), GFP_KERNEL);
+	if (!ifs_pkg_auth)
 		return -ENOMEM;
 
 	ret = misc_register(&ifs_device.misc);
 	if (ret) {
-		kfree(ifs_device.data.pkg_auth);
+		kfree(ifs_pkg_auth);
 		return ret;
 	}
 
@@ -72,7 +74,7 @@ static int __init ifs_init(void)
 static void __exit ifs_exit(void)
 {
 	misc_deregister(&ifs_device.misc);
-	kfree(ifs_device.data.pkg_auth);
+	kfree(ifs_pkg_auth);
 }
 
 module_init(ifs_init);
diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
index c5c24e6fdc43..74a50e99cacd 100644
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
-- 
2.25.1

