Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806C973D0EB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjFYM3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjFYM3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:29:02 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2080.outbound.protection.outlook.com [40.107.13.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9461F0;
        Sun, 25 Jun 2023 05:29:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSTx2YOWBiAugM5EBtuaLmaQ3QjQAKaYU/skfelSSIdiP7X42Q4jA0xNJMd7B0RGv+BGq4dL52JQKRgE3iikHEYl06uI/eHCWJBq38V4I/w0a7piPXCGfO4wTdrxVSeweJud/eYuEPYki5/NOXJv3KztPFrRQkBSwADr/P1QA1uaZJuGu4tdQ8YreK6K2mQstc2QApmBuJMrYpwTJxh40AthSjsmdajAqJsvxsn6/7BQMw7DOZQRZ6ivPDTZtJC7LxpFHrJa/CQSmn5pGG/bBWZoexB8YqLg8pFWWVblmqxXk+WTYAbO35LvVepXK8GlrfMaM3Ew9vHDrE3OF3aO8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJnsX7cUjZtzq8aJTM8YtCWwXVsh6WPR5DM4/3FtMew=;
 b=dTXzKz1v2t/yWHr6xRz4UbMgpPTVnLJiitptBCTZ133oee/vUTbe2Fg6+gEcfioQWMvOHO3YZU0qsQ+iRxDVNMyMWm65ZjPDq3tU3+Hhp44N3jW1B9LyS1EpaZ5vx1xesCawwai6ecL9IzzYZj4CEp+7qCnXqUQH+WFjN0Q6phvKweQStG3F4iNaji8DODYa7e1v6E9xsK1T1TlZ5JZrM2HMdXWTCJOB6TFKZ0LAEcHY/wshvcY0d1W4ZT1OqklEJPo4EDmZPdBDZCZF3KE37pcy8Jpa9jHPB+A8m5jC3kjoukOJC1QNTWOsZKEQ0szuGvbSD4LE3IzDpb7jICRdog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJnsX7cUjZtzq8aJTM8YtCWwXVsh6WPR5DM4/3FtMew=;
 b=Rod8Tz5nR9zDsXLDvgyGZBbNlW+7/QnAcV0rkVvTfxM6aND6QnZcDWaIRmIhgEC42HRS4iz6cgnJR2dTCOnYVLIDVxS23FhIjH1CdhUAM5GIRrbYm7PxgJCfYCz30Q6S2gnZziZlPbGqIDGW+bqTMc4ByfpU8HiWO58BWH4jAu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 12:28:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::efff:43d6:6f46:eea%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 12:28:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] clk: imx: imx8ulp: update SPLL2 type
Date:   Sun, 25 Jun 2023 20:33:40 +0800
Message-Id: <20230625123340.4067536-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230625123340.4067536-1-peng.fan@oss.nxp.com>
References: <20230625123340.4067536-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: c35e2bee-c2ae-450c-95ab-08db7577c02e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M06CHelAUj1I1r9HthexMwPlWk7MHCerzLqbqeh5pnkimbLgw+kXMcs6v3g8l9YqbBQu4tI9zBfNeQvgofH3DyENUT3GsC6+UI04k74I7TcDGAyjYbggtvZ05sABTRWmLLy6pDqq+Kyfx/VBt0w44Mne38HVQ4YAfkKsRP6TXxQVBG51pJnDuNYJO4IuKUQRKz16PWTN7gCcC6exiFjsWLqu+MrG/NEdmMtz6ukcTO8odXGd/4FWk130VBwGvlhj6VhslI0MP0VuoCt6nLsl2ed4buRTPuuSuhHxZ9zIiXvnONgzerQ+XKOT38Vx5Oym4JirY05NcGpI/sCtgANxjVHKxopTtXZiz26QN6jYgD11nAh64GvpW4Pba7UOx5XoHloO3T8PGsJarJWh2p/GI4g9RNp16SrzT6yNWG2eZ+B9VQMoKnpxPchbdH6z5krprlH2v5wLSjMoXL15IQ5ixhoV23Qn4PLB0Qi0pw19+kHs5H4f/ny6iAowAoERjpJwfqssFv4GwgWLsYs0onIRmBKpK+s8BKIYHyJ7/vdHMX9c0OQK/gbRdgBeZUg6Ey2DNkplsoE41CaVnpZDRLlA0lWHEYzPEW2ickFhfQCOiKMD5f6Fb4BroNaQlm9ngmYrvZ4G03Rwp1yD1hcdiFr3Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(6486002)(478600001)(52116002)(2616005)(83380400001)(6666004)(6506007)(6512007)(1076003)(26005)(186003)(2906002)(5660300002)(7416002)(38350700002)(38100700002)(4326008)(66946007)(8936002)(8676002)(41300700001)(316002)(86362001)(66476007)(66556008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5A3KTW2yr/fRnLSDG5B+R585jT/COFtXM42P8T4ogoz5hJOrazVk1IolaybV?=
 =?us-ascii?Q?B9OMl5dq4tUqSfPQKDHhaaaGTaflbkyMB1WM3j3VmzbW5sj9iN8vYmnHbZyJ?=
 =?us-ascii?Q?VGetih0YUZdxFxkxTx1Gf35kP5bRpwDFxOgHecYdQGCXAFieQ/596z6SGmMl?=
 =?us-ascii?Q?jTZq0dUzsTdBFofCMC2YU2QdNFj426h0KrB4lRCZ7p2WpBpmtHHj851hYGxK?=
 =?us-ascii?Q?wR59nK3XGodPiWKGqxxY5TwvxOXHN0e12DGXXR3KlAch0b53MF/VVD5vPNIv?=
 =?us-ascii?Q?tA3VTLHkL813M7dzvDAjQ75zQHsc/b2k0VJeiJLz5atauC4imMLL/wunIpCS?=
 =?us-ascii?Q?YzKAnfBekqhPTcSM1uIpfPa0mpHP92j27Le2rHsI2GLympG0M4B6UcI9K6Ej?=
 =?us-ascii?Q?FiIMyTxHOQNtXg8kavaFGuZZ203ZDMJxD8wWAduWTFQYCLGBaNS+wgmHGEQM?=
 =?us-ascii?Q?nQsyWNiAsdd0KWSLD1RcYPYZNDtYSt8wrYZf0fyc79YI19lttfxnmFifPCs5?=
 =?us-ascii?Q?A2t4OIS4MggTqwwisiVptBLBUC6bYjrkE/Wc+B1DYGBGIqtvxn1YlY96NrIc?=
 =?us-ascii?Q?rjhm3/03nu/YihaSFFXtCKHSzeFCwKsSPCnkiixKBbOB/PK8R/q6hg68/dq/?=
 =?us-ascii?Q?HHPRS3ak4n6iAiqVViZrH7wE4NSz7uc1lHaN1PrjiQRqDIY+xCVolVFbf1DI?=
 =?us-ascii?Q?y82YBPhi5jBc6zK6j9cjSbw3strYbAmV5tQp0ppaW0M7BwwYwdLkT0lMmZuo?=
 =?us-ascii?Q?DaeNjMITt2WS8I6pbLgJejml/u20em/H9RLtMa8qqzEO3UBPkAH06LOTSsSa?=
 =?us-ascii?Q?pesMxzcu1GRSFPJZ4xFyq9WxRU0wn0NHi5YDGFiyLEVmJP2IhTcqQNWbfwFG?=
 =?us-ascii?Q?4nIe0KMm4Iss33dwgqiSIY/prkflL8M2NEsmSJszawqOIZXk7WSOWBWtwBFd?=
 =?us-ascii?Q?xfTksbOzIit4MAu8dim0sEITNNFtEHwj905Smfq1V39StrACkTuT0IEXiLXB?=
 =?us-ascii?Q?D1tiXmo9IHGQBqVZrj8cdm1kzI5bau9C4TsfVP3My5x+G9pM15Hn5yfBEMMn?=
 =?us-ascii?Q?qyYroksXHpE3t2cBYz9kaDwvEOFa0UDaVn89POfRPcSjf9R5eEfD2yzWMeCR?=
 =?us-ascii?Q?GdOggeoM3G/USOR9UH2fRXhptQErWN3wChpEJluv4VAuOpm0YIYKoY1ZDaqJ?=
 =?us-ascii?Q?r/3muf9JqWQ69YmOuCIxy/TxCW1hVPCB7QGeuTNKOUvIkKzbTiTo3QxAl3Qt?=
 =?us-ascii?Q?7bDdw86yANM3iG0uI89VjKhc8zmzer7aBHsukvq+qbzQjBmtpkjmlIsXeED1?=
 =?us-ascii?Q?FmpN/AjQt2jWwTLDl2EOPpv0VxCBaxqkcKZJmydK83YcPp+yQBooZ0ds9d+g?=
 =?us-ascii?Q?GgeoZIlshCa8xOQpnK3ZzNMI8AgtcJrhavzjF2kYIhxU3aPAsT79rgts1FxV?=
 =?us-ascii?Q?tNp1o5KIeVaM8M/jPQzMReDbiiWexO4zShJeRh8lpCqBVEppZxiK2mtWSomC?=
 =?us-ascii?Q?HgPHqw0CEGgdrB5C1S6fUEs3sf+ClEP+By5YRANiMOxXvwu/dTZphwPCKqpD?=
 =?us-ascii?Q?QhmnjIGE+64p2/LblL4AzRDhajL817VgzoXXeTnr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c35e2bee-c2ae-450c-95ab-08db7577c02e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 12:28:59.0795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wOe2uTVxyXTmdVnZuj2LRmM8B11qC66kFrGYbgXRAoBd6U6v97d+5/PhA3dQcsexDX2FQlFvNzYsMVgJDvJaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The SPLL2 on iMX8ULP is different with other frac PLLs, it can
support VCO from 650Mhz to 1Ghz. Following the changes to pllv4,
use the new type IMX_PLLV4_IMX8ULP_1GHZ.

Fixes: c43a801a5789 ("clk: imx: Add clock driver for imx8ulp")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8ulp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8ulp.c b/drivers/clk/imx/clk-imx8ulp.c
index e308c88cb801..1b04e2fc78ad 100644
--- a/drivers/clk/imx/clk-imx8ulp.c
+++ b/drivers/clk/imx/clk-imx8ulp.c
@@ -167,7 +167,7 @@ static int imx8ulp_clk_cgc1_init(struct platform_device *pdev)
 	clks[IMX8ULP_CLK_SPLL2_PRE_SEL]	= imx_clk_hw_mux_flags("spll2_pre_sel", base + 0x510, 0, 1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_GATE);
 	clks[IMX8ULP_CLK_SPLL3_PRE_SEL]	= imx_clk_hw_mux_flags("spll3_pre_sel", base + 0x610, 0, 1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_GATE);
 
-	clks[IMX8ULP_CLK_SPLL2] = imx_clk_hw_pllv4(IMX_PLLV4_IMX8ULP, "spll2", "spll2_pre_sel", base + 0x500);
+	clks[IMX8ULP_CLK_SPLL2] = imx_clk_hw_pllv4(IMX_PLLV4_IMX8ULP_1GHZ, "spll2", "spll2_pre_sel", base + 0x500);
 	clks[IMX8ULP_CLK_SPLL3] = imx_clk_hw_pllv4(IMX_PLLV4_IMX8ULP, "spll3", "spll3_pre_sel", base + 0x600);
 	clks[IMX8ULP_CLK_SPLL3_VCODIV] = imx_clk_hw_divider("spll3_vcodiv", "spll3", base + 0x604, 0, 6);
 
-- 
2.37.1

