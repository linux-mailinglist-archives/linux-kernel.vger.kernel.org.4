Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D1A744515
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjF3XRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjF3XRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:17:43 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682674497;
        Fri, 30 Jun 2023 16:17:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTeqVZFPsFsush/7cMzTwV6HSh4bTSL85JsD58p1A+QPbbopBiwHGPhmBLHg243X8Bd2LlH1+YCJppjGVvTBF89mu7EWLKKRa3Uko/8Y5J9I6TBhahwG6Q0S6V2akoG2Tmf8kKxL2hoOm+uM795jftj8G4Le6smLAD+Rc9sZoaryZ8PEgDEzXTttIObB3m5KK+IDl0+YjJTpFUn2pwRg8v+yXkQFITQ9LxwDHkjfEzl1k2Xc9V9apaWM9EVwi508UFBuRMPdjUkFgWxWdmZW/rXl4cCMWl9CMse7RHyie7nyAoBFnvUIVAvIg6sZ2xDY+RvIUPMlf9DmSHtou2fS1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuYcRGHLQZR0bs8jN6P5lqtXoU9JqUFJvjZIf0oFci4=;
 b=KQzEbMRQboS4O6EE+LUOWCL9GNVB71qIMcIViUrdd0Iyhb8Bwgspwdd4cF00K9a6g3UG8wWm4sKWcs1fy9NGQ75CHXBJqqDH0ZTtSXdkleOxjxY75zYeT3Jt8x3Ipyboq6lGBLVDCaCZhRUkKbBPvSdyIofaBBhc6DAgeYpmQ8vnG5ATdYArUQu0uTL32WVw0HdgQZb/2uwiStfptO7RkdtGuBDTV9hCo2lKQrovZb2Kx/9bPEt2dFNr+uREpQt4fGfexfCmLW3DgsNhoKgmIRUCmiVMmLgJl6dL2N7pIx9I/vJ8b5LEAukXlmnBZxDy+VLtHsUi1bjw7XDym8k6Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuYcRGHLQZR0bs8jN6P5lqtXoU9JqUFJvjZIf0oFci4=;
 b=aV/JSGJGMT9Gu1X3bA2zyiYKnDQKLDTQQW0hnc69N9VUj1SXTUletUw6wmFdauCjL0by90zmUKJFWY0/61PTJy0o7owGXI/Mirq2NN3NooMHrmWs/CVSY5E1X5IW/6ztYUFHhlzW2ZOg+JaduvDFWb/yNcbZHaWld14ZEMqDul4=
Received: from DM6PR02CA0068.namprd02.prod.outlook.com (2603:10b6:5:177::45)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 23:17:34 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::25) by DM6PR02CA0068.outlook.office365.com
 (2603:10b6:5:177::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Fri, 30 Jun 2023 23:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.43 via Frontend Transport; Fri, 30 Jun 2023 23:17:34 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 18:17:33 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v8 04/14] cxl/pci: Remove Component Register base address from struct cxl_dev_state
Date:   Fri, 30 Jun 2023 18:16:25 -0500
Message-ID: <20230630231635.3132638-5-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630231635.3132638-1-terry.bowman@amd.com>
References: <20230630231635.3132638-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: b4604435-a20a-4805-4028-08db79c02fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HD1uMhXbP8R2e2KjpWxTn/G1B1nqqIWGjXbGcnw/bHq79KpJKSJrEcgUM+FZkbGNf/FU1VgfJICSxttxcILM0lKcH4u7B1JxOFdptrL7QcicXJjk8aebhZVA0JcIib6JnA9pOD0WWSwQC42zlp4MPZivI+lVmS3nPZFXTHUNTveYsgpYBdMygt0bHtjSUJxret9O2G5tczsydwJJhO6PVdYnDw5tfXMvYmCHtRAARTciFWc/gEvXd3WuFZmajyVHKHuKZKSnG3dOLKUoplN9cxkD49F2JQfQmli2K6tbXguWl0B8JWfDFN4VqIPEmJWUiDX+3NA/T1zD026BsrOfSgBLbmsy3TcAWhSXsW8z1TYlnloYC40CSiOOTB4jXJxkeNFLPJflQZ266BvT0U+DQRQlVuD7Spjew/M0zdnlkOoW/nslU605BkaQYfM5OCPPCmiK2QD3RrnPrMHULwqj+PG1qDkKJmIobQK3LG85IL1Rzp/OR8BAnSzknrz79712Lc4u0a4QFL6Q5uf+2gDjZvl8QKq93yGiEARMCEDDJJvr23FoUTbcDOG66CvTrVvN8HjahOriVZCd6VdEJM/5Wy9W1pHvsWGiSBe/CARU+/id/FwYujNSLKFPQmbjY/DL3lVCM1oU8S8sA7BDhcce+TWBqfBUO/lLrISym7coCKmkeSPrTuh5M7natJnniuM7noEP3Vydvweoxjrusf69nwx5WYpRnf2KZ6uvvuEvNvTQYemJaVNe6mNyd5N3YB+/qn7DwfqX781L2qLSVTFVsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(7696005)(478600001)(40460700003)(6666004)(47076005)(36860700001)(26005)(16526019)(186003)(40480700001)(1076003)(336012)(426003)(83380400001)(36756003)(2616005)(82740400003)(82310400005)(86362001)(81166007)(356005)(4326008)(70586007)(70206006)(2906002)(316002)(7416002)(5660300002)(44832011)(8936002)(8676002)(41300700001)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 23:17:34.2251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4604435-a20a-4805-4028-08db79c02fa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822
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

The Component Register base address @component_reg_phys is no longer
used after the rework of the Component Register setup which now uses
struct member @comp_map instead. Remove the base address.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxlmem.h         | 2 --
 drivers/cxl/mem.c            | 4 ++--
 drivers/cxl/pci.c            | 3 ---
 tools/testing/cxl/test/mem.c | 1 -
 4 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 607ee34b0ce7..fdfa6e5dd739 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -390,7 +390,6 @@ enum cxl_devtype {
  * @dpa_res: Overall DPA resource tree for the device
  * @pmem_res: Active Persistent memory capacity configuration
  * @ram_res: Active Volatile memory capacity configuration
- * @component_reg_phys: register base of component registers
  * @serial: PCIe Device Serial Number
  * @type: Generic Memory Class device or Vendor Specific Memory device
  */
@@ -405,7 +404,6 @@ struct cxl_dev_state {
 	struct resource dpa_res;
 	struct resource pmem_res;
 	struct resource ram_res;
-	resource_size_t component_reg_phys;
 	u64 serial;
 	enum cxl_devtype type;
 };
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 317c7548e4e9..3af3218ebe0e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -49,7 +49,6 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 				 struct cxl_dport *parent_dport)
 {
 	struct cxl_port *parent_port = parent_dport->port;
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_port *endpoint, *iter, *down;
 	int rc;
 
@@ -65,8 +64,9 @@ static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
 		ep->next = down;
 	}
 
+	/* The Endpoint's component regs are located in cxlds. */
 	endpoint = devm_cxl_add_port(host, &cxlmd->dev,
-				     cxlds->component_reg_phys,
+				     CXL_RESOURCE_NONE,
 				     parent_dport);
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 054cfa2f6a2d..2a5031f73c34 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -835,7 +835,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * If the component registers can't be found, the cxl_pci driver may
 	 * still be useful for management functions so don't return an error.
 	 */
-	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
 	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
 				&cxlds->comp_map);
 	if (rc)
@@ -843,8 +842,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	else if (!cxlds->comp_map.component_map.ras.valid)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
-	cxlds->component_reg_phys = cxlds->comp_map.resource;
-
 	rc = cxl_map_component_regs(&cxlds->comp_map, &cxlds->regs.component,
 				    BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 464fc39ed277..aa44d111fd28 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1423,7 +1423,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	cxlds->serial = pdev->id;
 	if (is_rcd(pdev)) {
 		cxlds->rcd = true;
-		cxlds->component_reg_phys = CXL_RESOURCE_NONE;
 	}
 
 	rc = cxl_enumerate_cmds(mds);
-- 
2.34.1

