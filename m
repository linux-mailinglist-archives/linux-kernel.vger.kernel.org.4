Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD4F605BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiJTJ7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiJTJ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:59:29 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140040.outbound.protection.outlook.com [40.107.14.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EF91D0D74;
        Thu, 20 Oct 2022 02:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwXhgi1ZbneeKQpm9lOR2oK5i2NAM2/gVE5N9sJY+gBWQ1kdEarKe3RVoecdIUgcBnQ1hOWurqU/tLSKI1BskR9zMJnZpzlq5r/dIM2CZHKWvNqghuTv1kPknCjc34+jgnWdHRnbjmWd5C1Xro48VR4MMJRoZCBnT57whXyZn8b09RvWm9DzUZ5jaieVpoloaG4q/YBiM3IFv/7PG1n1SNaK4BTBdr0Fve8KhqClTPb8njElnQYZfjgf4ARgFPp4LGxQ8Gh7GUBdz4Np5oAoxq13OGoJKO35LS7LXoVAf+ws0eolhonApmvIk9ZSv4Rnv6scmojYm7ObE+RJUxM8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLyeayUuvhh1tMXNNZm98QcOsVKr73ywfPvFJJys2Q0=;
 b=HutHG22+mF48NQSHfnR4ktcT7tOmnZ67r9I99jENvRTGqGY4kXOh/jPZyyIuS88SWUg2CGcxwF1ruX1nUfuXdgkvxRmpj8+Xe17BLCtgdmJ8hTuXlB1+ngugOuBCcTMbUHHpnM405C7/Qi0ggh5TFF551Z6lrApAJIEU2RBVMNiZbCrKT4i8bsMJ6BUKkRfPgUP8Xj1YcTITgXrPzVWdFHckYtnQ6NUrMQ+OR82Zx39ycUOYPH+NdMNKOhJ0LPPqFpo7sa97QSTozVnoAXYItTzL9cxE6v8v2eC1kuJHl/XFnzgg23YwjHAbsmGKFS+R/E7tHsw0eyn2CJYMa9SJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLyeayUuvhh1tMXNNZm98QcOsVKr73ywfPvFJJys2Q0=;
 b=DSfRdz1wu7uBRUgHu1nY+zg+Qmz4v4hdorRufx0UBkz0+V05lkNROhA8NthP516sLE4WQH2W7Cw2iYWgaR9hIS/+jFE23EcFPklfAFVBwGlghpIqed8FcIVvtVHcna/LR/oxjxDGJJbPqRBJ1w5LYw9rr4z1N97yN7dK7Hdh6Ss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8358.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.28; Thu, 20 Oct
 2022 09:59:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 09:59:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sherry Sun <sherry.sun@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 13/15] arm64: dts: imx8mm-evk: Enable usdhc1 to support wifi
Date:   Thu, 20 Oct 2022 17:59:32 +0800
Message-Id: <20221020095934.1659449-14-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: b6e031bd-2795-4aa7-0b9b-08dab281b7f8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JPKG7zqi55qcB64xAeOl8SQMVc6EdicxY3H/rRQSDVKFAL3NMNEueEypJnpK+t++cAom+r0AVgs3qaR8Ap+T3zLLsxsdJJ0Mi7v07WMvgASIp1q5gtDHiZRHX8D+QQvBy3vLkYFqzzTMrN4sY21DhjWtFaDuYqnFMu3Y/zgh7Sdzt6WxnGgjRLxQNHH/DkkB4GcI4k1NWGfQeupzWlyY1nCeLNG9+4TSY1XmUY7IidSoILUEJ3QUaZNmqH03kN37E/XQ5fLWwdHMFWuHfYNMqEDif9clJ9Wi84ba7obPdfaXRA1E30zPQtzI+iuNEcNHtFhdDh2VA7+LV+QH37QZw4zok0QBQ9+TYhdjryIUct9v5TCeaZx9KbU5meJ8qBC5Ez271/cRmoxmbqmlF8Schu4HMSeJoL9/qEYJBsblZj+1yiUlm2gbAV9XVr2k4OClCc1/+b6jcYnm8Tm9SWRM6VeMIev9bFHHXiD0p7xSe0dKmDaq5MD9nV5Z9uZIHyIlgavau6HHMbZaQN0ETWJTvQyf1S45b8/C9O32g3cC6MyKq2W9BvDaHnA0d6fTD6CCGyoeBsbhAPYtBWLkVFWUMPEWRZiZk4vLiZQXmtjmT73B4zaFaNb3+vlCOYQob5jX5jH34cmJ9kBANNte4Nf3yppFLMAxQ9SIn0qwL5vtkDbNd4kJYqKBpeaco2x4BOQJy9YSswVJqNAvMGvYIMV7J/khYpscq+F54OeJdruqaQShv1BELEz1y40tSq61DXIf8UP1JjevmUocdkxKixBBdwdX8SIVoqXLDEwcpOCthBmS6XcsD4VrxbUoTC+ae6EB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199015)(478600001)(83380400001)(86362001)(6486002)(66556008)(66476007)(6666004)(6506007)(52116002)(8676002)(316002)(6512007)(41300700001)(26005)(4326008)(8936002)(54906003)(5660300002)(2616005)(66946007)(2906002)(1076003)(186003)(38350700002)(38100700002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tXo2e9hKX7IlgJMsk3lsaC2gXFvSKALIUpFcyf7LLjROFc6aCiPCQgn+wQnl?=
 =?us-ascii?Q?Q0atWi0EJQhdpujT3XDYP63Neqbjh2hPxPcW5q/JDuyzh9oYuTouGIYnR9wV?=
 =?us-ascii?Q?WtpGMAexHMtPatiAtEYs1WyJMO+rqgnBsTEIHiZGj//0V7VqGkirDv6XiooM?=
 =?us-ascii?Q?ki+z3+XsYt/ysRY36nEAedmVWG80VVrSIb7wCSQqA5IX+gSgcyghCA7lsnOu?=
 =?us-ascii?Q?bntBlVVI4tPX34ffrpWOQ72X+HUFztdx6RLz/Q0jY3ALLkgUKWrvMLO+cxbV?=
 =?us-ascii?Q?Y6hVCTyTYEVA0ZVx62ed6n9vC4crPEbzkwlhllivq4XJ6BA3+P4UH4EV4v38?=
 =?us-ascii?Q?LwmvO/cYnkNhecE0RoF4LL8HAWCuDHzsJgSmi6nxdlBP0trhwYPMhV9HYC40?=
 =?us-ascii?Q?v1K9O5hOuQJ+nKYjdO2WZBso2gvweJ7iAdNDCR2EDMhkg4MyV1CFuJpg7PMu?=
 =?us-ascii?Q?qBtand5qLQZBlJVX3vZnKWQJccf+ozIyvhhI4Y7/2nZjWk7+Eo+vDsqsiztk?=
 =?us-ascii?Q?e2X8/hHJ7yNPhmePWhHvTClyEl6h8St8YdROkW2ncpRcu5PKc+6HHZFmS7W3?=
 =?us-ascii?Q?QYsFWTzuVVD7xP0F6Ln/VHyJbJct1gvq5rnRUBRLjc9tsPh9tCJPet5CKRMQ?=
 =?us-ascii?Q?CXD3VWgC7zqf4K16mlALK6Ld1VXsO0OlfvkILIiOJrKRV9mu/MNGtxkALJsl?=
 =?us-ascii?Q?3vdC2nL5eb9YSOWBAcL63WgfxoGj7cJ6KtcVybDNh0+tdeXunilNoA0D/n1O?=
 =?us-ascii?Q?5Y10bYcuVX45z5BWWreV35GEyaLBBPyiNfo8ZycgRpZs/1RJe9q9D/61mknC?=
 =?us-ascii?Q?kxBRlChgr2g61cR3KJc7t+cv/W+pYN/1+67NTr4JfzjRyaKzHIzXj6lTj/oN?=
 =?us-ascii?Q?0bJVN1eQTj2PIpddLiggLjxmTOnm0K1rAiGKw9Vd/yVPXLCHxh9I6sL6O/fG?=
 =?us-ascii?Q?6U+PJNOz3+NjrbV/U0SJzqc0k9IEPIb7Zshl5th9PukwXaVFkr8ANCy7r1xz?=
 =?us-ascii?Q?2y2sYFOX5NPb5UNjNeiZrCzb4SQybrUO6PE/E/Dbhl4kLRI1zy5+9RqOJ5Mu?=
 =?us-ascii?Q?zL55WO6VOshTNgV4OkP63SWsNDotLCzsVFuiHdxemOu+i29OnD06pUvr4Y6y?=
 =?us-ascii?Q?1vDTnDI8UFp2ioWYGLLB9fw1/BfHS9TPx8WLGSiebCWKTCmw63vMbvbiOayk?=
 =?us-ascii?Q?dVB8jD53KmxS3d8dG9Z5biXFLOs390qfcpP/aHffJtG4k83JNNGmJ5oiiQME?=
 =?us-ascii?Q?EL1a2zisYWlhKKTH278HLpY3Bx8pjPyUxzq6eCj89XeDZ060c76d0VgKXP2B?=
 =?us-ascii?Q?ru5++hR21HztBpOp57heJTEofrSq00D4f1N7T5Gobgr8aGFQCpn3GdIdY3Vr?=
 =?us-ascii?Q?JwmfOgPn9+6UPk1mh5iILKumuAAPKgElQi9hl/FYjruA9M8+L4E7m+sccYom?=
 =?us-ascii?Q?+Nf+k7AoVe8T5nUkY7/pEHRnjDkX5N2T0wyYV2dcQiKxoM2HjyhP9YAD+W1F?=
 =?us-ascii?Q?4ZZIHpmClrwc2JGTBP91w4I0+WWUY1gEG6QncowPXtRirbYPXjGL/3SC5zEt?=
 =?us-ascii?Q?wW1GO3O5uccnEKJK6bazFrEW2MxIbmn/bIJrM1G+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e031bd-2795-4aa7-0b9b-08dab281b7f8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:59:03.6027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKuOD8xIh0hEKkA0C3Eccq40ITPCmgGUylPFKLDKSBaZsJcAvSxgfHde3VJq9bwFnOXkPBQpoGLhUGRO1FGz5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8358
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
index a2b24d4d4e3e..c93387fcd498 100644
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
+		off-on-delay = <20000>;
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

