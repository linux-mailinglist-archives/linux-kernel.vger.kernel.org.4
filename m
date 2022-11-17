Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687CE62D513
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiKQIdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKQIc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:32:58 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2203657E1;
        Thu, 17 Nov 2022 00:32:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kn1LoSkT5tuPGU/MSHO1Dz5NUoT2D+6kplC9jbAkY90/yyX1vRYBRBSord9bbHOubwE81ZB5l4rrQj7YrlkQKWDBVvMHJlaCfGWjH7OneSBzL2YErgE1KGmDIwLziOXprufAIAr4NJpFbrkZ5n00KaHTT/cvOMNTu6yhduk2nJYtuSjn80tmoUlUBTliBKn3OzbXneNUHB7lQYXiG9bkYP4aJ+7Ct8qkk39A1a4/brtO0ru9PkqgLGBqSwHvCbOCvXpkMNhdnVEKTLwbtD6LrRbN6+dq31t4yWTC3gef5oVG9LUGhO3d15VNejkhlMzmIjieJ7ABfNfm+1jtGqMfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmXzJ92JDqTq+hUdcoHN8sWObry34wVBmqmWu1Wtohw=;
 b=LcpErL59ujQ49mLyW0YiuesMw1MiGPFv5etRZh+VzifhgYsZ51PkVLjpt3VyRih0m//DviZIGME9vMTSzh6yDOjxGGhf0Ocl/Y68C5JwiNaGx2c+Qt6GmCUSjBNOLSAeurZ4qBC6zdBYCgvxWqnldnDhIIkYXsOin6pFs1lsWWN9k6yOjhcJiYpv91QLpwRSAWIKZUB9mOcbiomj6Q5RiW7bg46bXQOXI5KHiyCD+tHVgYhQ9v/Ewdh2v/H2/a3xffOWeYUKqSREHGh/vaYUkTWYZH8YHU558KotzzydqKpChIylLAHxUNGny7dibCntlLVbfKKVmqsz8aygfDPwNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=roeck-us.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmXzJ92JDqTq+hUdcoHN8sWObry34wVBmqmWu1Wtohw=;
 b=V4YaVz7zDJmYDy4k4v4pipQZEnVvAuZ4Cq11v7fseQISs56F1hGlTbM4Lyk/AZZH1xFxsaFlOJvpsk6FbMWnUyarJIRbuvou0bbdrxiNC41gq6PLd1hCyWRC/PUU/x1Om7Wo2SNn/zh1urd5Bj4XL2O2xoVyRu03qWDEZVJP1ZyT4mm2GJ47Sd90nX06e78KeyU73hvSc97PTGfFIYjbv/vJjRnB1HaP+CM7LhJhXFa0KwVvmoL3QRiMwmObXH7tIwuaDSWIiUmjZnzx8bwZlAe2TxBDLZivAqEAjZiWWoCfYy084rVIfA5DEV4T2VgU0u1GoawKGQ2YNHMpGsMMxQ==
Received: from DS7PR03CA0153.namprd03.prod.outlook.com (2603:10b6:5:3b2::8) by
 BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Thu, 17 Nov
 2022 08:32:56 +0000
Received: from CY4PEPF0000C966.namprd02.prod.outlook.com
 (2603:10b6:5:3b2:cafe::27) by DS7PR03CA0153.outlook.office365.com
 (2603:10b6:5:3b2::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Thu, 17 Nov 2022 08:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000C966.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.11 via Frontend Transport; Thu, 17 Nov 2022 08:32:55 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 17 Nov
 2022 00:32:43 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 17 Nov 2022 00:32:43 -0800
Received: from nmalwade-dt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 17 Nov 2022 00:32:41 -0800
From:   Ninad Malwade <nmalwade@nvidia.com>
To:     <nmalwade@nvidia.com>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux@roeck-us.net>, <jdelvare@suse.com>,
        <nicolinc@nvidia.com>, <rkasirajan@nvidia.com>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH] [WAR] hwmon: (ina3221) Apply software WAR to offset shunt voltage
Date:   Thu, 17 Nov 2022 16:32:26 +0800
Message-ID: <20221117083226.20027-1-nmalwade@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C966:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bfc91e8-6a6b-45d2-4afc-08dac876535f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5lxiPrVunREjGi1nIlfaqDWxBZP4H2W/kooIminWtQ3LE7X6bESYWAZSmXTmL6MOETOrnVFo26rs0F4GiA7oQggReLYv9hTyDs7l6ZZsQXN6UT8R+1tKGRcWHPJQ+ZXGiEozsk11pDSdESF41b0vAA3YPAeeKNNQlW11QyRqyJUWZ31yq6RJW8P/2LsU9ZgLy4yBjHpkkjdNm1OlylSqa895EodmhQ7qkE+J206lq4NZt68znat9yAulQqZwVoACWZUC2LOVHtxiV1YWuEVFGb+DhLk/33lI4Hs8/52ymBXdPOyYMbXDh7yqmLn/M3GgLk2hapckkSlsvvOOs3R14b6OL30rwerktJJtQAg81QBj/kvucqqbmoqcBv3Ph6D5h6Fa+5oAQn4WLl2BXYptXmQd0HqTWwAbx+pBld8vu6Y5ZUKyI48lWQgGUsJ11VVTQog6m947EXzRKFo9r0B49bKxjyHR4/jOkHVbJsCNUx2gtClk8e3MJEtlLDWausuaQhKlqWce+a8x0Shyt3YW/PR9bo0NSrAwg5Df+etPd/3Ogjw/Qc+l5lxEpOJ+C4oN4PyxQhYfft7RAC22yLK12Lkpz45E018m5JpuNLTmyIffLM3zK8Soa5LixUakGB5g3yjTgRDAacef41q1FX5vnjkrBNY3KxQ+gQ/9iShcd21yxo1ARaU2dslm+xaVfLMc9VeMvfOBt9/95H5aNy2FAg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(8936002)(41300700001)(2906002)(5660300002)(316002)(70206006)(478600001)(70586007)(36756003)(110136005)(6666004)(8676002)(4326008)(26005)(47076005)(7696005)(86362001)(426003)(82310400005)(83380400001)(7636003)(40480700001)(6636002)(54906003)(36860700001)(40460700003)(1076003)(2616005)(356005)(336012)(82740400003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 08:32:55.5702
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfc91e8-6a6b-45d2-4afc-08dac876535f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C966.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used as a software WAR to offset shunt voltage reading
from INA3221 to increase its accuracy. This patch implements a
previous downstream feature by reading the offset information
from DT and apply it to current readings.

Signed-off-by: Ninad Malwade <nmalwade@nvidia.com>
---
 drivers/hwmon/ina3221.c | 141 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 137 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index e06186986444..726c8b99b8cd 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -94,13 +94,39 @@ enum ina3221_channels {
 	INA3221_NUM_CHANNELS
 };
 
+/**
+ * struct shuntv_offset_range - [WAR] shunt voltage offset sub-range
+ * @start: range start (uV)
+ * @end: range end (uV)
+ * @offset: offset for the current sub-range
+ */
+struct shuntv_offset_range {
+	s32 start;
+	s32 end;
+	s32 offset;
+};
+
+/**
+ * struct shuntv_offset - [WAR] shunt voltage offset information
+ * @offset: general offset
+ * @range: pointer to a sub-range of shunt voltage offset (uV)
+ * @num_range: number of sub-ranges of shunt voltage offset
+ */
+struct shuntv_offset {
+	s32 offset;
+	struct shuntv_offset_range *range;
+	s32 num_range;
+};
+
 /**
  * struct ina3221_input - channel input source specific information
+ * @shuntv_offset: [WAR] shunt voltage offset information
  * @label: label of channel input source
  * @shunt_resistor: shunt resistor value of channel input source
  * @disconnected: connection status of channel input source
  */
 struct ina3221_input {
+	struct shuntv_offset *shuntv_offset;
 	const char *label;
 	int shunt_resistor;
 	bool disconnected;
@@ -329,7 +355,7 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	struct ina3221_input *input = ina->inputs;
 	u8 reg = ina3221_curr_reg[attr][channel];
-	int resistance_uo, voltage_nv;
+	int resistance_uo, voltage_uv;
 	int regval, ret;
 
 	if (channel > INA3221_CHANNEL3)
@@ -362,10 +388,34 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 		if (ret)
 			return ret;
 
-		/* Scale of shunt voltage: LSB is 40uV (40000nV) */
-		voltage_nv = regval * 40000;
+		/* Scale of shunt voltage: LSB is 40uV */
+		voltage_uv = regval * 40;
+
+		/* Apply software WAR to offset shunt voltage for accuracy */
+		if (input->shuntv_offset) {
+			struct shuntv_offset_range *range =
+						input->shuntv_offset->range;
+			int num_range = input->shuntv_offset->num_range;
+			int offset = input->shuntv_offset->offset;
+
+			while (num_range--) {
+				if (voltage_uv >= range->start &&
+				    voltage_uv <= range->end) {
+					/* Use range offset instead */
+					offset = range->offset;
+					break;
+				}
+				range++;
+			}
+
+			if (voltage_uv < 0)
+				voltage_uv += offset;
+			else
+				voltage_uv -= offset;
+		}
+
 		/* Return current in mA */
-		*val = DIV_ROUND_CLOSEST(voltage_nv, resistance_uo);
+		*val = DIV_ROUND_CLOSEST(voltage_uv * 1000, resistance_uo);
 		return 0;
 	case hwmon_curr_crit_alarm:
 	case hwmon_curr_max_alarm:
@@ -758,6 +808,84 @@ static const struct regmap_config ina3221_regmap_config = {
 	.volatile_table = &ina3221_volatile_table,
 };
 
+static struct shuntv_offset *
+ina3221_probe_shuntv_offset_from_dt(struct device *dev,
+				    struct device_node *child)
+{
+	struct device_node *np, *range_np;
+	struct shuntv_offset *shuntv_offset;
+	struct shuntv_offset_range *range;
+	s32 start, end, offset;
+	const __be32 *prop;
+	int ret, num_range;
+
+	prop = of_get_property(child, "shunt-volt-offset-uv", NULL);
+	/* Silently return for devices with no need of an offset WAR */
+	if (!prop)
+		return NULL;
+
+	np = of_find_node_by_phandle(be32_to_cpup(prop));
+	if (!np) {
+		dev_err(dev, "corrupted phandle for shunt-volt-offset-uv\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	ret = of_property_read_s32(np, "offset", &offset);
+	if (ret) {
+		dev_err(dev, "failed to read general shuntv offset\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	shuntv_offset = devm_kzalloc(dev, sizeof(*shuntv_offset), GFP_KERNEL);
+	if (!shuntv_offset)
+		return ERR_PTR(-ENOMEM);
+
+	shuntv_offset->offset = offset;
+
+	num_range = of_get_child_count(np);
+
+	/* Return upon no sub-range found */
+	if (!num_range)
+		return shuntv_offset;
+
+	range = devm_kzalloc(dev, sizeof(*range) * num_range, GFP_KERNEL);
+	if (!range)
+		return ERR_PTR(-ENOMEM);
+
+	shuntv_offset->range = range;
+	shuntv_offset->num_range = num_range;
+
+	for_each_child_of_node(np, range_np) {
+		ret = of_property_read_s32(range_np, "start", &start);
+		if (ret) {
+			dev_warn(dev, "missing start in range node\n");
+			range++;
+			continue;
+		}
+
+		ret = of_property_read_s32(range_np, "end", &end);
+		if (ret) {
+			dev_warn(dev, "missing end in range node\n");
+			range++;
+			continue;
+		}
+
+		ret = of_property_read_s32(range_np, "offset", &offset);
+		if (ret) {
+			dev_warn(dev, "missing offset in range node\n");
+			range++;
+			continue;
+		}
+
+		range->start = start;
+		range->end = end;
+		range->offset = offset;
+		range++;
+	}
+
+	return shuntv_offset;
+}
+
 static int ina3221_probe_child_from_dt(struct device *dev,
 				       struct device_node *child,
 				       struct ina3221_data *ina)
@@ -796,6 +924,11 @@ static int ina3221_probe_child_from_dt(struct device *dev,
 		input->shunt_resistor = val;
 	}
 
+	/* Apply software WAR to offset shunt voltage for accuracy */
+	input->shuntv_offset = ina3221_probe_shuntv_offset_from_dt(dev, child);
+	if (IS_ERR(input->shuntv_offset))
+		return PTR_ERR(input->shuntv_offset);
+
 	return 0;
 }
 
-- 
2.17.1

