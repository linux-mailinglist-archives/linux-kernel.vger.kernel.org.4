Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792496FF2AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbjEKNYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238219AbjEKNXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:23:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2635B3A96;
        Thu, 11 May 2023 06:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKwMKg4k8iXMibFFp5Ic2l0lEHBTdiMKPXJokXwWsGZmAKXjDabF4tcsLm2qOX9KI0KP00OBtJbBMAs3BUHBaHZVKUpGCJyae2+vX8f5G7VNXrj69oql7XaLxfNFIepE8V9PIyd82ImaLdjGYWD55iz3wIs8WyESDMrZ/XS7g09I2lTCyP6R8InRIv/FcQgXW/sR9Ow61X9H0RAeVOb5IJifYehlWnDt+qiHNxxy/7048pm8N/im4ax4VRYlqNs3xNdExe6TEaBZoB43qNahj26kRKWQZghjejOE87+ARBYLuN7Y6INhMOVav90JI/q4IBMiYxsBY2E0FMHH51Fv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEN/aSOntME/JNvSbAySb4c+n1lbmBLiaBlMgbkl68Q=;
 b=G99HTl4Xtli3YRvZ/ydEnYIxz3F0YxcCVFO84gUVtfSrrZZBTZvxvt5S2NSdhLdhb44712wvOmrtBPAFjsApa+IP07J5nwAbCeGM3rgWXBYSUBSSVlPdm7OX9w9w4UwLN9gMjJByamDFwEPBtD7we5kVA6DlLW/jJc5b1K8jenUQt0E+egAs/bRdfz99QsEZ93Hk/W5xN6ofrQoaRZ9WC4yL7WC1Y5KEk/RLEDvh/i6eGWAAMeLg4OAlTGO+LiXjrFMVf+61bgQt3Snyg9bNn1ExvyXFoh+gF+9t0YWf3l8PqNxtCUQSNhatcq8BlTMxwI76ctAZ0bcIxWI0abpnNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEN/aSOntME/JNvSbAySb4c+n1lbmBLiaBlMgbkl68Q=;
 b=BVXEMirJPlAN4UneVnYOIY6XGXbrL5dDpJ8C2WHjhLZwjyYTnoMWoIujlyyMkVAHbvkte1FkL6dOzqrUpvCDTw5SiXnp3WXkE9z4pVQHV1QHzNM3jX97ZiyTbbJ791s3RJDhvwYD+x+iWkZzNpQcxdVYo5ESfpJVV0lLX4Y/bgfW6OYSSCCS9ZJr49gQfjKbuk0Ork/28SFKq4j+OjynZCxY7eHvYdWHtlehiCljPI9uO1cXs+VoRfOl3p2UUn54c8krNApiQURSIRJTUtc2DLyFMxzVipEjilEYuQO7Vis0zMtTF/SeZHVdDebPr2rrov6RQY+1iFY/mMxmOfiMqA==
Received: from SJ0PR13CA0023.namprd13.prod.outlook.com (2603:10b6:a03:2c0::28)
 by DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.21; Thu, 11 May 2023 13:21:34 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c0:cafe::22) by SJ0PR13CA0023.outlook.office365.com
 (2603:10b6:a03:2c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Thu, 11 May 2023 13:21:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.22 via Frontend Transport; Thu, 11 May 2023 13:21:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 11 May 2023
 06:21:23 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 11 May
 2023 06:21:22 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 11 May 2023 06:21:20 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     Stefan Kristiansson <stefank@nvidia.com>,
        <jassisinghbrar@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v4 2/6] mailbox: tegra: add support for Tegra264
Date:   Thu, 11 May 2023 16:20:46 +0300
Message-ID: <20230511132048.1122075-3-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
References: <20230511132048.1122075-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: f1c75767-a588-4b01-dafa-08db5222a44e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wc4M9iZ9gMmmrlgecg1yAsmAlu2PgMBQ7YXVQ48W4do0vHn12sCkeP1vktcsFSu3h6XtnpxFHJJrgOEtRnXrRCykOkIZGj4M+LxQksJmubP0MUdo9/ezU/o4evnd31iT1RS5oJqWdpphmGYkZH0YJlkB2scK8bvEHlJ+6Fbjg18IwisVppeZ2q76NnOfd7+f/y7qrbxWR/FH/tBWWd1lEOIVrnDiYeyH7qFyIvQlNQyupGKWE/NjET/aA0ZszzegoFGzePi9ZV4bauGL18GlqIcD1Z/LtuR2xkNmbZAly7+j67wf0qg+KahdFUVG8AHFuMHfMmexkvcFoLhV+rQMv2foTWIaIb8DfWk7Rq6bq8y4jq8jMB7Z0BAdi3Wv50SJhgdRvfXiNZhgaJTSLtAFrpZ/6++qGV27PzGLfFxtXYhcrNyVGrsDVW+arxV8ZbfIZNbFmdu3KxKKra68RLpM83ZeM3cXaERM5G4VK2dPKDanogsZIRz9m5taXFj2AQCc3ifb+0MoKYa7vlGwwnhCY3QQQIVloaAPsi+0A+u+M/nC0NbbKE74HH78e7Oa+FnKxK9vCv4dprrstfjpQgo6TQS4aoyyopaKBuikkeFMYcDX5qDS6sEOM0w7BqCWcUcCHpMeTIWr3Re+J8vhPzg+wb/ft5tCGZbZ8aRfnF8J0Mb1uwVHQeZWcyBfoXExn96V1xI+Y66iDGxG9dAPANzIQt6Zu+DhUoRS7zelwFmP1n9JJ0qEoGn3JBZzceNn3Qbx
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(83380400001)(36860700001)(1076003)(26005)(41300700001)(5660300002)(2616005)(8676002)(8936002)(2906002)(47076005)(15650500001)(426003)(336012)(4326008)(82740400003)(70206006)(356005)(40460700003)(6636002)(7636003)(70586007)(316002)(36756003)(86362001)(6666004)(186003)(478600001)(40480700001)(110136005)(54906003)(107886003)(82310400005)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 13:21:34.0335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c75767-a588-4b01-dafa-08db5222a44e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Kristiansson <stefank@nvidia.com>

Tegra264 has a slightly different doorbell register layout than
previous chips.

Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Stefan Kristiansson <stefank@nvidia.com>
Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/mailbox/tegra-hsp.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 573481e436f5..7f98e7436d94 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2016-2023, NVIDIA CORPORATION.  All rights reserved.
  */
 
 #include <linux/delay.h>
@@ -97,6 +97,7 @@ struct tegra_hsp_soc {
 	const struct tegra_hsp_db_map *map;
 	bool has_per_mb_ie;
 	bool has_128_bit_mb;
+	unsigned int reg_stride;
 };
 
 struct tegra_hsp {
@@ -279,7 +280,7 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
 		return ERR_PTR(-ENOMEM);
 
 	offset = (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) * SZ_64K;
-	offset += index * 0x100;
+	offset += index * hsp->soc->reg_stride;
 
 	db->channel.regs = hsp->regs + offset;
 	db->channel.hsp = hsp;
@@ -916,24 +917,35 @@ static const struct tegra_hsp_soc tegra186_hsp_soc = {
 	.map = tegra186_hsp_db_map,
 	.has_per_mb_ie = false,
 	.has_128_bit_mb = false,
+	.reg_stride = 0x100,
 };
 
 static const struct tegra_hsp_soc tegra194_hsp_soc = {
 	.map = tegra186_hsp_db_map,
 	.has_per_mb_ie = true,
 	.has_128_bit_mb = false,
+	.reg_stride = 0x100,
 };
 
 static const struct tegra_hsp_soc tegra234_hsp_soc = {
 	.map = tegra186_hsp_db_map,
 	.has_per_mb_ie = false,
 	.has_128_bit_mb = true,
+	.reg_stride = 0x100,
+};
+
+static const struct tegra_hsp_soc tegra264_hsp_soc = {
+	.map = tegra186_hsp_db_map,
+	.has_per_mb_ie = false,
+	.has_128_bit_mb = true,
+	.reg_stride = 0x1000,
 };
 
 static const struct of_device_id tegra_hsp_match[] = {
 	{ .compatible = "nvidia,tegra186-hsp", .data = &tegra186_hsp_soc },
 	{ .compatible = "nvidia,tegra194-hsp", .data = &tegra194_hsp_soc },
 	{ .compatible = "nvidia,tegra234-hsp", .data = &tegra234_hsp_soc },
+	{ .compatible = "nvidia,tegra264-hsp", .data = &tegra264_hsp_soc },
 	{ }
 };
 
-- 
2.34.1

