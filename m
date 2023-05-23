Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E6970E990
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbjEWX2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238822AbjEWX2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:28:15 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6120FE7C;
        Tue, 23 May 2023 16:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuL4gIElr2RUrrUd7p3ChrVedrFsbyr8hN82Zd64z7b07shpwUAParMOSIwsH9iigOaccCTQeoT9FlEtuUnVVtfnTFc8SzamlugRVeSwQWMdYBzfBvWBUHZgWDc+1z9MLCFgGa4uN9x4z/nam9S1UTUHMSH8ja+XF8/Qzo9evRC+GO8/gStNMSbob+/FbjozY+k3Uc/bTEROa9XFDguB9nzDG4rvW4AaBPcNeoZto1F/0dlaBKI35AedYFYePZuDawOgCZ0DXRT9XqCX5CqzEFPI/qHSz7w+/CojLtaPAljRRcdsh1D6z5317iHWh/9urS9QVOAuu4ieCmG/95SeDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apyQxvK48qB48cPBYxODFdsmX5VUAYHhqfdrve25qSU=;
 b=CelP5i3SR1/QHN9tQXPtqir+BYJaJSPukdoj3PXDCYQrJfUU69/sFaB4vvbEIk0YTAP5liRuALWCGo3iaPxjEo0HhOhSB1TEnmALBmJAI41kZgbw0smZZ1IiO/TpnK2qegyeeGHjz6fMcojh0e+KsxjdpiUPDK9Vkmzo/BECn2X+BTs4R/tHalbH+UPWW+KpghFHjZQDbFt3T+d16kS49CBqXIqdrDu3xWx28iVIbuRGxkAFPR51rehnwc03dY1DvcQUdCTdP+5yNfmsG8GoaYKh8Dkz3whYRSdVBj0CfuXEQ3AvbWiTyJUnlwAcPBY/pGltm1v8bjuS0wvtlJP6kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apyQxvK48qB48cPBYxODFdsmX5VUAYHhqfdrve25qSU=;
 b=iHiWlcm42+JK1MPCXP9NJ21sc71AaxK/EDvL8ysv2Al7bCx1FNAyyR+QYGUK+zLyZi5f9+tPtaTYv3TOTjshYN2JVeFyH4CCJ/v4nN5GPPE8IkUYd6cPRCc/+c5uJXNOT7FB4Jce81i9JC0eErI1SANyXzYJoqX1EtRau8EZdBw=
Received: from MW4PR03CA0172.namprd03.prod.outlook.com (2603:10b6:303:8d::27)
 by SN7PR12MB8025.namprd12.prod.outlook.com (2603:10b6:806:340::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:25:16 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::90) by MW4PR03CA0172.outlook.office365.com
 (2603:10b6:303:8d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 23:25:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:25:15 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:25:11 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 12/23] cxl/pci: Store the endpoint's Component Register mappings in struct cxl_dev_state
Date:   Tue, 23 May 2023 18:22:03 -0500
Message-ID: <20230523232214.55282-13-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|SN7PR12MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: 5deaa73e-796e-4a53-407e-08db5be4f6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 81Y76GhgrolYU1cAvubNoQ32lNycmQlbL/oAS+FYxFhpOS/V9MQpJa/rfVF9TTnTR3i/l4RAeA92xx4lgF0zQfELE0tJ+y4soHY/F6t9nZoUTFuTzfkQx98tmTK1YJY/vZr0tRvJ14EaHXxkwOuEwx9DzcxwMgHGnfkQtwE8NCS0PK7T9a9GPJP7/qSrUxGVhTjHZ2rJcIuAFw2fGDtmMTjM/0v5P1L29w/a8El+GOtDWDpJajtu3c2QQfFkCWjChSnYTHkhi1rEYlu1ycM6BvQeZmeUw3jYVAGQb/aTsVuOf5q+6FLz0oRoM6nXums/0PfNA7yVfcRoq7bFaGPx6Q65ptKKbygS1dMj0xT4S5rxa+TTGEW8WZkryoqIPyFV9wv/jRwA2GcYv5kcYvT7GW/FFxokYx+RbWeBr1ZbKtfasGfwbobUYiOXn7qitEN7LziPzemkjQPVxqLgZUnzUmAIiZ83/Ilmf7O8EeStHzf0Hr1EWIzVqDXx+iPPXG0ah7Y6HX6OxMpElU8L1GLd+bg8QCyFBLfEmksHta+aBQb+PfnGrpS28EVSPQ6YivQBTY8Zw+d0OYlqp8fscFO0eoEHUWf6Al39ReXdqUj6R0sGazw1+NRg742M9xQg1sN2lFfp9NI3nQnwTPSpBVJHD5cizlRgBbl35AOQtyclMJN0yjSGiQ/YQdXo69hGjpXzmMiVvjtYEhdLhuZKKusXQkZrT0KLAoAD3DEqj4SEB+vl2zirXeva/igClo3iM3+nw5Om0hRKig3xLHGYOk01/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(110136005)(54906003)(41300700001)(7696005)(82310400005)(316002)(4326008)(356005)(6666004)(70206006)(70586007)(81166007)(5660300002)(82740400003)(8676002)(8936002)(86362001)(478600001)(44832011)(7416002)(83380400001)(47076005)(26005)(1076003)(2906002)(40460700003)(16526019)(186003)(36860700001)(36756003)(2616005)(40480700001)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:25:15.4934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5deaa73e-796e-4a53-407e-08db5be4f6eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8025
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

Same as for ports and dports, also store the endpoint's Component
Register mappings, use struct cxl_dev_state for that.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/cxlmem.h | 3 ++-
 drivers/cxl/pci.c    | 9 +++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a2845a7a69d8..2823c5aaf3db 100644
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
@@ -299,7 +300,7 @@ struct cxl_poison_state {
 struct cxl_dev_state {
 	struct device *dev;
 	struct cxl_memdev *cxlmd;
-
+	struct cxl_register_map comp_map;
 	struct cxl_regs regs;
 	int cxl_dvsec;
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 54c486cd65dd..00983770ea7b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -662,15 +662,16 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	 * still be useful for management functions so don't return an error.
 	 */
 	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
-	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				&cxlds->comp_map);
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
-	else if (!map.component_map.ras.valid)
+	else if (!cxlds->comp_map.component_map.ras.valid)
 		dev_dbg(&pdev->dev, "RAS registers not found\n");
 
-	cxlds->component_reg_phys = map.resource;
+	cxlds->component_reg_phys = cxlds->comp_map.resource;
 
-	rc = cxl_map_component_regs(&map, &cxlds->regs.component,
+	rc = cxl_map_component_regs(&cxlds->comp_map, &cxlds->regs.component,
 				    BIT(CXL_CM_CAP_CAP_ID_RAS));
 	if (rc)
 		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
-- 
2.34.1

