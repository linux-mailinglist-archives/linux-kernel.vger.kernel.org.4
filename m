Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98B06CB6B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjC1GON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC1GOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:14:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154D126A3;
        Mon, 27 Mar 2023 23:14:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1aWLMpWUr3Zn9PXOlkOqD5Sh4EtuTaNX75p3yUW0vi1HToqFOtHblha1/yTxNEhjp0t/XIu3TRkRHpDTWwONG7LRltSH0EH6Tk3b1xCEICb2USNr4MYlqhAwqCU/23rfVaQYN/ipISPb+XwFnHXtihc+FvRWtH+xLo/fRlfRX1YKxQF8DgxtFt5d/Gxmu+Kz9d0xlfk4ppyXOfrFOx+4SOaq3aU2Qo5d4CafAfvmyCvtf1bJ5cwv57MzAG+1ps3I646rTRwHs0WjM5Iyj954/7Xxl+Otndh4RntVBD3Yvcr9E6ZaVhkuunbWgqVTzhPBst3Q2FZg4wTG6sP1izjnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPTy/byKV7q/q9VxxFZ+sR4b5/u1VweiYAmOQ2m96Gs=;
 b=KjSk4riaHPSul3zYhlu69vYjC+NE9qdN9DxSkt+hMdVhyr7bpoWcoVnVtjTFe0us1NeTMyoQGIT/MQtAnIf2LmdxcsPQw91/J5UYTNT0kCkqlagTnAQT5ZSSR5sh8s7JpA8PlSe/WxR81VA2H3Bv3voIVndMZ28I1QeyXIVrXYxno5qkmYouuAqxz3eY74WQL2XDCx0sh8Zv9T743vE+Yoaa6Tr+RknybHUqG1GZnDUJ94/+skuflJhkFkBMAzbPl1zuZLt+JajppgrxYoQYRvwDf5mi1oPAV/OZsFzM936eJO53KMEl33ow/74XcbrpVFGw9OPomDh2DjV7yBgkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPTy/byKV7q/q9VxxFZ+sR4b5/u1VweiYAmOQ2m96Gs=;
 b=GOOzNlYF8tFsL5NHt8E6wmkBg2s69tfCAsSL0WVE9dyEqecZvfaOQG6gXyqK/zvoCnQ769aqa37a/A2STRw7vehyZPi7mmhR5RCidSTeKa4Z0x8avnM1hCeF28B6xO/LwPPUR666iqogPbcRb86cWUDFxT95OXXeifegYucUtGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8834.eurprd04.prod.outlook.com (2603:10a6:20b:42d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 06:14:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 06:14:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        marcel.ziswiler@toradex.com, laurent.pinchart@ideasonboard.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] arm64: dts: imx8mp-verdin: correct off-on-delay
Date:   Tue, 28 Mar 2023 14:19:05 +0800
Message-Id: <20230328061905.1989856-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230328061905.1989856-1-peng.fan@oss.nxp.com>
References: <20230328061905.1989856-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 9178105a-20ad-452a-8377-08db2f53a218
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mITYa/UJpn6FJ7gWyrpOz9ToBW/I1NXyULc1fjAIc8Q558O5w0UyZZsjSICAyM5qRs3FicmrT+NDYZBfvbNs2s3qGSrnRN/6iHPlFPSBptqOF5u/5D0+GU0aGD5H0UXtZ6tYPln2cePuhqr3JsnkDrNbnKLyfkoyHWU/+DAfpkndkSFQrKLUAXeAzo4caj2+DXUuKFhKpKcGGrFwm/Qqa5IQO9rrfoirjk0T3nDWy9Vgs37l//WNDtVjbNMVAlpi5tzt7a29nRwYUVhdjzGXKVixvoUD1GyxmFaXoJ2dlI6Ya7WLIjHMHgxicWF9hH2uPwH+PiOBZhSkNxVH0HZe21HzyrMVzcrpaxj2rdjIUJeooZDp6y1mExrUrKBspsLtmC4/IH7bMBIy20WeH5tOuUxJXb6WlPSVJ86+YcNHzqynmn/LrmZgw4H0ymm7yCwVqesa51E7DNOrZuYrYd4/6xdwixvXMCH9m+4pDJ7Yj9NSAoTx0ZOns4JXL+7rjuPZ4uUzj2kFKZqfR4tk/OfcEmKotNtGU1QvbSFaCOlsxwu8wmdH15vK2JeRT/yzEBNyHuLTrBdbrq/e7eHh0M5LjyAAzsNKJ1CPG2UdPEKv4v8M1BN6JOW2kfBTVS1I8n44caPLxboYpSHqTs3/ho1TAVLjadaitJWTa/9wYCUo9yY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(5660300002)(8936002)(41300700001)(66946007)(66556008)(66476007)(8676002)(4326008)(2906002)(38100700002)(38350700002)(7416002)(2616005)(83380400001)(6486002)(86362001)(52116002)(6506007)(6512007)(26005)(1076003)(186003)(478600001)(316002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xg1K/F/DcRiL7n+9X8OJDkMhLtGARfCUEIaYqX2KaoL276xt5Y+Q6d6oaW+t?=
 =?us-ascii?Q?BQvzGb0bmWKEzybBtoL26GWwnUw96reF8u4GU3RGbl6QYWCCL872jJ5DdaVY?=
 =?us-ascii?Q?dbqB2NnyAoVFUClpEwgfWKFu8xqwDKw10DxRC8w/3A8X2ILUusi3A+mwzxtR?=
 =?us-ascii?Q?ETsm/73R6TXTZakaVuCA8gG7fHjM2YKxbP8oWwvxJGacGAK/Kt9SnyX4GJY7?=
 =?us-ascii?Q?FZW2YETg3ngz392vIMf26QZ/DljGei6bNf9IaR/dxcf3Rj/GLipmUb5avz1y?=
 =?us-ascii?Q?H6Mpc2klnGoMd9Nwr6HsQD5VGh17VpRBGWAnvdAOo5XTVxeIat6zwX9WTpKt?=
 =?us-ascii?Q?csmHif74m4ZzYKVUU9+eG2V1EySYbNcQssmoGtbr6ESZwg6AV4/yjLXZChgx?=
 =?us-ascii?Q?JuSxt+L14CnO102HTvjBUOj3/8A+zpLEVVWCqZ3o8p/RrTKGm22ssbZlo5SB?=
 =?us-ascii?Q?xrgdyetKulyGvBp0whufj0pWaxgK5W/MXSSntmdpNmAoPlrhGh7IxBaYZ0YM?=
 =?us-ascii?Q?9wskiJzp2uUoR9lnTSRGYQkwEcwkaAQhgXsgvdDi/ukUjBRvWEAYspRCbg0/?=
 =?us-ascii?Q?Dv9fQZNENRzFafIkYvSNbZaMd1YvrbZC6jGptlC4QA7kcZugblVOLXMikmCe?=
 =?us-ascii?Q?nfu4BlofUDC65jwoqh5odv4b/YyJUebYDOyAVBn2PEKaITZ8/b2J9+jIf/bg?=
 =?us-ascii?Q?sN2wyVygbFEDyKZfWCG8gPbI+388Uku+YJ2VSDg5DNKK/5gFS85zLvh3LSKJ?=
 =?us-ascii?Q?mygDG77Y8RjkJ44ga+zjLd2TZQr3m88g+cP9BmuL+20JDMPcU6fwQWs44I0a?=
 =?us-ascii?Q?QGKCz+9PbDV0XaYNd4QqucOtw8mySERsz/47jaA+DiFPnIt/kD84UQhGMDQQ?=
 =?us-ascii?Q?6nul9OeGJ2HuMUOpRjxQMPXK3dltrhd8muFQZSSLDtGW5cwM2lGqaY4g5JZQ?=
 =?us-ascii?Q?hTsqDahT2nQyrzYfmWdx5v0OYADjkaEqLpusR893yliEkdLek+MtzoOYkSP8?=
 =?us-ascii?Q?a+j4sBZlgzpUqz2rikbp7NhORp5ZO0KMxtMywT6NGAwCzsURGHFq0xTGRQRO?=
 =?us-ascii?Q?VfdYP0jGLSj4X7IIVakhdZm7fA78Pmfo2DOUJTD2tNVKXx/6SefFZsdYS4p9?=
 =?us-ascii?Q?QdRS8Z2270oYuYyOCIxJp4zxQw5HVqSchECgElNJ+5CIeTb4aW8jQoMPsbxK?=
 =?us-ascii?Q?EAY5GhtOEFqHKFCKD306+SHiFZUUqa7tZXXWmvgaKXaHswI9AQHlqp7eT0mQ?=
 =?us-ascii?Q?2cvvNN7mKq2awgONscf8oqvpxDUYEgKPi8aLBqymGHuaFT9a0gJ7de2tB9vq?=
 =?us-ascii?Q?vuxEbSWOk9gvnKtkjPCFd/vrXS9/QHxKIOHSZHMbKsbby2TZ89S7gWzSMjyT?=
 =?us-ascii?Q?3jSssilA7Vvkf+f+XuXCEvO9rBKEeXz5Dbj2+YMtJaT+uvC30rSaiY7st1EI?=
 =?us-ascii?Q?P9HfRwWCc/OZ845vXtWFpko60rQZ4n8uF0B1ORfOLULdMSejLCvz9UTwM+d9?=
 =?us-ascii?Q?TYSRZbfBjA4ofBAn3wRLlIsexAMh+Xxtc8Uc51ek9TOIW9hEhkg+1kVCcyZN?=
 =?us-ascii?Q?8hDCDzfE2nDmbfIt0hMhcOQZ1d2ojS0k9hWerPAQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9178105a-20ad-452a-8377-08db2f53a218
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 06:14:05.3967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnaBLsPpa8caPWh8STlPNGRQU/VRXhQ0XXbPRG/0IGmpiPAhdt3c6D85csQLDM6WbefoVmgwi2k15BcDDBZSyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8834
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The property should be off-on-delay-us, not off-on-delay

Fixes: a39ed23bdf6e ("arm64: dts: freescale: add initial support for verdin imx8m plus")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
index 096a6f2300f9..bdfdd4c782f1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dev.dtsi
@@ -10,7 +10,7 @@ reg_eth2phy: regulator-eth2phy {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio_expander_21 4 GPIO_ACTIVE_HIGH>; /* ETH_PWR_EN */
-		off-on-delay = <500000>;
+		off-on-delay-us = <500000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-min-microvolt = <3300000>;
 		regulator-name = "+V3.3_ETH";
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
index 00faaf9a02b2..e9e4fcb562f1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi
@@ -87,7 +87,7 @@ reg_module_eth1phy: regulator-module-eth1phy {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio2 20 GPIO_ACTIVE_HIGH>; /* PMIC_EN_ETH */
-		off-on-delay = <500000>;
+		off-on-delay-us = <500000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_reg_eth>;
 		regulator-always-on;
@@ -128,7 +128,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		enable-active-high;
 		/* Verdin SD_1_PWR_EN (SODIMM 76) */
 		gpio = <&gpio4 22 GPIO_ACTIVE_HIGH>;
-		off-on-delay = <100000>;
+		off-on-delay-us = <100000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_usdhc2_pwr_en>;
 		regulator-max-microvolt = <3300000>;
-- 
2.37.1

