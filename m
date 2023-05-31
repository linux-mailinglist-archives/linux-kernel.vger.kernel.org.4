Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BF471773A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 08:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjEaGxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 02:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbjEaGxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 02:53:38 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2042.outbound.protection.outlook.com [40.107.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E380B1B8;
        Tue, 30 May 2023 23:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlf/DhdwhRFA645B6q8pSJHCPwnVp3LGMYoIlNJi+67gprWgcrjwkJgV0M9Wh/rVMGrN2HFCDT1d2USrER4+5kr5qCJMGKmmCetOmwlGEulWh4cZpTMj/kJp35rHz35JuC171bgvYTCmcfWb5WDn5iFoTqP7r1O4sB9FD4uUjli6ujWj/ygdiIAtH7UFxOmrGcr5dcYGEbHcsLys4Dlm7vzdyMrbtrwq+ZEQF0m5ZDf+2TWPi5oSZPgA16urfUkcnhnk09OZqDJ+ssPvSsUpRygYCEoG+0SwlnG59XlvAa7e/vDEK33rUDNpIVvWsCvcUZvPrqQQZ6VJaq4jD71UDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhuLyZ1wbm+1q3bVqQyhAWAwcZ1Yg+s+BXcUwMAsPls=;
 b=mMgZUBPedxfUi79/5diSMWifhRAtFMcxnVqND1IdXteP7QPqX8Pbq7n6BlJvCFKBbsUJifDm22Kkers6Ej49xNevBuG7Fsq7lL+hSElDUIj8iIhCjDyoaGtEOeupSkYM0QP99jIH+AN6dPVSBnFW2qwHDLwtO07fyH+g4dvRHy4zQV22bJ4fp4XkxM4MZGuV+XdEq6TjD0yZ4qNO7ABMs/O4GZf3UuauGRhHpzAsEAuXX0SnrAPiRa00p99UI5t4/74AS+RL3Awq+rqap2cjjebiiCnJNiKs/oNQmbWt2Xns3Q5j52iwHkC9vYPNE++oMupbi6ZemRSi5j/SENLQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhuLyZ1wbm+1q3bVqQyhAWAwcZ1Yg+s+BXcUwMAsPls=;
 b=g3TYXZ8z8/1fKe44TAFEFGjyCIvnmyWbyGCFddYs+qssREFLEmurRGV+lKtXGTVEzJZTbwpfaK+fiwNmQ+knJj5FlYv+4QRXUL4tocOxz80T3WqzLeGnQKux9pmUIpV/PmVmZweO9zqDods+nNImNtfOT9S7a0tID105EKTTd1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM0PR04MB6771.eurprd04.prod.outlook.com (2603:10a6:208:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 06:53:21 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::1a8e:7e33:7f24:d77c]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::1a8e:7e33:7f24:d77c%5]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 06:53:21 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     ping.bai@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] arm64: dts: imx93-11x11-evk: add pca9451a support
Date:   Wed, 31 May 2023 14:57:24 +0800
Message-Id: <20230531065724.3671795-4-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230531065724.3671795-1-joy.zou@nxp.com>
References: <20230531065724.3671795-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5925:EE_|AM0PR04MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: cd1eb43c-db3d-4bc1-0fbe-08db61a3b91f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Xl2EURUTPYVBvM0573F7pggQ8ln760KF01kR8/qMmo6Z50hE2x4VEu3df4KJQSQaVsSLpBl3bFo94i77oS+ghhURnB0NNYGDixVFs4ESYvpAxkhs7VULJFnmCcg45V75qH74zX98FmEUdgDCWURmwYtHleer5Z3Q7sL/sbeOV1ePu1o+mLSZRpIAt4VKG9sHbNUlCSwvGDwHjK7XrbFuqVXOGp2q4sxcBySkkJr4LMyLPk+otNwNMeRXvNra7NWYfXrQd3QEEG9C2PndMlt0kTA2mer+QIesrYI3yfSIUhCtGVjRuNZeth9pCrMRfyiUWQuSM1/IsxDt/34VBlGW3glmIwSBTfBSM8jAvM01ZXtIUnAaeRC4zHxgaTPiIn4qLtALAXkddepIvfuIMBNGPjbuVGIkDTUN/kSxWLdR7u5cLSc0e1l15oBOq+JgpiZDLojGbAk3CTXehfTZYg2UAKEIjNmJHIHb8Y2BALMxIhMG0MfvuBKOvP62MMtbLJthuV7K/cvorzteqtB6MQvP2zyF7xVVtNCYXUaSr1lcrwJrCOkIeZBtj0Iwxcus+Q8mxrmlHmytz4vskIAeRwughJ2tdX7hq5X5xBjnAPY/8OSA5AQzIcPPsXbcLhRFKZuLnnASvMopBOlyNJVekrEoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(26005)(1076003)(38350700002)(38100700002)(41300700001)(52116002)(6486002)(83380400001)(186003)(6512007)(6506007)(2616005)(478600001)(8676002)(4326008)(66476007)(66946007)(316002)(5660300002)(8936002)(86362001)(44832011)(7416002)(66556008)(2906002)(36756003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R5CbEXZBBewDW4h7eInRXH09+KmFshxdqTtBFwIV8wYC5ZkvYSEsa8Da6Qv9?=
 =?us-ascii?Q?Rr2015zq0etp7Y3zyrWBD0Od3W4Cssj5y4nQt5gfoZFWeIeLsgseN4KVfK1Z?=
 =?us-ascii?Q?XR89ZrJLj4qixjrUvIr0XZzpyKG8zd3rwsMA2qLHDKweNiH289Yf/RVI1fxP?=
 =?us-ascii?Q?j3TRpDEGw/OYN0aYBuM+xnvF6f853mMQtQXZF1UXKZZ6bm5c94uMLzcXLwqB?=
 =?us-ascii?Q?p8aCgT1f8bqMKED866q2kCHtQbv0a0e6AcszHqdfCJcPFAiREuT1k2o69N3K?=
 =?us-ascii?Q?H7fIdvAi9KiRVZziUY2xaMvikm44xJ+YNBTVyI5gGm1DMmEluHK+Xsrpym06?=
 =?us-ascii?Q?Wteek3pUEqdlM4mipYfAm3EaD1dlKCXLm16xiPtRlASdUEtCifLHKNGTUAr/?=
 =?us-ascii?Q?QZ3lc0WWM5PRb7x6EEEU0EZ1gZ5vK0tJOzDQRL+BRof+cgDVsOkyCEYrqqf7?=
 =?us-ascii?Q?4r+oALSNsfJ8V7jyqsj0v9CQoIV91I5bMFMcvYy6s8yqz8GeuowcDdPA97WU?=
 =?us-ascii?Q?axjYMbwVu9Ww7SAFJ7vxcq2Rt+JImyLPZuiHm37yMkNssELCLFKl4GDS169U?=
 =?us-ascii?Q?SfralSU8DL6Wzre2HNYp9gKBGm0cp5VYwPy4uH2VCRhZiRAGK04Hyhs1ibYx?=
 =?us-ascii?Q?s4P298WM2DB1Jj03ThaxNCNen7rAQSMr5NqcqTZVnNLtHrw1W+3ITZdkmmwI?=
 =?us-ascii?Q?RJT87/Apln23r/FsOafNzQZTT7I96ajsVibz3OKLhTBQkbl6qcJLynLGJE67?=
 =?us-ascii?Q?ChPCcASd7FRZrITdBh+CWHE1rU1/PxDRGqxooSqfsoKH4kuWnEK7io6pd4xw?=
 =?us-ascii?Q?Omwb8J5IHUIqF6BLuDsJZ0exf54yz7w/NFiZINZbrGA7mariuxtT8z6F/UUu?=
 =?us-ascii?Q?M/HrZriNFMxnkE3CkcwV5kdIi178E7qphYD1hPAeNiJEmmbkAAiq8RyR/e4i?=
 =?us-ascii?Q?PMn/ld6SF0buAfyb3H3biqkk4E3AfB/plhpWpZDmDAJJfor2Baf4z02UPbSo?=
 =?us-ascii?Q?01j9M4fqPTP3NknMa4Erim/oo01cpvcxPs6i40O2KA94sgEt42DdsuhO3fVx?=
 =?us-ascii?Q?RUj/ZY1pNdTJTz1a47qOtcAY0VsZye8RW6XuFj9oYDNwkW4egnse7gAKQm6V?=
 =?us-ascii?Q?cbKx31ua2l8cpFgnVVZWqVbCfQx4FE0gA5RW/VglfoTTR+vCY7Y8LBbwp/vN?=
 =?us-ascii?Q?RWFjDqvQxGvhiNhXFzdHQXIeeoz12T95O9Qx3fe0ny74ZuAZmj9u2znn/MbJ?=
 =?us-ascii?Q?a4OVTIWGAOMbBmooAIP0SGcbbsRa3zwv11fAzZGFW2p5EegC/mrbUxgSW9dA?=
 =?us-ascii?Q?W/D1KZu+Nihk/QPCmKME97hXovvUruv3qJYFPsgfsGnTbU/upQpPcAcSQcmA?=
 =?us-ascii?Q?GlLmUu15p2P1qt59QfiMPtECKPCYxMWzRPhS67CORSuwzKsRXF6UybGaWLS1?=
 =?us-ascii?Q?n4uFRxr7h7XFlGkgjZudreWN8CQ/bPDY8f6Z+QjC4KRKC0fvsagWagVNPS5S?=
 =?us-ascii?Q?7G5YRoX2cxq1DNHe/EV8mTaKAxEOaDVi3xbyi2XYZLu6EnacPnfnhrnaD3sr?=
 =?us-ascii?Q?cPx+leXuO+y/DcNW+OsscR5tUQiae5c74oZwouFZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd1eb43c-db3d-4bc1-0fbe-08db61a3b91f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 06:53:21.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TI6Gh94tCvEqhHw4Phu05Dbv9XLWtvL8HEgpn5tjxNrdqxDquUXTust/JmUovcgm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6771
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support pca9451a on imx93-11x11-evk.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index c50f46f06f62..4de08d628b66 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -120,6 +120,105 @@ &wdog3 {
 	status = "okay";
 };
 
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2>;
+	status = "okay";
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <650000>;
+				regulator-max-microvolt = <2237500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <2187500>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+};
+
 &iomuxc {
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
@@ -166,6 +265,18 @@ MX93_PAD_UART1_TXD__LPUART1_TX			0x31e
 		>;
 	};
 
+	pinctrl_lpi2c2: lpi2c2grp {
+		fsl,pins = <
+			MX93_PAD_I2C2_SCL__LPI2C2_SCL			0x40000b9e
+			MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
+		>;
+	};
+
+	pinctrl_pcal6524: pcal6524grp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
+		>;
+	};
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
-- 
2.37.1

