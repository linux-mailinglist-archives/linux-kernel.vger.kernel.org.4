Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04F16D412E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjDCJtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjDCJtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:49:07 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE04812BC3;
        Mon,  3 Apr 2023 02:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJuJhB+qDpcYbETpCV6pTHjCTvlyI/2jQ47ghb0/JnlV6Vw9EPVhqISHcgQn7vJFuBP7aaRrvsccdb3UUVs+ji07ynPZFYKqq1V3r+Dr2d+iuFh+EAapVc+b8lwDOGsjaEMwTiVFECSpfnAmxcgeboMutpMBqMYzRks3L2cXTR1Exe5PsSw/BLODPmjZNEMLG0of78rBnN/IWYcm6t4V9eORwcE79gBKoqVrctrIDK/ummVxlVsraPFD8VimBuRQAcRSuw+mLLiB0k0oFnE901bgPC+mnzQcBRSVaiZMBDWKcA/cJa72t6A6vqELU9HsBeBjQUf4uICaBpJkwkpBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD7fguA+0DuPJzyBK/J3/AbOnO0yns7W2/60PUlIy2U=;
 b=lbolTuWl+WLENGXc/4r6flbvktKj3aE0GJbLst6DEnW2bWcyAodTrv0ohDls/6W7qDY1NPlvb8o5juamk2KlLl80Udl2TVMpjzFXpFrqp4COyFlabhY0Psrv4/eyRcHMHWViHGQuPtmvV3CgQwAKTHKubIXY/hQ9rL7I7MjWUsble5zAgzzYQsBlVslTSWzZgHPN/9R8v+jq59oQa8gTHITzgh6Gfi3K84hsrDmQFWs/Po3xN/DuuoR0fVrheLSn0iaytqjTR2WWhdMDjBcKlncWkzhQ9eZvnvKt7AyskHx8BsnLeh+dBaY26llI92FqtIb3Hjz5mlrLtmD9xBmgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD7fguA+0DuPJzyBK/J3/AbOnO0yns7W2/60PUlIy2U=;
 b=YNtaJCaE8s809ToZJcsz2uo53Dvy8hmtq4ipgtGbzNUE4kwSf1RgLNbdHQ57nNM1f72S67lECSGI5/sZy6XocOo5YNYB6lQ2cFx0w0BFnvADE5YU/nJwf/jTHIU10d1TDN/4x6dBf4A4HBRKW4Wal2WYH3203m3Y+OjrcM9Idic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:48:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:48:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jacky Bai <ping.bai@nxp.com>,
        Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 4/7] clk: imx: fracn-gppll: Add 300MHz freq support for imx9
Date:   Mon,  3 Apr 2023 17:52:57 +0800
Message-Id: <20230403095300.3386988-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0a84755b-ba4a-4710-c2dc-08db34288c3b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rM22tJCqXLLKeNcFpgnB+ZIm6mbw7gVAZsVZyp9oxiNnSpARO8u8wf+6dkRcaDyBrUYJ1okXf4Ww5VB47dAUvRuPDiC4FiO8zdMt9e+i2ka5On+1BpQP5Cgw6gSM9q5Z4s1hNNWdPXt53eT1Y3Ki3zEQKJBZLQtaxbNOCkPfjp8ou07Hyr7c06xLRyYY9XBe0twgB57A1lk2DnmzHJR+r2+1yJbjghZUBhyY0tJhUAd2uX+EC7wF0V6pXxMubMRCLdcVrBYwFlJnA0K6Jo4R+zZEqSVGU0/COLj2/INSlZvkoBv9IJSjSWJcDm8akuW+Z2O6v5pEXtCzPWshzIg94ZBED+jsk0eKKRc2rcgfX5oGtiK6F0ehLzgnyDYOkRuvnUhsGK7yO669y+M292Q6XtxGxt19s6gwoSWrGbv4meKhbXLk8mJ8vrFhF+exnpD8gtEp0gXUs1yivQ+o+qS+CF7InZv8azSfddEfLv3t4f8ut4G+IZAzqRdaxHEKBjwGVWbkEfApwuWijZaFHZO1SsxuK8vEXm8DvZ/z9eXLfCRChESM7h553/gjGMsYIoQqCrr0UTWSYp87HNG9blslX41vZaDoLxq7gc+0ESrZVPMK8lmfNfSBOJk+x/57LHG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(8676002)(4326008)(66556008)(66476007)(66946007)(54906003)(316002)(478600001)(8936002)(4744005)(5660300002)(7416002)(41300700001)(38100700002)(38350700002)(186003)(83380400001)(2616005)(52116002)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PNnAY4H8EWR3j0xJBKMfRbUwsDxn/PFhH354F7Tj25TdF4g8/9KiCpoDWLyX?=
 =?us-ascii?Q?aCmBC/7rA5c3Ig69QJbtH07yQ6+bXKrRFXRuaE5eYdHMeBUwJVMKlbGusf7c?=
 =?us-ascii?Q?5Q56VJochHbyxHnwIouKiHIrhUAB8fQMEJX87xQyWQ5n8R1NXi64Ol3IJpOq?=
 =?us-ascii?Q?VFCuabv5VUwhs2vImxJUCNNumF5rnadHGfepZ/JSKRoSY6XCnlQXHdeKwrs1?=
 =?us-ascii?Q?AzOTxK5vgS84NzsmBPfM2qAbhyozSxhGBMZGbyhvKBS15YRd9tgIuRVaBl0n?=
 =?us-ascii?Q?GjUfJUXNnwXgFS6INzJIUB+QB7fNPL6TKgNDHG750zy1Z7Kv0ryu7Iei2hOo?=
 =?us-ascii?Q?LgBnSPpPYUU3PlIrKaNL+JijSv/f7QWG44OUhIR7YEQ33uHqkr4uwpYJ9dEL?=
 =?us-ascii?Q?a21/hQq8OaUE01Un/mSX0giaaZjw11hXqKCqYSAoyyo9+cXaV8o+uDlDGDv9?=
 =?us-ascii?Q?4GD4wADqLrZ9JcMD5t3x76bUvPh6armHZFgGxiCpygp4dEyAnDoSEgzuC2pj?=
 =?us-ascii?Q?XZMx6uOre/rXnbgCJWaU5MPomGR+2nPCQGvJ0qgOe2dfh3ay9uUbKurfKKPc?=
 =?us-ascii?Q?i5htOxoAfWuaeBTdXSsceILPJ3P99rOPFjH6ZZtfG6wWhkT564jGDVvD2swz?=
 =?us-ascii?Q?up28aVlOwoqsW0x/jtsvXyCxMVhRK9MnUWS02v6WVsOvWgcNhGHTxXTqMTHT?=
 =?us-ascii?Q?Np8FrTqpm8QMr2o4mmlCudWmaMjjA6oZJY2pgTY+SUP9wsNeiAnFjBZy0VKA?=
 =?us-ascii?Q?FypGckMHhiwTKSZB1ei/ZyZA9HBaZMeI4+Fv57sYD2zAxzuuzaJfui1mGN5u?=
 =?us-ascii?Q?0oHasHhymHt2J9z667PE/CUNApLVNcZacEriGeSWMu1ttJSligDPWtqunsS/?=
 =?us-ascii?Q?bTCSyFbu+J7aHdNUR4bgbxHCp7MJtrR0W4TNi8CJgUJJOt/Pgg/zlSs3lF6K?=
 =?us-ascii?Q?2qpfM9YCHvkWcPWQ0Jnd3MCy4KxdBQhqq27ZaBBkq+HIZf/p/scaeRPtKg/a?=
 =?us-ascii?Q?P0kbtFAdjmc7prj2SZadR3CsWcTw/W2zn6qViw0vQWsqN/HDoA3DqFEx4KDU?=
 =?us-ascii?Q?6ornM0Pz6TIOZWMpXEc9QE3YslD7H8HM8DfwZmG3BEUdwweML62ogSJdUop/?=
 =?us-ascii?Q?rSElrEz6npBvOoeNVU3ZBESzHikKwg33piKVW7gSukjO7zdqHcQEUrAesVd2?=
 =?us-ascii?Q?Rx5BxitA9ZDb8YN7/7Km48ShxSe450OK2kYQmdRoL1mzKEVSXshKbq1gh367?=
 =?us-ascii?Q?av9jgT3Hb916t746kSRhsvIROCee1FC1LZVyYDQcLXyhC5bl7x3TdaQ7dH8h?=
 =?us-ascii?Q?w1CnZj4WA/50Y9l2ap7jmB/6ThnkH4ky22seoo+khh+wOj64UJns9K/34ort?=
 =?us-ascii?Q?zoOkOqLYRhNa9daYpkTt5i18/lUm9L3xMKSco7s3YuW0/Y58XKioQl/MNcos?=
 =?us-ascii?Q?dHUHXj27gRnCxNzbjAYrzcG7y3LALmwDYB2XW9bzSzENb3laIKTQooiKGk8q?=
 =?us-ascii?Q?bBwSY2cUXRHmpLdDrHOE0ceVKjWzdV7uM9eQ+F/MM4/MoUnMBMTdfV+oXq+Z?=
 =?us-ascii?Q?3DscCNlYtQAdODeGG8MWDaxoCRuPTwkgOC23fvTl?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a84755b-ba4a-4710-c2dc-08db34288c3b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 09:48:16.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVWzGT9pCuuXJ6pHNeDOOBXageYk8xdDmv+16GxYUTrPBxtaFkw7KDLqcWaDER1SlvOgZXg1VwVuVp8l1oZVbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8070
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

Add 300MHz frequency config support on i.MX93 PLL.

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index e2633ad94640..c54f9999da04 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -85,7 +85,8 @@ static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
 	PLL_FRACN_GP(484000000U, 121, 0, 1, 0, 6),
 	PLL_FRACN_GP(445333333U, 167, 0, 1, 0, 9),
 	PLL_FRACN_GP(400000000U, 200, 0, 1, 0, 12),
-	PLL_FRACN_GP(393216000U, 163, 84, 100, 0, 10)
+	PLL_FRACN_GP(393216000U, 163, 84, 100, 0, 10),
+	PLL_FRACN_GP(300000000U, 150, 0, 1, 0, 12)
 };
 
 struct imx_fracn_gppll_clk imx_fracn_gppll = {
-- 
2.37.1

