Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8854B625EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiKKPsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbiKKPsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:48:16 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7C963BB5;
        Fri, 11 Nov 2022 07:48:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5zunuunEuMWs9vwEWlSCUUrjtcnaTVy6XohuCeEUssz/Yw6B5cWUu1SGkVF1zjWQJlrLumbkLOG3H4T+h9XoJDFY8tKQcsX9s62lmRJXTZemf9rbnmyU0qTZdn6HHwPjsMpVqnVBUzmqgGbOXPKoyP28kq9oeadiS6Vr6X4ZGCOTSNEeznXKHenf8WbKKhQziMPsYtTbkpchJcRWFUxVrDn2gpAs0Q1+4eJVoxey4wLdZHdEshhP/RFsoSbnCrFYMMZqw71yQj10P5bAACVtPsdpYjR2EUXevE0vQqUupbbtFnFYe42UkaJHyz+tPiUIGWZcfKigsyj5Oe0KLD4Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBv/hZoysHfhJpqIxBY+he+hqH1X+XrxL/mM6CyZDDs=;
 b=FuuVCYOeE5cfIKf0p04sKE3XhPidXumdseEbKTS2ehTE8I7DlhHmFXM4LgDAcKsioRfz6Sy7x2UtXHOYEIUitFh3muzLip66aOosuEiIdSuc6Ic1UO/Cpe1bTC86no6znz2lWGdxnkyMpzCCRE+RlJT+5YM0OvccObHT9q5JatOZVKV5fQ3CowHF633PRCCLSCnoleB9xesfJkEvXu2npyInyhncyUY0l8vkdvEa6CPRNxoB83Y6bv05l8MltKDUkE8QVmnah5YWXqjfxJnbc2T5qTltrjN9pO2FrCYwGKH46l/m73YZ6gXXm757HVlbXmqeCL4BoobQhHXchZX59A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBv/hZoysHfhJpqIxBY+he+hqH1X+XrxL/mM6CyZDDs=;
 b=EpKpnQjBp2mZoZJjPQ2/5ro22d6OmdlPtsKPa9WG2QeLx6flHkVUrMqLJ/7uKgY9czLWKVAhCc4fLrpNethvpgYV94gfR+jKxqFZuWIoTJ9z3OBownftXsMFPjfPx5AUdXKaTHfwQTtH8qpMdm52f/ZDtVumbvW2jgUJNzB/y2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DB8PR04MB6969.eurprd04.prod.outlook.com (2603:10a6:10:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 11 Nov
 2022 15:48:10 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%12]) with mapi id 15.20.5813.013; Fri, 11 Nov
 2022 15:48:10 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     shawnguo@kernel.org
Cc:     Frank.Li@nxp.com, aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        festevam@gmail.com, han.xu@nxp.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shenwei.wang@nxp.com
Subject: [PATCH v2 1/6] arm64: dts: imx8dxl: add adc0 support
Date:   Fri, 11 Nov 2022 10:47:37 -0500
Message-Id: <20221111154742.2753318-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111154742.2753318-1-Frank.Li@nxp.com>
References: <20221111154742.2753318-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DB8PR04MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: ae86a1ed-8270-463e-48fb-08dac3fc224d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6h7Z7b7CnUguVsrCNcA2J9yiErthMnIWTUPvFW+57ZJ3BNgxdQ7eAbid8d8Mc6Hpa+kDNTYEll1jE8P4qB3qX1p9Ejpq6pfhZySJMJdtef0BtKjTMsdhV3D0C6Gd5CoOc7X2itApxS4CPtULlSqfKieZIXPu7CfbZ91Ki1JFuYN6+/5ZWZE3ySJbR3iREwysZkRgHmw4SHAz3V6o3p5vsyYCEWESAsiAK/YUyuRvDXk+CQFAdlo75UcaDpdp55MmO/AYPa++ZCeVMLg5+Xx1WqzLQAUpU8kTghy8e7UZH5xnsIWEQKtAawFvr2KOEmXAJzom5OeaGHccNxzW5PzDHS6S2XsJBqJLhyUJMrmjjkFdPqkDe3Wo22T3xJN0IUiAAxYOOJjn54QxNR+oghSc4oA7HjTomGTLoJaM0UoiUckbIgnK2EZ4+J6PW/6DEGVj1q4JM2HI7+FaCscQTju9NVb6SYYkE9gvbQKP2w4QKNnk9EhImygw9X4qFqpTNbcEhkDplfNl1Qp5rU8JTK/DtArgtJjfu9/wjEaEnS+7lycqPezW0Nd+SV0HHpJxT5caaI8HJipQETuJhB9iTHTyax5Gu3BDnHHzrZNjzHj+v1wQHvfko1q87jihTthpN08fvqYFmieQdFmSu38KFsmFdHIBvyYMZV2DheL4Ra0RTk5puShWgn8PWnNP6+q9YP6meIuYTxBierHSiadHmF8fwsV+pCrVcsVG4Yn6r+ZhWLXaPAZrlCX/4D/+pGow23X+RlmsEvrcbDuPl25FeDoiX3XPAnAuxPst1Zd9zOkJxxA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(86362001)(66476007)(83380400001)(38350700002)(38100700002)(478600001)(6506007)(8936002)(41300700001)(6486002)(8676002)(7416002)(4326008)(66946007)(66556008)(186003)(2616005)(316002)(26005)(1076003)(6512007)(2906002)(6666004)(6916009)(5660300002)(52116002)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GJMtf/SZ3zsWeN+t2dVohqD0/8bnqCIxh5XjRpoe6v6/oFHUv0ShD52hNsdd?=
 =?us-ascii?Q?dQ5E617AGIH2TF4XHbIF2zoSQ+wfSFakg7JIwLeTv5NxBbRoqPKH+VlEuSCF?=
 =?us-ascii?Q?sVHZ74+i4yNN3E7PH/uaOF9zgFYkgyM9LhUr170kh+EGx6gAxVgmL5LiauNq?=
 =?us-ascii?Q?MrjSkuLwsRe89DmVxzO5Q+VamX7+DFtv0fzbavEtNwddojHDBjUQqBpShV9K?=
 =?us-ascii?Q?kgVOspmEaLEGiVcdBHe61ORjAwlpDgIxeIRjoBR3hK7PDv/g8fw24GQ8MB4y?=
 =?us-ascii?Q?ogiFPJsfinfuuhY3S3afeSM23prk6X3KjmXg80RncuWbriNYiw3MuAB8Yjiw?=
 =?us-ascii?Q?mLFibDY1xUfoin44hJTo6sdwmtDf61q97kf6fuEjs9Txtz72FX6ku57VLp7p?=
 =?us-ascii?Q?RFQHFXKGsImFRGkspbhEGD9KinBt33ejsEktPEukdeOdqEV6UgQ2bqO+r5w4?=
 =?us-ascii?Q?NNxJR2bjlPuzWG/DQA5mUb4pcJj1zFs3sq374PNtbeDtDsVXcbYtWXlODi1E?=
 =?us-ascii?Q?gtSmXDKyHa1q/9MYSDQvp0/kaqxSnM20uiHimBwsmSeaKNzpDnyUVW4XaLiT?=
 =?us-ascii?Q?cGKDGV4x7i+qDPGSyu73PGgVgI7QvZh/fegy8ZLBTiGIaA26cT2SsXDVzocl?=
 =?us-ascii?Q?I3RTADVDQPE50K6uuGah3Kcoht6ksrV7+MOlooxZScpWE0+Fk7oIZBPVDJuf?=
 =?us-ascii?Q?CFQMR0TkZ5cReuhN8IgCSIVKRllWNFRgj8PBVVotFQe2qSd+9dfa6sxS8uLj?=
 =?us-ascii?Q?411B3VKGvBU4ByouP63kStIEs8bWZOo2lglBewdNdvobyQw+f+jTk14xwgev?=
 =?us-ascii?Q?t9qiJeeWwheWKwSRM4dAqA8M7k3M9ZThzCI8unWoCPfntZ37uT1y0X0Y4Rot?=
 =?us-ascii?Q?zW5ZwlkWX/6I608qJCeYzTtr9+Y2+8lWHNMChTnD/x0JE30VZjO0SyjQx6mJ?=
 =?us-ascii?Q?VLEuv1g2OcXbFSsSkrvPNx5RTbEWggKsmCRUnNsay9IdYl7unm2lztH6I/bl?=
 =?us-ascii?Q?lSDQskGj4lhqx8vXmMUW4idD/1RHzpuiqvFl3FG39OdVEE4+h0bf/dvpK8D/?=
 =?us-ascii?Q?4yu0zET8OhZd6b+6S50wQ4oDXpK2YU5kYzsTgznFMQNLwaFT7JhMhyEezN7f?=
 =?us-ascii?Q?4j91NQ1oo0xb1C+Qzl5w8dhrg356Gx0moaTpwkUU4/aYV7vwSKyxNFkLHXFu?=
 =?us-ascii?Q?3nZP1M/LI03XvEQhk79hkxClnN//t8mx7Hqxx+c7tYvsHGdztL5iPpIP5mXu?=
 =?us-ascii?Q?tR5T/1xJ+BphsgDPo7F8akkuR4wU+LJatr7m7uVWkxqoZQNde2X+DR8JnSWW?=
 =?us-ascii?Q?RM4WEz92xdmfoUI+mVAaUnrqKe2rGYu7zFt3mdwuTEKmiSAxvBE1TvhPS+iO?=
 =?us-ascii?Q?uXAG1ydgjBw9AfeqLVKsC4Jt7Qk6nBn6uwNRlbEiUlIyVXXbi7s1mI84Cdt/?=
 =?us-ascii?Q?DdBisTqu1UBjOFhFDVhzK8w/TUxpQqF+/GCdsxFi4Wjb3JL7tPnAi5fnM1mF?=
 =?us-ascii?Q?Gnpk3XE/SGPtxiLmoKCijgvx6Zx6w8vlDlicnijsRAqjEH2NRdZUMzqyqB2L?=
 =?us-ascii?Q?pr3I0LTrDYxE13q8jtu1cOzfX616SW29JYvN0V18?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae86a1ed-8270-463e-48fb-08dac3fc224d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 15:48:10.3042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TkJIlGHZ74avgM5wODsHPi++MIRd4Da+fY0MucSlpAxEBqGIVGUSKaGmLwJuOBYJSGsISryOXP5ZJSnjNW5YlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6969
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add adc0 and adc1 node at imx8 common dma subsystem.
imx8dxl have only adc0. Change irq number for adc0.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 52 +++++++++++++++++++
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   |  4 ++
 2 files changed, 56 insertions(+)

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

