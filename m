Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3796D3DC9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjDCHIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjDCHIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:08:16 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F30D32F;
        Mon,  3 Apr 2023 00:08:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btQ6UCSHzaS4AvdBM/49CByi9d/XkAKbUOOSnaEcfzeIIb1AnlbEyggpECLFbnQHTW5gZKV5DccdrwzgS4kio+Ov2WsX0uALIK3sJjshILeRC6QaIUu5A2HnFpv7sjCQAQxesA/o3yZGEncvGkd9nIMNp4NX5RG84W2tszLmGh4qVBxrV1cUW6pnY6U4oAw9dWJTxSy8O3lwrYchc4JaJ6jeEljsM2u+Jn6GiRcG1bl9i1bRCvMg496ql7Bq5jr+jEk9HAYT+Myuo9qyk9WIMU8vNxUGN5WuYVh80cCpqJ1e1gEK02O5/TwL2Cqnk+U3Mhxu+2pCOmfIafWl88NnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg+3/Aq/jV2NT/K5QnH1Qj2pzfpfqwF37aCElOaefts=;
 b=YZLB+Ds5hqikpzjkktf+FtNK1+OMKxR6w8aF1HGGocDN/BWpXc2fQD4dOGscBysOxJcjjNASYuSiq99h5xF1sskLe61vyN2I40lqjDpe5eSBjL6xnwStwOML13XDsgtAPJpfbozdyf0b+GZj2wwDvUjRftpxwrCVY+t9f2m+bE0GjRIr+i9jHE1v6dUegfqdSTqeMjNKKuQAQ+98uzxSAqIpGwE4qxQViKhoLsLcH1QaqORbGo40qBdswhuYs8sDf4pSXqor0ozRvnvXCpz+Avk0yZTsFhsoQ8TupNclneVVBORzqQAEzpKqrHlf/06NL5HhoYkju5FdX4FZm1+Bxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg+3/Aq/jV2NT/K5QnH1Qj2pzfpfqwF37aCElOaefts=;
 b=Dg6HtG+ZjCILMeWq7XW2YLFqtBSw1ZAonVTqvFA2m0A/wZ4qwalTFziTDVXmKK/Y00kC5clpuWxJSlh3esyc3EDZDpXJdjW2nylQRE7jAQ45xKscqQjihNFjMMKyK0yVIiMZ+4R8GCeSCOePIx2V5p8VZ1FjBR08iSbz6i7pJAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8768.eurprd04.prod.outlook.com (2603:10a6:102:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 07:08:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 07:08:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V2 1/7] clk: imx: fracn-gppll: fix the rate table
Date:   Mon,  3 Apr 2023 15:13:03 +0800
Message-Id: <20230403071309.3113513-2-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: c741e9a3-c762-43e5-3b0a-08db34122f34
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fS8wzHn3hBC1WoGTAvm84pwb/Zm/WrY2ttMdgo4FU+IfUnObaS4b/GsJm4ZuNMFyAotkLI2N9kOhsWQLl8e+hv0/g4rPZ4cuFAT1RL/M1ekSto4PkSFFfFTHHCU/O2WsvfP6nvybboDWI6NHSalrQLMyypS0MN1rdBTgvM44W8D85/GqtHPvduXE/o92fx89qGIZxFPhH2c39KJ/8iTjy0BmYj1wSxNdHbHEih/NZZ3OxnCcMnEWxUNH6n15Td/q7LrZm/vdrEVX8WusUvuAgd8G5MF+CILyogBqoBfVH+6BlCuRtSt+RDd8fOKWQuTunjwQPtIGpi9bDTETYXtwpWKyfAi6DxG0f7yRlO6wKWqDwEKcESIiDP+pRbarNGVwzsjsoQ55MNmMzfaJuJIyGZGlWg8g8DgMEwrMyFvYdXsJfwl+7h2Y5cU1GtF97aTkOWxT2362qqO9peKHina1SX/5oGTwC/yByxWK60X0ccOPpAblwrYrotB2j1MMZvhPoRTjvUuGGG7M+82sWSqmS02NIuAM6ykcFqB7KFbZVnpfmk0pCY1cHyIuxeK67cRQk6xGLAynJGhBAEvlPdMfo/MKezcSfvnKpAmhkWAwbc5oGyW7/4hvPnFX6hL0OJh1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199021)(4326008)(8676002)(66946007)(66556008)(66476007)(316002)(54906003)(478600001)(8936002)(5660300002)(7416002)(41300700001)(38100700002)(38350700002)(186003)(83380400001)(2616005)(52116002)(6486002)(6666004)(6512007)(6506007)(26005)(1076003)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VshAt1c3HSCsLM+6qwjlOIA0KPnSmtMQ4fx42YmERNPemxbBLbhyEoaYHXTn?=
 =?us-ascii?Q?b2RiUp8II5TNClFpTZ8LuO+ey9UZFDAMBfQtkMcqwQoVtOFhP1Vy5Q5mCJgZ?=
 =?us-ascii?Q?28McNouf5OF19z0MdArTJQw9RsytWNHGR7mPGtZIjUZYPnF6ZPcvz6HxirZF?=
 =?us-ascii?Q?QGauI6MXgs9u3g0lobETD6eX1UCf/9T3r/R7zO5D4wM64PCkXn7DiiRT2rxj?=
 =?us-ascii?Q?nRYCOjfFdiCekxEgSTj+Iiu56dOlPDd7ZkCKh5DCuo8a740XkBsaVUy5Ood0?=
 =?us-ascii?Q?ajDa7tMk7rw4bbVqacsflw/Ob0BKfLkzKB2oItXDB+jiW1hlm1vE6CZnvl4h?=
 =?us-ascii?Q?aKXfw7ePFXk+V9l2BXwQcMo9mOvi6B5KZtvcHIypVFLiL/c6X7v0lmW5LwXu?=
 =?us-ascii?Q?OwZw/AkWT0Dh31tyetJm50v91RAtv5hfxMJA3Uz5XwOtu+QsQFZbx9xgMd8v?=
 =?us-ascii?Q?UmpYLB8KMbI1fHibx2eL4zOo9hVii7JGt+tdMZ+47LA3i6J1NoRHhkrABlvL?=
 =?us-ascii?Q?yk0fdxGwShKiif3OsPvI5mMfnLjgCB9UfKjYeEh9/VwoIakI0wkRNQUO6bRj?=
 =?us-ascii?Q?VsnrqbQLiok276dhUPD9iNcmWcpSRcuqVDY0UU3ndl04DGMG/AowjaKI8m9K?=
 =?us-ascii?Q?dJRwytIHKRKCxVgWO5F5CoFnFw3iERAsWvGpu8lTkT1toVtMoG/E3ky6iIwr?=
 =?us-ascii?Q?/5bX+DZqweknzCnhnRzVUWTTfygujuAcsTrTZXBocm/1H1vQotmJsw0Gr34O?=
 =?us-ascii?Q?c+5dU8U+FL2IpRVPcFOIc8ZXOMdkEukbYIpLg7jztiH0IHLHntTUefxs1/Fl?=
 =?us-ascii?Q?61ru7rnChI8JGqteUYiDBWoqKGJG8LVXcrFbniFS9DLN+O096ZjEKRmD0XNf?=
 =?us-ascii?Q?PtxcFmd0ri/omNbklcMrUoA65JjIom5o9l6TqreZGylShN5+bJ1IVBcWg2I7?=
 =?us-ascii?Q?l/flR7H/3t+OjsWPHZlBX8DbJtSbqeETMir3AXSYaAluQSkYBA0EvFXF4kOv?=
 =?us-ascii?Q?0/D5I62DBmD+RNp0l0tIxAJXk3lugnlsFOaBW1aW9F+TYaKllAqJB2tMtxkD?=
 =?us-ascii?Q?LW/D/shlKWbaKv3nOsiKFw+6OAUJrCfq3+YzskVDjsM/DeX8YqTUtZNz7K9m?=
 =?us-ascii?Q?WhiKTttjg0jK321UT8hvQu8j1DHFv5GHFSUdWDITT1TPWqoY+ftCJRXKyMJu?=
 =?us-ascii?Q?Sg8D1f42tUjWm5MbHh3+VpzfHLwicxGeHVantBiK7ET4eYwtvxNiVb2WCBGi?=
 =?us-ascii?Q?q+41FUFXhK6ioAkom1GeQ6V2Dg1Ii+SHa4YHpNGU8jghVlYu4txI+5/NUx1o?=
 =?us-ascii?Q?349KOcaVF4HCJgqlthfN4fEnFUTKdOShsR6ycUwo+H6++94qSOnAtjr1pj7M?=
 =?us-ascii?Q?EH/tiZ/B/virIDfcaYVRh6qsSS/D2pma/yULifVhE16wvFw5Sq193SoSp472?=
 =?us-ascii?Q?1oCVCeeIv+FWfYMRYQUA2S5rlsBYrMxIKynq4/j0Xfnxyv33p3wpOLHjY/w6?=
 =?us-ascii?Q?Cn58wvv8iHNPsn03lG9GRcxS3W8seh9UFV/FI/nML7XrsyM7aeanhDjshWSO?=
 =?us-ascii?Q?4a2J4JIrvkHs8ERpQoDsgeKmIAmOkwTzKaa+4Hg8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c741e9a3-c762-43e5-3b0a-08db34122f34
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:08:11.2849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AK7imiuf7AxYaezueueY8RNslL42ovxvU94EdSzPjgAJ0d3H236JRKgJrm4Eum9f9HjUIQc5McE/K8AaBInriA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8768
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The Fvco should be range 2.4GHz to 5GHz, the original table voilate the
spec, so update the table to fix it.

Fixes: c196175acdd3 ("clk: imx: clk-fracn-gppll: Add more freq config for video pll")
Fixes: 044034efbeea ("clk: imx: clk-fracn-gppll: fix mfd value")
Fixes: 1b26cb8a77a4 ("clk: imx: support fracn gppll")
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-fracn-gppll.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-fracn-gppll.c b/drivers/clk/imx/clk-fracn-gppll.c
index a2aaa14fc1ae..ec50c41e2a4c 100644
--- a/drivers/clk/imx/clk-fracn-gppll.c
+++ b/drivers/clk/imx/clk-fracn-gppll.c
@@ -60,18 +60,20 @@ struct clk_fracn_gppll {
 };
 
 /*
- * Fvco = Fref * (MFI + MFN / MFD)
- * Fout = Fvco / (rdiv * odiv)
+ * Fvco = (Fref / rdiv) * (MFI + MFN / MFD)
+ * Fout = Fvco / odiv
+ * The (Fref / rdiv) should be in range 20MHz to 40MHz
+ * The Fvco should be in range 2.5Ghz to 5Ghz
  */
 static const struct imx_fracn_gppll_rate_table fracn_tbl[] = {
-	PLL_FRACN_GP(650000000U, 81, 0, 1, 0, 3),
+	PLL_FRACN_GP(650000000U, 162, 50, 100, 0, 6),
 	PLL_FRACN_GP(594000000U, 198, 0, 1, 0, 8),
-	PLL_FRACN_GP(560000000U, 70, 0, 1, 0, 3),
-	PLL_FRACN_GP(498000000U, 83, 0, 1, 0, 4),
+	PLL_FRACN_GP(560000000U, 140, 0, 1, 0, 6),
+	PLL_FRACN_GP(498000000U, 166, 0, 1, 0, 8),
 	PLL_FRACN_GP(484000000U, 121, 0, 1, 0, 6),
 	PLL_FRACN_GP(445333333U, 167, 0, 1, 0, 9),
-	PLL_FRACN_GP(400000000U, 50, 0, 1, 0, 3),
-	PLL_FRACN_GP(393216000U, 81, 92, 100, 0, 5)
+	PLL_FRACN_GP(400000000U, 200, 0, 1, 0, 12),
+	PLL_FRACN_GP(393216000U, 163, 84, 100, 0, 10)
 };
 
 struct imx_fracn_gppll_clk imx_fracn_gppll = {
-- 
2.37.1

