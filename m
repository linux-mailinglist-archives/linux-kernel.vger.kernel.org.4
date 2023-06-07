Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62054727164
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjFGWR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjFGWRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:17:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16767211C;
        Wed,  7 Jun 2023 15:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gC2li7a95TyYqshle70ur6cooW4i91IjPlBkgJeENaFupEIAUGpIbChehpvnhRM1EE7Is28JwopRxcRih61FRW+wjsDbWU/CA6wYVg7flaukLgBl714KISyZDeNCeTsesvL6w1KzPvk7CgXROlQE/IDhpEGiYUNcEbM6yDPRoLo30v2QnE65uNlvb3Q2u6tPTO8j0RRVYQvJOnPhSJoxKL3BL05ykvggDRGRFrmF45rbGz0poFVztnjPCGjKHPsHrMn5QGEqdxS7vA3hady9nZ1NBiHO84cPKUOH18LoLBjNsqHhHzyEQkK2zAoAYAmtRDnUkh9YkHh1A3c2z+nHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHwR5lbFu5qO4T9DennQ27mR3QqiAWGGc0roy2mYChA=;
 b=laflrfBWuI35TDTTG1UodO45a+9PdRCmorIJrb6au+oIB0EaJTqBFWjKpaW8YWoo9/2CYufiYGXRCKsmOKC2SuLCUri7ObuC8FD6Sj5E5INZzoTNVErhSTIAL2XkcuViiYTfuCbmOV5MizNL0o7V7Bq13qjfJ93L7Z6gNpjlSyoe9BPNSGxgkZ6z7vkF+pL/bLTx4rHYJripplhnVhbTk+ueGznXwq0OrYeW0cfiW0Fl4neYiANxUyUDzCYnbQMbD2+AIqdxOe1ukpgJP3CE3I2M8O2WbPE57yyRuskniHv1yUfACb3KgQwQD/e8xKG1Hxj3O1bTs6ZC5j8t3dHbbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHwR5lbFu5qO4T9DennQ27mR3QqiAWGGc0roy2mYChA=;
 b=v2m9abKAH1wsJA+mOdPA6eDzpBqKHmbsFwOhwVe05fpy0L152G63rHGFC6BDVCp6uMHLptU/yrATYZVg4Nddg3n2s1YxWtZDyFhobKsLQBnFM+pFHyM0yJ4yP9efLq9WgAbfXhBHS4LqMnVVzCFct2+nixzWDQR5npMyuJUktoI=
Received: from DS7PR05CA0023.namprd05.prod.outlook.com (2603:10b6:5:3b9::28)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 22:17:18 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::7) by DS7PR05CA0023.outlook.office365.com
 (2603:10b6:5:3b9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:17:17 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:17:16 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 01/26] cxl/acpi: Probe RCRB later during RCH downstream port creation
Date:   Wed, 7 Jun 2023 17:16:26 -0500
Message-ID: <20230607221651.2454764-2-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 59fde28a-fc04-4b75-962c-08db67a4f479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +yvFYHv1q+N7dzTHf5g98zh01NaeKuWVup8BZjyewh1CIme+x7c0nMRqutawF8kp5j5cDeKha4lSV7RsipkDQs4+e5jaenHdkTObactig6311mCEThesvPSsZ134B+6JIZ6pEiQc3EuO30njqrL9S1C22Bg50L+TSGtwi82Fd3tOqePN4jlUcq22vKcIJp2bf+cJCLqrBbKqjAYH8jcEoGB/yy+FTC9h4GtOyxNlZLplcASAEYlhVBF4WLpem+qxR+07xbxtUatR3f94hNsLGwGuNXTS9dG9U5Fu4LSFtyatGimcek96CYTh7G21zKqnmHbn6yHtmY6ilmoWh1ozYK/Ywen29TLuaoPat56QEJ3tKG19MPboRNZ8DwuSOUsGFEpS4q3EdNPKy893z+sJZ9nDYGqP9e2r4Zm1Y8I7KnRNxi1hIc1RO4tVbjnsdavtKNkM2ZmYiQUdcbb+3Z0+PiaMVReM7iY2lk/o43SVD9+XTyVU8xbEVyzGEZRP9yPH0Lt8UpMRBKWodNVKGp11ZBnkUSDWFgT8uBNFuyAETuXr1Vq4gXFP/Pte669lvWOCOja8BloX5xz87LRS2wulXU6qADt+5M6Stz8pxh+W9HcBru2fpPB+z1fpK6BLrH2U2EV7YkKXtkcrt9JPfddConCGV3tSteXqir4QVV6HLJf9h9GsO5rFNr0esHuI4Y6MHnWtZ45lJgxk02oppugd10k5umzW7xNSmRSeVTAhgdhc0fFWvt+JI3Ccej//2ZrQvaSFjDTREo6lA8lAQ9EXqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(54906003)(110136005)(40460700003)(478600001)(40480700001)(44832011)(8936002)(8676002)(7416002)(2906002)(36756003)(5660300002)(86362001)(82310400005)(4326008)(81166007)(70206006)(70586007)(356005)(82740400003)(316002)(2616005)(1076003)(41300700001)(16526019)(47076005)(26005)(36860700001)(186003)(83380400001)(336012)(7696005)(6666004)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:17:17.6338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fde28a-fc04-4b75-962c-08db67a4f479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

