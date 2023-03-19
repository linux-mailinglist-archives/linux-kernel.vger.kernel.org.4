Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C256C010A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjCSLuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjCSLug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:50:36 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A9B1F499;
        Sun, 19 Mar 2023 04:50:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nkgdIF1ExCsBAI3Xr116WidYyhpJIU8rJ85rDQrN1s0hAGILO86vAT2GbO7++vwO3WOH+EeBkwbKZNj73UDF0mWilYG9Pryu/d7qvCU3ZXYp8lArcr3JNX66TAlJfXXjuVfdcgEmgs9ERwyluFlZPJu2RGy6U7fNSb9/3/yMPyGxA7O2RDSKnf+6e0GF5BOxEzipxzcryz9TQuMofwCrzoSLlN/4lHZTxUH6bBrtYYq8MZ/9xc1Z/RsrA4xNwOJX76DxiKlXui1O3peqOemcMmzBJWffYc6eaHZDNPtYEppx80JylItE8BeqqHIm4W1hA0hjFyQRENL4CFeBA6jn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bEFt01oeXktAoasX8gfn18yVdwp45SrLy9riv98vpc=;
 b=bpKRPIEbMU9qzKHIC/MWo3Q3k/mbg7Z0jiPLzs/K7wSPW8JIXoviGVbQsMGzoFfQPbDfw2pIT8fqbewjpio6wdUP1gCP3xP5wdI9PkJb2YotN40FXG739KKTALIsqD1/vJHSCrZRsYiGRm/RJ0M8DYefg4qd8IswtG2v1OxZ26KescyKIZZfVAoNUDf+zFWdNCK5Sq/481Qk2PTm6wClf4laeiMwQiykdw+mQZw+2s07Wb/Ptj40XciivJYo/YZH0tvZM7tw+k+g0hursD/awA7i0TPZ1i8OqkU38XketJndkwIUdhydcfn+aIsyBQmpbtuAa+SfakszDNQX2tqN8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bEFt01oeXktAoasX8gfn18yVdwp45SrLy9riv98vpc=;
 b=W52nXHf33CJzpmxe9jTAxYugffUsG/vmUQ2GrTsbbp9dCQeew5XWTME4eFn82hKCUY9g087GxFN7tRM3qiRXoFrlowM5Xk6os0734QrFrxrddPyWjAGZAVhi8WxBB4ASBXJBtR3s+NsDWS9IXMceG7K/0j7mvlw2PAiUs4N3ho0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB10075.eurprd04.prod.outlook.com (2603:10a6:800:1d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sun, 19 Mar
 2023 11:50:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Sun, 19 Mar 2023
 11:50:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 4/9] arm64: dts: imx8mm: update usb compatible
Date:   Sun, 19 Mar 2023 19:54:51 +0800
Message-Id: <20230319115456.716969-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230319115456.716969-1-peng.fan@oss.nxp.com>
References: <20230319115456.716969-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB10075:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c57605-d0ca-486f-6c71-08db2870169a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4ABLCSsK2IAun4Jo50qG+xZIeKWWZi8WGlUXzb8AJ3VYT3PjrWzydDjeJH7ZgO4X5WaUPiqD5tJsymiN4/Wa+OY0xzPrI3B4ohJUbrWr6HVmsWRMc3NIAM8WJi/mvLazjepwGw8KnPNvmah6N7NKkVFdy4+IhlQ/V6w2ObHHMK9x6HAC3CyCY1tFboCHbQrsqoIbI533rSgJ+e/9URf1GqCUueL3Wppm+URgmNTT0QG8NOU/06Ae5cTRQMv8inE5FKOKzWP2gh7KrEJQfmHYkxBjUY19hnTuG0/vJFjwcth5xRjt51l9nl8Q6hTEotwGnAZPE3fMLjlo5hOaNmtlU+2vowj1zYLVf8SAZuiNC2Qybtyfoi/VRB6jqu8xvHOQBSPLq7nwv0JSx6dr/Q8teIgKkCiY7TwU5EDVImbO06h5ARKo6XLcYMAOg+ouZjrXEOelamH0ak3w003uUdhu4MueU3HX87wI9cnrp58eoCtnO9yAVJL5MtYIe1BFg+s5jT4tBOJSfLrUrD47N07lei6nrbSt/Zc7NPbGScUik3hmdMd9yGCA52M2jInQEbW3Pey2CJZMzcvJfNaU0M+6A/JC66ruTkhA2DDt98HnJ+Mlfv78DIG/QXmgI0Mp82h0tiIJ813Ro8StPmCP7JVqjdDkfHirkS5z7Zk/P+3BQpekTGYiN2wyyrKtRKYWQi7T308ITbVfY62DP4T/tFRCgZVyj26Dkn5TNbSCt8CG3A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39850400004)(366004)(451199018)(86362001)(2616005)(186003)(1076003)(6506007)(6512007)(26005)(15650500001)(6666004)(38100700002)(38350700002)(2906002)(7416002)(8936002)(5660300002)(41300700001)(8676002)(6486002)(4326008)(478600001)(66556008)(66946007)(66476007)(316002)(52116002)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fkXTC15KD5Yq3QdWi+xtYHxaeViMpMjBv8fECk82QaMK/y3Yhi5KGg+rnlRG?=
 =?us-ascii?Q?4QpKqHV0sWPBPCiyTUxeFblSFf3Al4LbmjF92q/hPepQUQ7hqGM8Egndy6Ba?=
 =?us-ascii?Q?QxuNcj/CPDPr+YaOatss/D7gZZYJ2B1Z2kyMWgGWTqISEeVU2lS8ypFZS5mD?=
 =?us-ascii?Q?Py6EktsGMEc7SAz6jgp5UrJJkCF+Nrn8ZAB7OudigBW8nu2X0ih2P2NaXdrB?=
 =?us-ascii?Q?3uab3ldF/KCpmpoSOcQpnmmf0dBx4zBwDYgmcN/9GbNFPL0RIjE8Sivt4YVO?=
 =?us-ascii?Q?faBkFO9aZYGcJwOYx+DgkCFuNma3GfPmVhnro1G4KHr/rEtdQzNjRGvY2ssp?=
 =?us-ascii?Q?5yjQXBhmtusA9LWYk4N0oOsb3kSiVVSJfsgWTgE5/sBfP+64BPxnNNbPgjQ4?=
 =?us-ascii?Q?ei0j/trUBx9Go0fN5B7rYgNlrvmeFhK85Xyd9V5o+2p3F/rctNYxxP8kHWD6?=
 =?us-ascii?Q?PtbC7XYHX/PCuh0SrOA5hP6uCOItk7mjrmOWb06XnS/ktgNdEr9bDaniL8ct?=
 =?us-ascii?Q?v2bFunpLXGEATqB5f5LgN4ZcyGQBcMLhfsix946lxC3+NqhoVpCgN8Ho+zeG?=
 =?us-ascii?Q?dmrzp9a8J4s+UoJfMSGOt968R/0MuNWK/2J6+gGJTyaoB91z26VLFNiaWpL9?=
 =?us-ascii?Q?Dgo6PV88cmbNLW89LGtqVt7L12uls+HnW/z/tiGxnVjjRmMZ278bCKq//fJ7?=
 =?us-ascii?Q?gsbQXsvwWzsaXyFepySl2pJoArErVquSJSydO0ee83jT6sRA3KjuftAQdm3P?=
 =?us-ascii?Q?xrBVbYc0yNoWH691BI7EHvxTS0fpbbyacv0D2YJiUuvOMnblzPf5k8jiG6y6?=
 =?us-ascii?Q?JPoVmeRJQCgKIwb6/o1i8vz9hjOCJGMJf2T0+SihZPY1lyidDuMC+a8hN30Z?=
 =?us-ascii?Q?CBvmxxj1voGeQq3RCrp81B1scpmWVR+H2pX+5kLfsLCWpnwuD3rzwuSa00vN?=
 =?us-ascii?Q?6zDrn+aTOa/EURE5JOBWM657RPGGSsAZp2myPOY8a88GsiN0OFJPyynUJi5e?=
 =?us-ascii?Q?e7yZNzQwSI9hJKjTLeuX8+ww4XizWbQwzeY7DuZixopvKI6px9SZ9FxYyMM/?=
 =?us-ascii?Q?sB5Q4QsiUkFMBhPsYKqZ532UhB/j3Z9QoCXWmnT1XKw8a49GwEuJgw2EoQ9o?=
 =?us-ascii?Q?Mmcv90aUI1aXjPePwOH1jq+c+lA7fXEHV1g2l/3Ei5yuNs4qDkYOcIp/96Uz?=
 =?us-ascii?Q?Vg+uphl29ZQCCu2OgkzAZpyqZTr1yiapiI+2VC/+RoFHvyfuuOCTvHcbBlb/?=
 =?us-ascii?Q?siKu1EAbq9P4S+ZZRU2iqH54HDjoAnqzXOUzcVXDeRk2amCTdTHZ894O8hUW?=
 =?us-ascii?Q?lfKnHP72YmTKUhKf6ffMYcyV/sxHk9Afiuv1GxZyQLWDCBiOez/HcdmH8/Wj?=
 =?us-ascii?Q?l8rc6tED5nguhm4e6krndFL7B058wAa+SbN+df4COHnln0OGHjjC2u8gW5ik?=
 =?us-ascii?Q?NnaHSnRaTsGKkwuDI5XwNcHf/eBsCaorKP5yxh28ur2kE/BePKwhy7GrIiNL?=
 =?us-ascii?Q?Oapu8ifESujmRR9NrMSJpIzYr2J9ePFcuh4Uwqx/yLAr9qsCIacP7q77mAQc?=
 =?us-ascii?Q?+7wCYo0/mBWoaVXxaIpUpxAubNOHFyuzcQFA2ns3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c57605-d0ca-486f-6c71-08db2870169a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2023 11:50:08.6223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXcX7wS9fNActRPIm2OwUg0lH94ZH0WjFA/nYt89+Vj/jdPefHfTdVqdmg0URB23i0akWR7h0p3TGVWcrHmODg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10075
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Update usb compatible per binding doc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 31f4548f85cf..719e38223bef 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1198,7 +1198,7 @@ imx8mm_mipi_csi_out: endpoint {
 			};
 
 			usbotg1: usb@32e40000 {
-				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
+				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 				reg = <0x32e40000 0x200>;
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
@@ -1212,13 +1212,14 @@ usbotg1: usb@32e40000 {
 			};
 
 			usbmisc1: usbmisc@32e40200 {
-				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc";
+				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
+					     "fsl,imx6q-usbmisc";
 				#index-cells = <1>;
 				reg = <0x32e40200 0x200>;
 			};
 
 			usbotg2: usb@32e50000 {
-				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
+				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
 				reg = <0x32e50000 0x200>;
 				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
@@ -1232,7 +1233,8 @@ usbotg2: usb@32e50000 {
 			};
 
 			usbmisc2: usbmisc@32e50200 {
-				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc";
+				compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
+					     "fsl,imx6q-usbmisc";
 				#index-cells = <1>;
 				reg = <0x32e50200 0x200>;
 			};
-- 
2.37.1

