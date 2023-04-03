Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538006D4122
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjDCJtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjDCJsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:48:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29881165D;
        Mon,  3 Apr 2023 02:48:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeE9EzXy89q8fSWDlqFEInw181zD8ahxEzC1y3LduA8xBOr3aJU5MRNQiQ7CFr0BlnO1JkwPp3hj/rlnzPYlmHrxmQMxyQCWWmlpvrCGys9+5rPGMzPt7m6NS5vB2eF80a8uYI7DvlHDAlfQl2lfZmo4AxnVYPzQf/Ywb6P4DzNjocUP0uF+TvaKLIHQQpsOSOhBeKM13Is8m49C9jebVH+QfQn/pwFkuiECK/Py8Nd6skCY11HLOAV79/XJPA1bQHOPXv3Nc7zq9j/zGMtVsfPr2c7mrWtRn3UvZ3y6d2zxxOlY1xGEsXEVgAzDJh90V6laKOF7tJFAVc9NM603bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Im/MUwjYZXMEULS1hg4hWTS6xpQTRAmSFmbzlW1Obw=;
 b=ac367JguEhxbFgxi5+jTeH1JbvRKlvo3PcAlyltO9ZNhw2DrC5XsX5W/U6EZf8KsNvZ+D1quRqVeJzm8jq7E/bn9ATWmYHf9T7hQWAtsSbJrtDFtl4xitXC421Dyi4YcyuET3Bk079n8kkiLHrvJPfIiN19/rcCBfAoNsjOZLYQGhg/W33Sh+75+4rEOoRJgegVlfiTVGM7JQ9nlfcOlSAZuo1g4YmSL0zAeO2Pe4rBMMnS4Cjr3sXKZw29QyNgERdsQHBokg3g2SD88hgW/RvEhGRbnGol+/jm8nWk4xevGR2reOFEsJ3YXGHO76ASN3VvrP0znyIevD7pBlExu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Im/MUwjYZXMEULS1hg4hWTS6xpQTRAmSFmbzlW1Obw=;
 b=Z4pnjG+DLLtIS8OjYdg16H1+F0Y9gtrQzAqdlXlSSP4GO8qsLaN2XsnDKTbTPTeY+6OM+6FgfiyQl89vJH5f8x/ZdlwGUdENPxxZ1UOyGBOwhwS06WWRPxn/KcHSnWy/kkJnGd6QnKNuMIeZGUDStcTOQrj5P3w32/M8e0BNQII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:48:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:48:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/7] clk: imx: fracn-gppll: disable hardware select control
Date:   Mon,  3 Apr 2023 17:52:55 +0800
Message-Id: <20230403095300.3386988-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230403095300.3386988-1-peng.fan@oss.nxp.com>
References: <20230403095300.3386988-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d72c10e-2561-44af-eb61-08db342885b3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pZiPgi1vEQjJC/uWzERgSN6U11gm+YaB0UqWzM95pw4gA5JtNEWsZfhWLU/rECTJhwOSnJSsXnNCEeX8AFauvjFF1Px2Hg8oHUB2aHUodRYOLh8Imr9V/0w+Ko08cJn+QRWRzU0/YZzd8hzv1VvjzAeH8+f6ljmHpztlte5Isojj5OJ2axX+DKDZKhQu5PZEQIni5HYWiCS9SxzTj1Di5j8G0i6OrohPxBnnZSFPAPR+SY+S93s2KwX30pxY7jekcFBz1P5v9Ly6mxPxMnPjGTfyZ+FpmqbZpBeYpMaj4Skiii7OchKGhuVsH+ygCCjK/sI1tKJxlduVmSUo492XYwlbVtCzCKf9+tUK7SbbTlykClb1Jxu7R4GlrYrPOO65Txnp3TEknmjlC0uDSBzDCjXprjxsNXK4/HXpHcIBlusfQ+9z1Un7uzn7h/DCs5gdyemUCCU+jw+vAVf+qf2rXEvcsXJJofZJDiJ5zuPOqKGwkhEt2YLQPRJpeJ4nGRQwif6fjEiZtbj1zNG1TQ1l1nB6y1olmmoyX7zLshoZJMZmGmZdjSkrZuOvijrCJqPd4c1wAL9GleM9CUiWJe5f9sGmRiYms7BiSpNVjuLo2zEyOnpACqrEWGuuFW6+73Pk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(8676002)(4326008)(66556008)(66476007)(66946007)(316002)(478600001)(8936002)(5660300002)(7416002)(41300700001)(38100700002)(38350700002)(186003)(2616005)(52116002)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qRbYy/H8Sq7iugQYryhjbAPtOnlJGG6cQyCocS9DR5/klc4t6vvbwwOVckU/?=
 =?us-ascii?Q?sTe+ZhyZtTZpv2WSVS9GJREnk/MU09ZSjrLJvkPCTmla858EGuqYEqN9OgvV?=
 =?us-ascii?Q?ldz6vtz9ReYw5gvng+HQ8aG2584iBV+pEgzwJM1pWgGJtvPGbTdY3o4Un63T?=
 =?us-ascii?Q?ntdQ5flGlKXSrdrrRqjwzzxEQQNw1pwg847HYRcz4DmHSzv38G+3syDVVE6J?=
 =?us-ascii?Q?GqwDhdXBZpAOXsYDn8dmPRl+2egvhT4QfGUr60HrIhpo4X3Lavz7j7ERNqHn?=
 =?us-ascii?Q?2SisbYKcv0BkmDHq7OtKXnagz/tnkX5qP3YpoMDtxmo5HqMKZILpBHlE6bI5?=
 =?us-ascii?Q?GqZFSbEo2t8tU872wpdp00ZSQNWgPCFxXA12WyuYSaHbtyNdpWJ4SHpvLvJP?=
 =?us-ascii?Q?RYInSXYD9DLNlGkgOFMR2cPVgY+tmna+hC+aKuP3sByPi0/SA6VzC5AcMNqK?=
 =?us-ascii?Q?fZa0FDqc4ETkEvs6giQtPgU5xdpG0yAPAYHfZR2ATOy6t0MONIOgAyisOxD8?=
 =?us-ascii?Q?VdSCswmSaXAj3GQxcO+xVuteePVfdrQ3eORmpL/PhYqoJa1deRu/zc215lKh?=
 =?us-ascii?Q?VOxT2m/k7u3fPhIDi8Lz3AzPziKNrW0w5EGMnc1HYgNPVElI42Ds+SNBUXEk?=
 =?us-ascii?Q?YVtbhYylUjRX7YNiFfjRgeovUhgyUg+znfnvrghs/z3wKUWkzY5agesOPKqu?=
 =?us-ascii?Q?lp1Cbv3fXK1o9GSmZ9uloUje2TscAXkVzc8CIUPLvxUf9BRNeC7P0zbdjhgD?=
 =?us-ascii?Q?sdA13k424XHcdbxDULelPBfma7AroxlPB2FIHvV1eDpfpaGM1+kGUtttGcq9?=
 =?us-ascii?Q?qPsKc2nXx4iaCC6L7sIe4bKSVZ4dty8wBIEs5086pmgT4sghY8CaZ7txSr8n?=
 =?us-ascii?Q?8r8zFDKLBKMWwHry4oabQiw4eXss0PeiC8LnLjuWXVp81zJoM0bmHIR7nMMb?=
 =?us-ascii?Q?x3+/zYx3n69qe1Bjv2MbPpPqSA3M9lsC/t8IXhG/JtAXWmzAh3qoOnwmQJiG?=
 =?us-ascii?Q?zM5riMWH6/QKGmIJS0DOzHdXuf33aj8PrX2m2BpbSj2CqPFWfdoLobIHQFiN?=
 =?us-ascii?Q?vAiSmE1Uy4JddYCaPGnPOxrClWsWUgw8WZ+9TRycj/HMz4gWeFlpwOVMGXZt?=
 =?us-ascii?Q?Cac5bmiFf7qrHXqkLNNuDqCKzaG3hvy7sqmmUjXQ5G+wYX0NFB0hKU1mEm9T?=
 =?us-ascii?Q?U6tpfHtQesILL0xcA5X/7ufDFS96X/1MRiu1u4kNFVH16UHyn0RG73ZqkaCG?=
 =?us-ascii?Q?TL9vuyXESLZAd7RexeZmynjtUqPtPnzEy6ocr2Bb9WJ4PHW6U5nZsxXZAy6y?=
 =?us-ascii?Q?UDHhD8L5jo4nZdfhwSNzFUTrF9p7o+cbtQwqWK0+aAEufF8WgPGqv4N4HPho?=
 =?us-ascii?Q?9TrTLFZliQfk2yQVT4ve53RQ6CZaKt+ZCfkgZtTFKZxTsjYb43X9cRsbRZFY?=
 =?us-ascii?Q?isSQdKcgns90ayDhy89JsR0RdQqX0i88yOefCIlWBeXDJWQddzoPoYYV13+h?=
 =?us-ascii?Q?46WtMb7613PoHK5fSzsOeye5mTUfzHgAxjyzTRx0HTu9102devVoJjKFSwB5?=
 =?us-ascii?Q?jV7pP9YJLXDJg20KBR8jGRCkmBEpLRi3Tx3HeXWk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d72c10e-2561-44af-eb61-08db342885b3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 09:48:05.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDETIK/+KWrg7/oH2kRhi9jricC4Fp4xe9zsRHIDIkvVFnm9c/v0h8Hc2vmx42OKxilNTHWwJ5tl4Bxp8KZKLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
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

