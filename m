Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C391E714B40
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjE2N5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjE2N5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:57:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20625.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::625])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB78E7C;
        Mon, 29 May 2023 06:56:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5vzuhcODNyZWmyX/+OB44WZzft3FoDO4mXt+z51a9yOn4Qa0conFA0f+iSBcvAYlZjwtvePEHQL2D61JIbYepOfxdGzj0B291y+msmT0n4lYKDsSgD27IY20lFCz6ZaNJ17uI74OuYDYHsSLyhRL0ftSzttPkzKCbKx8JgF6cmQO6zivGqgpcZe+LB6xuvkziuWLbedm45I0z2JyJSzLsW00tZw8hb4zDbZ8LBJ46QbumSk/SUnLCscUqUc1hzl9zYpA4eZ0BkLYzhsDyZZ/5qkD1LTagyVKoFAUojWjWgSqSTe64K4kbouJI0regbKda24IWOp/Clu6JPv7ubG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEN/aSOntME/JNvSbAySb4c+n1lbmBLiaBlMgbkl68Q=;
 b=dVUeTgKdD4Z8X3cp+wqM2bdFR5EPVpySrUumF53yo6co1xJu61S2qEEE18toYwXwMCR9Q4zOqnVrtJqBzikVf5ENRum9yBlEj7Cwwt2QhDKE78e29o9J+I5LywPOMa9Uwk8/mCXiP7SJda0cwzFchiWVk1xMm2yG9WdkGSgm+2+DeHdbooS59omqi3NIdf9oBUinCP3zpI8hVEAk/UVDoQG4pA5K6Mxdv6V9b6t8R2YvIlOAntBUbg556vlmBP+VnnxHR71O6EBEVfqBmJAru0csTqpX5GJY27jEPa2BDKap2MEvA9xpT6709lAIiXUvSydGIgCm85lu7xS/TQKcaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEN/aSOntME/JNvSbAySb4c+n1lbmBLiaBlMgbkl68Q=;
 b=saaFWRNf8qTjFNHoDFC7xzv/NTNSSDs2TSbeMak/sxTARCyooJTg6Htz/cxSfgxkUM3rpJ/NWV/t9X5gFQngvG/bdoKKqhjFCpJuZE8oFPF86ZrCL+BHSFyQrPn71Nzjx/xtZobt/jSoL3lAcv34TzwIJ0QaudzD31oLHO8gmQkYH+aXENIBejlPyfXUhsxMV70Zf2lafBE+kea7fEgypi9TyYX4qsFg8Ct3LKzzqVPEmT8ZTAwXkaI1MFaMfKZgUki6QWwc6qxrgen4hBBTkrqP/ZLBxQ8OxxnemRB8Yxni6DZqCbwyt5PrHvKCsKYj9r3rFLKX85vZDDPyf55NxQ==
Received: from MW4PR03CA0296.namprd03.prod.outlook.com (2603:10b6:303:b5::31)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 13:55:57 +0000
Received: from CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::99) by MW4PR03CA0296.outlook.office365.com
 (2603:10b6:303:b5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Mon, 29 May 2023 13:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT116.mail.protection.outlook.com (10.13.174.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.21 via Frontend Transport; Mon, 29 May 2023 13:55:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 29 May 2023
 06:55:44 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 29 May
 2023 06:55:44 -0700
Received: from 44189d9-lcedt.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 29 May 2023 06:55:41 -0700
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>, <stefank@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Joe Perches" <joe@perches.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
Subject: [PATCH v5 2/5] mailbox: tegra: add support for Tegra264
Date:   Mon, 29 May 2023 16:50:45 +0300
Message-ID: <20230529135044.2746339-3-pdeschrijver@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529135044.2746339-1-pdeschrijver@nvidia.com>
References: <20230529135044.2746339-1-pdeschrijver@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT116:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc6f0d4-e358-4d8f-47db-08db604c6d4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: evNg9xH10tM0c8xfmDpaf+yWZyyM9S9qnSSlmYiW7geu/hE7yA4GCwZwPM+LGngeB/PLMKXRHwov5hrFtR8mYqul8FrTNN8RYvSi+AFYGTkVTOYVr4nyZot8lpenf9M30nzQuUJDv6syOT6htdl7KBpTtGQxNwnGYzx/+QckrDR8VfI0kpldjw5GOXNjlLzRmQvFZ+2SOi54rQBt0YIyWpUY8RQg8NOH2SlJuXvbGPw+jpMXnccihWk4kvTX67IN2ScbeuLyJXSJF9rFi8VUOvVylMoPCs+7ZsIbGsIECtW5Uz3Ion9Hhl6zmY/PvTp/jWV9vF7YPRr2biXEkMTkbz+rBX4maTh4/Es8Y9zdfBnhIwF5FciP0cNizJ1W+zR2uoiwYncuD4Yk4ceImjv6mIyxzWwKfzGSqAj5tX2C0Ks5w9DTdv/FVylkAbdu+OtTlZ4wL4MYSFFOrRdwlyA+gayfklN87ChVvSp+sB1dPF5VKjcIevIINu6hGNCFNGkiBtzN4ulcKwLpZzOQAnWmfk35vnzxqezWIaQExCFhbZD59sVzCw052U3NgQ78s1ffG+zKqchYNwBCXCtI5pUXio1mIAoxMjVoXmCJpJLX5lZXZw7umJleFFz+zbj1dzzLufo1rg6loABq4EB6Kedws+a9YEn6WMaNXaVHyuBPTedzN6QN8lf1F83Tl6b2Fk/6WYgos3yhXcBNwK4dQUy6MJKfoW+54aEVbh6DG0ZwazZCxWHKGCTCPrfSujnVtDdj
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39850400004)(451199021)(40470700004)(46966006)(36840700001)(2906002)(186003)(15650500001)(1076003)(36860700001)(107886003)(5660300002)(82740400003)(8676002)(8936002)(54906003)(478600001)(110136005)(356005)(7636003)(47076005)(336012)(83380400001)(26005)(2616005)(426003)(86362001)(7696005)(82310400005)(41300700001)(316002)(70206006)(70586007)(36756003)(6636002)(40460700003)(4326008)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 13:55:56.8991
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc6f0d4-e358-4d8f-47db-08db604c6d4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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

