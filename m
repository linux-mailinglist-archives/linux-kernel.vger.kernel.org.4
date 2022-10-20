Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2377F605C05
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiJTKQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbiJTKQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:16:11 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60068.outbound.protection.outlook.com [40.107.6.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883C7179399;
        Thu, 20 Oct 2022 03:16:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9rzcWLZ/s1veKY17kjke/kErv5zAc6WPU3tnix4MUfpRQIgXN5TKcDf6hjuPwZa77WtPCgIZn9xGIsMvYf5aF0UiHhWGwLdj2MJDnLOpFeCAJO9jH16eFNbafqKXfebNbXEfpZerE/SCVLOTeN3bXVxq5yiFa0h5J20mF+K7BfwYAH5GoL1TFSPItjFHk88RPD9LYxpqGhVQB9zZ+1gevUj+ajl0MlCqs5F2RFeW7i9YAHNk/O+uxsiTeLhe/CNxuspVYA9B6IHmaZEd5bomRV/wrcmTvqAdg/rCxMEzAdrrechn2JL1l9ImSyVIY5R5jpES62JBIfAcyrEtTIoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfogty6HgNnM5PKaqdOFZa8IPLgQNz1AyI+tPhhn/Fg=;
 b=jJLBn/bvj1UXEteGG1KAlQ/9z2Xl7w3Bb4wVNfCRTfJTvYfb8UlyNex6Kot/R2tzIsFYyTHIdBXyBrg6EpnLHryktY2Mo3X8zQNG55SxZDE49pLCrWHyJuKzYCFdUDZ/1RbyiSA4JHiNJpUsBWsVdP60IpQGjI/i9TfPeY5q1Lftq1dzYgyZzguCvxC8ZCGqWFQzkpFSa8D2gJgy/PhA+8FolIQ7uYLB2KmwF+b+oaiW3gnMxC/d8r+JhKHjMGioNb3vw1GW1eivy9yVKNO2FeCye+JVflon2/r9+iHHJdEdNtcS5vLpZduDFJboFq6zBHGX5MVASH46iZmvUmMp4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfogty6HgNnM5PKaqdOFZa8IPLgQNz1AyI+tPhhn/Fg=;
 b=gd5csnDI3DuKhK4dU0irWmTAoZ8y5VrimyV4TMBGBwMiC9pOWLVXpg4ewRAQ1F2Yz9X6hnWtOLASTS29oFsaiuAOYdPdrPB/2rdDa7ZPBw33+HipbHpSkhN5R8d818bX008XXEnB/8SWlshYCWkVzuMe7jRorRHEpl+OWwueFDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.28; Thu, 20 Oct
 2022 10:16:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 10:16:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 7/7] arm64: dts: imx93: add tpm nodes
Date:   Thu, 20 Oct 2022 18:17:02 +0800
Message-Id: <20221020101702.1867188-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 832e8eeb-7515-4086-f67f-08dab2841a71
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j4StzvqYH/0XTMh/1uUWqBLTkNxvGKbepsj52dC6ESVqJiTu9VFiSElXebJ5Tz4lPgkMTci8Wmo/RWWj9GsLLW/LQdN9msVs9hepl85zuxNjC9Vm32Yfvv3WWU0BbJt59T/qDfKb+Y0iLv5m/DjHZGQJdCxZ6gvyGBekQryIl3UqSFk3TD3pXlwYrlDDsdE0Ev7YnyOqmoDybcG2XPlvpRXfuXT76k757MQdHD2QXcIZ4XpH14B3T4/MJLEoyk/nF0c+RD1N7MzFRGf1IMpCInpNyVSC81fGUUecYA40H5WXyMN1KzG/tqEKj9UdJ5gDhxfq3o1slCjims7j5w5HhYS48J761PBFyMde9Evc/Drz324zUha5Hucon9mcOWj7rxrUkFTKKoyOABO8N+hiQxV7AeooXhIhVDqhW0pLHO+JAKNW7OepSY5N8KJIahTePc/3mAzL0zgC4rjjRLQebUUWSka+FpigE3o9rK0PoZSBHxQN5z2MuLpTOPg/mujcjVzcskjDxFsKVfjG9GqrmZ0qbQtGPiU23XQ+yC3Ze4w17ZrSOl3k1Vv29FZXkNCxNBgtC/OfsqAXlNPhi3br4h6GBEmRHugMqF4avONWk5/xA/7dZhalqaR7rkLoOq3LZbDDXlVfjDCWFKU6nevLadv1Ynef9Vp3V60EgZm/1cgTFRdf+K2biVbM5qqYSjmL2VgJWyTRVG10ZvXWr+j3FTft4MtsVQmWqTJNcy+FvldQakPBREvAEqOLx4h+wrceygGdADjvvDmP/9KjliLIrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199015)(83380400001)(2616005)(186003)(26005)(86362001)(38350700002)(38100700002)(5660300002)(1076003)(4326008)(66556008)(8936002)(6666004)(41300700001)(316002)(52116002)(6506007)(6512007)(478600001)(6486002)(66946007)(66476007)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OyZyM+WqUKUYGsMwceZZ3B6pVi0PayR83IWB9OE/t7mxOEiPYCs2eX7P2f8o?=
 =?us-ascii?Q?5YTrZ4ZDodJUtim7lAGxL9ol64RYosxKg5i0iN1NDtoFeTxNHd6d8V8X2W0N?=
 =?us-ascii?Q?N6c8RHoVHKFuZ/r6HqMzORteEaNS/Tqck9yS/EidJr1gXSxNqD4Xi01eASF/?=
 =?us-ascii?Q?IRPWw9pInH5qzV0KaEButCZGjh8vui24A6u4WohOxL75u3BMw0SysuCzH/NS?=
 =?us-ascii?Q?Bh2B7jgejerfgq7qsWUUhebD+kdajvIWovWjly17QM3LmFfMkAgGGRmWpeJG?=
 =?us-ascii?Q?7mYLLJzYmYWMUhC6DzdyGdWu4V2XxiHsCC7Q92YKc5CrapROBVr2Otw4FFrh?=
 =?us-ascii?Q?dJAh5r7KUva84MzWGUqTM3TiUxXkt3fk+xZiKKXCBdOlzLwCM1OfxMxhAP46?=
 =?us-ascii?Q?5eVwxgPc+bWuEEJEmno8zo+SjUkE3px9oq3qdWvxDKY2D3pTMt1jD7RvrH6h?=
 =?us-ascii?Q?SCTdjDvPJauICdzuRiEZ9ovI9FozKus6hR9j26ceWNuE8ClddCvmG7w6F0jr?=
 =?us-ascii?Q?RT8km0dLzEyKvoUXS7RcgiYh6meJ+dn2LR2dhiCraAJf/NvO9Y89XnTNTYo3?=
 =?us-ascii?Q?FAZRl4vevkgSc0G2daL2MQr47MuVfePdv1VcZ3DimZsngAFZV3f4HItKoA9F?=
 =?us-ascii?Q?nALYerUOZB7ylxyWxWmwcpAqevNxZG9JhgPSnQx28fRL7mFjvW4rVwfC6GMb?=
 =?us-ascii?Q?rxtxHffWLko7/G521oVhLR1b9OHVdi1xjdDITf6yjhLMCnniM7mHM+eGuAHD?=
 =?us-ascii?Q?F0U0BSZb0dVndxQGOGEL3pVXmZ5BGXtNcPWZZEL8cCyuBAv6Q0058M8f4F+k?=
 =?us-ascii?Q?K+dprVVFKClOtuUNrRt9dQCFe49WpvxuCwv7FmNS2ANohi9jnyzHrxJU6ucw?=
 =?us-ascii?Q?RcjxPTZsO1oSI1R+4ZF1Bry5HiF1tSRWcXgmjY17mXkBMCnmCYWSeuXcTN5W?=
 =?us-ascii?Q?tMidxm6ArkmwWUkGiiV9p/4hQLNhoRyxNpqn66TkqTaT2Kna2F4Jj+B2zgAK?=
 =?us-ascii?Q?B5d1DU4NqaVul0ky763GdGH1iPNlyZy3JcfshQ/AgPJXXyBJxoDPLyJFDbzz?=
 =?us-ascii?Q?p/+Z3VyvaEoCfZZh9ZPhqS7ygV/yc3pLeqc71BDiH235DYC+wD5+vjy+L/rg?=
 =?us-ascii?Q?BQ7jVmaokYbwAWg6hLcWzjebm9vmY13zhXGh2eFCvfvsqZ96pD5/rMNdswfp?=
 =?us-ascii?Q?1zjPuBQLdktBp2HE1Z+x/VCgjYvzMv04FKbQ2caX/KsHiJAJWfjox9wfAcLq?=
 =?us-ascii?Q?S2eQjldKJB5kzS/oXtqM74fKNazjcuOUd+NBKoT60w1N3NFFcByvdgsyrlGu?=
 =?us-ascii?Q?U3nhp8CmaCN8TcAQeLUiBde1HfZcHW4bxO6Fq3rRwwfIqbrrHIyXRJiSegpH?=
 =?us-ascii?Q?ZWgHdLLmVjQH4zJNJYmzTyw5e3/volsTY/FqUNr+CdyJCjCQDspuFJjN4nPA?=
 =?us-ascii?Q?qtk1B4ZiToFSPq6gVNzxYSd6DNJ2KEDnxry/Q9gFYdEqtWlKI3Irj40Vb6Mx?=
 =?us-ascii?Q?FK5rFb9qCkczsP4oF82mn0TKsyOd7QHq63rPDQTywNSc0XlWMKhZ0sIHtLgT?=
 =?us-ascii?Q?/ibmdx013fclA2GFPVl0gz0doPbOmpbgt3pj6717?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832e8eeb-7515-4086-f67f-08dab2841a71
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:16:07.8748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UVuwljhqd1gh0DR0f8yiu8MhjFeBoAws7An8P9cRNRt6Pu34dqceWr8XY/NE3JpjTHInn1V/h/LpDdtMzEJlg==
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

Add tpm[2,4-6] node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index f67fa992a5d3..5d79663b3b84 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -153,6 +153,14 @@ system_counter: timer@44290000 {
 				nxp,no-divider;
 			};
 
+			tpm2: pwm@44320000 {
+				compatible = "fsl,imx7ulp-pwm";
+				reg = <0x44320000 0x10000>;
+				clocks = <&clk IMX93_CLK_TPM2_GATE>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			lpi2c1: i2c@44340000 {
 				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
 				reg = <0x44340000 0x10000>;
@@ -281,6 +289,30 @@ mu2: mailbox@42440000 {
 				status = "disabled";
 			};
 
+			tpm4: pwm@424f0000 {
+				compatible = "fsl,imx7ulp-pwm";
+				reg = <0x424f0000 0x10000>;
+				clocks = <&clk IMX93_CLK_TPM4_GATE>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			tpm5: pwm@42500000 {
+				compatible = "fsl,imx7ulp-pwm";
+				reg = <0x42500000 0x10000>;
+				clocks = <&clk IMX93_CLK_TPM5_GATE>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
+			tpm6: pwm@42510000 {
+				compatible = "fsl,imx7ulp-pwm";
+				reg = <0x42510000 0x10000>;
+				clocks = <&clk IMX93_CLK_TPM6_GATE>;
+				#pwm-cells = <3>;
+				status = "disabled";
+			};
+
 			lpi2c3: i2c@42530000 {
 				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
 				reg = <0x42530000 0x10000>;
-- 
2.37.1

