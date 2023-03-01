Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B596A6533
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCACBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCACBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:01:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE231E2B8;
        Tue, 28 Feb 2023 18:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677636074; x=1709172074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8fGhALj/6YuPeeMFkK3yfUkQG/FNpfhZ0YdkO37eDWg=;
  b=SM8JC6Dril1rZycfQdj0I6N+WG+ea0PKLXubU/5gzUFPzbv+jFo8L39D
   kptQQcvSDglVtJcHX/z1IqQSA5WzOOBBLBlY38mQ3c+FkLoNeNjlWHWf9
   mDeCJtnFUPyv5eB47dPtVFS1HXJ7dCQkwE4S/82BV/KNZPkzwUlq22XYs
   F9FCzT2Jg84UX+XRHz/g+2gckV7/yNLOwTl7YPWupz3ZoLX2Z7e0w2e57
   JVH+NvRXz3JWrLvbTep+dYvvWn1foI9kq2OW75d5OIxUnU89qSu5+IDjD
   DXBFgKzdDHTbHINZH54Ns1AjGRcgiMCPZr8IaxlIRyVthJF1vr5x8V4DB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="420558425"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="420558425"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 18:01:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="704639942"
X-IronPort-AV: E=Sophos;i="5.98,223,1673942400"; 
   d="scan'208";a="704639942"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 18:01:11 -0800
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
Subject: [PATCH v3 2/8] platform/x86/intel/ifs: IFS cleanup
Date:   Tue, 28 Feb 2023 17:59:36 -0800
Message-Id: <20230301015942.462799-3-jithu.joseph@intel.com>
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

Cleanup incorporating misc review comments

 - Remove the subdirectory intel_ifs/0 for devicenode [1]
 - Make plat_ifs_groups non static and use it directly without using a
    function [2]

Link: https://lore.kernel.org/lkml/Y+4kQOtrHt5pdsSO@kroah.com/ [1]
Link: https://lore.kernel.org/lkml/Y9nyxNesVHCUXAcH@kroah.com/  [2]

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h   | 2 +-
 drivers/platform/x86/intel/ifs/core.c  | 6 +++---
 drivers/platform/x86/intel/ifs/sysfs.c | 9 +--------
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index e07463c794d4..ab168ddf28f1 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -246,6 +246,6 @@ static inline struct ifs_data *ifs_get_data(struct device *dev)
 extern bool *ifs_pkg_auth;
 int ifs_load_firmware(struct device *dev);
 int do_core_test(int cpu, struct device *dev);
-const struct attribute_group **ifs_get_groups(void);
+extern struct attribute *plat_ifs_attrs[];
 
 #endif
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index b518b661daf0..62c44dbae757 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -20,6 +20,8 @@ static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
 };
 MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
 
+ATTRIBUTE_GROUPS(plat_ifs);
+
 bool *ifs_pkg_auth;
 
 static struct ifs_device ifs_device = {
@@ -29,8 +31,8 @@ static struct ifs_device ifs_device = {
 	},
 	.misc = {
 		.name = "intel_ifs_0",
-		.nodename = "intel_ifs/0",
 		.minor = MISC_DYNAMIC_MINOR,
+		.groups = plat_ifs_groups,
 	},
 };
 
@@ -53,8 +55,6 @@ static int __init ifs_init(void)
 	if (rdmsrl_safe(MSR_INTEGRITY_CAPS, &msrval))
 		return -ENODEV;
 
-	ifs_device.misc.groups = ifs_get_groups();
-
 	if (!(msrval & BIT(ifs_device.ro_data.integrity_cap_bit)))
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

