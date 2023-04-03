Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA61E6D3DDD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjDCHKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjDCHKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:10:04 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2079.outbound.protection.outlook.com [40.107.104.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29158E3A0;
        Mon,  3 Apr 2023 00:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGlZyCXgpmtUHUCfjbXFhO9Le30TPH/nSPheF+Pg3svkcIiZsd1bfrJwDIAe3bc7x7PXMPtHdIo4QQx5MPXtbBA1VC4fOA5Nt4Siv4mHorQGzzfHxDaaeBGGyUFA2zloc6bKiNCyjyeTIf6S76so87iTnrrsUuJkA3TbEQwcGdrbjQsv+zxXMXgk2iL5RnOZJkxxZ+7sVqMbG5O9YR2DG9/qki4Z4Gmk5Md3cQuzqd1BWKeAYK70bPGcbXiCXFHS7X9I2BFhJYnP/BKz0ia/PN5xdhLA7572ySBT3w9KJeetbJrs6v7dV1q+Tpy1uh9Nozj/0bTWAio6ceXbhhwCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoBQJAujs6fATBYwHzRBjS5q2UlOsvkasf4N1E1xl5A=;
 b=gpjwmbdldNXOCz9zIoX3taGHax71wd4kGZJVtuywFHxRUQdib727gglcCf6+yGgy8F3sBDnpkRjjNf/pZnYYlk5yKZJ+Q/UjSbJTCrTQZfbCM2znPJZDQglKGu3zDZVoGLMHj85+CEjf0OFC8r8M17mbi8keyvnv1liwPH1l+HIF9kfFBDmKzXW29HepFL3tlzxsOnX7YocNTwhJgb8Mhfp0hORc3HES1FdLZp519zS8WxQ7ZkLR9a3nm3G5lwOq+3WaP6pVSjCnko58cjInfVkbmX8/UUFxc4wK5DWxJPWrP4Ry7fMgDmSzWStrsZAJ59PJ1kihgeGtevjmEnsQxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoBQJAujs6fATBYwHzRBjS5q2UlOsvkasf4N1E1xl5A=;
 b=aFLUxFi4l/efeFc7o7wbI/f8yhOxse9aXhz5/Llc9I3kfY3rNUbWlTPbIOVzzKM5GWqVTK3apO1RqccAcM9aCHkfHHhvmu8Hivs/ijQz9iy5IUmvAkCtbQiz8W2yH+abT58hqTIO/GR6OkD1XUlHCLlcSiqiJP+8rdYOvqvMPlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9457.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.28; Mon, 3 Apr
 2023 07:08:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 07:08:40 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 7/7] clk: imx: imx93: Add nic and A55 clk
Date:   Mon,  3 Apr 2023 15:13:09 +0800
Message-Id: <20230403071309.3113513-8-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b724327-8bcb-41e0-9555-08db34124062
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUnUyPG+L7zg0qBloN20gX+nVIYWYWFWRU4y6sM+dfKydcay0KOUtsaek7hfp6vljFNAo5TnO/oBNmpOomerG8sfSWn5rIh+TjfUKcu+Dc1UR9yFD2pFWjdNzkubnQo2Z50HKEh0zaj5iiZ/K4qCaX7NOW4SCbxVNagJkylGi7MAWzi4kc+hTEU/vT2ExDpNdx5mZuqeJDTmJdwzJEYCadX+NdV56pQ0vBl59sdhYoOyLWH2RwBxF2yJFOAcpoBYBSUhlF352g77R/+vrb7lc6RyZ+MjGaq76zhnpmfYjf9ebphXY7A2lc8ngSEYOQXQOSgjMpTpFX1XCD2KSSgbqiWunkogBNjKvL+voQ/nCIl+qpizt7KnHP+ktZDTmzB4sS1N4zNwEBzBlnp/qT1tl9ue6SzmxOpljTjEy6Ms8CJHfa5obpvMKfeDDRkhJxfX3HRotblRuX3Mw1i1tgIUgfh4qMbDZivCV3GBTxwMGoptyEql/fesaUpT0sMMooafTXl9+ebsQozeq97LIppk1EzWEDWt4zC55roAN9/oj7aaMcqP1k3A1MkU5l37eXxzXPQaEJBjhSJ/KTwAQ4Sg/MgqbaueioxnNxsRvQMRvHI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(8676002)(66476007)(6486002)(4326008)(316002)(66556008)(66946007)(52116002)(5660300002)(478600001)(8936002)(41300700001)(7416002)(2906002)(86362001)(38350700002)(2616005)(186003)(6666004)(26005)(6506007)(6512007)(1076003)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GAVGYMEN4fGfaKwXQBNgO5QlzFBa2/bUtYIkk/Mt4+ZnQ1ttkCZ9pDIw02P+?=
 =?us-ascii?Q?LS9uWXqjW1JvhDIyxFO7/jYtz3xuzunp+wkcHjFOr78j9h16TTDPdwvsi15w?=
 =?us-ascii?Q?YUabMsxy1sfuIMgIqugIUBIl3Pv88mLf2J40024u1t9GEgzgXNdckmXdvyk6?=
 =?us-ascii?Q?wlEx8SChm0PbzoD+rOWv0nR4RmortaRfQ7X6ykcr4BaTR/9RbZ/oJKcz3CBF?=
 =?us-ascii?Q?PCgvKp0Jej9iTEi8s75vT/X1PvWXq5iA3PNcg5SGYRVoUCO2rR6FktogUle4?=
 =?us-ascii?Q?9Fpz9ZvaxKymeNvfGAIhOOa4ogcQOFxnmsbB9VuXh3ngzMmmbgMJNHr0d0MY?=
 =?us-ascii?Q?4IjKOeqM7+mWBniKq21Kdvt2GEF1378NqqI2rL4KmQVGCEr1m3EuSnceEvnF?=
 =?us-ascii?Q?XR1Z56sVZ1njGAljRpKWfYPxUJaoJfKd2yMlBzInyxFQcgARSjNGdViVSNTr?=
 =?us-ascii?Q?RUNXduZTQVdh44VNR4r04cZNlCIstrPCXnlu3+YykDqWq7hBexI/mNp9pp+d?=
 =?us-ascii?Q?+yz3xoqZhi6ImxxmAU6zMd8Jdig7AzK/SPsErMUf3tDGvjWbGWp9TDkGaU9y?=
 =?us-ascii?Q?XZ60I1BZUTvP9ALSWt0uvci8sROkovjjQsaJxMG0qD6jAdVztZQRvOm6F1Xm?=
 =?us-ascii?Q?JZgDF4nuFaU1Xk8eMB9N3FxlLFfnTBReAt/SzRqjqTJMPVkKfcJuNvlG97Cw?=
 =?us-ascii?Q?B9JkQeFeMbHLwhFOCtT7sQ6aZ/wMylsCBG94WRPzJwH8Yuz2SxUBnxTr359S?=
 =?us-ascii?Q?G5vfDemH9kh+XDbrnaNIiVeMx18/VcOYapElkEv4+pu/9Zc25DkUvW2R5Be/?=
 =?us-ascii?Q?dzW2CoWoLeiLYhUQ3B0zRxh62g0eQ/BABBn957oU0ETisTSeClpuw1BrJ797?=
 =?us-ascii?Q?v0rcb8wSrhOSIJ7t7PAMvVcH4xW1vnkLv60P9O5xC2/sK15quKWT+PnFmtjv?=
 =?us-ascii?Q?4laoB3mT62UMYkZvRZegC4GpI1ITHOfjZ3RBN6kaDFv/e5qqjFT0I/zuwmgJ?=
 =?us-ascii?Q?+bCE332SxJmY+3p6u548SO/ohauFg6qT4T+1cow1jBdoafJOl64MdB4W/HsW?=
 =?us-ascii?Q?4Km9epd/jB6BW0LEvaJa8jvyEj3dN0sWO9T+68QLlcAvorMomByDh8fdK69l?=
 =?us-ascii?Q?0CSxmRzt1MOzt8zmqN33ytRVEJMIP6pmvssMvzWMPn8qI6osrP8yJG3aPMu7?=
 =?us-ascii?Q?y30/hCha83IN5/r05xox8YU74GaB6lJOmXck7ZrdE8lFxqazZPZ6iuWpyxhl?=
 =?us-ascii?Q?eqEKjTveYYlIEy0hp7D4Zm/gJw1rQ1zVk/pWWbOuWyv4gyCQOalKrZszKvV/?=
 =?us-ascii?Q?mhUN1H8TmYbu8lsXXkJuPbFVf3o9Qkh6i8PittSl9VxIkrRz3RHwPQVyzt1R?=
 =?us-ascii?Q?jh1KnacBEPcFGNmXYXTj1l88wTENQFrb1mxvWGuaXHQAAYs4Bng0h5ApIPGG?=
 =?us-ascii?Q?s8yNXwTGCNGl978pBjYXnEnRivkuTl6KcH6bKPJjMecv+W6bX/9iN94eZuH2?=
 =?us-ascii?Q?akahWSRUJFbSBGjowAFye32kF8WpQuFRyh4aS7lRm1Em9YK3LIEdoalOJkLm?=
 =?us-ascii?Q?I83+JHDHKpVC2V+ND29eAIU5waQcsZU6n34YjbuC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b724327-8bcb-41e0-9555-08db34124062
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 07:08:39.9915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vaJfvcUq1ljroWxTTej2wGPIOjwX+weQx+ffovLa4fVeqMDF0Qd+m9PtC07+XauAHc4kZ3NOKPOpVuDi+uiQ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9457
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The A55 clock logic as below:
     A55_PLL ----------------->\
                                A55_SEL-->A55_CORE
     A55_CCM_ROOT--->A55_GATE->/

Add A55 CPU clk to support freq change.
Add NIC CLK to reflect the clk status

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index de1ed1d8ba54..0edc836b3768 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -33,6 +33,7 @@ static u32 share_count_sai2;
 static u32 share_count_sai3;
 static u32 share_count_mub;
 
+static const char * const a55_core_sels[] = {"a55_alt", "arm_pll"};
 static const char *parent_names[MAX_SEL][4] = {
 	{"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "video_pll"},
 	{"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "sys_pll_pfd2_div2"},
@@ -55,7 +56,7 @@ static const struct imx93_clk_root {
 	/* a55/m33/bus critical clk for system run */
 	{ IMX93_CLK_A55_PERIPH,		"a55_periph_root",	0x0000,	FAST_SEL, CLK_IS_CRITICAL },
 	{ IMX93_CLK_A55_MTR_BUS,	"a55_mtr_bus_root",	0x0080,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
-	{ IMX93_CLK_A55,		"a55_root",		0x0100,	FAST_SEL, CLK_IS_CRITICAL },
+	{ IMX93_CLK_A55,		"a55_alt_root",		0x0100,	FAST_SEL, CLK_IS_CRITICAL },
 	{ IMX93_CLK_M33,		"m33_root",		0x0180,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
 	{ IMX93_CLK_BUS_WAKEUP,		"bus_wakeup_root",	0x0280,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
 	{ IMX93_CLK_BUS_AON,		"bus_aon_root",		0x0300,	LOW_SPEED_IO_SEL, CLK_IS_CRITICAL },
@@ -117,6 +118,7 @@ static const struct imx93_clk_root {
 	{ IMX93_CLK_HSIO_USB_TEST_60M,	"hsio_usb_test_60m_root", 0x1f00, LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_HSIO_ACSCAN_80M,	"hsio_acscan_80m_root",	0x1f80,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_HSIO_ACSCAN_480M,	"hsio_acscan_480m_root", 0x2000, MISC_SEL, },
+	{ IMX93_CLK_NIC_AXI,		"nic_axi_root",		0x2080, FAST_SEL, CLK_IS_CRITICAL, },
 	{ IMX93_CLK_ML_APB,		"ml_apb_root",		0x2180,	LOW_SPEED_IO_SEL, },
 	{ IMX93_CLK_ML,			"ml_root",		0x2200,	FAST_SEL, },
 	{ IMX93_CLK_MEDIA_AXI,		"media_axi_root",	0x2280,	FAST_SEL, },
@@ -153,7 +155,7 @@ static const struct imx93_clk_ccgr {
 	unsigned long flags;
 	u32 *shared_count;
 } ccgr_array[] = {
-	{ IMX93_CLK_A55_GATE,		"a55",		"a55_root",		0x8000, },
+	{ IMX93_CLK_A55_GATE,		"a55_alt",	"a55_alt_root",		0x8000, },
 	/* M33 critical clk for system run */
 	{ IMX93_CLK_CM33_GATE,		"cm33",		"m33_root",		0x8040, CLK_IS_CRITICAL },
 	{ IMX93_CLK_ADC1_GATE,		"adc1",		"adc_root",		0x82c0, },
@@ -291,6 +293,9 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 	if (WARN_ON(!anatop_base))
 		return -ENOMEM;
 
+	clks[IMX93_CLK_ARM_PLL] = imx_clk_fracn_gppll_integer("arm_pll", "osc_24m",
+							      anatop_base + 0x1000,
+							      &imx_fracn_gppll_integer);
 	clks[IMX93_CLK_AUDIO_PLL] = imx_clk_fracn_gppll("audio_pll", "osc_24m", anatop_base + 0x1200,
 							&imx_fracn_gppll);
 	clks[IMX93_CLK_VIDEO_PLL] = imx_clk_fracn_gppll("video_pll", "osc_24m", anatop_base + 0x1400,
@@ -318,6 +323,14 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 						 ccgr->shared_count);
 	}
 
+	clks[IMX93_CLK_A55_SEL] = imx_clk_hw_mux2("a55_sel", base + 0x4820, 0, 1, a55_core_sels,
+						  ARRAY_SIZE(a55_core_sels));
+	clks[IMX93_CLK_A55_CORE] = imx_clk_hw_cpu("a55_core", "a55_sel",
+						  clks[IMX93_CLK_A55_SEL]->clk,
+						  clks[IMX93_CLK_A55_SEL]->clk,
+						  clks[IMX93_CLK_ARM_PLL]->clk,
+						  clks[IMX93_CLK_A55_GATE]->clk);
+
 	imx_check_clk_hws(clks, IMX93_CLK_END);
 
 	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
-- 
2.37.1

