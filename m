Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED5E6D9EA0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239990AbjDFRVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239653AbjDFRUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:20:18 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6197E8A7B;
        Thu,  6 Apr 2023 10:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JuY/NT2lPSYolyHZeCBZVJxFcTQC6oGB+l92rimfQd6VNC3rKTostCNfmdmuycMwizhLxWyPku5cMObwdEnqGw3ZkZjUGICznixSWj8zYGgdWxbm2CZ2DTLQaSyRfL2uG07HNx2y832uvO8A08pLEaYHLozTWQcYWIio04V1Ynw962MpC61++L3gbzX+a5vzz8cDTMBHoX2oVUfAahY5UonFtqTAyqX/YdKOQhjrOfZatatFF45aXhVQYHpBw7FMmPEsTnNxW5ANKgXg4neOHHoFd9k0O+4ZVxAIhXD8v2KSu+J3nDyQjO3hVxDfPKkFGZYfm24GsS+83DcMIggoig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2CJuSdgjUz5SfX6G1RySck3/wEeQCdulMwW76h6I1M=;
 b=Y7bti4wtyH0lPrn8IbTXTu9rWHXrp9cM8xpbigGubI3e08NW/X4cl14vMvIyfiN36ZLv1GsEstO8yoII7NDdImxa7Lrx1hM5xLsTYeeLNvkDi01s4hp0rBKus0ZfQr0ZlPfBoJvhSTRGYFCnj8+lVjfMKpC8zWKryG9ywLOJui1gqXaCUs1twripZQVMPjBTCIWyz28G8B6rcHQSaqpmlxVAGU4a07YdbxbwCTEHvJztj9JW+4Eg3mY8325gt5JQKhyJMtJrJIoJBxyu8YXNSZPApBP/75wXnmgBrPGNsAvKmPVXQcB+xnLOdxRVUXViI85nwEBkYISPZJ9ABnnOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2CJuSdgjUz5SfX6G1RySck3/wEeQCdulMwW76h6I1M=;
 b=Chy9d92hTpcsyIs2SS5UcMQV3GPBLqpuHddCwcnlyYJJ6FSaIBEs10XTVpuBPDBN35BEsnxpHF3YSnObpMlq46OUo931wlKpqsvBZj4jlMym/8cijJawsshtRaFFzCoyZxdzIQgwgq8brUS8IypRiuOxZPMYkga1RlQt43kRW++KO5OegKe3+AFHwaSp7Sj72J+ULC+Kd5RIZVY6NHmXLnDEr7AUP+4qrVnOv/Ca1xeTTVlO31e0rDBBLgwkYMZ0awjs2TsSFKPJFa+sDr124QmGijxb51QvtV+4uPhDMvA7YsS97Srb1Ys+lbY0DY6G82w6SlQdWRGUNaKL6fiecw==
Received: from BN0PR04CA0074.namprd04.prod.outlook.com (2603:10b6:408:ea::19)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 17:19:11 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:408:ea:cafe::80) by BN0PR04CA0074.outlook.office365.com
 (2603:10b6:408:ea::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31 via Frontend
 Transport; Thu, 6 Apr 2023 17:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35 via Frontend Transport; Thu, 6 Apr 2023 17:19:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 6 Apr 2023
 10:18:42 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 6 Apr 2023
 10:18:42 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 6 Apr 2023 10:18:42 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V5 08/10] hte: Deprecate nvidia,slices property
Date:   Thu, 6 Apr 2023 10:18:35 -0700
Message-ID: <20230406171837.11206-9-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406171837.11206-1-dipenp@nvidia.com>
References: <20230406171837.11206-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: a36308a7-548a-41dd-1eb2-08db36c30998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKgdtZuYpuEd3Ht24U9eLpaD0Fc68N74Fd2JKa/gYUyu5d79EaOUje/rOETyvyr1dId7oS66QtscHDV75NPTqqo1slc0cnModpxs3e0ARcRgEUdsx5fcPfeaq2+o3J+WCwDw7GPLNXsU3zhfH2i5RLrLtdgsl24gLJAHcFKlZtjq8ctHu0VBXaWcSyuCvwguX92KxS2nKfDPIFekuMC/kbBR8bvBecvl+G0YiZq2Uo5E46pHLTsE1n+GW4D5pw7ncG7K4AfpYLzBc8HYvGNmPcCK2NHNP3wIy5QqzpUrHo1oEHinoeqVDGGmrIT38zcEVX/Ajjoa0KED8Hqs9TGqlCYMu2dNUZ+/OcSAvvH5AlGyNWq7xy+avAu9cGoY4ilxjslDLSHuqQ8/7V3JBJmrRKczyK/gxjZKHJmkyfsZM3JD5+Q80KqmHgOFT/aHHx48NIjTozZiI30WoK8fcsv9b9iamEXrqDcSj9+BrfAsyKGvei24MVwuCdeJtOo4NUOGW9A+Fy5yU61h8juCcCOXw6uzUl6PvBrM6Wece9dfaUCFNggfmU9TxThL5pYNQsfh+KtNBDSASWtKhXJNJKLSYCeq6SUQbDTvFoQmt1ZHhd1NwQyrfXCDj3qQF53+owCFEQqozMjloxt9ZTKL++X20U9qgI0yWjQZriC7RC0cEFmqxvf7er5EhscTdhMiRqjIxUpQRV7U3cxfX1cPn+yY6bnmfWUtLSX+/WIN5WcJSMoEFzYGAueCdGowzwHM5JHBDo6Pl0lSIG80IjFUovWfBB4NbaTfMyiA8ZXrVFUkcqoDrtO1kJI047qIgYTMgtpe
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(36840700001)(40470700004)(46966006)(36756003)(86362001)(82310400005)(2906002)(40480700001)(7696005)(2616005)(36860700001)(6666004)(186003)(426003)(336012)(47076005)(83380400001)(26005)(1076003)(107886003)(82740400003)(4326008)(70586007)(70206006)(8676002)(40460700003)(478600001)(41300700001)(7636003)(356005)(7416002)(5660300002)(921005)(316002)(110136005)(8936002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 17:19:10.8512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a36308a7-548a-41dd-1eb2-08db36c30998
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The relevant DT bindings deprecates nvidia,slices property from
Tegra234 SoC onwards, moving the slices value per SoC data structure
instead.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
---
 drivers/hte/hte-tegra194.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
index 5d1f947db0f6..945c68c5e476 100644
--- a/drivers/hte/hte-tegra194.c
+++ b/drivers/hte/hte-tegra194.c
@@ -118,6 +118,7 @@ struct tegra_hte_line_data {
 
 struct tegra_hte_data {
 	enum tegra_hte_type type;
+	u32 slices;
 	u32 map_sz;
 	u32 sec_map_sz;
 	const struct tegra_hte_line_mapped *map;
@@ -323,6 +324,7 @@ static const struct tegra_hte_data t194_aon_hte = {
 	.sec_map_sz = ARRAY_SIZE(tegra194_aon_gpio_sec_map),
 	.sec_map = tegra194_aon_gpio_sec_map,
 	.type = HTE_TEGRA_TYPE_GPIO,
+	.slices = 3,
 };
 
 static const struct tegra_hte_data t234_aon_hte = {
@@ -331,12 +333,21 @@ static const struct tegra_hte_data t234_aon_hte = {
 	.sec_map_sz = ARRAY_SIZE(tegra234_aon_gpio_sec_map),
 	.sec_map = tegra234_aon_gpio_sec_map,
 	.type = HTE_TEGRA_TYPE_GPIO,
+	.slices = 3,
 };
 
-static const struct tegra_hte_data lic_hte = {
+static const struct tegra_hte_data t194_lic_hte = {
 	.map_sz = 0,
 	.map = NULL,
 	.type = HTE_TEGRA_TYPE_LIC,
+	.slices = 11,
+};
+
+static const struct tegra_hte_data t234_lic_hte = {
+	.map_sz = 0,
+	.map = NULL,
+	.type = HTE_TEGRA_TYPE_LIC,
+	.slices = 17,
 };
 
 static inline u32 tegra_hte_readl(struct tegra_hte_soc *hte, u32 reg)
@@ -639,9 +650,9 @@ static bool tegra_hte_match_from_linedata(const struct hte_chip *chip,
 }
 
 static const struct of_device_id tegra_hte_of_match[] = {
-	{ .compatible = "nvidia,tegra194-gte-lic", .data = &lic_hte},
+	{ .compatible = "nvidia,tegra194-gte-lic", .data = &t194_lic_hte},
 	{ .compatible = "nvidia,tegra194-gte-aon", .data = &t194_aon_hte},
-	{ .compatible = "nvidia,tegra234-gte-lic", .data = &lic_hte},
+	{ .compatible = "nvidia,tegra234-gte-lic", .data = &t234_lic_hte},
 	{ .compatible = "nvidia,tegra234-gte-aon", .data = &t234_aon_hte},
 	{ }
 };
@@ -679,13 +690,6 @@ static int tegra_hte_probe(struct platform_device *pdev)
 
 	dev = &pdev->dev;
 
-	ret = of_property_read_u32(dev->of_node, "nvidia,slices", &slices);
-	if (ret != 0) {
-		dev_err(dev, "Could not read slices\n");
-		return -EINVAL;
-	}
-	nlines = slices << 5;
-
 	hte_dev = devm_kzalloc(dev, sizeof(*hte_dev), GFP_KERNEL);
 	if (!hte_dev)
 		return -ENOMEM;
@@ -697,6 +701,13 @@ static int tegra_hte_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, hte_dev);
 	hte_dev->prov_data = of_device_get_match_data(&pdev->dev);
 
+	ret = of_property_read_u32(dev->of_node, "nvidia,slices", &slices);
+	if (ret != 0)
+		slices = hte_dev->prov_data->slices;
+
+	dev_dbg(dev, "slices:%d\n", slices);
+	nlines = slices << 5;
+
 	hte_dev->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hte_dev->regs))
 		return PTR_ERR(hte_dev->regs);
-- 
2.17.1

