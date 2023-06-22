Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76302739601
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjFVD54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjFVD5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:57:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C9E2122;
        Wed, 21 Jun 2023 20:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmBueEQP/fAQN4VgeDSO0nWdG62IyX3Hwz84k+jREzfoBxk23iBo2T2B/zUuyxIEL7nPmUu27T7tBB0OBcjTEmtLSjBt8fitFfAWooLynuQGfpN9nXOMx3FCAPOEMCcIWxPv+grnO7Rl6sq9o1kB5iYft7M60Lph60p5EXB5eINRrVctB09pE7K77JAySblZxuLbdzlHyOaO+N+jlJSmj3kXx6KJiQRbr3a/e8Rryrp61uCAwZbFiLY5pT7UrqlZlVJ+KgVwkwoiBh/SIqHdOON8bPTWZiutW7d9nCyO2l3c66omhv6ZbX372DJoRByzaIKPAO7t8+7CaMkh2/Sw4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8D11d93aD0raN4W9zkc7ZDlIv/12QAi/az/g2ZWtzE=;
 b=SmzDkMq+0s7RfxbucP3wrtVk1GfvUz/IODqyYeMAvFeXeDlTLsxKUdtA/yENwbwD1Qz//6Cob2AyOQa/50fpr+LHq63rlKjJrrwbCJh+uIHmxD/Pa4pmSkKpERjz0n6irC2qobc10u3qaKuGzxYcCF0ePBO2NEPqj/HXqXna4SeqeIu0OFeG1q2OGZ9A4xpqPO3fInEa6pgno09rmWE6VS80z5xJn9X2xhg7NjdbDoTcYzEM0LS+gs4y/6jUrRZHY8QREGF5J440PiAs0cPLuZCPc+aH1tYKGkDFIUTWeGyWdYXi7TLVn+yD70Fy95Aoxct29vloSPuNa3CaMYr7Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8D11d93aD0raN4W9zkc7ZDlIv/12QAi/az/g2ZWtzE=;
 b=DaXCCzQBqN8YzvHfJ0vBYxsEtS5xzFIa+Udxm62VOVkJvKD3MIX9A5Y9+OpMuRRS8RyBdo9Pxr64RG6dDY5gF/+xMXihwQWmldsTuQogqzeUstsUhVV8HR/zLSYG8LD7njjrfwvYEQFnK1bDvmauqk9tHWhRWtmEkz2K7Dr1IYg=
Received: from BN9PR03CA0223.namprd03.prod.outlook.com (2603:10b6:408:f8::18)
 by CY8PR12MB8362.namprd12.prod.outlook.com (2603:10b6:930:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 03:55:50 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::31) by BN9PR03CA0223.outlook.office365.com
 (2603:10b6:408:f8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Thu, 22 Jun 2023 03:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Thu, 22 Jun 2023 03:55:49 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:55:48 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 17/27] cxl/pci: Store the endpoint's Component Register mappings in struct cxl_dev_state
Date:   Wed, 21 Jun 2023 22:51:16 -0500
Message-ID: <20230622035126.4130151-18-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|CY8PR12MB8362:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dbae379-57d4-4b60-40bd-08db72d49129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WTPIc6i2wpS868rlj4PqVpRr3vWrjr48fBzgLpnUM+ZymaabLg9hzDD8bTI0D/MzPHe/CBDs4t+Wmehhp4QpNKq7DYxcWjHwN8G4SMt9J7Wk2ziuRN0pg8k00uf8tSySWAG/bD0tMHlvp2zldR9aDNX2kCkh8b/akRL1UXgbCanEnrojJVImK9op7s7r67+5uMECP5LUeFoPCOhoHqcl25qzRs5DqtWjYiyvIBPg/dqzPImU+K1xSPoeKJ95Pq2io4rPKJDG8/3i3wiItISFBCQOwD0QSo2be0VAz5qbwGw9V8wOmJj7tJJHw5VwCHb/Ix5N4T+OJWlVtNXTxlQyZ5KRbp3waYZs5YgsZj7RM6ZtP7FL5kAVPu+ZNNuDo+YUC5Vy0fMxZ2fWz9xdvb5Z6ZgZEE4dMyQeNnh8OzE3J7J252GbdUZskCNGMQpGOKezpkduXIAkWWP4EBHRHCeXYVSkN9g7hAQRfy3+Ku6F5UG0KeAFYEZ99965QlBln1P2XzSsqr68babdY+HX7QErXTiKeY4RQ52JQ8wvGstPzSv4iNv07VxxbOl1mjtbmCsK9OmcapK4PWl/dvZc9eCb3+zwm/HdP8AOxOVNyIGOfa/TK37pSlmALBGWsbiDxkjFfDLlqAazU8iIVmLdv1VHVI9lvJecK3LHBn9SYij+PMVxwtLpElzLN76tC5IudXi8RuSKNrrxjh86o5tVNuZxqtbS3hNkBls0/P3qsIA7FhmQziQxg0Rg4SNPhUyMp06EH6TFQnaT772r00rmbEUPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(82740400003)(356005)(81166007)(86362001)(36756003)(47076005)(83380400001)(36860700001)(54906003)(110136005)(40460700003)(7696005)(6666004)(426003)(336012)(4326008)(316002)(70586007)(70206006)(2616005)(1076003)(16526019)(8676002)(8936002)(26005)(186003)(41300700001)(2906002)(82310400005)(7416002)(40480700001)(44832011)(478600001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:55:49.6621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbae379-57d4-4b60-40bd-08db72d49129
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8362
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

