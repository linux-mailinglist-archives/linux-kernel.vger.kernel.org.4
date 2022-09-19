Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D41B5BCAE0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiISLho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiISLhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:37:37 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20064.outbound.protection.outlook.com [40.107.2.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3072AE2C;
        Mon, 19 Sep 2022 04:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIlbSypGzwFr1zPU0vG0WgpUK4Yl0l4e+BAWS4rZTibtAHyROY7xoJKcNNHabJ+cyyleX+Zai2biWQX2/Atcx7wKau8BTzdcVgBQV5NQAc4PXuGwcdcJ0OgG/ZKP+Fv+UQ2cjM+Fw9PcDUpyBsD2Dn+xW3ryz3VooIoI2orhJNVDGNSBOv8mKbJuYtJ0V8cZyiC++z/v4+0OXUcCXvy64bpQ40PaggTKVrOBcyuyD7ErDGJC51JjEUa3JzQdVj1oxMAfgM3qpAnR21ulw52dvSp5l+xxzQ7Q/HQtHJhvN9a+XEUQ1bZVc4BUxSFRLTmftzkMGBxglvJbE0sCbfFKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FMwUJO+1Vq6w08bJH9RWmvUryRvma9UMBooxcRrSy4=;
 b=f/McdsjGXAu58TwqIslv5XqEsEIVfri+qAKRQ7ITTB6vR9uDhFs3BdfiwTjtixtRKZFHsJDJEfUQhWLNIExrnmGiHLXrIe29dlbyILFpHhUvAt7AiTdCX2VIuEKokF3cAW8uYnHflF9kksSiQzgDkWGvw+GVFespyQStUgyjpk1Edw9JAY1XvVVNCzMb2Zhq+JEbCB9+KTVYygIV7+3fUJIoG0LwXCHOKQoPaDarMKW2lFbq5umTWgj0p4/kYbZdfQUNHv9sEGZQ5lDntZaGxHbjhut60bol8fFsW23YvtH03nnCycnR1SFdqj0WapGVI7yanjVy17OORP0hzms5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FMwUJO+1Vq6w08bJH9RWmvUryRvma9UMBooxcRrSy4=;
 b=H8JGPtlg4jxr+waFWiVcLCyew3mij4PnK6WFL9L6csdAtumMXBSlfGhDRSykbGqsHhGCx4JweGMcAhGkWQ2QSKJ/8ns5EsmNxltluPIxKNCF1PLjddD7VdxnYxZAYQTy/Tppr7OWLx+U1QYzxFXSgWt4E4hyj7vrsUhPFVeV/rA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM7PR04MB7030.eurprd04.prod.outlook.com (2603:10a6:20b:114::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 11:37:28 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::9466:d44b:804:72ef%5]) with mapi id 15.20.5632.018; Mon, 19 Sep 2022
 11:37:28 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: firmware: imx: sync with SCFW kit v1.13.0
Date:   Mon, 19 Sep 2022 14:37:15 +0300
Message-Id: <20220919113715.243910-1-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.37.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0276.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::49) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AM7PR04MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: 849af064-5cd6-4f45-16f6-08da9a335450
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mk/zJTnqhUmXQ4JpuCjqd8aPMn1XFhxkHMsmECEfeUP7Y/LxxGueimjAYbvriysMwPY+mBoDgiVrI7tvTU6Y3gehMbHZMqUUMw046EUwPaamSyqLxgedO4MmRtUuMk+RqtKk/vXCuv+FqQgzoPELp3cb2S05wh7hUb8ZaJaifGUc6Uzyxcp6sFbf8WOzWo1Yvz++7P0bkTUBLic4Xokwp6N3PIcBt3Q4ddJ9BC/8K8eIt+EnDUU6coDu6rRCnjg6ZyZLdFyH+3CY/J6hHLtr2dkF2+FX5kp0ACofMk1AsrwYaHaHgLqa5yi4kx2ajCx+Wj21cCOz047IKMMZnjxcchEgUuUObQm4R6BbGKDsd0vrje4fplelOL80FmDyCLGTXggnVaIDVwyXjK1JFlj7/3N3PQEQGUe+ltevVfpLZiT4/9TSfGF0kUm2T9W/VCnUs9rKgd0txr8OwESg/JVx/eXnxAoJLZBV4cfMDidvwDmg6wdbVVbw9tFL8zkbGYiBM7IJNZCFK8aK8qMG0szD4ZDYQ9Dv44i8miIuVy9v3JD1ha4k54mFKJuUWv0BeJ7SjTrKdilP5BD2iUX9RMWJZEoSqHXfhKge1xEMje13XHMeO0+K2uiSQCdcRcKjtaVUYoE4JQi1JbvMPRmpLMXFyoDL/3vLZsJaRZpIakpipTP4eTXHRmAcLKukMV3DBKQy+ZsioZMV8FrK3RsQdUTBV1blIASrok8kgey3zO2XjwXPRHrU9SvgbmTCrcd1W19TqBfYLILtDORQxrs1tF5OmmRJne4qj1NEl57iaDnj7LY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(451199015)(6666004)(8676002)(38350700002)(38100700002)(52116002)(6512007)(26005)(6506007)(478600001)(6486002)(110136005)(921005)(966005)(316002)(5660300002)(186003)(83380400001)(7416002)(2906002)(30864003)(41300700001)(1076003)(66556008)(66946007)(66476007)(8936002)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EoA+buDMKWmN3akw+Biw6iWwXE/Vgkw8pDTHBGXvqb409kSC1Eieihkuh1Ca?=
 =?us-ascii?Q?ZWSpiZInkTtfzgMWmaFlFSLR4TxwPa1tZdgkHYKo0a8wml4k4nQVD29wQ/d7?=
 =?us-ascii?Q?3n6sf4NZpSDsX4wD1+GVBg0xO6a8VTPKP3Jv9kicbWnTLhb2Xzv1kLu4ikU+?=
 =?us-ascii?Q?HMA+Mv9sksyWKdE9KWTttNai0m8A4Tttd9irjhLjgJ6JPtJtr5F8Mbb+Kwd2?=
 =?us-ascii?Q?GzHNDmM0AjwbFJfJ80/+j0YFXcUhWlewDSi1RlI0N1qs11/G7pZzqebnYVqN?=
 =?us-ascii?Q?iBx3iDCj0/IuZmU7/MaOUYeZht5itBlHqI4qT57i0wwnusZSv5u+PivzX2dp?=
 =?us-ascii?Q?2GF/hUELn1mwJaiBiZByJS0KNjny9WmVLKVuZea49YB9MVtb65i1yMkX/2VC?=
 =?us-ascii?Q?x2z4/W3JlGKwEvm1fkPRKjfO7QALZsBz1oiyxXzgrHK0mQuVLc4xi67NgEYq?=
 =?us-ascii?Q?XgGXKZy7kj1om3NkgmEp7JibHMTRlrWqxoIX0WztZ85tYJF+p4iPUXiKyUVU?=
 =?us-ascii?Q?XkL3yPZ16gCfFsFKoOVgFKP8CFUqdjLfIrWhrWM0bLGRgpUlhyV6NjQdKWhY?=
 =?us-ascii?Q?HOBOADBv7j+C7gZoV8R47g673mwaiGvd8QoXDc9rAwPP2qg7nSQdng86IbDB?=
 =?us-ascii?Q?S6chPLtddgTRp9foXTGqTCbtf1dUiVQO0LrGYLR0PDs8+ou4hg+yeFOCMlSh?=
 =?us-ascii?Q?Zzkk/B3QI1MoMS3HT+jtQjGzP7epmOzzJrq5BtwgrVyW79UaFsoRRBpOGRXO?=
 =?us-ascii?Q?KWG+35xFeMYWxDwhnv0JvhbxO2YlWMfW5tu83Xcv4nuKp9WzN3I2WTH+7gkJ?=
 =?us-ascii?Q?g8fD2dUjoZQYQCDZAwSfNRhOcuu/W0Ub2tWsacG5QH+cQRXRKyeliToq3QuQ?=
 =?us-ascii?Q?1lHhLHa01/1EHqnPynAAx5HpVtXfv6ZGrG5KFOo5k2ov9gtXLOy3rIuNoiRy?=
 =?us-ascii?Q?St0L7rcgMs2FOWkiofSmYib6ruEBpDgZODZXSOzKF8Q43L6P6HmiXVe8uQC9?=
 =?us-ascii?Q?tLGKr4dE4XMesQ8AjNqz772rdQq47BI9dN7RgHVpCXORPwdAfSUrHlkyT1Gs?=
 =?us-ascii?Q?6its0XjUdpYkdqBRXtTKV1QbyN+awYIY93pVEvkX6DiQ8Zqk8vQnZ88XwYCI?=
 =?us-ascii?Q?mULoY5H/30YO7bb7rQa3H+9AuQJMA8sWB4oPAuphPuewatfOl2UGvElJnuGS?=
 =?us-ascii?Q?D8WFObcw1HZ8yGT/lTuByYgbsJ8WmZePSIScClbinbe9AVhm5es8V9ewtgOV?=
 =?us-ascii?Q?2flJoYTNbA7BVgRiePr3t6uRuueXyf1x7XTJHFY/oQmOgTgkcxtDdy7GfyNR?=
 =?us-ascii?Q?x+HUuPIYNwG3p7vlHHkqkWHN9+SGb29maKzr27/lvjgn2fLa8DDnHHxNaeM+?=
 =?us-ascii?Q?TWnWx+HV1TYu2tlWBdxuvjwMSA0sIP20GQzH9+XCwDOFOKjzxvPIYU+3fdPm?=
 =?us-ascii?Q?rIxCfjtO9tYWphXxVjjKT84B6ENOw8GFBti44ISEuufon8Es4KmVe+wcrzck?=
 =?us-ascii?Q?oImg34gRzMIAcNVG+W0lzuDBacMdC3lhadwEyaV7HrVy/L6jfVZvM33BvO0B?=
 =?us-ascii?Q?xrcfagO0sYIvmwoypcUhxHFW5Q0CW957ap1ACofi?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849af064-5cd6-4f45-16f6-08da9a335450
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 11:37:27.8484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBOuCfJZFbYyixxCldy2znokSW1OD0+lAmDr7wS0d+Ltuid6+rBLd6wyt1wwi5I3KbTU/Gl1KIHYiP1wRE5CXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7030
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

Sync defines with the latest available SCFW kit version 1.13.0,
may be found at the URL below:

https://www.nxp.com/webapp/Download?colCode=L5.15.32_2.0.0_SCFWKIT-1.13.0&appType=license

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 drivers/clk/imx/clk-imx8qm-rsrc.c       |   4 +-
 include/dt-bindings/firmware/imx/rsrc.h | 292 ++++++++++++++++--------
 2 files changed, 198 insertions(+), 98 deletions(-)

Changes since v1:
	Two patches squashed into one in order to keep changes bissectable
	and compilable as suggested by Alexander Stein.

diff --git a/drivers/clk/imx/clk-imx8qm-rsrc.c b/drivers/clk/imx/clk-imx8qm-rsrc.c
index 87e0b6ac027e..ee01acd1a181 100644
--- a/drivers/clk/imx/clk-imx8qm-rsrc.c
+++ b/drivers/clk/imx/clk-imx8qm-rsrc.c
@@ -79,8 +79,8 @@ static const u32 imx8qm_clk_scu_rsrc_table[] = {
 	IMX_SC_R_M4_0_I2C,
 	IMX_SC_R_M4_1_I2C,
 	IMX_SC_R_AUDIO_PLL_0,
-	IMX_SC_R_VPU_UART,
-	IMX_SC_R_VPUCORE,
+	IMX_SC_R_ENET_0_A2,
+	IMX_SC_R_ENET_1_A0,
 	IMX_SC_R_MIPI_0,
 	IMX_SC_R_MIPI_0_PWM_0,
 	IMX_SC_R_MIPI_0_I2C_0,
diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
index 1675de05ad33..a4c68f394986 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -13,30 +13,30 @@
  * never be changed or removed (only added to at the end of the list).
  */
 
-#define IMX_SC_R_A53			0
-#define IMX_SC_R_A53_0			1
-#define IMX_SC_R_A53_1			2
-#define IMX_SC_R_A53_2			3
-#define IMX_SC_R_A53_3			4
-#define IMX_SC_R_A72			5
-#define IMX_SC_R_A72_0			6
-#define IMX_SC_R_A72_1			7
-#define IMX_SC_R_A72_2			8
-#define IMX_SC_R_A72_3			9
+#define IMX_SC_R_AP_0			0
+#define IMX_SC_R_AP_0_0			1
+#define IMX_SC_R_AP_0_1			2
+#define IMX_SC_R_AP_0_2			3
+#define IMX_SC_R_AP_0_3			4
+#define IMX_SC_R_AP_1			5
+#define IMX_SC_R_AP_1_0			6
+#define IMX_SC_R_AP_1_1			7
+#define IMX_SC_R_AP_1_2			8
+#define IMX_SC_R_AP_1_3			9
 #define IMX_SC_R_CCI			10
 #define IMX_SC_R_DB			11
 #define IMX_SC_R_DRC_0			12
 #define IMX_SC_R_DRC_1			13
 #define IMX_SC_R_GIC_SMMU		14
-#define IMX_SC_R_IRQSTR_M4_0		15
-#define IMX_SC_R_IRQSTR_M4_1		16
-#define IMX_SC_R_SMMU			17
-#define IMX_SC_R_GIC			18
+#define IMX_SC_R_IRQSTR_MCU_0		15
+#define IMX_SC_R_IRQSTR_MCU_1		16
+#define IMX_SC_R_SMMU_0			17
+#define IMX_SC_R_GIC_0			18
 #define IMX_SC_R_DC_0_BLIT0		19
 #define IMX_SC_R_DC_0_BLIT1		20
 #define IMX_SC_R_DC_0_BLIT2		21
 #define IMX_SC_R_DC_0_BLIT_OUT		22
-#define IMX_SC_R_PERF			23
+#define IMX_SC_R_PERF_0			23
 #define IMX_SC_R_USB_1_PHY		24
 #define IMX_SC_R_DC_0_WARP		25
 #define IMX_SC_R_V2X_MU_0		26
@@ -56,11 +56,14 @@
 #define IMX_SC_R_V2X_MU_3		40
 #define IMX_SC_R_V2X_MU_4		41
 #define IMX_SC_R_DC_1_WARP		42
+#define IMX_SC_R_STM			43
 #define IMX_SC_R_SECVIO			44
 #define IMX_SC_R_DC_1_VIDEO0		45
 #define IMX_SC_R_DC_1_VIDEO1		46
 #define IMX_SC_R_DC_1_FRAC0		47
+#define IMX_SC_R_V2X			48
 #define IMX_SC_R_DC_1			49
+#define IMX_SC_R_UNUSED14		50
 #define IMX_SC_R_DC_1_PLL_0		51
 #define IMX_SC_R_DC_1_PLL_1		52
 #define IMX_SC_R_SPI_0			53
@@ -151,10 +154,10 @@
 #define IMX_SC_R_DMA_1_CH29		137
 #define IMX_SC_R_DMA_1_CH30		138
 #define IMX_SC_R_DMA_1_CH31		139
-#define IMX_SC_R_UNUSED1		140
-#define IMX_SC_R_UNUSED2		141
-#define IMX_SC_R_UNUSED3		142
-#define IMX_SC_R_UNUSED4		143
+#define IMX_SC_R_V2X_PID0		140
+#define IMX_SC_R_V2X_PID1		141
+#define IMX_SC_R_V2X_PID2		142
+#define IMX_SC_R_V2X_PID3		143
 #define IMX_SC_R_GPU_0_PID0		144
 #define IMX_SC_R_GPU_0_PID1		145
 #define IMX_SC_R_GPU_0_PID2		146
@@ -183,7 +186,7 @@
 #define IMX_SC_R_PCIE_B			169
 #define IMX_SC_R_SATA_0			170
 #define IMX_SC_R_SERDES_1		171
-#define IMX_SC_R_HSIO_GPIO		172
+#define IMX_SC_R_HSIO_GPIO_0		172
 #define IMX_SC_R_MATCH_15		173
 #define IMX_SC_R_MATCH_16		174
 #define IMX_SC_R_MATCH_17		175
@@ -250,15 +253,15 @@
 #define IMX_SC_R_ROM_0			236
 #define IMX_SC_R_FSPI_0			237
 #define IMX_SC_R_FSPI_1			238
-#define IMX_SC_R_IEE			239
-#define IMX_SC_R_IEE_R0			240
-#define IMX_SC_R_IEE_R1			241
-#define IMX_SC_R_IEE_R2			242
-#define IMX_SC_R_IEE_R3			243
-#define IMX_SC_R_IEE_R4			244
-#define IMX_SC_R_IEE_R5			245
-#define IMX_SC_R_IEE_R6			246
-#define IMX_SC_R_IEE_R7			247
+#define IMX_SC_R_IEE_0			239
+#define IMX_SC_R_IEE_0_R0		240
+#define IMX_SC_R_IEE_0_R1		241
+#define IMX_SC_R_IEE_0_R2		242
+#define IMX_SC_R_IEE_0_R3		243
+#define IMX_SC_R_IEE_0_R4		244
+#define IMX_SC_R_IEE_0_R5		245
+#define IMX_SC_R_IEE_0_R6		246
+#define IMX_SC_R_IEE_0_R7		247
 #define IMX_SC_R_SDHC_0			248
 #define IMX_SC_R_SDHC_1			249
 #define IMX_SC_R_SDHC_2			250
@@ -289,46 +292,50 @@
 #define IMX_SC_R_LVDS_2_PWM_0		275
 #define IMX_SC_R_LVDS_2_I2C_0		276
 #define IMX_SC_R_LVDS_2_I2C_1		277
-#define IMX_SC_R_M4_0_PID0		278
-#define IMX_SC_R_M4_0_PID1		279
-#define IMX_SC_R_M4_0_PID2		280
-#define IMX_SC_R_M4_0_PID3		281
-#define IMX_SC_R_M4_0_PID4		282
-#define IMX_SC_R_M4_0_RGPIO		283
-#define IMX_SC_R_M4_0_SEMA42		284
-#define IMX_SC_R_M4_0_TPM		285
-#define IMX_SC_R_M4_0_PIT		286
-#define IMX_SC_R_M4_0_UART		287
-#define IMX_SC_R_M4_0_I2C		288
-#define IMX_SC_R_M4_0_INTMUX		289
-#define IMX_SC_R_M4_0_MU_0B		292
-#define IMX_SC_R_M4_0_MU_0A0		293
-#define IMX_SC_R_M4_0_MU_0A1		294
-#define IMX_SC_R_M4_0_MU_0A2		295
-#define IMX_SC_R_M4_0_MU_0A3		296
-#define IMX_SC_R_M4_0_MU_1A		297
-#define IMX_SC_R_M4_1_PID0		298
-#define IMX_SC_R_M4_1_PID1		299
-#define IMX_SC_R_M4_1_PID2		300
-#define IMX_SC_R_M4_1_PID3		301
-#define IMX_SC_R_M4_1_PID4		302
-#define IMX_SC_R_M4_1_RGPIO		303
-#define IMX_SC_R_M4_1_SEMA42		304
-#define IMX_SC_R_M4_1_TPM		305
-#define IMX_SC_R_M4_1_PIT		306
-#define IMX_SC_R_M4_1_UART		307
-#define IMX_SC_R_M4_1_I2C		308
-#define IMX_SC_R_M4_1_INTMUX		309
-#define IMX_SC_R_M4_1_MU_0B		312
-#define IMX_SC_R_M4_1_MU_0A0		313
-#define IMX_SC_R_M4_1_MU_0A1		314
-#define IMX_SC_R_M4_1_MU_0A2		315
-#define IMX_SC_R_M4_1_MU_0A3		316
-#define IMX_SC_R_M4_1_MU_1A		317
+#define IMX_SC_R_MCU_0_PID0		278
+#define IMX_SC_R_MCU_0_PID1		279
+#define IMX_SC_R_MCU_0_PID2		280
+#define IMX_SC_R_MCU_0_PID3		281
+#define IMX_SC_R_MCU_0_PID4		282
+#define IMX_SC_R_MCU_0_RGPIO		283
+#define IMX_SC_R_MCU_0_SEMA42		284
+#define IMX_SC_R_MCU_0_TPM		285
+#define IMX_SC_R_MCU_0_PIT		286
+#define IMX_SC_R_MCU_0_UART		287
+#define IMX_SC_R_MCU_0_I2C		288
+#define IMX_SC_R_MCU_0_INTMUX		289
+#define IMX_SC_R_ENET_0_A0		290
+#define IMX_SC_R_ENET_0_A1		291
+#define IMX_SC_R_MCU_0_MU_0B		292
+#define IMX_SC_R_MCU_0_MU_0A0		293
+#define IMX_SC_R_MCU_0_MU_0A1		294
+#define IMX_SC_R_MCU_0_MU_0A2		295
+#define IMX_SC_R_MCU_0_MU_0A3		296
+#define IMX_SC_R_MCU_0_MU_1A		297
+#define IMX_SC_R_MCU_1_PID0		298
+#define IMX_SC_R_MCU_1_PID1		299
+#define IMX_SC_R_MCU_1_PID2		300
+#define IMX_SC_R_MCU_1_PID3		301
+#define IMX_SC_R_MCU_1_PID4		302
+#define IMX_SC_R_MCU_1_RGPIO		303
+#define IMX_SC_R_MCU_1_SEMA42		304
+#define IMX_SC_R_MCU_1_TPM		305
+#define IMX_SC_R_MCU_1_PIT		306
+#define IMX_SC_R_MCU_1_UART		307
+#define IMX_SC_R_MCU_1_I2C		308
+#define IMX_SC_R_MCU_1_INTMUX		309
+#define IMX_SC_R_UNUSED17		310
+#define IMX_SC_R_UNUSED18		311
+#define IMX_SC_R_MCU_1_MU_0B		312
+#define IMX_SC_R_MCU_1_MU_0A0		313
+#define IMX_SC_R_MCU_1_MU_0A1		314
+#define IMX_SC_R_MCU_1_MU_0A2		315
+#define IMX_SC_R_MCU_1_MU_0A3		316
+#define IMX_SC_R_MCU_1_MU_1A		317
 #define IMX_SC_R_SAI_0			318
 #define IMX_SC_R_SAI_1			319
 #define IMX_SC_R_SAI_2			320
-#define IMX_SC_R_IRQSTR_SCU2		321
+#define IMX_SC_R_IRQSTR_AP_0		321
 #define IMX_SC_R_IRQSTR_DSP		322
 #define IMX_SC_R_ELCDIF_PLL		323
 #define IMX_SC_R_OCRAM			324
@@ -373,33 +380,33 @@
 #define IMX_SC_R_VPU_PID5		363
 #define IMX_SC_R_VPU_PID6		364
 #define IMX_SC_R_VPU_PID7		365
-#define IMX_SC_R_VPU_UART		366
-#define IMX_SC_R_VPUCORE		367
-#define IMX_SC_R_VPUCORE_0		368
-#define IMX_SC_R_VPUCORE_1		369
-#define IMX_SC_R_VPUCORE_2		370
-#define IMX_SC_R_VPUCORE_3		371
+#define IMX_SC_R_ENET_0_A2		366
+#define IMX_SC_R_ENET_1_A0		367
+#define IMX_SC_R_ENET_1_A1		368
+#define IMX_SC_R_ENET_1_A2		369
+#define IMX_SC_R_ENET_1_A3		370
+#define IMX_SC_R_ENET_1_A4		371
 #define IMX_SC_R_DMA_4_CH0		372
 #define IMX_SC_R_DMA_4_CH1		373
 #define IMX_SC_R_DMA_4_CH2		374
 #define IMX_SC_R_DMA_4_CH3		375
 #define IMX_SC_R_DMA_4_CH4		376
-#define IMX_SC_R_ISI_CH0		377
-#define IMX_SC_R_ISI_CH1		378
-#define IMX_SC_R_ISI_CH2		379
-#define IMX_SC_R_ISI_CH3		380
-#define IMX_SC_R_ISI_CH4		381
-#define IMX_SC_R_ISI_CH5		382
-#define IMX_SC_R_ISI_CH6		383
-#define IMX_SC_R_ISI_CH7		384
-#define IMX_SC_R_MJPEG_DEC_S0		385
-#define IMX_SC_R_MJPEG_DEC_S1		386
-#define IMX_SC_R_MJPEG_DEC_S2		387
-#define IMX_SC_R_MJPEG_DEC_S3		388
-#define IMX_SC_R_MJPEG_ENC_S0		389
-#define IMX_SC_R_MJPEG_ENC_S1		390
-#define IMX_SC_R_MJPEG_ENC_S2		391
-#define IMX_SC_R_MJPEG_ENC_S3		392
+#define IMX_SC_R_ISI_0_CH0		377
+#define IMX_SC_R_ISI_0_CH1		378
+#define IMX_SC_R_ISI_0_CH2		379
+#define IMX_SC_R_ISI_0_CH3		380
+#define IMX_SC_R_ISI_0_CH4		381
+#define IMX_SC_R_ISI_0_CH5		382
+#define IMX_SC_R_ISI_0_CH6		383
+#define IMX_SC_R_ISI_0_CH7		384
+#define IMX_SC_R_MJPEG_0_DEC_S0		385
+#define IMX_SC_R_MJPEG_0_DEC_S1		386
+#define IMX_SC_R_MJPEG_0_DEC_S2		387
+#define IMX_SC_R_MJPEG_0_DEC_S3		388
+#define IMX_SC_R_MJPEG_0_ENC_S0		389
+#define IMX_SC_R_MJPEG_0_ENC_S1		390
+#define IMX_SC_R_MJPEG_0_ENC_S2		391
+#define IMX_SC_R_MJPEG_0_ENC_S3		392
 #define IMX_SC_R_MIPI_0			393
 #define IMX_SC_R_MIPI_0_PWM_0		394
 #define IMX_SC_R_MIPI_0_I2C_0		395
@@ -514,11 +521,11 @@
 #define IMX_SC_R_SECO_MU_3		504
 #define IMX_SC_R_SECO_MU_4		505
 #define IMX_SC_R_HDMI_RX_PWM_0		506
-#define IMX_SC_R_A35			507
-#define IMX_SC_R_A35_0			508
-#define IMX_SC_R_A35_1			509
-#define IMX_SC_R_A35_2			510
-#define IMX_SC_R_A35_3			511
+#define IMX_SC_R_AP_2			507
+#define IMX_SC_R_AP_2_0			508
+#define IMX_SC_R_AP_2_1			509
+#define IMX_SC_R_AP_2_2			510
+#define IMX_SC_R_AP_2_3			511
 #define IMX_SC_R_DSP			512
 #define IMX_SC_R_DSP_RAM		513
 #define IMX_SC_R_CAAM_JR1_OUT		514
@@ -539,8 +546,8 @@
 #define IMX_SC_R_BOARD_R5		529
 #define IMX_SC_R_BOARD_R6		530
 #define IMX_SC_R_BOARD_R7		531
-#define IMX_SC_R_MJPEG_DEC_MP		532
-#define IMX_SC_R_MJPEG_ENC_MP		533
+#define IMX_SC_R_MJPEG_0_DEC_MP		532
+#define IMX_SC_R_MJPEG_0_ENC_MP		533
 #define IMX_SC_R_VPU_TS_0		534
 #define IMX_SC_R_VPU_MU_0		535
 #define IMX_SC_R_VPU_MU_1		536
@@ -572,6 +579,95 @@
 #define IMX_SC_PM_CLK_PLL		4	/* PLL */
 #define IMX_SC_PM_CLK_BYPASS		4	/* Bypass clock */
 
+/*
+ * Compatibility defines for sc_rsrc_t
+ */
+#define IMX_SC_R_A35			IMX_SC_R_AP_2
+#define IMX_SC_R_A35_0			IMX_SC_R_AP_2_0
+#define IMX_SC_R_A35_1			IMX_SC_R_AP_2_1
+#define IMX_SC_R_A35_2			IMX_SC_R_AP_2_2
+#define IMX_SC_R_A35_3			IMX_SC_R_AP_2_3
+#define IMX_SC_R_A53			IMX_SC_R_AP_0
+#define IMX_SC_R_A53_0			IMX_SC_R_AP_0_0
+#define IMX_SC_R_A53_1			IMX_SC_R_AP_0_1
+#define IMX_SC_R_A53_2			IMX_SC_R_AP_0_2
+#define IMX_SC_R_A53_3			IMX_SC_R_AP_0_3
+#define IMX_SC_R_A72			IMX_SC_R_AP_1
+#define IMX_SC_R_A72_0			IMX_SC_R_AP_1_0
+#define IMX_SC_R_A72_1			IMX_SC_R_AP_1_1
+#define IMX_SC_R_A72_2			IMX_SC_R_AP_1_2
+#define IMX_SC_R_A72_3			IMX_SC_R_AP_1_3
+#define IMX_SC_R_GIC			IMX_SC_R_GIC_0
+#define IMX_SC_R_HSIO_GPIO		IMX_SC_R_HSIO_GPIO_0
+#define IMX_SC_R_IEE			IMX_SC_R_IEE_0
+#define IMX_SC_R_IEE_R0			IMX_SC_R_IEE_0_R0
+#define IMX_SC_R_IEE_R1			IMX_SC_R_IEE_0_R1
+#define IMX_SC_R_IEE_R2			IMX_SC_R_IEE_0_R2
+#define IMX_SC_R_IEE_R3			IMX_SC_R_IEE_0_R3
+#define IMX_SC_R_IEE_R4			IMX_SC_R_IEE_0_R4
+#define IMX_SC_R_IEE_R5			IMX_SC_R_IEE_0_R5
+#define IMX_SC_R_IEE_R6			IMX_SC_R_IEE_0_R6
+#define IMX_SC_R_IEE_R7			IMX_SC_R_IEE_0_R7
+#define IMX_SC_R_IRQSTR_M4_0		IMX_SC_R_IRQSTR_MCU_0
+#define IMX_SC_R_IRQSTR_M4_1		IMX_SC_R_IRQSTR_MCU_1
+#define IMX_SC_R_IRQSTR_SCU2		IMX_SC_R_IRQSTR_AP_0
+#define IMX_SC_R_ISI_CH0		IMX_SC_R_ISI_0_CH0
+#define IMX_SC_R_ISI_CH1		IMX_SC_R_ISI_0_CH1
+#define IMX_SC_R_ISI_CH2		IMX_SC_R_ISI_0_CH2
+#define IMX_SC_R_ISI_CH3		IMX_SC_R_ISI_0_CH3
+#define IMX_SC_R_ISI_CH4		IMX_SC_R_ISI_0_CH4
+#define IMX_SC_R_ISI_CH5		IMX_SC_R_ISI_0_CH5
+#define IMX_SC_R_ISI_CH6		IMX_SC_R_ISI_0_CH6
+#define IMX_SC_R_ISI_CH7		IMX_SC_R_ISI_0_CH7
+#define IMX_SC_R_M4_0_I2C		IMX_SC_R_MCU_0_I2C
+#define IMX_SC_R_M4_0_INTMUX		IMX_SC_R_MCU_0_INTMUX
+#define IMX_SC_R_M4_0_MU_0A0		IMX_SC_R_MCU_0_MU_0A0
+#define IMX_SC_R_M4_0_MU_0A1		IMX_SC_R_MCU_0_MU_0A1
+#define IMX_SC_R_M4_0_MU_0A2		IMX_SC_R_MCU_0_MU_0A2
+#define IMX_SC_R_M4_0_MU_0A3		IMX_SC_R_MCU_0_MU_0A3
+#define IMX_SC_R_M4_0_MU_0B		IMX_SC_R_MCU_0_MU_0B
+#define IMX_SC_R_M4_0_MU_1A		IMX_SC_R_MCU_0_MU_1A
+#define IMX_SC_R_M4_0_PID0		IMX_SC_R_MCU_0_PID0
+#define IMX_SC_R_M4_0_PID1		IMX_SC_R_MCU_0_PID1
+#define IMX_SC_R_M4_0_PID2		IMX_SC_R_MCU_0_PID2
+#define IMX_SC_R_M4_0_PID3		IMX_SC_R_MCU_0_PID3
+#define IMX_SC_R_M4_0_PID4		IMX_SC_R_MCU_0_PID4
+#define IMX_SC_R_M4_0_PIT		IMX_SC_R_MCU_0_PIT
+#define IMX_SC_R_M4_0_RGPIO		IMX_SC_R_MCU_0_RGPIO
+#define IMX_SC_R_M4_0_SEMA42		IMX_SC_R_MCU_0_SEMA42
+#define IMX_SC_R_M4_0_TPM		IMX_SC_R_MCU_0_TPM
+#define IMX_SC_R_M4_0_UART		IMX_SC_R_MCU_0_UART
+#define IMX_SC_R_M4_1_I2C		IMX_SC_R_MCU_1_I2C
+#define IMX_SC_R_M4_1_INTMUX		IMX_SC_R_MCU_1_INTMUX
+#define IMX_SC_R_M4_1_MU_0A0		IMX_SC_R_MCU_1_MU_0A0
+#define IMX_SC_R_M4_1_MU_0A1		IMX_SC_R_MCU_1_MU_0A1
+#define IMX_SC_R_M4_1_MU_0A2		IMX_SC_R_MCU_1_MU_0A2
+#define IMX_SC_R_M4_1_MU_0A3		IMX_SC_R_MCU_1_MU_0A3
+#define IMX_SC_R_M4_1_MU_0B		IMX_SC_R_MCU_1_MU_0B
+#define IMX_SC_R_M4_1_MU_1A		IMX_SC_R_MCU_1_MU_1A
+#define IMX_SC_R_M4_1_PID0		IMX_SC_R_MCU_1_PID0
+#define IMX_SC_R_M4_1_PID1		IMX_SC_R_MCU_1_PID1
+#define IMX_SC_R_M4_1_PID2		IMX_SC_R_MCU_1_PID2
+#define IMX_SC_R_M4_1_PID3		IMX_SC_R_MCU_1_PID3
+#define IMX_SC_R_M4_1_PID4		IMX_SC_R_MCU_1_PID4
+#define IMX_SC_R_M4_1_PIT		IMX_SC_R_MCU_1_PIT
+#define IMX_SC_R_M4_1_RGPIO		IMX_SC_R_MCU_1_RGPIO
+#define IMX_SC_R_M4_1_SEMA42		IMX_SC_R_MCU_1_SEMA42
+#define IMX_SC_R_M4_1_TPM		IMX_SC_R_MCU_1_TPM
+#define IMX_SC_R_M4_1_UART		IMX_SC_R_MCU_1_UART
+#define IMX_SC_R_MJPEG_DEC_MP		IMX_SC_R_MJPEG_0_DEC_MP
+#define IMX_SC_R_MJPEG_DEC_S0		IMX_SC_R_MJPEG_0_DEC_S0
+#define IMX_SC_R_MJPEG_DEC_S1		IMX_SC_R_MJPEG_0_DEC_S1
+#define IMX_SC_R_MJPEG_DEC_S2		IMX_SC_R_MJPEG_0_DEC_S2
+#define IMX_SC_R_MJPEG_DEC_S3		IMX_SC_R_MJPEG_0_DEC_S3
+#define IMX_SC_R_MJPEG_ENC_MP		IMX_SC_R_MJPEG_0_ENC_MP
+#define IMX_SC_R_MJPEG_ENC_S0		IMX_SC_R_MJPEG_0_ENC_S0
+#define IMX_SC_R_MJPEG_ENC_S1		IMX_SC_R_MJPEG_0_ENC_S1
+#define IMX_SC_R_MJPEG_ENC_S2		IMX_SC_R_MJPEG_0_ENC_S2
+#define IMX_SC_R_MJPEG_ENC_S3		IMX_SC_R_MJPEG_0_ENC_S3
+#define IMX_SC_R_PERF			IMX_SC_R_PERF_0
+#define IMX_SC_R_SMMU			IMX_SC_R_SMMU_0
+
 /*
  * Defines for SC CONTROL
  */
@@ -637,6 +733,10 @@
 #define IMX_SC_C_INTF_SEL			59
 #define IMX_SC_C_RXC_DLY			60
 #define IMX_SC_C_TIMER_SEL			61
-#define IMX_SC_C_LAST				62
+#define IMX_SC_C_MISC0				62
+#define IMX_SC_C_MISC1				63
+#define IMX_SC_C_MISC2				64
+#define IMX_SC_C_MISC3				65
+#define IMX_SC_C_LAST				66
 
 #endif /* __DT_BINDINGS_RSCRC_IMX_H */
-- 
2.37.2

