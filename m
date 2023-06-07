Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE2672716A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjFGWSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjFGWSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:18:31 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7C226B5;
        Wed,  7 Jun 2023 15:18:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OhyGabfBlTH4Vs+i8hqLBmqjEZF5/VVBkuLxkVpIS5hTwl4p8PwO2WrmiAdbtQw3/ji6mVneCF/RcrUqPIy8zhlCq9FpQQ8iKi+1iM1wqC+fyLU2dAYxr4hPJ18zNOD/aGHg4c2MH9HRyG/mpL8hyaKD4evurc0Tx6/ZxHH9NTelwLopz94yaqHBDcrSdX71LpwdfmqZhtEMij+Ld0qcTbNqSYbWsAGJjguYWTsJA4q4S0AHkUfbm1NwWYutHuiIZFw6hg/vPOp29gVK3plktKqjng5Q+ATrtMvTrbzvZcAmAY67wy6sDupivHQDetTiNp+e/CBva5KXgMApANJEzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsRLMEt2sXeJQsdpVTnPaC5DuGfA/D6e4um+wi8aF2I=;
 b=DH696CYtP5b5exzBuuRNcTyw5OHeCl4rJDGZqYTFApd+QYbEWS49JIKoF2BaFHEM/kADiTQ6+e/yeq8cKtxIs/lSld2XvEUL62r/+SHdatsXPeqMnp3+DXIe2+mwTNLpE6CJdkbMfA+uNOIlBUIxOnmZM23B3g8SD2xNQWmiOXtHbIZJK3Ftj3i+Vxp5IkHz/wd13D0UJR73aFBoIcAutfH1hxaruf52UEKDDIQciaWM37cS4wCH/sTNgr+lW3EOaWrCQCfuMGZXy7sIYkpYFWlDdOS5McCBi5lAwvdWsGFqM9kiz6pb9CIq3WgXv5uLLxbypntTBjdk6+mg6KH1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsRLMEt2sXeJQsdpVTnPaC5DuGfA/D6e4um+wi8aF2I=;
 b=lEfHH3TXDtIFWLTWod6HJ+BOjzwUj8oHKWNOlcSO4wDx+77VGlg2u/NHMlsmUh4/ARtR/W8sUTIAaIBhykRvVOf+rXjhli9h8/cOn6NBOjkqs3DJ6bvCVWU3pm1DWwreqhAZt2doAxN4571nHeeiZqYLXbhZtdZGCjCLUo5FDtM=
Received: from SN7PR18CA0022.namprd18.prod.outlook.com (2603:10b6:806:f3::21)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 22:18:13 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::ab) by SN7PR18CA0022.outlook.office365.com
 (2603:10b6:806:f3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:18:12 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:18:11 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 06/26] cxl/pci: Refactor component register discovery for reuse
Date:   Wed, 7 Jun 2023 17:16:31 -0500
Message-ID: <20230607221651.2454764-7-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 106cf131-cdf6-420b-e1ae-08db67a51572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nv+cO+m/lExEbZK82GMldxxbMN1mDMzTvHBQV586jkZOq0+qLEwPc77I9h4tvYMRfCLQ1vo7ZOrleAHhM375fyWfKyOC2ryk2nBKJplIIo47meX0yhrtSICQ2c4HSPwAWBNxLhIXTSTLmvagZL4wsn/GGO7VKUFX7I9hPUgkW6d8vf1LP/6rrVsHbI+vXBReUp3EUrlOJLP+0YWldGkSlrJhNylQvpvcqnOzOAeCprrAVWg3ms4dHzyOlw7XNQTDcc+shpGOFeTbVDAspcjDEjR4YlRTY9c1NQQREzcA/w6dPv/e662Q9/r39BVkNqeQYs/79lfFYu8xy3lnnycGxoxZu47k07C5reVaHbHCJoGa9obT0de0j80o7UaNV/kOvdc7oQE8LnAB3zFuIIk5nOI0hRVw+MO8v+kdPLhuBynVVKEuIfIXquMZBe0bBfehwVEYDqw6JWOJ5wfNvRklsUAXswj/g8wZsvSDIVm+xvu/6h8BYxXoBH/RucNMfFqZ1+cmkwQke4KyzbIpJY1IeNMYbIURCbeQZDT+/NGlr7X+3rZ1ox3CPEmLmdoEDA26BzMGrP5teJ1VZJ1kPdOJcSKg2WXl0IAeP8VKyl/J5kvCtmKtem4m9TigcEHf48+NXyIM5GiL6DUg0iFnwYbW0gUIRohCnVxNZ/wKFdPveVE8WfLaH1qTMrI/zIPfLRhakxVFzrvrcDPZuZR/Eh9z5ZEwJVTMpBRSn9aHaUl3R4a6XLXgUqNmtGOEztZPdRaooquDogeLiq4Do1cMdpLNAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(1076003)(26005)(40460700003)(336012)(186003)(36756003)(81166007)(83380400001)(36860700001)(47076005)(426003)(82310400005)(86362001)(82740400003)(356005)(16526019)(40480700001)(2616005)(8676002)(41300700001)(44832011)(110136005)(54906003)(5660300002)(478600001)(4326008)(70586007)(2906002)(316002)(8936002)(70206006)(7416002)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:18:12.9391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 106cf131-cdf6-420b-e1ae-08db67a51572
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
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
 drivers/cxl/core/regs.c | 78 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  1 +
 drivers/cxl/pci.c       | 80 +++--------------------------------------
 3 files changed, 84 insertions(+), 75 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 3b4e56fb36a8..bf80e371ef27 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -338,6 +338,84 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
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
+
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
 resource_size_t cxl_probe_rcrb(struct device *dev, resource_size_t rcrb,
 			       struct cxl_rcrb_info *ri, enum cxl_rcrb which)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 095b767c21e9..1c6fe53e9dc7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -264,6 +264,7 @@ int cxl_map_device_regs(struct cxl_register_map *map,
 enum cxl_regloc_type;
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
+int cxl_setup_regs(struct cxl_register_map *map);
 
 enum cxl_rcrb {
 	CXL_RCRB_DOWNSTREAM,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 9c1b44f42e49..ac17bc0430dc 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -274,71 +274,8 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
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
-
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
 
@@ -346,14 +283,7 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
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
@@ -684,7 +614,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dev_warn(&pdev->dev,
 			 "Device DVSEC not present, skip CXL.mem init\n");
 
-	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
 		return rc;
 
@@ -697,7 +627,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * still be useful for management functions so don't return an error.
 	 */
 	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
-	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
 
-- 
2.34.1

