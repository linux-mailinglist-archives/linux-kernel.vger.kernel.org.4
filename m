Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EE96D17A7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 08:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCaGmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 02:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjCaGma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 02:42:30 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CA61CB89;
        Thu, 30 Mar 2023 23:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYZbfCt1WrQ55/w5v0rT6IZalEHf4OWjFmLFPqvVz0rkeGOJWt1iwp7B9TBjSZAurOAghiWFtGF1hQPLdXPmU/o669d8YthTIzPvXUgfkXWQPjXBtH0LOm1G/s8Y6UyI0Sc3PDB2v22K5I7Kb3yG7PMOpm70hUO1/UafH3UmRcPlwewFLr29gAKxybkhbhA+1ED3DwuZ76qulh201aLDO0HLJxCfEBmq0krlPAa9Wd+4poCXzSOc3HY8vu3rsUQNxNxtZVTzFBC7c/ATypTpJrRvmszN278J3TuIGENj/p1W00MfX7V0qCoDrMJOXMLwTcuJxT+dWgTVR8OwfzV4eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlr1lqP0Heho8q7xOeRNM96l0jcUy63Wi8nlwF7Qu94=;
 b=citBDiDo2ot+pmjLO1HpXr6w4a7kSobITc1FfKGsr0n2d4fYfYY5UqArlPTRFPAQ5sz1hmX6PoX7ldI5HMEbs1kUKz7koZG2MyFWiBmhEFLHxuwIDhVHIxKHYYEVmrr+zmOgeBZdSSTs/V6Vs5h5c1aRT3tDXJZlWOG6we01s7wYyFjLdJhAmVmnOKEsrd95+W/xXb25D+a0fzGWCEM4Cw7aQoKNvdvfKHoRFlond8uFfV/B5jh6mfa4RBHqzdBMcCT3XmhbIBMy3AHXO66fY38+upeXq+QB7eeb8/sGaKTWYIzGR5A3nTNd/pgWdGBNPiFwtbGvXz7sEw9VwhqprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlr1lqP0Heho8q7xOeRNM96l0jcUy63Wi8nlwF7Qu94=;
 b=YAtu8U5wsY32FPVgMBoHWO5Qu42K6Wl9pDlcztKYny0CgXamTvlwgJ2erGAkcxJkhvICGFIv6i5wyi5vQ77M7u6qLUVuuRgcz2mrd1YVz+1MZEXRTUTIShWwdFUlzmvFAxBHaCwUt0Eh2hFrupNsdY2PtkwTMuSjaNg6yMhfH/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9271.eurprd04.prod.outlook.com (2603:10a6:102:2a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 06:41:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Fri, 31 Mar 2023
 06:41:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/6] clk: imx: imx93: Add nic and A55 clk
Date:   Fri, 31 Mar 2023 14:46:28 +0800
Message-Id: <20230331064629.2475338-6-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5ebbe3dc-746d-4466-83ac-08db31b3013e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/1J56H+lUrPugdNQIKw6f+S/DfJwlb9h+KGcbex0VSaCtetp7FcQGC56xQqM2n7LU6Y0YqOLx+adbJu5tlHYn/pCW0QZbSJlie8uAS5GTkc8sE7jGv67eq2IWC8Mci81iTfiE29Y1qaB2DldpNZFRscJXXgk8ncGhYn3/rHPx4p/hSiCs6P5sDlU/Emim6kSvL85jP0+r/0a9mr4Yfv+5+xNCtQ6V4zytPp7NFq3Yj+sO1P0Pm6izi0+LAM3VVMzuxgMVwfVDU62z1zEeYnIC2UkEB5jkGA9MFGNOfNxRp906GNhBS0jPlabPeidCzcZMyzVOCzxlJfCOxs7OHztppBog69GaiWwmExQ/iITBOmlY1JMvHBa7rdBokrdsj472yf6scPwUtZpKHqueG3RYp8D5EjZH8ukf2IVkm6Vjo4QVpIf9Xore8yowMDnSq+EPF/UpqTNTy4K3Qff0zI1Jj1qRgwvZLku3RpGJX92BZgHlI/2AXV2VOwqAEnOzZky8ctgZbkKnC8XjkcCYoGKQq4Qg3LAM/c2U/3D6p/ZKlWj9v2hls69pNciZZiiJtsvFb9tyf/ptIe4ahsY1953x0iy9AByDB+UMhn7ZhnNms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199021)(2616005)(2906002)(4326008)(38350700002)(38100700002)(41300700001)(83380400001)(86362001)(8936002)(66946007)(66556008)(6506007)(26005)(1076003)(186003)(6512007)(66476007)(8676002)(316002)(5660300002)(6666004)(7416002)(52116002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+qECv8febdwjwXhQmsVb5j6rPTyLulbvr0BXjU0/F+ZSKf30COBJhhaqo+FZ?=
 =?us-ascii?Q?loBi6m/qKITxEYXx+Lcmz84e/p7tDe6tiTIB47oLKv3jkUV68cqL6ttCslur?=
 =?us-ascii?Q?FYjYYkWUM0ItytOuwc3OcT0vHa4ELtGwZM2uER9Adkm+TAHzJ2HwMHu+Yl5M?=
 =?us-ascii?Q?yAN4Qn898V1MiijCM9b/MccgIOh97lif4b4ePwrbOvBpopdiACRAEyCQAKFj?=
 =?us-ascii?Q?ue8oZKXzBh37/hLN/9CRWdmfxFPbacSKQRSv6/OADvqPUjtg7IPTRU6ZErHl?=
 =?us-ascii?Q?zRqTAbhYYBsupTZY9tVpX5Rsib7r5Dm91DDAUhgNl4z+MMysDJay34A6ItV3?=
 =?us-ascii?Q?Q8DLA5Cf//kfgp0iFKsk8DbsjIBlYsh0afsVOnVFQwf6fktHzfRFMNKMKorw?=
 =?us-ascii?Q?tulVTu0485Vl8H2GClMZUlfeZBE09AR0YR6L7rOfzDTZYE+FLWhcUNBU6Lme?=
 =?us-ascii?Q?v/GOSFjjOdjx1NCQcX80qgy7oSjeXPk/HDcSayXd6isom5grvZ8yFJBr/QTp?=
 =?us-ascii?Q?exbJfs0nLQJedfyT1d9TlrV1pY1BPqRJENY1k5j91X7axEN4EK1v7rU64Uok?=
 =?us-ascii?Q?ov1xJ7LHi2QGzsaH7Mztf2QvJ2I4bT9SJIfP1Vh6Z1SEEvEGFjN6g8GAzEqC?=
 =?us-ascii?Q?Kz4DeDB/IvSZQdnjaWAyvr6cOf+xKNdZyXJoSgHdRds+EgOBbsYOkhRHb9J4?=
 =?us-ascii?Q?TRz+GtaQbQT8TngBkyJb1p9XWpCJfg1z5/2lZq7PIIXR9BLqVliyfuFC3p2Y?=
 =?us-ascii?Q?U/aIdiRcw+4x+auPg129tT1JWAunUr60/HEqMXWI9gTQ+EONWsR8gqGd7XGP?=
 =?us-ascii?Q?Xoum5ORflC5hLd/0V2J9wdZwMvAweFlEXB4LWlIKCobd/s8KXl3eOd+4Hbko?=
 =?us-ascii?Q?71M+yIipKVOV8cu87uKg+XfG/SGpkiq9Juo/ghxFp/wAj2aB9cBbaa2OnO7I?=
 =?us-ascii?Q?V519MRVmoYOpfXdT2B7nd+AY3C8LeKPepx0vlAD3joWr4IGYjLTf/sgElmvf?=
 =?us-ascii?Q?ps8jrJq37+rkgAv73Cz2x0TwxuMWh53nyfqEfBVO19MErG8weWqEXQBLzWol?=
 =?us-ascii?Q?YFpIwqfVTEArHuRycB9nHNSI+od/Gap9UF0ZkDUneZjebL/XJIj6sYDsgVf5?=
 =?us-ascii?Q?YtUITLbpIIGtXQnlyAHVje72je70peMQEaPom8FsRWWhw21QUZJJ74w6k19S?=
 =?us-ascii?Q?VDzzL33sVeQbFgNRS3/WzIMW9KFyzM/LQiGaplfpocMUbdL8hFMvvHFnfLb6?=
 =?us-ascii?Q?+B58RrzU9Dp8pFptWVFgJpxn+gVnMXeoAm9liSkjA/dfd/D8F/eLK9aRZyKq?=
 =?us-ascii?Q?/gBah49gT1FIScZj9nCJBYznR6juG9jWuCYryQx94S90r4SyXPJ9xDxQLQs7?=
 =?us-ascii?Q?CAwS1OxWbPyqnJlH9cEYdZRqlVSJc3vI0on+M++QpWiGQz9fCfEJ0Zut17bj?=
 =?us-ascii?Q?M2/Pm2M/Q1PjTGCPexVqQz4AWzVCtFt6wJ/c62DyWA8lzf0rDEdhLpumHoh7?=
 =?us-ascii?Q?OGabUvXja9twNOR4GVhh1ivEFlq7K7RUloDfv9Z1nbT6O45eVmSL8MTKmdgG?=
 =?us-ascii?Q?kuMUQSE3PysmyKwIemG/LBMxTRGBDYIc/Gssb9pK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebbe3dc-746d-4466-83ac-08db31b3013e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 06:41:49.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dglZ8azQuwGnFaFVqOonz7Y7KB1J+VDf1ikxnilUgeob68vlCAS/nOvJyyCaxyM41dmhFCiiB78mdxM5ISrMYg==
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

The A55 clock logic as below:
     A55_PLL ----------------->\
                                A55_SEL-->A55_CORE
     A55_CCM_ROOT--->A55_GATE->/

Add A55 CPU clk to support freq change.
Add NIC CLK to reflect the clk status

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c             | 17 +++++++++++++++--
 include/dt-bindings/clock/imx93-clock.h |  6 +++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index bf2908be26a1..4cfe1f367d83 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -33,6 +33,7 @@ static u32 share_count_sai2;
 static u32 share_count_sai3;
 static u32 share_count_mub;
 
+static const char *a55_core_sels[] = {"a55_alt", "arm_pll"};
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
diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 8e02859d8ce2..35a1f62053a5 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -199,6 +199,10 @@
 #define IMX93_CLK_MU1_B_GATE		194
 #define IMX93_CLK_MU2_A_GATE		195
 #define IMX93_CLK_MU2_B_GATE		196
-#define IMX93_CLK_END			197
+#define IMX93_CLK_NIC_AXI		197
+#define IMX93_CLK_ARM_PLL		198
+#define IMX93_CLK_A55_SEL		199
+#define IMX93_CLK_A55_CORE		200
+#define IMX93_CLK_END			201
 
 #endif
-- 
2.37.1

