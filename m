Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88794747D93
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 08:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjGEGye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 02:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjGEGyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 02:54:19 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2135.outbound.protection.outlook.com [40.107.215.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517F51992;
        Tue,  4 Jul 2023 23:54:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5XIKNl0mVYcYck5FoY97oiem+/DvISqVyIIxhGdPkza0r82X+ACb+GIT3JqJP7lF2hDQIUfoPcrFg8ZLhUeq7ciRGutCr25ozmwxhsXDzYCY7hhuWg4UENPjwv1TqZDwgarYuj8Zn7aiVevjirPYt3Ob6R6JRphiFRZyLsPTYP24PiglSnc6YD9yvXdb9Tz2dY1g5DNnKBQQVcVmStjZZHOr6txM7tQqca8nY58oi8T/9/0kwoom5DdAOt+RDelo9+/75u0vfaecyJFg9tqo/K1OniPY2TuzENooFYLQMkbjqMVUfN34t43kjE5D463r+ubgvBW/6Bhp60JQzyCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t78Ts2f+ONfhdnmDgCdAXpgNSzp/ttPaZtRAj3Dx4XM=;
 b=eMUHKw+yOhng6f59nJrxrqYevlAwoBPf6A/AFonD1O9lietLVjIAfCGOQ1jgmzDkpJFhC9OHv1qqMwePNPJvxkMmMJXFS+pgRNGvIEp0HuUX0VRwEQzr1mRUSjNeE8byoMf4tSohQ5J1aLQcZbnDxNQPJrMixPukzhM2OGXn0end/hGPQXK7ECRyPXVcZDxg3kXxixDcvkRdzyfqsAnIN8PofMDWruqrw394jEkkDbHsU9VkdXN+MXPD67T/UobPYwXhElA36jNBm+r0FgNeWE/BzXwOp0dCcbcYdlku68NMkcDBC3ey6tlCGT8qEzrGN4Zs2x3xl63oA5xi1+fyKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t78Ts2f+ONfhdnmDgCdAXpgNSzp/ttPaZtRAj3Dx4XM=;
 b=KJjn9djFz2nq3ZvNbI63LIaOJkvF/4PUPIXV3IkNJ9rCAfhvTpgKe6UVXH0hxjGUnOzxyTq6hrCD7mf/lDBnptiyWWsFoOnD5oZ5GqLKY80ppGYlR0yoOPqAmK0p3x5ZDf+hPuEeLGNabb6zQDeexkJjBnmKM53jJYQDpjOlgxDyjtu/wWmFIoQXEbxBLmwqDqxJ3voiC/4hRpnpxywZK2MiC/3rZ8KGAHR1wgncrx2cv/YY5qRvyghYDEaRLcZ/EsIGVaCcfdPrLPOdcYWAGt7miIEZCeyoHddaVTmQ+tLYYsEollsAYPDSnk3g10oer6LHgbIR46lbvWp1/UKtmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4140.apcprd06.prod.outlook.com (2603:1096:4:f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 06:53:43 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 06:53:42 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 09/13] clk: mediatek: Convert to devm_platform_ioremap_resource()
Date:   Wed,  5 Jul 2023 14:53:09 +0800
Message-Id: <20230705065313.67043-9-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230705065313.67043-1-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: de174659-4c73-446b-6d1f-08db7d249222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKNMZbEPXnNCTlXCZMNrjgAPBQLPTAOyDPp/s0QE6vFXlXR7ox+KE/dCYlqPY8YSauzBxG0gxIipEI0vLJ1UkVppJCawT0zz17BTR3iojdSwEbh+KZDpKlOVLKQbZe/1nciKOOc+AoB6b++4pVpdXk57HxTiBBrKwlF+67e9WglPZ/9H2eoyFMN8xhDg5zK+NEPmZ644eFd/cmJDXIDpDKhIJOo84Dhqcu4HYJB+MnT5z5N62EYuEGI8t2+qzKkGkzGb2+725Dn5e958q11w4fNquUaL/sN64a0zh/nqPrdmi+wsCNoQ1dAvFTyzGfz4PR+ZGMMSq+x9nat3RNSnQm7mQ/8421jBjrkXxrmxIHnuthQCUitj9KW3wqJFnfbgjgyUUG2enouBWsOWiI6J9RVhcXfg4eOPU389ne09gIGPk05FUcWKxYy8Dfks6aoIErTX7vnDdNkkO9KXW82UD1gla46KW6hbPq1hs6XcYuJZidesQFr3MMuHl0wSKc2V7CIH0Kn5pofuU8SpLKdLq57BqvxpgN9CMAcBk949HxM88OVLQ3sWesl1paN+pjD6VTD7C+tyk+dkZIwatSI9LgYtoS4kkiFABdC8oEXVlahu8IGhWDQgFjoEd6sYO7Cy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199021)(41300700001)(8936002)(8676002)(110136005)(36756003)(6486002)(316002)(5660300002)(2906002)(66476007)(4326008)(66556008)(52116002)(6666004)(478600001)(6512007)(38100700002)(38350700002)(186003)(86362001)(66946007)(2616005)(83380400001)(6506007)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?otlb1vDzV/g0APXSGpLg+VMGlZ6YXZy6x82se0HsRTC+eVSIpK/3kUOa8Skb?=
 =?us-ascii?Q?FfXITTIAE2eZnArLcErRj/eokIPTl/YAZ0T/yeU/xA+OWXvhNh7GkD/P2M/8?=
 =?us-ascii?Q?Ob853xPrkImR5M28pVG2toe0ihoCcrfNuzGcvpP1ULR1KbINjI6ItD+qVnD7?=
 =?us-ascii?Q?jPjIat1XFAXvh2IMDFAHsEe4bNotH9TzQ95fe7QCDb0Y7CeMzQG0ODfd/8XD?=
 =?us-ascii?Q?l4es5ma3x/FatiJDq6ilOfNegwuKNz4tKbFwjdMZAM3E5d+ruLmVLi8eXXsO?=
 =?us-ascii?Q?DUWUdDVSFgjnp1b7my3iAF5i9HXZIorPYqMJCwf6L6N5G5KOajk26dHK52Ta?=
 =?us-ascii?Q?UojQVBoqOc7YpJzez/SGHwcpJ2AJpQpB5BeqaLeAO3oZ5ZjwpliGYiI+N7Oc?=
 =?us-ascii?Q?TBcWopNR7TP5ASJBUJe3mcC4Y6QssW4ZKX/3+mu5hg2smr0M0SHFA2SXEcK/?=
 =?us-ascii?Q?CxTNCroz/dh0cKqgC6fuUsT4yarxgkbNBT9S/VMYXiTabYYv+wVON3zwHcdm?=
 =?us-ascii?Q?DrdRi6uoxSPCScm/wmE5pAJJ7fUdTiPsPOMQAzeZ6CD/Be8wIC8rLppFOR3S?=
 =?us-ascii?Q?hCS1ZcmGCWuB3HcKQRoBRNU7UUb/GytT7E9LKdAwl90H4Up14fuAjAjOG1gF?=
 =?us-ascii?Q?0Bq7K8p2KUlw4TNO4sgJRRyRAVqq6TDbKP0FvBQ3Ow/0A0oCTjVMThF6lVYk?=
 =?us-ascii?Q?f+lu6Gx4P/RRzXaWc5oxeyc+3Br6U9SrsidViAKjmQHK8ojpZLWNlKvQM7cb?=
 =?us-ascii?Q?VK5QAf4mJNedD6ghwpYJia1Xo2YDJpV3Dbucp4oX0BD9iymh9z5/Ti712Rcw?=
 =?us-ascii?Q?JM4iKxI2l5bpSlIaNbpFKxdaXE0IkXbgNGvIXSzKL8FEFenbMfMi+Dxmm0V3?=
 =?us-ascii?Q?PYbVxmrMgJjdYbrDBwG0D/J12H4KL4PnO+/aMESaND+F5lJqSUS5Cdob5lij?=
 =?us-ascii?Q?E4mzMVZgBX9pi0dFJFbBlmGAIAVtpWI0gKuquaJJlBibaw+gr+UztNJQdrX7?=
 =?us-ascii?Q?3WlBjD8t4CL8dT6HRYkY4SohcGlByH1Yydae5gN0e5GwP6gi3PgdHDd0TGDq?=
 =?us-ascii?Q?p+EB/g2db1tnEtiBjerdeDQC/MBMsbgI5XRWyRvJzKT9RkvkuiK8a9X0PziL?=
 =?us-ascii?Q?ou59zwzZ7fk1vWzPtZLTgpNKNszMy0t/Man7pwXvQ1ZKO6rzlx5/VlcBMtkY?=
 =?us-ascii?Q?W96sdymx2OiN5lCISRCscIsUmznrse+3175jd3MIj4IUFkyMhqLU08FV00c0?=
 =?us-ascii?Q?P1+T/bpe1fgeWOI/tgN89gVaBHeYt8vSHuvnzxB2wUYpoRoZEVpBAhsY2wSK?=
 =?us-ascii?Q?RGmkvXpa92cFi4Atec780C7ddFITvG+4IXAMh4vhG0ay8R2Vq8Otz4KpLWr6?=
 =?us-ascii?Q?B/o73Ol/pQ4GyG+islFdYR6Rf78SutCVpXAMpSBDGUuaBNXqbpGFEZuITTif?=
 =?us-ascii?Q?R2iPz65MCUgCKAIQiHimx2X8VEbeXUC9wdt58MxdVgj6P6yeD2YDRA+seqWV?=
 =?us-ascii?Q?iBprWObpgdhb5xdgzSysneVkb3xVKArbiFC4r+lyotUykjlQuBwtJFjjkL/h?=
 =?us-ascii?Q?HSXPXz87VaVgHfPqxsCvs2pq5gSMYKL+ngiUFRy9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de174659-4c73-446b-6d1f-08db7d249222
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 06:53:42.8527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/E2Avh/eC+uYHqptNDQWMvUcTb2FZbCo7EwBqH2ay8T2R0cNvJq/LzpUskCxzquubeMnyCEsgJp6QTklV+/bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4140
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to simplify code.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/clk/mediatek/clk-mt2701.c |  6 ++----
 drivers/clk/mediatek/clk-mt6765.c | 21 ++++++---------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 4a154da8a543..4269eb37be2f 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -663,9 +663,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 	struct clk_hw_onecell_data *clk_data;
 	void __iomem *base;
 	struct device_node *node = pdev->dev.of_node;
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
@@ -887,9 +886,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 	void __iomem *base;
 	int r;
 	struct device_node *node = pdev->dev.of_node;
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	base = devm_ioremap_resource(&pdev->dev, res);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index 0377e6dd3206..bd957d7c6d54 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -731,13 +731,10 @@ static int clk_mt6765_apmixed_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 	void __iomem *base;
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base)) {
-		pr_err("%s(): ioremap failed\n", __func__);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
 		return PTR_ERR(base);
-	}
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
 
@@ -766,13 +763,10 @@ static int clk_mt6765_top_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	void __iomem *base;
 	struct clk_hw_onecell_data *clk_data;
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base)) {
-		pr_err("%s(): ioremap failed\n", __func__);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
 		return PTR_ERR(base);
-	}
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
 
@@ -807,13 +801,10 @@ static int clk_mt6765_ifr_probe(struct platform_device *pdev)
 	int r;
 	struct device_node *node = pdev->dev.of_node;
 	void __iomem *base;
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base)) {
-		pr_err("%s(): ioremap failed\n", __func__);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
 		return PTR_ERR(base);
-	}
 
 	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
 
-- 
2.39.0

