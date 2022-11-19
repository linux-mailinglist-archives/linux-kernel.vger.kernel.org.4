Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF80563086B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiKSBYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiKSBWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:22:55 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA3232B82;
        Fri, 18 Nov 2022 16:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668817431; x=1700353431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kG3nCP9dnjVyAb0rhxfcQS0XfXKR+QBYZvRjPdhXez0=;
  b=ZlvQD5LAiE5dqkBxDSWQ5XXgNmhCR8+KYFPKnBpCp2xG0LtmtdkALozS
   OXpHqJhlH9f6kE02XUQ40a/B21fGk4+P4AGeSkNmHRP82+0qtPUS4Dke2
   4IyB8RGZBFymMY8zZnGaVNOrOSWTTn6DNVlWmFwC0ucM33iC8p7qc+qIO
   sOPY+GrrqOLTJeVEszXnR0C4lg2BWyneJGn/KVXOB2l/FIwfM4/Dp9wx+
   UP/FgXHbFhxyjRaw2j/j8lAFQvw88NqFQb5ltUq42qYaEqUpaiYyPQIyj
   xc8W72luu+JJMHZ/lRI3p9KuOlflOeDS7AKRqNn6Tx0123GLzJstXWysH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="293656147"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="293656147"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 16:23:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="618202703"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="618202703"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 18 Nov 2022 16:23:45 -0800
Received: from debox1-desk4.lan (unknown [10.252.138.169])
        by linux.intel.com (Postfix) with ESMTP id B43B9580A6C;
        Fri, 18 Nov 2022 16:23:45 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/9] platform/x86/intel/sdsi: Hide attributes if hardware doesn't support
Date:   Fri, 18 Nov 2022 16:23:36 -0800
Message-Id: <20221119002343.1281885-3-david.e.box@linux.intel.com>
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

Provisioning capabilities are enabled by a bit set by BIOS. Read this bit
and hide the provisioning attributes if the On Demand feature is not
enabled.

Also, remove the sdsi_enabled boolean from private and instead add a
features register since this will be used for future features.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---

V2 - No change

 drivers/platform/x86/intel/sdsi.c | 33 ++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 32793919473d..bca05b4dd983 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -41,7 +41,8 @@
 #define SDSI_SIZE_READ_MSG		(SDSI_SIZE_MAILBOX * 4)
 
 #define SDSI_ENABLED_FEATURES_OFFSET	16
-#define SDSI_ENABLED			BIT(3)
+#define SDSI_FEATURE_SDSI		BIT(3)
+
 #define SDSI_SOCKET_ID_OFFSET		64
 #define SDSI_SOCKET_ID			GENMASK(3, 0)
 
@@ -100,7 +101,7 @@ struct sdsi_priv {
 	void __iomem		*mbox_addr;
 	void __iomem		*regs_addr;
 	u32			guid;
-	bool			sdsi_enabled;
+	u32			features;
 };
 
 /* SDSi mailbox operations must be performed using 64bit mov instructions */
@@ -332,9 +333,6 @@ static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
 	struct sdsi_mbox_info info;
 	int ret;
 
-	if (!priv->sdsi_enabled)
-		return -EPERM;
-
 	if (count > (SDSI_SIZE_WRITE_MSG - SDSI_SIZE_CMD))
 		return -EOVERFLOW;
 
@@ -405,9 +403,6 @@ static long state_certificate_read(struct file *filp, struct kobject *kobj,
 	size_t size;
 	int ret;
 
-	if (!priv->sdsi_enabled)
-		return -EPERM;
-
 	if (off)
 		return 0;
 
@@ -464,6 +459,23 @@ static struct bin_attribute *sdsi_bin_attrs[] = {
 	NULL
 };
 
+static umode_t
+sdsi_battr_is_visible(struct kobject *kobj, struct bin_attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct sdsi_priv *priv = dev_get_drvdata(dev);
+
+	/* Registers file is always readable if the device is present */
+	if (attr == &bin_attr_registers)
+		return attr->attr.mode;
+
+	/* All other attributes not visible if BIOS has not enabled On Demand */
+	if (!(priv->features & SDSI_FEATURE_SDSI))
+		return 0;
+
+	return attr->attr.mode;
+}
+
 static ssize_t guid_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct sdsi_priv *priv = dev_get_drvdata(dev);
@@ -480,6 +492,7 @@ static struct attribute *sdsi_attrs[] = {
 static const struct attribute_group sdsi_group = {
 	.attrs = sdsi_attrs,
 	.bin_attrs = sdsi_bin_attrs,
+	.is_bin_visible = sdsi_battr_is_visible,
 };
 __ATTRIBUTE_GROUPS(sdsi);
 
@@ -490,7 +503,6 @@ static int sdsi_map_mbox_registers(struct sdsi_priv *priv, struct pci_dev *paren
 	u32 size = FIELD_GET(DT_SIZE, disc_table->access_info);
 	u32 tbir = FIELD_GET(DT_TBIR, disc_table->offset);
 	u32 offset = DT_OFFSET(disc_table->offset);
-	u32 features_offset;
 	struct resource res = {};
 
 	/* Starting location of SDSi MMIO region based on access type */
@@ -528,8 +540,7 @@ static int sdsi_map_mbox_registers(struct sdsi_priv *priv, struct pci_dev *paren
 	priv->mbox_addr = priv->control_addr + SDSI_SIZE_CONTROL;
 	priv->regs_addr = priv->mbox_addr + SDSI_SIZE_MAILBOX;
 
-	features_offset = readq(priv->regs_addr + SDSI_ENABLED_FEATURES_OFFSET);
-	priv->sdsi_enabled = !!(features_offset & SDSI_ENABLED);
+	priv->features = readq(priv->regs_addr + SDSI_ENABLED_FEATURES_OFFSET);
 
 	return 0;
 }
-- 
2.34.1

