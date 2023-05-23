Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DF270E977
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbjEWXYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbjEWXYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:24:22 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B2AE53;
        Tue, 23 May 2023 16:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkoXaAMpTycWSOuk66+dy6CiQTvfnXlaKxfBrClv5fSq7YfhuA1AfodnV3xaROYRcmg8EhRCGa2DKSSPl2GQmJutcpk4uedkjoxSTnmYcPLiPDGDxzqFHpfMhdHgbPTsvAysMUUSNCK9ej5xuTCMjavt8GzOdP/t2b3uPs3GgG3CxvjUWwKrKc22K2b/TQi9LTnopv8ClJbsKoO0deIqB6YG1LRLEQ8eaMd+Mf+NVXjOfnd4FAIXwSGexFWgkeCz/iUacnOE7l6q+fQXklL/GGziA9t/Ciia5WYw++w+dOaqRClo3o20YOX5LYGs51PXk9+4eL3jq9dAWKQTvKARyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuKQHo+wgt3bi9z1sdkiYszjcMSyPmtLrW0tH0dGwPs=;
 b=MF4OVvB4thRwdaK6Sl2g32zXocDyDT5Bj4mo4G2NEriX3T1xznSotGirpAPiYps96CwFdcy360N9W29HqzOk9a70sIeMJr9p2usBIUwxj7YqtMMdk04daGsZ1AHzxEPFkptyBt/cokij3dByvEF8zsn4OO9QQ80c6j3Z9tp39PFNNhRkT2FEebN8gK/3+EaZ8uXrAC90YyJ4x2PMre6kpV8R2eDciyIs5uwkYAIov/jTh3whFo2HLZGFOGrI+OwpVKOnmPoTuVWVX+BJA8kP8OpmEjElHLVlwxtEq4Rj1kyRkco60poVrWFiM49ZypE7ELOw5/W2LfWDOx/poRhn8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuKQHo+wgt3bi9z1sdkiYszjcMSyPmtLrW0tH0dGwPs=;
 b=TwSFZ5fVFoqUCYVZNwF/S/rNdypMxSKV47oBSDebtS4zNXQP1gAH87u+YsMwHLwz7C+1+LRQ5H75MoF4kP/K83sSy6C58mS8o8l9YJTnfyjohCIOV7jjR5lvUTqJ7YtMtrhDxgZn860wFD6VY7bVmwbneNNywu76Uf0jORiqKu8=
Received: from MW4PR04CA0100.namprd04.prod.outlook.com (2603:10b6:303:83::15)
 by CH2PR12MB4167.namprd12.prod.outlook.com (2603:10b6:610:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 23:23:55 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::41) by MW4PR04CA0100.outlook.office365.com
 (2603:10b6:303:83::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 23:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:23:55 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:23:54 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 05/23] cxl/pci: Refactor component register discovery for reuse
Date:   Tue, 23 May 2023 18:21:56 -0500
Message-ID: <20230523232214.55282-6-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT039:EE_|CH2PR12MB4167:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6974c2-8fbf-4157-9599-08db5be4c720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bUbROVVl7CbegAPvKSJu3f9a2ao0WXyvk6NYrPISM9yfpv+zsmjS05QaggOK/8+eeo7vDxL92QSDiIYTJDScPuaT48HI15HI3P46Ar7bz24LeyWfZXDIWfrFkLYkE/FhZxofhLhAo9Ex0rhH0KZ9x5FmL/0sXe5PlM/j6aB+zQEnWGFq6LrW65oofroDQwgCgeOFpLBqd9bdibFmEuSMYOveyk8X6rv3o/TaHFxC2h42uhsP8tTO/pY/BZ1w8fFqdBEBvTmRgzHctCVlpZj74Th7F2UsAa6WGUEjvgnrWHrSMK3H06nzc9oeWeNCDlv4JiJfVyXjNKxPV6S2sLLQsRrWS3Rw6+3nPCnRmNhTlg/gXWK27KBhPTqsUpK98/sG7toD5A8F8Q0AA0+lGo3vTMtsAJ4gj8JXyKgIPyVztIuNlNOvj3qd34aTsENA9vGOjtn+14+DnwsQzxMz1zWkGO64iTuJukhmAyjC8DNPJ6IDfbwvbmQYgQVyu727l4hVqWWN5bo80o8f967Aa7tJpw+VLbvDtSwULHM5ZOP3IITzss/iJ4wuXSUG9f6TDJ49iEKjVMrJN7STDOihiBhMUmUf1jbKhqW2aPI8eoIf1qq1KTMrH+YnZns5MDMP3jcdMrxAK4xS7f7Gs2NwHNcCC+Rz7w/96T+aGSvRmOK4TyjgrkynfJG6tKW/MV5P4ejzhPHpZXhHNMek1vP0LYcana44yh/VAVLabmuo8WssqCbx5BMGJdXGoQiZAMoHiPcyKxSAgG2bojXeb2EsEIbpyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(82740400003)(40460700003)(16526019)(26005)(356005)(186003)(81166007)(1076003)(7416002)(44832011)(2616005)(47076005)(36860700001)(36756003)(336012)(83380400001)(426003)(2906002)(40480700001)(41300700001)(7696005)(316002)(54906003)(110136005)(82310400005)(478600001)(70206006)(70586007)(4326008)(86362001)(8936002)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:23:55.3123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6974c2-8fbf-4157-9599-08db5be4c720
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4167
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
---
 drivers/cxl/core/regs.c | 76 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  1 +
 drivers/cxl/pci.c       | 78 +++--------------------------------------
 3 files changed, 82 insertions(+), 73 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 9888bdf43e55..cb2a5b1c6db5 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -336,6 +336,82 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
 
+static int cxl_map_regblock(struct cxl_register_map *map)
+{
+	map->base = ioremap(map->resource, map->max_size);
+	if (!map->base) {
+		dev_err(map->dev, "failed to map registers\n");
+		return -ENOMEM;
+	}
+
+	dev_dbg(map->dev, "Mapped CXL Memory Device resource %pa\n",
+		&map->resource);
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
+	void __iomem *base = map->base;
+
+	switch (map->reg_type) {
+	case CXL_REGLOC_RBI_COMPONENT:
+		comp_map = &map->component_map;
+		cxl_probe_component_regs(map->dev, base, comp_map);
+		if (!comp_map->hdm_decoder.valid) {
+			dev_err(map->dev, "HDM decoder registers not found\n");
+			return -ENXIO;
+		}
+
+		if (!comp_map->ras.valid)
+			dev_dbg(map->dev, "RAS registers not found\n");
+
+		dev_dbg(map->dev, "Set up component registers\n");
+		break;
+	case CXL_REGLOC_RBI_MEMDEV:
+		dev_map = &map->device_map;
+		cxl_probe_device_regs(map->dev, base, dev_map);
+		if (!dev_map->status.valid || !dev_map->mbox.valid ||
+		    !dev_map->memdev.valid) {
+			dev_err(map->dev, "registers not found: %s%s%s\n",
+				!dev_map->status.valid ? "status " : "",
+				!dev_map->mbox.valid ? "mbox " : "",
+				!dev_map->memdev.valid ? "memdev " : "");
+			return -ENXIO;
+		}
+
+		dev_dbg(map->dev, "Probing device registers...\n");
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
index 2a9f65be148b..ac17bc0430dc 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -274,69 +274,8 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
-static int cxl_map_regblock(struct cxl_register_map *map)
-{
-	map->base = ioremap(map->resource, map->max_size);
-	if (!map->base) {
-		dev_err(map->dev, "failed to map registers\n");
-		return -ENOMEM;
-	}
-
-	dev_dbg(map->dev, "Mapped CXL Memory Device resource %pa\n",
-		&map->resource);
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
-	void __iomem *base = map->base;
-
-	switch (map->reg_type) {
-	case CXL_REGLOC_RBI_COMPONENT:
-		comp_map = &map->component_map;
-		cxl_probe_component_regs(map->dev, base, comp_map);
-		if (!comp_map->hdm_decoder.valid) {
-			dev_err(map->dev, "HDM decoder registers not found\n");
-			return -ENXIO;
-		}
-
-		if (!comp_map->ras.valid)
-			dev_dbg(map->dev, "RAS registers not found\n");
-
-		dev_dbg(map->dev, "Set up component registers\n");
-		break;
-	case CXL_REGLOC_RBI_MEMDEV:
-		dev_map = &map->device_map;
-		cxl_probe_device_regs(map->dev, base, dev_map);
-		if (!dev_map->status.valid || !dev_map->mbox.valid ||
-		    !dev_map->memdev.valid) {
-			dev_err(map->dev, "registers not found: %s%s%s\n",
-				!dev_map->status.valid ? "status " : "",
-				!dev_map->mbox.valid ? "mbox " : "",
-				!dev_map->memdev.valid ? "memdev " : "");
-			return -ENXIO;
-		}
-
-		dev_dbg(map->dev, "Probing device registers...\n");
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
 
@@ -344,14 +283,7 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
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
@@ -682,7 +614,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		dev_warn(&pdev->dev,
 			 "Device DVSEC not present, skip CXL.mem init\n");
 
-	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
 		return rc;
 
@@ -695,7 +627,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * still be useful for management functions so don't return an error.
 	 */
 	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
-	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
 
-- 
2.34.1

