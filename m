Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723B25E9E45
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiIZJtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiIZJt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:49:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F28113F;
        Mon, 26 Sep 2022 02:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrHsU9LOv2rIrMXN7sWQrh23bmoI5TFGWLQlDam5xLHkxZK6jTaOuGjzFB/DBbziQR9XEOz1hgYzvOzptjaEpV/dwPwOo+BCvw47avC4KR6g2yZQxUIf53jMv/yrrCvUeRUwjxS0wwJaR50Tr+UVA5iKAfywLsMt6svxfgeRe3j97ArjjUBgAQFqHWeW4n/rzjMhCUTzji9NmvPU4mOtyaGDMHQpqXC/fxjdsom5hofQrYIfJ2JC/JoAsQvYAhEMfxKZZZI6UN5IOK2d1zRVQIydUxfyvqoB/h4rDsSUNg1GBqjhg6USA2VZXWCKt8u75QbQlfWCLuOFrdNFnPyD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yt2SFqLcav+hZ/lBpn/7PhfyM9sb1S7Ki7Fjfdb/ozI=;
 b=C2H1LOGwsbxWYVnSE7Cd6T+nU9zjtyB9V34EBxUlQ4IjG/9oQGLqF5coLKlE24tFBB5nJNqIurezsgMRUl3m5b+ez6lTHU3Enyy4FnXzbHzhebyxEuOFHlL34R9c0Crr9Es+UmL/BUpGhAgzu0fjfbAjOars6nUpR8fgeoEBPLXguJhI6u9GI1HBxc3bU8rL15kV9vnDrUFBT3JJqR9zbmgv1Fau2zoDwB1U6BV+FUruG8UOl6FGs3V/aoiXfGjRPbB0cTv7u7pKAKRful8s7eeVLEI2Mc9abwYui5HqfmsB+8cbztYanixaZZbJkPpewGzU1/BlVEgnW9W4hRWfig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yt2SFqLcav+hZ/lBpn/7PhfyM9sb1S7Ki7Fjfdb/ozI=;
 b=THZH5t+ILN39/Iyt4qsj6h5Y8UuHxgN9VplvNdEgwhARf4/ybQsbBfWqylsGuQ8OtmCecBQgz2IquCbLXgj2bRzsd5UiTuE67+B+NmdO9EJRM3sdQI0PqOGVCY056iCFGeqLYNIXb/y0KS8XMnidhwxbLizMRwuGE0uC5/dej3ULRneRAO/88w73TXgT4Snt2xDU0FoE4L7JkaC3kPjk7Qm7j4vj2A5stDZKc9KijD6OJCgX1mafpp4SmQIdGB9bdm+6PAuJHCVY5I4MYa9V8MNTPYwLWfKNcJYl0HMW417jbtwgk3quR7Unt/79y/G9J+xh3xt+HOvPj9qFN3K3Mg==
Received: from BN9PR03CA0584.namprd03.prod.outlook.com (2603:10b6:408:10d::19)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 09:49:26 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::82) by BN9PR03CA0584.outlook.office365.com
 (2603:10b6:408:10d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Mon, 26 Sep 2022 09:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 09:49:25 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 26 Sep
 2022 02:49:11 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 02:49:11 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 26 Sep 2022 02:49:08 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <p.zabel@pengutronix.de>, <linux-mmc@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <anrao@nvidia.com>, <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        <kyarlagadda@nvidia.com>
Subject: [PATCH v3 1/4] mmc: sdhci-tegra: Separate Tegra194 and Tegra234 SoC data
Date:   Mon, 26 Sep 2022 15:19:03 +0530
Message-ID: <20220926094906.14537-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a964afb-f445-40a7-14b1-08da9fa465dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+dfj5W3YBdHqJvPC6Pj2gf5eHr+EvUX3fUfbMQCcULXcA/nzxBqUmkvdwppGfq/GTpHI0pzMHlCfiwWkXSpfzr5D+AaR+vJi5zKwLeiYGxCQ1x5GoG7YAWJfpdwyy1AR3vcXO4F4hwn+0MD5sC+VvamiluR4Z8Mk80A3LdkixoBH04dFQBDO5lYxUgiMnKAGS9pNYrwt+HfDs7V9vXYTL8KCLW3+UPJ/0QrBr5A64qUELABENDI+zuN+YdwEv3VrMYyndbG5Ng5+ijZeJFGYiy3PGwS03op5XWqiQArVqgHgwuqApVgRIP6xqB1mh55ruHjiWX2ffGbHVZaqRwcg+WVHnl76BFCli4/giBlRkZLUuqP11Y3MbG0lZuH5vNKqeE+nNW7KCRsXkpZ3ZooIDC4FkIZVI9JniB32eedbIye89FO7YbuLaCDjO7XHxuxRNKwA3x0V7UlW+UrBcWKnqdKmV10zvg/2dWpGxEPAP0Z+7hf6LhgN3GhZdbaN1H8l3dv8o481iMWV/aPYPs9JnkOs5W+LECBWSkHjx/WwumFsFoo7yK1HhqOW8b2ZKlrA4SwOVaFdc/uFlHCY+4dw9SeVa3u71yTnnNYcIdJAgoZDzsrquIyZ5Vjfn9WJjNbAc0ySZLDXB8PJL5y0Cz8MhcMfUReXA5t3kBSt7liCQY73UEDT4Ss8zL+8HzmvVKsy8aG6gXVaXoPTRsFqmNvZJmk+fQBPR9jFhRMd/iL1EAUW5PQgzV6UCyx/fQrmIR1AjZJ+3AKWVQ3o/WTWpb1DQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199015)(40470700004)(36840700001)(46966006)(82310400005)(40460700003)(36860700001)(36756003)(356005)(7636003)(82740400003)(86362001)(2906002)(5660300002)(478600001)(4326008)(8676002)(70206006)(70586007)(54906003)(316002)(110136005)(8936002)(186003)(1076003)(336012)(83380400001)(47076005)(40480700001)(41300700001)(107886003)(6666004)(426003)(7696005)(2616005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 09:49:25.6690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a964afb-f445-40a7-14b1-08da9fa465dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create new SoC data structure for Tegra234 platforms.
Additional features, tap value configurations are added/
updated for Tegra234 platform hence separate Tegra194 and
Tegra234 SoC data.

Signed-off-by: Aniruddha Tvs Rao <anrao@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 2d2d8260c681..a6c5bbae77b4 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1556,7 +1556,21 @@ static const struct sdhci_tegra_soc_data soc_data_tegra194 = {
 	.max_tap_delay = 139,
 };
 
+static const struct sdhci_tegra_soc_data soc_data_tegra234 = {
+	.pdata = &sdhci_tegra186_pdata,
+	.dma_mask = DMA_BIT_MASK(39),
+	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
+		    NVQUIRK_HAS_PADCALIB |
+		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
+		    NVQUIRK_ENABLE_SDR50 |
+		    NVQUIRK_ENABLE_SDR104 |
+		    NVQUIRK_HAS_TMCLK,
+	.min_tap_delay = 95,
+	.max_tap_delay = 111,
+};
+
 static const struct of_device_id sdhci_tegra_dt_match[] = {
+	{ .compatible = "nvidia,tegra234-sdhci", .data = &soc_data_tegra234 },
 	{ .compatible = "nvidia,tegra194-sdhci", .data = &soc_data_tegra194 },
 	{ .compatible = "nvidia,tegra186-sdhci", .data = &soc_data_tegra186 },
 	{ .compatible = "nvidia,tegra210-sdhci", .data = &soc_data_tegra210 },
-- 
2.17.1

