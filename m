Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A6A70E984
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 01:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbjEWX0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 19:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbjEWX0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 19:26:12 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on20625.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e83::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50F2186;
        Tue, 23 May 2023 16:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0/p2UqSV4vd4Lnhdq/0hytq1IO99CaIX1zFvj4gXtw3G3hIwN2T/+PmyflqO2BeCXt2htRaOdNvKsvpTALDyhbzQxzfHInN6wJvTAaFmj9I81tbnPVYaWi2R+cZADvEkIb+BPzsXtzxNcYzrOUEdK0rzCb/xyouApwbJQoXeDY6TYMwQ4Luu0NyElRzrHixJ8ZZcC3o/SnOOaoN3etIHCdm5pvOp/++7UEKhjUCtKfzaabMHMadRmhH56frzO33Qaa6FkEE4DzhDVAVK9ES5DabuJ4aTQcESaxnyXW6xtMXTT41YuSO0iM+PNdfrBjV4LO3xsZ37sHvmVwlCu0Oaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0KWUDvo8knqFxY5epU4v/oEjuSH4pRUOlFsM3aaVh4=;
 b=X+yz+kMZI7o0ewpNurYPKNjD+N38ka57+fZb26vXwupo/yqXGQz//1DlH1jMGJg9UvCZeSvCDPYArZ0vWCU3RNXTAwe89NZC83mwy0Ive4nYv/YmN0f+lNwT50XhRSW68ixVxoJ46dprx4KWwpYAmFOAzthfjbvXYyZsK2BJEPzp3gl+yQWsPWu2UliPekvuNHamS6SN3RYQa2erZJ8pGUkL4Efoy88JXjw1WNk2rJO8I96nqhRTzkg/HJCNcYdH1WS9sf8Q+msM5L4st7AuYWex00oyJJv9DEUhISIoDCzNQXsybMdajRxzqJ1qZ6axv/1u9UgsazIyU/Qvzk9OYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0KWUDvo8knqFxY5epU4v/oEjuSH4pRUOlFsM3aaVh4=;
 b=hOnuqfN0j9E7ihyd4UznVWFEUw+VlWUKyQ8fQ8J69cae81IRRODJBR1UNyTmtCZRpRXWTv6iHGfIII47K46EwNcvQkYwtXTHat7z1dwsScyUw0+jSowkqSLazdqUXnGRP8d4jLOltggNDCnAG7I1jmiVM9zZdQocrIEuGy5PzTU=
Received: from MW4PR03CA0313.namprd03.prod.outlook.com (2603:10b6:303:dd::18)
 by SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:25:24 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::2a) by MW4PR03CA0313.outlook.office365.com
 (2603:10b6:303:dd::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29 via Frontend
 Transport; Tue, 23 May 2023 23:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.29 via Frontend Transport; Tue, 23 May 2023 23:25:24 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 23 May
 2023 18:25:22 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v4 13/23] cxl/hdm: Use stored Component Register mappings to map HDM decoder capability
Date:   Tue, 23 May 2023 18:22:04 -0500
Message-ID: <20230523232214.55282-14-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|SA1PR12MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: db8bfbd1-10a9-417c-82ac-08db5be4fbff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UUFNTq0v9R8y+hPYQNUnWfiLvK6gLfZzA2kDYKoIQQ81EhlSx9Zxjmv1DGwqfPu7s2z8a2YjEEX97A80ALsxmebh2YpQUlQLg5bTLiyeTU563cDwrAUg9Bi/XyIOWMjAqRABFwIUtk4iPO0CvI0KJT4sD9PFx5miE6ChdKUIvYBhDs6A7WQZRPrlOydtw5JFzPSb6Gszo+OAW+Wjuh6ePRII6Aa1Cstyn0FUY969Njlv/qYOF0+dGmNqwXtnLM1fvQKKQOIsW9D+ufbVJuypU19Ode5SlviWVdg/IEzkwOLBUzFzzUY1/ng0N7OFsmhQdGSpnlWa6NKWWX8vwvl3ajLu53Of1iObiF8zZYvKUYpd7imA2f2mENqyinQxubuF9TBlScvolYrKb6wqPtfbWme5V198ZS6EpcDcdP7HvGoBqUIqWxr6L0xJT6QHbd2OCKF+wSttyeIMUHf1tceNVS4dcsB+wtZxedK4FUBFMNwEMHXxRLedtZfKsLjP9sPq/OVVOO4KK1P75/xWO3QcjX8IPSAmCfu4A4km/YMcXctRnwZZ+K/Q4ymCEqBX4sQz9Zi/0yoj95W7lAn7R8oOqzaJvNYQh9JIeVqF0JKBafv+qHCuiL5eMoDxrl7ztQeZIylFdJMzeTdhvZXWFbeACasqKUw7UWqyPClG/EpQioNbrbz5/yQfNe39C1jCnKP3RM+wM8ALTpXFaPJc7btUXdqgM8LN7vzWLqgGhXI6XMDi1UIJPHHZ6tnCAKPv9dkTK7hCH0BQ+/i5sss4kDllxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(41300700001)(44832011)(7696005)(26005)(1076003)(6666004)(316002)(40480700001)(82740400003)(81166007)(356005)(8676002)(5660300002)(7416002)(8936002)(36756003)(40460700003)(4326008)(86362001)(478600001)(82310400005)(2616005)(36860700001)(83380400001)(110136005)(54906003)(426003)(336012)(47076005)(2906002)(70206006)(16526019)(186003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:25:24.0148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db8bfbd1-10a9-417c-82ac-08db5be4fbff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Richter <rrichter@amd.com>

Now, that the Component Register mappings are stored, use them to
enable and map the HDM decoder capabilities. The Component Registers
do not need to be probed again for this, remove probing code.

The HDM capability applies to Endpoints, USPs and VH Host Bridges. The
Endpoint's component register mappings are located in the cxlds and
else in the port's structure. Provide a helper function
cxl_port_get_comp_map() to locate the mappings depending on the
component's type.

Signed-off-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/cxl/core/hdm.c | 59 +++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 5abfa9276dac..55b5cb4842ae 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -81,26 +81,6 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->interleave_mask |= GENMASK(14, 12);
 }
 
-static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
-				struct cxl_component_regs *regs)
-{
-	struct cxl_register_map map = {
-		.dev = &port->dev,
-		.resource = port->component_reg_phys,
-		.base = crb,
-		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
-	};
-
-	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
-	if (!map.component_map.hdm_decoder.valid) {
-		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
-		/* unique error code to indicate no HDM decoder capability */
-		return -ENODEV;
-	}
-
-	return cxl_map_component_regs(&map, regs, BIT(CXL_CM_CAP_CAP_ID_HDM));
-}
-
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_hdm *cxlhdm;
@@ -145,6 +125,22 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
 	return true;
 }
 
+struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
+{
+	/*
+	 * HDM capability applies to Endpoints, USPs and VH Host
+	 * Bridges. The Endpoint's component register mappings are
+	 * located in the cxlds.
+	 */
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *memdev = to_cxl_memdev(port->uport);
+
+		return &memdev->cxlds->comp_map;
+	}
+
+	return &port->comp_map;
+}
+
 /**
  * devm_cxl_setup_hdm - map HDM decoder component registers
  * @port: cxl_port to map
@@ -155,7 +151,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 {
 	struct device *dev = &port->dev;
 	struct cxl_hdm *cxlhdm;
-	void __iomem *crb;
+	struct cxl_register_map *comp_map;
 	int rc;
 
 	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
@@ -164,19 +160,24 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 	cxlhdm->port = port;
 	dev_set_drvdata(dev, cxlhdm);
 
-	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
-	if (!crb && info && info->mem_enabled) {
-		cxlhdm->decoder_count = info->ranges;
-		return cxlhdm;
-	} else if (!crb) {
+	comp_map = cxl_port_get_comp_map(port);
+
+	if (!comp_map->component_map.hdm_decoder.valid) {
+		dev_dbg(&port->dev, "HDM decoder registers not found\n");
+		if (info && info->mem_enabled) {
+			cxlhdm->decoder_count = info->ranges;
+			return cxlhdm;
+		}
 		dev_err(dev, "No component registers mapped\n");
 		return ERR_PTR(-ENXIO);
 	}
 
-	rc = map_hdm_decoder_regs(port, crb, &cxlhdm->regs);
-	iounmap(crb);
-	if (rc)
+	rc = cxl_map_component_regs(comp_map, &cxlhdm->regs,
+				    BIT(CXL_CM_CAP_CAP_ID_HDM));
+	if (rc) {
+		dev_dbg(dev, "Failed to map HDM capability.\n");
 		return ERR_PTR(rc);
+	}
 
 	parse_hdm_decoder_caps(cxlhdm);
 	if (cxlhdm->decoder_count == 0) {
-- 
2.34.1

