Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EAE605BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJTKA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiJTKAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:00:00 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D052BB16;
        Thu, 20 Oct 2022 02:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdsmZhak3ZI1wcN6QOb/RmCOHK05z1dwpIBPjxcOaQPuC9qDvtybLP8eEpk7184Dyp0hvHuojK7MGTCAwPQnltrR9mLOT3BeDLfosxmRlSqFWwOCIRS6/MWPlm4Uv8qVjyJ+bDo9Y4rFwvS+iv6/0OC8oayECkoWQmZ8wlCRVkEOdK3iH+A/IpwzzQT4xNO2Z+4BGI7JEhiqc2poK4qbQL3RwTv4Rh6dy8C8A+P3hcdIUsozXmeh274UhXqPFjwHt8T74z4yEPlRjzgzlcfySdR6aiL0EovNKjgUa7NgjYYqgFwhdTUlLhjuY+Gu054aWbbOpjS64sN1WV4sKwKfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4vYeBZR9tmPY+QMMDrxLe28Hz4g6Nb4Whf3zuqIOoQ=;
 b=HnWBplGlJ5HAx12+jPCrT15o3GVkPA9It3f2xaPYZZeTjfoHomsLlUpOsNGsrrR/NL5Rm2n0VjzkNbN8xjXXxREx6F0YnlcG+UMFjcy0O76BYiWFqfUur3Ary0Msxu9D+exPrdO7E2FUD7FKE9s/UIiBZHmpS6EvgIIkB2nI+RgvpmLWCAGunkQFmJPUF2+8Xj4nuU1pWQB2d5PtVSFBTIClu9POLPQhE8q27L6nUrHi4xbRBpyrL/T39S+DgsK67Raw0e23sSYuUV7nk0CZXvcRjFA4aIsgymL8ZNcbY868gucyEncDxqKcZ3ZgkL6PnfR11TqRSvej8JOpyamypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4vYeBZR9tmPY+QMMDrxLe28Hz4g6Nb4Whf3zuqIOoQ=;
 b=FtZceBfrj3UTbNYIVqZbto41VLxxFOEoApZ3a+L+RAACC4ibOWYfkJ9yls5XT9Jv+jaWTbEdFqwA7yeZ/rjhDngWOdf2oVAPs1/zXk6NsiV9HmLv7dwBMOApH3yBnIEnwL7/7/+Y/7hw1FrXjBBb7IOV4fUsuWM9oChdrf2TOmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8039.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 09:58:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 09:58:59 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 12/15] arm64: dts: imx8mn-evk: enable usdhc1
Date:   Thu, 20 Oct 2022 17:59:31 +0800
Message-Id: <20221020095934.1659449-13-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c795c1d-2640-462a-502d-08dab281b5b9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SNTlShv5/I6d3x6taGLURfSbBmTdPr402CISGRfN4cNXXm7vBlAfuN007GtsOXiu7XlVvkeMoj/f113qiaPCUgkqeVXHb9DzC6A37APTyaJb4fxehFEtWKURIFKMekQ48O+DUgnRthquwOGXFKt4qLUyavrzlXCA8cgcA9t6dvY9bUD3jsVyDxIL7+fAkGZ+lBkpZLg1vMiWYIesndLIWoeg1ia57dIYIcRI0a0+dDIpx6s1z72VRNdlMPk9qLnNbbwsnUWmIVsbqdUnj9kxdahGTK7KrUY+FZWrNh3XGECicQYjVNL35u1CbkUY12ijVyBqee9jHQLeqMG8ukPxE4lqoEGXENXtRJGshTrlVvi4AGnULbgmyNznAkU6RjVXXvX/36S4iOidzrFdPDRqAcLSNrS+OxNFAWrNT1V3DHkmQ57t0EpQXiz1a2ax0ijB5kqmFqUpGWtMAZCKwWDC/j2GJYI8BdtIFqiatU6guiL7bc0a8dV3W2LdPfakOld3695Pj2jIZP1U3kk2CJuGvQ+Y2L8e+Ymwp6kDn7l+s0hRoiyD5CJvS7czXHnFDuIOZB1Vsg3vKr5KVazgQINw0i3dGMxqZFK4+Vti/vtY94YxYuUyooimT3xwcIuURqJEG+94koPV4uM/alDoFaI2OrNZfu9FOGnmpFjY1uRmUyi0OX4vGQ0UQ+wAmHpRoIYcKHA2XDHp1h3Pj8T0gDnBLfjb53qRRQR2aDyVvoMdL8tCPPogBMG+0JObE9nhJYz42S4AkLRYM0sC5Fq8Ta5jk2W+LrmytC+YPrhT8l8B/86Bk1akBA384rIK136c/4MX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(6486002)(83380400001)(478600001)(86362001)(66946007)(66556008)(6666004)(26005)(41300700001)(6512007)(4326008)(8676002)(8936002)(66476007)(38100700002)(2616005)(2906002)(38350700002)(1076003)(186003)(5660300002)(6506007)(52116002)(316002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2+OeazEkKEf5CVT0EiFoIepLyBylz0/w3DCsr0EcNvQHxnHHBsmhUjOJ9DsF?=
 =?us-ascii?Q?7+ggQLAILa0IKCostf5Ti1nJJSA3xJ2fBOByAWpV18ac61ilHn7WSi3Iu23p?=
 =?us-ascii?Q?KaoTkdddkFkCMzTPdCJWabAlcTyL5C12p4lwhwu3BC+bvM/vJoGaAj/OWx2x?=
 =?us-ascii?Q?iPQcNfAqeRZu/DYCY3jaQahwMJNEPWfsVNsmCfyM9w39y+TzpC+grPcm3bGC?=
 =?us-ascii?Q?unavOxdpCUGeqDT4DMUz5TKRpLNhYdsdHQx3FVstdMlHqVtYQgi485r31Ku6?=
 =?us-ascii?Q?B1ZBAp0RGqwYw7K26iwwloVs+rNSAxQYNkFym0wSbRXuGP9VCnoGtuY9OzBf?=
 =?us-ascii?Q?xXgTjo00kQjxfnaUrjRroCKLKZ/JNvlrD9+S6q5n8M/fBbBRAemdbNSD66rr?=
 =?us-ascii?Q?C07xUWCppvjAIlKPB2iCdFby1lyEJ1AdXf830Zx+3Qrzm+N5lAv7vNrOhIqc?=
 =?us-ascii?Q?Pmii0zDypFa+UAzL4+2a/GZwkfbF3Z5bD2zGsq7AhYKTyfTGo/VycOJ+hwK1?=
 =?us-ascii?Q?xyv2uZYx3g+xbgHygOuslF/LSOlWl0NUedwOobjlVIEuY5Bo/Dg6uP+UF013?=
 =?us-ascii?Q?MoxbIGM4L6HCdGxObQaqm2wfLMVkz+LuG4NUf39idhWCyHwBMJJbVMYQSFyb?=
 =?us-ascii?Q?vZ+xtj6fD30G4Fs53BzPrMqFrIhQMl6Rj55TtvKVGSjzew5NqijhRWU6Q21l?=
 =?us-ascii?Q?Xu4UUPGCJpIz5OfpdN7o8m02EbVdBOUKf1NbNt4810uKl5IM8OlK3iqvnzOf?=
 =?us-ascii?Q?NuLcDpgeRvi4YOBD1Ln7Tj3Gm62sjreld8pV9RAk3Xy5ZoRlI6/SKPq5iXbE?=
 =?us-ascii?Q?oDmbViwwz2/rMJjR8GNPakbzqJOS7vMFcK6FWinsE25hWXk4CQ3iEdnQjAFp?=
 =?us-ascii?Q?qtt7i/dbK+FxLgUdD/wdnvKZ/onZyySPM9I8YNBYrOhszvY+GdxgVn8UhGTL?=
 =?us-ascii?Q?e1F7gidcyMEylq0zTktRWZUosTgJ2qXM0SNxMLu0rUbVoVqwveAJKbbIaEoZ?=
 =?us-ascii?Q?2smH3bQSST9TxN2270EKmDF7aQS9joBS/cqVtpAc488Iig8rvt8EiiLElbxq?=
 =?us-ascii?Q?VoV6tp6vFi7l/SOmluxDzfbt7KweBMZruQcdrSAtDpZbHFo+bDOBNMhjZaIz?=
 =?us-ascii?Q?6FwgwKXxRV1Aapcu4lp4N3P2CdNvxzl/bTPuEJQ4+I+8+HMUffwAricsTTLj?=
 =?us-ascii?Q?liW6PCLtCgnHl/rFi4Bo6VNE/6tvYj/32t0Qe3q0Zvn2MPAvx+SMBvwat/fk?=
 =?us-ascii?Q?TiguV/6/8jATpsMujDyKPSPBpX/jxYcq3KPIzd5Bw820bE66fpgTiHX7nXJM?=
 =?us-ascii?Q?gyXfLqlbp9y466WflIki5Lt6jaJmW7pIPCjB0Cj6t+osGQO1bAHm4zWXTVMO?=
 =?us-ascii?Q?qSmsXJN3fZavxdJyCvKWwtSPZgNIpzDO/VQrEYyzd4akqzojzFhrmb4P0TBL?=
 =?us-ascii?Q?wqRGM70AOzIbTi0tRV/RhBSuboPa7W3p+fIH7f+YDlLf2UIK4Z4QJ1ot3NXS?=
 =?us-ascii?Q?PbChM/znnae3lPL8CVM30OEj7tjXFP9pO8n6fpC/WfmYiZwGOcxQkJyg+9+Y?=
 =?us-ascii?Q?5yZ6Gl1AqXQPnZl/OJRiSNxVuIINx2AzpYGnYXm2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c795c1d-2640-462a-502d-08dab281b5b9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:58:59.7411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lzL8RUTGiOPa9Wj++B4ERkQjgRsq1AX/HAI8E5fO158+TSHCB7i0jWKVE4tDj+XJeld5ysAkPtwgXxutaj5oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8039
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

