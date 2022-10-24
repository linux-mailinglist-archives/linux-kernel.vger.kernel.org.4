Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55266609898
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiJXDPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiJXDO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:14:28 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782AC792F6;
        Sun, 23 Oct 2022 20:13:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLHzSy1EdQyroUfADAtrq8virusNIDc+uo3iyp9icHEB1moMv0RAm1o2vJ9lkncVANKO1j7LmrN6qOexOivlFWGGG+qR5qO2IRvNBrhKoxIJsmzyEiTYLqCVrHDQPGG3a2eXVl2Z/jkJ1PUdFJyFJFFtXYPzAtHllZqNx+aYCbZ1aZe4wVDGk+XYofUvLxQowUWOp69F5rsdiR8yJ8gfjBwQilotg7bytrq2ti6RQgjVqRtoYKVxi3Umm2Qi6qBKT/Ej/TzFsUAdzpAs5ynIknRqLmYf+uku3eMdg5xnNJA2WYItznebEIfJWChK+c0f1j6OHTBYQlIN3Y+2zhSvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4vYeBZR9tmPY+QMMDrxLe28Hz4g6Nb4Whf3zuqIOoQ=;
 b=Cqu2T9jhCBEIaiY78LuY3ui0A7TraQ58SkccApaIMSKRZuCvyNPBjVG/QbUDpjr4WLfrqOPlVU6P7d2JJrcZ3sfTuJRhFpgSMfhiMRkFm6TbbSBtR9O8WlVmbEK6ihZr4Y4b9dnIthr1GTcagjUTYglC1zFMoyA/rnoVd60RfD/MnR7Iyr0n4FMQPu/UQbTO75/1r9XYrWqNNw9z3uQd03JvQ9gtlwhX5GQfacWJuiDirK7OL6EjDf72OX3B7ygsV/OxaeHL1GMYag9+qlqM6b/v3SxmMCzPdCBexMElt2u1bWkMRUGNddeSpRIc40ylGqFnDAtMbVJogh7S9T1gLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4vYeBZR9tmPY+QMMDrxLe28Hz4g6Nb4Whf3zuqIOoQ=;
 b=Hb0AybKtONE76OOc2vBcXuCbmnXQWiHQ+82n/r5oh2YgKy+/Ani0Hk50a8tg1rtvaPZ5J1HPP0wE2yRK+lzAZ50bh4zd5E+5IywqzPUJA9Gl9m04ZE4CwAeM8OaimkdaZLWIG7VufFvtbhLYFtLP9HmGQHn4vPQl0zYRy/9Uo2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by DB8PR04MB6825.eurprd04.prod.outlook.com (2603:10a6:10:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Mon, 24 Oct
 2022 03:13:04 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 03:13:04 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 12/15] arm64: dts: imx8mn-evk: enable usdhc1
Date:   Mon, 24 Oct 2022 11:13:48 +0800
Message-Id: <20221024031351.4135651-13-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|DB8PR04MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: de5e7ae0-45bd-4957-0193-08dab56daa5e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNA0tILrTdrwRrSc+S0rCwXqFu3UGUdYAoy30IvkIkkNa0KgIjt62W72VaUqlfKPtUXoS9Mb/21xpDtF7uOwVKKdGUh9ujRvsczELSP8MpElxOB7oVxRENB381HBGXKaxxTChE83AghaW/1ixJTvpLe8yZaXMFSJpXaqAFvW+Y+/gGdbJ5IrBqoztxVv799qkNBNHyvjaiIht1/kV6ygNuwdXM3dB+xR5Vsxn3GwFixKnrLwUa/wnVVuvcuVNhxMeH1xNjYG8HsUsS3ayFt8AcsaADPZaf1fm5kImT972YA13Q7vjCJgjSwr0MXm+qnDIkkJw/o8N2/NyewQFTiLIurL3Jf5BNoEE9py05DVOuWXN1DtebfTrJZMRg30+cJzvScz8FDz+3IZCALdqIrOwIEB40wK/DMUSGqIeKE2amoCfb5BS8hW+kutZn4NudKaAek+l2COFwE4aUDvyN12Cp2X9i3zJatfbXxbG1PA46yaRVpSbd6FfwnIlHb7FoWE/7NyI5xZyyOLigRtjDXcktDD3M5e9AJydTIS5ouy4qEQ0b82qUHRz7K1DTO65mjo0fffsMGGZb6mPpkBws/fVHHpdJN2MMEuOWmQwt1V5tk1ci3l7dJagFb3gnkrCgCaChYYAOhZasgC+CNJx/CCF3CEUT5IWhIHzAMiTNaFIQ7B0jxmqc4N2YKz3m9XVyP96AvEqyKisWjaydbu5ZW2jZqLPt/jf/AAZEsrUzyYueem7xj+Fi5RT1nLlocEWM9fggz9/32KkygJSZThq9x5ftCXCNA+rzwzmUVAfE/7IVJ16GvkmWmTCOuM+zBZ7CKO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(186003)(38350700002)(38100700002)(83380400001)(8936002)(4326008)(2906002)(66556008)(66476007)(8676002)(66946007)(5660300002)(41300700001)(86362001)(316002)(2616005)(6506007)(52116002)(26005)(6512007)(6666004)(478600001)(1076003)(6486002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lOWNO5t2OYMp+lx9M2XIFbE099N6e/VURCnHTSQs0b+kRETyeycBv8OU6/2R?=
 =?us-ascii?Q?+DWiLn7I8eahfDyjiHLuI4jaTvprKw6+mTI+EkpPY+ntsGvLYaXXNo+hpggs?=
 =?us-ascii?Q?8jk520WGg18vWW9ELGTfhQSbg6h/Ai4Ydr5R+b+jAbWtkyjm379tpnQth4Vo?=
 =?us-ascii?Q?ob7LutsFGD1jPJ+DR/LZ24uSB/I/nlSMZM60cWt09JTAIDyKTGtnIwLf6A3p?=
 =?us-ascii?Q?umnbr3hS8vfBiBH0YpjrKROAoJSM8SNxhZe536SypS2lGnKwmkSreRQrVZhK?=
 =?us-ascii?Q?M08XxYWEGyVX9LSCXOC6pZht05z5K03NRPM31ERjB0n053DCafsdlRS+fI7L?=
 =?us-ascii?Q?dgUQymkipVfO5YmVxBTonZqERZNk7vWAnMTHlvUJ2gpr60AZ7kYlvW+MsX5F?=
 =?us-ascii?Q?xTn3G37ck8MVYWdYxVyk3czGPt7vBCslD0gVI4M1jFtODgviQSBCURLeWbtG?=
 =?us-ascii?Q?C2x7k8g8kWZgF+7z16KOr0wh+sOuMzUrc/B3BCzu4azjTrlt9JunyElbB2NF?=
 =?us-ascii?Q?I6jLCs+Z8iH5JJMUeWhlPctZRgG/AGKNzZWg2C9zQxJYRRbnulGIEpuxsg6u?=
 =?us-ascii?Q?mGmTWYCd9cPzWtcZ/py+q0CQ/GpozlhD1XZVb+J8Ys+Yo0qJW7ip3GQbBOHE?=
 =?us-ascii?Q?jLs8lzONaJlpi2GsxL/rti3L4bfii6KIfg/dIWkVhhlfmkgiP9ZSdMxN0Dpy?=
 =?us-ascii?Q?PLv4AFKo5dIJfnM6WtACgWFUIPPkFqJe3sfxP+YDOz7DLt6A1LvvEqGlSU0e?=
 =?us-ascii?Q?YCTcHbHThQTzhCrRvyNNodcKFHZz4/hgc4TiGiIP63qG7yZTpWp8bqN0sMbQ?=
 =?us-ascii?Q?bz8RcXW+3mzA4y4Xw/on8ivTFF3rncJz9W65jUO13X1YfVH3skxUE1Fp2Llp?=
 =?us-ascii?Q?KQqLoazu1xInBmO+Qd79kAh/R33+3x4V+zNH7NT2g1+16+Wc3NKNcX+LWLfN?=
 =?us-ascii?Q?cmzIz1v81Qr26vW2drz1zugFd4wPE/bwKI2nmXIKIC2y7ibTSmKGj5mv/Psl?=
 =?us-ascii?Q?iIuI1P6wZGXND+2HpwlTNYy1PJ8yD0wZzyoLTU9PN/XbFyLgw5RHrMbrhMiN?=
 =?us-ascii?Q?+9BKSaNARnP3pP2VCOzRQaIHsNGBNaiTtQrfsIO3QlnCSr2In+ZbCVHv8SkK?=
 =?us-ascii?Q?8Vbpg5f8pk5PiZfgUbQZ1kmrXMw45GVvja9inRbrIbU3WMJqJi5MHoA5iCaK?=
 =?us-ascii?Q?2gNbKJvsBfiZ/d52zhuc1XxV1OYbG3D2wRauPPN24K9Yfvb5JLQLuWxsLuCG?=
 =?us-ascii?Q?UNaj4N2wduXNVjSQTcWQlHmRLAhs+/DkLF/RVi08N2oteOobxQU9JR92YKIP?=
 =?us-ascii?Q?UGaSA4MMGmesenNg0fb+NbmJVOqrWL7ae6mBlGVP9G5OnuIJuRtLJfhJ4gGl?=
 =?us-ascii?Q?ZrEz865/1ZzH8+keMgtNl3b8LC0kfYtQQQzIE9cYcblkbfYg3DrIH5FiB1sl?=
 =?us-ascii?Q?Z+AXGb8WvVMUUi/7mc6jDBHH/DOtj0A0Ph+QDJAjc6IOPJDZ/mZ6tUoBGNGe?=
 =?us-ascii?Q?AH8kLh3gMxkybekw2a1l5nhBuN4AK88bPUpii7j8X4cfHbNlHp9cGkQY+A93?=
 =?us-ascii?Q?YZOX3WVGiF4sCTnMO7Qwb/SC6UXPoIKFSe51HJUG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5e7ae0-45bd-4957-0193-08dab56daa5e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 03:13:04.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUQg85oqY6pkBFs24eynJVgGvEbi8D1FWAec+98Wvl1ZDNPXocorVTySrHGC+9P6MDYQSyY3GYL32TsmF1YoIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6825
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable usdhc1 for wlan usage, the wifi device node not included.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index f137eb406c24..50553359401f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -28,6 +28,13 @@ memory@40000000 {
 		reg = <0x0 0x40000000 0 0x80000000>;
 	};
 
+	usdhc1_pwrseq: usdhc1_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc1_gpio>;
+		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -271,6 +278,22 @@ &uart3 {
 	status = "okay";
 };
 
+&usdhc1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_wlan>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_wlan>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_wlan>;
+	bus-width = <4>;
+	keep-power-in-suspend;
+	non-removable;
+	wakeup-source;
+	fsl,sdio-async-interrupt-enabled;
+	mmc-pwrseq = <&usdhc1_pwrseq>;
+	status = "okay";
+};
+
 &usbotg1 {
 	dr_mode = "otg";
 	hnp-disable;
@@ -474,6 +497,45 @@ MX8MN_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B	0x140
 		>;
 	};
 
+	pinctrl_usdhc1_gpio: usdhc1grpgpio {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_RESET_B_GPIO2_IO10	0x41
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
+			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
+			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
+			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
+			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
+			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
+			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
+			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d4
+			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d4
+			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d4
+			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
+			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
+			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d6
+			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d6
+			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d6
+			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d6
+		>;
+	};
+
 	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x1c4
@@ -569,4 +631,11 @@ pinctrl_wdog: wdoggrp {
 			MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0x166
 		>;
 	};
+
+	pinctrl_wlan: wlangrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x141
+			MX8MN_IOMUXC_SD1_DATA7_GPIO2_IO9		0x159
+		>;
+	};
 };
-- 
2.37.1

