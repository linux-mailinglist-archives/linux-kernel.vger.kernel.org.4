Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B4A727171
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjFGWUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbjFGWTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:19:46 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F47B213C;
        Wed,  7 Jun 2023 15:19:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ked3+pjRIOjJY1pAyfIrvMVdMaKrSF3SMLtO9cIgni0a9iSolgAdqfaoq8lM2QKDmA9diUYIv9thESezGnc29l3l1RZbmPIzD0Waw1VcA88JUYQGduxeDkN7RX1nzXC3Ij/4RwsJeNXTySCZoMyR9TsE0pI6Jdn7vjReqaile6fxc++tp7dQqPTHndZG6xazwClfDT45VJGFTvwZGsT6U4U0TUKzsnjAcKqzGdtjUMxpHBbrLdKdQZK50uUzfJdPgZKx5MR5/CfOroD/nvNnmaJX2Tofx4QrBtB/iLrAMMBXGqIH94Wj46MbSn/EYxdfRek52XwBwsrixC2p4higOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCZUggPsgP0xOHD1I4YjQT7KnY0ULmjRsTsU8DgkRxg=;
 b=oKMdZlp5pEuLgqX3pmmKiBFghUvhYoUSLEw0ziMICBXfLpd/Y4ymkPXLavUpYfSawH6yA4xl9k2EqnrG++NtV7pCVRTBrCMe6hHrnR2IY2i8WQk/uHh3G9OXUrp+Bzto0ZWp7Mv1xDTjc+W/m9QAgOe8sIy3xptSCA695HtqhNH78Vr5DtV2RzrQ2atxgjK8zOQdUTyd3QgdODtpGgodqnbz/iVt+CrT0Kmo0JkXqlJyg/2znBMgK3NRsiMVU2vbLL08GAFfDpQIHoSUyDUyuKB+2BLlhJ2BpYj5O8kTEnVwo1QKXeeOAAY88T6MEJaImnV0yhF0HNq+ykNEGFzR+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCZUggPsgP0xOHD1I4YjQT7KnY0ULmjRsTsU8DgkRxg=;
 b=JkWyTsuAgF+wNMpZzeOPa5EYnvCAPQUfwllBPjk3ihc11v8696lwPnsHAv89PSKqL+yKoXxJFftlj1bD28dIh8M3vzEbx1ilc7cezZwYsXHgqVHs0/bMR8zyFIE4H46GTp6ZFR4vAfnfPp0AXIGnA64G5KJm5iEyx3BZdcy6+2Y=
Received: from SN6PR08CA0034.namprd08.prod.outlook.com (2603:10b6:805:66::47)
 by DM6PR12MB4316.namprd12.prod.outlook.com (2603:10b6:5:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 22:18:45 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::65) by SN6PR08CA0034.outlook.office365.com
 (2603:10b6:805:66::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 22:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:18:45 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:18:44 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 09/26] cxl/regs: Remove early capability checks in Component Register setup
Date:   Wed, 7 Jun 2023 17:16:34 -0500
Message-ID: <20230607221651.2454764-10-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|DM6PR12MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 784d577c-3863-4dfb-cbdf-08db67a528c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IQutv+ewGtxXoMspvrcXmFPiq+ZQ2KCkAECqiRLiHJLlSfTJziskXI3gzM2XUhoo1chjWEZwAwBMRW/vF4cG+jBOVICpqJfUiHZRw3i27W7RmfU3OpLCT4bWmM2l5+U3RPvIfGFAgfSXx5TXgrF79rBwzN+jUr3t3BkAN2rt6yH8X0xTy2E61IeEcI2puUsKYudWoj8vc4Hqw8Y/Y/yWcfaiq18I3oeYsqR4N3BIASaX9lTpPKSaQVKwG6tyVRJamzNZs12OMFKJ3lErQBh71Rhybwxe9urjPe1gwljfx81hYW5u/XyLja7hm24kcd00mVWJ0swwhA0PCrGQtu4qkIy92DbfIXFQH10NSTi0jmxF4N9gPoN3Hl7q248PSyuilP7d4vAFMIXCXNBSD9lhJxM0oVnIApBNs4nbS7NzxrY6Td6JhRt4UEe4wGt0S6lti2Z/jqK36ao2hrjd4SvRRlwp39GTK+wZ65YyU9dWMyiXAJoDHdMwF0uldC+P/bQQUR80m1dJTSwGY2LWsheXke07FMG9cKWruPN3KvnJaJ4ogAe4eXHvQQaHHSLSyqbIfFbxQt+Vf5z6TDBSqHeNUBOKs7uxCGEoR3m+Mv5bbcdiSAWJPHdIn/sve0FkR9pCBWMuMXQoJhfI3Kr5uW1Ku7rCqfVSeq5088lELj7t0OfxYlehpQQgR1BNMZ4wvgfaNh7EKxlhGGRvO7hJ/oTNBLrp9gk/vWhWFPIqAyFKcS7UUVE+S34CGyqwC1DR2jX7XXIPmI8Iioqii+2hfT1FOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(81166007)(356005)(86362001)(47076005)(36860700001)(82740400003)(36756003)(82310400005)(5660300002)(2906002)(7416002)(44832011)(40480700001)(16526019)(186003)(26005)(426003)(83380400001)(336012)(1076003)(2616005)(316002)(70206006)(70586007)(4326008)(41300700001)(7696005)(8676002)(6666004)(8936002)(110136005)(478600001)(54906003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:18:45.3854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 784d577c-3863-4dfb-cbdf-08db67a528c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4316
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
index bf80e371ef27..ba2b1763042c 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -370,14 +370,6 @@ static int cxl_probe_regs(struct cxl_register_map *map)
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
index c23b6164e1c0..e1c7efa9232e 100644
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

