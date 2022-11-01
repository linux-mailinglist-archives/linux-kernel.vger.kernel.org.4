Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA95D6151F5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiKATK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKATKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:10:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A571C416;
        Tue,  1 Nov 2022 12:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667329852; x=1698865852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K6E1RFYeJekr3s2TcMWi6yPlXHIkdOkuHKVN7RzSc9s=;
  b=bHjC+l6GtMZEPiI0xuJAY5NvEDTasNPaosynun9/od1KA32TZKUAPyXh
   2VJ9y/+NJNRz1v4EHeHz9CJA6AUwEu0f6XGQTM5X6myo3mXjUf6gINwoV
   z/E3xJxjPcrF27tJXc6OY8u9ve8imeSyOaaARNwiZqkEjP66N+lgyGHBj
   02F4fLN85Znhc1FVvG8S5MA/ChE2i/7whKYVShg/Fv6VNfvs4tOclLelp
   szlkFGTV8VO80W16SB7zDfcBvQlbKmyEtEzgjLgvhteM6kkVhry7lJKtn
   SIIT603fmL06RYZ/2sCDEooQoe7lgqd/SBevaYgfKALT6yP8alU5CitGN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="296656329"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="296656329"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 12:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="702985441"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="702985441"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2022 12:10:26 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.195.64])
        by linux.intel.com (Postfix) with ESMTP id 9DBBF580B9D;
        Tue,  1 Nov 2022 12:10:26 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] platform/x86/intel/sdsi: Add meter certificate support
Date:   Tue,  1 Nov 2022 12:10:18 -0700
Message-Id: <20221101191023.4150315-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101191023.4150315-1-david.e.box@linux.intel.com>
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

[1] https://github.com/intel-sandbox/debox1.intel_sdsi/blob/gnr-review/meter-certificate.rst

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 .../ABI/testing/sysfs-driver-intel_sdsi       | 10 ++++
 drivers/platform/x86/intel/sdsi.c             | 52 +++++++++++++++----
 2 files changed, 52 insertions(+), 10 deletions(-)

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
index ab1f65919fc5..1dee10822df7 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -42,6 +42,7 @@
 
 #define SDSI_ENABLED_FEATURES_OFFSET	16
 #define SDSI_FEATURE_SDSI		BIT(3)
+#define SDSI_FEATURE_METERING		BIT(26)
 
 #define SDSI_SOCKET_ID_OFFSET		64
 #define SDSI_SOCKET_ID			GENMASK(3, 0)
@@ -80,9 +81,10 @@
 #define SDSI_GUID_V2			0xF210D9EF
 
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
@@ -398,13 +400,10 @@ static ssize_t provision_cap_write(struct file *filp, struct kobject *kobj,
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
@@ -441,8 +440,31 @@ static long state_certificate_read(struct file *filp, struct kobject *kobj,
 
 	return size;
 }
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
 static BIN_ATTR(state_certificate, 0400, state_certificate_read, NULL, SDSI_SIZE_READ_MSG);
 
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
+static BIN_ATTR(meter_certificate, 0400, meter_certificate_read, NULL, SDSI_SIZE_READ_MSG);
+
 static ssize_t registers_read(struct file *filp, struct kobject *kobj,
 			      struct bin_attribute *attr, char *buf, loff_t off,
 			      size_t count)
@@ -472,6 +494,7 @@ static BIN_ATTR(registers, 0400, registers_read, NULL, SDSI_SIZE_REGS);
 static struct bin_attribute *sdsi_bin_attrs[] = {
 	&bin_attr_registers,
 	&bin_attr_state_certificate,
+	&bin_attr_meter_certificate,
 	&bin_attr_provision_akc,
 	&bin_attr_provision_cap,
 	NULL
@@ -491,7 +514,16 @@ sdsi_battr_is_visible(struct kobject *kobj, struct bin_attribute *attr, int n)
 	if (!(priv->features & SDSI_FEATURE_SDSI))
 		return 0;
 
-	return attr->attr.mode;
+	if (attr == &bin_attr_state_certificate ||
+	    attr == &bin_attr_provision_akc ||
+	    attr == &bin_attr_provision_cap)
+		return attr->attr.mode;
+
+	if (attr == &bin_attr_meter_certificate &&
+	    !!(priv->features & SDSI_FEATURE_METERING))
+		return attr->attr.mode;
+
+	return 0;
 }
 
 static ssize_t guid_show(struct device *dev, struct device_attribute *attr, char *buf)
-- 
2.25.1

