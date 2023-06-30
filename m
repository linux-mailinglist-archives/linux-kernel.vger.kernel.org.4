Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED98B744514
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjF3XRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjF3XRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:17:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C763C17;
        Fri, 30 Jun 2023 16:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuS0iBtWnmg4wuEpIFHr59qdgCS6U36YHdHMEGpWSZCErJQpo8T0BQfUc8k4jv+hSVYYKOFXsBX5urDbDpTY3DXgX5qpbpZ/UvChwZrVpHtwdIhmg+JjoJeirvMxBuKEz/jDcbsU/y96OxbtQiTHmj5dcqb8M68hIees5untffi93QtKIylsU7mim4IL/3zInUSAimv8Xt7+VnqEZF7ZdRpo29tR7bEM5xGCQLdVnD5d35Av0sKqcHHf7yRNPEg0eOY7D1DtagmpFEW4C0fQfoGgYj2WzpueZq1BAjYMoStekiCCI4jFBr4RaFtcj9hR71OgB5kR4bEg5FHM2Py7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABeINDbqMY6Qk18Kqg7NbRozgFxBeCn2SmP490du/Vw=;
 b=BfMwhXYlWvRMzrzumb37vptU6gz59uzQIuFGLO/xfPkbLmRmIJ/vkwVJrUyeMcX7tS2QonkUnqICbcVqF59VL1jQbJ33DIZKxxwOO+UMLXymqDapakiJ4ymajYWpotftarF5dcox0bygWXKd/ODcJVdIAFKKirPd9uAL1O3yv7UFlZhICHCwu+edB8jbzdNWP/FppStzwpLpQEpk066y+3BglSwfLuoQFx4zCn1oWBLQ05QYYKCh3UMJBCnTEwwmwGeze5F3P+spGPWx6prjeqoZHPaI4JmwTc/dDHzpYbgmaDUZdMTU6om5vqQsQOfTQ52BOJ0nJjZfUEAzdozhfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABeINDbqMY6Qk18Kqg7NbRozgFxBeCn2SmP490du/Vw=;
 b=zHMXmX7CsEXp1nWTswThWE+COyVX8HJVelvcURivBkrMkfYS2o11LmVtOd1HYx1l+sdAJifLov/4i/5TP2TkV0VNA/6rMFHETmJIoSdZMeaWXoD4SNSSr4Mi2lamkT5+Mj2FZk+PBAy7loBkfJu+6pmI47I3RT3dM8KSgkIIaq8=
Received: from BYAPR21CA0028.namprd21.prod.outlook.com (2603:10b6:a03:114::38)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 23:17:24 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:114:cafe::7a) by BYAPR21CA0028.outlook.office365.com
 (2603:10b6:a03:114::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.10 via Frontend
 Transport; Fri, 30 Jun 2023 23:17:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Fri, 30 Jun 2023 23:17:23 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 18:17:22 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v8 03/14] cxl/hdm: Use stored Component Register mappings to map HDM decoder capability
Date:   Fri, 30 Jun 2023 18:16:24 -0500
Message-ID: <20230630231635.3132638-4-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630231635.3132638-1-terry.bowman@amd.com>
References: <20230630231635.3132638-1-terry.bowman@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: 622edc73-232a-4b30-fdbd-08db79c02961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5hyf825lecJ849cqJj/gms26mEgy9g5J/kcNp0NvJofGSNZj38C96PeF2cv2AlecnBhKUq7H6m/ooYGc2SxxqtFl4TK0M7oP0/X/F/JYm/cPKcCIxOv/h1ZT5n6VoT7vOzTiDC06X5os74vb/RdW+rTvQSZ426dWRxAvMvtEp9fRT7cVkC48R/S7P4kFoD9aze5hcnSrBDav70WgiinI+6jtRCCkXS4OxdUaNkRRo1eotrl+I1bvrP7lFt92aHcwzXh/F6QTv1BMMDapVgXlDFFnLWguq6QWB2G3OsgtiLSIkP4W0R+0a+H3YtHHiwEU8IVGMuGq7pt10bDD8cPGNmEdHCbYNjiRXSpdBkK8yfPpr0Rvuf76YrmpkvuVXMGJEs0JGrZWhgpjzw4gHZJ6+x66K0JuakkNNiTc1o/ljx6nx//MSr3+zQ6fzKmvFSmuEcjUScum7Ja7Upjp7dd+tW23yBl6tRmFh8gjPdJahyEPfBJH+/IvyeFCLMWlJMdji8eghauB8+5GI5V/AI1dYtbsrIZqhSxycb9yLKvyEz7gsmnxG4pB/owFX4Xpywt0VbwwAtYjyzA9c5p/VC85GjgwDm91hD/n8juvq+h+oKXCJnjA6TwQ2ivWkzkqD8mhaKdtfVYDPBfwLPHKLi9OecvzNcJjwKiAhIjxIiHdBHU6MzUW546myT64LQzn4uE1hLxjEvyS0/1DS9UpqxUYhoRlTUryc3qvAzK89ClJuviDjJG/mH1reBmTyC7ucoDOt7pXA1ugJgxJ3AREiMJWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(86362001)(54906003)(8936002)(8676002)(5660300002)(82310400005)(110136005)(7416002)(26005)(1076003)(44832011)(7696005)(478600001)(4326008)(70206006)(70586007)(41300700001)(316002)(16526019)(186003)(2616005)(2906002)(47076005)(40460700003)(83380400001)(336012)(426003)(36860700001)(40480700001)(36756003)(82740400003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 23:17:23.7089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 622edc73-232a-4b30-fdbd-08db79c02961
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c | 64 +++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 4449b34a80cc..b0f59e63e0d2 100644
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
@@ -164,19 +160,29 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
 	cxlhdm->port = port;
 	dev_set_drvdata(dev, cxlhdm);
 
-	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
-	if (!crb && info && info->mem_enabled) {
-		cxlhdm->decoder_count = info->ranges;
-		return cxlhdm;
-	} else if (!crb) {
+	comp_map = cxl_port_get_comp_map(port);
+
+	if (comp_map->resource == CXL_RESOURCE_NONE) {
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
+	if (!comp_map->component_map.hdm_decoder.valid) {
+		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
+		/* unique error code to indicate no HDM decoder capability */
+		return ERR_PTR(-ENODEV);
+	}
+
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

