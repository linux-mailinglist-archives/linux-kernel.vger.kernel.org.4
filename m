Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B246D413F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjDCJvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjDCJuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:50:44 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40D212BDE;
        Mon,  3 Apr 2023 02:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLPEHv0+tZQT7TELWedeuajY9h7rHZjWq+04qszEaSrg7YU9LJDNW9LRWCDcKISoBvrSC4K17ZeJL8P1W1rmZLAwKNluc8yrWPpLbZ2DiJKhwM/o86ylhC6aTgVR+UECYm3K/lEgNEJWP47IJNo10GLly6TpOLiYKGPoO+klElcUrZ2zqGO6JxVs9j/cqz0RyagAGBswjc6Bm79hmd60czwiWpUhrinFeeYrPLwtIPY4RGejv8O3lqB6IzB3J4BULOqMAdQo9P7UKMusbYS+78eFVQz8x+F9vRTdIZRIaK3hRyyl/OeuPjSy+IrW8JUgkIHJ2a71Qqi5iXMl5gavGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbNpJJ9Zx3euz9TCPPtBr4bcu2SGx+lg99DLF0z6AxI=;
 b=ikDCof9nk50OETQJj2IYlD7oZkKRatFcRZIOS5iH+Nhxl6ZuzDMscgFBEoypOqA39SGLzzltQJNAxE7t2Z1GeHvSJulWOQvZivaPP3DjQanSVi6pHqad615wbJzOv4o5yAkhkTQA2YqWhfNvonDzpTUyPSH/dgOFU6/16NRK9rXs//nx3kaLkkfC+DMIZzi4TtLPsv75RlQSZSOfuGdITb8iqpR82JT5D9Hp6elBNwHo7EcWlz1dkt+adHUnGJ25NonNYRV/5+VGPG/xEYxTgHLpGlt/vLY2Wm5RPauPUZ0CkKxxC8xJ7PleVIoDxisNiGIisVLN337e/DZsKjC+4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbNpJJ9Zx3euz9TCPPtBr4bcu2SGx+lg99DLF0z6AxI=;
 b=NQ+btT3Lt8/e7QmdKQ+NPI2Z/DcewL8tQLLgag89jlPI9uiv6nL3ok5HltAyJDBedgo2yU2e4RB7R7je9hX9z9MaLuOGVcQ/uFpl6bkq1+yqSELWY9jLBJElqov1tQ7r9+4Q9WPMo/6IXtgvJNO1jfa8mjOpVdgoeJYw2Hm44PU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8070.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 09:48:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 09:48:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 7/7] clk: imx: imx93: Add nic and A55 clk
Date:   Mon,  3 Apr 2023 17:53:00 +0800
Message-Id: <20230403095300.3386988-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 706630f0-7fed-41f6-5b94-08db34289577
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2swljdvVhMB0G5um1V+zTj7zDIzpiE6fTxuarlX8C+a2RYn/WVsimCiZGprIEQkvrStx3mjLV3yUaQzOTzc906Kq1rrle78O1dBl65Xrhc0fjNjRTmG6zdG4uRy1EY9SGVVH2Vt6vQl6YJh/Zj0uHBOTZ6+SLvx+WjdcrWzGmlEe1OsQKSwQsXwaV48Yh7XziFtm4Ku+QoAjmt/0x7moaBOp0iHOsfquQIuZzflqqcYd/pFnnRMx0QC286LA758QBz8EvjS39opCXCe9y+hsTbECcY8f7gXogZp8w4iwOHwqSTVtWlIpbjZHz0P3cm4LUCNvGTd4RwHT7X1zF5UfyQOn2dKas8Seh8nTKOEbskU0Rt6F59DMViPCrQ2/7s9UV+2KHXG+fOhyJivkLg4tSQ02fxKOqQoTyfspj/8TZDUqA2/MpE9iUoddwRbvftdIAAgIGCXGOO1ccUrkoGMc7hDjJpNbHRMqax5JiP87DpeRfjLmihlN3XQUMdzxijUQl34jKgkGetsxrsdNcMDJoWYH+Ow6U2lfbrSUdsQx/vohYiONziRU17ttZKCu+of/nuxY6JGJduLGLJm4UrwKJMZ9awf+PNIW2JiPpkoE0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199021)(8676002)(4326008)(66556008)(66476007)(66946007)(316002)(478600001)(8936002)(5660300002)(7416002)(41300700001)(38100700002)(38350700002)(186003)(83380400001)(2616005)(52116002)(6486002)(6666004)(6512007)(6506007)(1076003)(26005)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2HLeA5BfQfrMSUmUEg94hz4pjIB/+2uwdxtQbgXAEnGa+tByz2TZmmOc7S4p?=
 =?us-ascii?Q?KccvNGZRXPhPN2ZIOdj7wQnWszcZ7G53Y5hNvCvDrEdFusCYXEsmZtyEOBV+?=
 =?us-ascii?Q?voQLEzeqtUxH+qXfOpDi3gIiT8VMYDAse5a2UuVsSLneFx6tYJqlG095ZF9n?=
 =?us-ascii?Q?ec8o6yOmrNEwBHzqku4vur/nuiNh1lhKHS7STm5q9vAONlsLKXnswntT9kzS?=
 =?us-ascii?Q?2Hp4D4/iml70Fl0IP+Ud6TLzLCcoe8kMDzLEnXrJfZKuqgblrkFLfUYAixpR?=
 =?us-ascii?Q?Hcd3rBUpVVpX+7hoOo4hjkkqiOe9edvHtqkCkzi28UusZzKbGLBJrhOPck6I?=
 =?us-ascii?Q?VxEw+FNJInZvq4P1cotvXp5zUq072d4AClpT5+kkyX6gwJqFTudAgpIF7XMB?=
 =?us-ascii?Q?1Yr2EfVOPenTfy3cM9qT0JyBFYtrEZcdHpaPrbIKq81KtEwe8tQ1Cc0gVib6?=
 =?us-ascii?Q?LUmYAQYTtg//L0GMe4vSyNZs/EXlwPUio6WPtLbCrHGPA/oU00cKghGe0ozT?=
 =?us-ascii?Q?qN+rz7my/57EKxtVT1lqzMgly8R+2WZegMCjRIyUQnXH3eqtEAAQvz0RTmdQ?=
 =?us-ascii?Q?z+ucRoNEwVDO+602eiZdoF4LAbpDBAJzLhyHeQ2e+pBUei+OLtuRkDRAFyyi?=
 =?us-ascii?Q?ie0rKeqpvb3J2/mv+VFH35aVjALiCHnzxmv9d1u4WdQypKQT6nblN/eUa0Qx?=
 =?us-ascii?Q?43tW95H2YnsbmiLFu1Qwza1CO7sxCcmV8kWuwPfpu/Ma8g7iyp4XWAzTDMgb?=
 =?us-ascii?Q?36NtXeDXnDJpinu3z2Z4ROOEFCOAhyt2Kf2WUSih6LOGNk7EM63jDS911Z29?=
 =?us-ascii?Q?6SU3EizBXUCllPw03AAr5mQbXj2yK/xg9U5eYyu193nTCMZHI2Ux3Ogc+CUt?=
 =?us-ascii?Q?KU7Gz1ky8l/BHNX72UkrBz+WK9Twv0Do+nbOT8HqqYgJPsfB+cdL25g99S49?=
 =?us-ascii?Q?Jj8oe6+/1HEAwPyQkG/7V1/2h15V5Qc8jZVBqnIzfZvO63E0oaQLm+a8ikSv?=
 =?us-ascii?Q?d/bfsOU8NjZN35I6y7/Neuvk6+ZSKTBCHSOht2RuIE4qKMWLhFhvGViPyTm8?=
 =?us-ascii?Q?bRPEZOb2OZox6fs7OwTJ3YvsrMsfalWdVu9kqxUtCrC34E1o3vIjWC16meYI?=
 =?us-ascii?Q?IfWCIuwhLq0bIElHpo0pArdQKlzhPdLhiU2AEnFhT+eO5j0bIK6ieNIMJkqf?=
 =?us-ascii?Q?s9GZCZQ9akJRe0IPTE8gmqjffsFX5sgl7u9DAJZSpEWoyHvbd+QP/T/Dh127?=
 =?us-ascii?Q?jYqMUSSkz4pQJMtpdpg66dCRLaAYgS/emUW18pTzVl4RXnoTH9M5shbVXAeu?=
 =?us-ascii?Q?UFg3Zrjb+VhJqOlyPWVXeSYTNkx80sqkIooVrZjH9AGiOxjATSe1BRAonuxE?=
 =?us-ascii?Q?JZ6HSo/rbjVD5+Nec4vKvOOB00lzm/pB+uUNHtPpeIZEbaYYcgCnDA87Ewvi?=
 =?us-ascii?Q?UpfJlAy1iK6nkAlLMYBYT89jWhjTlS+nPlPh/FTW0BD0OeNi4M1y7IPYNNYX?=
 =?us-ascii?Q?4k558f2FKlgr4PVYmSonA0caPc0f0FkFgSZ5h0tFFkeN8RikxoktODDnbKJT?=
 =?us-ascii?Q?lYGxqQb55q07TR6W/nHHaeb+NNPtZSVh7XLzkdES?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 706630f0-7fed-41f6-5b94-08db34289577
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 09:48:31.8167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T43jX2uiRmKq4PhsPKXH0Pw6MWwE52dPmg+bFmLthp0NMSCuBV/jA9ccF7z+YiuRnNYbl4GW6QpW0OW65nBOYw==
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
index de1ed1d8ba54..07b4a043e449 100644
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

