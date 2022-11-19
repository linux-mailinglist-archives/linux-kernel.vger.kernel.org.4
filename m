Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638E7630867
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiKSBXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiKSBWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:22:54 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E7129357;
        Fri, 18 Nov 2022 16:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668817431; x=1700353431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iohc0ivLgSmNxHpii1jlB1jLxz88zxScpsa4pec26hw=;
  b=Gbzs/7YfboXQ1PVR4b7Oh/0FCLDzfY8pp5+biDQ47+LPcbTZbZwClwn+
   CU/7LkuI8J8PPwa9ol3g6Ihryps3WDPVCwV3ybe4sK+y7jBVriXMyMp1p
   4W4FWdEMM8lbx4Ep2Y9LGlPb3wg7Tymtnvfm5rue/NTPuRDCE4EuVyCHd
   rsW4Kx4qOuiVLheTxaUd+g/pZOVjplVhKNpd848tCfcPF17O1Gy3PHC9L
   OWiIiyuOzNq5VFbCbIcTjICBL8RoO/kDJKhUWE7CZVxSIYsBKMTFGWInn
   R9ySPhYKIMNdhtOuMNq4yMFxB4pRN0XqIFeN8d24bUHOLNFqcwKxQLRSJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="300807216"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="300807216"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 16:23:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="709218857"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="709218857"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 18 Nov 2022 16:23:46 -0800
Received: from debox1-desk4.lan (unknown [10.252.138.169])
        by linux.intel.com (Postfix) with ESMTP id E36DF580DFA;
        Fri, 18 Nov 2022 16:23:45 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org, andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/9] platform/x86/intel/sdsi: Support different GUIDs
Date:   Fri, 18 Nov 2022 16:23:37 -0800
Message-Id: <20221119002343.1281885-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221119002343.1281885-1-david.e.box@linux.intel.com>
References: <20221119002343.1281885-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer versions of Intel On Demand hardware may have an expanded list of
registers to support new features. The register layout is identified by a
unique GUID that's read during driver probe. Add support for handling
different GUIDs and add support for current GUIDs [1].

Link: https://github.com/intel/intel-sdsi/blob/master/os-interface.rst [1]

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---

V2 - Add Link tag in commit and use defines for GUID based sizes.

 drivers/platform/x86/intel/sdsi.c | 50 +++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index bca05b4dd983..9cd4339a7370 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -27,9 +27,8 @@
 #define ACCESS_TYPE_LOCAL		3
 
 #define SDSI_MIN_SIZE_DWORDS		276
-#define SDSI_SIZE_CONTROL		8
 #define SDSI_SIZE_MAILBOX		1024
-#define SDSI_SIZE_REGS			72
+#define SDSI_SIZE_REGS			80
 #define SDSI_SIZE_CMD			sizeof(u64)
 
 /*
@@ -76,6 +75,13 @@
 #define DT_TBIR				GENMASK(2, 0)
 #define DT_OFFSET(v)			((v) & GENMASK(31, 3))
 
+#define SDSI_GUID_V1			0x006DD191
+#define GUID_V1_CNTRL_SIZE		8
+#define GUID_V1_REGS_SIZE		72
+#define SDSI_GUID_V2			0xF210D9EF
+#define GUID_V2_CNTRL_SIZE		16
+#define GUID_V2_REGS_SIZE		80
+
 enum sdsi_command {
 	SDSI_CMD_PROVISION_AKC		= 0x04,
 	SDSI_CMD_PROVISION_CAP		= 0x08,
@@ -100,6 +106,9 @@ struct sdsi_priv {
 	void __iomem		*control_addr;
 	void __iomem		*mbox_addr;
 	void __iomem		*regs_addr;
+	int			control_size;
+	int			maibox_size;
+	int			registers_size;
 	u32			guid;
 	u32			features;
 };
@@ -444,6 +453,18 @@ static ssize_t registers_read(struct file *filp, struct kobject *kobj,
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
 
@@ -496,6 +517,24 @@ static const struct attribute_group sdsi_group = {
 };
 __ATTRIBUTE_GROUPS(sdsi);
 
+static int sdsi_get_layout(struct sdsi_priv *priv, struct disc_table *table)
+{
+	switch (table->guid) {
+	case SDSI_GUID_V1:
+		priv->control_size = GUID_V1_CNTRL_SIZE;
+		priv->registers_size = GUID_V1_REGS_SIZE;
+		break;
+	case SDSI_GUID_V2:
+		priv->control_size = GUID_V2_CNTRL_SIZE;
+		priv->registers_size = GUID_V2_REGS_SIZE;
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
@@ -537,7 +576,7 @@ static int sdsi_map_mbox_registers(struct sdsi_priv *priv, struct pci_dev *paren
 	if (IS_ERR(priv->control_addr))
 		return PTR_ERR(priv->control_addr);
 
-	priv->mbox_addr = priv->control_addr + SDSI_SIZE_CONTROL;
+	priv->mbox_addr = priv->control_addr + priv->control_size;
 	priv->regs_addr = priv->mbox_addr + SDSI_SIZE_MAILBOX;
 
 	priv->features = readq(priv->regs_addr + SDSI_ENABLED_FEATURES_OFFSET);
@@ -572,6 +611,11 @@ static int sdsi_probe(struct auxiliary_device *auxdev, const struct auxiliary_de
 
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
2.34.1

