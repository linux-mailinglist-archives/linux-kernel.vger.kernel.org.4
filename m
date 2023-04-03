Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1396D3DCD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjDCHI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjDCHIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:08:21 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2050.outbound.protection.outlook.com [40.107.241.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1195BA7;
        Mon,  3 Apr 2023 00:08:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxqgmAH/Es+bFD6NXvg4sZ70SvIXOwLDsSW/DoGJ+PxAflpjayOqe66nKQn5ow1Zymc3a4tIhRBCL6DFVIxqWCF4VrbkHlEWMdGKwNl8t3z61lm8+wrZk/lRPubWTivGB93LdJSRNBjCro8mhp6wIQl2f0WPC0paGqVx7Je6ZYvh/PQfRy87ngt4QYyHE4aBuFgGK7GOrTaNcyymAfMs50f+ld3LhXXyMyFoPyjRCapcm4BjrNBv/2tN4pwE87YNF+ieluhqKR4CsYb1pptyBxTo/fD634c1xZsLtfjTjs8k/8mdpcIf6ueiLwssrABO3JKmXwnO79y54iwVzTchHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Im/MUwjYZXMEULS1hg4hWTS6xpQTRAmSFmbzlW1Obw=;
 b=OUaxlAHdJxISxXOrdYAuIMJWL01bpqJIQqCw6gV/k/Xf5MRfoSV6nCTUEN3eXzkTKTfmCU0PKSdWVrF+GSgZK6bggQrPtMW1SpNJMCeXi2887SW+afDx64w6thmazKqM/wFpNIISGv9b4TvLQ0OsGALiCiE2CnikBYCSZodN7/eGZVV5mQPuJxHj2aIaG9M/g+LP9EPd1b+HYuXiJCzP3dmXCr0IhUE+uaPpLj5b6xtPXLvqaLnkvxdjo4/144lhspSVLGZ/XsTnnnnEyqA53iOMGDHzGyRCnd+c/36qLE4lJvu81pQ6GMPtENHQyYMRtdJTCA0BEVqFF8J+yyM5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Im/MUwjYZXMEULS1hg4hWTS6xpQTRAmSFmbzlW1Obw=;
 b=Tc/5OBA/r1QfuzSU5vYx9DXGoXDr9h3VG8WbnzL8lEu3BLTs/19ny8D6J0qQ6xXf8K1gf5QdlACzvF5bNq/cb8/Oo8uBQpc4+R5j5lIrmncDNusxSOeZvyTlJlbSWAaXKX2IfgloGEbV6uYquSvTUzs+2qFhreSoLGYdrzSdDu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 07:08:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 07:08:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/7] clk: imx: fracn-gppll: disable hardware select control
Date:   Mon,  3 Apr 2023 15:13:04 +0800
Message-Id: <20230403071309.3113513-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230403071309.3113513-1-peng.fan@oss.nxp.com>
References: <20230403071309.3113513-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ffc745-f57c-40f2-8a56-08db341231fd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H2EKOu5iRnrLhg7B6SoPA2urcTWOrl7j33vweBBil8eeZ6gLkmuhyeO4o2iJ7cE+MO2OA/9l1Urd7dwVcnaN9ZO8sY+W+te0+hsrk62TTa/QiTuu0tV3y0eHdRqdQrAx7BQlKJM+KuNkI7K7O0BxYrptPq2Y6cIqpl0V1RekFZCJy09rIa2aGgopimdB2WIe9bgYxaS82HClnV2P4+a+hR8Dta0pBJJnCLLflZBOKGrmtpF4hSYxaqUDYYVQACZS924mZ90LKl+6n+/Ew6D6JzMRjfKVQ6R0QXFFvWDIjbO1MxwC0cfrBEBnhG249nZPKulXO07pErEThTrk0ZuP3wlTTnoEMk2ZXyb2OT9XHubUjWryFQjV9N2tHgAQDS4Rex5dpKapr9dE9psYtRfqUQBW1wk2DfPVYfG1JYC4sY7ftTJyeC1BmeuYf0U9hbHlTOdVuouVVGbqnQ0emIqib9duqpoXPlQPO9XDSDUC4tih80XBqUADN5CXkOiV6CPfUZ41WT1poysCtpCDJB5Hhjfl0wwawd48QCliHUF3S0yMKQWrjEe6Bx/dbFvYBKoEPvC4uX8bMypPLi+iizlZZLmxSPKC4BtNcIsNd+1tTpHAqLvRAoCuZXESgnwdZ851
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(86362001)(38350700002)(38100700002)(316002)(478600001)(7416002)(6666004)(66476007)(66946007)(66556008)(4326008)(41300700001)(6486002)(52116002)(2906002)(186003)(26005)(6512007)(1076003)(6506007)(8676002)(8936002)(2616005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eW/FzEK7yv48Frdn6CPeCCTQ9Epv9pr+fGqSapqObSvHxCUQ/BD01KsTv3Mq?=
 =?us-ascii?Q?HfsHYUbEKIkJ5smUxDLXQLopZJs5t+0lwrI00RzYcKhs0spYY1wnChl6EovC?=
 =?us-ascii?Q?tZS0HFMG7pVPWsJFNVEcO1Dpw8Dm3p3U0QgcBnB8OoCHjTcEwQWAim3MT73x?=
 =?us-ascii?Q?a5SyATGl4YsWKpdWqmrehEocyTB+U19iOmFfa3+h8iQhYDgsWD/Dgd+tj7K9?=
 =?us-ascii?Q?D4v38MGItW4MMom6aizbs+TJ3ed3w09Nc3DbjhhtM6hRehBPhkl63q/jFjLn?=
 =?us-ascii?Q?yx7pJS9VdYfx8cctCj0UfQnKthOwOC11hcyGiBmThRcsRYyoqpeIkbfOqiCe?=
 =?us-ascii?Q?euzEPBL54g9L+pICom2Ulunm6HrYWSd9Vh90utdcTYTLPEIdap1md1WRTCjj?=
 =?us-ascii?Q?m3WyB8T2qp6OVu4thKKUY3z3XhbhX8PvEToNP6XK1TxV/LPfwepxiLlyMjAs?=
 =?us-ascii?Q?ARFkfh8WHNhEu7K0w3Q1Ofl/Mb6gcNxg+k3gQDOuVzdRysnOfhzzjBoAp0q0?=
 =?us-ascii?Q?L5lfBrBNK2y57J3XNENo4xJ/bKMZVCQlSLoeNwYnT0v0E38/ragpZNgNfgvy?=
 =?us-ascii?Q?TpdnxaCxK3pFibDO7rMsurErz/QrdHkSjcy0V2+ArFCtVjrhLzafwUo9k8yI?=
 =?us-ascii?Q?RX0jxLl58djPMma3gkj3AAB6nDGp2AidTFTjZV1TKVY8z3zFUi7iSubnSutW?=
 =?us-ascii?Q?nVZ44DDeNNNHTz8galeICshqmlUeqkSjG+vGc8nUXlbc+y0C0+UEIqjFiL5o?=
 =?us-ascii?Q?oj4VnTL5hUDw3Mh6qvSog1WdS5ZpRFzWkG0ELA3KyH5tEdXQV20IZNS2fhst?=
 =?us-ascii?Q?C5QeDFiYCRUYBhd5ixomky1Dwri/NtB2gzSI0q0v/9IZGxakOZDGnPu43wI9?=
 =?us-ascii?Q?eJCaX+MkRAUbB4zeyt9Dq4BXz6sIWk5NrNOiEGxqqj+QfYXXUI1ibpC5S6Dd?=
 =?us-ascii?Q?ImgmWG9YWXFeFSlfasEZJl9V7rbJRvUONo4BjrYUaXw2wE0xXbRR8/Pcm35y?=
 =?us-ascii?Q?LmxcTqJi13POATlBj/0mRsZR2StbESBisj+Cdedioy7U4TuC/kD8PEbCXoHF?=
 =?us-ascii?Q?gw+vgT4qtJYNkJhO98mT6hls5/ABUA8THgbWnqYOA42Rv5PoylojnhStsYRA?=
 =?us-ascii?Q?LImJHjcyR854p7Emzv0pJVS/C7SM9KeqTFKVw92KmY9ul8MyucjXEC8EMJLM?=
 =?us-ascii?Q?hC0bHqo+M+AYKsucCdv9LSSIGs+4SWCbQ+cLgdeTNL5LKf08QC1moCYUENhv?=
 =?us-ascii?Q?DYRJ1Y5XVHg59YjOM+DA8Aw+oPmzCT0Kunoz3NDlpyfrsJaw4tWTopo3BdR6?=
 =?us-ascii?Q?+dcouhokuKyrGCfzbFg40q/fuqZL5tklq2SmA7nXbdkHpfwz7knkxMLhXvrx?=
 =?us-ascii?Q?BIlv4hap8mhOSrO4tYAtwmldUlZUkRRp25oYfBaII6wPQshhNmODK23ntCHf?=
 =?us-ascii?Q?QXSpzrtUI25h/nC9zmZM+TuANo6CydNEwSm02iSogP3x8ySa6UmsnMpbPYd/?=
 =?us-ascii?Q?c5HnWaJ7aefo+vFiBDHYetD9TXMtGSXyqku1tFUUMWQwTnEKPMuCarE/mNDG?=
 =?us-ascii?Q?H5ohYcsOeqmSifK3V0RIBineBolWrmC2rOzi6RPP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ffc745-f57c-40f2-8a56-08db341231fd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:08:15.9269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxWP5dgjAvYMPeBPlowEqbJPqbxz2tpSwLSAMQbv8fck+oJaUFXSKvB2lc34oTLN1ZRxheWRb429iA7cd7Lmcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8459
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When programming PLL, should disable Hardware control select to make PLL
controlled by register, not hardware inputs through OSCPLL.

Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index ec50c41e2a4c..f6674110a88e 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -15,6 +15,7 @@
 #include "clk.h"
 
 #define PLL_CTRL		0x0
+#define HW_CTRL_SEL		BIT(16)
 #define CLKMUX_BYPASS		BIT(2)
 #define CLKMUX_EN		BIT(1)
 #define POWERUP_MASK		BIT(0)
@@ -193,6 +194,11 @@ static int clk_fracn_gppll_set_rate(struct clk_hw *hw, unsigned long drate,
 
 	rate = imx_get_pll_settings(pll, drate);
 
+	/* Hardware control select disable. PLL is control by register */
+	tmp = readl_relaxed(pll->base + PLL_CTRL);
+	tmp &= ~HW_CTRL_SEL;
+	writel_relaxed(tmp, pll->base + PLL_CTRL);
+
 	/* Disable output */
 	tmp = readl_relaxed(pll->base + PLL_CTRL);
 	tmp &= ~CLKMUX_EN;
-- 
2.37.1

