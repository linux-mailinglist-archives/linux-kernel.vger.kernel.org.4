Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D10D7395FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjFVD4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjFVDzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:55:50 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8331272A;
        Wed, 21 Jun 2023 20:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmdcu5qeo8R/YCVANohoWn8YC5ToU45aAZFCiBlGElcbbbrJ5VZmpQOVLAdmUps3o9K3L7i6Oucmp5m5Nw/SJLnhLXXc4le2ssnwY7kgdYeKvWnZDZuMYXH7WfO5qYDpVeHbJaH/wX/I4D45CoQyil6U2Lb9Htib64ZtzvJhwtVV7KdqFdmN/tknd4DSVzR4GiJeDRd7os7AlwgGVZlshTwdD0CLkO6HXT+KIW4pFj250XM3kJo58TlfCUkNqMwDeR3r1RtzHWLXz5sX4gSgagwNJzROy9+dnGt3uaM4W1iZZ13Ca8qlUbh2F+VBBFJhwYK2XbDXVpN2lMkpukPZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IqJ+mOd5KPwVI76S2Q/gRsUbFq6Y6yh5uPvLB4Nqb4=;
 b=jdOGFdlgiwzVuv3ItP1IlMi8trd1YvUmq8l/bUjEZg4YSdfwBz4MLJYXKhjzRJvufl/Qp6+b5xcXniz41yt1JcqE/RcimFyDbFz01Jlam8hOaQUZoh417j6rmQFPeJASXX2nGgQ0+vl/zGpAbHG5Kybla6EO7gxg8ir8jvRNFmIU6KTmr02IKR1KgkTv5EYWexAtZUzEm80mrI54OnVGEoxdIKyn+eRNKHo9fcXgpHW7k6rUOVH5BuJy+E+OKwM5FqW7Ug3VTZZ6GzgnLof0lrsVG1fYE6TLbIvCj7dlOs+0/0DKFf6rAMM488QccCXrso8cUgjmexP+rl6kbUZKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IqJ+mOd5KPwVI76S2Q/gRsUbFq6Y6yh5uPvLB4Nqb4=;
 b=JzZQst2yBx5MdpMEGZYeTAb98VdxA32j+OdRrBUYg404//fFhbtaVJewPPfDXCgeqqZER3w3jqDNdsIR4fjNPHfyAY3jtpsdAldaQwATR+GDFT6TAEIHabcC3UKlmetakoyGPjmnVZhoERJ+6SIAx/3aX4dbB3Pdt9GN7TkUTQA=
Received: from BN0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:408:e6::16)
 by IA0PR12MB8747.namprd12.prod.outlook.com (2603:10b6:208:48b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Thu, 22 Jun
 2023 03:54:55 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::56) by BN0PR03CA0011.outlook.office365.com
 (2603:10b6:408:e6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 03:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Thu, 22 Jun 2023 03:54:55 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:54:54 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 12/27] cxl/regs: Remove early capability checks in Component Register setup
Date:   Wed, 21 Jun 2023 22:51:11 -0500
Message-ID: <20230622035126.4130151-13-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT030:EE_|IA0PR12MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e69c060-30d2-4987-016d-08db72d470a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aw25LaJIPzsfACsn4YXYIzvQsRENHEFGulWlUWu8Kw5GDfrgMy/dtunw76LLRTOb+2TzaKXjL57tVVHamIzgZPBp2SWvxNCOYbiNoPFahCDxbmJlwtXPyS3THZaRaZbTo0tDWclNZIBoH50I3s9DFsaxXpkq3qq/THigvuwTmaiBr/3l1P2OEw6SUyxV7XW+0QvFJxlBjqcxZaic6EO7XXiZP5CUzVzKwstKXlKjiRm0+/YzzwT4pU0IGMWi5nhakza1G+UIUmihUhdyOVlYb0DPvLPx5l6DgvzXinPH6hguCusb+yuhqeCa6f2CNRZx6+DgBFWRmSS4qflqFNF8sSnlapGPbtbxnGSKiTlPhroLqYqsbDUF9P3JX5jXGuwnhIP162lz8q0yyM3P0HhkEDTG/7b/qYoe55QMUReEGBzI2Wa8CV0MWJtQngpkt5TB72YGHBkbtmuOa2TyrdTDbkMXcM1okBeXgdE3uXKPWJstVlBZbRZ/7RveAu0KimBB8OXQpQfm3XGdKvxIntbW5Bx9CZDNWhhT75EM+EYcBXeyt7jJAr5VIEbaAiglp50Rqnl8FgGHixoNntNFJksoRnyTHebE9RbafV3R4l40gQNyaJjHRQcOTu7g/VdAisMXHwMupxIvpcrT86Fvhw1JKGgDXH4GlA9VbHUB55C0XC8UC4kY/oLWjY1WGLvaAw3bKZp7nBkw4HyQtG9SRYZVvcyS/b7rqJjBGhjCM0qxQEU453T/ug/OBQnnn4VA7aXd3faBG788LkY39wMAFv0Zbg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(7416002)(356005)(81166007)(336012)(426003)(2616005)(47076005)(83380400001)(86362001)(36860700001)(44832011)(2906002)(5660300002)(82740400003)(4326008)(54906003)(110136005)(16526019)(40460700003)(70206006)(8936002)(8676002)(82310400005)(186003)(26005)(478600001)(36756003)(41300700001)(1076003)(40480700001)(70586007)(316002)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:54:55.0992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e69c060-30d2-4987-016d-08db72d470a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8747
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

When probing the Component Registers in function cxl_probe_regs()
there are also checks for the existence of the HDM and RAS
capabilities. The checks may fail for components that do not implement
the HDM capability causing the Component Registers setup to fail too.

Remove the checks for a generalized use of cxl_probe_regs() and check
them directly before mapping the RAS or HDM capabilities. This allows
it to setup other Component Registers esp. of an RCH Downstream Port,
which will be implemented in a follow-on patch.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/regs.c | 8 --------
 drivers/cxl/pci.c       | 2 ++
 drivers/cxl/port.c      | 5 ++++-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e035ad8827a4..e68848075bb6 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -369,14 +369,6 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	case CXL_REGLOC_RBI_COMPONENT:
 		comp_map = &map->component_map;
 		cxl_probe_component_regs(dev, base, comp_map);
-		if (!comp_map->hdm_decoder.valid) {
-			dev_err(dev, "HDM decoder registers not found\n");
-			return -ENXIO;
-		}
-
-		if (!comp_map->ras.valid)
-			dev_dbg(dev, "RAS registers not found\n");
-
 		dev_dbg(dev, "Set up component registers\n");
 		break;
 	case CXL_REGLOC_RBI_MEMDEV:
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ac17bc0430dc..945ca0304d68 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -630,6 +630,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
+	else if (!map.component_map.ras.valid)
+		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
 	cxlds->component_reg_phys = map.resource;
 
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 4cef2bf45ad2..01e84ea54f56 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -102,8 +102,11 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 		return rc;
 
 	cxlhdm = devm_cxl_setup_hdm(port, &info);
-	if (IS_ERR(cxlhdm))
+	if (IS_ERR(cxlhdm)) {
+		if (PTR_ERR(cxlhdm) == -ENODEV)
+			dev_err(&port->dev, "HDM decoder registers not found\n");
 		return PTR_ERR(cxlhdm);
+	}
 
 	/* Cache the data early to ensure is_visible() works */
 	read_cdat_data(port);
-- 
2.34.1

