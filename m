Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2066228BC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiKIKmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiKIKl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:41:56 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023AD24BF5;
        Wed,  9 Nov 2022 02:41:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USCOF7w3xwcxEoLfGpqF42/Xu41D/oAu5CVlQ+K3lcweACqHSF/mAGdmHAsL66BmA7vpDjrb5twzQGUZme4I7/YVaqR10XdhTyY956IHBb/qwdl+6LOlDzd4olG0Ph0XJ8YUTT3X8Gltmq+/X63xe5HRgKxRTtQjRJVyeM+OCIQypzBISj23DzLXL1ThIwC9TFYYPWrmJjN2Lp2giz5PX0WuDLl6kqLTP7OBwqQfLzCozZR/aXkdYGeCMLMdzWb0LKhzxxXujIvylInqOwjKvufQId2nYKSoAaBSljUd6xsI1buw/I6nNsEqgC/0ZN2szTi2D7P6QoAVfqtMfOD1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKDHc51d7FEG0Lu5nY4eByWXC99jgX1kSwZm+TRGAHw=;
 b=Y9cOTi6WVx0pxiHSOcgYLTyJ9YENtpcJmMnSpVEUbFWKTfYZh81Ochtu8OvKa5ULxwRYzyK8cPr6LtwQZoETK5algqV6Gz8CNYt7YnH+rLs4N5BIO4Lifm4IixVIyBA9PvW9w6NwldLgz9Z89MkeE3pWSUAPgYKgk5+wJ09PXZkO75EHgK7IRNZJcb7J9byczSFk3/PsX+4dcTn09eD9MxVF3hPLVbXSbtvNrURPP/JAA1IdmQYPlFExTfSknQIenXIO6MlWW5RNMAvzY+XnUX/HyHXKRY7B/nOnxaOeMVkUN7EEPVudQwsEhfztmhKX/2YqsPTxOgIOzXtoTtya2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKDHc51d7FEG0Lu5nY4eByWXC99jgX1kSwZm+TRGAHw=;
 b=vHd+1d43xMCPm00zPhiVwRtid5K5I6WXpwUB3e+kjRrGq14/17R3HBby8zzuQX4VqBV6EkjCZgI9udmU1GLtb9TbWYlCncsmS3mAD3yhWVWLhAOBO6u9g5MdpABloQs2Bm54CiYzQDGOukaA7IRvBF4nOXZqeAFT7f8ccFa/xjw=
Received: from BN0PR04CA0063.namprd04.prod.outlook.com (2603:10b6:408:ea::8)
 by DM4PR12MB5216.namprd12.prod.outlook.com (2603:10b6:5:398::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 10:41:43 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::88) by BN0PR04CA0063.outlook.office365.com
 (2603:10b6:408:ea::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 10:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 10:41:43 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 04:41:38 -0600
From:   Robert Richter <rrichter@amd.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 7/9] cxl/pci: Factor out code in match_add_dports() to pci_dev_add_dport()
Date:   Wed, 9 Nov 2022 11:40:57 +0100
Message-ID: <20221109104059.766720-8-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221109104059.766720-1-rrichter@amd.com>
References: <20221109104059.766720-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|DM4PR12MB5216:EE_
X-MS-Office365-Filtering-Correlation-Id: e76397c1-a1ee-485a-0157-08dac23efe48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zqoFqo/jzW42iUUSv6lS1sllGBlfaJDATCNc9zvjjUZfcTG408m4+JKnlVpOlkmBc6qMfPL6wMO+qx07ZssHQCJT4uVQ4bb4d3ekqJNnvgIakJcCXo5gxdksSa3MrImo2V/Q6O50QZffQbGaG1YPwIWSHdmkVnUtfpJrINmS2AvkmUEf8UpXx9XfZljLvReuycWcf4fXZ7ncLWc2vhMeIOt/f+D+csduUiz/dsoVTSwRiqVbC3oGmkI/fYWVybySJaCx8cbZLI/tPIxHf4SNMCFoCnzqhOCo+rRhbbCmW/TXqTAA1bxYDKGfYBvNw2y/+6Ik4tZqyK2b1tph6o3Drw0U4uPtczaflI4NK/RP5cTUosiz1T3Tl1UOyFyKPOTWONHHc0jZOlsXiCWllDsVxqKwwVETvB6TLbmBeAp0/iM45ZaDAGLPp5bQ92DAHqaxU2/+foqjT5T+NPlDdEJ2eQCi7lwn6CtB4H1GKMgulcNN+Gyd+AE4PPIeaE3z37viwGcrvOq5ak1gncZMMY4BfAwHSeKyPmK0tSVk2tofjVRe2hASReDLhf90ceJ6aQ9CTkb8YN8sKb47jOi+YRdBTdhHMAz297FMKPAoOYgMegYDpOnfiUlx3EHkmArY4VAgLP4iLhy3leCqc0cT1+9GbQM3WBCHSRSsAHyEB2bsm2ENivP6zYTjMy7fLFM/taejoDpBrI1NX8+URmgxMk9CPqfTNZCKalzE+bX3OH5l9wj4PfCpiooAPG7WyzZql5yx5uAjXdvkcq4PAmWqB9aj8WKUCjzz9fS/d0DonR0RP0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(26005)(82740400003)(356005)(36860700001)(81166007)(82310400005)(8936002)(70586007)(41300700001)(8676002)(70206006)(4326008)(7416002)(5660300002)(110136005)(316002)(478600001)(40480700001)(54906003)(6666004)(40460700003)(426003)(47076005)(83380400001)(336012)(16526019)(1076003)(2906002)(186003)(36756003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:41:43.5770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e76397c1-a1ee-485a-0157-08dac23efe48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5216
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the code to register a PCI device's dport to a port. It
will be reused to implement RCD mode.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/pci.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 8271b8abde7a..667de4f125f6 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -29,14 +29,32 @@ struct cxl_walk_context {
 	int count;
 };
 
+static int pci_dev_add_dport(struct pci_dev *pdev, struct cxl_port *port,
+			      resource_size_t component_reg_phys)
+{
+	struct cxl_dport *dport;
+	u32 lnkcap, port_num;
+
+	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
+				  &lnkcap))
+		return -ENXIO;
+
+	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
+	dport = devm_cxl_add_dport(port, &pdev->dev, port_num,
+				   component_reg_phys);
+	if (IS_ERR(dport))
+		return PTR_ERR(dport);
+
+	return 0;
+}
+
 static int match_add_dports(struct pci_dev *pdev, void *data)
 {
 	struct cxl_walk_context *ctx = data;
 	struct cxl_port *port = ctx->port;
 	int type = pci_pcie_type(pdev);
 	struct cxl_register_map map;
-	struct cxl_dport *dport;
-	u32 lnkcap, port_num;
+	resource_size_t component_reg_phys;
 	int rc;
 
 	if (pdev->bus != ctx->bus)
@@ -45,21 +63,18 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 		return 0;
 	if (type != ctx->type)
 		return 0;
-	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
-				  &lnkcap))
-		return -ENXIO;
 
 	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
 	if (rc)
 		dev_dbg(&port->dev, "failed to find component registers\n");
 
-	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	dport = devm_cxl_add_dport(port, &pdev->dev, port_num,
-				   cxl_regmap_to_base(pdev, &map));
-	if (IS_ERR(dport)) {
-		ctx->error = PTR_ERR(dport);
-		return PTR_ERR(dport);
+	component_reg_phys = cxl_regmap_to_base(pdev, &map);
+	rc = pci_dev_add_dport(pdev, port, component_reg_phys);
+	if (rc) {
+		ctx->error = rc;
+		return rc;
 	}
+
 	ctx->count++;
 
 	return 0;
-- 
2.30.2

