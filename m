Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E930F70E97A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbjEWXYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjEWXYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:24:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC5DE5B;
        Tue, 23 May 2023 16:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGn6fKMlG1Q5/FAa0pK6AIDuAu8eDt5Zu63ACkRHJpsQqXVCOT+EWjtmp7YbiAV2KTWM4tAr0Skex0zAd1LLOsXYJ8t6FU5k+dSpJRdYu/ztUSQ1LbHTGdYiQUn8qa5uq9myWDQcO6ieV6wxqwCg3IndKAw7vZLmH50mR71RtV0QSMI3qmm2LOv5LWSW5WiBPdc9ha6SW7POeq6j4K2jUtnLmybtUjPJwHRwvUDyETSdvwgXjVVXFI7ZgTPtdAPCxED3nmjgQTztUjlzIBA+YvYYpIyjMn0oO/mn7+MYkk15kGj5I6COH7JIrl5HEX0KhiYVmGvbThXbVAIOu2ApdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=It65MVk32CP51aKCK1dag4V5Hqyq9UBcxOX4uzKEYrw=;
 b=gk7I/ZFNH24HpP2R2OVLoTFpTnsJPH6ayGyp2Tsu6vgwlIMRbuy4CdzB8RsMXdBm45l2gbD06IUPHu6aUwyR4JdsghMXQKqVHcSPfvgO83nUc+iGGFa24UqWIGoz5aKuieH9sQFolbpJKj8cjNX3oCqFwgnd2JtFwqarxe2yN68u5Ek2R4DBih42kYlYRea+CE+UUGUctBnODux8g/VRcopdQz0caSsGksC76kom06zIabCvUYTDq3P//kFk2wKaGgiMSf1b+2zcBokn4rJTczk6UvnT5wjMLAyxgEus3DGvwtTlLeJeIJTzrBuNNHpY2KYzlgyL4tYn6wQ37KhiYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=It65MVk32CP51aKCK1dag4V5Hqyq9UBcxOX4uzKEYrw=;
 b=iPqhlBx+lJBT+OoJ4IQ9OJERYhZlM5j7RawNe/Uv4sKtT9dLgsNRCQpr9HT1TVlsZvw+D1bdwNxHHS+xzCIYAhYcM6Jk/2Yb4iGyKZHbR+eRHRdUMsnOJ/w6yVLUoWQnrJK78mIamdkwnXa+hAJtliaH5uDfZxBpDM3QrCUtVPg=
Received: from MW4PR03CA0165.namprd03.prod.outlook.com (2603:10b6:303:8d::20)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 23:24:09 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::2b) by MW4PR03CA0165.outlook.office365.com
 (2603:10b6:303:8d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Tue, 23 May 2023 23:24:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Tue, 23 May 2023 23:24:09 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:24:06 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 06/23] cxl/acpi: Moving add_host_bridge_uport() around
Date:   Tue, 23 May 2023 18:21:57 -0500
Message-ID: <20230523232214.55282-7-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: d273a5fc-299f-40db-a135-08db5be4cfac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SVwhXb8Zl3vWEydgnyQvkSh368ya8M97sGQbXOBA01M8kXBgXKP0vhX0cUHcL9j03wmj3jkR06lJnOZs4nBcl8KCAvlushlLNIS2ukfT+kXUdcGLjnHA7AnE3cvXqAaNUJX4H5lhUKRAc6Kkh86iLfsCK12CL0WKC44gQn0MZjbf6jhAZJsbQ9+vLTVDj9gDUMyXIeeHuYGkUUfS4DWMPakwnqxyPWbDRMe0tQuX0VENCcEpttLLrEclg1ud4FMZB175pf5I3gtA6/2QzqHsvbvFSdqC+usYXsJOsYL/JLFKItptvDrlEkTnksH7lLMQpI0VM++rWsIhSXzXbVKOxICxck5DxUHHqaKGU4i+GdAGTjcihO531utGcZYnIic63UbkzO/Y/aXEhpQIK19qAMcg3nN/C720ckN7k9mxZHnf3rWUy6oOWkhMQ+fOZtn1vuiUVbN19smpDPSuSYVrQOJsUutpiMtIlfY88LUrL8x0qMaGLkH+R+w8QLXvg7Djj9A6vnl+v9wLxhcT0KTmEkmBjse0EFtdU02n6tutZNMgVBH2RAp608CpsHKIoXVCNwEDXS6cWZq4HsxRnk0OAJD+XH9nT6Im38w223LYFBaCXu3lEhY0VjqDOqFpHZXE3V+AaJ+K6bOFH12cFhenEt09MgzAvXrh9IpOgZSLCAJtaObxOQswq3SZxyFdI68fsgszY8FRi+zf5HDNyIKuGWMcpst34qY8IKWYCnnSqc9Hl7Bd4JqDMD+kFgDKaFuZxbcL2V+LVXL7ivQCMWSo0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(8676002)(8936002)(47076005)(44832011)(5660300002)(7416002)(36860700001)(82310400005)(336012)(83380400001)(186003)(426003)(16526019)(26005)(1076003)(86362001)(81166007)(2616005)(82740400003)(356005)(40460700003)(41300700001)(40480700001)(6666004)(7696005)(70586007)(70206006)(4326008)(316002)(36756003)(478600001)(110136005)(54906003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:24:09.6519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d273a5fc-299f-40db-a135-08db5be4cfac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
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

