Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AED6CB4E0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbjC1DcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjC1DcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:32:01 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA308271C;
        Mon, 27 Mar 2023 20:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPW6+oOlIopA3Itj2P4TCggQz/Hlc70emL2egTkCj5absjb4sHm1HJNbGgjYt1JaaPW+EUHE6EPTqQCA8e74TwAzuqn33Fh6ZeZLDS/NQLlB4Jshw5UM6YqBMsHYYa5YFV38gTxPsJPINTZf0+KN2U6ZCgRqnVgHawkFMpkBV0ktFFzV2o57L6kuIJn3jK2iubq8h11dIeZWFhxhmn/0Je17CIunIibv7v61QxrezhpHfIbmGdWwyltGFUbAZ6ZTMouXHvt/qzQO2PY9YLV1qt1qLW3KTIPBNgAO1doKSPHFbaWKAWXvaBH9QQ570wDZJGyjZD/Q4Tow0uK6YOoG7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSZUhAJpNUhCxAWxQgzjuxZy/ahQcxNuy4PLJCJ+sMs=;
 b=Lk6jT9JstJqDbjG6MkSb19kVc/IU8fTAMdmqM25wVLowKaJYMrL4o5VSdNYrdgUDP1OV46PwaXqBsvrDknu6Fy3LKtLrXI3/V0jR3EZAUb68Quigp9ycuMEZ6PEJkHX02jbRamUxbrphnd8IjSNrAhGtn3BZK+dkKQnVbzy2HdRIq3l3hYbuMn2Q18U1//0EOUzI/qehBnoIGKVt+YEzlkhwwMdv+Rl5mNzy6q52Rt9GErR3Mjign2QesWldTBftBlMLq3JXbOHhZ0NsPvu9TIwKBzxx0dDMxxp8X/THLpwJpEmaX0FLu9vtHgnZ5KF20qM9Zy/xVuLoQoFBfRJcZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSZUhAJpNUhCxAWxQgzjuxZy/ahQcxNuy4PLJCJ+sMs=;
 b=Yz/PYpUikaguf2D/Q3yAThDKF60mUgIILOK8QRg6DTZ5nKEeNfygKSJsMB46KMwZUdB2OI7n64AsIiUH4pBc3cFZt/J+EhruvvzTqn4/jOKLKtcu88yYvsTeiGwfbNrtvaOK7DT/VYUyUSnDRmeVdvUcotBQpoWH2TXYiTOeUB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 03:31:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 03:31:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/6] arm64: dts: imx8mq-librem5: update pinctrl to match dtschema
Date:   Tue, 28 Mar 2023 11:36:37 +0800
Message-Id: <20230328033640.1930104-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230328033640.1930104-1-peng.fan@oss.nxp.com>
References: <20230328033640.1930104-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c18a0d-f95b-4b90-e463-08db2f3cf616
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IqTdbq2n5lS1GSZq6mbfMacec+JCPrWSt5jWVpz4MmHXg84xzGS+P7Yr7RZqWLnJjZZT9NWVN/k2yg2qODugDlZ3nfAtseykz8NiCYHEq7dgmV3EdVJqlzuVAEt3bzQtQy7WfaC+I8kujYsIQc2o82A99Jt5pPe+TSpAbv4dZ7TPmppG9skYovbJ7HoA5L337MvnLu8K5Zui6qulu0nIwSEDhdl6+61m9+QUzaV9I3QII6h5yklp76yWhZ1wbj0OJZZDfTonz23AyO6UDiNh8Pf5/QUdnoRPHNa/+GjfJlOvjIXMdposcwdbo/PaVupzxp5u2p114LMcDFHqrzciJtK/pWdi7VaAmjPsNFk26d80a7g7Rxf/ur0DjCDQd/vBpZv8MalCLbYhOksJHRzSG6pkdY2dSRie3DFPIn2mptbr0t9hDmZy8RPtX19CoqhTbFS4V+aHEXel1PiNpP1opY89Zhs58bSo9b01JVHj5VIb7bi6vSAtBcX1L04apaLrS8onvFnMfWjOuwYt+51ZjL2MNc44H7iPX7FUPcsB0bAcfH6qOwLCBmQ/K0+wgYYQeBUehk2VIhvQO2VXdF6vMQwB89pYULpxN/3fbq49sluQ5TKqcLCHRYvCDWaAmWKD0vnU1cWHZDeyc6CU7kflMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(86362001)(6506007)(1076003)(26005)(186003)(2616005)(83380400001)(6512007)(8936002)(5660300002)(6666004)(6486002)(41300700001)(52116002)(4326008)(66946007)(38350700002)(15650500001)(2906002)(38100700002)(316002)(66556008)(8676002)(66476007)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rikno6haFAvK2ffwtzA8jKpf5LxdehcJz77KK/Xp45Rijv4qS4jOLunjmczr?=
 =?us-ascii?Q?Bgt/q3GR1Hjql/CifhRiBtsUdzmr/DTYoh0yBLiM9vjLRZdkhdQh9PWoPJHd?=
 =?us-ascii?Q?LoGvi7PNAgPRIbl8Y+lKUKUBLvWkpywbwfem3ZrKQ59r3o9d95+TenljHUGH?=
 =?us-ascii?Q?euQ6RA3/Qxu4u1AYzdmK6v/RFLg8PXTe2IRnVtvrIkZO2ClCcKD/DIpbQQR0?=
 =?us-ascii?Q?t7/RrqGvrWHuFieKXyw+2+1C2EZeIZ8hndL8W8L3DnDLrWREgDsMYU9CZSTG?=
 =?us-ascii?Q?Vfufm2EhI4/sBIWESv1Fv0hN4BmJZY0cLQWWPM5s5jtGBa/oN7wKI9B+nE58?=
 =?us-ascii?Q?jm66vgufYPLjLejLtVjEZ7gVr7Tfja65VFqhea7n8K95vaffPUj1H3Puqm1/?=
 =?us-ascii?Q?/IUCfo3qI732Wlj3S+ckIIOqhMFfCFhlANQ5yzQyTrWmwJp4OqTWISy8Rv91?=
 =?us-ascii?Q?JG7g/xy0DVsV1ecab3BAILe+uYyPigN7pX/pv5P7wSu43k8ezOJcMpzdVpu+?=
 =?us-ascii?Q?QfoB/8xnI14hDCkOnICz+aqU1i+E36CBvfVSmqamz0jvdH1fM1nQwUKPw65t?=
 =?us-ascii?Q?SFhAyj9EuLOYv0/mJp5JOU7jzHGhdcOgcnz6yvHSMbz9FgwWiFtcv0GEH1QD?=
 =?us-ascii?Q?DJptq+9G9QDgntNf1d9ZfzEAsaChSj9pNIwPuQfoaTssbQn6j2dmPTSuOc9m?=
 =?us-ascii?Q?NBaVaACFMtBD4/Cl3Ptyg5GsV9TtEhtajzpbpb+F25zxQER/eOLaGjIPt1ML?=
 =?us-ascii?Q?HZNYw6uOG6WWfXCcrC3zHVARRnKcXyuQ67GDpaRy66dNuwP2jwQb/irRk7zH?=
 =?us-ascii?Q?7/4txb40Q7SUk/Zw7blNadxmRmPRpGgCDgvUMS3ZnPIpfzX+rrUTwETG3BbW?=
 =?us-ascii?Q?z+JSlS9HOrigtWuzIb2See08tnF/k0TmjjSqD7FhAvtfiID9SSf0h0cq8Zn7?=
 =?us-ascii?Q?m+XQJNgYZKIH4FGI6eu+tEvsCaEEovYY5DKzwyCfP0O/CoeH1xeqVY3vqzC7?=
 =?us-ascii?Q?CnrU/KVUlLantO19+3Sd2/ZkotxoaPmeOtqH+uSWZhWWDAXUdANptvdrrbcp?=
 =?us-ascii?Q?vn5Z5nOFsjTEP7v/dXXxg/VcOX6Nk0NAQsz60sWXG6GkGvVYB4jx+k6SjO0q?=
 =?us-ascii?Q?S0wJqUeDzvUuvJuyBKW16THtd9x3N7fepyHNfagwAYG6HWgg6ngBdfsgp0MD?=
 =?us-ascii?Q?y6aO0pHDMNXS7bYedAmSxxfOp6feaEHz4gZIZec0GMmOoG9l5Q//WHQppTH/?=
 =?us-ascii?Q?1fHgIQEsiLv/h2UqZ4fERLQXbOeKDQalhcsqhEGSkwOQeYpWuQirqVLzRWSI?=
 =?us-ascii?Q?hwhHWwFRF5/t+ptjfpE/tO01Nda6q/Rjp3/ofUQl7SYfzQfX1b/2wSj+de8z?=
 =?us-ascii?Q?lD1b/73PQsL01D3vh4bX767IjoiAHGSuOHoehlRvArIo9lqWwkISczgi0jB+?=
 =?us-ascii?Q?cHGAp0CqHQww1iI0Is2dkSNbzGr1sTO8v7xRVniuQajO51wHO51xKYxOj5eb?=
 =?us-ascii?Q?iLzOeAx2MBntCf1Kr/ZYsEqmBYdc3IsCvJCltjYyRv8IO3He1Ovs9oPKvjaL?=
 =?us-ascii?Q?SS8z87Ry2l6ezsn5KJ11aVAF51td4BiJbn0ry6d4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c18a0d-f95b-4b90-e463-08db2f3cf616
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 03:31:47.8899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khsVgqHbvI3kboeWFBft2qWPJmaHckV6T0Vh2EjH5gpjH/sW43PEKkdGgztAv9aE88M0qYL8XxchrpdXGh81TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The dtschema requires 'grp' in the end, so update the name.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 2 +-
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi       | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 7605802f294d..ce7ce2ba855c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -667,7 +667,7 @@ MX8MQ_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0xc6  /* MIC_SEL */
 		>;
 	};
 
-	pinctrl_spkamp: spkamp {
+	pinctrl_spkamp: spkampgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SPDIF_TX_GPIO5_IO3		0x81  /* MUTE */
 		>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index b3de4947762f..d0d013226d88 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -662,7 +662,7 @@ MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x8d
 			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xcd
@@ -679,7 +679,7 @@ MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x9f
 			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xdf
@@ -709,7 +709,7 @@ MX8MQ_IOMUXC_SD2_RESET_B_USDHC2_RESET_B 0xc1
 		>;
 	};
 
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x80
 			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK		0x8d
@@ -722,7 +722,7 @@ MX8MQ_IOMUXC_SD2_RESET_B_USDHC2_RESET_B 0xc1
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
 			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x80
 			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK		0x9f
-- 
2.37.1

