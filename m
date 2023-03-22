Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4FB6C3F32
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 01:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCVAiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 20:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjCVAiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 20:38:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3CF5B8D;
        Tue, 21 Mar 2023 17:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679445485; x=1710981485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tR8Yd0RAdqIs10hjw9+2qyYnDXiukGHnJw3oTb13eQc=;
  b=bmzjGiEmHtHEnjH4cR6p2eqin9eY7YCMP67Y259N4ms11xQ6kG6P8cEs
   floL70OAyxmY4vnHdWewBdIKO/0U6KzBQedyBZJj+BJa6Mkqht9YeLchD
   9hD39MZp6lqIi7/BTr/L5gVi1PiWbpi1bspb3wZz2wYHAc5FgNxHFW5s/
   C0KMpjKNvK3y1NYRLke+5xxxoL13aCCJpXVEPI4e/7/AIe8tNIWz6hAra
   1DvYfQ4HhZ+wj6x+B/TsNnkoeTDolT5hn+7ST4x8hu7wU8h1tfjy6gyas
   x2q0dXOOrv4oaecJTI87mklHl9x1v9+iihp3yHbRaOacpkxNsXxaEBlWm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="322934908"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="322934908"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:38:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="675076035"
X-IronPort-AV: E=Sophos;i="5.98,280,1673942400"; 
   d="scan'208";a="675076035"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:38:03 -0700
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
Subject: [PATCH v4 3/9] platform/x86/intel/ifs: IFS cleanup
Date:   Tue, 21 Mar 2023 17:33:53 -0700
Message-Id: <20230322003359.213046-4-jithu.joseph@intel.com>
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

Cleanup incorporating misc review comments

 - Remove the subdirectory intel_ifs/0 for devicenode [1]
 - Make plat_ifs_groups non static and use it directly without using a
    function [2]

Link: https://lore.kernel.org/lkml/Y+4kQOtrHt5pdsSO@kroah.com/ [1]
Link: https://lore.kernel.org/lkml/Y9nyxNesVHCUXAcH@kroah.com/  [2]

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/intel/ifs/ifs.h   | 2 +-
 drivers/platform/x86/intel/ifs/core.c  | 6 +++---
 drivers/platform/x86/intel/ifs/sysfs.c | 9 +--------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index d9c1a1f3e31d..55bcc70c2966 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -252,6 +252,6 @@ static inline const struct ifs_test_caps *ifs_get_test_caps(struct device *dev)
 extern bool *ifs_pkg_auth;
 int ifs_load_firmware(struct device *dev);
 int do_core_test(int cpu, struct device *dev);
-const struct attribute_group **ifs_get_groups(void);
+extern struct attribute *plat_ifs_attrs[];
 
 #endif
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index e2bf728eefdf..f272644617a3 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -20,6 +20,8 @@ static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
 };
 MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
 
+ATTRIBUTE_GROUPS(plat_ifs);
+
 bool *ifs_pkg_auth;
 
 static const struct ifs_test_caps scan_test = {
@@ -31,8 +33,8 @@ static struct ifs_device ifs_device = {
 	.test_caps = &scan_test,
 	.misc = {
 		.name = "intel_ifs_0",
-		.nodename = "intel_ifs/0",
 		.minor = MISC_DYNAMIC_MINOR,
+		.groups = plat_ifs_groups,
 	},
 };
 
@@ -55,8 +57,6 @@ static int __init ifs_init(void)
 	if (rdmsrl_safe(MSR_INTEGRITY_CAPS, &msrval))
 		return -ENODEV;
 
-	ifs_device.misc.groups = ifs_get_groups();
-
 	if (!(msrval & BIT(ifs_device.test_caps->integrity_cap_bit)))
 		return -ENODEV;
 
diff --git a/drivers/platform/x86/intel/ifs/sysfs.c b/drivers/platform/x86/intel/ifs/sysfs.c
index ee636a76b083..2007d8054f04 100644
--- a/drivers/platform/x86/intel/ifs/sysfs.c
+++ b/drivers/platform/x86/intel/ifs/sysfs.c
@@ -141,7 +141,7 @@ static ssize_t image_version_show(struct device *dev,
 static DEVICE_ATTR_RO(image_version);
 
 /* global scan sysfs attributes */
-static struct attribute *plat_ifs_attrs[] = {
+struct attribute *plat_ifs_attrs[] = {
 	&dev_attr_details.attr,
 	&dev_attr_status.attr,
 	&dev_attr_run_test.attr,
@@ -149,10 +149,3 @@ static struct attribute *plat_ifs_attrs[] = {
 	&dev_attr_image_version.attr,
 	NULL
 };
-
-ATTRIBUTE_GROUPS(plat_ifs);
-
-const struct attribute_group **ifs_get_groups(void)
-{
-	return plat_ifs_groups;
-}
-- 
2.25.1

