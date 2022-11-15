Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61428629416
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbiKOJQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbiKOJQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:16:12 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0C31119
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:15:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtzHSODVvZCMTX1zZ9FdPC6/7/4RrH+CSzwGberVIljke85JrIzPoQbh8ONcXmzaTtfZuUQqx3o7wTNjRNqXXSqA7yLJ24rGX0tSPaNsxjtbRPxpWLb7PaYaoWQ/dWXUasgKJ5rYPbun7ow4rDG7YOXKw0LeURs9benNw8vfQfvyElBn0DkqCRFVt7hbE01lsjQ57uMrTDUtpJywBDO0M8qqsMPKw+Oewz+ULwkjBBbrxbDEzHRl0b0RKDiXxWUMQi2BR7qxUPRNtjnDEWuanMsp+NQqcBVp3x2o27lYiRNTorASnvHQ/PnSeMYdZIv3FBmCKB97Wpz6/QH71M+vIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94TR/gJ3QFYxCbPvYw8g71pvCpJSSj08ePQxdLAnyuQ=;
 b=and3NhPxxbYEmcM26hq6reQN/0hy8Gi67bwwKrDUhI72I7h2h1rZEJOW2n1LS6Y1YTDRIroz8Xu/pf+U2Xl5T2fD+9pGvF8TAMN8Twuj7cZDWbkNcVk+T3t3vVrfRkAhpkKipRLGLZXgc1202yL+rgnwhSpOgNCwYcox50jipbBFieL6zmJ/PLdkomngZ+k+HlU0x4gqmiH9stHedzAC7lF1p3lvgreRhBckkeH7H8rRq6U6wuqHwEdDSLIdmB7p65Yxwcsn2nuKDAUFA8P8+AZ22eXSgF4+Yrp+FYINZuYa64Nm9iEVSQomTJUuthBmfYJmI4Naj4eI5Rmls2Gbug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94TR/gJ3QFYxCbPvYw8g71pvCpJSSj08ePQxdLAnyuQ=;
 b=IQr5hlWCQ7hHwC/PZlEydL2IoNKPsHdwJvlYpxg6ljwupkmHs0X7TmBb7xtLy0fbtDXYqgzlw9ZgZUXjYnmUysfi9q6Z9q7INFJ/odiKwAMZCBdYVjfr+qbE9GnavLG8NL55K3hHWmR+iGiTf7BvQwF5o//xX3edbB2KhUa3fXw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8195.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 09:15:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 09:15:53 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Clark Wang <xiaoning.wang@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V5 03/12] ARM64: dts: imx8mp-evk: add pwm support
Date:   Tue, 15 Nov 2022 17:17:00 +0800
Message-Id: <20221115091709.2865997-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
References: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c5665a-9ede-4f2f-1484-08dac6e9feb6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZF8Le8zPEuLQrUJg2vsrnKVXciFUHW6nkdJvgoVx6qkUYCNpDkTK4mwIyXtwPbNtD4X+Z0HRCVEmzqryCqJg7pWgSabPVCiqFjg+av/4SUmZFNfWlobQxINHnKmxY/QX2VQgBufaWZA7FFul3HgQ/EQxErpBBZ8uLpz1YNAuyD8raG2fhlvhMFZ92cKQ9pn23NnSZyTOTVQGqp3lB5YJTYONqNv0eJMis9p+rQixfJdxhQMcNhwR+C1lK8LwhaaQ6xdRCuiYkEheADM0WP0G3w3dOVpiP5MeIRuZBbeYIgnE9elJX5JeOHefG30bjbKo2s7TTOoOcCf5I/mFxwKpYj2fkiFJnPlTRYkqWfyFpVZzAKpGbN6VIOGMvxK3Dyz3Z7KYycRTeoE5HkNB04+76qMKCfDrelVEtdxohBb8F7LeVv/+AEB7ZTjDeRZlB1jVIOaZAX1JZOfXKB6Ig8HeEuNzVVWbHPdrBzdI05kyEhY0+kIk/t3MIseAH7Lh3Pvt6F7tqW8j3rRYKQu5NUqjT/lfIvwJq4BKAlritzyQ6ObXGoHvuRvDAtutLKOsX+n2Z9FO7ASvU0kI+gvKvB4cZRJaOc4rVVncoSNngFORiGPP68GClHrexztAdF76dVM18OAWQRfIytWkUsjOlDSVyI8Wbvp7sssK+5DvnVXp0JVkOcOqROObIYa886w6/AxKQukn86UqXevsBvqUr9cT8Ja/Mgb4iJVfoNCRk0qrNQ4HbB1PuEyd1vvLAajfPC1sb16jDsfHiGnxoP6WTljLMN7SIEt/fgGaeqnWI5y2RtcCi02GsJXO2FxIR/4482KLl44UyPkDxdc5LOAjvhtZ3tft0j1UfPXgVqdlrjsix3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(6512007)(52116002)(86362001)(38350700002)(38100700002)(1076003)(186003)(2616005)(2906002)(26005)(6506007)(8936002)(5660300002)(6666004)(478600001)(6486002)(66476007)(54906003)(66946007)(316002)(66556008)(8676002)(41300700001)(4326008)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hIlQTlq4lCyt6vwmRMpH1z7Kcx9s6Eu86XKPwfIm4x56C4sjvcDzWxSU0azl?=
 =?us-ascii?Q?scr+6/UDop/o3Kn1NezeOHlOd6alree/CuyyIBLxAfsj1I+ChV8z46ZqgCWc?=
 =?us-ascii?Q?Q2JQ8ifsTnvOqD4owwbXNe1lX3HtV+FgTz7S0AjhbiCbnchy3wqHLA78hH/J?=
 =?us-ascii?Q?bdbPLj9yTQaHCMNDWsh09WtG+sQBE25Ifd8xr8E6mm4PNgTgB/gUlazEmv4Y?=
 =?us-ascii?Q?3XfYRS8BtnJwMfIhJ+rFBBdhpv9FUN/JiI71gOYXUMGw9co4tTPc3cP8Q/uS?=
 =?us-ascii?Q?FtGwwJpclBRjZkVSS2hnmf+s7iv99PNfjt1fpn7EcYqW3CwXFlElZ2dMPgST?=
 =?us-ascii?Q?7WaGl2wXewUvghMLXVRcCa9IThpeSVWDP+3ZoU9Q7cONCK0VhZHc6oVUl7pk?=
 =?us-ascii?Q?A1/FWnh/oZ48YeD/ubZnnnxZ/UNiPR4/G9qmKcbdp6ESmWMXhO6bhpBjSUmJ?=
 =?us-ascii?Q?LyOXTajlCKLoHe2u9KmTJFcTnDjMi1vhfNmjY1yseFUmOdZMheHgFTXXIUqU?=
 =?us-ascii?Q?+zGGDSHCpFLtmw6Tb/cEqzwl2em26aLYn5Gnd03ZzA5xq3cr0fttanoE0EV3?=
 =?us-ascii?Q?0f+jsO4hmtWVuwmynTNgI6nm2u6n7kJkULZy0qxouMVAf//q5efsmNII/M9l?=
 =?us-ascii?Q?CPNVwEI5P/Y2RqfxvlsM3LPqBoUb/v/f2FKGpl1ZvEugon0myEqKepAcZ+Kt?=
 =?us-ascii?Q?TF5vNRYVDz25sCB3NwIvNjrTKWQkV4oo5S9zAkjfUhkOzfH6Lkk0RmIwBm5s?=
 =?us-ascii?Q?FrOYUBlC3OR51cvsYbBGa9Fc/8mjzE9oM3Mrriqmb7IR7VFgnMhF/Jzm+zm8?=
 =?us-ascii?Q?9d+VUpqbrtkpV9AcO9bYVF7VeueHLvODqkSfGSvCTBwVsuS5kZZaZyucIa7e?=
 =?us-ascii?Q?5HEA5w/HZlixnqjKxzloQ7d6ZfP/aBrgUErxC2RXqMS4nZBXaOlRdmXeiBOP?=
 =?us-ascii?Q?aTcvp0fb3IQs5Kdiu5fUTaok8E3oCoHBzL4eQkt8ZErFtJb0YTFdkPzf+mKf?=
 =?us-ascii?Q?1WWIl9/eOp4/jDA7ylD4fJabMANOyWAPd/q10ZfqADPCCnvh6G0W3iVVFA/j?=
 =?us-ascii?Q?G2VpXZV8y4ogMpbHBqfFt/qVaHLmVjXiOjTwSlhxJQyk2psKsgEDmnvTbdFh?=
 =?us-ascii?Q?6DTF+qh3lxK3diPaseaaS7034uvkshp1Gcy8f+wRaClIYE5yJWskCzrniKBq?=
 =?us-ascii?Q?tRQcMG7FguR2kzJlh+2TYdcwj6C/3jGoGCUirLK7W1ASJCO2fhiNVKUPEaAm?=
 =?us-ascii?Q?T5IhRLN1o9iskH04FbwW4l1vSaT9N1PGlJfZXT5VV+7kjMfgFSRIfXp0zVHr?=
 =?us-ascii?Q?+6bgYBr+cEyP+cIflx12uYdsH+nnRZgEEGj7P+nxh9NRpl73EM8v2wxOposG?=
 =?us-ascii?Q?KYehsEUMY0Vd1VBRW3ny4xAs/Bfj4LKgK/yCJVQhF8NG0iluNJlhS2c5fmHa?=
 =?us-ascii?Q?Zywi4vHA3v1EwpaXZT4Cp21WLhzLqzk3WUCL9JQ1yxcZD/yiz3nlDyk42zkv?=
 =?us-ascii?Q?FxAR2Q7XoQbRxCeWH9LVcTod1WMZfX+HMMVsrMOeixw/SIR0ieJx2b8ue/E1?=
 =?us-ascii?Q?B4qxcagstT81FFCjQV+baao4SKoNPjhr15L3EQIm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c5665a-9ede-4f2f-1484-08dac6e9feb6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:15:53.1558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bm5VF6e+uVd4QHK87QHqQrQQ2SsF42frucOuur1MhAtF2vdP7/HGkjOrnIzADJ1v2pOtH6GKnJOzv2pM+yoXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8195
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clark Wang <xiaoning.wang@nxp.com>

Enable pwm1/2/4 support.
Enable pwm1 on pin GPIO1_IO01 for DSI_BL_PWM
       pwm2 on pin GPIO1_IO11 for LVDS_BL_PWM
       pwm4 on pin SAI5_RXFS for J21-32

Acked-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index b4c1ef2559f2..e323e6f4b7e5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -390,6 +390,24 @@ &pcie {
 	status = "okay";
 };
 
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm2>;
+	status = "okay";
+};
+
+&pwm4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm4>;
+	status = "okay";
+};
+
 &snvs_pwrkey {
 	status = "okay";
 };
@@ -567,6 +585,24 @@ MX8MP_IOMUXC_GPIO1_IO12__GPIO1_IO12	0x146 /* Input pull-up. */
 		>;
 	};
 
+	pinctrl_pwm1: pwm1grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO01__PWM1_OUT	0x116
+		>;
+	};
+
+	pinctrl_pwm2: pwm2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO11__PWM2_OUT	0x116
+		>;
+	};
+
+	pinctrl_pwm4: pwm4grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI5_RXFS__PWM4_OUT	0x116
+		>;
+	};
+
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
-- 
2.37.1

