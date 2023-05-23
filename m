Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BCD70E973
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbjEWXXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbjEWXXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:23:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7D413E;
        Tue, 23 May 2023 16:23:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6MP2pH90xpbOM324RdqNioCNGt0L7XiriUvB0U2UYqHfaqfonwC9RusoFp2GpDPKn73b7beiv7CGRC4igJ6WdEQKH1bhCIDb78tABIq3VHkVUjiM8fde4cn+GhAV3jzvWJRwf8by6U14boHZD0UT9CuiufdAULELIFZFgSDSvrHez8tzrPnLfB5gJlnY1YGca0lfy7SuCkiCEca9h0kPvAAQWZsXUrrA6x5q3sdl6+O3S7UXkbcyXTQSd89Zy1LhrRCcLJE01KqQJXs7jhG7UVGdkwp4/LGa/NfvcbFmsXFWqR23M6rfqpgDI464OdiCuLxD3XE90d7NuDwmNPsog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egDokfXXDszvweDL9NrXTgSRRESJBnnhw+oPJSrt11I=;
 b=dfeQRWwvch6PSrCOHVLpwYAB0Kiro5fvr8ZLAmW+jma8sVRPlywYt5WA4t2ijm+vs8iQBZluuCt6VlSwMm0OJ61FbYafk+MEWN01+MyUrW96bGVbJD7UjIB/MS9NuvgSQ4GzRPhWaeDlcazBKv0/qp3f1iluZMWkPNjNCWSQCBhJ2tf9oO6l37UqMjQKL0uQrrRwU2nWLEbHZEVFJtQ7Irk6RnLQPyoWjCC54D6qyKkAr2JGSmMpr82Mq6cbtYbPEGdShqPA9x5RTOr2Ek0tRyf7kwV4jFHw9Xbqo1TLHqLpmPDM2PitKD+7Ti6zx5e8i/zuvI7tY7KzRdIVTdbRpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egDokfXXDszvweDL9NrXTgSRRESJBnnhw+oPJSrt11I=;
 b=wSmvpgPEAcsMIKg4FpyUsS2rJrpu3nWozXoyMVQdgFElNPUlsFYJFSBlVM983zv3q6cpPxi/xZ80u5dpNLzSGgKG6F2CGdqSc8kWV1q4sQPbgK6rQ6jc42kPxH0TxRRJcSmBOAylArYORpFuHE0U2FfeNSSIWOgHvSPbyzX9kmM=
Received: from MW4PR03CA0167.namprd03.prod.outlook.com (2603:10b6:303:8d::22)
 by MW4PR12MB7190.namprd12.prod.outlook.com (2603:10b6:303:225::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:23:11 +0000
Received: from CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::e2) by MW4PR03CA0167.outlook.office365.com
 (2603:10b6:303:8d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 23:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT074.mail.protection.outlook.com (10.13.174.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:23:11 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:23:10 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 01/23] cxl/acpi: Probe RCRB later during RCH downstream port creation
Date:   Tue, 23 May 2023 18:21:52 -0500
Message-ID: <20230523232214.55282-2-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT074:EE_|MW4PR12MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e8a6e56-2aa3-4cfc-2020-08db5be4ad08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pt5bM0FB74zJFwIGCx16CbS4dmJ0oBLnEfKuXEnvjl+4ZyxVme4Xxtho09nn6f8YZoBY71BMYTIMmwXRHQpvIYpA4v9cryI9DoEB/Wdl5Q7agGfqs/CX5cNihim7U1YE8Ul8plYGZNPIE7UviPFBMVG8tcM6QAmNyvnxKpYImcxLA1MS/NvhNGY6nKdWVqGI5lAkLhRbu9dW9hB4VEGMC9vWlog20emSYTxh8N1N127mCufUcC3kMmjlYnbQnSkEVtmqppoOAghG5+4edFCrgwty+nR4G48HRaTVo+WVy2C1d/1afGG0MUcuOqne+86NYxLXpCzzvJgPzFA8JIjJ6PsxT9dYDTtWoqqAcr/ammxsPK46VaJ1tWifF6HGXCybsw8dTe4/um6BPLlKXl6ubt0S8m9mT0dewD1L5vk+slL4ucaPCrX0/1s7tVQ87v6gAA5nC4tOcutbYhHonTrlFjZxkKrhDN49KdWYnzWNXIRIamqZN0hldXIITUfvftANGy+734F+Yd8vkPihVSJ2dHWF9QZxJ6RbMfMc8gc+2LDwtfeNt5Cjyclkuxh8Znruq7oIx8LTS+5nr3t5KFLE0P0k1my7b/Rb1f2zH57tmOFwh+VSOCq1yBcDztEcwZ4eE6bsoAIf8XXN95EF7tJjoYnf4EFXHRi/n9/2DKRq4Vt/RDRXH4DF6boeGWjvAAiIKWmzAM1P7/wKcE/TrEL+XBt0TBPb2uq4N47zSt3iT738JBJd7hCT8myi1puOmrvX4rtax1NwM8xmj/iCfcm5yA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(2906002)(5660300002)(44832011)(47076005)(426003)(336012)(82310400005)(7416002)(83380400001)(70586007)(70206006)(8676002)(8936002)(40460700003)(4326008)(36756003)(316002)(110136005)(54906003)(41300700001)(478600001)(40480700001)(7696005)(6666004)(86362001)(16526019)(186003)(356005)(81166007)(82740400003)(36860700001)(1076003)(26005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:23:11.5312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8a6e56-2aa3-4cfc-2020-08db5be4ad08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7190
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
---
 drivers/cxl/acpi.c      | 52 ++++++++++++++++-------------------------
 drivers/cxl/core/port.c | 21 +++++++++++++----
 drivers/cxl/cxl.h       |  1 -
 3 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 7e1765b09e04..39227070da9b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -373,20 +373,18 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 }
 
 struct cxl_chbs_context {
-	struct device *dev;
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
@@ -395,23 +393,16 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
 		return 0;
 
 	ctx->cxl_version = chbs->cxl_version;
-	ctx->rcrb = CXL_RESOURCE_NONE;
-	ctx->chbcr = CXL_RESOURCE_NONE;
+	ctx->base = CXL_RESOURCE_NONE;
 
 	if (!chbs->base)
 		return 0;
 
-	if (chbs->cxl_version != ACPI_CEDT_CHBS_VERSION_CXL11) {
-		ctx->chbcr = chbs->base;
+	if (chbs->cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11 &&
+	    chbs->length != CXL_RCRB_SIZE)
 		return 0;
-	}
 
-	if (chbs->length != CXL_RCRB_SIZE)
-		return 0;
-
-	ctx->rcrb = chbs->base;
-	ctx->chbcr = cxl_rcrb_to_component(ctx->dev, chbs->base,
-					   CXL_RCRB_DOWNSTREAM);
+	ctx->base = chbs->base;
 
 	return 0;
 }
@@ -440,36 +431,33 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	dev_dbg(match, "UID found: %lld\n", uid);
 
 	ctx = (struct cxl_chbs_context) {
-		.dev = match,
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

