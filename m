Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D56151FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiKATLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiKATKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:10:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2821CB10;
        Tue,  1 Nov 2022 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667329855; x=1698865855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NA5/t41ZCbqszgHs3lJC1knncUR7kRh2Cap2isglxDI=;
  b=eyf6Axlr/KQZNbcUoeOkGWBnmTn+LgD3LWsLDM7jtUTShVnntEvKVwLt
   lVipl6iYQoBbexu4lPkNTs54ur18/xeLamU0HDmVOLh9vpKGJV67HLDNK
   vfPi4T5naMi8QB9G/iiLCHI0W5eezlkyE/YnwUbvtHcXcNWyn+VyiFM70
   sISiVG8QdPFZjz5BvRzwqpTo/ub6qx1NNHlrY0Er1ix9EgVaPE6yI9lD4
   LIvd7KDRX11Y9SulHCMLu+5LkYgATInwmk+axWStvV3tyIi1PZkDWq3JR
   gSRrwr5MHQsMMXhfxBHXjYwYllmwkHTbVza9Ld5CPv2dSQpBxiHJFJX2H
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="289607881"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="289607881"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 12:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="667299027"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="667299027"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 01 Nov 2022 12:10:26 -0700
Received: from debox1-desk4.intel.com (unknown [10.212.195.64])
        by linux.intel.com (Postfix) with ESMTP id 70A9A580AA7;
        Tue,  1 Nov 2022 12:10:26 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] platform/x86/intel/sdsi: Support different GUIDs
Date:   Tue,  1 Nov 2022 12:10:17 -0700
Message-Id: <20221101191023.4150315-4-david.e.box@linux.intel.com>
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

Newer versions of Intel On Demand hardware may have an expanded list of
registers to support new features. The register layout is identified by a
unique GUID that's read during driver probe. Add support for handling
different GUIDs and add support for current GUIDs [1].

[1] https://github.com/intel/intel-sdsi/blob/master/os-interface.rst

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/sdsi.c | 47 +++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index bca05b4dd983..ab1f65919fc5 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -27,10 +27,10 @@
 #define ACCESS_TYPE_LOCAL		3
 
 #define SDSI_MIN_SIZE_DWORDS		276
-#define SDSI_SIZE_CONTROL		8
 #define SDSI_SIZE_MAILBOX		1024
-#define SDSI_SIZE_REGS			72
+#define SDSI_SIZE_REGS			80
 #define SDSI_SIZE_CMD			sizeof(u64)
+#define SDSI_SIZE_MAILBOX		1024
 
 /*
  * Write messages are currently up to the size of the mailbox
@@ -76,6 +76,9 @@
 #define DT_TBIR				GENMASK(2, 0)
 #define DT_OFFSET(v)			((v) & GENMASK(31, 3))
 
+#define SDSI_GUID_V1			0x006DD191
+#define SDSI_GUID_V2			0xF210D9EF
+
 enum sdsi_command {
 	SDSI_CMD_PROVISION_AKC		= 0x04,
 	SDSI_CMD_PROVISION_CAP		= 0x08,
@@ -100,6 +103,9 @@ struct sdsi_priv {
 	void __iomem		*control_addr;
 	void __iomem		*mbox_addr;
 	void __iomem		*regs_addr;
+	int			control_size;
+	int			maibox_size;
+	int			registers_size;
 	u32			guid;
 	u32			features;
 };
@@ -444,6 +450,18 @@ static ssize_t registers_read(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct sdsi_priv *priv = dev_get_drvdata(dev);
 	void __iomem *addr = priv->regs_addr;
+	int size =  priv->registers_size;
+
+	/*
+	 * The check below is performed by the sysfs caller based on the static
+	 * file size. But this may be greater than the actual size which is based
+	 * on the GUID. So check here again based on actual size before reading.
+	 */
+	if (off >= size)
+		return 0;
+
+	if (off + count > size)
+		count = size - off;
 
 	memcpy_fromio(buf, addr + off, count);
 
@@ -496,6 +514,24 @@ static const struct attribute_group sdsi_group = {
 };
 __ATTRIBUTE_GROUPS(sdsi);
 
+static int sdsi_get_layout(struct sdsi_priv *priv, struct disc_table *table)
+{
+	switch (table->guid) {
+	case SDSI_GUID_V1:
+		priv->control_size = 8;
+		priv->registers_size = 72;
+		break;
+	case SDSI_GUID_V2:
+		priv->control_size = 16;
+		priv->registers_size = 80;
+		break;
+	default:
+		dev_err(priv->dev, "Unrecognized GUID 0x%x\n", table->guid);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int sdsi_map_mbox_registers(struct sdsi_priv *priv, struct pci_dev *parent,
 				   struct disc_table *disc_table, struct resource *disc_res)
 {
@@ -537,7 +573,7 @@ static int sdsi_map_mbox_registers(struct sdsi_priv *priv, struct pci_dev *paren
 	if (IS_ERR(priv->control_addr))
 		return PTR_ERR(priv->control_addr);
 
-	priv->mbox_addr = priv->control_addr + SDSI_SIZE_CONTROL;
+	priv->mbox_addr = priv->control_addr + priv->control_size;
 	priv->regs_addr = priv->mbox_addr + SDSI_SIZE_MAILBOX;
 
 	priv->features = readq(priv->regs_addr + SDSI_ENABLED_FEATURES_OFFSET);
@@ -572,6 +608,11 @@ static int sdsi_probe(struct auxiliary_device *auxdev, const struct auxiliary_de
 
 	priv->guid = disc_table.guid;
 
+	/* Get guid based layout info */
+	ret = sdsi_get_layout(priv, &disc_table);
+	if (ret)
+		return ret;
+
 	/* Map the SDSi mailbox registers */
 	ret = sdsi_map_mbox_registers(priv, intel_cap_dev->pcidev, &disc_table, disc_res);
 	if (ret)
-- 
2.25.1

