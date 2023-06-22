Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AE77395F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjFVDyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFVDyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:54:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F5A268A;
        Wed, 21 Jun 2023 20:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNM63QIIo8eNVXi4VL+Lh4yMFURiyBeaw2fvPMybY/dKib1OcArw3YhqsXzyaZ2mi6eNoY8H5cBItNtcilqx30QepBrJ8dh/c+MSX4yk5Vjz6XHvctXmQlbPQFg1ZRi/SAIbAUL0blMYj09FElgCRQ4ewwzwL7MdP70eAtwd4ddqrK123hOSGBfDIupmC80n0SJQXOrZbKjT2Ll3O94gRTpQZYEc57JBObHvH7/3F+VOouYIyo3KUcAOD82zN9UOcSHw+dmVky62d5cTbB3W955IDH+iM2clCuuFZw7mIwjbAsjAPah09uAPi4OnbjTHtHGTbSMa0upyaguSxgkeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wq/u5D+bx9jIqXYGIpZZFSmx4bnSQZCU9S92xb8m9GA=;
 b=gbOPaqTh/jKIMoDwtqcrNGpCKQqkFnhFP8RJBS8Zif7sjDG2zxajCrFLagGI6AWyKSwUBx2+CxRXCZzvc/j8BVXCmur+3pi1n9Up0kIvd91YTv3P2kbMGJI0gHAGa4VcSOD0zmbtfuhhn+vtnljgE+iNE4WVXVI5G0YCkgjyvfSwsztzDqqGAyozmqXnuV0vd1ewqhOSzXwBF0qbr0fLCZNMFYmyn+jlOGZVTWq4zE5vUJCUFDwHktrw2QT6mkcW7wtotWj7vJUA7nwOQ2p1GfE/LpzMYtI8AZUW4L9/LM0coMWBxvxYfakn43cq5Ux3mVfLYZ9lAxqUNlBzNZZ1vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wq/u5D+bx9jIqXYGIpZZFSmx4bnSQZCU9S92xb8m9GA=;
 b=M5vGL41NSkNsOH48wT4Gv5HfS0rKbyEkTVADzRUqoa6SDkqP3RP8f1KorQxEUz408vxQpq5MjQypI028juT0lp754lmQ/uO2z7QzcortINl6aL2i9Z8l8gqxHkL9kHJzAzMHyW5B/iUkOgg2lVQdi26Bp8RRVzrVBCQWN5LQp0o=
Received: from SJ0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:a03:33a::7)
 by DM4PR12MB6160.namprd12.prod.outlook.com (2603:10b6:8:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 22 Jun
 2023 03:53:38 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::35) by SJ0PR03CA0002.outlook.office365.com
 (2603:10b6:a03:33a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 03:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 03:53:38 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:53:36 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 07/27] cxl/core/regs: Add @dev to cxl_register_map
Date:   Wed, 21 Jun 2023 22:51:06 -0500
Message-ID: <20230622035126.4130151-8-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622035126.4130151-1-terry.bowman@amd.com>
References: <20230622035126.4130151-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|DM4PR12MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: d45ebc84-c78b-49ee-c877-08db72d442c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qi69Uhj6xsIxlclUDCBnl0QRlg/1nkUUZAhUrFJbC7OFK0G8bmyXn3Q3Vp9z+TvJ3iXiBH9jofkx/7M/OACzWLFDvcbOs0tHPbbhQ+nW4BE4oQEMAolX0+3gB6kCZrBYe+IaHuSgFHvY3yWSE3BtNkTGNBc7Z30U447bMgNvfgHVcoB3ZaJNHD/9voWDfpHxpgoGvk7vosCFMqM27XuBCGyvGmKleQ7Myo9dziiOFxJJn5KWhJ1WaA06SW5h2bUpNwdRG6HavTQtmXbnGoWRSoPqcy5fqGO3aa/5Q7NY+PKg9rXqLqnGPMqPlKyInsDJFklyqExerlMXljzTktDr7AjhO6VryP+8+IIxCiIMYT4lMxcCXnlvXBLAKiLE1bj2VbraymFWtxU44YuFg59bNc5W5+ydr144kebuMf5iUFOXRNR1h1+z5c9wLhLs2ruhbIhsqi9ZR1u3QzLwUTjcEwzC6QPZXe4QGHGyrcxdJMeu2292GO//TcAsouXyzceIgnpncZXPw6x/sW/K7lK/uA4zHwuqaqAfd2OOLzZGEbZcU79V6PFfHBeW1Iad2B/TU6FIuEDMsx+EAOHtEFDhAEDuQaWmtp8wdEdeYKLtI2HF6rmWaMAa3v4mibubhcxPU2PCgEq7TYJ6HKLQpR95jmN4Zn8Lp/HIXgLqWSAdRsqOSzdcRn5f1W9Un+jBiINp3ACqKz2PYn0m1XsJuM+Zd3F9WkbAERqBldndsJnH2xXH82vAw2JOCIVJOaEe3vTlKMD0vb++XavpHudDWbnhbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(8936002)(8676002)(41300700001)(40460700003)(82310400005)(478600001)(16526019)(82740400003)(356005)(426003)(2616005)(6666004)(81166007)(336012)(83380400001)(26005)(186003)(36860700001)(47076005)(7696005)(110136005)(40480700001)(54906003)(36756003)(4326008)(5660300002)(316002)(1076003)(70206006)(44832011)(70586007)(86362001)(2906002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:53:38.0426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45ebc84-c78b-49ee-c877-08db72d442c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6160
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

In a result a bunch of functions are available to be used with a
@cxl_register_map object.

This patch is in preparation of reworking the component register setup
code.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
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

