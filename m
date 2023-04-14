Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610656E1949
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 02:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjDNApZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 20:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDNApM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 20:45:12 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12hn2243.outbound.protection.outlook.com [52.100.166.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A47819D;
        Thu, 13 Apr 2023 17:45:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftQGK94oIHQuJZnhyfH9LEe26EI9cTyBjUAgz0arecqg4w56407d5mwVRBw2ogfFTvaGIODWlztGtTFbuPuA3wvwy510x31iD3l9FhlMMmYUa7vQSol7YzlPBmGW/fIaMOAylxDeM3YsKjseUh/CXEeeoSb+gRXApTPBz1K/4E43hV6tVfkSBji0cJ91vmg+eILYMZwCb2wwP4H8Tnmu+dnmuIJtVddNhmbVlnJo7gasrfaBFaAjhn58BsXbyTJP7Hz2FqmLt89MJXCn2c8uF2uOwo9rfVl4PEhP7I1frTGvWmN5K0ALvriGB0u2Zzx+V+B8M76dpwIvHzlqUwUeCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2CJuSdgjUz5SfX6G1RySck3/wEeQCdulMwW76h6I1M=;
 b=GDAuJagx3VY3FUFrDXggM4XVcZnYvREvfR/WAPf4WmtHd2TuZWTB0vHWTrHAjHaHI2PyZMUpzWXVev4uhr42ZPFfXMEEJNn3wW6lPVR9Qk1R14CSTC4UhUKwnTdYw3MaOFJkvqTmV2IManuZbJisddj7uQT9/kI2PJVHhLIE8FlAma1wRsuxl5dIouGenRdCAvgcml0SUp9L9L/ZIn6hUMJYHr6rWUOG08YLG2hsEAMMTAeSGkWdMN6PYtfteHFrxJak/00Oi1MOlY5/xEs3MOb/BOL3LLuzGyREgoJIb128Kc4Rs11DhfoDvGmYQcWnflI7F5NQ7IIdJB7ZeOAiyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2CJuSdgjUz5SfX6G1RySck3/wEeQCdulMwW76h6I1M=;
 b=YlCtKZz00AcGLGORWXlT3Gd74FBkilqgB6jdzxm851U7K1g5MDWKJMw84K5TOxQu4IwqkRg7ch0wdmCr6wH9pVh3S01X7eXzo+2OTLu5mlc9ATaY7IVfsetPn+Mjjzt1hzATRU//PXiKOT50qr2nkd7mQzVOr1bQMZOYWuSGZqlolBVWC0NMKYVARoJh6XL4lVrklyLESSgBQ6WdTVSESYTHcDNmSQz2GCHZWg9pv9Y1BhfqHEuXU2rds7pbKqopFwVl4j8V9dBsOVdelz5wCoUARz0/do2/2LuqENvf4ecX4JCoDhwSjYW/yxMtrW6evMarSBCWdO0reNwQ5dD++g==
Received: from MW4PR03CA0273.namprd03.prod.outlook.com (2603:10b6:303:b5::8)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 00:45:08 +0000
Received: from CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::cf) by MW4PR03CA0273.outlook.office365.com
 (2603:10b6:303:b5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Fri, 14 Apr 2023 00:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT074.mail.protection.outlook.com (10.13.174.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.31 via Frontend Transport; Fri, 14 Apr 2023 00:45:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Apr 2023
 17:45:02 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Apr
 2023 17:45:01 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 13 Apr 2023 17:45:01 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <robh+dt@kernel.org>, <timestamp@lists.linux.dev>,
        <krzysztof.kozlowski+dt@linaro.org>, <brgl@bgdev.pl>,
        <corbet@lwn.net>, <gregkh@linuxfoundation.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [V6 7/9] hte: Deprecate nvidia,slices property
Date:   Thu, 13 Apr 2023 17:44:53 -0700
Message-ID: <20230414004455.19275-8-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230414004455.19275-1-dipenp@nvidia.com>
References: <20230414004455.19275-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT074:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8196aa-52cc-4230-7070-08db3c817ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTgySec1L2xqggaFlmiCp7Ce3Nhs0Zc9fhShYUD88qhfAmvzv2ZdyFc66eUYEa/4dWm7XqijHx84oL2metwn++gma5StrhZkNTZjJlPw4s+dTHQDB8uZsDDIhyqMKntqBpTEhEJu3/pdg1cuipn2WFT8e9hN52BGG5G4yIKW9gWZIMIiP35PeS4rT6jEPrTdzCaLIlhp5A94bBO7K3ArfY5cqRM6ux3EXZzqYPu+fmZuuPCiPTL+UsYBNGHGi7iU0AsfqzKKJKT7yZtWu+gCtz21L9PTPV25b+W2/kQV6M90Tlxg4rZ0tYbSp4VU/DMwKwSERW633WmGlggY1wlscwpxkSM/PCgieR7h6knhogeHxOWZIvUSJRAnAmJn0M+neOgp0bAx7Hk94sjfQ9pPZr8tkpSgALrneacQx1KyfmuKMeiYstNoMAD/fF7klWQohw32zliEYERcZJrb0vqE/et721pv9jfqW18DIo1WEv5usCY2Kr2rAjI2JtTJbb0Dz4lc39OmAYxhP1XuxdwDxWE/KmD+vnWMriffW72aDb1A8F/7RBpyTEn2Cj7nkFk8lmUK0bs/Q/bacnfH6WvDZ6rwAZ0ArOdX+YOFpXc+oyI5Xf4r0irA/5hJrLcbTeXX1ZrkXX+LWCYpM6MdbojUvyukpfkKLXHmSF9+Xt4XkCraYWdjm3QxKN37t2+TneTqXBX42JT+vPwzwnMRuIDVWsP6keYjfeDR3ttQyl72kcJAwwl3NigBtDZczrlnFey6tXurBx72HPWl4/Tay0qx7cEz5YYO4cGKmcF1FA8ls//0uLZqyNlM1p8AkA/rqdBh9aAV/j1uqMj6+biPvoS6sJp9UrwiByDxLodKCC2XDR8vBvv90d5eJVmuzc3rPSLW
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(5400799015)(451199021)(36840700001)(46966006)(40470700004)(86362001)(110136005)(7416002)(34020700004)(40460700003)(921005)(316002)(7636003)(356005)(478600001)(41300700001)(82740400003)(8676002)(8936002)(5660300002)(70206006)(40480700001)(70586007)(107886003)(36756003)(426003)(336012)(1076003)(26005)(186003)(36860700001)(4326008)(6666004)(83380400001)(2906002)(7696005)(2616005)(82310400005)(47076005)(83996005)(2101003)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 00:45:08.0581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8196aa-52cc-4230-7070-08db3c817ef5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

