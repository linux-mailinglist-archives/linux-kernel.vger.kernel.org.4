Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94616C5C13
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjCWBaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCWB3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:29:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDF13C2D;
        Wed, 22 Mar 2023 18:29:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HALSNvY7cYdC312o1A771dZ3skeUl2Z5P7nSHVkGFqIj/jsM7xPczyhYqMUO9LfEf4jNVrOCaxZ6ghBJQX0AMh4Tyt5VVIFCiBd2r7V3MQy8O84UvU/Q5Lk+IK3vVhaMbqs2vrDxfyM4aRcm73gsVlE2nVTz3en8j91Cz+BvGOLATXRQ1jcdGEKrRtRd+gwHT6iNVF5J//zQHcQShu1X+qj2u3C3czpvhee/KXHo1YaB7RQd5PM03geZ2TRLZ5sM6NSDdidAM1TVZ0v9RupLqwkv25th03IEH4tgky79qMhbEH4yQLtfNWC25uNp00fTdLodLkxX4jkGyED2iEaLMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2CJuSdgjUz5SfX6G1RySck3/wEeQCdulMwW76h6I1M=;
 b=BF/atmIVOO/cvVNSdKyuG0bZQERpoIXNHUCUIemycoRW7Cq6TSguivJdT+zwvdCHuo51aHzlq4Ti59e6S7EqEELfbpo1EXcvBhYQlPLJNwUfJuZjqbiFkwfJ0kNr442XkSM5xLVIYwzM7fHGCtusQPfWE+YpoF2MnTgwxEKi9JJMjoRmgs+2H2smVQmXjYRYSlz2U3aK02fwTzE4Ek6JgKeG5riMaG/Zl8rvY0QmeDfs+XNnyqaQ11ZliNg62SZ73H/tol8w78UWe90VKc9LSvIiSBdL1Ly1GGE2fnVNsm5tQhy7Ye6YNDAq1IvWp8A+9uWh+7qHfFJF+WvDqwH3Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2CJuSdgjUz5SfX6G1RySck3/wEeQCdulMwW76h6I1M=;
 b=OcAJCCvN8U5G0/VlAXbFyMKCbtZ/ISw/qwiZSCJTXvPp9eyLQxt53H7gjhZU7vai/InkksQQU/aCa/hEecvBqYjr0k6PJQrv143OE29lQHzzi7tGNEpSF1nKtaMahnWUXwACGMDgId3+SiVa5EjrQB0/XqG0GSOHibcdlpQx7hHzPsF1yon+ULZi5DcDU9GBgVJjBBQdCYbMb0D5IOgoAUcT662PnK3h/fGrCxb9MnT608MC4h797I88nwk7NOKxGQEHJL5OIVyG8QDL/O4geOcmKsq+uj+eflpVJ0wmGoX8BByMKpjH+AFWpIpAU53o09MSNpkQ8BCGqA7XIDAwqA==
Received: from MW4PR04CA0189.namprd04.prod.outlook.com (2603:10b6:303:86::14)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 01:29:47 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::4e) by MW4PR04CA0189.outlook.office365.com
 (2603:10b6:303:86::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Thu, 23 Mar 2023 01:29:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 01:29:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 18:29:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 18:29:35 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 22 Mar 2023 18:29:35 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH V4 08/10] hte: Deprecate nvidia,slices property
Date:   Wed, 22 Mar 2023 18:29:27 -0700
Message-ID: <20230323012929.10815-9-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230323012929.10815-1-dipenp@nvidia.com>
References: <20230323012929.10815-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|LV2PR12MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c783fbf-d7e1-47a0-3c88-08db2b3e16b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NuD4lRB6wUV04MqD6CkfMSS2KMh9mKSiYNl3EB5yjCb7k9YDXOTtwlD1boN/FVYYKhNb1owKcIH+j1ndgy6DgcPztvHHN31ZdC+Z8sOcSAJ2+znQVNmqLY1DaOTnQ+fP1xSbkcNq+auKGFW10rUTQxAFY0tnfAAV2M2R1bd1Wn/rakSdwr54slWPngt+BdxEwSW415jIVHlKR0YGjYvqyzF2F7cRe+7PW12WFxDDpS/kAb49zSU7ICC9pF8L9oznk3bYRaAcx0P21LHbaybyq/hhTmHr7frY0SjhcgNNoWdQWUphJy/tTThsYJbsCdkPMB/cR/ZWEciZXxbLlrXDhBfcQQIzP3XNWUwxXfuloCJLhWfdKPNQScaKaV1uNJqwnIospxneE+lSvPF1hyV+KF0vKI188DpeaIjvD2ZF0WUnKXJSOZPwhi3CtbES40AGgkqfRM7bBd8rzg5syUUt4sIjuiM3CvTiAzrfZD5ViXVQFk2LVUyAUDAZUgqMyKRHe8WxOGSKkBtwcawrbtJZ626dEf64AecYtUOiFYZJEXDCjSNpCLVudMqQLstPsTO6mKHGpBhwrQpgjbWzIG+h8iCiT6lM53s9jkX2W6C7VkBddg3RJNWvgeVelErL5ScTyDjSRQgi/fei0mCUJO/pOPWHoRYxOHJor8ZLsboKWsuZX0ncRZNcz3ZcyLEjmPhfMqkkqLdauf69lk5z+ww7vDUAmlTUMUXr2u9/01W4ZPElG903hyPKCs8aHLQwLgZWFGa6TCmU3r9ORhJw1Ig4qYrQis7ETru+/KX5bd1VoaOAv/zMbMIhvPvi6tCbbco2
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199018)(36840700001)(40470700004)(46966006)(40480700001)(426003)(316002)(47076005)(110136005)(7696005)(36756003)(7416002)(4326008)(5660300002)(8676002)(8936002)(70586007)(70206006)(41300700001)(36860700001)(82740400003)(40460700003)(86362001)(2906002)(478600001)(82310400005)(7636003)(83380400001)(107886003)(336012)(6666004)(921005)(356005)(186003)(2616005)(26005)(1076003)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 01:29:47.0084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c783fbf-d7e1-47a0-3c88-08db2b3e16b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

