Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0290B73A9B1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjFVU5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjFVU5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:57:35 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30BB2103;
        Thu, 22 Jun 2023 13:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqEWIFnfaGaJBTE/RhkkG2PIsoZVlZFMS0P9m7jK/R/yel0159QdL3DNBMjSHcKdtbKoBvuELOt+uDBzeurfqs1TPzR7Y4r+VHqLRA7xxRRvt3FYTfjcvNJgPBFsSKgcOqS1OMlwLoGFsfHwDsHJRtAdR8e0DlClUIOecVpS82Ix0dKtl3BC1FpkAHkrgB1otmyIqhkztKiUyxiqIXns/F8kzjAHc4dMjaROd6Yp/iJWDSilMhTGNMi4C6e+nQtRlworypBEw8E8cc7YwIvqG27n4hTbhv4ISTikSpjDmfAE0uc2EFIiSydC8ARQUbfaF+HvorEnG/VtzRXDvuXv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCaX2UCbPwk3XHqmoekVr5xpfO8s5REsnJHptyPWvss=;
 b=JKscYP26O1ZHE7pWA2E8PnQZYCGKMdmgn91NW4aPcpAPgO9PpFzlbQaum9mCBO7f95fqdie6xx+FunKDzD7sAX+Tp2hb7XvyF1JxQNtVl2TjvHF4bC/KDJw4mmuiaFtJ/vk4Jtk7Swj4QpIigEXDirhxGB3K0gzR1APXVIUQ6CMcOeqdphP+3ipY6I+haVMGtxkt2IyP0Ri7zKwjyMruPBj1lLMTj4keJhvAbOifC+xniyA6FtQU3QpALYHYmqwyjdBEyrfOpNEtmKgMP7+upTForzXBH0gAh8WBorha2EJG973Zizj80q+XxJUy3u/flTAdtIWifzToArpd6XyglA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCaX2UCbPwk3XHqmoekVr5xpfO8s5REsnJHptyPWvss=;
 b=B2yUBonK02ENDQnJgGP4g1S1dWKYXqo+YE6JrleftaYFpeBVlOZ1qU6a5RnYDqao+8rF+VZR0PWaXoulTavzQxD4FPtCM1rokAcL3XA4UjcMVUNsrN/k9F4FM1opKlw0g/8f6LCp9uJbEBX965+ZAHd47F/aXBntDU8ousV0mqU=
Received: from SJ0PR03CA0350.namprd03.prod.outlook.com (2603:10b6:a03:39c::25)
 by CH3PR12MB8356.namprd12.prod.outlook.com (2603:10b6:610:130::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 20:57:03 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:39c:cafe::a2) by SJ0PR03CA0350.outlook.office365.com
 (2603:10b6:a03:39c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Thu, 22 Jun 2023 20:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:57:03 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:57:00 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 08/27] cxl/acpi: Move add_host_bridge_uport() after cxl_get_chbs()
Date:   Thu, 22 Jun 2023 15:55:04 -0500
Message-ID: <20230622205523.85375-9-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|CH3PR12MB8356:EE_
X-MS-Office365-Filtering-Correlation-Id: f19a32e4-0956-460e-7b22-08db73633b19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WturjFtolGDV86q7UpwzjNHNFI+zHiCx7E+dA+zdHpHFpTaDer0TQLO9djcIacgXhDhpLAMg0s7yIhS+NTUxlXW0mEgXH3/HFh7TmyqqJV+XeNTZr3fGNGuVszGx08Ye/Xwaq/5PrKfz18FqWMxksXXGhgkVs/y05oBCmn0GJOlpQyV+xLRRh1QNFNXCJjISOkyaV6Gca+Eutoj7SM7L0Lp1jdm9AHQTqI9BIJRV5yYOlifHnz9xtmNQhuBL+jq98XQJh3hKjLCFkwhME8PjWO1xpILjB0HkW/KflW5KiqR5kA92KPGdeIQEN4NbFnqGZremOddxzemdBVaK1JBCxZUqXdeADEcAr4wCTys30dVc92O6CwOPN3HY/7UoqOEw7H3o+RqqQCQzIpGtvWSWQpMK4IoeqLkpnJXuww/lyW7WaaTBJYMGC2sXEljNJMGLEDNPvPnq2DyKOzVbmBw2iI5YGOkMNbOwYaXlOQL5L73ENsP2XpvI33qU7L4dPjCwHI5rLkzRErxH31/dhnus4jKEpzGwyojBAFLAlKx5kbReVhB0vdKSlEHPxSqlf5MkX3jl451ZtPxaOAsqjtee2xXfDCTUa0vErayioF8DHD8nWiio+BciV/d13H4fS0u4MX8mH4FN8PiAcMj9iapEZTREi/lU6UsyPL1HkS8vGWyrNDMgby06/0D/9tocvoSPO9zcVpUGWXGrhRoSP64vVoOdE+et82dYRy/s4MTXOPVrEPk9eCGuNYi4x5kKBGR6NJTbGUkkOUZESA3WtgD+Tg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(36840700001)(46966006)(40470700004)(336012)(81166007)(26005)(83380400001)(36860700001)(82740400003)(186003)(16526019)(2616005)(40480700001)(47076005)(7416002)(44832011)(1076003)(356005)(5660300002)(8676002)(41300700001)(8936002)(2906002)(4326008)(7696005)(36756003)(478600001)(70206006)(70586007)(54906003)(40460700003)(110136005)(426003)(86362001)(316002)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:57:03.1976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f19a32e4-0956-460e-7b22-08db73633b19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8356
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

Just moving code to reorder functions to later share cxl_get_chbs()
with add_host_bridge_uport().

This makes changes in the next patch visible. No other changes at all.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/acpi.c | 90 +++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 70cd9ac73a8b..0c975ee684b0 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -327,51 +327,6 @@ __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
 	return NULL;
 }
 
-/*
- * A host bridge is a dport to a CFMWS decode and it is a uport to the
- * dport (PCIe Root Ports) in the host bridge.
- */
-static int add_host_bridge_uport(struct device *match, void *arg)
-{
-	struct cxl_port *root_port = arg;
-	struct device *host = root_port->dev.parent;
-	struct acpi_device *hb = to_cxl_host_bridge(host, match);
-	struct acpi_pci_root *pci_root;
-	struct cxl_dport *dport;
-	struct cxl_port *port;
-	struct device *bridge;
-	int rc;
-
-	if (!hb)
-		return 0;
-
-	pci_root = acpi_pci_find_root(hb->handle);
-	bridge = pci_root->bus->bridge;
-	dport = cxl_find_dport_by_dev(root_port, bridge);
-	if (!dport) {
-		dev_dbg(host, "host bridge expected and not found\n");
-		return 0;
-	}
-
-	if (dport->rch) {
-		dev_info(bridge, "host supports CXL (restricted)\n");
-		return 0;
-	}
-
-	rc = devm_cxl_register_pci_bus(host, bridge, pci_root->bus);
-	if (rc)
-		return rc;
-
-	port = devm_cxl_add_port(host, bridge, dport->component_reg_phys,
-				 dport);
-	if (IS_ERR(port))
-		return PTR_ERR(port);
-
-	dev_info(bridge, "host supports CXL\n");
-
-	return 0;
-}
-
 /* Note, @dev is used by mock_acpi_table_parse_cedt() */
 struct cxl_chbs_context {
 	struct device *dev;
@@ -467,6 +422,51 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	return 0;
 }
 
+/*
+ * A host bridge is a dport to a CFMWS decode and it is a uport to the
+ * dport (PCIe Root Ports) in the host bridge.
+ */
+static int add_host_bridge_uport(struct device *match, void *arg)
+{
+	struct cxl_port *root_port = arg;
+	struct device *host = root_port->dev.parent;
+	struct acpi_device *hb = to_cxl_host_bridge(host, match);
+	struct acpi_pci_root *pci_root;
+	struct cxl_dport *dport;
+	struct cxl_port *port;
+	struct device *bridge;
+	int rc;
+
+	if (!hb)
+		return 0;
+
+	pci_root = acpi_pci_find_root(hb->handle);
+	bridge = pci_root->bus->bridge;
+	dport = cxl_find_dport_by_dev(root_port, bridge);
+	if (!dport) {
+		dev_dbg(host, "host bridge expected and not found\n");
+		return 0;
+	}
+
+	if (dport->rch) {
+		dev_info(bridge, "host supports CXL (restricted)\n");
+		return 0;
+	}
+
+	rc = devm_cxl_register_pci_bus(host, bridge, pci_root->bus);
+	if (rc)
+		return rc;
+
+	port = devm_cxl_add_port(host, bridge, dport->component_reg_phys,
+				 dport);
+	if (IS_ERR(port))
+		return PTR_ERR(port);
+
+	dev_info(bridge, "host supports CXL\n");
+
+	return 0;
+}
+
 static int add_root_nvdimm_bridge(struct device *match, void *data)
 {
 	struct cxl_decoder *cxld;
-- 
2.34.1

