Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1D661A0C5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiKDTWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKDTW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:22:29 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9071900A;
        Fri,  4 Nov 2022 12:22:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzX2cLEgKRBVFpWxmAziQzrk1D+edB3kDAh0KppbNqn/LS5IxKlklIRG8yG9XaAxtcotQCm/l4+p4yHLYt67DSnRscczRwDEy7ojjbEqaqs3BUkB3L1CCt7ETXmW2KCnrWilYRjnfRioJbEdz3VdbnFzxv2loKZNG3XY0AB6Z+gsaDqHd/1LiRRibTBkt9VRYXKpvnhc6v5O6Wop5sPDK8e5VZFkHkuZ1buQee/jeGWsbDu0LKB+uXo3/xWLw1bFfVqXaC5YdXvQFZrbn7QNCFGHd5E/B+jlkiHl0ATdMARUWTE9ceW1iq7Ur6ff2MzQgBH5ug7hS1TtXJR56UVhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSlyb/z2NgF7IIQoTFzg5Txr6NKrw734zlNeYdTD/cE=;
 b=k4l5h7L4m6ya5fzpjrPFYyEUpjBUeXf/Vkq8PFllcLLap806UkSyi6mdCKTbIh7Cq2bIz6JEBTLhJ5PE3iIYUZvm/sE7rFiKK+h1Y8EGiZ2K8T1uTEnkI4nbZyDqLgFJ7HVZ6rUppV1il4FdyELhCqQlQEeVT201ToLegjYERW3PC13Zdg7xaVRUTMAWhuhWH68q2xR5ZbswTGkkxdjo27HWCPRlYML8vixZ/jcx+NZjpnawxsDLTIGmrr1HvaU83zte3BtB862EjMiLzChqyiEUSYfWCHjDSsX6H2iYGmGn5r6ZDpk1/SViBQoscVsrbFHhtbeCbNjTu0eP3vvGCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSlyb/z2NgF7IIQoTFzg5Txr6NKrw734zlNeYdTD/cE=;
 b=VwfvdcYLWJlRT7ejDFSWOfNPOZUv4hjvI/X8zayRYZq7/RUaKHXrsND0RtS7SjNlaidoio0y/+yJf89X24g5koVLtoGEtDJry7CelrZ/V2rjncZcYuPvoVyjLYLtYYiNTmRTjbh0n8TDDBfrCU8gm8gwpd6J5OJB6xVFMfkuEsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Fri, 4 Nov
 2022 19:22:25 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%11]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 19:22:24 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     han.xu@nxp.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 1/3] arm64: dts: imx8dxl: add adc0 and adc1 support
Date:   Fri,  4 Nov 2022 15:21:25 -0400
Message-Id: <20221104192135.1661541-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR01CA0004.prod.exchangelabs.com (2603:10b6:5:296::9) To
 HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e81d0b-ae7a-4809-4b03-08dabe99e741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S11dlZRvCKuFUZS7SrjbiVOjmewSr2QajMyEgETgywbkmCq/YQmFfnFx5a+RdsajY7BvEfepsMor4Qx7Y2G7WBdGSJ8AqGE5LhD5V+FP2Ka5LyzEdgKKlBzTTWLYEnFQwjQxGaOANuoDcTdCxErKSawhNt7VD2eKR3vpeI/zNNQ+1yJqC3ztT83yZzBzQ5WbCjKnmojdcC1DEVPKLeKj0jWuX9MSJoJO21IjNn0EmabLnJEGD6gTMQYl9cxIQoAhrPLoRuOE0zik6HT0YNQh0B3aodjYdewdbWhBMm0Sz18rMJzC53z7A3nai39JqnDU69AdX1sz8HETpLVji37R7jRkr4oFdlTSBj6VIxRsH/qKiEzFE2wHinkc4LVD/lb7BqVw3XW+O0zH4oNzcp09JUJSpqmNQ27QPJ+2VMbAEF82OWOhxZH0B/PsiKCDoEwcFLdY75cDrVb8r7JbQXm8p3uJ9Vac7Cm0zo88IMTIQndDYjvV5PSaWqyK1gB0MhpSgCUNWo1uKqK9VVwj+opBRHonUwhtkrdzrjl76zOgYlWvGPw29QR49x+QKQkZ4vgkXMiPr/QcyGliljt3atVATnL6OGeHh53leCuo+pldWMo6fml34jMWHVqk/W1oFvGu2zPV0xI7ifPtoYedMU7rG9mq+8dbOKaDdgyySv4P5dq8XkF3xQjIlb4GN4wWfNX+V0ENIQ2JweIXb0QYlVx8UAzhdfBzswyd6DupqxC4OYIlJzJARPVsHFFnFTEmZ3szTQrsCH6d/JxRzZHdiKoK37ELQpdYSbXBV0TCV6ku4nq709CtPYvAxpFx7UGGWZZp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(36756003)(110136005)(478600001)(2906002)(83380400001)(7416002)(5660300002)(86362001)(921005)(38350700002)(6512007)(8676002)(38100700002)(316002)(2616005)(186003)(6486002)(1076003)(26005)(66556008)(66476007)(41300700001)(66946007)(8936002)(4326008)(6506007)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a3+vTITzLJ0fPPgiSfamP270LreZ/uAk92qflhWRpr4ccdDeDiaVDvoA2vUr?=
 =?us-ascii?Q?vlveNMTQEU2y+teEavg32dAHR1xWe/ws4nTOI90xGIr2u52OjyvbzemFNZhR?=
 =?us-ascii?Q?4gNRckGqVJzcKUG/vjZkRlLLWg27Nvjyq4UoOmH4JMLLWdiOT/R1XImYtNw+?=
 =?us-ascii?Q?vQgKgxnn+4aL+XZPuGFHNi5wTGaRNknmxETVR9WIX3/UFgB2B/zMebm7v/+b?=
 =?us-ascii?Q?SIqh/R+ip12gGXqGbGjLYdpBlkhoM2rvpT/zY1rgkNWbKBKMN8iVp+rBhijU?=
 =?us-ascii?Q?2E3aQRPKM/ls8NwtxJGuZFpkruF2963CiiyiEnqiOOkq1wDBZOBnrXh6GwnV?=
 =?us-ascii?Q?o07aiN+/zn/7KL2vbgq003HwfxVIXAWH/ntR/+tiXGBL0VrM8YQYHyyqqcEt?=
 =?us-ascii?Q?b/JvNJGmxYeq7Km6WRAwBLEiBoUxKDZEMi9itIQnWRWoQtIQ1r18wgqezMp4?=
 =?us-ascii?Q?dzwVtYErAL+wI09JkZwbFM4WzvVlpp/kWhwyNl4Ykf0/Cwco/HYBH38jJbtG?=
 =?us-ascii?Q?Zt0WSmMFdXyqG/IBF/OrRiJU7FXPLPpiUtY0g2FpqQ5ZUDuqKrGmsPmvQsL8?=
 =?us-ascii?Q?OZlCOn9oRz3I2oaqpTUU/318UDd/mgxXYymUHfZ/WkwPcwEnj/wTUXwBcYWO?=
 =?us-ascii?Q?WlaEfu02YRcgwdA06d25Mk4bkZQUhZYUVSXjsJQYTmnW3NepDUHaLPRYSpsa?=
 =?us-ascii?Q?zZS0kS/ls/3j0ptIY8uIQQyWUFXFAef5LF5F56O8UdFp6YQ+QhSDgzUpLPDZ?=
 =?us-ascii?Q?XfExaLYxFIs3dLcqgq2VoHBbSr8vRsa+ys7+UdMMOJz53VbzYP5n7IOOA97Q?=
 =?us-ascii?Q?CMaANMOF2TsyEzIzrSCgE37DGtpTyM/4k4vCUqtyo5BfrWRgkj3nDU4cl7QG?=
 =?us-ascii?Q?NuZt3Se/O5w3D8leo9wlEJDTkQcL771JLPf9C+mtFuRwHnFsHVx6Yf8HzyE3?=
 =?us-ascii?Q?i0II84JZOckUEIyXIG01UhTeY3mLp0tb19mag20bv4ATNgziNdYjgJQGF1K0?=
 =?us-ascii?Q?DlXCdeC7vfyShZhOy1lv3g2cUAJRX7zPDo5qE2tvP9kmjUwtGC4TaepyVVtK?=
 =?us-ascii?Q?b2Y1HjX8YgdJxx8YuU1l3E66MyEXSI3fn0fZ5gxTqnnHwBl+uvjUq2l/YeHm?=
 =?us-ascii?Q?cRTTLp93pkS1A+7gtTTavhB+1P5T0Uku4gjy3ksAQ/Fd//5A+HPSZKbeuR49?=
 =?us-ascii?Q?whYAPkaTaUOzYSAWxTq1vX5k0V9PWfyBr+ZmEggcvPVUBQ8sB9VOpbVxRh00?=
 =?us-ascii?Q?SAML8N6rKBnWNsPQnUmhe+pdOmy+5GRitmoo6ABQfHLAO7cnz4zekVrL+wGt?=
 =?us-ascii?Q?WFO8gGn0Oe9HX0DEIrq4l0+DDQTjdWaQKTWmhh5jMbjeZhDCUYwJZO2MQwoj?=
 =?us-ascii?Q?TcAmQnvY+kMjw3kGkHq12BUUupk7gPHYnb+mW6Tx2Gnk9N8ir/vq7yzCyXEg?=
 =?us-ascii?Q?/e88cfJJjNssJHSx2WJ7MxyEfP3sjQK4VWiNNo6pNN5b7L3Z4NwSamrUBzjA?=
 =?us-ascii?Q?KwYx0bYHapMb+ka9HqvGVnSfi+0WWUWaQy5JIZQQXOyXc49ojUVaaUrm1hx6?=
 =?us-ascii?Q?tByJO6xx1NgamTt5qmfYLG4nqPJHQuG8MT9DFRGY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e81d0b-ae7a-4809-4b03-08dabe99e741
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 19:22:24.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8YiimhDRCbTiYmyN/3Gp5zGk6iY9CK6o+ZoC0i7KmauWrIuEM6Orh+lqh0ObxfQeiWDoD4lQimVmpLKsdA923Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two adc controller in 8dxl.
Add adc node at common dma subsystem.
Enable adc0 at imx8dxl_evk boards dts.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 52 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 12 +++++
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   |  4 ++
 3 files changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index d7b4229bb4a2..bdbb660c2682 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -156,6 +156,34 @@ i2c3: i2c@5a830000 {
 		status = "disabled";
 	};
 
+	adc0: adc@5a880000 {
+		compatible = "nxp,imx8qxp-adc";
+		reg = <0x5a880000 0x10000>;
+		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&adc0_lpcg 0>,
+			 <&adc0_lpcg 1>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_ADC_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_ADC_0>;
+		status = "disabled";
+	 };
+
+	adc1: adc@5a890000 {
+		compatible = "nxp,imx8qxp-adc";
+		reg = <0x5a890000 0x10000>;
+		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&adc1_lpcg 0>,
+			 <&adc1_lpcg 1>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_ADC_1 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		power-domains = <&pd IMX_SC_R_ADC_1>;
+		status = "disabled";
+	};
+
 	i2c0_lpcg: clock-controller@5ac00000 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5ac00000 0x10000>;
@@ -203,4 +231,28 @@ i2c3_lpcg: clock-controller@5ac30000 {
 				     "i2c3_lpcg_ipg_clk";
 		power-domains = <&pd IMX_SC_R_I2C_3>;
 	};
+
+	adc0_lpcg: clock-controller@5ac80000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5ac80000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_ADC_0 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "adc0_lpcg_clk",
+				     "adc0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_ADC_0>;
+	};
+
+	adc1_lpcg: clock-controller@5ac90000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5ac90000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_ADC_1 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "adc1_lpcg_clk",
+				     "adc1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_ADC_1>;
+	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index fc9647ea50e9..11b1ff90c06d 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -91,6 +91,13 @@ reg_usdhc2_vmmc: regulator-3 {
 		off-on-delay-us = <3480>;
 	};
 
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	mii_select: regulator-4 {
 		compatible = "regulator-fixed";
 		regulator-name = "mii-select";
@@ -102,6 +109,11 @@ mii_select: regulator-4 {
 	};
 };
 
+&adc0 {
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
+};
+
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index 795d1d472fae..ac3362e32811 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -11,6 +11,10 @@ &dma_ipg_clk {
 	clock-frequency = <160000000>;
 };
 
+&adc0 {
+	interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+};
+
 &i2c0 {
 	compatible = "fsl,imx8dxl-lpi2c", "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 	interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

