Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8516CB6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjC1GOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjC1GOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:14:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05261173C;
        Mon, 27 Mar 2023 23:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7nkamfDBTJPsnQBdtqyy0x5R59MpHCdZAGp21+R6AWFo8eUCcgL/3UKQd8emQ0E86kMzgRiD8YWeht8Ph+E5nIgsl5w/6CeZyqKdKjUDjGOc4ZEfe/kEUgB3JQtrkGahnEZrZsHpkiYchPsn6mmxuunC2xgD+7FK1PL2aNQN0EjxJu7GxW4Iz1MofXC53z9EIHUlf2ls8mfA8fDPy3xwGlhsa0BDRxzWOYlTF5OjMBiAwPdWbiw4JfXX108T29pbTa5C4SYCKlJlvb/e+GCfIm01lVdhReBVQDFWpX5Bw9jr1ABhnuWFT74Yrtcd9sX3zcXH/22wluh/WeU5l0SyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvWjNxRw8fY1V3jCUYc88qCYNGpoa+JPVdWJk4UMj08=;
 b=PKEoqAxhWFJWEAR2rDMoUgxT+Dg3gNkgavyJqoq8gsEV1K106QqCUE7cw0J7Bvhz03YuYhuv5cqnekJCLmMdB3Gn/7zqa7ncvGUrcmGzZArXBP+OTEZ5lmcgpuJYII+4F7pai5v95FQom4Yd/DVf70EB+E0Hi9CNpU/0T/uIm9suQE0p1U41IWnMapoWL6A5VK4EqqEg+PbPnbJRFKkEkglp1VZHqhGZNiSNYMlDXiAsPrjd8+QVmma1bsqVScrYlbNGiPzFEvqlIrav6exuFE08JncQD+UZFdkIhj5rjvz175BatICpTz/GuJndBRx1dwUrWIZzqH9AD213b8K7lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvWjNxRw8fY1V3jCUYc88qCYNGpoa+JPVdWJk4UMj08=;
 b=HsyDvJxNanCSihFYCj8gyYXbHV92sUN6rMBg/AFD+2dAzCmVrgHv/ZCwXkM0dtYIoFwZTQEfWUZNaRKnKP15TxVBWDGorREgYIqd78LBQexZTaJGKaMM7C525h0TjbkwDc1OaS18ndtpKchLUsGTjWek8sUt1pRJIGZZozZg/Jg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8834.eurprd04.prod.outlook.com (2603:10a6:20b:42d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 06:14:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 06:14:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        marcel.ziswiler@toradex.com, laurent.pinchart@ideasonboard.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] arm64: dts: imx8mm-verdin: correct off-on-delay
Date:   Tue, 28 Mar 2023 14:19:04 +0800
Message-Id: <20230328061905.1989856-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae7de79-02fc-40db-56e4-08db2f539f32
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +pptk8Vo8zh1Lbz33VKZDFeYGIT/PoDSaSRYtnEcled1PMIgwLMCxXKEE6LcMJ5m7e4ho26UMWtrzGIE8I7xstuki7N4hD5x3X/w44KU7fifwChTErKOk/w1VDjV6gc+deA8ID1Q6jrK9hI2vmnO6lmkP4x8x1FbRwfdIXqlBUIs4boN5weXEnbNP9/7p/HrQeHfj2oqyrGnKfbvbha42ZIcbpaHLr3FYHQc/QppxesyYRv41i5DOtf05OSacEwWivVtqdUA5EC+BuhEkCGZlNPCPSHG7dKd7DIKFL41LVziHoNrjBv0CJxVTGQms28W2bQCT/0Ima77ryN7cuhXBwTlSsVGkReJfFg4gIEt2SRRp86zICdQ7dXdSIFe4MpO+7ZwIQPsHPyF6dSOMGJli7KjyDW+zBc0HKlWzQqnhQUFU6dWKoVzmhvZ0gNQT18xGKm/0Uvo1dCIDxDM3i+CphX+AOwC/2ULCSelM97Iwy9Lz33ZdZHjxP76H7fgUJ+ZNYznYZOdSDZXX2p3uOKjux3Q/TyWcvGMjTvMvjmBDSdtm1DyzC70PV7uC2zGLPWRbP7Yohwdv3ELXt+VqRQPiylZ7y8BAJLlrbVdSYUfARZMG10xS4c+jo7391i/JZN3F2QQJOQh8KQxbai4dfKC6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(5660300002)(8936002)(41300700001)(66946007)(66556008)(66476007)(8676002)(4326008)(2906002)(38100700002)(38350700002)(7416002)(2616005)(83380400001)(6486002)(86362001)(52116002)(6506007)(6512007)(26005)(1076003)(186003)(478600001)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cfaXtc6cboVvzHNfvBd+vvq/mbxRF+CJOL4CfzzTHfjDp+ZIvasr7YgD+rxO?=
 =?us-ascii?Q?iIisVBYaB8b7zZopfNw2+dO/wT/5Zvhtrz4FgJJNuzEr87Wn8MUurAF8kzfU?=
 =?us-ascii?Q?hrfZe5k7CLKj6I8XmKNvmHbfn2UROX5R8mA0kYjXTY+QY5HjuViNVM0ATR70?=
 =?us-ascii?Q?LhWcs3IpwB7HKKawfgxI6UZkMfX//6xtbqO6mwjDP+3jaWCduxqKiD1qz71J?=
 =?us-ascii?Q?NltB2rRYOJJo4RFYsJdMdJkrfSNAYCJ1+dY2jYmbXJaVxBy3fmT/vXmEaDc8?=
 =?us-ascii?Q?0xwazzI3fWo4TPjnsyvGW4YSfMm0McLj0leYBEBwahqzxhoynDojG5gEtgDR?=
 =?us-ascii?Q?Ths9A2x1/1Wbxp5Jr6tLsuPV4ECzMN975L0dvJPIqxWqUbQEzMbU01nVM9g/?=
 =?us-ascii?Q?jdYfM9PQk6gfabTWU6v8Jt7T/0/LH4meyStrGBVVaeqKb4dDJB2fgovADSg4?=
 =?us-ascii?Q?PPFrzKNVQQfYmeSIqzMeRC/v0EyEZB58cQK01J/mrAX8DRILo+GFm5tzSkW4?=
 =?us-ascii?Q?tpKeXsz/v1YWDPzrjpyI+LJZ2op1sAtAxDaWBw77Me0KcZjli0K1MOuWTMEc?=
 =?us-ascii?Q?HNYPEGHztcPCunJUEFtRPXk3tIKDDmHJ3wyNUMlf/oY2VOPER98uYo6tt2NG?=
 =?us-ascii?Q?GSWpEBySHKzrXPz8yDbJIfDefRjKdrmyR2eYgL8o2WKBREvPm4O7Yfp5WB/K?=
 =?us-ascii?Q?l+9tH8GUlgOdMkiM8Ul9CQarmcZX956mT/cij1Ab5S/wOyBuoDiHiWK67M5n?=
 =?us-ascii?Q?vnS4zr2agbu/B+wJMroDJdTc5q8eYI5hTMBXdOccbJMOiSHieJLv4ATq3Yam?=
 =?us-ascii?Q?CEk/B8auKgsjbVJyUT4wIftwvpc+BrAKzPb1lWHT4f94VJYH2Q78AnshQ2wt?=
 =?us-ascii?Q?Oc5K1j08ZJ0dIZVs/LJRywiXO8QiZTLJbE+TNZyQ9n7lBApIBAFMq6ioGZRB?=
 =?us-ascii?Q?8a9VTeLFNLYS+SyfOSJgXu8vcKJFj8VVr1/kByHXPZWnTH7tPkBXkRnL+QzK?=
 =?us-ascii?Q?21JRQZ/DCD3w60hX+l5fYU1NN3j0PXmxs940RywN0VNUNfCmqAzmxICmCtxh?=
 =?us-ascii?Q?ss4nSWUGPe+BOlUCjC6osP/Z8BVdLDxcn6GCgkeQVPU48XQZwETIVRIxc1Cp?=
 =?us-ascii?Q?38wsANvGxTgiDRo5y2/eQOYXvaFGIwYhfNwN/iGnAU8a/uIWoo+z9Xf1QnnL?=
 =?us-ascii?Q?0CBuO7acB+2jDhZ586PZv5os06Wb+SdjIh5v8o/dJylKbTQ+S2JL5dGWABAy?=
 =?us-ascii?Q?cySfBZcjpOHbvOezcwR+Qw5KUIP9uZjxFZT9lvSXW4uNZmxc5sKstLd19SCW?=
 =?us-ascii?Q?QsjW/pFivLpHbFmw+/qY0xU0gPuBdcn4gt7H7QUyicFFScrWhSTaIOEJ90uY?=
 =?us-ascii?Q?NyGWMUypeE8MDTN77fJYGRL37B+xlUFN0Gis54wplIV3HTRp4l07rnP6x8JX?=
 =?us-ascii?Q?LrIJcLaMrYl2AKRiS5UwpwJwG8xvdCKwlVo/9gD1sweMwqdmWHDnyCk4S6S8?=
 =?us-ascii?Q?FRCP1YpmIGH0gjC1NSow2af8hbYHPO9YYZuj61SsMi37aTBltsfdvw1gwxyj?=
 =?us-ascii?Q?HqBnyxsoi4PDkMXs3X4oPmlgNpYkzHUbdmFw45UZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae7de79-02fc-40db-56e4-08db2f539f32
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 06:14:00.6686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5abhjrPRlmUrOn1gBgZaFcINSHrPVT0I/K4Y+3PiCGyjcdY238zXIjPux0I4f6s4gn5NkKT3XEszqx1/S4dzg==
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

Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
index 88321b5b0693..6f0811587142 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi
@@ -99,7 +99,7 @@ reg_ethphy: regulator-ethphy {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio2 20 GPIO_ACTIVE_HIGH>; /* PMIC_EN_ETH */
-		off-on-delay = <500000>;
+		off-on-delay-us = <500000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_reg_eth>;
 		regulator-always-on;
@@ -139,7 +139,7 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		enable-active-high;
 		/* Verdin SD_1_PWR_EN (SODIMM 76) */
 		gpio = <&gpio3 5 GPIO_ACTIVE_HIGH>;
-		off-on-delay = <100000>;
+		off-on-delay-us = <100000>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_usdhc2_pwr_en>;
 		regulator-max-microvolt = <3300000>;
-- 
2.37.1

