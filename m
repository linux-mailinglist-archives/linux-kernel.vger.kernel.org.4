Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7FC605C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiJTKQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiJTKQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:16:08 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60077.outbound.protection.outlook.com [40.107.6.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6522417FD5A;
        Thu, 20 Oct 2022 03:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjnSeRf6VPia0ANJNtjzPYXqh8teoFk3SSDAwfQr3bktUV/mYFT0FRSCYoJZ/RgIA/WZnT/WQavnNzcYPm9ZbRWXgbYvq1g5B+phcuBNQxMLQzLzDa0a8W3/D/oAtExVsYnvpsVUpTw8yKRDU724ABNz4PJBxDRdJZoCG9/HPtUmJanwL46FurL+oEkIArYypo/EFWpFOT6jB9ZihUgQKhOjYWzTPFEEsj9+w+OkfW2Gxyf2d3Ym5BJfOAz4ezEMIsWzvgreHUa80BQFwYUdiUDc2odMcZvM0sLVX4u8BU2+OpeqhseTIOyLuGZrMBL+t0/6dD4Pl6aZdhSIu2pNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9ntvb+nVXcrw4gNsJXMYK6gHQngysJTe6129y9nqN0=;
 b=F7onQ2fZ0tqegnrXXY4Ydi80G8AjgInLeY22dT9y4n95neg09YjK9p9B2/hOC56RWRxJhrHbhBTC3jyJrVNzVmsXHnSYRyHvxPILVdzs+exBQ16cubF6hix3nu1ad5+sqMw24AhDodJUu5GdMcZKAzLNIoSmRf1Ki7R+CrsGvb0+Y7feWLqUy+3C4inaRISnagfjmvpKZzFaO3BpnZesWRisVXSaV9MRoiljlHVQDXMGqeSDxbnsWX6lcNejH1gzYNhk4sXHBS3XL+Cq6xd3dpdBpoT6P3LTtwaNsgwua7Em5SYjsmV1a6F18OamxTyNSCqXj+7YHeoU9a2Tb3MO8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9ntvb+nVXcrw4gNsJXMYK6gHQngysJTe6129y9nqN0=;
 b=Kp4D3B8w0jzI1kMu/HWm2a5Ir/Ez9SdfLRfbTXkoSNmh0dwURcOLwcOKkH/v91cs85bs3ns9B0C9lK+OLjsp49HenecJdbcUY3rOeaXgPUCk1bUFltXX2iuvOXM7TsWi5T1VhjBvDxd7+yLQE4BwO/gu1Ycq1XZwHw5KaiG1jaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.28; Thu, 20 Oct
 2022 10:16:04 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 10:16:04 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/7] arm64: dts: imx93: add extra lpspi node
Date:   Thu, 20 Oct 2022 18:17:01 +0800
Message-Id: <20221020101702.1867188-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020101702.1867188-1-peng.fan@oss.nxp.com>
References: <20221020101702.1867188-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 184afc82-4e32-4422-a6d3-08dab2841854
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fj4zSIzQmcossxtS70Uc4fdvwgcyyY9RDRzPHlGrx9orDozNE+3SPSzvxMwVTqxu8ruRz6snTYYPHT1X5M0np6mTcEglHVYots6dXoWErduNjwbbd3fQTWGfFVMIPccSdf7WMSQF+5WHSuPjmWUfD1Gtb3yZw8f7oU5BdH19eiLwUAxPl84Wq91T5JsNXwvbfhVRz0gqtlLerKwoGX+E8Uq2VFfIBJcsahTde8ZT3dw97V2BToPV9cqqdNPFTYaTe47WMqn0S8MzWWm5kWDPf/ge9BnCpL4Bb/ZUkUFbYSyL/cud4lcLIQypvTPaisHc5TRPlKkdm2zP3jDywX/lwYO4Hro8OW2HIW0s8zmoUcMsnS4DK6z8vm1i+oukWCZgdZnSoiprCXdGGzAJO7IK+kK6YD4uNUnmdzgkIpfe27wKKhRihnaCH7BtZak4n/fWFZW1qnGYcv8uWQaLe8gzSv7kx1NWlQwF4Nq/WJ7Y9EZ+WnZZ53rqSi+HZYdXEa1ZwNtIQ1bjQV5XWco1DNCm7Cnwv4JnOrIEyjWEaTSixG2ISQifl+H+TuB1ARUh1lbC9Sf6iHeMwt8soJENJYLM5csuFjXgXudOks6ovU0kDw6BqEXdaZTM3QHbfRhgGzA870e5uZ0QHDP2/4gGxewtmQnh8M3NtzBSCxdsXI231Zv+J8ans+GbiQvLvYGB/hO05ZGQv2U2sELiI7RjRdO8SzIeDgZW4gp9YbLKwgKZIsVn9L6f7v3YPA786dLL/v217VgH76fkFYPckwcSZ+91lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199015)(83380400001)(2616005)(186003)(26005)(86362001)(38350700002)(38100700002)(5660300002)(1076003)(4326008)(66556008)(8936002)(6666004)(41300700001)(316002)(52116002)(6506007)(6512007)(478600001)(6486002)(66946007)(66476007)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w7amzw1c+ySd9PezdlkgWby9+I3E8ih0NpNIsq6Hq3Tasg0ls81wrcom6P6d?=
 =?us-ascii?Q?YyFUWwGllTnzC5B7ECZRRraKF5jYrpvzS0d4wCm86B3S5NtSSVlfN2xdqLS+?=
 =?us-ascii?Q?+MjwZ8sJQpRUBSM9jxMlyYClLhBOnu4VBpl8G7NksHZyht2uNv372FRdOno0?=
 =?us-ascii?Q?avYUoOTDXtponYzR+kP4H5q81/tQ2XJUZsmGySFsA3CwPfsjkLyfmpXUyGE4?=
 =?us-ascii?Q?+X4SQL80+ADH/BGKB4CTN8KdxxxPhaXyBVn8ui5f0uhNNSrx8AD4ChL/T+49?=
 =?us-ascii?Q?j33r4KPXUEotXXOYaUJHJsHhUqrFTFtyU+k78xC88A8Oy1uhojlA0fHIHYnj?=
 =?us-ascii?Q?4JWL9YpSUOfhPzP8f52Ncqn3oSSN1U+OLG/EZYlHM8vbuZoQjnOZaTFpZRFl?=
 =?us-ascii?Q?v8S3pDQ7MPoxTog2MG+jaEaiOrEYyDnRIFSgz6r02f8eAXOP2kWPZyTJ2pFo?=
 =?us-ascii?Q?K4/W7fVyVEXaKXVjlBkGC2cqDCLhWD57Y+NHLyZLfIjTcIvxiRuZN7JgaX50?=
 =?us-ascii?Q?gRUYLzpNUyRkrpf9se5OiubZGh5g6cVXmPBkUrTDUSL44QqVpZfHvJljTo9Z?=
 =?us-ascii?Q?tsvNL4BWD/0i0zWT4R2tlBg1JJNTP55dyaDB031OSk5dooY7qzXnMkqEL56b?=
 =?us-ascii?Q?FrRg3ZGqW13SbWNz/h53VzUB1e5e8fnHtQJQNA9Ywbj5P8dxjz61ZRcPtR5g?=
 =?us-ascii?Q?bJlqt41v5ogLyYNxeNXimnG07rNSJNEyrV8PjRirvSL8EnyHDHHQ5EPf+51X?=
 =?us-ascii?Q?5atPPeUOUowvg9sxNUlTQs7ZPi12GvdsDJiqQsAsWl86dtbaDLar0/q/Lhqo?=
 =?us-ascii?Q?ZPxyxNn1CSrMuXWw0uvS+JmYJb2853bBGPTJEJRe5fedYj1Vri5kTngFI5XF?=
 =?us-ascii?Q?d7Cs6VELFvhcYHExbCV0IIvvAZyJf6rhiIwaTp9TBLDDAt/5WgvCtbn8OqI+?=
 =?us-ascii?Q?C6ZHFcPhmjWy/tojbGAejA8Tq8FeESrO6qOAkjuALfjMeAdB5NlW3XLwNHyf?=
 =?us-ascii?Q?YvgPVJaaCrJ1JwAs790YsglcTsw9Zn8Wh0GL8qD3QURyrmxspxYMq8yPqShF?=
 =?us-ascii?Q?b+GmnWevPo4gWP1Is+B0mC4r8mMETegLvARcv1yauWgaD4vjL9iEXlOeocVZ?=
 =?us-ascii?Q?KByeJNTVxk8zjuH8BFWWNu4ogNoZBF8N9RwtC4gmBs5zibKePAY9ObdXi1BR?=
 =?us-ascii?Q?ddnpauHKYzMEsRxD8CAoAxsYc6rCm1WyDXpSJaA+B7gwdoA1JFU3TYzzy3nP?=
 =?us-ascii?Q?nacP3pwNDfLtZPsWwLe3oZ1Vzv17ji0MT4OtC6JVq3RjfO0WO66yWM1D2UVp?=
 =?us-ascii?Q?Ls66IFCy5mejXy8g8sYRonWsnqPeJ7E1vaQBWah6a58Ld0p65ITMzqCoNeUa?=
 =?us-ascii?Q?hpW8QeYnnTESVyBQjuy025eYnaT4IFQwvdzGeyYmq2yN/RTajn99AIoY5gUT?=
 =?us-ascii?Q?4gorrjaWbazFfXqbfw6HbYzXLOGP/OsDVrsfcCm/KQpym0FcS9Z4KUnMVcIr?=
 =?us-ascii?Q?8+d5YD3fSmdrv638ezR+66e+QVLv/QDr1IsaI2MeMM905pujxmd/r5hTMKsa?=
 =?us-ascii?Q?3ize1HHLkkMZnl6J4Q7BMt9Jh2VGUlA+KsJN06yV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184afc82-4e32-4422-a6d3-08dab2841854
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:16:04.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +h7qqKGT6m6KzsuPbb7s1onZTkuXJA6movjbb54T9c3Kv72CJXauHG+zD+8mYZaptwOxD3fJkp4W4qyYjRp1Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8429
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add more lpspi nodes which exist in i.MX93

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 72 ++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 092a6bdd0fea..f67fa992a5d3 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -301,6 +301,30 @@ lpi2c4: i2c@42540000 {
 				status = "disabled";
 			};
 
+			lpspi3: spi@42550000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
+				reg = <0x42550000 0x10000>;
+				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPSPI3_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpspi4: spi@42560000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
+				reg = <0x42560000 0x10000>;
+				interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPSPI4_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
 			lpuart3: serial@42570000 {
 				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x42570000 0x1000>;
@@ -395,6 +419,54 @@ lpi2c8: i2c@426e0000 {
 				status = "disabled";
 			};
 
+			lpspi5: spi@426f0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
+				reg = <0x426f0000 0x10000>;
+				interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPSPI5_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpspi6: spi@42700000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
+				reg = <0x42700000 0x10000>;
+				interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPSPI6_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpspi7: spi@42710000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
+				reg = <0x42710000 0x10000>;
+				interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPSPI7_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpspi8: spi@42720000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
+				reg = <0x42720000 0x10000>;
+				interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPSPI8_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
 		};
 
 		aips3: bus@42800000 {
-- 
2.37.1

