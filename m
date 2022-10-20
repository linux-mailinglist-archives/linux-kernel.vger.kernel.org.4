Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D239C605BA6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiJTJ6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiJTJ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:58:46 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84D51D065A;
        Thu, 20 Oct 2022 02:58:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pftk0DdYjhfR/nqdFtO5t58I7O/8SbUlH1Fa/iR2AVZ7BmtIiBY9hEUPuOpiH3BO5kziiKR39tpgXZjsxHGI6O/kfauAOZIotGvLmb9XtN5CCSSQOjbohtqpypE3vNXJTxHEubkCciUO2TYLlzD8gE97H12VdcrTgCmdzlVZu21+QHsz678YjHe2yqMedvaZRV9LCkAr/KC8K+24w42eqrEuo/80yF+S5VZVV+H6ynhFiSE+zWgNMY8b9fMXm3mcaiopK5yFx37b8yuHdFZMBr2SXslAea8PORpGuBELfYCZUfankufOMXQi1TuowQdRjJAo9KEmobfri4IqKRYYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/4Rn2tg73rCFJ/1f0IRjweg4zXNdxTiBQk31yxPMcc=;
 b=WXQo8koUMHnsf9wyCdr8N595Bf8ZfEU2tVEWPX/ZFYe/jYrw+qqpS5px3yBLIk+1qI9ABGnyiP++snQ5It7RGxu9tATmL8+FzEryoJ15TxRaRp7J6Zg7b+JQ7AYBsVG5sGtEFYGrNQy4KbLsSNfNld2dIuHKOK98eepbZfRmqRYCwsM5vBxIG4Tt7HFVmyXCzv51K6yAb3oYnl97MlZMeGQopFcJdbIGAnS9r8HM3lHttXMSMZr5NGATlH1oAkTwZMwl4SV9tyNQ3fXyafqIUU+nJDPaXjDr4IlDHM1jN73pHimv79ab9CNqQxM5eUml2S0g1gksFs092aAJbZOOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/4Rn2tg73rCFJ/1f0IRjweg4zXNdxTiBQk31yxPMcc=;
 b=NhTm7gvK4veYXi/qB4ZTP5890YAIdwaVeORJ4KbJLDpZZkUkXxu+ZZWoFoa9yKAWysUxOuHKUH75qya9OgfnlOL/kalflwBMtXw9PUMVhWfrWHkwTirTM6uVT1hKLjtXd1lPQVNaA8L9UOkYJBxkr/+ashoH1xD3y/2YilEahP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8039.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 09:58:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 09:58:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Clark Wang <xiaoning.wang@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 04/15] ARM64: dts: imx8mp-evk: add pwm support
Date:   Thu, 20 Oct 2022 17:59:23 +0800
Message-Id: <20221020095934.1659449-5-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 707cb6c0-4315-46ec-b5cf-08dab281a445
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KOxY0SYwW/HbAZn1mNjfWEMh/a2bxugFSaumQiGJ2L292H9t9PnbSVZnRdBPAYCRimr7fRTRKEOa2/v8lIW2FGvSbGhqu6+VND2bSprnTbs4icFO//WyoVZFEZOcFsT8lKv8H3v25jx3DAf2w+ysdf3ry25GbsPX+4+f6DYUzjSI2K0Y2aLmU7rR7FRVLT3iyNs9XfKzTOKjnX7nbwVJPyI7Wev7KnAjbW3Jjai2I4RDzN8m3jeiZKEP75JwDcZ+1+cvk0qJPA3NlnCaW/JkcZ9nH+PTLhbT4xzsU05ZdQKxf8QZRgBjuBH4BsLkAEv/3o8OEDvYFL6Qf7JxPqtqTaK/UzS4Z5sQ+0pMbUvLo8LblK4nsLI8W9E4Tptaqy5F8QfPrPYonxxQ4J2RVGVJbQasBi5RibjAtPyIgrHPhIMyA1WTe8DiRrhueu1oOwFa7SR5U5V5eww4Yf/bLLFtSocrh35F2yjsQdoRfT28naDtkbSm6boCODfCULBMaxWU5Ve2uzTsBAHMX6dO2Kv1D2SQTW5VUBzj3delPa7WQ+eKy8Lh9sNc4ym2sCkqduvg8OeMDnX4eHhmBRYRGbRIH3ZeEtjmcag7UNeoBi/Rqx5TRKuseuJSfUucJfz7Hj3Et58NQa+w9XM30x3Bp+3fo7j0Ja9jiCKQyYLFbLYu3LyXRkmPTvHvD7nBcaQon3CNlbK3JP8u/2yr2nRFh6N1ZEq0HWoYwzY/ZH3T2Zy5wLoTed4MxZrLOo0psM5MVXC3xXmNFj5L4mSo8cRtV6LbyY6T/u4NwNc8e94UYc5y2OdzgUYiZSN+D+gYgXICvZlE9JVdanDbUWElGyj/WzUrFKrYDRcmeCKTWgeFmeKlZ1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(6486002)(478600001)(86362001)(66946007)(66556008)(6666004)(26005)(41300700001)(6512007)(4326008)(54906003)(8676002)(8936002)(66476007)(38100700002)(2616005)(2906002)(38350700002)(1076003)(186003)(5660300002)(6506007)(52116002)(316002)(32563001)(414714003)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c22zZn/qZA83h0Tyo5RU3hHYMSqEjln4KHMsm3pjnzdclgIVt8I/ZWbzxexR?=
 =?us-ascii?Q?NFxuwme0rQkNLJ3qyzlJhrBgkOBNZ8MBSfWHyvW79Ht8HQu040LOaNESFVAQ?=
 =?us-ascii?Q?QENNEk9Th9LSHAiZkLFRsJKn07jamSDtrlFIpxhjWMET8U6tcrkF/z/RCkAm?=
 =?us-ascii?Q?qyIwneueHdLOmKMKDuLDBC6D0ZmyhrZBTYW/vzllYhRRIlXXnd3ohgE5wFj2?=
 =?us-ascii?Q?trXAbHqCmNOspkJHo16F7Bv/bt1m4d324EMVMNGt4+2DAAkfFk69pzS4kC9w?=
 =?us-ascii?Q?Cu8XaNHxqEy+KptqQybnMk/chpGdwBCqlbErqjdv1qh+283DKVwTfUeLDHHI?=
 =?us-ascii?Q?Qe/dPdAGtvG8RboMKYAmqEJ7IFU4vGO1pIXXRGS4H7vhn1uUfXGQkxi/TSni?=
 =?us-ascii?Q?sUI3jXh4Zb01X6hn9ZquEg3KEPPP2CtLCLj9fR/QDmUhToWFCiPd9g+OdTZK?=
 =?us-ascii?Q?++j9tWMs0ivj0l+VP6/y5sVsB7CHzPzyE85zJtCi1t3lIRD5QE45wCOhdO8y?=
 =?us-ascii?Q?+F4As2R2u6vH4MDwVit2fNZkVw45Hg1T5iw48n+wQMwej54yuu9vtuBRlQJU?=
 =?us-ascii?Q?PC1fl8jEcVSR9+sCMfBkt9khzePPAIThrXawAtxlMPfJi7s+w7RAv7V0CgIS?=
 =?us-ascii?Q?BwYfTVbbJwvPtPg0nu1POAJA/09nfxI+HFG5qB7CnVOg6uoIu7HrvrFMVZrl?=
 =?us-ascii?Q?bzk2MWWs+vCL/yC6n4rNtEZjXmLAWdrUKwa34mIK3qCD2coyXqglSiRJWR+z?=
 =?us-ascii?Q?g1lmRjUSjmEPezI/94YKmfkdHIjFPHQno2OYMrKLcB5XUBx0aBWNfnev0uMl?=
 =?us-ascii?Q?XPeTiXbq9MQtxjE/QQanLqNRiqSMIAvxmASUqg21RiCb0jllubK2V5lg1GZS?=
 =?us-ascii?Q?iI7NBjsiCjCSecR46cdujzBnllNkyDgRFRHbkiXEfGAratDX6cM2WPfw57xv?=
 =?us-ascii?Q?6vq3Ei+zPWR7ECzo647BaC0DRRqf0ENQhqlKwxw9G6DHmBKdpZeh4xC9cW3F?=
 =?us-ascii?Q?z6TC9QjKfpdUnXqgDf73UvdTVMQXTYEyCfHcdaqtSgUkgdA6gWaaU+OXwKHD?=
 =?us-ascii?Q?W44WrwM3rT4c8M9WZMbpanOpR62EiJpN3i1anEmHEP9M8QXMP4B+SfRBiqEz?=
 =?us-ascii?Q?wJppImAe/zG8Lh25RCGfNhpvLWBozAbGeKFJgzl/0uIVphmrUnohPUbcWrgv?=
 =?us-ascii?Q?7ozR7dN6lopTnnQTazS6yj3HE8Cdy86VsdYRMesVlItZ831GKZl6FnIfli4J?=
 =?us-ascii?Q?L0FbsIcqfw1dazhGvJwg3yjxKw8YVot7TkxKaq/FGOkiVv23aZQS7g3eGwAv?=
 =?us-ascii?Q?REz3HktwI15s+zxMs4HVQGTasy4b28cgxaxPpPqI8oDO/Jhuo0lpP7e+WRY1?=
 =?us-ascii?Q?OcBBHriZ5aAI8voMD16joA02EdwpaKCxr6z6OJby72zEOTdb34kKULL9d8BH?=
 =?us-ascii?Q?5vUBWbC4vS2tb/iFpkFvAF33Q4LrEuUyuFRxRXoUoFZoDkaTi3tiaDvNWkpc?=
 =?us-ascii?Q?Uyfp38u66029HRtiV07JgQUldww+cxn9DiFW9dkItQ6Egdtpj8znf/NfUBOB?=
 =?us-ascii?Q?e7OVkR9buiSq+dGxBiHY72WG2AjRPBA0+m4tmD4R?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707cb6c0-4315-46ec-b5cf-08dab281a445
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:58:30.4465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHztf9pUB5cbbgwxUFltJ7y3dyBay7b1MElCTZk9r4vZFsfb9zgWFSvL1BjLPCqOFweJFUQev1HKVv6a/XRUBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8039
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
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 36 ++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index a4cddc5a8620..2e29bb3c041c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -101,6 +101,24 @@ &A53_3 {
 	cpu-supply = <&reg_arm>;
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
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
@@ -465,6 +483,24 @@ &wdog1 {
 };
 
 &iomuxc {
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
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC				0x2
-- 
2.37.1

