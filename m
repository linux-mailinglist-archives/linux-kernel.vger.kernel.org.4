Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8707395F8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjFVDym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjFVDy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:54:27 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52C61FEA;
        Wed, 21 Jun 2023 20:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWNjMRc+XlirNWq96thNc8+IR8V0u/ABu3ZXXQY9BPEESm3huYa3vFWIXOsNjCfEEl+PlINWL6Wf0g8hg+WVG/QKarjU+EAAcIWntjFaDpLHx3vGnj3ByNH4+4rGoZ+9Dp3EbplVY3nLb185qXgQ9X/qglRLgH54mKyDJ5u6e1nBP+eBQ7ZdGuAHC2j3zTgei6aEuk3SJpfxCZn5wkteYTnYmUFQyHM5tFwzFI3mht+rTQV3p9MbSdi8EMpIlmsw3PgI0OqsMO4VQyEjIuC0p1VurZKyvVys1dFMpFv1ySjCL+hO+mWL/UeYNe+i3f8vxRZV8w/fP/NoG/nWEaYu0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fPDt9oWCOA2VD7agqDbcIq75dtCSP481mqclj94gxA=;
 b=EvmgtZd5SA6ZkI8fAhaKTDV2IU6QNl9614RKZvzdyh0um7Q6WPqQhSDDaA2y1InoA7usDZBNscNoGP5eESd3PG0ERXh8ysV4sYQqB3ehkxrBYQ6YeIMdnYA9ZyWGbXi4MJshfjRzO5pzU2E0o44XgfwCJzDBhEpc85uOH2NIYdpunxJKalhqPOp607Ns6d2sDYBlhYO2WAuP7JL1Env0BQOaftG8T8Fm1OLI4VbXaZOL30/+tDuB97MnAfpnpkI5uhguhTFqpTFwEZL+FthGc+YHclA9zp5x1JeLd9Dr57eJpQYnXoNOr+NtpCu9uDI93I0EOMQ2DcxQE9PGrGEY0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/fPDt9oWCOA2VD7agqDbcIq75dtCSP481mqclj94gxA=;
 b=WJc260rpaYXrPUd5amnEZeHvLprBt7x9n19CpiKpgY29A8SyPgf9X4+L35g3cjo/5ldBCfI5Vi+m71bBkuV6ECG6GtN3Boul70BX7I3Pem7CZHkT9FsYDONRs3Aib5WPJ8gahe/mRL946WUH4xHXJncJviMtkPsYzOkK6zSbdGc=
Received: from MW4PR03CA0203.namprd03.prod.outlook.com (2603:10b6:303:b8::28)
 by PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 22 Jun
 2023 03:53:50 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:b8:cafe::e4) by MW4PR03CA0203.outlook.office365.com
 (2603:10b6:303:b8::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Thu, 22 Jun 2023 03:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 03:53:49 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:53:47 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 08/27] cxl/pci: Refactor component register discovery for reuse
Date:   Wed, 21 Jun 2023 22:51:07 -0500
Message-ID: <20230622035126.4130151-9-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: af6f1522-b55b-4a0c-3075-08db72d449aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WTVQOJMd4UVHcQ3DKUM3n9YCGL97+8gOy2iTlScQ7m6dDb2lMaAZs3rElcA7H87IRjw0oNOSm6UDg5pjjdYTgRW3Nwambc+eI2dgbaRm+4CgoL91YP85J2Nox0B2oqqJmDb+qYY3dC/MbKIcw+kYrQGaF/5OPHZ+5pSFIIbaMaCPw2FPgfru5cljTaj15g0CPYjIW+MZ3NEDkd4KzXhauu40FdYl8c/Cm1w6luBDJy4FjMmrR82UVeFLH3H4RdT/wMoPmbcJLIkxSf61Tv+Emlb2wFjsdURhWk0UOqDobiOsb/zwK2tWNLAkdHd4RNTrwCPKiI0XZDy+Fypr6rAhDowyLZmU+HxQDM97wHCYiItIfX5VCJ2DNLyRjj7RKIV3aIUfSj/IRNPIHco6b00ydKWtnV/eQZUjvllarmwog+fhu1O6IYWSEBk9o7VW2DeETEeieRzgtxEA2CZ7McXAc5M6YIVaaYedIslfI8j+bLHZ666Ibpes5ioVlXhwEvZDLWcoAV55SgM/d+dfu6QRWPCH2W3YfTSO+VaA085j9/UmXQyOXlDHsEWu3AZY57juO8jIWktj+yKq2F3oaNiVgCIsbln3Sa4uSEHuj3VkVDsfE9btN7wRvZ1QAXKROk4/YVNOWoXOZ48F+kC8FCmdsj0NzBwilhKpuj63i4TC671kg/f7CT9x28FGTiAwRt8Nly3d82J6uUHJ01Gu8o1tAuQkNffjeogEMZz1eRRrZPI3ADl91dMeiGmBNIMOJDcaT+Te0ln3P16FKQvtNgvgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(7696005)(6666004)(478600001)(47076005)(36756003)(186003)(16526019)(83380400001)(26005)(336012)(2616005)(426003)(86362001)(82310400005)(82740400003)(81166007)(1076003)(356005)(36860700001)(40480700001)(41300700001)(8676002)(8936002)(5660300002)(316002)(2906002)(4326008)(70586007)(44832011)(7416002)(70206006)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:53:49.6174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af6f1522-b55b-4a0c-3075-08db72d449aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164
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

