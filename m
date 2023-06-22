Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA658739602
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 05:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjFVD6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 23:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjFVD5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 23:57:10 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2042.outbound.protection.outlook.com [40.107.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222491BD8;
        Wed, 21 Jun 2023 20:56:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIAcSn0mQN1Tr/wxDtO5ch3lofi9oLG6tmJKWeCRnwkFdjVSMqZ0fxVESj/+CTMY4ONuvOBLF4vLafdiVHex8V3roV8qi42GmdGBen/znQ6GROT6P40aDLvt67W1ontzCzDbZ+JHIxWDipY5wHlNxztdliBqglOCaWO6fuoxK0sj1hgCgzKwKmaWpgl24MZ2kmasnUscNTxqvakTDgXEUyUO43K2P+jkrxYxypK6PZUcTXl0DSFq+7NkDK6ihJnZt2cKJwx6skiloS6oCuruN3gJeEscb8mUo7cvzHgqACCTvpCSrdYBmXEApwChGea06x6RT0eHVmLaRg6hgjKiOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E059ipK/zVOw/u131srGq0nmEWQWJEXPx4wZxTDqqJM=;
 b=fpAVh2OpZCjOZEirY13VRozbclPi/SE1NaYYwpilhtN9NGVieO/3GFwWFc0meZj/97zx4zkdRU1XPSbwfJHsaLzSeL1QTnrzyV2XLX4nZG074Se+gOUO4h0n45cs4OfCh7foBYXukE+8mHdnOiiHc3G+U9WVl97OzlbPLh9R7N6fltNLxzi9WAS1xh4PAnYZKi/Tb9HUKen7cvr5d4uIm40UtZXOr0curDuGIXdYNqLZwo8K2s2uiK/t3hktRqhb/Ck46cqt+OhHHsspcC2L95RaPSAVE1wuXVsa6FPW4Y2G7uc/eq6RCYrQ3Pi0Wtya6RmvMKnlkD59ox5f2cmcpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E059ipK/zVOw/u131srGq0nmEWQWJEXPx4wZxTDqqJM=;
 b=X8wlyu62QILaVck1jI1Lm0D8A1HRT1QcWdidvO+o7rzXj7CQyaeXTW59V3owsCGtCAkhXVrqwJPugpZYFfWIVN9Ev8dtv2dSztv+ziVRtE/5jxWW+QbJzC8wLW1hQnKpVoOmewLR9oBoeElU1WleNaUvFf7iNim74ioPDhLxQA0=
Received: from BN9PR03CA0764.namprd03.prod.outlook.com (2603:10b6:408:13a::19)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 03:56:02 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::96) by BN9PR03CA0764.outlook.office365.com
 (2603:10b6:408:13a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 03:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.39 via Frontend Transport; Thu, 22 Jun 2023 03:56:01 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 22:55:59 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v6 18/27] cxl/hdm: Use stored Component Register mappings to map HDM decoder capability
Date:   Wed, 21 Jun 2023 22:51:17 -0500
Message-ID: <20230622035126.4130151-19-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a8e1fa-8c17-4d0b-1beb-08db72d497f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9PlWedjAs+MyAAEIyo8SvOtP16wShrKFcDrqKLniavPJfQprtwYGm8WTIcv8mgn9VFSSn8muNWqgFZnBpfwt05nHeEiVPFqWFuC1JOofdCnjx0vPhanUTJei8SeomAec2iQ01ewjhht2omrbw8BHOTbaM8JxooVKyBbZ1n34t8h3flxRwehlx28hVyL+/ZojeEuSyMF1zmwh+bq34tnE6o+HWchniQ2gF32tOH/GV5PKA1I+wkrOvXCOqMd/cV27BGjj8uEuHodxGH7gL/W3qqtHBDaNcL4VtXdjeEb4eHfQEK2JaAAmjqKVHupyCKxUqa2IjEHZ5H1H3V+vL9vGPHRFQBydYZTYzi0OfijwHjBQS8f8JQe5BugGY4jIz2tmukJEriawmwZEFJ1Lg7ZX34BBpktv0s5tfKGuVKSVok2WvQvjrj3JN6urYqxOhAfEvRjObgOaPR6uoBFectpVvQreBSf2PPqZkJb0ZtqQzSY5matv2z582wcSRePCJemw1BGQM1CPyB8rtd0SKCKQijLERL6WZfBVbVxQUnad63y6ZWtbln+vAEzXpQ5Hjmp1SYf88dwWRRYU/1UxzPOaEB2Or8JvLGeJKMBS9bCJedfKS5vuJLYI+b0V39frO2qSM163flshMULUWCrHBI9gCfBkbDwunTrwQAYQiHFYNUd7e1slBM/TTgV6hRFzKiRW8l7RXosVz/g0rJu0eaPw8krqBbQP4hYgD/3e3sqHl7Z4RC0rSv2VfdeC6kDpU6c8WdB+rZMbrSSxRxiKft8LQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(7696005)(110136005)(478600001)(70206006)(6666004)(54906003)(70586007)(83380400001)(2616005)(36860700001)(40480700001)(336012)(426003)(47076005)(40460700003)(86362001)(36756003)(2906002)(82310400005)(186003)(1076003)(26005)(16526019)(356005)(81166007)(82740400003)(4326008)(41300700001)(8676002)(316002)(8936002)(7416002)(5660300002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 03:56:01.0644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a8e1fa-8c17-4d0b-1beb-08db72d497f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946
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

