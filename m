Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6079D6FD946
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 10:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbjEJI10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 04:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236548AbjEJI1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 04:27:13 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AC36189;
        Wed, 10 May 2023 01:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFBTPUzR38WMJ5ejkCaAj1cHzKrHboKf8NZ+VAP9jg9XHHugH56sYF1tIhWlNdzOmwGASafiekN4KbirybDwubOIqc+1u9J0A8SloCP25IX8dyKaVVZeBX/4JRU22AycgI4HVtnUIetLihKFrLOlBjKJKM8NliJ4r9d0aMnYRXZtZoGlSspasJV3XBaUZJjOsaBxZXWoI8DJaDYVRUsZ4v3fUtALbmXHKcZAaNjnoxLu7HSykAPotZJZ7hUSGml/tMM8RPP6C+KBf1DGfgvNtxuPn0XSxZGOh1FCeyJGQFzYKAQYzzK0nsv8/bjxXpO04SQrLHISGPEbJGDGiCSbFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRYdhnCiZ/JqpVucIyKmK5jhzzMrWF1tiSdz2jZHTfo=;
 b=n4vD4toLUSCqkPl297oIO4IK86lmGhuyVTe4nnQKLLP9wB3tz1ptTmpYRSJGuB0t1QUG1J5GTZZtvLvBl54T8X08/bDXHi26QL6liNFq7DCBOrarrEc6i6SytKrrx07K4l8FrkA83zA7e5uG/MaTQbE7jPSllxVh/5eR+gEeOagLxf9GI0ajJg4C7AHX8SqSyWIa/6FZI8ms6ArIoNXdppDqPAYIsA/CE0vh+Cr79EtUtceVBRg4QbgBXuxCX2iTBlhIafKdqjzXkeN4DBfIcbL8AhdcrNejYMeqZsHhPvRPLLS+0lTSO3azZcihIXrEQY8ZSXeQL1SZc6xG2SGrRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRYdhnCiZ/JqpVucIyKmK5jhzzMrWF1tiSdz2jZHTfo=;
 b=ESqhDEZM8G1z5ZoXb9qpeBtYIeajXFJoXOPms+KAXJuhoYioFVBYWYhmJePT68xZnFsPp+OeRkZtAy1BbgKN6P7/U3r72dPwz2wsfHYHe2YlllccK9b/t7DXqL2JJcCwwR5qhcrqOnRt31L5Vt0x6L27iAaGRUvUlgGRgHI0aqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9368.eurprd04.prod.outlook.com (2603:10a6:102:2ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 08:27:06 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%4]) with mapi id 15.20.6363.032; Wed, 10 May 2023
 08:27:06 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/5] arm64: dts: imx93: reorder device nodes
Date:   Wed, 10 May 2023 16:31:51 +0800
Message-Id: <20230510083153.3769140-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230510083153.3769140-1-peng.fan@oss.nxp.com>
References: <20230510083153.3769140-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9368:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc99aa9-d7e0-4a02-13aa-08db51305722
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3PwjHRL9pIc6h+3GNT8DrIix5QkOztsNcDM+AANee4jAirZm+Jj2l/XNSqESv/vO+DkduiAORKYaJpOHoPfbPGMmosB5uEH4PAtK9eqQtAkrsxsVOFzV3K7nc7Su954/0kAZhocw5HL4AQF8r96Yii8Y5XkJg7lb+dFHDOYgkJL8YMtZTFSrgAK6vTNtN0PcgDXsSbenEgxl+t3tHH6SGxPq//jPKiBe5wHxvyX9yslhw4gVubFCnmcdrVJdPfCzHLsS74S2gJp0XpiuI8fyinsldwZEgb4Arxx2JsjLuznlfwl90fI0YD/xSl4tvCLH3nbEzHken1jncNsg6QSGw0eKAv/MG9FIHOfd6stKbf6A6OyhDoNV4gYXro+fpLz6qlhaE2BB7yBh0Q1L8xq5E4QmnpdUa2YqfXXTGq0Gj4HDY2y4SlVG1T0We1Npys4wp0hzkMWP7OOF62wP2tN5kDMPBcvmiPO0Xt1p5oELH55twbqCM7hC1f1XyGvFQGw/GU2xUhtDKKqt0IAmJ7arwL6SRMGaRsgVTmUzeNHVOlZNYt7mbeAOlS6Oaof1d34IMQnWb5Oh2kNJRECfud7/lvQylcJcLLMNRjlpLvVLEzLELrtyK/1a8rB7sV9HQVJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(38100700002)(38350700002)(4326008)(8936002)(8676002)(83380400001)(2616005)(66476007)(66556008)(66946007)(316002)(41300700001)(6506007)(1076003)(26005)(6512007)(186003)(478600001)(86362001)(2906002)(6486002)(52116002)(6666004)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e3LLmHENhcn9G8Oc/beDOqJ+6MM8FfaLVKioLuePuSMr4WoFbgClLkF1KIDi?=
 =?us-ascii?Q?682CLuC4Y1XYHFhnSzd21IJ5Ax0R6gY5BQtJ9AaLlzwA2dqC6oUH0BZJrv2h?=
 =?us-ascii?Q?fa3IzJcBFfUxWOcowgXQw3UQ2PrLURBb5GEiecZcWSCa366LQl1zG9uhSQD5?=
 =?us-ascii?Q?9RE9xXXYclHSwznkzTSvrpLbokH68j8IGQegYXyj5RLSmtZJA++uN7kXD7J9?=
 =?us-ascii?Q?+0ngzS/PLF2WnBuAAAMC8EdEdtw9+nqzmKIY1cCT476ESUd0kI2fQKBoA3LE?=
 =?us-ascii?Q?7e3bJ4cqMnzA1QCRIEH2fwfeyF9Sm7RS+k570r4Y7NsFIadF8S1d99ofFrs9?=
 =?us-ascii?Q?bUdFIqrve23QDGB9PDSs09/S/DF2ccW+vXHqXChsr7tt3Ugvsb9KjP3Iwymn?=
 =?us-ascii?Q?nV7i3oiWzWaJq0s5GCsd6ZO1CXGVDEp1GAQaM+M4yzFyMkKXhg2kvhL9iJP4?=
 =?us-ascii?Q?ycsaa1vao1vPGFv9vqiphhJjFv/yed/4tBeYGT+MDqYrpI3sAFpCYS4fp+V7?=
 =?us-ascii?Q?/AQKdq1F4LGjzGbv9SLjWo5rN5GWmkUfCXbe/m/Cmq98+HfWh5WTfde7MMnb?=
 =?us-ascii?Q?WkXqZwbzkBNm842NuNj1g1JveDFoSEX5HLs02SaTt0nikiivE+DfbXDIPUjI?=
 =?us-ascii?Q?Ex0PgG+r8HEESpriAe8JQ+nnbDjjWInOImtOXjDIniAWImr5fGdObHGtsPMg?=
 =?us-ascii?Q?ThFyqHAvbA9CyA2v9IpuroVT+0MFvASL4O4GX3nMorOR61cjwopzHscAABrh?=
 =?us-ascii?Q?v1KatLJiEgCyxOCC8Eq4y3oLtfpd1H3SNy6D+Kjoeu1hYNACdcgf1w/IdRdE?=
 =?us-ascii?Q?Z/iAnKFhV6thmkPXvF74QSP1M6vKq7fvOwSIHYKzx2P7V7gzr50Ja+3nIKf9?=
 =?us-ascii?Q?ZUykv/fEnnpvxEmL+YcQ2Ue+b6wazgzdrlTs33VzsXlJcEmA/VjSkWtQy7Ox?=
 =?us-ascii?Q?wRfCTpIhxVKwxzBAZOoy3wZhbLJqiQF7GEIS71MuO8oQAvIaiNS9afg733DY?=
 =?us-ascii?Q?DTnM644KTCqi5CKl0ios8EpGJ8CIWyRVIPwXw+IJ0KTaeTAT5TaqXzT/JWi0?=
 =?us-ascii?Q?UngqcA0/XDzD2BqDTViU0ANS0hA6bpCWdf2EHJy6AeVCKShCu1th8CBnA+RA?=
 =?us-ascii?Q?r/pnKvYlleGXsdN+pvyD3jENr/NFsj0bTBargXsX7jVX2GMBlcLi4KMyI96S?=
 =?us-ascii?Q?0Rdohb1XFzF6mk5Jq1ZrMPP8zzN1JdoEKmQ6guynEv38LToGdfWu53CUWxl4?=
 =?us-ascii?Q?iN5K36DEWiYwL6EzW8AV1JqgeoONgXX+Dhl7DOSJFfmAjouQPkTYk19ziu7X?=
 =?us-ascii?Q?roznClNTxuPK5T7OZNN/uUSEXsWK9KTjI7fir0aFTk7v4Ydkbne45y/UIiSv?=
 =?us-ascii?Q?HKfRlyY76hsdWyYbUSRgICKB6OJON0zC0fWSDbFMZ3hESEiyqSBz4tEvXtpf?=
 =?us-ascii?Q?p42+zjGWenzEuCpQM8CFoSzreo6i3HSoalLRQyApWmMaY/H90d5Qh/vVd5Mq?=
 =?us-ascii?Q?q5KU+8bsuU4DRLlYk4r6CxNvCIegofwcyQOQK/G3mI47eevTC9kcdUXPYe7G?=
 =?us-ascii?Q?83lL4BK6jLld1COA5LA1824Pu18aHWygoBe3wedh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc99aa9-d7e0-4a02-13aa-08db51305722
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 08:27:06.8027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgHjJGNN8r5CyjOUsfjoEEBxBCVUU+ue3mJu5Mr3G1sW7k653tYzj0c9z10WHRXeadEKCvkj72ojUTSW5qHjQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9368
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Reorder device nodes per address
 - Move eqos node after fec node
 - Move mediamix node after mlmix node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 60 ++++++++++++------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8354d17a6a3f..5c5652ae4ee0 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -305,14 +305,6 @@ src: system-controller@44460000 {
 				#size-cells = <1>;
 				ranges;
 
-				mediamix: power-domain@44462400 {
-					compatible = "fsl,imx93-src-slice";
-					reg = <0x44462400 0x400>, <0x44465800 0x400>;
-					#power-domain-cells = <0>;
-					clocks = <&clk IMX93_CLK_MEDIA_AXI>,
-						 <&clk IMX93_CLK_MEDIA_APB>;
-				};
-
 				mlmix: power-domain@44461800 {
 					compatible = "fsl,imx93-src-slice";
 					reg = <0x44461800 0x400>, <0x44464800 0x400>;
@@ -320,6 +312,14 @@ mlmix: power-domain@44461800 {
 					clocks = <&clk IMX93_CLK_ML_APB>,
 						 <&clk IMX93_CLK_ML>;
 				};
+
+				mediamix: power-domain@44462400 {
+					compatible = "fsl,imx93-src-slice";
+					reg = <0x44462400 0x400>, <0x44465800 0x400>;
+					#power-domain-cells = <0>;
+					clocks = <&clk IMX93_CLK_MEDIA_AXI>,
+						 <&clk IMX93_CLK_MEDIA_APB>;
+				};
 			};
 
 			anatop: anatop@44480000 {
@@ -685,28 +685,6 @@ usdhc2: mmc@42860000 {
 				status = "disabled";
 			};
 
-			eqos: ethernet@428a0000 {
-				compatible = "nxp,imx93-dwmac-eqos", "snps,dwmac-5.10a";
-				reg = <0x428a0000 0x10000>;
-				interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
-					     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-names = "macirq", "eth_wake_irq";
-				clocks = <&clk IMX93_CLK_ENET_QOS_GATE>,
-					 <&clk IMX93_CLK_ENET_QOS_GATE>,
-					 <&clk IMX93_CLK_ENET_TIMER2>,
-					 <&clk IMX93_CLK_ENET>,
-					 <&clk IMX93_CLK_ENET_QOS_GATE>;
-				clock-names = "stmmaceth", "pclk", "ptp_ref", "tx", "mem";
-				assigned-clocks = <&clk IMX93_CLK_ENET_TIMER2>,
-						  <&clk IMX93_CLK_ENET>;
-				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
-							 <&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
-				assigned-clock-rates = <100000000>, <250000000>;
-				intf_mode = <&wakeupmix_gpr 0x28>;
-				snps,clk-csr = <0>;
-				status = "disabled";
-			};
-
 			fec: ethernet@42890000 {
 				compatible = "fsl,imx93-fec", "fsl,imx8mq-fec", "fsl,imx6sx-fec";
 				reg = <0x42890000 0x10000>;
@@ -733,6 +711,28 @@ fec: ethernet@42890000 {
 				status = "disabled";
 			};
 
+			eqos: ethernet@428a0000 {
+				compatible = "nxp,imx93-dwmac-eqos", "snps,dwmac-5.10a";
+				reg = <0x428a0000 0x10000>;
+				interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "macirq", "eth_wake_irq";
+				clocks = <&clk IMX93_CLK_ENET_QOS_GATE>,
+					 <&clk IMX93_CLK_ENET_QOS_GATE>,
+					 <&clk IMX93_CLK_ENET_TIMER2>,
+					 <&clk IMX93_CLK_ENET>,
+					 <&clk IMX93_CLK_ENET_QOS_GATE>;
+				clock-names = "stmmaceth", "pclk", "ptp_ref", "tx", "mem";
+				assigned-clocks = <&clk IMX93_CLK_ENET_TIMER2>,
+						  <&clk IMX93_CLK_ENET>;
+				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
+							 <&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
+				assigned-clock-rates = <100000000>, <250000000>;
+				intf_mode = <&wakeupmix_gpr 0x28>;
+				snps,clk-csr = <0>;
+				status = "disabled";
+			};
+
 			usdhc3: mmc@428b0000 {
 				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
 				reg = <0x428b0000 0x10000>;
-- 
2.37.1

