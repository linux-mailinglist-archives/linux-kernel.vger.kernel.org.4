Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F4873A9B2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjFVU56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjFVU5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:57:48 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A902136;
        Thu, 22 Jun 2023 13:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZO7mhMjs0c69Rpq8MsxMNp8E9uBQUf5oGMEVWJDP7cxnAU+UykmIHla3RW6AXPdIq0v/STZzK5FroqFNnoLizWyoReQ9BBwvZLoRPIq4nSt3TuDk/5wmj8/hjf0ln3dlwGVMUopIX5uiNwebb3OgDnnteIDmY1Cn5H+dr4N8cFNdBS3ipHsD5PL6Gx1RDY6ggO/dVJX3U04E6oNdDr3cPu2bd2GFOfdfBMeJO6nqLcmQ5Az++YgYOwwekIWobY6gvu5X9IB+oWn413nK7Pb6TRSxb+m0j/WW4rNButSL9pCMZ4keInCo4D94XPerLRSLzy7dGGwoUfk+8XuCkzA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7+D52Ajp1fAWi0SwTpRUWw6rM8Pi+Eac7Tv9OCFyLY=;
 b=oRqDsrWPyRIEy/QA4MZ5ZNV8MrLDMl8yEdXmftGZEUk8rNC89G1ChQfJ9YoqNA+vGgJ5TZRjftr7eoJOwAAsIKjT8iwEgabBGiaSqAXCf/pnYafXVcBoBRjnhTt68QRkAbq/Jf70zqa5Yo5zB+TzG4GsqFT7rs8wrU4Y2vtePb4Hsjyw9/xD5uhdEIHqaVQvVVE500hr/ChFIU0xGXqgfZcJrnacXohdsYNQ4i/DwWu3JRbxbi7IGMdK+485TAzrwh0atGsoTRq1wiD3WaVS9A+Tswg6SezPQfEUyQ+hOlLIqfGHgBUWeVktfg1CxBcZ0qq13ivqNLgcoLZ3FRRl4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7+D52Ajp1fAWi0SwTpRUWw6rM8Pi+Eac7Tv9OCFyLY=;
 b=0h5qy5xZkux602ruJUJHT/41q69X2K9SaecjkpdAFEqkBA4J6xEs2pC7vps3jgyCQ1SyguUsAj2chyRI845vS6yXAN+K+WxaNpuVYJ5KYLECiQQBHWYfEPBSb58kVgf0MS4TNCR3LxqyNVEMEfKMB1W/lSe1JMYfEYpj3bj7+S4=
Received: from MW3PR06CA0015.namprd06.prod.outlook.com (2603:10b6:303:2a::20)
 by MN2PR12MB4238.namprd12.prod.outlook.com (2603:10b6:208:199::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 20:57:13 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:303:2a:cafe::74) by MW3PR06CA0015.outlook.office365.com
 (2603:10b6:303:2a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Thu, 22 Jun 2023 20:57:12 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:57:11 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 09/27] cxl/acpi: Directly bind the CEDT detected CHBCR to the Host Bridge's port
Date:   Thu, 22 Jun 2023 15:55:05 -0500
Message-ID: <20230622205523.85375-10-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|MN2PR12MB4238:EE_
X-MS-Office365-Filtering-Correlation-Id: dc040a16-b63c-4722-f4f3-08db736340c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7++wA6BYz9CxqriE8h08OlAY17no4xRPfdILO/OZLvpvHDw5zGpTjavHQvtcQ3axGYlDCdOa/UCQ4XwqzILuY/l5K+L09NrIrqMyAaQh5Vb6kl7geNEtdea62c4kBQULuP5MB++tb8NkxBbFOzI9+07QihTr9sby1JfE4L4ZnYbE8Fk3ztfVoL2Xn0BfcXpIXLi+7yyf4p7tRj6uMiZPFyplBVVxZPU6jwKUWM4+cGrDX4Sf8kcHabKKbePi5gbnYotwsm0U8jyF49vsEgzVvNYs+9AJfKKM0nuBUO+mUCr28doaTr4ECzzgbasWPr5fNlMzVNFSQwusHfje0+fT2w/+L/rA4+ocCBOnOHjUsEBNZeH0B7jCKE24V5duDDaEEGMcOsl5aBOrOzBUpin1OnFS3mLQrrLWB379fQ5ZoHCi3ZXXHPYC7cNfFs2UbbPqA+7hNPJxNvqD/qwj73tMjgPAAPsqnQi+OIypppOMXkrJlC1VH1B0hwpnuurKFJelTF/vgSDME5g9OX4/fClZjaYyWyWohm0RJaCqv6XDlETpNyujugEGNJ2AlgVUkt4xSuzmXORp6ubmj5NA5mSrCOEuztRtJ2Gb/NlAk6zePAjRAbmZKR0UoqSUl7mka7TlOWeIUdTuSWbI+XkWfcN6n6OE6RdBpDffr8Ao25hv52hs+iYUe5L/z3nXM6q2nt4/JsrAE1+6Syjw4CLj++INhaoFO7VnoT9hYlYW1J/v4B05SAJHmchVjYoqMLs50gM9pi6tfwWv0+nexpxkkZX2FQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(186003)(26005)(16526019)(1076003)(40460700003)(478600001)(2906002)(44832011)(40480700001)(81166007)(41300700001)(86362001)(36860700001)(8676002)(356005)(8936002)(7416002)(110136005)(47076005)(2616005)(426003)(336012)(36756003)(82310400005)(54906003)(4326008)(82740400003)(316002)(6666004)(7696005)(70586007)(5660300002)(70206006)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:57:12.7075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc040a16-b63c-4722-f4f3-08db736340c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4238
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

During a Host Bridge's downstream port enumeration the CHBS entries in
the CEDT table are parsed, its Component Register base address
extracted and then stored in struct cxl_dport. The CHBS may contain
either the RCRB (RCH mode) or the Host Bridge's Component Registers
(CHBCR, VH mode). The RCRB further contains the CXL downstream port
register base address, while in VH mode the CXL Downstream Switch
Ports are visible in the PCI hierarchy and the DP's component regs are
disovered using the CXL DVSEC register locator capability. The
Component Registers derived from the CHBS for both modes are different
and thus also must be treated differently. That is, in RCH mode, the
component regs base should be bound to the dport, but in VH mode to
the CXL host bridge's port object.

The current implementation stores the CHBCR in addition in struct
cxl_dport and copies it later from there to struct cxl_port. As a
result, the dport contains the wrong Component Registers base address
and, e.g. the RAS capability of a CXL Root Port cannot be detected.

To fix the CHBCR binding, attach it directly to the Host Bridge's
@cxl_port structure. Do this during port creation of the Host Bridge
in add_host_bridge_uport(). Factor out CHBS parsing code in
add_host_bridge_dport() and use it in both functions.

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/acpi.c | 91 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 63 insertions(+), 28 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 0c975ee684b0..89ee01323d43 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -335,13 +335,13 @@ struct cxl_chbs_context {
 	u32 cxl_version;
 };
 
-static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
-			 const unsigned long end)
+static int cxl_get_chbs_iter(union acpi_subtable_headers *header, void *arg,
+			     const unsigned long end)
 {
 	struct cxl_chbs_context *ctx = arg;
 	struct acpi_cedt_chbs *chbs;
 
-	if (ctx->base)
+	if (ctx->base != CXL_RESOURCE_NONE)
 		return 0;
 
 	chbs = (struct acpi_cedt_chbs *) header;
@@ -350,8 +350,6 @@ static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
 		return 0;
 
 	ctx->cxl_version = chbs->cxl_version;
-	ctx->base = CXL_RESOURCE_NONE;
-
 	if (!chbs->base)
 		return 0;
 
@@ -364,11 +362,35 @@ static int cxl_get_chbs(union acpi_subtable_headers *header, void *arg,
 	return 0;
 }
 
+static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
+			struct cxl_chbs_context *ctx)
+{
+	unsigned long long uid;
+	int rc;
+
+	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
+	if (rc != AE_OK) {
+		dev_err(dev, "unable to retrieve _UID\n");
+		return -ENOENT;
+	}
+
+	dev_dbg(dev, "UID found: %lld\n", uid);
+	*ctx = (struct cxl_chbs_context) {
+		.dev = dev,
+		.uid = uid,
+		.base = CXL_RESOURCE_NONE,
+		.cxl_version = UINT_MAX,
+	};
+
+	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs_iter, ctx);
+
+	return 0;
+}
+
 static int add_host_bridge_dport(struct device *match, void *arg)
 {
 	acpi_status rc;
 	struct device *bridge;
-	unsigned long long uid;
 	struct cxl_dport *dport;
 	struct cxl_chbs_context ctx;
 	struct acpi_pci_root *pci_root;
@@ -379,41 +401,38 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	if (!hb)
 		return 0;
 
-	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
-	if (rc != AE_OK) {
-		dev_err(match, "unable to retrieve _UID\n");
-		return -ENODEV;
-	}
-
-	dev_dbg(match, "UID found: %lld\n", uid);
-
-	ctx = (struct cxl_chbs_context) {
-		.dev = match,
-		.uid = uid,
-	};
-	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CHBS, cxl_get_chbs, &ctx);
+	rc = cxl_get_chbs(match, hb, &ctx);
+	if (rc)
+		return rc;
 
-	if (!ctx.base) {
+	if (ctx.cxl_version == UINT_MAX) {
 		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n",
-			 uid);
+			 ctx.uid);
 		return 0;
 	}
 
 	if (ctx.base == CXL_RESOURCE_NONE) {
 		dev_warn(match, "CHBS invalid for Host Bridge (UID %lld)\n",
-			 uid);
+			 ctx.uid);
 		return 0;
 	}
 
 	pci_root = acpi_pci_find_root(hb->handle);
 	bridge = pci_root->bus->bridge;
 
+	/*
+	 * In RCH mode, bind the component regs base to the dport. In
+	 * VH mode it will be bound to the CXL host bridge's port
+	 * object later in add_host_bridge_uport().
+	 */
 	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
-		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid, &ctx.base);
-		dport = devm_cxl_add_rch_dport(root_port, bridge, uid, ctx.base);
+		dev_dbg(match, "RCRB found for UID %lld: %pa\n", ctx.uid,
+			&ctx.base);
+		dport = devm_cxl_add_rch_dport(root_port, bridge, ctx.uid,
+					       ctx.base);
 	} else {
-		dev_dbg(match, "CHBCR found for UID %lld: %pa\n", uid, &ctx.base);
-		dport = devm_cxl_add_dport(root_port, bridge, uid, ctx.base);
+		dport = devm_cxl_add_dport(root_port, bridge, ctx.uid,
+					   CXL_RESOURCE_NONE);
 	}
 
 	if (IS_ERR(dport))
@@ -435,6 +454,8 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	struct cxl_dport *dport;
 	struct cxl_port *port;
 	struct device *bridge;
+	struct cxl_chbs_context ctx;
+	resource_size_t component_reg_phys;
 	int rc;
 
 	if (!hb)
@@ -453,12 +474,26 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 		return 0;
 	}
 
+	rc = cxl_get_chbs(match, hb, &ctx);
+	if (rc)
+		return rc;
+
+	if (ctx.cxl_version == ACPI_CEDT_CHBS_VERSION_CXL11) {
+		dev_warn(bridge,
+			 "CXL CHBS version mismatch, skip port registration\n");
+		return 0;
+	}
+
+	component_reg_phys = ctx.base;
+	if (component_reg_phys != CXL_RESOURCE_NONE)
+		dev_dbg(match, "CHBCR found for UID %lld: %pa\n",
+			ctx.uid, &component_reg_phys);
+
 	rc = devm_cxl_register_pci_bus(host, bridge, pci_root->bus);
 	if (rc)
 		return rc;
 
-	port = devm_cxl_add_port(host, bridge, dport->component_reg_phys,
-				 dport);
+	port = devm_cxl_add_port(host, bridge, component_reg_phys, dport);
 	if (IS_ERR(port))
 		return PTR_ERR(port);
 
-- 
2.34.1

