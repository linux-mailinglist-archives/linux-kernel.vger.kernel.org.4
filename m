Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7714C6151FC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiKATLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKATKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:10:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656231E71C;
        Tue,  1 Nov 2022 12:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667329853; x=1698865853;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kZkezDSibEk4/v19uR3JE7pTdxO5vPRROINTTCkEtq4=;
  b=RgVqccXRc5hbs+qMMj5dz7WI7Ck8c5QFZop1u6vFE0D5rxGE6s9fjjoI
   i/Ye9+PDmuCalY6el7z91kt0eTDKzvQSIlAAuaL+NJYKM8RfxJY1QB0/0
   JNkZI3LIOIg00PaZCemhPWBj7GTMOtJtqc030reYHk/a7qoLKUQlvhJYR
   vEjLYSmPCXqd3hGdEh0pNpma/dl5nCxnwp6TjyAPfLIMatlbC6jwMlNu+
   l1Ot8JyXI6cfdFhHVx5ooFIPKgwQ1BDRUBB6Z+IwsSnmvvSfIlbUO1C1n
   1t4nUIMv19aVHZRf+zV8xDwMXjb/9IDo0HfCA7X12BN4AC0noZeN477ca
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="395531248"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="395531248"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 12:10:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="759278165"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="759278165"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 01 Nov 2022 12:10:26 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.195.64])
        by linux.intel.com (Postfix) with ESMTP id 43BDA580C99;
        Tue,  1 Nov 2022 12:10:26 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] platform/x86/intel/sdsi: Hide attributes if hardware doesn't support
Date:   Tue,  1 Nov 2022 12:10:16 -0700
Message-Id: <20221101191023.4150315-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101191023.4150315-1-david.e.box@linux.intel.com>
References: <20221101191023.4150315-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
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
2.25.1

