Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C77472717B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 00:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjFGWUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 18:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjFGWUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 18:20:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7C92682;
        Wed,  7 Jun 2023 15:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPMFRJtqqYlXIuWbmAUWGzpMzQP0MN6fG1qppL0BA/MTDH2Q9myMYDPUp+42Or1BAHI8yLpUJ0J9AZutdkVXEouMJjOqnVKGRhaCckGE/8xQ8IMl2+GG2LJyx/7xrEwPD+GpngC1NiWnRlZysjWyiFn7IhzAUAjuBzV3jsa/inpMc7xKKkBar2YUl9eIOi2f/tfEuOMXefEvKLad+7wOrOwkKqpukpZ3ydlXwCc2/yztbRsnXRswT2SO/BOZNm+36OgQeeP5TjRAkbgF+gwJrsvqVwsMJqVh/nR/30GuJHVe2UyamKQSDClRP9dDQXBmmjJgBVbL8jHBG1Y+noSlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h69VZGFSo7hNSJ1EZCzcm0Yi2fEqnbytIPIAzkujDEA=;
 b=j1rj/KLwcJPpwVWdsD1gzo6bFXa6fJj9ggzAFB5HvF52wsOyYA3m0dq68SCjtlgjgWS5toGimJ5JKMqHl1SaH6fWPG8beryMNtjd3nSRPGZuNdEh8WMYhGvsBnjJLUObjbWUiKYbVzHAVJvOAXmxM40n8Y3c1NzNvJHLn6LXyAz8ntqp+hShn4GfMAw6DZNhekepfI928PvGQDM+ttSZT78NdynH/ZjPblEaKxsGzIP0LEkkzcdwJqKT1nRX5CoVXj3+d4UAfjOW8ak3GHmmSZzJdOv6fhQkv57SqVNi5LbiOfk+q5rIRcQqUh7Ct+Hb9vIbUYcjTOP1uMoiY3NrOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h69VZGFSo7hNSJ1EZCzcm0Yi2fEqnbytIPIAzkujDEA=;
 b=GWLBHUoIZ6H/3lUBBuL7Lv9pKIRGiYTHrYDzbSr5hVukLygC35v9rpeMRPbXQIq1O3C88N51CWKFtFtjKVKKwErwfqgaaz4r8b9PpZ7n48iL3n8f+rLbh85HZ7+mefglFSwj/ZPeSus/L1Vc4RVjaqVuDC97Dr7ZNUnRnO1tLnk=
Received: from SN7PR04CA0035.namprd04.prod.outlook.com (2603:10b6:806:120::10)
 by MW6PR12MB8958.namprd12.prod.outlook.com (2603:10b6:303:240::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 22:19:51 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:120:cafe::27) by SN7PR04CA0035.outlook.office365.com
 (2603:10b6:806:120::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 22:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 22:19:51 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 17:19:50 -0500
From:   Terry Bowman <terry.bowman@amd.com>
To:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: [PATCH v5 15/26] cxl/hdm: Use stored Component Register mappings to map HDM decoder capability
Date:   Wed, 7 Jun 2023 17:16:40 -0500
Message-ID: <20230607221651.2454764-16-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|MW6PR12MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eecd87e-df89-4a95-9f61-08db67a55002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNUFrrtLI4BFZs79kfjQmLWbmkHlgnJM3/2ShFSyQHH57Xvku30xeDzsIUEcDu+lM3phKmhlck6n4a/kZBQiGhndRHTMEBJR2K26r1vlLMrE65Yx381+tzbwQQ/tYr4795OQjyTokBHiwSRkcUZLPuJ9Fm20ikt3LP0RxyzLZ7oQEEw9EkPCLSvtda+uT/5jd7HU5KNqsCoLf0Y51oimSgO93jD4OwUJpiHk8QOFaEQ2x5xlowTn2UJmTsOO5m25lfG1/7g3/LUrDHzWlTBEl4FtfT8DagAQTF3eZ2bToehGfD39ITNX9rITIgyKOEHmIqysHt5K0sM3WOYBwDPK7Q5/BrQAaTFKNfqoLHomFYs7a3P/qaM8qjlzvEfngQUJV57HGxfweA4HKwTCIKs63HpaLPHhN7AYYlE51tsT1Kij2y2/5A0dfR7hLXXa935VII8jtUbdfCIf7Oc/T+DGXJ/Os1qV+C9gcpGYXL+uCDZ9cMS2ReJjzQ4BBU0nlGfXCJQ7tIFbG+Vx8kH7UZR4nSp/5ER2HQDjk+KuhjnVn/qJCgPpzjLcRKwzQyYuPAgQb8fB9fSpgan2PVvHvEmyJyG9ngbS/PMkq2Kp1Ip8ienYprHyZJMjq+BAgoPI4JgVv4CT+9EVt5JqFUHmNNldMJ5fcKRdv1wZM8iunG687e70hGhovWaodOSP4b+FjqJHV6pKABW6+Gk0pA7rltCfYi9I6cC9j4hNo6ibNqG0v+vRO/NJhpbTzqWhVpcjBcImA9ioq2w0vZtcd40NDRxtNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(5660300002)(40460700003)(8936002)(8676002)(54906003)(478600001)(7696005)(40480700001)(6666004)(316002)(82740400003)(70586007)(70206006)(4326008)(356005)(36756003)(81166007)(110136005)(2906002)(186003)(82310400005)(36860700001)(16526019)(86362001)(336012)(426003)(83380400001)(47076005)(26005)(1076003)(2616005)(44832011)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:19:51.2046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eecd87e-df89-4a95-9f61-08db67a55002
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8958
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
---
 drivers/cxl/core/hdm.c | 59 +++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 5abfa9276dac..6a97c0227964 100644
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

