Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11C573A9AE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjFVU50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFVU5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:57:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97C0213D;
        Thu, 22 Jun 2023 13:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoQCbZ0r4fe7omGQ6qsWuJ8lPOHcu7rTnrNr47a/5AUx4mbqmC1tcHpKIGgQJ6Sk4x8YVMtm2qkSVIIKmnC7ePIlJiMZQD0sJRNnPiwiQYwkgMWnEn5h5OwKep2IrdP/WiLXt5HvWeL1Mip4mZguC8+nTMIEDJxe6mM0nmOMJ/1624yilw3xGDV7qx3Nq0WVAqNmRa+P39a2qS2FUXLk/6FCSUCC3izka/YoprFGUg0LscM+bXI5or482oIjvYBe/GiTaaFaTroFP1Dpyjy761e3NB9ChyzQ7LnUteakCiqNmpBVKHvlxlAN/uh3egwrXf8ImfbVRRlKVBsWVhe1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fPDt9oWCOA2VD7agqDbcIq75dtCSP481mqclj94gxA=;
 b=RW+Aivm+QxXxvAV/SyQ/Y3Ot8EbLKm4fJuHx3X6fJIczq8GYSf5fqdjkaN5Qveba0/6CBIJuMbf2MqthxLDtdneujLg40M8dXYX4wcHHz9b5l1LWCEwncQzFFzJew9x57us9pUypAoORjntMqoTeBikSdezZwX7fTFv/rpV6uDdn6TPDvH9sizpNDYhrQ7LEE2USqPDi3m56gNHlvENxoZaOhuowASNXvYJQFZCN+1xosOhAb1TbjhYprdfHviL1Da15yvVm4OaX5Rs6zXFMOFILJWF6dzv9HpffqAc+7CeibzF9cx5eMv3OB80azUr1lf7YaLk/G9FVIIpEDSXHrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fPDt9oWCOA2VD7agqDbcIq75dtCSP481mqclj94gxA=;
 b=Sie8sHP36Y7liY7O9qF8vdMpsnlRgzzp2PUMDNI0ldZS8M805/pnCoh7LNOKTriJH4zLEmAOxH2YTErPuJR9lWwBhPPLUFY/ooVD61Smu2IHXY8YEElEp94vAk1APHSmOOlst+9KWDAqLeQM9BGjSP44Nf8aCwJh/QLCMHpgYgw=
Received: from MW4PR04CA0103.namprd04.prod.outlook.com (2603:10b6:303:83::18)
 by CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 20:56:50 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::40) by MW4PR04CA0103.outlook.office365.com
 (2603:10b6:303:83::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Thu, 22 Jun 2023 20:56:50 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:56:49 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 07/27] cxl/pci: Refactor component register discovery for reuse
Date:   Thu, 22 Jun 2023 15:55:03 -0500
Message-ID: <20230622205523.85375-8-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CYYPR12MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: e5bf2be6-dc12-48b0-b0ed-08db73633381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KshAh/3pIbBlnQL0Zzu0fED5thE3sabCjxSdKlvSy4u4XYKMgmo9jcHmGDSpelNkbvauFdH+exvYVtOnVI80X6YbiYzg9sicuXpn0TfO5M6a2amPKwM7RJTej9w8448ldumZd70xL3lyosJ1ClEh8eKMA0CNuwRd29Oo3jsvJmyGBv0FdzmP6okYTpiD0DUpTD+nQjyAJCiuLPl+RtgNXtELUiTSSnpDRhQ/KI4RdW/NnF2HhRI+QLYbXsETT+2DG4p+rJj+KDDFFcHc/22iW+hmG7uc+3sc9k3k1DvsAe6vaR+J9Lykt4khOdod5ZYcU4KkvwB2n/SZL5oX8mm56wSMpoYfQ4/2gUlx0kWowAWiOHMzY9b6L1hsfLEppKUH0ThQT7lFGQ2T9+wLKsiCiVl0MPSfmOgvstchR7IJEdYKLsiXr/z8aDtv+TnOTAtZb9bMn+DglrYWC/YNKn0CPTxRcYwBI3s9E5PAf7LdYEY8oIeIQnsiOvsyX9YXpU65M4P57c+fFo+uUHmFCWzf3YTFLXRTQd5jzHQbhuuqwGti+0eBmy3g4dnVc4TfcETJb6R5hBBSKxmTcfynCuDONp2OjErLlhefEosUc1/hEloWPxM4LNTf63D6ZMOHG6yEHeW2+HIsLXVxf/931pg62GJwMiMrZV5YnrG+SFFT4DuLV4DTNXb0D1iP4T3cOQkPXEHW+KmEF9kvsLVOyJWV/x+Azoc50X3jZzDIBLLO08B5YljJ4toZqH3LlNw6u/0Z/UdfC4lKFj+kEEW5xhgK9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(186003)(26005)(16526019)(1076003)(40460700003)(478600001)(2906002)(44832011)(40480700001)(81166007)(41300700001)(86362001)(36860700001)(8676002)(356005)(8936002)(7416002)(110136005)(47076005)(2616005)(426003)(336012)(36756003)(82310400005)(54906003)(4326008)(82740400003)(316002)(6666004)(7696005)(70586007)(5660300002)(70206006)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:56:50.4432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5bf2be6-dc12-48b0-b0ed-08db73633381
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8655
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The endpoint implements component register setup code. Refactor it for
reuse with RCRB, downstream port, and upstream port setup.

Move PCI specifics from cxl_setup_regs() into cxl_pci_setup_regs().

Move cxl_setup_regs() into cxl/core/regs.c and export it. This also
includes supporting static functions cxl_map_registerblock(),
cxl_unmap_register_block() and cxl_probe_regs().

Co-developed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/regs.c | 77 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  1 +
 drivers/cxl/pci.c       | 79 +++--------------------------------------
 3 files changed, 83 insertions(+), 74 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 713e4a9ca35a..e035ad8827a4 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -338,6 +338,83 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
 
+static int cxl_map_regblock(struct cxl_register_map *map)
+{
+	struct device *dev = map->dev;
+
+	map->base = ioremap(map->resource, map->max_size);
+	if (!map->base) {
+		dev_err(dev, "failed to map registers\n");
+		return -ENOMEM;
+	}
+
+	dev_dbg(dev, "Mapped CXL Memory Device resource %pa\n", &map->resource);
+	return 0;
+}
+
+static void cxl_unmap_regblock(struct cxl_register_map *map)
+{
+	iounmap(map->base);
+	map->base = NULL;
+}
+
+static int cxl_probe_regs(struct cxl_register_map *map)
+{
+	struct cxl_component_reg_map *comp_map;
+	struct cxl_device_reg_map *dev_map;
+	struct device *dev = map->dev;
+	void __iomem *base = map->base;
+
+	switch (map->reg_type) {
+	case CXL_REGLOC_RBI_COMPONENT:
+		comp_map = &map->component_map;
+		cxl_probe_component_regs(dev, base, comp_map);
+		if (!comp_map->hdm_decoder.valid) {
+			dev_err(dev, "HDM decoder registers not found\n");
+			return -ENXIO;
+		}
+
+		if (!comp_map->ras.valid)
+			dev_dbg(dev, "RAS registers not found\n");
+
+		dev_dbg(dev, "Set up component registers\n");
+		break;
+	case CXL_REGLOC_RBI_MEMDEV:
+		dev_map = &map->device_map;
+		cxl_probe_device_regs(dev, base, dev_map);
+		if (!dev_map->status.valid || !dev_map->mbox.valid ||
+		    !dev_map->memdev.valid) {
+			dev_err(dev, "registers not found: %s%s%s\n",
+				!dev_map->status.valid ? "status " : "",
+				!dev_map->mbox.valid ? "mbox " : "",
+				!dev_map->memdev.valid ? "memdev " : "");
+			return -ENXIO;
+		}
+
+		dev_dbg(dev, "Probing device registers...\n");
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+int cxl_setup_regs(struct cxl_register_map *map)
+{
+	int rc;
+
+	rc = cxl_map_regblock(map);
+	if (rc)
+		return rc;
+
+	rc = cxl_probe_regs(map);
+	cxl_unmap_regblock(map);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_setup_regs, CXL);
+
 resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri,
 				    enum cxl_rcrb which)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index bd68d5fabf21..ae265357170e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -264,6 +264,7 @@ int cxl_map_device_regs(struct cxl_register_map *map,
 enum cxl_regloc_type;
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
+int cxl_setup_regs(struct cxl_register_map *map);
 struct cxl_dport;
 resource_size_t cxl_rcd_component_reg_phys(struct device *dev,
 					   struct cxl_dport *dport);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0a89b96e6a8d..ac17bc0430dc 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -274,70 +274,8 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
-static int cxl_map_regblock(struct cxl_register_map *map)
-{
-	struct device *dev = map->dev;
-
-	map->base = ioremap(map->resource, map->max_size);
-	if (!map->base) {
-		dev_err(dev, "failed to map registers\n");
-		return -ENOMEM;
-	}
-
-	dev_dbg(dev, "Mapped CXL Memory Device resource %pa\n", &map->resource);
-	return 0;
-}
-
-static void cxl_unmap_regblock(struct cxl_register_map *map)
-{
-	iounmap(map->base);
-	map->base = NULL;
-}
-
-static int cxl_probe_regs(struct cxl_register_map *map)
-{
-	struct cxl_component_reg_map *comp_map;
-	struct cxl_device_reg_map *dev_map;
-	struct device *dev = map->dev;
-	void __iomem *base = map->base;
-
-	switch (map->reg_type) {
-	case CXL_REGLOC_RBI_COMPONENT:
-		comp_map = &map->component_map;
-		cxl_probe_component_regs(dev, base, comp_map);
-		if (!comp_map->hdm_decoder.valid) {
-			dev_err(dev, "HDM decoder registers not found\n");
-			return -ENXIO;
-		}
-
-		if (!comp_map->ras.valid)
-			dev_dbg(dev, "RAS registers not found\n");
-
-		dev_dbg(dev, "Set up component registers\n");
-		break;
-	case CXL_REGLOC_RBI_MEMDEV:
-		dev_map = &map->device_map;
-		cxl_probe_device_regs(dev, base, dev_map);
-		if (!dev_map->status.valid || !dev_map->mbox.valid ||
-		    !dev_map->memdev.valid) {
-			dev_err(dev, "registers not found: %s%s%s\n",
-				!dev_map->status.valid ? "status " : "",
-				!dev_map->mbox.valid ? "mbox " : "",
-				!dev_map->memdev.valid ? "memdev " : "");
-			return -ENXIO;
-		}
-
-		dev_dbg(dev, "Probing device registers...\n");
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
-static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
-			  struct cxl_register_map *map)
+static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+			      struct cxl_register_map *map)
 {
 	int rc;
 
@@ -345,14 +283,7 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	if (rc)
 		return rc;
 
-	rc = cxl_map_regblock(map);
-	if (rc)
-		return rc;
-
-	rc = cxl_probe_regs(map);
-	cxl_unmap_regblock(map);
-
-	return rc;
+	return cxl_setup_regs(map);
 }
 
 /*
@@ -683,7 +614,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dev_warn(&pdev->dev,
 			 "Device DVSEC not present, skip CXL.mem init\n");
 
-	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
 		return rc;
 
@@ -696,7 +627,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * still be useful for management functions so don't return an error.
 	 */
 	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
-	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
 
-- 
2.34.1

