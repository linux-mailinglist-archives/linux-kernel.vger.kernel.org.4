Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799EE73A9A8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjFVUzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjFVUzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:55:46 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A69199D;
        Thu, 22 Jun 2023 13:55:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Onem230EGbeclNsqA/H0SQ6NYm71ehpm65auREUbLpjuEBnWU44Dm3e+1vOVHB27UgHVe88+hS36a4rg4SPH4kWhuODsp4qLimPu+Lwv13XVBJ0TDqMPsRRdqMDa3uiBc9DqXR7ZIRHMyEKTVWfBHq2JvvUh3jzSL9InvuAB8pZXeERUK+EpiwEtXS7l5spWk4F6IL+fXJq2ztpfuwxKISKTn2EDzLRWZpXpL/vAz0XYyeZIdW4AjMasuJGx7QAuT44sCPR07t3wxUbQ016f9luzGHfUnRqLxSN0X0yNCjccHl8j7UxquPeBwIswirLAfjqVjS3Y7qc+7TWVF5ez0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UebWhYTjSDMulwjytUBVUXAl38XaXPQ0axkBX8wU1P0=;
 b=KdFNMG0Mq0pf8Z7YYLwK53+PYfK3BvnjMPDpijxCBSK/MIQkGVEr383Yslr8vrWIHVidF9on8ZHyPAV7V+N4/lTZstC37ezCOcNyt9xz8AdFQWgrS7roNq7DBN+Lz60Bwq/u33NqlrVla8SBQ+fyU2CIf5CNY3ubREoMhfaTqxvBZifiotvhi+NQP7/ObDPcz3E7h1H8rzghgDM+LK/iO1dRuxdGvM1zbIYProTTgu5C6o1nwh4YYysQeVuMy0nEkXXBWk94uDCjoqVwrYIwkdlLFzlgNS/kDm+p4eQWXpvXl/WDAIFpUADYaHW/5h5CEPvT+53gbAR/dKWu+t8Hkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UebWhYTjSDMulwjytUBVUXAl38XaXPQ0axkBX8wU1P0=;
 b=aFAqWfkMmbne4+ULOhme4dT3Lnkr/A95V4ASsfjdxlE1rZiDll+lFf3z1+cD+vSDP9uWxO26XdWm9Gc4vXVd9y0k45BmWveSZpAzr1QcY7mArUg3bwJXBQjFP1AC7FE3h4MrFDQF+nWq5sqiVqEW8DChoMz9r2T6SlORrPwkm6M=
Received: from SJ0PR03CA0338.namprd03.prod.outlook.com (2603:10b6:a03:39c::13)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 20:55:42 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::55) by SJ0PR03CA0338.outlook.office365.com
 (2603:10b6:a03:39c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.25 via Frontend
 Transport; Thu, 22 Jun 2023 20:55:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:55:41 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:55:40 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 01/27] cxl/acpi: Probe RCRB later during RCH downstream port creation
Date:   Thu, 22 Jun 2023 15:54:57 -0500
Message-ID: <20230622205523.85375-2-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|IA1PR12MB6113:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f53a367-08bd-472b-545d-08db73630a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Flf4kK3bm0FXS6yZxmK2k9J3rUOkXctp+RAVkyvrRtSOV8TY34S2HIlVENrMBzh2xQlZFWsyormnG3M4tkD3zJQ9ZvWz+Np8PQgRwixIjW//D6DRAKMZIlCS1IegM72u8WOLMtAJQ25oDJE1NsZ3fLV94g+Yn8TFLEWXlCihi9ZNhmXxuyOGQnT2GZFelwS7BlCU+6MGTZft1XhkbPxUH3spTdRqr93AdliD3K82Ahd91SuBABwTsV4wUq4MlCdcyNUFCRC6R2xgnP4eRSumsEG7lnKeMskw9bp+G/2ePfG13Zchh83/ncoxVvPiIjhaS5xdUyWkS9NOi1cFQLrkK9Eb3dz/Ya0IQXTdBBigMWaYLnm4HOzJKryEC1RxSBV02KKBAetNRxPSViDGfKTqKEypdph43Tp4yNetwSJZAnLrBFnAzvlrg00PWTCUeVIt7nq0o1CTqVZIBi93QpQvjU5e2t3i3V1YumwNp2ernZDeKPt8MjcC4XDcvuAeqFhL8fqFlhwFwReJcRL6iQiFe6JgywvWRDsnsgrhvv7HsgTJnsMQ++IhHYa+ks5VB4UQFRXIbCdxsfbjkXxmylo+oZLsnovMxPi1/aaVqxm80vrR926Dh1h2A4xB9bnhQtD054HYq9XB/9auddRj/ocmoaw73iTT0l11wSxW0oCWXycBR9KL/9n8xSJaCodxdzP/YyOxFy6YhKSBXZoAYLb7bOSXQ8ki4XVwXh6cHcQ+9xh+E7vsXDDby7ITgCA48ijHgFwpyyUI0gdmyT17XeOsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(2616005)(86362001)(110136005)(478600001)(40480700001)(7696005)(6666004)(186003)(16526019)(4326008)(41300700001)(316002)(47076005)(82310400005)(336012)(426003)(83380400001)(1076003)(26005)(70586007)(70206006)(8936002)(8676002)(5660300002)(36756003)(44832011)(7416002)(40460700003)(36860700001)(2906002)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:55:41.4314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f53a367-08bd-472b-545d-08db73630a5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113
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

