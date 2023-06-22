Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7CB73A9AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjFVU5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjFVU5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:57:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB7F2132;
        Thu, 22 Jun 2023 13:56:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHfSshDjSzOSabCvcE/0Jo6ZmkI8uaQhw3Hwxx2a5swlHKnORcEHOU/WswpD6UWT05tYXEwiwE0D51EKqPkmC0vmpa8Jud3koQhlWKT4cgNTvRO8/K2gXmR0Q9MZJOgtpabnwKlgetvglhMgNAqfieop3D1a4R+iWx0A0gQR0JL5ne2/MMEMQMVMZpiCq42DOpLfly3c6NlRGckBRbKwOmsJXqZf8AyHWYr6BWo/VJIthAEktEj6YLYkcFxVVSSQD08BqNId6d1tS5H/vUhXZF4ghipfIa3QUi6qFpKguaeRv0Vnd7ATqxObAa7u9Q7D2s8mTXI3aYe+RZam0y1urA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GEzMeIKxZc89M43xn5/vmNh8jVN5oX7RIx3v5SSYl4=;
 b=JsBloXZ52VhsnPjb4uiNbk8tuV1ULSyqdFGWIL6szDDxwF8wYNYd6q3ixTv/MM8dnbNm4+o9DyGUB7idUToGN16fj3SlUXsr6qIYaOn6+8kELI6coP5569qfXu6q27/Ov/rYR5Y6qUSWlxCRALnS1e+X7P7Uik/2yCAD8hkEaOh3LI7K/fcXBNhUXI8UD+gINzmqvlc9NDRK5EEw9zy8SOlJ6J0Uuw6tC6YeAbV7CFWK0QA4C5BsN42mll7IGq3uoPOEofGC65ycT4kcOkOKMCPcQdKYQMjvg2OomYtfZf4COEL8auWmKU0o+WD8XiMm/JsJXynJIrYc4yYxnMu+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GEzMeIKxZc89M43xn5/vmNh8jVN5oX7RIx3v5SSYl4=;
 b=QfLYPGHoSzav5UJlRKrCd180+9tS+5E8NQ/XIwp+dfmIKiDo8qtzyf0CiqCJ6o0OQooUc8KALRcUK9rmFPzwdElu3dUqLhEMq7verGQ9H1vwfmpxZhBkhTmkDNxU/cLI6SZperNgrGlJXEM8YiEAwlfY0IgOZba8F0y1KLLIC70=
Received: from DS7PR03CA0223.namprd03.prod.outlook.com (2603:10b6:5:3ba::18)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 20:56:40 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:5:3ba:cafe::1b) by DS7PR03CA0223.outlook.office365.com
 (2603:10b6:5:3ba::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:56:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:56:39 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:56:38 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 06/27] cxl/core/regs: Add @dev to cxl_register_map
Date:   Thu, 22 Jun 2023 15:55:02 -0500
Message-ID: <20230622205523.85375-7-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622205523.85375-1-terry.bowman@amd.com>
References: <20230622205523.85375-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 646f873e-c690-4f41-80de-08db73632d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYeC2uZVib7SzGGS7lhsK7rTsyU67L75dlP5IR4xcqbijzhbZj6hSe7enpoTh8eYtizmgBnDB+g6hRR5dtjV8gEVq95DY9EzUqcM1yBbgUvOQY/k6gLL6eXsjlHm/kpgsfKb0i8r4pnxCC2Q/xUhVlWKs+nHjTLzqRxkfVc/6AJOC24ClJ3S8Q5swkhnQR13P4Up1NAHIX//ZrPSB99vUM8i0jMPVUB/kzEx9FgorjnHHtzR9MuMIDBcoptoLsSw1OCyVnaXlgfWIxZqngl8PWnlfIbgL+Zf4wZJb36ihYR61YqJOri80Vab7pjOB97GffEU6jenfDF3oeWwOgzwxDxG/ESf6Qd36iyxD837A078AR8GgRZ1YDi1q2E46M+QG7hqUS6H9RiBZ5wg5rkTrCSOaYpBf1HQRAToyCoanKk943WeInOFoQDX0kyIBTpVokLXG6pr+3C/qLncapQrWzmBeeTwgvXavsGwmWkfzfM0OqkvmnfIPPbvR/jgz6vONm5zTzkju+dRyKwrD44DAD8mbWtHIb8xTn+yqj/e9lpUoMVuAtgWE8tZ8qfe5gbO71vSD2k7uSupmtFdgva6sFwZ33iLMB4h3B8Kd9A0poEKRChM9lH/HQFxed5Sd1UxlRBY92QiG2JdfRlgipWMSWehg2YOlOGbzycPPLIE46ae18AAM+e3IyPsc049MKnvU1M5/qxWsAOOZB7C48NcOlk6uINC8fZ80aWbBbCp8mmC5HGWEpl9FlU7zph8dFE1SBO8B5d1q1705sOPi8taqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(40480700001)(2906002)(40460700003)(82310400005)(356005)(82740400003)(81166007)(4326008)(8936002)(2616005)(316002)(86362001)(8676002)(336012)(41300700001)(70206006)(70586007)(83380400001)(426003)(1076003)(7696005)(478600001)(110136005)(54906003)(6666004)(36756003)(16526019)(26005)(36860700001)(186003)(44832011)(5660300002)(47076005)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:56:39.5433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 646f873e-c690-4f41-80de-08db73632d02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

As a result a bunch of functions are available to be used with a
@cxl_register_map object.

This patch is in preparation of reworking the component register setup
code.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/hdm.c  |  4 ++--
 drivers/cxl/core/regs.c | 18 ++++++++++++------
 drivers/cxl/cxl.h       | 10 ++++++----
 drivers/cxl/pci.c       | 23 +++++++++++------------
 4 files changed, 31 insertions(+), 24 deletions(-)

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
index 6c4b33133918..713e4a9ca35a 100644
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
@@ -302,7 +304,11 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 	u32 regloc_size, regblocks;
 	int regloc, i;
 
-	map->resource = CXL_RESOURCE_NONE;
+	*map = (struct cxl_register_map) {
+		.dev = &pdev->dev,
+		.resource = CXL_RESOURCE_NONE,
+	};
+
 	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
 					   CXL_DVSEC_REG_LOCATOR);
 	if (!regloc)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 754cfe59ae37..bd68d5fabf21 100644
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
index 0872f2233ed0..0a89b96e6a8d 100644
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
@@ -288,18 +288,17 @@ static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
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
@@ -346,12 +345,12 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
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
@@ -688,7 +687,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_map_device_regs(&pdev->dev, &cxlds->regs.device_regs, &map);
+	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
 	if (rc)
 		return rc;
 
@@ -703,8 +702,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	cxlds->component_reg_phys = map.resource;
 
-	rc = cxl_map_component_regs(&pdev->dev, &cxlds->regs.component,
-				    &map, BIT(CXL_CM_CAP_CAP_ID_RAS));
+	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
+				    BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
 
-- 
2.34.1

