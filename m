Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E007395F9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFVDzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjFVDyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:54:40 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC2B1FFB;
        Wed, 21 Jun 2023 20:54:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4zMdpgj2gttXZMTVFfsMiMUAmbn5Ll5/Mj7ZBOCxFvduLIvJcAkSePBSr7J8UtjWlfiJoaDCYqFCyjgboptcMHFsG+HU/zkyU8rZs+v4v/FiFQRAtuYPx4RFh5CNrV2BEAy1BfU9exFFqmzBGwbEiWBQddWxsMzERfEGJ/wUDpIZSmV7IPXZC3DxxGLT3px9kgrBrtij6oxyXTH1RUo3hTevvsVWASqWV0zqN50l5yXcu7wsGcQ/DGOx8W6E5FQJEog4hrs4V60coUbJ/foZeWbTTjndf3bduUiVr/RBE5mHeSzn076orD/wuKZiu+JJEFHx8neR8UYu1ORVRDf3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCaX2UCbPwk3XHqmoekVr5xpfO8s5REsnJHptyPWvss=;
 b=WgpoEjialKmOvSEVhlG2XT4qI2ZjH/XCf73ep9Ag16Ssy7DxrCMXpV6UVDi0PhAUeFJRewMi4fDFUIXddhDYp8b+xGHhGUYjGXks/ujkXaNzcXPvyfocoxS01FQ1okRZQ4UBm90CYl5kv4YfLWgK0LaFwtjN1VgaSv9hAdXlEqUq7/z6Qd8V3dNjX0CiqpZJzPt+eoSAg+LN8VF2V86Cq6KMYSRKRIkQEHUoBYXliCsdXwrGKGnPZs6qhv6OXnMYQcXbpUuK9sOB1wVHjUYM/k7LXHPo5Z0OcnM+tR70v4YMviXUmOINEOhUG1KiFzRk9hz0Uk4sTb/QMr3B00hWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCaX2UCbPwk3XHqmoekVr5xpfO8s5REsnJHptyPWvss=;
 b=bT+vdTfI8c3B2tIRy1um0rXuWSqL5L0aXt/ObTuJaWybTrYsQnhagHBopCfFPla2o6RlHnlsu9yjZGp9YT5NIKsuLuptmb0/a1HGV3t+FkvbLoPGJ6H98+Hb0RlrVH03v05rmtF+KV7lLHo9J6Ix6sGFuKX1YcMHpFxM/ZcxNZI=
Received: from MW2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:907:1::34)
 by SN7PR12MB8026.namprd12.prod.outlook.com (2603:10b6:806:34b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 03:54:00 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::18) by MW2PR16CA0057.outlook.office365.com
 (2603:10b6:907:1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 03:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 03:53:59 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:53:58 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 09/27] cxl/acpi: Move add_host_bridge_uport() after cxl_get_chbs()
Date:   Wed, 21 Jun 2023 22:51:08 -0500
Message-ID: <20230622035126.4130151-10-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SN7PR12MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fe5aa4-593d-4450-c0cd-08db72d44fd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Il1cVbmdss2g73bIUskmt6I9LaEdB3doW0dO1eZRPNUH74zynNOprPsiTeG23OB8Pcv93GKh0EVunmGaym8qM+8DFzkDo8JUTEVoVfI5wlooHKCkdnwNU7jzwl2WSs3nABoH2tg0RjZiYKk1OYCH3XGgHLKtOXanyAeNJkm97WfuH3VA4pfNd9ve61CPr+ZJx0ZkBSRnX6x5GkbdySZ9FSoU5VVfuuMIp6S7cu4DeT7n3iRRKjbiBa2j+hDo88BO/FpvfGeYbHplHSa0NtjJn6GxVYrl2j4xIDLw58h/97FUSSOmeJDCN5JNs+5UKJQHSs+BtnWYrXlbKlV8jxQcKVLkGQucKlEiteCtUB4qARutDd6FtMXavPu7TBcWEGR8p4MHZ4bA+Z37QJ9oYp1jaa0/NM5GYNK/I2YRyuU4R/KFeh9zpZvNM/jUASNHhnZwefQSpHMph2fonvf9foIDU4EnTmpcdSIiPzr1hFDQ7sXfEHudMBUIzcNZ97dDadDhG9HaQIVBf5FLo7w9J6yTsKUGUZUQbfWW5WDZjmaQ6QeH6PGmJvbU5gW8Zf3Ot5RHcHp1LR+DBAXoOLNcLDxuuMPoGdse0j5BVZ7OFLcGUCsoocxtDEnOvS2w4iQcNTNB0NXjNf44x8eKKE3mqHa5wEeJp/Hf+uhNAmz67/d8Jl7R6/cLgha4GI/MhTEkS+2Qwwdb78iwb4SC2QAw6Vy8XotYZo68aSGR5coSCc/eXbjCYVBJSzU0wcUV+8qS4+ast8tfT2xXYnCX9ftnwcAJpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(44832011)(47076005)(5660300002)(7416002)(2906002)(1076003)(41300700001)(8936002)(40480700001)(186003)(8676002)(26005)(40460700003)(2616005)(336012)(426003)(478600001)(82310400005)(356005)(82740400003)(7696005)(81166007)(36860700001)(83380400001)(70586007)(70206006)(36756003)(4326008)(16526019)(86362001)(54906003)(110136005)(6666004)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:53:59.9576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fe5aa4-593d-4450-c0cd-08db72d44fd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8026
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

