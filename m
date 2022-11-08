Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C7662069D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiKHCSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbiKHCSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:18:05 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338492D1FB;
        Mon,  7 Nov 2022 18:18:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIFmhXcVBOs6C5l/bWN2jtHcgR1otZBvIncQRjGHy1AlVwyMSdvSwtHcAH2Wz1gX3iR5lLSQ2ic5nvKNraInsNc1Jzs8tashv1gWKgvij/fVCOWM20o7qMRt0wCKQkl9ldVpEBq4LrnTEHqJ5kfH8Zgk+/UU8IALrT+2pdDlqu2gJEax+RiNY7ZulCS3yYbG7Ahx3Fqu75Xj5VMZo0djW4kmaoR9C/O358g1GoIBQKolP593VAKNKlFPrmF1Yk/HRpUD23Z3kh6PU70N2AHboBRvuYq5MwgjZNRhif66mvrg4zwZFqd3ECarQBjpGjQrexQI5tTWXPiFlV8V4B5LpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lZ9irHlCKyzQ3rU8OfhvKlzEkOmyv496+vkqurqXQY=;
 b=f4mXSHdq44+ElTVkmLFAL9P25O71KM9ru4apj0xHxgOKrPCxIBhD6Xyxh+JijPPX2SIdaaBRHf9iWNRrzjnRauX1wWfZgdtUcVGQ0MuNatjrPTyb2Dlp2DJwGftPyunveAL0nRvm9q6yF53rsYMF6FaUmirZXcnwCrpJN8Zg4aYUeHmUU4LZhok3xGo5G7XfYRo+21UJPpsqG4bBcwUKCqSXesyTOucZ+T9v5r2/PzDwhpNAgfPDLw0hD4hcgsI37YqjLCv6bHsCRVwNY2mOX1IHLv5UcltKT/htbEdRIqEixUVtLkLfsE90Ag3NqVwBZL8WvFYHke1adJaf/KOIRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lZ9irHlCKyzQ3rU8OfhvKlzEkOmyv496+vkqurqXQY=;
 b=O2dEEpXFEBkk6S1h6lw3MQfZGauOLE0LyLYR6nF9gjevd8AROyH1oClzdh4Baj2wfQRc0JDlan6nWCsXYvevkTDhxCE7b4WKsr9VvZ5AyP/UoOd7BXMVKP2XDjb0T1iQuOr9vFGk98xT+5TQiRgmxmOIt+yabTyQLdyTluvXfx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 02:18:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:18:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sherry Sun <sherry.sun@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 12/14] arm64: dts: imx8mm-evk: Enable usdhc1 to support wifi
Date:   Tue,  8 Nov 2022 10:18:18 +0800
Message-Id: <20221108021820.1854971-13-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
References: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b743fe5-23e0-4bf0-62fa-08dac12f764d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0g3PPe07RZB+hh3Iv3LnfZPAr078qKu4+Z0DcdzB818X8PTX4qiU153D1d2LuRfwOo3X3luVLiZvC0k5g7sLNCAwX+4swZU/fK25VjOXKHC0tDgXgiSSa7HqTUZePP90KH3oPALImJOWzXyjSgfRweZgceAPXrZgIhdpESg7rpYqJsTiJ+71LGUQGl45mzOuGYGin4mBW/AZ+oMGqLjrClguOmLoqCu6L08u/n8nbtWIXhLlob4K1WNhtyJp+EH6iGKtmxXMqqF7QdIaJpmMfp3faF0VVfBziWxncH+jPn7LRd6t4KJENPaL/yz495WViiqg/bvFHEkWw5YVR2YdxSpwPYyLZ1arunV93eFsp6sj/nxLCfP3WCXTBrP8yI3gXX6bQDLbZdjecgrrH56YaVaBVWDe831avS0DwbgVtf5ecw9iLgCpu8y4GzBh7iQoorMOmNg2bnZOGfBSG/qdu6Jtl9wjGHAy8lujExg1Kf4FNAl9Y6avG+KX7FDIo7uMY5oEWuDHlZxs/us6FqciTvTEWdDn1CN0kaU6Jf/tkRygppwCMjIUhrrCZ5qP7d2ETUNYf1DZFhSCewyzFRTNCK2zdmgVYK1iG46ykz1G1yXyqeLKt5k80kVH1myazIyOETn6Ds6EglpiwLjye9AFG5iNhdju41ZMV5TUuNFuluITJoNZYz4+74eeuDk2ltbYDNivcyucRXUc2KTwsQA4Bir9N+t8uEbUlODaalCIJRFPyfQZHRwJnWhvGEZL1+NNnEN5Qt+PV4qCfv4byqz6sH4J7XPOFoRzxf8lLRNhpR3hnYtbstsxK3Py52enpZn8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(6506007)(38100700002)(478600001)(66556008)(4326008)(66946007)(8676002)(316002)(41300700001)(54906003)(8936002)(1076003)(5660300002)(6486002)(2906002)(86362001)(6512007)(83380400001)(2616005)(52116002)(38350700002)(66476007)(6666004)(26005)(186003)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YO2IdrY4xyuGpSb31Ciut32KGufEWf86aNdpJgJ4aaTsSMxpuFZm28RFzAtF?=
 =?us-ascii?Q?lnVaZaguqsiClGnU2VyDIhlFWs/b1S1GDsgxejpbEhO9ue2WH4tg8zM7JX+q?=
 =?us-ascii?Q?6cIDoW1remhdyFlEMSzeqHMO8spYXmDulvUkRauC3WLX8/dodP2feZObetd4?=
 =?us-ascii?Q?7QFLQU/kw8pK0tE0+fv0JGz9YXg/pipWCRRDqlbjNhr1HW/Ch2CF6eR6lb09?=
 =?us-ascii?Q?22Q47Z8Md4XQ/oT1AaS8WMors4ekvPRro5fbvHSdKhYulHQoZSw+tlMQ0P9B?=
 =?us-ascii?Q?UtLI7t7HoNqk17xfQQYOujnxgEQoK3TTBy8SWqV1bAOtbk7oxu4veYUHcdCU?=
 =?us-ascii?Q?Lvl4nrAJVxToBbGPyV2wQjEGezFE1t2tsgRHhb+x7rYpdWfdbhkhjoMVb50u?=
 =?us-ascii?Q?vRY+N9t3i0wQtOfFLYowlShsjM9GTO09RzwBJ+b43C14LWdeQ1lngo0JOTIG?=
 =?us-ascii?Q?56K/GVv9l/5UTyDWCLTb2E348KqBFlJkOkt/dkTzbuawrLVEDjaiytupfYy3?=
 =?us-ascii?Q?3m5eTBqByLxwkP5+gSpb/w1wlxA+sX1s+KPqGj774CoUB+MCsbLEXC8+qsar?=
 =?us-ascii?Q?bp7oyZccpAeurth7gJG28Jitq/N1wPPMNhf/ovWE8hLYu0sM/pNTRaSRBUBA?=
 =?us-ascii?Q?y0DKtNXbRxzXQ646s4qbHYg9Ee3veeqVMNc/rX4UsxlEoaqfNxawVdSVeXep?=
 =?us-ascii?Q?jfPchD9UDz0BRCd9dELPM5dGy7Tk2nqu8fur4Dqm9tckbrwTHNldkQr1p7S6?=
 =?us-ascii?Q?TEE1ScHuBi5BYPuEuBVPHrmS4Omws8Lk8npA82sbEvQQQBJnMZkzS9LjNrPF?=
 =?us-ascii?Q?MS79zcJOkXEd20UmEb7oxQ1g8bg2xWbJeInKTmyF8QCqjtFe/I0J9FUAeBN9?=
 =?us-ascii?Q?fjVc/jxG3RVt+hLLuiT9s9FoazmSq85ZYNT4S/vz+0Vsoy0qsQP975718+ks?=
 =?us-ascii?Q?jAgV+90L7X9kWQzdp1vpvbI2KY61KodAfZ/iWY8/+eMhdlrTrOao8N2qE76n?=
 =?us-ascii?Q?1ipCbf9/XRisqLcZPN49OXlGX4cNBfT+WCTebTvrenb4spx6hmS/SB7xhVdW?=
 =?us-ascii?Q?O3Oj23WVRZds5p8e3U1qWqb6VJiOupTv6xNGAlLjkyv8XQ6Wxc/WiUPw1BGO?=
 =?us-ascii?Q?rzs7SUF4EtWzRw28iLJlCCzcixsXGy1LcHnokxpyZAbHWONbAnFPl84PT+7N?=
 =?us-ascii?Q?99vf1o2nBrS6fS3Hrb1jgQo0UNXJTT6tmZ0VKwKQnWWapafyUrBCWVRbc5pC?=
 =?us-ascii?Q?6BkeM3ytr7UJOb65tzZonNbgpdhovFpTX5uPSkybWX1O8u+UYBlZjkz4JC19?=
 =?us-ascii?Q?yi4KovFjy4JA3+oEoHKBR5Y1cB4t3+LmbyYJQur+t24WCRHGJ1bViduYsr0J?=
 =?us-ascii?Q?YiIDRuf3ou8xK4u9ZyUndL1imxP1Y5T4zdTLuHgvMhGAzPf0McZOOprDstgg?=
 =?us-ascii?Q?lH8RZjtY0lzN8aQcjqtmUCUGgDVEt0452pWtfsJKIGSeBs67qcgwaeq5aXwO?=
 =?us-ascii?Q?PkvvzZG2cJsdeot0k9dr4t8rQsLBYsgiLyF1wKRLumHoBAZeiVF75lDzCpVL?=
 =?us-ascii?Q?uO+cFDb1wYzTZ71ga4fGkxaKUPSaXkkOdBlRWYDN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b743fe5-23e0-4bf0-62fa-08dac12f764d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:18:02.2190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gnxtn8zVQCgAKMSwUUdUH66si4JfQ+CfERTAD1DZPspqxAKjsYT1Xl4TikjEcsAQscCFeEGVMLM8FL1TcRlUUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sherry Sun <sherry.sun@nxp.com>

Enable usdhc1 which is used for wifi.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 23 +++++++++++
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 39 +++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index a2b24d4d4e3e..898735965ac9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -15,6 +15,17 @@ / {
 	aliases {
 		spi0 = &flexspi;
 	};
+
+	reg_sd1_vmmc: sd1_regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "WLAN_EN";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 10 GPIO_ACTIVE_HIGH>;
+		off-on-delay-us = <20000>;
+		startup-delay-us = <100>;
+		enable-active-high;
+	};
 };
 
 &ddrc {
@@ -53,6 +64,18 @@ flash@0 {
 	};
 };
 
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_usdhc1_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;
+	bus-width = <4>;
+	vmmc-supply = <&reg_sd1_vmmc>;
+	keep-power-in-suspend;
+	non-removable;
+	status = "okay";
+};
+
 &usdhc3 {
 	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
 	assigned-clock-rates = <400000000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 7d6317d95b13..ce450965e837 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -559,6 +559,45 @@ MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
 		>;
 	};
 
+	pinctrl_usdhc1_gpio: usdhc1grpgpio {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_RESET_B_GPIO2_IO10	0x41
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d4
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d4
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d4
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d6
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d6
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d6
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d6
+		>;
+	};
+
 	pinctrl_usdhc2_gpio: usdhc2grpgpiogrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x1c4
-- 
2.37.1

