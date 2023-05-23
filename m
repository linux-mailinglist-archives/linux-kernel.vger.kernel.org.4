Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA9970E976
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbjEWXYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238685AbjEWXYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:24:12 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D1011A;
        Tue, 23 May 2023 16:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maKWMi9AzCxojNAIEXXngzoM+KXvN41ns5NSXyYQz99qOaTy4Bn1c5cbKXBIkXqTRDnsHGhD4Zg9qlCDHZrMt6SlwcuH1pzTeXAMO2gIYrLZlD28JMVKlBk2zw1FsiomlRT9HJFoeZP4wA/M+Su466KisEq+HoHzp8M7IT2sGaKRgQL7lSjD9Uqn7vZMdswe9ZGbUEJhqX+HdGp98sw0CM13Xmav18n302KsDkVBHAxEd12Kw66ZcUmd9s27g3nKDwxm8EHHl28+HyBnEdmDk3cK+svECc1E3z1aWOu0g7K3tqSeds5V4E7CKWTfyV2iUO7Do4VT9rvdzOX9dvRLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCYuAh2oY+yIgsTZ3UVFgv/sZuysfs/IETLX8lmb0pE=;
 b=QkSvD5yCIZ94xzvknYDun8p8gNa4o+ujs6KHV2aV1vr9k3KEmALyM4ccK2Wc+fjt2kaPeEaKEppzQYNM3ENWLkDyW5eqs3G4eB6JfR+TEht3HF28cx35RsFlwaCeq5Vk9qX4+B90rpQ7pPkxh+XkBSe9ULrxrgH93JDlEgWM18oRPqFiXbNi1nHNayw85vDwayA4VVdp8roBkIv2mFIGyc/YFqUjkrNe5WQh+O5S0970nO7VMfNb5j9uu0I5KFgkoraAewL9tEZFdL5eML5ih3B9OKNnH7MBKtN6MDiXm5wVI9JKg00+K8Aw68zCeo5Dgq1J6HnZYX+0M1ROdkhObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCYuAh2oY+yIgsTZ3UVFgv/sZuysfs/IETLX8lmb0pE=;
 b=5M1qm29fkeWIJ/Y4QFkMkK83hXY/DcdYaU04Un5GlDQFPyUwdVmd3GsLak+IdhmnzavQHb1f/nEdLDXyWPMdLQFDcJjuFuVoRfAvWlJvmr2lIhgG/ofE2SD7BxUlK16ocTuSsPMP3bUVQK+cU7y0wY8A923fIaa43nYPLRr9kEg=
Received: from MW4PR04CA0262.namprd04.prod.outlook.com (2603:10b6:303:88::27)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:23:48 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::1f) by MW4PR04CA0262.outlook.office365.com
 (2603:10b6:303:88::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14 via Frontend
 Transport; Tue, 23 May 2023 23:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:23:47 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:23:43 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 04/23] cxl/core/regs: Add @dev to cxl_register_map
Date:   Tue, 23 May 2023 18:21:55 -0500
Message-ID: <20230523232214.55282-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523232214.55282-1-terry.bowman@amd.com>
References: <20230523232214.55282-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT051:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 334c4346-7aff-4948-aeda-08db5be4c299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/t6Nh3jEHx9AiTodL78PvtlyAcFdm0LvAo37O7pI5AApEUg0jRT6Lv6scbK9EkdM478bf4WbVmxvV3nfwUWKEMIrWtpn2CK0X+25BBHc0bLuKweNChjTnlvYdyG20iWqKVxxMqqbu+jG0IGyANNpH5KDRQ0/MltaLjT16O1z1n2TimRUBjJC4TyfR7rPTnEHtW7J0CuZsAcCkXh0DPgFUJcGmPjEHfBuO9Z7MR8v9r9J5lBi5bKvR+L/2h1vIz+pJiC2qsTqRZfOGnkit7IqfR3W4ZXYu8v0AGXzqiGhVmTiJomJAAqp+yk27QAqKRiBDghxSsK8hrSOadjtiOKxrDNVjuWwUSKkMDW8UOqVz/MmLZSNZ1H2GQ/nbratx4JM0ODIgEwPvyA5w4vvcNMnb1VUqldaMaXBmiTHccFhivFeDYX1TIknZkSQEEUEWe666mX8UZgrC9gDxzOntezwMshYxvbMzoW66MU6Ah1194248VF5/2RLOZSlliHb1CAztM78Hssvc/iR0qMPU9zpOT9zfdgFPiZoJrw1DbLjVTEdrNmYBL2k/Rf5rPY6fWxY10kEnCgaA5RjkQRIDA4faO0QCpxvMKEnKvCTPkOKgXM9II3quZfYXBTO33LzFTUBJpCwZdt6oMtYM+3PszuxfKFoyzct6LEAgmcTzMnKpXUQ2vsx+Zc7SfiHK6SBQRyo6luSagRmlPZ1tvu8MmV/AtqEQhLRtjeFnwKc6YD2XiO7yHfQGDlWCpGpenks9TvDhmPAT2/HkffO2XBr2oClg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(46966006)(40470700004)(36840700001)(2906002)(44832011)(7416002)(5660300002)(83380400001)(82310400005)(8936002)(8676002)(40460700003)(70206006)(4326008)(36756003)(70586007)(110136005)(54906003)(316002)(41300700001)(478600001)(6666004)(7696005)(40480700001)(426003)(336012)(26005)(2616005)(81166007)(356005)(82740400003)(86362001)(36860700001)(47076005)(186003)(16526019)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:23:47.7017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 334c4346-7aff-4948-aeda-08db5be4c299
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

The corresponding device of a register mapping is used for devm
operations and logging. For operations with struct cxl_register_map
the device needs to be kept track separately. To simpify the involved
function interfaces, add @dev to cxl_register_map.

While at it also reorder function arguments of cxl_map_device_regs()
and cxl_map_component_regs() to have the object @cxl_register_map
first.

In a result a bunch of functions are available to be used with a
@cxl_register_map object.

This patch is in preparation of reworking the component register setup
code.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/hdm.c  |  4 ++--
 drivers/cxl/core/regs.c | 22 ++++++++++++---------
 drivers/cxl/cxl.h       | 10 ++++++----
 drivers/cxl/pci.c       | 42 ++++++++++++++++++++---------------------
 4 files changed, 41 insertions(+), 37 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7889ff203a34..5abfa9276dac 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -85,6 +85,7 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
 				struct cxl_component_regs *regs)
 {
 	struct cxl_register_map map = {
+		.dev = &port->dev,
 		.resource = port->component_reg_phys,
 		.base = crb,
 		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
@@ -97,8 +98,7 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
 		return -ENODEV;
 	}
 
-	return cxl_map_component_regs(&port->dev, regs, &map,
-				      BIT(CXL_CM_CAP_CAP_ID_HDM));
+	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
 }
 
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 08da4c917f99..9888bdf43e55 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -199,8 +199,9 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 	return ret_val;
 }
 
-int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
-			   struct cxl_register_map *map, unsigned long map_mask)
+int cxl_map_component_regs(struct cxl_register_map *map,
+			   struct cxl_component_regs *regs,
+			   unsigned long map_mask)
 {
 	struct mapinfo {
 		struct cxl_reg_map *rmap;
@@ -213,16 +214,16 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
 
 	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
 		struct mapinfo *mi = &mapinfo[i];
-		resource_size_t phys_addr;
+		resource_size_t addr;
 		resource_size_t length;
 
 		if (!mi->rmap->valid)
 			continue;
 		if (!test_bit(mi->rmap->id, &map_mask))
 			continue;
-		phys_addr = map->resource + mi->rmap->offset;
+		addr = map->resource + mi->rmap->offset;
 		length = mi->rmap->size;
-		*(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
+		*(mi->addr) = devm_cxl_iomap_block(map->dev, addr, length);
 		if (!*(mi->addr))
 			return -ENOMEM;
 	}
@@ -231,9 +232,8 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
 
-int cxl_map_device_regs(struct device *dev,
-			struct cxl_device_regs *regs,
-			struct cxl_register_map *map)
+int cxl_map_device_regs(struct cxl_register_map *map,
+			struct cxl_device_regs *regs)
 {
 	resource_size_t phys_addr = map->resource;
 	struct mapinfo {
@@ -256,7 +256,7 @@ int cxl_map_device_regs(struct device *dev,
 
 		addr = phys_addr + mi->rmap->offset;
 		length = mi->rmap->size;
-		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);
+		*(mi->addr) = devm_cxl_iomap_block(map->dev, addr, length);
 		if (!*(mi->addr))
 			return -ENOMEM;
 	}
@@ -302,7 +302,10 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 	u32 regloc_size, regblocks;
 	int regloc, i;
 
+	memset(map, 0, sizeof(*map));
+	map->dev = &pdev->dev;
 	map->resource = CXL_RESOURCE_NONE;
+
 	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
 					   CXL_DVSEC_REG_LOCATOR);
 	if (!regloc)
@@ -328,6 +331,7 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 	}
 
 	map->resource = CXL_RESOURCE_NONE;
+
 	return -ENODEV;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a8bda2c74a85..095b767c21e9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -231,6 +231,7 @@ struct cxl_device_reg_map {
 
 /**
  * struct cxl_register_map - DVSEC harvested register block mapping parameters
+ * @dev: device for devm operations and logging
  * @base: virtual base of the register-block-BAR + @block_offset
  * @resource: physical resource base of the register block
  * @max_size: maximum mapping size to perform register search
@@ -239,6 +240,7 @@ struct cxl_device_reg_map {
  * @device_map: cxl_reg_maps for device registers
  */
 struct cxl_register_map {
+	struct device *dev;
 	void __iomem *base;
 	resource_size_t resource;
 	resource_size_t max_size;
@@ -253,11 +255,11 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
-int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
-			   struct cxl_register_map *map,
+int cxl_map_component_regs(struct cxl_register_map *map,
+			   struct cxl_component_regs *regs,
 			   unsigned long map_mask);
-int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
-			struct cxl_register_map *map);
+int cxl_map_device_regs(struct cxl_register_map *map,
+			struct cxl_device_regs *regs);
 
 enum cxl_regloc_type;
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0872f2233ed0..2a9f65be148b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -274,61 +274,59 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
-static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
+static int cxl_map_regblock(struct cxl_register_map *map)
 {
-	struct device *dev = &pdev->dev;
-
 	map->base = ioremap(map->resource, map->max_size);
 	if (!map->base) {
-		dev_err(dev, "failed to map registers\n");
+		dev_err(map->dev, "failed to map registers\n");
 		return -ENOMEM;
 	}
 
-	dev_dbg(dev, "Mapped CXL Memory Device resource %pa\n", &map->resource);
+	dev_dbg(map->dev, "Mapped CXL Memory Device resource %pa\n",
+		&map->resource);
+
 	return 0;
 }
 
-static void cxl_unmap_regblock(struct pci_dev *pdev,
-			       struct cxl_register_map *map)
+static void cxl_unmap_regblock(struct cxl_register_map *map)
 {
 	iounmap(map->base);
 	map->base = NULL;
 }
 
-static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
+static int cxl_probe_regs(struct cxl_register_map *map)
 {
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
-	struct device *dev = &pdev->dev;
 	void __iomem *base = map->base;
 
 	switch (map->reg_type) {
 	case CXL_REGLOC_RBI_COMPONENT:
 		comp_map = &map->component_map;
-		cxl_probe_component_regs(dev, base, comp_map);
+		cxl_probe_component_regs(map->dev, base, comp_map);
 		if (!comp_map->hdm_decoder.valid) {
-			dev_err(dev, "HDM decoder registers not found\n");
+			dev_err(map->dev, "HDM decoder registers not found\n");
 			return -ENXIO;
 		}
 
 		if (!comp_map->ras.valid)
-			dev_dbg(dev, "RAS registers not found\n");
+			dev_dbg(map->dev, "RAS registers not found\n");
 
-		dev_dbg(dev, "Set up component registers\n");
+		dev_dbg(map->dev, "Set up component registers\n");
 		break;
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
-		cxl_probe_device_regs(dev, base, dev_map);
+		cxl_probe_device_regs(map->dev, base, dev_map);
 		if (!dev_map->status.valid || !dev_map->mbox.valid ||
 		    !dev_map->memdev.valid) {
-			dev_err(dev, "registers not found: %s%s%s\n",
+			dev_err(map->dev, "registers not found: %s%s%s\n",
 				!dev_map->status.valid ? "status " : "",
 				!dev_map->mbox.valid ? "mbox " : "",
 				!dev_map->memdev.valid ? "memdev " : "");
 			return -ENXIO;
 		}
 
-		dev_dbg(dev, "Probing device registers...\n");
+		dev_dbg(map->dev, "Probing device registers...\n");
 		break;
 	default:
 		break;
@@ -346,12 +344,12 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	if (rc)
 		return rc;
 
-	rc = cxl_map_regblock(pdev, map);
+	rc = cxl_map_regblock(map);
 	if (rc)
 		return rc;
 
-	rc = cxl_probe_regs(pdev, map);
-	cxl_unmap_regblock(pdev, map);
+	rc = cxl_probe_regs(map);
+	cxl_unmap_regblock(map);
 
 	return rc;
 }
@@ -688,7 +686,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_map_device_regs(&pdev->dev, &cxlds->regs.device_regs, &map);
+	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
 	if (rc)
 		return rc;
 
@@ -703,8 +701,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxlds->component_reg_phys = map.resource;
 
-	rc = cxl_map_component_regs(&pdev->dev, &cxlds->regs.component,
-				    &map, BIT(CXL_CM_CAP_CAP_ID_RAS));
+	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
-- 
2.34.1

