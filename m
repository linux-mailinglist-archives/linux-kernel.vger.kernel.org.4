Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03CA72716D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjFGWTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjFGWTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:19:08 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E80D1BE4;
        Wed,  7 Jun 2023 15:18:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHIhVO+cKknInxYJLZRld8opMApdrxjmGYIuV7D/4zkebyi62eyKhnq2gmVMK/GxDvOC+Mg8fl14akcGuJKjGms0ZwWyGTabKqtnupJ8E595sS5wRa3CM9M0AikKv2XyCK9If6Ij8KThc0kFwxOlvVVBsfjLFe97XVK04gCw08KR92yGScnsIOp8YJkBReNvxNue9U41r0OCzwmmEnUCXE0nbkLV3wBZuWzUI1jq1592p7LVFWlD36dDCKeB/zzEU71UoLa+UfeWItBbwRknhN4Ge3I3Ekv6fpXDGNq85gy5jUiibynK0xAqMG2N7jjkL2Jy88dx0mQJgdNDbAZGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEQgRCr2X2BhPVnrkGRmKTB5mvLaMeQho/f4EpFlxYg=;
 b=c6SPZjPel/PUpGl9hJaFk9F5rH/rvLv4Mpv3WGpyl08sbdZycWJgbZ8C/6uuq1kc5OCeuUkRHL04a3+nRPNl0GWmHTUGScXb46qAx/qxcKPwruR8iPDfTCZ/J4vYoMThCj2vj40eD5E0MpLDMcdrJyTJbdnRS3ev2ix/Gxwb7QuMoyvitBM1tQ350WFUasYAlw8td3ju+GvJ/Stcnmm4ogkTjXBQaqUGVU6Bbwy34h6uD2fWx7nkWo5ockj1OnJt5pWmBWeS6utblAM+aO0KglbmriUun3CPZKeSUTmQXRVoa8mHXJVIp99Me02iot0urOLUXDBiTAhY/SLOrUAndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEQgRCr2X2BhPVnrkGRmKTB5mvLaMeQho/f4EpFlxYg=;
 b=H5K1j4JVOUoaWQy2X8fOdzm+EFcx8rIK3Z1JaNKTIGvJQ3HptSsPoEfByFlkI1OU5/T/D7cNh6IMvPbhaKhkVS27IFwu0pa+LIJRcOwzQAl1IsGdLhv7ESwgyANBTGZ1CwNXYQgeilCH8t/IREx5LHgh5Q4k5eaoAoIyjceYKJc=
Received: from SN6PR08CA0009.namprd08.prod.outlook.com (2603:10b6:805:66::22)
 by PH7PR12MB7329.namprd12.prod.outlook.com (2603:10b6:510:20c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 22:18:23 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::a5) by SN6PR08CA0009.outlook.office365.com
 (2603:10b6:805:66::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Wed, 7 Jun 2023 22:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:18:23 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:18:22 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 07/26] cxl/acpi: Moving add_host_bridge_uport() around
Date:   Wed, 7 Jun 2023 17:16:32 -0500
Message-ID: <20230607221651.2454764-8-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|PH7PR12MB7329:EE_
X-MS-Office365-Filtering-Correlation-Id: 1048dd86-9ba6-4f03-3ec7-08db67a51baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5/JgNVOTogDmKQ/eWJtcZpSX42Grf8UzenYQLU25eWPkOL8AbLPBAb+Jw15iLpjOBn4rSJy9AM5CbaOCuWD0VANQ5fKMicV6VoptWpQVlLERc07mW4jYWdyE3vxQvKCkB6Esz5IaImUkjQwjsQfvQjA8JFRwBHGSohrC2QLl8WMjZts20z+BpkYcc6pTWP9deGaXGmw7Bj/WH/ZaLxRCuiw9Dln+L5yube4LuZ1kCQNbQAe0rnv1AT6h4T/6/fLgVfBDlqSC6fV8MqrARiGBLfxodck7vGwFd+/q3T0fJCnt1lmLlSeWpXY2GjCS5IiX+uYEqO3f4S7o1UJBNMydJIWwpXQRuBpDJPbbw888MyqZBPcuPd7WrZ2nASo8k3N2Nh9Q7UnmoAz2mBZxV+ibOBrqovUZObzRwO+KFPJZ+NMvvTy8E//hQeMS65AlHihWIrOcxTqc1c7t8dV8l19BeqFHBHSSTRgRSW2O1Rtu4LMAoG+IQKNyhE8Rr652D1MQX2wonHlehzsQD1ywlKanTHQfagBQE5Pw+QfI5TiOkhh46Lux78Tc982EuM6l01PYvig1Yi8MTWYw71tCDA6buDekJH6ZVrsYadBX4glwD9KNC4AxunGh9jOuqS00x2bQurCaQaGvAwhhx5IhLpYscNOfw4rTqDXZ0/HSZDKONelwWKTH16vWHbaxVQBDnEaCaQWMjxdXm9KQMgdhdI1R3cObEy8vzok1D3gI1mdqDJO0gl+2QX2sV7W1S/DS71kEHszYkvDY6eSRLAbmyqpOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(86362001)(40460700003)(7696005)(4326008)(2906002)(54906003)(110136005)(41300700001)(82310400005)(8676002)(5660300002)(82740400003)(356005)(36756003)(316002)(44832011)(81166007)(7416002)(70206006)(70586007)(40480700001)(8936002)(6666004)(478600001)(36860700001)(16526019)(186003)(83380400001)(47076005)(2616005)(426003)(336012)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:18:23.4010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1048dd86-9ba6-4f03-3ec7-08db67a51baf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7329
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
index 39227070da9b..4fd9fe32f830 100644
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
 struct cxl_chbs_context {
 	unsigned long long uid;
 	resource_size_t base;
@@ -464,6 +419,51 @@ static int add_host_bridge_dport(struct device *match, void *arg)
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

