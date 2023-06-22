Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006BF7395F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjFVDxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjFVDxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:53:06 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAA21BF2;
        Wed, 21 Jun 2023 20:52:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clXABx3YVqE1pSMktRQIslS1nTRVYGIKSTD7gLUNZ572hO5pYQsP9J1+CZ+zXOAIXMD2z15353NmHElLj+SzzDFhea3eBBeSEz3AeyzE4Qwlh1ogup+NnOxo80vl8H2RVtHeRa523MKgnd92jTjgx4JhSS1YizkkwTlBH+Lz1Ky4PxeAw9ZVItqHbZ5ndD4TGBQG2PwGHEnVNR99TDqLGNxlYjNRcHalPDArP83vhuWVKAiqHlj11DszTO4RXlZZR9VtBj1PjRPYvcpyzJolBf6+dqwJDDwyOSCTaibKN33jKK6ErSUNAYDe/hfMntnXPLnLCTcamWDI19ENcn+zQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UebWhYTjSDMulwjytUBVUXAl38XaXPQ0axkBX8wU1P0=;
 b=dJy+2dVDw8iD1F8b2V7ZCyq2WJO8pn1+kzPRGgToO7yUstACStZ7tnAP8UmGulwWnm8vEZmnbhdHM1vtYnaqvbCYpJlYYGSvZIXr5aud0vv3Bi/04GGZKehyAl4ADRv8jlGUP3EGGbe8n8wkwX3d2gLJlwdid1Mh2vsBiil6wF+txVUOGf+TBeCBbV7Z3gIoIvg+2AHeRIDgyZWPlwe9hwtklw1iTxbu+U03yGo7z64oywIlCm+RE/HIJXbSuMT2LjjH495boAPmt8c0Sc5R9k176K7fldQnZxObQM8WIuo8PxxA/Iod5Sl4Hq4zrC7Ayv1sy2DJaA6AYVJKnisdfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UebWhYTjSDMulwjytUBVUXAl38XaXPQ0axkBX8wU1P0=;
 b=VnzZr0BP/PdErVGA/+T1119ENorAEqbthPGHf4LuuBnp5FoZWuy1qIkUExJnYfajEcgJ718MJXRXgq9hnuhLHZ/BarodGiUAi5jw4QanfUOU1q26crvsQa5BR6igx+lHGZT8TbAgORuvFssJ6aqX/SSNWcZATLJUsBpib9RpoFw=
Received: from DM6PR07CA0125.namprd07.prod.outlook.com (2603:10b6:5:330::7) by
 CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.39; Thu, 22 Jun
 2023 03:52:43 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::ab) by DM6PR07CA0125.outlook.office365.com
 (2603:10b6:5:330::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Thu, 22 Jun 2023 03:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 03:52:43 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:52:41 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 02/27] cxl/acpi: Probe RCRB later during RCH downstream port creation
Date:   Wed, 21 Jun 2023 22:51:01 -0500
Message-ID: <20230622035126.4130151-3-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f52e01-a774-4a2e-aa11-08db72d42221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8fTQJMez7pnWZktGMFl4mBxBp35JeKPOv7Mp/RhZvgWSDII5oNT2IpqD8D5l1idQrgz9UX5WcoPcJPkA6rFX7PYinS7qESmnRBhGtpr3k4m3SobXXbE3LV8maj9QY3ua/qEeK9nySDHg9rYV3JWIg8lGu7B+BY5M7YOY+tqtXk0fWi7D6vOTBWvJn4oB7Fj1G3Ll7N/OKcY/3BdGHktVjVKlIhjYwoT2TdWRPZDKyHdZbEOzeiO/d5C5mACSOI8vliCjwCLHOo4NrBQwDDoqSGG0sKSUs/0v9XKIE7Md92srov4TCLB7FUtnF5ijCU9Mv+nOJCeV9C1JpwNjaDgxWfPqp6ur6PkFTC7zLkgP/CVoocGrf0VJ0oRf7AUrJnC7/15IxBm77/KFa/gxw+flWWVkFJybKrw8uoUtn7tyZyU7mxvLiEleIGoBQDlQ+yBhESxFDpEHRWvSEXNfd5UtqnmnjXeZW6RNmeThgsLQODiv0DKPWLMWCkvu3vaubcUK91GN2ORUxhrgSOCIrZlaTRvIZ0TOws+Hn/YCvHB7x6CG6slhEwfKUrZJw6ihrWZAqG3uxQylU6U8GD8vyXz/FkWyngtzKmdNmVLPq9kRtPtPnBaRY0eCUFg4eJUAM3hoyz11zvGlwi8zmK23x8VlpvMYGY/SbyLzYMdT5wOutqXC/aoLQQtRqqw1ud9ba+qPw1zt9afA5fGl4j4e8ez/XaRgzoxKn9zlTxVP1UUzakc4pGCYSFAQ0FX5m9/b4XyFKg9wXmmLO4cAalpdSkU1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(82740400003)(8936002)(8676002)(7416002)(86362001)(44832011)(82310400005)(5660300002)(41300700001)(2906002)(81166007)(356005)(110136005)(54906003)(478600001)(40480700001)(83380400001)(6666004)(7696005)(36860700001)(4326008)(316002)(70206006)(40460700003)(36756003)(2616005)(16526019)(26005)(47076005)(426003)(336012)(70586007)(1076003)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:52:43.2759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f52e01-a774-4a2e-aa11-08db72d42221
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739
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

The RCRB is extracted already during ACPI CEDT table parsing while the
data of this is needed not earlier than dport creation. This
implementation comes with drawbacks: During ACPI table scan there is
already MMIO access including mapping and unmapping, but only ACPI
data should be collected here. The collected data must be transferred
through a couple of interfaces until it is finally consumed when
creating the dport. This causes complex data structures and function
interfaces. Additionally, RCRB parsing will be extended to also
extract AER data, it would be much easier do this at a later point
during port and dport creation when the data structures are available
to hold that data.

To simplify all that, probe the RCRB at a later point during RCH
downstream port creation. Change ACPI table parser to only extract the
base address of either the component registers or the RCRB. Parse and
extract the RCRB in devm_cxl_add_rch_dport().

This is in preparation to centralize all RCRB scanning.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/acpi.c      | 51 +++++++++++++++++------------------------
 drivers/cxl/core/port.c | 21 +++++++++++++----
 drivers/cxl/cxl.h       |  1 -
 3 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 7e1765b09e04..70cd9ac73a8b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -372,21 +372,21 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	return 0;
 }
 
+/* Note, @dev is used by mock_acpi_table_parse_cedt() */
 struct cxl_chbs_context {
 	struct device *dev;
 	unsigned long long uid;
-	resource_size_t rcrb;
-	resource_size_t chbcr;
+	resource_size_t base;
 	u32 cxl_version;
 };
 
-static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
+static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
 			 const unsigned long end)
 {
 	struct cxl_chbs_context *ctx = arg;
 	struct acpi_cedt_chbs *chbs;
 
-	if (ctx->chbcr)
+	if (ctx->base)
 		return 0;
 
 	chbs = (struct acpi_cedt_chbs *) header;
@@ -395,23 +395,16 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
 		return 0;
 
 	ctx->cxl_version = chbs->cxl_version;
-	ctx->rcrb = CXL_RESOURCE_NONE;
-	ctx->chbcr = CXL_RESOURCE_NONE;
+	ctx->base = CXL_RESOURCE_NONE;
 
 	if (!chbs->base)
 		return 0;
 
-	if (chbs->cxl_version != ACPI_CEDT_CHBS_VERSION_CXL11) {
-		ctx->chbcr = chbs->base;
-		return 0;
-	}
-
-	if (chbs->length != CXL_RCRB_SIZE)
+	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
+	    chbs->length != CXL_RCRB_SIZE)
 		return 0;
 
-	ctx->rcrb = chbs->base;
-	ctx->chbcr = cxl_rcrb_to_component(ctx->dev, chbs->base,
-					   CXL_RCRB_DOWNSTREAM);
+	ctx->base = chbs->base;
 
 	return 0;
 }
@@ -443,33 +436,31 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 		.dev = match,
 		.uid = uid,
 	};
-	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbcr, &ctx);
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs, &ctx);
 
-	if (!ctx.chbcr) {
+	if (!ctx.base) {
 		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n",
 			 uid);
 		return 0;
 	}
 
-	if (ctx.rcrb != CXL_RESOURCE_NONE)
-		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid, &ctx.rcrb);
-
-	if (ctx.chbcr == CXL_RESOURCE_NONE) {
-		dev_warn(match, "CHBCR invalid for Host Bridge (UID %lld)\n",
+	if (ctx.base == CXL_RESOURCE_NONE) {
+		dev_warn(match, "CHBS invalid for Host Bridge (UID %lld)\n",
 			 uid);
 		return 0;
 	}
 
-	dev_dbg(match, "CHBCR found: %pa\n", &ctx.chbcr);
-
 	pci_root = acpi_pci_find_root(hb->handle);
 	bridge = pci_root->bus->bridge;
-	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11)
-		dport = devm_cxl_add_rch_dport(root_port, bridge, uid,
-					       ctx.chbcr, ctx.rcrb);
-	else
-		dport = devm_cxl_add_dport(root_port, bridge, uid,
-					   ctx.chbcr);
+
+	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
+		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid, &ctx.base);
+		dport = devm_cxl_add_rch_dport(root_port, bridge, uid, ctx.base);
+	} else {
+		dev_dbg(match, "CHBCR found for UID %lld: %pa\n", uid, &ctx.base);
+		dport = devm_cxl_add_dport(root_port, bridge, uid, ctx.base);
+	}
+
 	if (IS_ERR(dport))
 		return PTR_ERR(dport);
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index e7c284c890bc..1a3f8729a616 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -938,12 +938,25 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (!dport)
 		return ERR_PTR(-ENOMEM);
 
+	if (rcrb != CXL_RESOURCE_NONE) {
+		component_reg_phys = cxl_rcrb_to_component(dport_dev,
+						rcrb, CXL_RCRB_DOWNSTREAM);
+		if (component_reg_phys == CXL_RESOURCE_NONE) {
+			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
+			return ERR_PTR(-ENXIO);
+		}
+
+		dport->rch = true;
+	}
+
+	if (component_reg_phys != CXL_RESOURCE_NONE)
+		dev_dbg(dport_dev, "Component Registers found for dport: %pa\n",
+			&component_reg_phys);
+
 	dport->dport = dport_dev;
 	dport->port_id = port_id;
 	dport->component_reg_phys = component_reg_phys;
 	dport->port = port;
-	if (rcrb != CXL_RESOURCE_NONE)
-		dport->rch = true;
 	dport->rcrb = rcrb;
 
 	cond_cxl_root_lock(port);
@@ -1004,14 +1017,12 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, CXL);
  * @port: the cxl_port that references this dport
  * @dport_dev: firmware or PCI device representing the dport
  * @port_id: identifier for this dport in a decoder's target list
- * @component_reg_phys: optional location of CXL component registers
  * @rcrb: mandatory location of a Root Complex Register Block
  *
  * See CXL 3.0 9.11.8 CXL Devices Attached to an RCH
  */
 struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 struct device *dport_dev, int port_id,
-					 resource_size_t component_reg_phys,
 					 resource_size_t rcrb)
 {
 	struct cxl_dport *dport;
@@ -1022,7 +1033,7 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 	}
 
 	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
-				     component_reg_phys, rcrb);
+				     CXL_RESOURCE_NONE, rcrb);
 	if (IS_ERR(dport)) {
 		dev_dbg(dport_dev, "failed to add RCH dport to %s: %ld\n",
 			dev_name(&port->dev), PTR_ERR(dport));
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f93a28538962..a5cd661face2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -671,7 +671,6 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 				     resource_size_t component_reg_phys);
 struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
 					 struct device *dport_dev, int port_id,
-					 resource_size_t component_reg_phys,
 					 resource_size_t rcrb);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
-- 
2.34.1

