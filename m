Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F28660989A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiJXDQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJXDO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:14:56 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB0076569;
        Sun, 23 Oct 2022 20:13:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEqfcXpGUcUhKQzB6nQYXBSYW6BD7bQkracm+CRlU7QuWukCLGvOrA3CabajjAaLDQ96psSnPUkdXICj4QLAx0maFK5NitIxvCz0aD9lWdxCNObqBe6atoMZbebo804wLER+q7KliGOW/NxobXKHIbGY4ZXmU+txJFjRQrt8t6fsX7tCnTECwsqI8E0zYsC20L7QGaeJ/I1dx3wg6lijDUoYyHthOEqvkf2kyZRsBblHhjknl8oMi1yZm7bl/4aln7KmYKREWVgtFu+VnF/V7fabhXOzRFzw+g+fcSreXEkP8mimqnCYVkIGkZDQp4pfjTPFX2BGeuVp4Aeke/MNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLyeayUuvhh1tMXNNZm98QcOsVKr73ywfPvFJJys2Q0=;
 b=WNC7VtsYgUtS6s5sRJmIWD9n85dMLdcFXReu77pdlBGtmoVkwTxPax9ttG0Sl0HjtVCXzpDqCTjlGHO/clH/h1X4VoEREGcP7b4Aj63JEm+QSFj/YrPyxq1kOQWoQjvY/U+QtV5upcVYgOff4Wa7LA2Qj3+iqL6au/vHA2TiQNQCjt8vtE90aG1wNPEwYwF6WcPbItJI5gV/KuzxBapAiJZOqpDEO59IbbKM0SsOf+tt2V3Xn7Cg5XjK1Ymi19ywrCkDMSMX6+feNdlsqY9a/dsgCVnxsfwkpSJH7KWNZJojLbbq7gft/9FXs5EGPkGRlmO2uBleSWlRF+ih4pVfFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLyeayUuvhh1tMXNNZm98QcOsVKr73ywfPvFJJys2Q0=;
 b=jKE11/p1oWfg7Azv72+YlV3y+C9dc9sQjEIMXX/WkElSosOWQRuOamyCQHP2VLuYvbP8qc316u4E4tWMFG5a/NE/xc22NtPmObrsGNrJRxC4v57LgoNULHR2GnvZKB8T/RF4G1Rq+V5rYTFAHlwzmNs2qZvZMnZvgr0NnPDWfGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by DB8PR04MB6825.eurprd04.prod.outlook.com (2603:10a6:10:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Mon, 24 Oct
 2022 03:13:08 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 03:13:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sherry Sun <sherry.sun@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 13/15] arm64: dts: imx8mm-evk: Enable usdhc1 to support wifi
Date:   Mon, 24 Oct 2022 11:13:49 +0800
Message-Id: <20221024031351.4135651-14-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3feab0a2-167c-4c26-e091-08dab56dac84
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNWnmUy0LAoA18tiZlaKFIhyqXI16Eh962dOoZIhDHo0t92DoM+OvZpIpfRmqpmJBRZFd0ly8awfoNT7wInIancF7i4cr9joMc+iNEKpqHHfY189RpYcihltRGGMO64Z366xeCa2FA+oUEOGDaNlTsDadN7jq+iuk8Mi/owsnjfcasZCpdIkL6i/3wGQuoo6nbNVKa2R8xDFo1NrMCIrs0RNSEUynuky5ooygboae7EapcZZMdiM9rJ5SmMhGr3JvwTBBb1U4tyzet7o7Cinh+3jfdwSVZb++hCWSVcoi0nRgfDQObT+ss6GqEGsZPiUD4OeU8Hcp/Y0bqs/MiCGnSTa48EvO1QbTFv4ip8NBK/56Le80ityxZ4YFrhE9eV4qHjtS4X/sD4OMgfjX6gKh6omD/HIrlf8/dBTaG3yq+XyuZqPNSw5Uy3fiTZnDbewX7KsrNLormIua/Sbh2CvIg69LYJvC1fwB/ek+D5y2yk7x9CC+TViPCmo33RIis/rMGqJCmhbdJUxVaYmW/WE4P36RVhkJLmBhtDfPpWvtsyFU0WWNu+IvoDe5mhHk1nFqsUT3NerLUto8XjqM2/G5nthfHBi7ZRJbR4MAyieyajXqe5duoNHybcZxhNJsI4ieB4zO1WQFGLZpnNP8S6a74CDf4fBAsqdphvtAf2LWth25Vbyh+Gl/hdD09dg1qFW/Q5Dj3/148I/1Iu0okykC4/dMeDbdmz+/TYElOm+EbYNLZMg6QfnQ5Xse1w0Ob21sjG00r8YS6+hQ/PC+RqC31kg2qxYPNNOm2ejHXZX9iGx7akjcdnx7EEz9t7C1s7Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(186003)(38350700002)(38100700002)(83380400001)(8936002)(4326008)(2906002)(66556008)(66476007)(8676002)(66946007)(5660300002)(54906003)(41300700001)(86362001)(316002)(2616005)(6506007)(52116002)(26005)(6512007)(6666004)(478600001)(1076003)(6486002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F+IHRqzFt486QUPQNA2kzwHW5riNtvyQlcarOSw7GIqlaYQdeEse6HBaL6g5?=
 =?us-ascii?Q?j33IaPsHN3WALvECHOArmfWFLKX/683agzxHSOR3EKYlgJ4kXisQ8c566MYb?=
 =?us-ascii?Q?lq6etLwwPAIVoXcxkNrj5eWqTmWbBQLmPCFUfdJuhSfBkL7mJLbkGbH/tqIq?=
 =?us-ascii?Q?v3Ay+PNHhVu/7+ZjuxwUYcK3zvwQbuEhHVnpkYGoQz49OyODSkBzsPS9GURk?=
 =?us-ascii?Q?11LZRRrZyaAAb2gIvkkm99GNiZz6vYQEuonPJmeJnVAKePuv/ThBebMjxfyR?=
 =?us-ascii?Q?/TEdCfzE8+C3n/K1Afb4b6iHvYqMWXSt5Lea5kta0leRKcdVDpOTccbuwUK3?=
 =?us-ascii?Q?ACSHkGWpoLNnjrXdRfXZSAI8xhIauBfU7tXnkgl6a6ia/24xHmCBby4P1WU2?=
 =?us-ascii?Q?2uYkfVJLCwHsder8xcCsfWoYN2jrxX2jfJ8cYESTk1nbOzLs2rw3rbj0LLNX?=
 =?us-ascii?Q?l0r3TWI1xiXj61zP22IlpLcITxaO3mrP+p6i/HOOrGdw4nq69P6snA1FBWyc?=
 =?us-ascii?Q?B0gUvsdvBdiyEIjZfUKss066F5tzw8QmFXFvKOAiG11BDa6pWSYY6JZLSMze?=
 =?us-ascii?Q?CbdzylVtBRsJ7UMUXE6rgflWiynK6yXqR0/XLzQoYQ0rnoSHje3YiCd4nR7Y?=
 =?us-ascii?Q?pRhHSt5tHvERw2cWAO6o35gYZlF6GYjfDhmTgnocZM91+TXo97m8fWa2+5R8?=
 =?us-ascii?Q?4ofd0phKnXiYo+QL1f22F9vERoESvb+MJduLfWXw94LOmr/IauGaNq8jafpN?=
 =?us-ascii?Q?RwOIJXoyjTjEsOL9Y2vpftGnY+yPZ3K3t7m6YYN/OKtBxhUReFQk+5UnObtp?=
 =?us-ascii?Q?cjfrJKvBKDdN3r+wbFnEtxBuDYiKGya3KzqSuYf5jHbEmnRcTKaU15JkwnGR?=
 =?us-ascii?Q?sRtnGgqs8QN1MleZX/45VdCocM+Q3N1/XQ5sHyO9EClbMkMcx2wFb3EMDa7w?=
 =?us-ascii?Q?0Rlvnyu8SBEvHIrHq9ETOJ24PZM5uwELn0RHKB2cTQK644gazoQtwY0jmB+g?=
 =?us-ascii?Q?VYyPDoQue/8I6LX/voI39Y8lkKitZHyYAWYWrkd6AqRImlNqLmZupjk5yan8?=
 =?us-ascii?Q?TeIWZTkq0LabbTN0jMyJkhcqUDz2wrcPFUDLNzHmtkjxKY3ZKNkn8+3daLhY?=
 =?us-ascii?Q?fF3WpsdVvOZpJWRNlh/XUm58vtyPpqmHY281sLBikzjgQ9obHIbuKNOsoTJy?=
 =?us-ascii?Q?Oi9fSrDal6miiZc33JfjcLRFRvg4CUs7QaB6a4FLsrxFEX5kgKRy0xqEpr4O?=
 =?us-ascii?Q?8AbLxZer4mU6w/uKmssFUSwxR2zh2QQOL48lAZ8WF4IswCuJ/LmnqMv49uE3?=
 =?us-ascii?Q?Ip2m5YtMfqm5RnuVQqiMtrCc9OLktAGAAJKYKXsynssW/7GU5KTHtmeEdpHK?=
 =?us-ascii?Q?t//9tesNnxTtd9FB2omSxCAZw5GfpoBg9W4omLbdces0xWrivHrV71hSpguO?=
 =?us-ascii?Q?yE8/1kvileP8mjkQgIkmNenU+RKDk25poSpLICc1usv3lcVeth/+yzjlzoYU?=
 =?us-ascii?Q?zDvL0Z701ppvsLcfIta9M7cxbgREc8vNA/7N1OnyLyctkm/TbAGtPc9sT/K4?=
 =?us-ascii?Q?6NV7KaYGMyA2MwLMgWhKWcxkysA2L04unmf/NMjj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3feab0a2-167c-4c26-e091-08dab56dac84
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 03:13:07.9141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIU+DqKraspIRNaO5/HFw9fqsomK7UvyvyomlsI71G0pArmZwMWyWn0B243ZvA8LLNCKFd9hUK21RKSsBlJYGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6825
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

