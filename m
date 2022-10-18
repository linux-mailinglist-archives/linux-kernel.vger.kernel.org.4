Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F00B602CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJRN0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiJRNZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:25:48 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A765DC8216;
        Tue, 18 Oct 2022 06:25:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOTqOrtnZ2s8gkBg8G3jT5kND5/0oFbFZ6EQpXbNtDvHwmqp7CEXJ1dFxTvsHnXCfuQUl7wRmr4JIa1uaL02ERFNZLrfO+drnq3FER5KHq5eki9x0R8usUZd2k23e713vQ8Go32i8chDVCpBl5ikG+6KJ1ABtu0OpmwFoMOqYnsN4mu47SDTWd9rPg3OjUQwjDUZ1fIgSQ9BbImzw610qryTRddJ+tv10/7GVpyLjQ/s8RDHVSHvynSY/OjMkuUfjSPTKB2cxEO9AdyotqcKenoz30Jy8+IY0wsi/CejnRz+JTQliAVEDO8B9BTHOq5oCKSRyO6mVieoWhgpbE9yiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKDHc51d7FEG0Lu5nY4eByWXC99jgX1kSwZm+TRGAHw=;
 b=WZV7qBjQD/42f8dN6RbGANVi4Sryz2j362pCr6Kv+lX8KB64lWKPknnj2q+gIFmfPqi1B2SnBjSxiMJsF5UVoDwdl9gXWxpJrnsT5gzAzzONleujJIhJiVMqcARzLDPqx+wn0nT4KX7Iq2qUGlJYdv606JaTDlJUaZakrJKfgXPADrCGocaazzwcXZBLddk0TBhzz3BIcZ4/GRuoatkhH1Z5F/sIHNwMFVwBHSx7Yk67BWoOtH1xJqEvj1+K5znSwYX/+GBlIEqWTVm7K3Fjm4YCxbjv4QAYM1xglOHbnFRSyu9K6L5z0op79isbN7hYbvVo+qDB7HsjPXqePr4A9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKDHc51d7FEG0Lu5nY4eByWXC99jgX1kSwZm+TRGAHw=;
 b=ta3A3EmrRY72kYcFuny5f8FyfNICnbuXjIutvm2SUZm07eLpBMWlTWksO46tucKn3KYiuTJt9aFFF2eObybwvS7BT//Gk9w61gumS81632Twrz+ZHzZWKiz93o3Sj58SgNEsZoxZuojTDECWI8+jg8dfDw8tsjyKCxxDH7Wvyj8=
Received: from BN9PR03CA0581.namprd03.prod.outlook.com (2603:10b6:408:10d::16)
 by CH0PR12MB5266.namprd12.prod.outlook.com (2603:10b6:610:d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 18 Oct
 2022 13:25:01 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::94) by BN9PR03CA0581.outlook.office365.com
 (2603:10b6:408:10d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30 via Frontend
 Transport; Tue, 18 Oct 2022 13:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 13:25:00 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 18 Oct
 2022 08:24:56 -0500
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
        Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 11/12] cxl: Factor out code in match_add_dports() to pci_dev_add_dport()
Date:   Tue, 18 Oct 2022 15:23:39 +0200
Message-ID: <20221018132341.76259-12-rrichter@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221018132341.76259-1-rrichter@amd.com>
References: <20221018132341.76259-1-rrichter@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT028:EE_|CH0PR12MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9f280b-fa20-4503-465a-08dab10c28db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGWAmxUBc5wQVTyVa10/bDMqRGlfRFQRZNB+5Y1WJa5CTt+8urbdwRDM+Ml3Rl4B2NV/rOMYJFzquRoCTvF7zyNy/eVV8GqYD8IVRUP/pwhkhrjJuQq+RwlvLZVSYv1RiCWA6qERINYMueD9s7Wt3rp2LESC2Pbqscbth4V7uAQbrYPOR1JtCSA989JXp/VMKol5UysUl/FoXM6W/a44fboMjFA32vZsVrx/PJ186djf+hdUxULSoz14QmdWeqzPkJ2ximfYN7Fb9I6l4jCd9xgFSY0a9WHN2ulGHibJgME/A20D6AGml/cDHKUmziEXgXlTDV8CuOR3XAeVfqsA6PXVQpV2w3J8cNwh/1Ykx7xzQNBdxYfEnGTlSTy9Fpoaba1OnAkG0WR9WjJ4BkPoO/v+V8RvOJ94l8REr28bjBH4OtI6IA2cJpBlTmCgZKWrn7Xo9zK76qQLr7nPzjpgxx22uWKgnybZhkHQhdJAbsqPjrXSBod6oXq0a5/uCxTSpLFEmhD65TVL08m9R27Cgpwj0reoPCS1Mhx4avOucBG6YV2V3y0ifBD6Bwf5j7YoAL6PtcgjcHcZkEorJqyB/wN0nlwCdd+aAEFT6Luyg/TSQIvMJohuGbquHd40uX+42jeE8pUB16wmfhxUtuc7C7hR1Uhvlzz2t+5eqXbVlrleR9wa/RRWQWm0esmOoA+fc2b31wd04Gz7LS+WcPWWejEeVMqPslg8uC5bpElPL3jqGYKMSi6KVZnlYzOQXpjIzOqZCx11l7Xr0rjd2Zg5jZy7phDKqOhx2qg/EWgjR5o=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(110136005)(54906003)(4326008)(8676002)(7416002)(5660300002)(316002)(40460700003)(70586007)(70206006)(36860700001)(6666004)(478600001)(82310400005)(2906002)(41300700001)(36756003)(8936002)(83380400001)(186003)(1076003)(336012)(16526019)(426003)(47076005)(82740400003)(40480700001)(356005)(26005)(2616005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 13:25:00.9216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9f280b-fa20-4503-465a-08dab10c28db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5266
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

