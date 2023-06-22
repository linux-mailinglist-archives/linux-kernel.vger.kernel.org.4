Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0DA73AAEC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 23:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjFVVC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 17:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjFVVBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 17:01:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68CC2D54;
        Thu, 22 Jun 2023 13:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnWefkz3VgvGfCrTV0h2pNAPISXTmTqXJRn9ePW5sC16o4MewPdfjhfh96TLLIFeRsdorRCw/OXRfTIwEjNpz2p8bw7JfshAsoiFnnCE408C784C4r9cNR2tUjUtFL2TuYtKaBy4nzIHmibeCVjcZeLg7qnV978bLdkytwFnNWCK1NvvlubynFvTeipc0um+uya//+Amhcq5SYtJ6D6ZDe4On7mn6kevVCGuk+QyurWowSwKfJC3WLaDvfU+mYqNaHQaufzOxEfXm/eTtqCUVQDnTbM8+7ms9olF6BsUVLOcvY+eylnc6yVSU+QKpQWobMUgJ7IzAlqMhoO5Ple9hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E059ipK/zVOw/u131srGq0nmEWQWJEXPx4wZxTDqqJM=;
 b=WUts8bqdFENSBb+sZ8Nm964Q5vCtklnDPd1lhspAyJ1YM/Yb19XDnh31+twstc5YCUSnpgxn81MrtStShTst9Q9H0Sz11TambiEqC7buH5Oo7T9qo8tVJHq+9HA9XrFJxa8CjXLQzGh5VDxPnp7tf237XIbeuMsJHgkKGJzhuJFMzyTWhbz7PY/E/U8S2WHyCzfoSmq4qRVyl6uvcQAlizWWzlNw30MKWKKkb8Pc/YT4QI25om6qxZw6vrBAx2Rw7dHV675S3g6FuAjFD/Wsm/mz4GWjWY/+W6o/meYzywTZyHxQpehwDIKzqdIS7b6MDFbL05dUgvKBDz44I9qi9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E059ipK/zVOw/u131srGq0nmEWQWJEXPx4wZxTDqqJM=;
 b=VbGDiEYWg2g6yZCqfkdVcaj/3anoRBduR+qiWSiCzCWOnVOrOjFyvVPRMD58pTscGwXCThF866L4YQW9Wgwn8ZYrErZQRaYJSE44hb0BONKj1DdG0IhxenFEmINRXLx0ANCnkgXglau3AT+iQjbZuaYRBgLKLeHbfrSQUS4OE1I=
Received: from CY5PR18CA0002.namprd18.prod.outlook.com (2603:10b6:930:5::25)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 20:58:40 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:5:cafe::16) by CY5PR18CA0002.outlook.office365.com
 (2603:10b6:930:5::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 20:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 20:58:39 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 15:58:39 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v7 17/27] cxl/hdm: Use stored Component Register mappings to map HDM decoder capability
Date:   Thu, 22 Jun 2023 15:55:13 -0500
Message-ID: <20230622205523.85375-18-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|BL1PR12MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: adaa9cfc-d0fd-479d-0212-08db736374a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/B2blBpaJf2kQ9YiCu6uQUUEVRzzzR3UY18A0xgSDe3t0jThdIYMKzlrwW1Xp6hVHberyBuSYdjgOSyKb5bvtDW4nlIq8MemVBIcQZJ1MSXV3AudP6EJFXZib8cQX1dgcnyOnwzlfZ7xAKALsuea6rSjEBoEga8cJ26AgBKhXuDehAEj8IxoDKHywPwxMROcmwcNalukd8tBPPtv917dHlpeULmG1wn7bY2IK5m1fhR5NF2UY5RVcQpNQ8v83LmmXg4RAOaXYX5FfrwQU4MDdXlO5mhgY/QA9sCk0Cl/XqpHTwR2vCVZk0BOlbeWeVH/NbW14lAQIRsKI0uHSRdNTEojNGXdWj9MOuJQgEReEiYMyntCzJkcIeTecSMMskcuHUhUWOyITlQx1tNxOBVUBUCbGbDs7EyLgPiXbQ9rXxypAvqZRN6E+0qC/DoaZdzaUjHQ0Zy0sQrizqhE+rOCGlQBwyQv7AOIPnCXwkCbJ1N9AZiuxYVl6YzmYqxxfDkGGCzw1/8NC9UL6B57gXCB9yAmS2GNpcJScPlyIjAhEwdJv4wn93s9f3ahN3gPcZc5jbBnD+Fa9biAuYdhrD2iyvwOHe8qMufCVhfBkjIAUPHlt2EQusvMoF73iGlAJRN7+ZPQJfCx0vxwORSqwukYv0pvDsBWhOcVaAzZz3dDS9Aa/pVtQAkbZKXVY0DkMRkQdT3fvtLq47SC4zmjjN22FvLIeSRBQaP5rfg1tBMCP/Kn6TIgFZecSehe8rOQ5XpTM9KMamBt6GY8psr6H20mA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(8936002)(70206006)(70586007)(16526019)(316002)(186003)(4326008)(26005)(1076003)(2616005)(426003)(83380400001)(336012)(40460700003)(7416002)(82740400003)(7696005)(110136005)(40480700001)(47076005)(36756003)(36860700001)(54906003)(41300700001)(44832011)(8676002)(2906002)(86362001)(5660300002)(478600001)(82310400005)(356005)(6666004)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 20:58:39.8153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adaa9cfc-d0fd-479d-0212-08db736374a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/hdm.c | 59 +++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 5abfa9276dac..8dcd9f0b22d8 100644
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
 
+static struct cxl_register_map *cxl_port_get_comp_map(struct cxl_port *port)
+{
+	/*
+	 * HDM capability applies to Endpoints, USPs and VH Host
+	 * Bridges. The Endpoint's component register mappings are
+	 * located in the cxlds.
+	 */
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *memdev = to_cxl_memdev(port->uport_dev);
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

