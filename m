Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8AB63086A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbiKSBYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiKSBW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:22:56 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5F75216B;
        Fri, 18 Nov 2022 16:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668817434; x=1700353434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tbSKuur703p3F6JcNLmKqmZ6yxfEnKlj8/e3vCGHE9k=;
  b=gw+omeOJp35Ralu/raIgZbSyWh9P6xhArH/dukBZpd06zhaJxWVaLXFz
   QdAgBPwvX34NXqgLwKRa+W2KiEf0bMBDuYP+EjwrCoTMiANMgG1dKtbIj
   ++k9xhCPAOIzee+2OS8eIekNu0kRpqmdwp/UKnFcvdI1swQfz8F49xgMj
   vLHSj8B46p5BMbhb9LQNAviBfWuENjYigEKI2yKT+mFqU+mCl4PC4L3b1
   Y+Ivqz78eYE2sRWN4GDJNSUjoGxKbhvpksz0MhrJLtEOmXXzRhB6M6Q1Y
   lt8FrAnDRcsGgwbCqUlJgmHLVx40TCpP3ui+Ta3wINHAI6NYxRJXNYX+1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="293656149"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="293656149"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 16:23:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="640401527"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="640401527"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 18 Nov 2022 16:23:46 -0800
Received: from debox1-desk4.lan (unknown [10.252.138.169])
        by linux.intel.com (Postfix) with ESMTP id 1E87A580DDF;
        Fri, 18 Nov 2022 16:23:46 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/9] platform/x86/intel/sdsi: Add meter certificate support
Date:   Fri, 18 Nov 2022 16:23:38 -0800
Message-Id: <20221119002343.1281885-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221119002343.1281885-1-david.e.box@linux.intel.com>
References: <20221119002343.1281885-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for reading the meter certificate from Intel On Demand
hardware.  The meter certificate [1] is used to access the utilization
metrics of enabled features in support of the Intel On Demand consumption
model. Similar to the state certificate, the meter certificate is read by
mailbox command.

While making similar changes also use the BIN_ATTR_ADMIN_RO helper to
create the 'registers' sysfs file.

Link: https://github.com/intel-sandbox/debox1.intel_sdsi/blob/gnr-review/meter-certificate.rst [1]

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2 - Add Link tag in commit message
   - Use BIN_ATTR_ADMIN_RO helper for certificate files and also for
     existing 'registers' file
   - Allow default On Demand attributes to show without explicit checks

 .../ABI/testing/sysfs-driver-intel_sdsi       | 10 ++++
 drivers/platform/x86/intel/sdsi.c             | 49 ++++++++++++++-----
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel_sdsi b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
index 9d77f30d9b9a..f8afed127107 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel_sdsi
+++ b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
@@ -69,6 +69,16 @@ Description:
 		the CPU configuration is updated. A cold reboot is required to
 		fully activate the feature. Mailbox command.
 
+What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X/meter_certificate
+Date:		Nov 2022
+KernelVersion:	6.2
+Contact:	"David E. Box" <david.e.box@linux.intel.com>
+Description:
+		(RO) Used to read back the current meter certificate for the CPU
+		from Intel On Demand hardware. The meter certificate contains
+		utilization metrics of On Demand enabled features. Mailbox
+		command.
+
 What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X/state_certificate
 Date:		Feb 2022
 KernelVersion:	5.18
diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 9cd4339a7370..9e0ea2cdd704 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -41,6 +41,7 @@
 
 #define SDSI_ENABLED_FEATURES_OFFSET	16
 #define SDSI_FEATURE_SDSI		BIT(3)
+#define SDSI_FEATURE_METERING		BIT(26)
 
 #define SDSI_SOCKET_ID_OFFSET		64
 #define SDSI_SOCKET_ID			GENMASK(3, 0)
@@ -83,9 +84,10 @@
 #define GUID_V2_REGS_SIZE		80
 
 enum sdsi_command {
-	SDSI_CMD_PROVISION_AKC		= 0x04,
-	SDSI_CMD_PROVISION_CAP		= 0x08,
-	SDSI_CMD_READ_STATE		= 0x10,
+	SDSI_CMD_PROVISION_AKC		= 0x0004,
+	SDSI_CMD_PROVISION_CAP		= 0x0008,
+	SDSI_CMD_READ_STATE		= 0x0010,
+	SDSI_CMD_READ_METER		= 0x0014,
 };
 
 struct sdsi_mbox_info {
@@ -401,13 +403,10 @@ static ssize_t provision_cap_write(struct file *filp, struct kobject *kobj,
 }
 static BIN_ATTR_WO(provision_cap, SDSI_SIZE_WRITE_MSG);
 
-static long state_certificate_read(struct file *filp, struct kobject *kobj,
-				   struct bin_attribute *attr, char *buf, loff_t off,
-				   size_t count)
+static ssize_t
+certificate_read(u64 command, struct sdsi_priv *priv, char *buf, loff_t off,
+		 size_t count)
 {
-	struct device *dev = kobj_to_dev(kobj);
-	struct sdsi_priv *priv = dev_get_drvdata(dev);
-	u64 command = SDSI_CMD_READ_STATE;
 	struct sdsi_mbox_info info;
 	size_t size;
 	int ret;
@@ -444,7 +443,30 @@ static long state_certificate_read(struct file *filp, struct kobject *kobj,
 
 	return size;
 }
-static BIN_ATTR(state_certificate, 0400, state_certificate_read, NULL, SDSI_SIZE_READ_MSG);
+
+static ssize_t
+state_certificate_read(struct file *filp, struct kobject *kobj,
+		       struct bin_attribute *attr, char *buf, loff_t off,
+		       size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct sdsi_priv *priv = dev_get_drvdata(dev);
+
+	return certificate_read(SDSI_CMD_READ_STATE, priv, buf, off, count);
+}
+static BIN_ATTR_ADMIN_RO(state_certificate, SDSI_SIZE_READ_MSG);
+
+static ssize_t
+meter_certificate_read(struct file *filp, struct kobject *kobj,
+		       struct bin_attribute *attr, char *buf, loff_t off,
+		       size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct sdsi_priv *priv = dev_get_drvdata(dev);
+
+	return certificate_read(SDSI_CMD_READ_METER, priv, buf, off, count);
+}
+static BIN_ATTR_ADMIN_RO(meter_certificate, SDSI_SIZE_READ_MSG);
 
 static ssize_t registers_read(struct file *filp, struct kobject *kobj,
 			      struct bin_attribute *attr, char *buf, loff_t off,
@@ -470,11 +492,12 @@ static ssize_t registers_read(struct file *filp, struct kobject *kobj,
 
 	return count;
 }
-static BIN_ATTR(registers, 0400, registers_read, NULL, SDSI_SIZE_REGS);
+static BIN_ATTR_ADMIN_RO(registers, SDSI_SIZE_REGS);
 
 static struct bin_attribute *sdsi_bin_attrs[] = {
 	&bin_attr_registers,
 	&bin_attr_state_certificate,
+	&bin_attr_meter_certificate,
 	&bin_attr_provision_akc,
 	&bin_attr_provision_cap,
 	NULL
@@ -494,6 +517,10 @@ sdsi_battr_is_visible(struct kobject *kobj, struct bin_attribute *attr, int n)
 	if (!(priv->features & SDSI_FEATURE_SDSI))
 		return 0;
 
+	if (attr == &bin_attr_meter_certificate)
+		return (priv->features & SDSI_FEATURE_METERING) ?
+				attr->attr.mode : 0;
+
 	return attr->attr.mode;
 }
 
-- 
2.34.1

