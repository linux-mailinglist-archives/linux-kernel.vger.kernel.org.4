Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E33727169
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjFGWSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjFGWSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:18:10 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A8A1725;
        Wed,  7 Jun 2023 15:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2gc52R48iQTBtzzCu/UKlvMz/MIevCkNSIPGdBtykadfniTkUom34xlNelKFrEon3EwKsMpK/9cKQx+7NkdpmrrygCSpvXagxGbQvkV4VYZFnNZAbKgVM6SVICrlZQDZtij5TfDxqNVZ60UmUcPatjNvzV8WI0G02UgFu5oGlDkmhyv/LwUWC+/xtTWLImyKwFqCwnC0fVuIym0kuYe6M3z19rdVd+zRRsJeIT33/9Q5rPGBWFzECu1ZaLsNrIXZCvzyJspKppSMuO5MTEow9G6sIBv5kqciu0Rwakk4UaeysFkh3enNMRzqUyGkNqQrY6EbnEZdLElEFwh+PtHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cECOc7tLVigXXssSxMEkrVogzKcsCfikW+IAQfkToWo=;
 b=boFa9n2pI4K3zWXryMD1ABjmZ3ZzaDt5sUyTtCG1q94JbuT+IAUoJZlcoKghlS7KFvNHJsnjIuuUDtq2vXAha+vWX0f7ovuQsihuc9tZwaiVnunVJJP9pjZYqXaEmN2vVmIke0enmhHGAefqYQxGzrBSHhbAPSI5Wcbicm+t2Hya5zP9pA3hZ1cTSiXuqINbNyR3P9t3QQexI+JQXSJDY+mBWf5v4FO6rz4nJC1HKENZtF/84bQ7oPeFa8Bveegn0M0iS4z+a1hiRibKR74MbfnoG6O7NDvjRhpOb+UU8KA0SqTLrM1rcrvkSxkqJqXb4gTL9gR6dA3M1FhcRCOGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cECOc7tLVigXXssSxMEkrVogzKcsCfikW+IAQfkToWo=;
 b=eqQWtl8/Qt28jhcj3IzBmk01d0BXswhK7FrgXqhNAfuwhHIcrlL8twdvPifJLxCioLiVN80xBaqdGMEj13bn2TDaVF8t+jy4VbVsAXIBKP6gwesICAl1WHJPv8YbP8wIsm1KTPHAQfcMpPRoMRgvu3bTAmBTtGnJgHkameB9uzk=
Received: from DS7PR05CA0005.namprd05.prod.outlook.com (2603:10b6:5:3b9::10)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Wed, 7 Jun
 2023 22:18:01 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::54) by DS7PR05CA0005.outlook.office365.com
 (2603:10b6:5:3b9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:18:01 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:18:00 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 05/26] cxl/core/regs: Add @dev to cxl_register_map
Date:   Wed, 7 Jun 2023 17:16:30 -0500
Message-ID: <20230607221651.2454764-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607221651.2454764-1-terry.bowman@amd.com>
References: <20230607221651.2454764-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 8456e53e-4d11-4148-77ad-08db67a50ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A47um4Zfv1nSX9I8BlJheKOAspnSPDhLS53IeN+bKdS3WJSOcwTUaOK93zxG4jCZMtxe6bPDkqs+i16/th2XRvHnM3ro9SvCiAEjIrQ9ZETGtl1HlmtdRGif+6oXQbKbSkzkZHAJV6ym56PYFXSJoF0QI93AFFJP9EhRlIISX7qfJH930UFmw6vwXdN8nYG7a6CBU1EPrzLbXXSzZNp4Lkj1yWZ+czAX3WT2a7kREqApRy0veTmHKeb2KMPT3XLyvVvJk8p7KbkHWaj0W7VaDGM64lhEJf4GDvH08m2GyXV+qW8SG6l/99aIFV89pLRsx4tsSe1MyNfmiNfDPYefBtgn8/VWl1QDMyvPGy+g/zAWMX5s7IvonYmjoh7rofFvxsGOOBPA/nyrO+472OvR1fe/ioNnMT838prU8vUEW+IPmiKU4YMhid0eKNswdYDQ831ITgu0QOjQmx8k7TTHfOuk+P6V6yg/S/tWNsokaJmD4wm/vwybSGdzaWd7c295FqTQ4ipI0X4ryZ0twGwKjwQfIQpGRbIONG2vNcJTjRV9+Uy7sf1P8KnAJSd69F3diM7lDpnBzMh04gpnxRFXQO1eLGoENmHEEgPqUorzSYTcHEBS/qs4caNWjZlw+D+FXq6NfECVL9iTS1z8vDBQQNpWXi47xdwwXqWli46e43+MlU8kVfu2SsHtZsyI9dbk5fzKRYBI0aNfJl2H8B6ZatK9q++Q8tEs/U2QB+c5lEUsqN0HZyLFywh2m54PlN4sH1GgBuuk41iao/y0EkCQog==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(82740400003)(8936002)(36860700001)(316002)(41300700001)(8676002)(478600001)(70586007)(47076005)(81166007)(26005)(4326008)(5660300002)(1076003)(70206006)(356005)(110136005)(7416002)(44832011)(186003)(16526019)(82310400005)(54906003)(36756003)(83380400001)(2906002)(426003)(7696005)(336012)(40460700003)(6666004)(40480700001)(2616005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:18:01.4938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8456e53e-4d11-4148-77ad-08db67a50ea0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794
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
 drivers/cxl/core/regs.c | 16 +++++++++++-----
 drivers/cxl/cxl.h       | 10 ++++++----
 drivers/cxl/pci.c       | 24 ++++++++++++------------
 4 files changed, 31 insertions(+), 23 deletions(-)

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
index c2e6ec6e716d..3b4e56fb36a8 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -199,9 +199,11 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 	return ret_val;
 }
 
-int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
-			   struct cxl_register_map *map, unsigned long map_mask)
+int cxl_map_component_regs(struct cxl_register_map *map,
+			   struct cxl_component_regs *regs,
+			   unsigned long map_mask)
 {
+	struct device *dev = map->dev;
 	struct mapinfo {
 		struct cxl_reg_map *rmap;
 		void __iomem **addr;
@@ -231,10 +233,10 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
 
-int cxl_map_device_regs(struct device *dev,
-			struct cxl_device_regs *regs,
-			struct cxl_register_map *map)
+int cxl_map_device_regs(struct cxl_register_map *map,
+			struct cxl_device_regs *regs)
 {
+	struct device *dev = map->dev;
 	resource_size_t phys_addr = map->resource;
 	struct mapinfo {
 		struct cxl_reg_map *rmap;
@@ -302,7 +304,10 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 	u32 regloc_size, regblocks;
 	int regloc, i;
 
+	memset(map, 0, sizeof(*map));
+	map->dev = &pdev->dev;
 	map->resource = CXL_RESOURCE_NONE;
+
 	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
 					   CXL_DVSEC_REG_LOCATOR);
 	if (!regloc)
@@ -328,6 +333,7 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
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
index 0872f2233ed0..9c1b44f42e49 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -274,9 +274,9 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
-static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
+static int cxl_map_regblock(struct cxl_register_map *map)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = map->dev;
 
 	map->base = ioremap(map->resource, map->max_size);
 	if (!map->base) {
@@ -285,21 +285,21 @@ static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
 	}
 
 	dev_dbg(dev, "Mapped CXL Memory Device resource %pa\n", &map->resource);
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
+	struct device *dev = map->dev;
 	void __iomem *base = map->base;
 
 	switch (map->reg_type) {
@@ -346,12 +346,12 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
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
@@ -688,7 +688,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_map_device_regs(&pdev->dev, &cxlds->regs.device_regs, &map);
+	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
 	if (rc)
 		return rc;
 
@@ -703,8 +703,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxlds->component_reg_phys = map.resource;
 
-	rc = cxl_map_component_regs(&pdev->dev, &cxlds->regs.component,
-				    &map, BIT(CXL_CM_CAP_CAP_ID_RAS));
+	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
-- 
2.34.1

