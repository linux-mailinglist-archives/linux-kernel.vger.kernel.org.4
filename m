Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5BB73AABD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjFVVCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjFVVBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:01:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BE21FF2;
        Thu, 22 Jun 2023 13:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJkQrLAdhHMcrBaH/rRgUECWStjCvKB59uhhgNyFKNyGfw9ZL6Ns8R0SJO2ZGZbxDWmDxlpw+yrwHLeaVkRa+0NlpkbwFyXKLKIm0zq2Wp+TaCM81A3Kfx5j4zpYug3akIA4An0OYepFlx+l8ajzm4sdM8qXnwLxtlDUl/3uGU05rVpkIDLVJ+IfaOEkkZ8I3SRUW5igmS5t1UMH17LuVyn2yjT8Q+B1COIYq8qmAEh+U+iwq18xM7ebrNM3O9o7eBzrcISYXp1zp7ebvCmvAmvjOLmBKl23abEf+amXv0r4in1idjcBWpPYALUq8MOdBfVJFjpkARQLESvytXF9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8D11d93aD0raN4W9zkc7ZDlIv/12QAi/az/g2ZWtzE=;
 b=BTuItyJeoPHgqFD7/2/G36sEpiqcrFkNeyGsGBzYvXuB9CwgQFm8BqKPtjKjWLl/p/jrVvdlurGnicgWY85+OwAhS96kxNWgI+cptkt+DPiQ3c9wOEXH1CT87kHV6b9/U/ZyvgaSl0h5KhJLmWYjQJBYzIuKuL49chS+UCy2ceqknBLEKmdoBNGj3uv6u0sRR8Gk7zT1QKsPYmqTvbIlhQMCkKfQRXsCkPyiApdlU/JNy9wVTqQPY8u87OmHVbGWcJEVS7yHPvMZ3O8RKvvNACB7YxMD2A6hv+6aQuSOZzblTb7CVtrZYdfTxuemJrSruxZlki7xbHFtB1p79152eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8D11d93aD0raN4W9zkc7ZDlIv/12QAi/az/g2ZWtzE=;
 b=Os8NKAdGRKghiNTkfHmRC7PTjTOrUDTaFD5yvbxiY3la0BXbOThW2B/enOd26UtdOlecgvEWaM+e/Le84IPs/FL158XTiRyPWF/XppL5WnJnzT9hHBQfuRO/u8QxUSCjBBe0tU4DAHhv+ExeAl3YOCqvyXuETcw5pcduDOr9BgE=
Received: from CY5PR14CA0027.namprd14.prod.outlook.com (2603:10b6:930:2::7) by
 DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Thu, 22 Jun 2023 20:58:29 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:2:cafe::3c) by CY5PR14CA0027.outlook.office365.com
 (2603:10b6:930:2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:58:29 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:58:28 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 16/27] cxl/pci: Store the endpoint's Component Register mappings in struct cxl_dev_state
Date:   Thu, 22 Jun 2023 15:55:12 -0500
Message-ID: <20230622205523.85375-17-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DS0PR12MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5274ce-7e93-4bf9-a088-08db73636e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5e2sx6IZp1F3ii9LLvTjrMnzHtjiPxthq52AWVtzPN29LbvLXKXM7+pDwC3E7MGCokeArtsz0Z3V//84MXb7+/aD96pPM0+iJuaRzR9+6HxqEvVSCiB8F2JNiV20dFMx2i+FI7FPEzBCQYVejYulAFN4Hzt4E1D93AgS8FQbHPGjmD4UxGPPxgT/CfW0J6Vs/ajkzm9AuDEwnG8kndsgGMQGQYDQSRY6XsximfP3CNvE1QZFctACxAh7wX9xfRaDYZuonSO+zXnMIsWBcbHqAGkfGlx8u041Z1Fk9bktjX/xKR2KB9z6ppKcuI986G90hqQmv02qRzmg/De+gxj2PUgx+uenAByY7ypjNKns3mMZoUFA1f2cjtSIoik0UqSUQkxg/rUaGOZC3x8b953tZUqyDxF2fbrFv2zeihJ4ls/Ei3mC4Pc0HSPPzGzlSXTJfsL21NRtopBsVlkDo3ICj7pbm0zcHv6WIT3Vb0EtKaqEg5lgh99LDXLENkyiN8Y5wysc1LhhNN9bpExJoq15wB+4b+wMvwk7M+dELLDmeRbM5vi62pCdwHdkS7T8+uEQAzAxJibt67twuo/LZ2ir7lYak72WesTmvoKQlZmMRHTo7/2dlwExTw1jMepJlyqmI2EjBYNuqHC7MUxgb9dm+5B0Ds1C5KzfKi6bV2RDTRXrharUh4Z6boBD1b3WqAbaJ4LR0bGXeJH/R+ZC6GEF7IHrpSMPHR/xKaYkBD9fqZdURJCKTcYo3AwsO+tmuOn8DiLItnSpA8RB07wOZbAng==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(2906002)(7696005)(82310400005)(6666004)(81166007)(82740400003)(86362001)(356005)(2616005)(83380400001)(336012)(47076005)(26005)(426003)(16526019)(186003)(1076003)(36860700001)(41300700001)(110136005)(54906003)(478600001)(40480700001)(44832011)(4326008)(70586007)(316002)(36756003)(70206006)(5660300002)(7416002)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:58:29.3336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5274ce-7e93-4bf9-a088-08db73636e69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

Same as for ports and dports, also store the endpoint's Component
Register mappings, use struct cxl_dev_state for that.

The Component Register base address @component_reg_phys is no longer
used after the rework of the Component Register setup which now uses
struct member @comp_map instead. Remove the base address.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/cxlmem.h         |  5 ++---
 drivers/cxl/mem.c            |  4 ++--
 drivers/cxl/pci.c            | 10 ++++------
 tools/testing/cxl/test/mem.c |  1 -
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 76743016b64c..8aee1a42d9af 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -263,6 +263,7 @@ struct cxl_poison_state {
  *
  * @dev: The device associated with this CXL state
  * @cxlmd: The device representing the CXL.mem capabilities of @dev
+ * @comp_map: component register capability mappings
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
@@ -286,7 +287,6 @@ struct cxl_poison_state {
  * @active_persistent_bytes: sum of hard + soft persistent
  * @next_volatile_bytes: volatile capacity change pending device reset
  * @next_persistent_bytes: persistent capacity change pending device reset
- * @component_reg_phys: register base of component registers
  * @info: Cached DVSEC information about the device.
  * @serial: PCIe Device Serial Number
  * @event: event log driver state
@@ -299,7 +299,7 @@ struct cxl_poison_state {
 struct cxl_dev_state {
 	struct device *dev;
 	struct cxl_memdev *cxlmd;
-
+	struct cxl_register_map comp_map;
 	struct cxl_regs regs;
 	int cxl_dvsec;
 
@@ -325,7 +325,6 @@ struct cxl_dev_state {
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
 
-	resource_size_t component_reg_phys;
 	u64 serial;
 
 	struct cxl_event_state event;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 205e2e280aed..92c6151b7206 100644
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
index 99a75c54ee39..ad4cfcd95e17 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -665,16 +665,14 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * If the component registers can't be found, the cxl_pci driver may
 	 * still be useful for management functions so don't return an error.
 	 */
-	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->comp_map);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
-	else if (!map.component_map.ras.valid)
+	else if (!cxlds->comp_map.component_map.ras.valid)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
-	cxlds->component_reg_phys = map.resource;
-
-	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
+	rc = cxl_map_component_regs(&cxlds->comp_map, &cxlds->regs.component,
 				    BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 34b48027b3de..fd562a5fa06f 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1241,7 +1241,6 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	cxlds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
 	if (is_rcd(pdev)) {
 		cxlds->rcd = true;
-		cxlds->component_reg_phys = CXL_RESOURCE_NONE;
 	}
 
 	rc = cxl_enumerate_cmds(cxlds);
-- 
2.34.1

