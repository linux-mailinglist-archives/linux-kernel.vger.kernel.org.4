Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BC56FB244
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjEHOKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjEHOKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:10:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9396D5254
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:10:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6X6uQrOccNi3b+UqZXUoZl1/xhTACm8t72BI2EVt8kc3Ezk/mKr0YpmrVxDGJzBbAv9J8RXk2I6EY2QktH6BYeB0F2FoeHXFpodzVFKhbWzKg1Y/zSRydLits08uxtIfOfaR46x3hTK1J/6XJMtXCvJgvZi+8CdesoEqsOAYetVqdCJi3X3fCDohA0BBwp9bC4B/Ed3TasrgO78pso0BmdIsiYxSS6ly2O5S/hf6dafjtaIzQH2ZsIL7soW5H1/49x9ZHQvBiqe1dsLpKibtubdooUReRBd+w/lzeod7SJ/8QbZPxYYNKtF4gUYDRzhHQUlPu/3gMqjKQPMSAHIgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G9DBGoXZSscaN1UGL0BPqQjv4dPeMHfzVhkN7U/qBro=;
 b=ZDB7sA1wRt5iizUZ6NkYb1F3jtHFc6Uvdr+XRwTP8W/f/9feWuIhstolWQw/Fl4+UtqrrWYKu7Z46Jowf/hD52Hc7zazdxJzIZLvd/1maJnnpYqBLbYCl3ozmGpxQ8QOcUwJ8fqk7kKMLz7d2cr4dL1rK5wM9C/zueAz6GcPaaDZ9bGLOcoYjLSQNnflBLQAZRJMkBCMQSMZ0j9M+V95AZ08eDGAx83CzJ5AnrBAEEa3AI/3Ii97UosbNposkYJmsd3OwrtJblWVxf6TigiIyla/CtbgjvD+ysKt94dtu14NAyUg6eZQ/cuaUASphUg/aPGlPRdm6jPwNdDIYfnYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9DBGoXZSscaN1UGL0BPqQjv4dPeMHfzVhkN7U/qBro=;
 b=YQjzZ3DZU6sUdBAaa3E8IOClnqX1o6YNovV4aXUY/Ix4EmvI4/c/VOG8mOpDPrRy1wgX/YkGUgN+885vxhFCSub41P3gbH+uh5N8sg0IxverYdswI35ZkoTedMgSZdseRMNSFe55lq/SEECYXtNWNxiBhRd12jx/mJ/BuZ3/Onc=
Received: from BN9PR03CA0211.namprd03.prod.outlook.com (2603:10b6:408:f8::6)
 by SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 14:10:03 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::2e) by BN9PR03CA0211.outlook.office365.com
 (2603:10b6:408:f8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32 via Frontend
 Transport; Mon, 8 May 2023 14:10:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Mon, 8 May 2023 14:10:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 May
 2023 09:10:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 May
 2023 09:10:00 -0500
Received: from xhdipdslab41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 8 May 2023 09:09:56 -0500
From:   Nipun Gupta <nipun.gupta@amd.com>
To:     <gregkh@linuxfoundation.org>, <maz@kernel.org>,
        <tglx@linutronix.de>, <jgg@ziepe.ca>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <harpreet.anand@amd.com>,
        <pieter.jansen-van-vuuren@amd.com>, <nikhil.agarwal@amd.com>,
        <michal.simek@amd.com>, <abhijit.gangurde@amd.com>,
        <pablo.cascon@amd.com>, Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH] cdx: add MSI support for CDX bus
Date:   Mon, 8 May 2023 19:39:50 +0530
Message-ID: <20230508140950.12717-1-nipun.gupta@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|SN7PR12MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 27827e52-9293-4e2c-988f-08db4fcdeac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFmerrQcLMrcS/pPzVO78c6qS6Sp+X70miJXj3CSBx6l2SoOmt3HUbgjXQHHJ1hwprq52J8YnjMe4yPchoj9mW6dozNBsQIoPL+PvMBbDkRarWBkJsbLZMhuceGm4nUJhtZLeo0RZYQ6sbS+Ese7EQlGlvJLyZEVfITLKY6DmPOtQuJAVpENblK8vmQ/7aFBKagZvyvcQ1AjkqZT+miozhK5ZtP7P+0og4OYmngFfUWFKT/bcaxPWvwE1ox7dBFJ/XYn1eNmLZ8pVZCMTUMAblaVSx1lFDmMuyR/xHhv94QEn+jr18ly2b+JkZNrPNwOxJwUSe7QOxZl2hq/hBE4AsOACmPAe4vZlwNi5iKm/JFHRwD8XN5GSbdVyfiBISMinAbhZPZv21puQi37F0AGFZXjl5dmL3hV1ZTM/U3QjReJmg+vycopbGXlMzbbu9QNMPh3Wy0AZ8uft7EOWPuHtmPzSFTjP9F9MlDkG0UkiK1qlLMLG4+Q/p8au8pysNRWIT5xRo2HGZk1T/ScxrJPRqqVIblCXaDllDgHfiub6m5ulLvKpxDdahpjYw+DW/Qg5bgqE8jazQaKXYgidKAjrmH2YnmePwKdHNHWZzS0Xy7ibWCU65OLgeWFXKd2xcpEpwJbO8pyTVr/lnX+AZd2GiTC3fuXbhRPBJ1X+x6pnegHpNPkRlX5RR/vKES1SDxWdwq8QdJQ4PQtqP+6PuTecwXzZGMmedE2USTGSImxDpQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(36756003)(86362001)(336012)(966005)(54906003)(110136005)(4326008)(70206006)(70586007)(316002)(478600001)(40480700001)(82310400005)(5660300002)(44832011)(41300700001)(8676002)(2906002)(8936002)(30864003)(186003)(82740400003)(356005)(81166007)(2616005)(36860700001)(26005)(1076003)(47076005)(426003)(83380400001)(6666004)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 14:10:02.8558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27827e52-9293-4e2c-988f-08db4fcdeac9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CDX-MSI domain with gic-its domain as parent, to support MSI
for CDX devices. CDX devices allocate MSIs from the CDX domain.
Also, introduce APIs to alloc and free IRQs for CDX domain.

Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
---

This is a rework of CDX-MSI RFC sent at:
https://lore.kernel.org/lkml/20221014044049.2557085-8-nipun.gupta@amd.com/
The change was separated out from CDX bus series and has now been
validated on Versal-net platform.

 drivers/cdx/Kconfig                     |   1 +
 drivers/cdx/Makefile                    |   2 +-
 drivers/cdx/cdx.c                       |   6 +
 drivers/cdx/cdx.h                       |  10 ++
 drivers/cdx/cdx_msi.c                   | 153 ++++++++++++++++++++++++
 drivers/cdx/controller/cdx_controller.c |  23 ++++
 drivers/cdx/controller/mc_cdx_pcol.h    |  58 +++++++++
 drivers/cdx/controller/mcdi_functions.c |  19 +++
 drivers/cdx/controller/mcdi_functions.h |  20 ++++
 include/linux/cdx/cdx_bus.h             |  26 ++++
 kernel/irq/msi.c                        |   1 +
 11 files changed, 318 insertions(+), 1 deletion(-)
 create mode 100644 drivers/cdx/cdx_msi.c

diff --git a/drivers/cdx/Kconfig b/drivers/cdx/Kconfig
index a08958485e31..86df7ccb76bb 100644
--- a/drivers/cdx/Kconfig
+++ b/drivers/cdx/Kconfig
@@ -8,6 +8,7 @@
 config CDX_BUS
 	bool "CDX Bus driver"
 	depends on OF && ARM64
+	select GENERIC_MSI_IRQ_DOMAIN
 	help
 	  Driver to enable Composable DMA Transfer(CDX) Bus. CDX bus
 	  exposes Fabric devices which uses composable DMA IP to the
diff --git a/drivers/cdx/Makefile b/drivers/cdx/Makefile
index 0324e4914f6e..4bad79d1d188 100644
--- a/drivers/cdx/Makefile
+++ b/drivers/cdx/Makefile
@@ -5,4 +5,4 @@
 # Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
 #
 
-obj-$(CONFIG_CDX_BUS) += cdx.o controller/
+obj-$(CONFIG_CDX_BUS) += cdx.o cdx_msi.o controller/
diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 38511fd36325..4231f691a230 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -56,6 +56,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
@@ -479,6 +480,11 @@ int cdx_device_add(struct cdx_dev_params *dev_params)
 		     ((cdx->id << CDX_CONTROLLER_ID_SHIFT) | (cdx_dev->bus_num & CDX_BUS_NUM_MASK)),
 		     cdx_dev->dev_num);
 
+	if (cdx->msi_domain) {
+		cdx_dev->num_msi = dev_params->num_msi;
+		dev_set_msi_domain(&cdx_dev->dev, cdx->msi_domain);
+	}
+
 	ret = device_add(&cdx_dev->dev);
 	if (ret) {
 		dev_err(&cdx_dev->dev,
diff --git a/drivers/cdx/cdx.h b/drivers/cdx/cdx.h
index c436ac7ac86f..90e2da1e320d 100644
--- a/drivers/cdx/cdx.h
+++ b/drivers/cdx/cdx.h
@@ -21,6 +21,7 @@
  * @res: array of MMIO region entries
  * @res_count: number of valid MMIO regions
  * @req_id: Requestor ID associated with CDX device
+ * @num_msi: Number of MSI's supported by the device
  */
 struct cdx_dev_params {
 	struct cdx_controller *cdx;
@@ -31,6 +32,7 @@ struct cdx_dev_params {
 	struct resource res[MAX_CDX_DEV_RESOURCES];
 	u8 res_count;
 	u32 req_id;
+	u32 num_msi;
 };
 
 /**
@@ -59,4 +61,12 @@ void cdx_unregister_controller(struct cdx_controller *cdx);
  */
 int cdx_device_add(struct cdx_dev_params *dev_params);
 
+/**
+ * cdx_msi_domain_init - Init the CDX bus MSI domain.
+ * @dev: Device of the CDX bus controller
+ *
+ * Return: CDX MSI domain, NULL on failure
+ */
+struct irq_domain *cdx_msi_domain_init(struct device *dev);
+
 #endif /* _CDX_H_ */
diff --git a/drivers/cdx/cdx_msi.c b/drivers/cdx/cdx_msi.c
new file mode 100644
index 000000000000..60b165c998bb
--- /dev/null
+++ b/drivers/cdx/cdx_msi.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD CDX bus driver MSI support
+ *
+ * Copyright (C) 2022-2023, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+#include <linux/cdx/cdx_bus.h>
+
+#include "cdx.h"
+
+static void cdx_msi_write_msg(struct irq_data *irq_data,
+			      struct msi_msg *msg)
+{
+	struct msi_desc *msi_desc = irq_data_get_msi_desc(irq_data);
+	struct cdx_device *cdx_dev = to_cdx_device(msi_desc->dev);
+	struct cdx_controller *cdx = cdx_dev->cdx;
+	struct cdx_device_config dev_config;
+	int ret;
+
+	msi_desc->msg = *msg;
+	dev_config.msi.msi_index = msi_desc->msi_index;
+	dev_config.msi.data = msi_desc->msg.data;
+	dev_config.msi.addr = ((u64)(msi_desc->msg.address_hi) << 32) |
+			      msi_desc->msg.address_lo;
+
+	dev_config.type = CDX_DEV_MSI_CONF;
+	ret = cdx->ops->dev_configure(cdx, cdx_dev->bus_num, cdx_dev->dev_num,
+				      &dev_config);
+	if (ret)
+		dev_err(&cdx_dev->dev, "Write MSI failed to CDX controller\n");
+}
+
+static struct irq_chip cdx_msi_irq_chip = {
+	.name			= "CDX-MSI",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= msi_domain_set_affinity,
+	.irq_write_msi_msg	= cdx_msi_write_msg
+};
+
+int cdx_msi_domain_alloc_irqs(struct device *dev, unsigned int irq_count)
+{
+	int ret;
+
+	ret = msi_setup_device_data(dev);
+	if (ret)
+		return ret;
+
+	ret = msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN,
+					  0, irq_count - 1);
+	if (ret)
+		dev_err(dev, "Failed to allocate IRQs\n");
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cdx_msi_domain_alloc_irqs);
+
+/* Convert an msi_desc to a globally unique identifier. */
+static irq_hw_number_t cdx_domain_calc_hwirq(struct cdx_device *dev,
+					     struct msi_desc *desc)
+{
+	return ((irq_hw_number_t)dev->req_id << 10) | desc->msi_index;
+}
+
+static void cdx_msi_set_desc(msi_alloc_info_t *arg,
+			     struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = cdx_domain_calc_hwirq(to_cdx_device(desc->dev), desc);
+}
+
+static int cdx_msi_prepare(struct irq_domain *msi_domain,
+			   struct device *dev,
+			   int nvec, msi_alloc_info_t *info)
+{
+	struct cdx_device *cdx_dev = to_cdx_device(dev);
+	struct device *parent = dev->parent;
+	struct msi_domain_info *msi_info;
+	u32 dev_id = 0;
+	int ret;
+
+	/* Retrieve device ID from requestor ID using parent device */
+	ret = of_map_id(parent->of_node, cdx_dev->req_id, "msi-map",
+			"msi-map-mask", NULL, &dev_id);
+	if (ret) {
+		dev_err(dev, "of_map_id failed for MSI: %d\n", ret);
+		return ret;
+	}
+
+	/* Set the device Id to be passed to the GIC-ITS */
+	info->scratchpad[0].ul = dev_id;
+
+	msi_info = msi_get_domain_info(msi_domain->parent);
+
+	return msi_info->ops->msi_prepare(msi_domain->parent, dev, nvec, info);
+}
+
+static struct msi_domain_ops cdx_msi_ops = {
+	.msi_prepare	= cdx_msi_prepare,
+	.set_desc	= cdx_msi_set_desc
+};
+
+static struct msi_domain_info cdx_msi_domain_info = {
+	.ops	= &cdx_msi_ops,
+	.chip	= &cdx_msi_irq_chip,
+	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		  MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS
+};
+
+struct irq_domain *cdx_msi_domain_init(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct fwnode_handle *fwnode_handle;
+	struct irq_domain *cdx_msi_domain;
+	struct device_node *parent_node;
+	struct irq_domain *parent;
+
+	fwnode_handle = of_node_to_fwnode(np);
+
+	parent_node = of_parse_phandle(np, "msi-map", 1);
+	if (!parent_node) {
+		dev_err(dev, "msi-map not present on cdx controller\n");
+		return NULL;
+	}
+
+	parent = irq_find_matching_fwnode(of_node_to_fwnode(parent_node),
+					  DOMAIN_BUS_NEXUS);
+	if (!parent || !msi_get_domain_info(parent)) {
+		dev_err(dev, "unable to locate ITS domain\n");
+		return NULL;
+	}
+
+	cdx_msi_domain = msi_create_irq_domain(fwnode_handle, &cdx_msi_domain_info,
+					       parent);
+	if (!cdx_msi_domain) {
+		dev_err(dev, "unable to create CDX-MSI domain\n");
+		return NULL;
+	}
+
+	dev_dbg(dev, "CDX-MSI domain created\n");
+
+	return cdx_msi_domain;
+}
+EXPORT_SYMBOL_GPL(cdx_msi_domain_init);
diff --git a/drivers/cdx/controller/cdx_controller.c b/drivers/cdx/controller/cdx_controller.c
index dc52f95f8978..29e8e4a3b8c1 100644
--- a/drivers/cdx/controller/cdx_controller.c
+++ b/drivers/cdx/controller/cdx_controller.c
@@ -8,6 +8,7 @@
 #include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <linux/cdx/cdx_bus.h>
+#include <linux/irqdomain.h>
 
 #include "cdx_controller.h"
 #include "../cdx.h"
@@ -49,9 +50,20 @@ static int cdx_configure_device(struct cdx_controller *cdx,
 				u8 bus_num, u8 dev_num,
 				struct cdx_device_config *dev_config)
 {
+	u16 msi_index;
 	int ret = 0;
+	u32 data;
+	u64 addr;
 
 	switch (dev_config->type) {
+	case CDX_DEV_MSI_CONF:
+		msi_index = dev_config->msi.msi_index;
+		data = dev_config->msi.data;
+		addr = dev_config->msi.addr;
+
+		ret = cdx_mcdi_write_msi(cdx->priv, bus_num, dev_num,
+					 msi_index, addr, data);
+		break;
 	case CDX_DEV_RESET_CONF:
 		ret = cdx_mcdi_reset_device(cdx->priv, bus_num, dev_num);
 		break;
@@ -154,6 +166,14 @@ static int xlnx_cdx_probe(struct platform_device *pdev)
 	cdx->priv = cdx_mcdi;
 	cdx->ops = &cdx_ops;
 
+	/* Create MSI domain */
+	cdx->msi_domain = cdx_msi_domain_init(&pdev->dev);
+	if (!cdx->msi_domain) {
+		dev_err(&pdev->dev, "cdx_msi_domain_init() failed");
+		ret = -ENODEV;
+		goto cdx_msi_fail;
+	}
+
 	ret = cdx_setup_rpmsg(pdev);
 	if (ret) {
 		if (ret != -EPROBE_DEFER)
@@ -165,6 +185,8 @@ static int xlnx_cdx_probe(struct platform_device *pdev)
 	return 0;
 
 cdx_rpmsg_fail:
+	irq_domain_remove(cdx->msi_domain);
+cdx_msi_fail:
 	kfree(cdx);
 cdx_alloc_fail:
 	cdx_mcdi_finish(cdx_mcdi);
@@ -181,6 +203,7 @@ static int xlnx_cdx_remove(struct platform_device *pdev)
 
 	cdx_destroy_rpmsg(pdev);
 
+	irq_domain_remove(cdx->msi_domain);
 	kfree(cdx);
 
 	cdx_mcdi_finish(cdx_mcdi);
diff --git a/drivers/cdx/controller/mc_cdx_pcol.h b/drivers/cdx/controller/mc_cdx_pcol.h
index 4ccb7b52951b..07358d25b90b 100644
--- a/drivers/cdx/controller/mc_cdx_pcol.h
+++ b/drivers/cdx/controller/mc_cdx_pcol.h
@@ -562,6 +562,64 @@
 #define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_MMIO_REGIONS_ENABLE_LBN	2
 #define MC_CMD_CDX_DEVICE_CONTROL_GET_OUT_MMIO_REGIONS_ENABLE_WIDTH	1
 
+/***********************************/
+/*
+ * MC_CMD_CDX_DEVICE_WRITE_MSI_MSG
+ * Populates the MSI message to be used by the hardware to raise the specified
+ * interrupt vector. Versal-net implementation specific limitations are that
+ * only 4 CDX devices with MSI interrupt capability are supported and all
+ * vectors within a device must use the same write address. The command will
+ * return EINVAL if any of these limitations is violated.
+ */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG					0x9
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_MSGSET				0x9
+#undef MC_CMD_0x9_PRIVILEGE_CTG
+
+#define MC_CMD_0x9_PRIVILEGE_CTG SRIOV_CTG_ADMIN
+
+/* MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN msgrequest */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_LEN				28
+/* Device bus number, in range 0 to BUS_COUNT-1 */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_BUS_OFST			0
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_BUS_LEN			4
+/* Device number relative to the bus, in range 0 to DEVICE_COUNT-1 for that bus */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_DEVICE_OFST			4
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_DEVICE_LEN			4
+/*
+ * Device-relative MSI vector number. Must be < MSI_COUNT reported for the
+ * device.
+ */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_VECTOR_OFST		8
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_VECTOR_LEN		4
+/* Reserved (alignment) */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_RESERVED_OFST		12
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_RESERVED_LEN			4
+/*
+ * MSI address to be used by the hardware. Typically, on ARM systems this
+ * address is translated by the IOMMU (if enabled) and it is the responsibility
+ * of the entity managing the IOMMU (APU kernel) to supply the correct IOVA
+ * here.
+ */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_OFST		16
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_LEN		8
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_LO_OFST		16
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_LO_LEN		4
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_LO_LBN		128
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_LO_WIDTH		32
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_HI_OFST		20
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_HI_LEN		4
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_HI_LBN		160
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS_HI_WIDTH		32
+/*
+ * MSI data to be used by the hardware. On versal-net, only the lower 16-bits
+ * are used, the remaining bits are ignored and should be set to zero.
+ */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_DATA_OFST		24
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_DATA_LEN			4
+
+/* MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_OUT msgresponse */
+#define MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_OUT_LEN				0
+
 /***********************************/
 /* MC_CMD_V2_EXTN - Encapsulation for a v2 extended command */
 #define MC_CMD_V2_EXTN					0x7f
diff --git a/drivers/cdx/controller/mcdi_functions.c b/drivers/cdx/controller/mcdi_functions.c
index 0158f26533dd..41ebd26cd585 100644
--- a/drivers/cdx/controller/mcdi_functions.c
+++ b/drivers/cdx/controller/mcdi_functions.c
@@ -120,10 +120,29 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 
 	dev_params->vendor = MCDI_WORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_VENDOR_ID);
 	dev_params->device = MCDI_WORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_DEVICE_ID);
+	dev_params->num_msi = MCDI_DWORD(outbuf, CDX_BUS_GET_DEVICE_CONFIG_OUT_MSI_COUNT);
 
 	return 0;
 }
 
+int cdx_mcdi_write_msi(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num,
+		       u32 msi_vector, u64 msi_address, u32 msi_data)
+{
+	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_WRITE_MSI_MSG_IN_LEN);
+	int ret;
+
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_WRITE_MSI_MSG_IN_BUS, bus_num);
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_WRITE_MSI_MSG_IN_DEVICE, dev_num);
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_VECTOR, msi_vector);
+	MCDI_SET_QWORD(inbuf, CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_ADDRESS, msi_address);
+	MCDI_SET_DWORD(inbuf, CDX_DEVICE_WRITE_MSI_MSG_IN_MSI_DATA, msi_data);
+
+	ret = cdx_mcdi_rpc_async(cdx, MC_CMD_CDX_DEVICE_WRITE_MSI_MSG, inbuf,
+				 sizeof(inbuf), NULL, 0);
+
+	return ret;
+}
+
 int cdx_mcdi_reset_device(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num)
 {
 	MCDI_DECLARE_BUF(inbuf, MC_CMD_CDX_DEVICE_RESET_IN_LEN);
diff --git a/drivers/cdx/controller/mcdi_functions.h b/drivers/cdx/controller/mcdi_functions.h
index 7440ace5539a..35a300727f34 100644
--- a/drivers/cdx/controller/mcdi_functions.h
+++ b/drivers/cdx/controller/mcdi_functions.h
@@ -47,6 +47,26 @@ int cdx_mcdi_get_dev_config(struct cdx_mcdi *cdx,
 			    u8 bus_num, u8 dev_num,
 			    struct cdx_dev_params *dev_params);
 
+/**
+ * cdx_mcdi_write_msi - Write MSI configuration for CDX device
+ * @cdx: pointer to MCDI interface.
+ * @bus_num: Bus number.
+ * @dev_num: Device number.
+ * @msi_vector: Device-relative MSI vector number.
+ *	Must be < MSI_COUNT reported for the device.
+ * @msi_address: MSI address to be used by the hardware. Typically, on ARM
+ *	systems this address is translated by the IOMMU (if enabled) and
+ *	it is the responsibility of the entity managing the IOMMU (APU kernel)
+ *	to supply the correct IOVA here.
+ * @msi_data: MSI data to be used by the hardware. On versal-net, only the
+ *	lower 16-bits are used, the remaining bits are ignored and should be
+ *	set to zero.
+ *
+ * Return: 0 on success, <0 on failure
+ */
+int cdx_mcdi_write_msi(struct cdx_mcdi *cdx, u8 bus_num, u8 dev_num,
+		       u32 msi_vector, u64 msi_address, u32 msi_data);
+
 /**
  * cdx_mcdi_reset_device - Reset cdx device represented by bus_num:dev_num
  * @cdx: pointer to MCDI interface.
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index bead71b7bc73..7b84e0642a20 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -21,11 +21,19 @@
 struct cdx_controller;
 
 enum {
+	CDX_DEV_MSI_CONF,
 	CDX_DEV_RESET_CONF,
 };
 
+struct cdx_msi_config {
+	u16 msi_index;
+	u32 data;
+	u64 addr;
+};
+
 struct cdx_device_config {
 	u8 type;
+	struct cdx_msi_config msi;
 };
 
 typedef int (*cdx_scan_cb)(struct cdx_controller *cdx);
@@ -62,12 +70,14 @@ struct cdx_ops {
  * struct cdx_controller: CDX controller object
  * @dev: Linux device associated with the CDX controller.
  * @priv: private data
+ * @msi_domain: MSI domain
  * @id: Controller ID
  * @ops: CDX controller ops
  */
 struct cdx_controller {
 	struct device *dev;
 	void *priv;
+	struct irq_domain *msi_domain;
 	u32 id;
 	struct cdx_ops *ops;
 };
@@ -86,6 +96,7 @@ struct cdx_controller {
  * @dma_mask: Default DMA mask
  * @flags: CDX device flags
  * @req_id: Requestor ID associated with CDX device
+ * @num_msi: Number of MSI's supported by the device
  * @driver_override: driver name to force a match; do not set directly,
  *                   because core frees it; use driver_set_override() to
  *                   set or clear it.
@@ -102,6 +113,7 @@ struct cdx_device {
 	u64 dma_mask;
 	u16 flags;
 	u32 req_id;
+	u32 num_msi;
 	const char *driver_override;
 };
 
@@ -162,6 +174,20 @@ void cdx_driver_unregister(struct cdx_driver *cdx_driver);
 
 extern struct bus_type cdx_bus_type;
 
+/**
+ * cdx_msi_domain_alloc_irqs - Allocate MSI's for the CDX device
+ * @dev: device pointer
+ * @irq_count: Number of MSI's to be allocated
+ *
+ * Return: 0 for success, -errno on failure
+ */
+int cdx_msi_domain_alloc_irqs(struct device *dev, unsigned int irq_count);
+
+/**
+ * cdx_msi_domain_free_irqs - Free MSI's for CDX device
+ */
+#define cdx_msi_domain_free_irqs msi_domain_free_irqs_all
+
 /**
  * cdx_dev_reset - Reset CDX device
  * @dev: device pointer
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 7a97bcb086bf..d9b793900931 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1637,6 +1637,7 @@ void msi_domain_free_irqs_all(struct device *dev, unsigned int domid)
 	msi_domain_free_irqs_all_locked(dev, domid);
 	msi_unlock_descs(dev);
 }
+EXPORT_SYMBOL_GPL(msi_domain_free_irqs_all);
 
 /**
  * msi_get_domain_info - Get the MSI interrupt domain info for @domain
-- 
2.17.1

