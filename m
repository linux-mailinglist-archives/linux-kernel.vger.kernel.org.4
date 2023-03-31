Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5E46D17A1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCaGln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCaGlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:41:40 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA3A1CB8A;
        Thu, 30 Mar 2023 23:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fr5HGDWVRLnQMUKQ712FGI+WyyHsXwf/7zSJibyUDEwoFDPkueexcUI0j2wDmPKYCKOgl4L5CCud9vOmfTAf4s5kO2Nr+fau2UnxMMw+vvbn2nJjLXHkITFNjB0ejgIPa7iatJlbh5s0u+3emoiXtYmUVRy6vASmgvNJwcc5PHhFbphd0iV1hLsHZh+Xj0GwmQW/Pjr+3E8VERDVZ/EnZzMpZHTOivIe529hLxf6qCd5V9lML7Zo1w+t4Qs+9moj5fy7nGgu5V3d8Y39R4A2JLznINgINi+UDf4AbZWy0+Eq5+WVd+xeWNHxGnjz8tKMV7QsP4GPrzLH/MrRQYvVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Im/MUwjYZXMEULS1hg4hWTS6xpQTRAmSFmbzlW1Obw=;
 b=W/9rfLYp0JF08V+KzLGRf/F6KcKwizZsgNZyzGpOsanuYgAvaUv4piwy7WMON/iER0X6geZF5FE04MuxeUapTZ6nhH9Xw4G4zmqHLqRRqEbwfQNuzN51Z9ZKs0ge90JaXV/q+3fk0RqNPmuxkrLY8vIYoXB3jTGl79WKyjNj2fdJjCNPRRHzmYTrelEZDaEIcyaTuD8zrktktntLBmoknahU29sjTcEvwndMrBBels11VqDlUfz2ZXAZGpgwxfhY/SWR+sFOlN1vWnJ+zqWtcDO8Zk/5kUH1PBwkpgF9DjnLSzREIL3dBX3vZAu7ynhdBh7SRYtIklwSFCL75+mvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Im/MUwjYZXMEULS1hg4hWTS6xpQTRAmSFmbzlW1Obw=;
 b=ahyFnEbu5YbWr7CO/fgrv0Cla7b3UGLO+v4jhyQTrXucZWSjwq2C7Nk+7h6yFCuQy8y1kMtKK2s52B2sedTugx8iI6oV5nQReuB45aghVIIV+HeUBN+TnSc7he4ebsXYNS7kIf+1Sa/FngvZmGOCZ8ulmFQ43LQcowZzmnSJ01Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9271.eurprd04.prod.outlook.com (2603:10a6:102:2a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 06:41:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 06:41:36 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/6] clk: imx: fracn-gppll: disable hardware select control
Date:   Fri, 31 Mar 2023 14:46:25 +0800
Message-Id: <20230331064629.2475338-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230331064629.2475338-1-peng.fan@oss.nxp.com>
References: <20230331064629.2475338-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 823a01f0-ac1e-485a-8201-08db31b2f927
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CsTnR68Ii7m55bZHN/k0UAUR4e108C0xAW6mmqqLgMPkt0FiG9jTJIQwRas0/uOA+IEgSnO/pmfqzKAGoFrSclsqo8kL0oQPRD/nzOYXRep2We8037BQiTGD6cduWXMi6iL+pTaW4yl+HJOxumEXtF0XvxB9H57BN+0JxNL/FDi+GzeB7J7SBN9OnfVwLnfpW4TntfaNmsMv6woCoJtEPb5vt7BsgwLExqxKGQhdtj4e/+zLVSMXG2rz52nDU08gECzR8mPTY169fHXa1wo90DhmW5gpexCWhUB/FQDKdaPbCom3iIIMz4znRLVP5xSICyHvk1GopxRM95vbB28wxWU9QjwpOiyWMbbwBKM7b9cp0beNxhS+7a7WUqGFr6V6d6NO3Zb5jEpLn3AzXYAuhdXGDBz2i/gZG26Av0PIt45cZ3/IhKiqs6jqdvg408KCOoamxJ0Ej1wZpah3Z10uPJE4eESjS1CsRyWaqtsOzSr+0mEjIH+p0eB/kBqJrKaLUi0zDniFKKyrwE5HyDAqwssVpT5lYbCcXKlOdISPUC1QEaQYEqkWPmnPiHrL4NwV/pr8SDTj99xBsI/OsC0WvA+oVAOqauK6MPpFqFYKHS/XsiQaaHzBr3Rpj/GEzWCI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2616005)(2906002)(4326008)(38350700002)(38100700002)(41300700001)(86362001)(8936002)(66946007)(66556008)(6506007)(26005)(1076003)(186003)(6512007)(66476007)(8676002)(316002)(5660300002)(6666004)(7416002)(52116002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t3Z56SNCT3xLSRPImVroFNJHFVjvC4OB9VO+QLaobdct8iay5fnR/7KFYPyA?=
 =?us-ascii?Q?k7LmTSzyvCMY/GfR7A/99cSEM+yhejxRfrsn/8csXtnQD9OM/ATB7I5OViX/?=
 =?us-ascii?Q?g5i5IrS+5iKsxxKR6TNxn4e/FVHmSFyFKXHtrcJXxkRaYDMbI1n+Ucs5evxk?=
 =?us-ascii?Q?Bb3nyQdfukHRZfXdk6gkTBwOCsS7JqfC2grl1WJHAOq17YBFZGST92Hwu7GL?=
 =?us-ascii?Q?u7M9IJxnKtlj0aIJuABlviMyk7IiaSoUTbBod+WwI2HdSOp0fDVIzfXrQ4mK?=
 =?us-ascii?Q?5APCb3DEf6lFxY1Qr0JWSi6vAAGBIpP7DQ5Qae7w3UGqEoFSDGA88WQpHxlR?=
 =?us-ascii?Q?5mdBXnNyEg7wrGAVmYEjzYk5ozaVGwZ9Gn09L4RKwm4jQa/aD3U4Y0tDSQ1n?=
 =?us-ascii?Q?0zmlsJ0EOtSeOkLMaYu50iInaOpIAqfTAhuB1fpDn9XGClGY8JmSPUdQBDGQ?=
 =?us-ascii?Q?v7lp6/oexe2X381IS7UHKur4AYgyqaUNTBKakJtGaUW/89590JxVt5rit22O?=
 =?us-ascii?Q?aJBJiwBe+Hcn7EHT3v5+hGDFAMmZokvNTBJNJjmAFF3cJGtvyETDCB5yaTiU?=
 =?us-ascii?Q?jQZuzc9CSNZC67SErghPROXcox+TtS+X+TaLRggIWMEoF345cy/bgqMsW6Yb?=
 =?us-ascii?Q?ErUHFUNtvDVLAGc/98H9/EQkoP93FZiSGvt56ZLfi4oisqRLrI2E3KIs5cff?=
 =?us-ascii?Q?2mQBEq/hEX7KLWE0aSwZB6wh+yxBLj5LU/lz9M66JF1jAot23+912L+exji2?=
 =?us-ascii?Q?z5+o6aMxzhD3+W+7f3oxqNEWCMFi4KS0Lneodny/IyjtiVQUiUMrD/PVtVvG?=
 =?us-ascii?Q?xDWYtUh7/coutq6pkGQi41KbigaEznHEitGTi/9iGpVWzb8774kbm5AiM54N?=
 =?us-ascii?Q?NT8/fxPrsBoNXLgjytVVFCoTEqUzrj5BIoY0vXuf1oex7k9qvNzt0sl9Acjt?=
 =?us-ascii?Q?NawzxN9QN1QoGvWB0UtSTZTYLdeRLdWEfBaeNinSaNd4uQdjGLD9lQnXBizI?=
 =?us-ascii?Q?TeKce8VU9oczWvE2BsQFVYERafnQpI+ChLjt1aV7entTkeWaOIzETB6O7cF4?=
 =?us-ascii?Q?bghnKgL/dJ5zOAoZCME56nx0QwdzRMCmGngugVlcjSU4toHR7JFDfSpUzKhn?=
 =?us-ascii?Q?qVS/cxHKTjnBbn00fR7KkgZ5JzoaS+hPzteMhny7SJra0pPdxg/ropuiPeBx?=
 =?us-ascii?Q?j20kUeKAiYS6FbsVbEc6Iq8hvy0fQAfsxxEfsp9o3JoVdpZBaXrb1EC9x6QE?=
 =?us-ascii?Q?g48Y8up77g/qqzHmJSOlUkhHPlyxU+vcMpcAs4Im82+fbN4arswew5hxaA3J?=
 =?us-ascii?Q?00yyeESPWk30ErPqzaEZMAX7UjBS9eeZ/pXLFiXbixaMqKYu+KaEf1/bvjA4?=
 =?us-ascii?Q?e6WSjP1cNQETKcVHrzEcTrnv8xwUbuN4fGhQx8j4WOhNcGEfe21GQy/BwTYO?=
 =?us-ascii?Q?KXsNmxj81X1ZyMPzHLBGuFmfQWr/7xP4Tr+F5bJyrzMrO+NFXXwgzlN1SiG2?=
 =?us-ascii?Q?EXajH8KP3bLY9JiEfdBoSTDYRrDcCgZtfY0PKtS0kpovBPnJpiN9XYF1SSGE?=
 =?us-ascii?Q?IaIQNeIYfzdgujOnZhcCzVKNIaJVZaqG0y81G+tj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823a01f0-ac1e-485a-8201-08db31b2f927
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:41:36.0925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Lf8Pz/KYH/r98l2/I3DMNZEWnj/Cx5T1MiuY/XhLG6SiFhql47a9hs9xOsus/xuOfPQK4BlNkqu9TlY16DziA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9271
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
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

