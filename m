Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B04C62941D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbiKOJRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237986AbiKOJQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:16:46 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFF62314B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:16:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LO5DnzhUXJ7Gz/9qBuQCs103DowjPqLyHVMthzTzoIRa/gc6P4zgi/RjtMSrlhYoCMDIznLemuKgUadGD7OrKgIn7LUaSUqNM26gJFdPwqyzaNVbe0Xvv9ttvccC6wz9kPqwHnF44FB3nsuRlrlmH7xSF/KOneafjEpa+PAazc+xnz53v2pK4lDnpsiG906g2C6MJcxH+yVRRrOzHj4k3Gq3b1k4YDPaWB2VMCwK97+RA2SyoCrLq623piWltWoc8Jkv1RDnQXjmgc0vMbC+j6sH9SceglHzr5PDDafoZwEDYamgkwrCEJQwjS1EE9SwGzh/t4r6htRG5rT8ohDJPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVZcr/S99xNnQtY1GSazp191cisvYVqNqs7IKEpic50=;
 b=bI28K85jD++WTEoa+pbNfw49wj3C5FzlSjD5pZvP04wa0wzjsf1ca5YUQJkkPYiPoMuJC6Ni2wrnxL0Dugqs/Ih438uiEJ2MzZfB5l99JTyQLeglfnod8vn26c0w2a8v9lZCXm5+wdmlz7Y1/Uy+6tYOMT2DtQxm+5XJx9Wl8ZJYWsiXc2EaVqEE/lJtMqrXjyKleCWpSyW0bh77WmhMqMt67JEbWaRUyGSRZxX3R/XkbuJb0QNzqlYIaoLj5VBgdvF7wu8prJgt+sPs/J9U6MT134psG2eHlKnR/o1vdCvS1PaeJjUNI6tIC6KSGpiu+a1YNmuasvtY26kv/XjcqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVZcr/S99xNnQtY1GSazp191cisvYVqNqs7IKEpic50=;
 b=YajtzyHZZQ6i5g4FkAflPk9akNDJTZLbZ2N5R5UTIoJ2hMY9jyFMpwSQJo/fgdDoKJPifyiTVEhZfWjr5ib49gtCP4SPMhCY2I4Atk9Zhxz/5Ja0jTULImM/H5Fe6oVK6eUDbZp1UPs7ScHcw2gxw6K4iKOPHzzthWyYSN/cDc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7899.eurprd04.prod.outlook.com (2603:10a6:10:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Tue, 15 Nov
 2022 09:16:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 09:16:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 10/12] arm64: dts: imx8mn-evk: enable uart1
Date:   Tue, 15 Nov 2022 17:17:07 +0800
Message-Id: <20221115091709.2865997-11-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: abcc3977-77a4-4764-b4b0-08dac6ea0e4e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zVV3zNNhxjilF/tysFB+E4doAvdABtmlErtlsm3AR2iqBcbyCTdm2LmTYnrifAVYFeD37vbHbgVSG3JiUh32pi3k5CJ8RN4WhESFWGuxpOdNrhjza7lAC+aHa/Pki2PO6zE5Jba64SeyyBk/SdKDSGSKewhaUoNltc6jAn+sw7GQre4iFjVzlbLRKVUNzMNEhxB9PjOyPNJhq7ow142vGFrvjkqSs0l6t2sdWdmaU9AwmhE/EloW7B2/j6RpAwlGK01RD4Fn0TieNq6eEamWRT5g1HLCS6gFbArPOd+Jy4hG108PwtjEfXUjIOI89gQUEThlhR5/KlPyMrLTtZCHegzKcswMDX+g1u04QfgM7ybEunsaaKdTeLy4As1gADLmwxXvJSTrZcaH17qKwy+BSlgadDXBmZHuZSknw9Wfd384CR/rFxzKbFQsxIvHTlaQ6APJ8NP3W7wdKU9r0GvC0GNtjMdf8H3mBipPg56xhEf2d7/eM9kfSP/zvBXuO2IqZr3Dy7LktsGgzOwlVqJ+wllgsFLCsxe3dUwMnbbBG7gwU2LqZcLSbKQ9qCYEpgLXcNEq0+Wy7QL6DDxJ4QXjeZWX69gEvQDPo1uyKbam42I+oPETNxEDhu86x3jBAZP95bMpmphVEVlnYxj7ojnIthuMyONqmcjlZFxM8XTRukKotM2skycO4CHfxdddFji5gc/H11bw01Yo8AgXSP6D8XLETDryJlu8bvwhdHkfkg9c0JqnXt6Vb4PeWiv0mbQAGh00YFSCwCBSR6chN8ZjIuSW8MqqYLfu1SgUIIGM++t2qFkJwBErtsL4VtVb1Rt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199015)(1076003)(52116002)(6506007)(6666004)(186003)(478600001)(26005)(2616005)(6512007)(41300700001)(8936002)(5660300002)(66946007)(4326008)(66556008)(66476007)(2906002)(86362001)(6486002)(316002)(8676002)(38350700002)(83380400001)(38100700002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZMZxCgT8QfVYftl6NEUapEK/kDGZP+m8UFkxWxSlhFExyIQ67HUUp2VFdLkQ?=
 =?us-ascii?Q?r2QIxyw0biL13r8aDrgE7ygzDBVKzYGyG7FW4d7EvA/z6kO0qps1zuzwXWNc?=
 =?us-ascii?Q?yiw0rpN4aKINv6l/6zTFjLeWWkzpBOQm/lPp06cLvyDDbaMmCnYiPhBhU9XI?=
 =?us-ascii?Q?iOEK1fTaY+u6pfU224i3nQGmwHroDTMtVlziDq9w5le7r1Cj1VuWyjRXMlWL?=
 =?us-ascii?Q?pZ2eaVLJ+36ZSmPaRZ87A2NVU/YNaIoajGCyR0AdIWxS/fZxtVuRM0bEiE7C?=
 =?us-ascii?Q?NuR5CzK+QPnfeGLRvZ76NjhQgnZWM+UVywVrTml9aF/80zUPJMIaupP9JeO+?=
 =?us-ascii?Q?JKUASQNfFw47dRosU1Ug8CmEXNpMVOmfS4GDEWKpycJYd8Xom2i6aW2xnhm8?=
 =?us-ascii?Q?h4ziXLDo71b8+h5PJoEAy6m3QUX8QILq6OKNP/+6XRz/Mdv122NDbUHupHXc?=
 =?us-ascii?Q?4WGW9fJay4K/g5MoNm0/27kCOXMTZ5TeVgvITIH2AaiGTqr2PQe94XeOozN0?=
 =?us-ascii?Q?boLREaCf2N+1AQPpFXaDp/HGJapPiyihxaNFhXBzh9o+kt2md+KBKrImAm7u?=
 =?us-ascii?Q?q9nabVJLvdCivkMdsGd0W0P12UyJG+yqnY3y50m6OMtxdHZlVKuTcTqlnSeU?=
 =?us-ascii?Q?lqkTEDrVDuPOUjueHkDfKJgAK9Ls8oh3IKQgDsVJOfmjf+fP/IcyH395ZwD1?=
 =?us-ascii?Q?X5x9U2VFg8km7TK2x7LCWXCtKac6u46Pp+CEH0QnnZZegG8i+BBP3VW+0CU3?=
 =?us-ascii?Q?tLZ9xW5LEfjKU3s/LjJoz5y1KZUtI/vx4dxJ7bitJjex4IUMNV2svLwhXAT0?=
 =?us-ascii?Q?hydFh5AxUilz+VYLnLPnIkbfx1SIyFlCuIidSq+0e+nMyWQOHJxRnu2eUOz1?=
 =?us-ascii?Q?SyekqExISTbbYEiciU/nhWvL9SLAFr90Hx4nv6YRUOziCk4gy2x1keiWpqXp?=
 =?us-ascii?Q?LUYrra9xTkbgGkKyi8LDB5xAyWy34DxM+4wsXq/5DDqEOw5vskVAb7wWChqn?=
 =?us-ascii?Q?CO3Sh2VzUniSeQuj+7JfP4Hu9BHb/vg4TvI0bfMryNPuNRsbCiW7jPAmT7Wj?=
 =?us-ascii?Q?6dnigMxcPt1Y4n5a3/ukS5vouvbSxS1Obb5qX1oDIClKrs1tXlnmsXsZ7Fe8?=
 =?us-ascii?Q?Cdl2PuPzQo5b+Rbsu4CaKAgyV7ox8JhrFwBQ7C6ow2pi/iHoQfiRZV7E93ET?=
 =?us-ascii?Q?qnxf8glMZ6lb1eKuvXq2EnVlzModSPyMFiA6L3CdqEpTxcRsy6YYoogVMbtD?=
 =?us-ascii?Q?JhQt/m6Nbq3FkTkZjmv0YD8ytUI75xxuIprXABGzQrgX6ZxkNRBdbn1rRTfX?=
 =?us-ascii?Q?ah7p17YcMQfV2G4Zm1y2i8HeHvCxMG8dlkzCTA1RwpXGYT1PQzWTJlOrYikd?=
 =?us-ascii?Q?k38jsvdd4Kw2fZu1iGAPO3uSpFpN+m/+bivrQjviVpZrKbBeZ3Ez+lbbTj6b?=
 =?us-ascii?Q?bWG79Mp4+5tSCL0uWGkl54FAgcbHF3nZUKqPV9q3s03QRc8YCst3adc2c7IR?=
 =?us-ascii?Q?hz78Z48YlYaUNdyjSf0tTJjN3Xq9KgHAinmM37+0Lcnc7ah9uFTnsv6bzY7h?=
 =?us-ascii?Q?D6C5D7l1bbQXCOr0j9yL28TAjAxYn5OvYo+fP0EL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abcc3977-77a4-4764-b4b0-08dac6ea0e4e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:16:19.3219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AKftR0H9AXNJm/25cXgGmSoPEUx9hLlgvWbE5nLSChos02VVHF6jNGej+mPmz3EGDJY3nF/iBJmsg6plM+Vig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7899
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable uart1 for BT usage
Configure the clock to source from IMX8MN_SYS_PLL1_80M, because the uart
could only support max 1.5M buadrate if using OSC_24M as clock source.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 1971f095e4c2..12dc5d398a03 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -247,6 +247,15 @@ &spdif1 {
 	status = "okay";
 };
 
+&uart1 { /* BT */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	assigned-clocks = <&clk IMX8MN_CLK_UART1>;
+	assigned-clock-parents = <&clk IMX8MN_SYS_PLL1_80M>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
 &uart2 { /* console */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
@@ -440,6 +449,15 @@ MX8MN_IOMUXC_SD1_STROBE_GPIO2_IO11	0x159
 		>;
 	};
 
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_UART1_RXD_UART1_DCE_RX	0x140
+			MX8MN_IOMUXC_UART1_TXD_UART1_DCE_TX	0x140
+			MX8MN_IOMUXC_UART3_RXD_UART1_DCE_CTS_B	0x140
+			MX8MN_IOMUXC_UART3_TXD_UART1_DCE_RTS_B	0x140
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
-- 
2.37.1

