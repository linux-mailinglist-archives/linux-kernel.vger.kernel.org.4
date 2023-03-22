Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780376C4214
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCVFV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCVFVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:21:23 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2050.outbound.protection.outlook.com [40.107.22.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17312311A;
        Tue, 21 Mar 2023 22:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBcu3ZUt1deAOBOeAbuKSYmYCUd/lkkCAt535Pgv+co6P/LVj2yHvlp3ZpNUDBSgq5b4p8QZLfFNovzxZ+5aVjkJoYMu3rnDRWn1tuu6QrSbgGtR3yrfxGN/+0ArMSJxD+MSnAKMCAqv/R9aSmUDZBLer96JVq6Kom4hL8Xi6f6ZGToyHONSKW2d0n2Swmj1RN4BUnophkENe5l58KRq/XZk6P8eK+WjZJU0n+QoVr4al4c4N/IJAYUq3ing9lkHDdTQH6abdC6rvvjvyaaeR0lJp+83ToOBHPhqIqu2wCaQeP2sExmGhZimfAFa/8H4yz1loy87d45q9L6ithtkUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51+SX6PXCPRgE0dgckvFecLhC7yvksaMGDKwLdd6Xc8=;
 b=RgS5YIkJb1ByuiUfs6hbuVq1EfnwvDsRKvyEzcnU8d5Y8oso34TPcFawgZKhdvfDrPD+dVA4vVmZwzpoeXd+9tR83TiK3mSn7o9M/QMBtyRQUg6HaLYHHSc49JjnAmq9poXto83eP6Tb7Qz9tKkjvPzZsn3uG/A0g8CZLrj6TyhX5w5IqexseXE+iH4ypsb0Q752tVPP9YJSYSu2PALYbYLfhC3BVHGY0LFJdeR1OUqHks9ofMcsBqTsulTvRZNr1NRLvdY8fvX8Fwj4OSrtm8SGlWC1mkxCEyQCieUZ7d8LQdnguanP35tVY0Li3DDcy6ZwiAa4IbQG7CZMaGrfCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51+SX6PXCPRgE0dgckvFecLhC7yvksaMGDKwLdd6Xc8=;
 b=N/udc9zEhrhgWo7j5CmzMAVDod+navWDkh3RFywQgplWg11E+Kqad/Z2HcmOaeOg3VODUg9GD2OiLsDvNMXSV87v/yDJhWaMDUg46Yqnjfa6h5fhAE2RUS2LFKfmyU2oeC079DjzEV2wGu3NOq45eToMq7uerW4dd5tshqLkxd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6819.eurprd04.prod.outlook.com (2603:10a6:208:17f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 05:20:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::f55a:cf12:da08:6d2a%7]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 05:20:24 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, xu.yang_2@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jun.li@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V7 05/10] arm64: dts: imx8mm: update usb compatible
Date:   Wed, 22 Mar 2023 13:24:59 +0800
Message-Id: <20230322052504.2629429-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
References: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d6def5-292b-4007-5edf-08db2a952381
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lo/ZAZotcCXyJi5x8uJz2dpaV5jhrSjKSnExij+iVi/SdSTBejm86LmxmfHXJ7XnkcO/qiNczZOeEyRf0Cq2NxEL2FLkhgyGwdAL4oKq3IonlKJS1wIMzi9J4THS9n46H3XZ5qX8UlWjF+S3JTWffGn4Z+m0UfuaKnkx8o2C08x2noP23kNIqpBFLlLXE0I+TYWP0yxPiLsObfFaue3d4w+YAUA0cFD6vVMdJIMbNValN9Rw4UhrRqaisO8oTx2O4Z/mHBZ6v1LpuGU/nWxgBCeNCDb3XK6sYbwAoX3Ua+in7AemDyTYbKskFDnGFr4qjRm95PaKKoNHKtCVgEtwqrOqhYR8aHph9jmPAjTWNgvDyb7z65UPwMkLdt7Y+WUG/mgBAZniREZH2B+AFMud6ymvVznickETpa+zE0elcskc/jcsM+Qjp1+cVbNGNfOHKSLyqXAryM83Xp1B1H8jKsywlRPNzDRg5gd1DuIo2MMC3gPli+CvgFqXe/pX1A5huH6M+XkF215As/SKae0O5E36PM+jSVzWoYmcWLXRe2UYxXeyEHKH8tMJ6Bv4vk+SljEMGwGsBUrGu3c7khQOmw313vnrgVVt6sA3hIfOskq+7EVA2hxMT/JGiH+lxfyQspUMvBS3QbzovC1IppSt2iIuye1DkuNxZ8iMNfxVwQbO8rVdALu3PtrFKkvV77VEglzhCFGqL6VXFG/cbAuu0ohlZb2nhbxJ2foQzSYcuyM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199018)(52116002)(2616005)(186003)(6486002)(4326008)(83380400001)(478600001)(6666004)(15650500001)(1076003)(66476007)(316002)(66946007)(8676002)(66556008)(6506007)(6512007)(26005)(41300700001)(8936002)(5660300002)(7416002)(38350700002)(2906002)(38100700002)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eUHAOGDSEm6TVRzIbEXVxy63KVyd9gU6IoPWslo+ffkQrBErZuyjL/1SeWkw?=
 =?us-ascii?Q?PRmceVAupjaF5BT4RKT9UIKOh5BHUGjb4Kr/Q8ChPPZBMoGoutH4UrRk0/EN?=
 =?us-ascii?Q?YJkNQk2XyUzhDy08w74BG5HwAd0sWMfrP+0Am3cCJCJ6kKkkIZceI5v6XO9D?=
 =?us-ascii?Q?+xS1IqWw+RK/w01lW+O0ekmq7W1uAJ3GONxVvmkmS2UZ47TYw+QQfG4rWOtV?=
 =?us-ascii?Q?Ea5s6Fr5/2XTqmwdCQLNLtPI/MQRI/Zq5OHPAJ5jwQ1jRbicsxxd2YRwtomk?=
 =?us-ascii?Q?oFl1zedWNXsdcba4RPn7X7nz+JWPPt/jaEIWyFz7g5L3fP3E6jdGZGYrkxlw?=
 =?us-ascii?Q?ZSMyCAZv6dj4m5qPmZNIJzUDXcSCnAh6ptRPbdUEGAdfb65BnJRI/Ys6eMIX?=
 =?us-ascii?Q?2Du7sVtv5i7SONBDbzmhQx6jJz/9GEudxINjR3RGAULA1nwsWLX0qV3867K/?=
 =?us-ascii?Q?BEnrYnYLdPIKBn0kmx/0ojGV1My5HxPuaIysZzUI8AcgoiOgP3xhbspCUvJM?=
 =?us-ascii?Q?QLbg8WyToROg5fyRW84toKM5bxy7pV4172PBjM8/azkBEsW92ankIVQrOxGC?=
 =?us-ascii?Q?ByN9aSroIT4C171PTFByL8/dkecq+uLy006YFI8AkewlbTJwITfRsqExKga+?=
 =?us-ascii?Q?epxk1aNXmiikx4uHwH5iX1FZ8S334niSkoYlSNqBWeEQmBSNmk4fxVx/tVky?=
 =?us-ascii?Q?Z66bIX1jn7azsShj87quZo9NP08NwP8QHDHKP7M2FfVbs6pn470SHigZ+Dwp?=
 =?us-ascii?Q?O19pJxHEYDfIlNT+HRxUaHzBG4qO0vNfw7dpTdktQB4XNpewcxhzThL3ujWx?=
 =?us-ascii?Q?FGT24kaHTWIeygnoWHWtbeVT1MPRHdpU2aTzQUpLUgFa+fYy5ucjpjJo/jBQ?=
 =?us-ascii?Q?YrjfIT+dRBtMtjSftnFlEPziuBuyoKUagnN57sPQdsol5PXSl5D+x0JZHUKn?=
 =?us-ascii?Q?oVgEFGASR5tqXCUvnr7ITQBdFBi0xrRxsWQXvrG6Zsa5V+EaH2iAqQTsfHzx?=
 =?us-ascii?Q?7cYXuBpRjH6XcuYA/wcmkqtBQQwW3gNfBMcGSwyEAe89vN+gAs6DAC6juKxx?=
 =?us-ascii?Q?8dOtnMAuX5ubE8KKv17TMi8adsCuGtmaZLEuW6l6caqKlI16j0QRw56zozt4?=
 =?us-ascii?Q?VFlcjhSF+tHdZLYWCDPpOJdu7nqkQjuiN98kOIoUggxXxNmpdbASiLeG00vO?=
 =?us-ascii?Q?ku+AdcH9POreuVWQWQnq7zGYhoO1q7Zn3S+S6Gj4HDIwVurQ/zmUBcNCF1Y6?=
 =?us-ascii?Q?d6j3h1KVevt3HsI/XiPcx4Y/cpj9/dW9Sf18ViyNAQiexlcaz+h2JZRTc1Lo?=
 =?us-ascii?Q?4Ca9sLXI18q+nvi5tcDn3zciJha0omLje4tDEYTQ+vpND/UNzbP3GqoEHibE?=
 =?us-ascii?Q?4MOKzORkk//amuTvm1WLUdRdE45ZDwofOppHx9Lt9owLDaAvLHsyQW8ivL5F?=
 =?us-ascii?Q?ry5+Z+X+OmJ2Hu93SCJuBOyYYR9AY6edzD7ZYIow+DLGhG3Ftf+zUEcE3asZ?=
 =?us-ascii?Q?dAo02hSp+R6yMEa+/zteb/J4RWeLujNEz2eQ+82EhQVO1B7OPoLDWvr5nedL?=
 =?us-ascii?Q?4+l2Ju9Mbn5tSURJQQd4b1o6LeyFvZxnEvLU/I29?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d6def5-292b-4007-5edf-08db2a952381
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 05:20:23.9275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icFuE/rvVZuPRqtHZSNc7zhb3mpBJgeytA8kFQ5desqcBBTAes8Sic29YJ1VbvRxAwZheoi2LQI2eBFjBjDhow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6819
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index a9552867e547..e311da7e87bd 100644
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

