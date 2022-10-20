Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B03B605BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJTKAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiJTJ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:59:48 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80081.outbound.protection.outlook.com [40.107.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC858A1B9;
        Thu, 20 Oct 2022 02:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huvww7ETaV8ZHL3LjiLQuwd4N4fjiS8r2TjY6aUIGSHBI25uysjzG8darMGvEbMQvP3REfnykePzGqVEMKsSl3jTHS2GCJuIlDsmVzVlyJqvD/FvJRRgwh8QgAMR0/EGSvfqs3M5TTOqHD9wNnL98WCLnfsN8F+QUqnbXhnZxIkXJorpvQ7cBXZE+AJj1tAQTw2Ch+zOSC748HXYMkD0LtpJ/I22cvVfZBRM+PNRxziTHREqdMK+ep5RDxzYMZfo9tjhzvICoXeEEBlNupMezkv6fNLDmRNHwaVbaoYpXriKy/vLsChxjoGN89sxkRar/2zk0BryDFgmK2V2SV7Dmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b10whJRrtoyjpasSiFxHGpQixZAdxSNfXYz/TyCGF0k=;
 b=Fzo7zJNJd/p8o+DoxQj/vxyZ93SM0JfAAV98nhCXOlhn52GagaYVsGNRPcZWql4MmzOsIXd3J9ALSgQls8EK6d6XgWFFv3f1NtIrMqLL9nqB51tfiqs/EdvGWOU4Rh8WGBJxSQYe1cX/oQA8kgAUJocdQXXHOH9YSt5B2ScRljXnPi+90F/FzmhmqyIcZDAQVqwAT4s+KV5g1uxm/5eJDVtQU2Qm1A+XqALAPTVQQa2vPfXvNQY22IPgx6PNzecg03rf0EmaHi46G3CpoR6A/kvNrmV6kBYgDgqUKz7yXUF5eMjMS+y5ssMtqjHXAMToXX7DRKdHBQGd/LC87huQJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b10whJRrtoyjpasSiFxHGpQixZAdxSNfXYz/TyCGF0k=;
 b=QRlO/8aoGHaiLk0+fjVtSmUruInlzJrY46lsSMhQEXLO7HzIKbnBg8a/1dHoD+St+cwCk2kGE/Td1JFrZczYMJjV5tE1jUFRfJm4qetyDatzg0uAbsDczgLGqyrGmOZSROKV5PZYXylP1QRLeLtq7nbtWgjT3y+kEeEOeViDTnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8039.eurprd04.prod.outlook.com (2603:10a6:20b:2a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 09:58:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 09:58:56 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 11/15] arm64: dts: imx8mn-evk: enable uart1
Date:   Thu, 20 Oct 2022 17:59:30 +0800
Message-Id: <20221020095934.1659449-12-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: dcef835b-20c4-40dd-6700-08dab281b392
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tgm3jkp/5bB3y+zU5i5dViDHUZuud2VHuzboI6rS3M+NTQupqFk/1yHK2oL2Q8RFIIV2rvbFeJloRwFhK/ddqvr0FD8/ZWqNvn/0udqlAfX3uCEUkMghFEgpGQIofO6R0J5wMwZ/XPRLQItV6is+XnoOuBCs47XL0wX2F64WvDv5EoQAq4k62Qz91S/pSvgDRXvUpYQKh1F+VTDminue/XPsWxwuhO9njGvai8Uew+MCobeePxXH8V0OevesybQi8hvMwKtQ0u9umx1RiWT0D3g2b7xm1mFyie1/w1YcqaSIrjmpjwxQf7BojdcgwOK0q7+486kbVogBAabFfbXTsdtvmXKi4U2mJFU/YCOrhPc19z2jdSqUFVcxZtWvPe5pnZ1WbA+TH6BnQnroW80mRDKTRRuUR3RtBPokav9My7wKFzF3ygZuYJ6y8ajLv/58257YHA1k+2Adh6YOS6SqB/LB9I9NJFtGOtH8+o85CfHX8QTLNBL3f85eVL38CPbUdH4msom3gtuYd4eZv78bhx4Ka/LLUSQb2xEbTPHi1vr6YOikZ6eBkTeRF3aVf9RQdHmn5dq9AtwxTdpBsOE/LfYciHGwBDxydsbjydrQsp66E66Xoqyn+8lBh2eQVp7ELH4cF+TTpy+hVUPh8WK8htyweHQxULW4RqP8TaQCiBUM5znQ5L6J20h+jyxpN0Gj/Vp73KW6/7gu6sr2Bdoe2toyXrZO/WB67bW8ynzwgAFLx6/oI7LziaLS5mFNz9mQgusLuQutMNkk5NvAf0Pryc5r1Me/vJFfANUSPv0viB5TLpygIAS+VDedME+Rc/wL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(6486002)(83380400001)(478600001)(86362001)(66946007)(66556008)(6666004)(26005)(41300700001)(6512007)(4326008)(8676002)(8936002)(66476007)(38100700002)(2616005)(2906002)(38350700002)(1076003)(186003)(5660300002)(6506007)(52116002)(316002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9NjMNszFm5u0urOrRBNvCQOxfXAcKwFbot9xne0Qah1cHM46kdRxdvtJ6RHD?=
 =?us-ascii?Q?9QDcFn12CykNsyJqgjMr3oO7h0HPU4EflChMCRbY/D5AI6NjGa3aVweCTQZv?=
 =?us-ascii?Q?da19A01e2bcRxPmMazgDHm7pmQp/Eajn0K6czXgQuXW6P42KGf2XU9TRmM6v?=
 =?us-ascii?Q?nP7j5PQruwVHmZ8h48YW6ifbA4rL+2nj3noF6S8djvBZhvdJ+FB2HLMVyFos?=
 =?us-ascii?Q?7o6HqYB/oiohvydnzkZ0M2YrsYetyN0WzbggF5RqBNgMbk/f4D7ja28C39VI?=
 =?us-ascii?Q?HKxwQIlv3LFHzbq5ZVoZXCzUzVeocUDeJjPbidg1xbOffaFYvg2SwTz3XsxZ?=
 =?us-ascii?Q?TaOOzdY9QAW5clBAhSzeG2/eu8TmqjtYqCQHdbOJK+P4IiKfFi6GnvciVGDl?=
 =?us-ascii?Q?pyU7lzlJArMphji+LeMhThfoDsDuYzWAGCevu4V5IxktOdaYrKqIqkjoNomk?=
 =?us-ascii?Q?2s2/JhjJWjR6rC0shTHt7+qCjnrCwmeidX0e9s+mvblwSWs/bckieRvtpt6G?=
 =?us-ascii?Q?7WdF03HDiK4fFIWCG97akfA1lxGvqP10Kt+2gzktF8vZYzNRGzRfY9dOXNRh?=
 =?us-ascii?Q?h8XF2r1caDSUMWt5OCB3rBDJtnJletqY7ekBJTZ+mXymE/oiyosyt77Rx/qA?=
 =?us-ascii?Q?Xsg3dSXYEhYTISUJ5D1pYdzcUNlEblOAbb5KsvUeeyhxfvzTlsS0M/2/0hBN?=
 =?us-ascii?Q?sToPLDmEOMVUePSvPynr6UUgzggh2XeBtG8x31WmUaoiUFHYfU45vXr0x5Az?=
 =?us-ascii?Q?0N1Rjq5vAEbKrBxxXht0lfCkPL2++zJRATPmRDcllNvEhAGeefnQUUY/gsrp?=
 =?us-ascii?Q?rZDBqUDjCStgHUG3nZw7efopbkgwaphGppWKAISdx9YgffJy3fvtiOY2nkmQ?=
 =?us-ascii?Q?71DKLmanv1vz9QQls0+9AT7otHLPM2YXnSqDa9W/Y5BPMUj5lU/hNlDHqeFL?=
 =?us-ascii?Q?3iLCfAb2UbUSro3l6lGn2wDvrGrotF/TlI8x6zzPDu6sbmnfB58ahLmr2+Bg?=
 =?us-ascii?Q?KC5Gcxuc8v6TiyB525QJWHv6TP9/jRGv5GiG2K9Uj7Ut9cGzZxkujb/H7tkM?=
 =?us-ascii?Q?2nNy30gauMkmXB+AzosJ079/LYnJ7cWAUaiPQEzPa5cipS6vsEN8OmkphV33?=
 =?us-ascii?Q?tahT7J7RLmvliafvD7yrsrPIj0BSEHXgFzY1Ywn0XBCl+z6/MtbRLhQsDrVq?=
 =?us-ascii?Q?r3Svu5CJ3ooRJrD3pOOxTnIaVnJDgjViPT51Ai5wdces+VsoBHQcHH5h4cXj?=
 =?us-ascii?Q?U/WKZym3D948DAEN+boAFf7mNqrOd3vl2MoLxqzbULgf1TrTF8WEXD6fsn7d?=
 =?us-ascii?Q?aWLEDKEJF62MuFnrXpLkNkG2C2LvUZlJvEXUKkDXfYxgbQpNQElgTTRY+/+B?=
 =?us-ascii?Q?GVlJlSEgMGcWmnTT9AOLAOoGOsmvri9VDy2b6dthc8wJeQJMv5Z6hHtDTjcw?=
 =?us-ascii?Q?BNQ2c3okQ+MUyQ6zsjTAACrGe3DJrr4RMaAaOQKiK0ItQOvJBPOTg68T05ly?=
 =?us-ascii?Q?AQh4Bxizk/ugCuur0oRgYPSUUsdUGzdWkh82mxbrncaDZ4cdqQ66lY6DhObQ?=
 =?us-ascii?Q?NuKoECCeMapIBNp5FfPyg4/DGmuKSYW19y5X4NK7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcef835b-20c4-40dd-6700-08dab281b392
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:58:56.2712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mjM+JGuERDLDWhtZ5LSNIZ7Vv9fF0aY2EgXakoesS4kRmqQLME3kiD7CZYo32m/1YjdagvzN2gA2lMBH72wAzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8039
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

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index a37a165b40ec..f137eb406c24 100644
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

