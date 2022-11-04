Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A79661A0E7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiKDTXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKDTXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:23:11 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E310E48775;
        Fri,  4 Nov 2022 12:22:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLLNi6A6tChAOFJ2N3Da7f0JkNmSL912qpwTuuamMPz+RzjWSOCTS/+dWU1hdqAzI+c4wEDcA0jalZ89hEazg6BT0S73TFWG01bewkUW/5qE80d3sxWiR3sdnypcUKbAfb4N1EWuW09avRG6AWuDlMEV+Wb4p/HfLYBF/soRE2oKNIZ4iKiVYviv98UwtLg1KVkj9uqrg85OvlfEtKdR6Iunwo8dMSfJ2hd+ojQoN+aAWLFPkvSy17HFN947MAR2nuwIDkJg/ganwZNJ6pLY8AM00/evmJNPWF1UEOWJAM27N1P3djE6leyIDvCVOIp4YnqcpOFjk6Go8g2nq8WDtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlI13wTV0jL2UsZewP0Zrv3lKQOH21Ic55LlKC/8+TE=;
 b=k/YCh1YP28O+85Hm33HURyQ9E8WVYmQohlVW6ZCJrGSq3W3xH33RVxakZMkUQuhHTr+2+2m9L47LzrMEDVxfHoCysOJvuvyiZtCAqTxsS/avcoSBjEfXs0grdk85kCcrknUscahhQJcm6WnDHLMWrUBQhNvKd+S/7/M4n78fXp2WXpbCeBpIO3biVyFtSey/Gq4o9qUzQyPQky2VRBltVlpPahbVIDz43ZjCkYdZLBI1l7kMCGqinAIPljHUij8uOqeC1WQSZZtYIh2zbmz4n0aN0GKIWWE3sLaIPElfEmUzYBNxlyWwCjg6jEpYFTqk4INIEYYzN9mi5x7oLbmqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlI13wTV0jL2UsZewP0Zrv3lKQOH21Ic55LlKC/8+TE=;
 b=ZJnL/4EzqJMdOLNP9VdGmfp6v0NkCYhkKHS2NKhp9P0vTOmDWRipyKk4MYhDthEnn743XLjONQEi1aeEJaoFUDZh9dugOjVI566TN7b/cOlRTWwIzi3eDjsO6ekdi+CxYXZQsluikeRbfpY6Me2qw8FaY21VJavPVajPSo01t7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Fri, 4 Nov
 2022 19:22:44 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%11]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 19:22:44 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     han.xu@nxp.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 3/3] arm64: dts: imx8dxl: add lpspi support
Date:   Fri,  4 Nov 2022 15:21:27 -0400
Message-Id: <20221104192135.1661541-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104192135.1661541-1-Frank.Li@nxp.com>
References: <20221104192135.1661541-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR01CA0004.prod.exchangelabs.com (2603:10b6:5:296::9) To
 HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: b94404be-11d9-467b-b8ce-08dabe99f2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NL6vS9wulRX2BAnKY+2x105siQidCrBKQs04CNDi/fLr6KHiLZ8KtMwOyhLm51Y3wgNiLasBkgcrCwtY9qKR4tgOhyZ3jIIm2nqDWOHCps/uHKiVvQICFErXylni4lcJGsiU/AAJBtAqeN0l1lQVYHrKYGtppYTPAh+j3tgBLxGL2k8Kgvl7NiDl5yKt+TPK3x0xiTlz2lnAJxwQa4y9mO6DJREJYMvTJQ5C6kHEVt/mLGrZx1kqRtSpGtXnUV5Yj2Ty1zyt5B51iXQjt+dZXJLXJvWRCAoZYcXFPZrgJqqLycusWYedNDhEBcBdiNwljpGIMzKdOXo59lcykUSJqA+wd2iMxvpcjOQP0VXe0E0m+qERC/afVyVkEugOvpAk1D7V0kSvmyxfwDQZv4XALYm6enYwGaYtlXWgugJ6G6I59ZoIDLBmdaL18mkPy5Fd5TGlPxFfUVOL/7dqt+mtDs1s+reO8POMumgoir4Xc+3GtH9dBvBrxtFZyUntwDDS58bZV7qWPvrc1Oqp5pyGqvjpWTPjceAYl13F5bV0EYeCxMEujZpFHgDbo34LlJsCpDy/C+VxVmF5tnZw1wVEdgD/4iVYaMoqeG0HTvMeqJzLDV9zOdyAQZdmATmkuzL/H7mAHTAgSQqupRRsbyfndWYMlHrVVoAqkbLzlrcxSwJC0V2f8aTA+o7rv6dkkBJlqgin1kE5CAdJsjHRXO63R2VWOfZEgDPYYnxiWcmklFx8MIV5dNMOkwIugi8JSCR+TnQPOSIq5jtzJeTq4lTLQoL2K+iHdW4759z1P6GID6Qn+M0xdQWaJIHgNxGeQYG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(36756003)(110136005)(478600001)(2906002)(83380400001)(7416002)(5660300002)(86362001)(921005)(38350700002)(6512007)(8676002)(38100700002)(316002)(2616005)(186003)(6486002)(1076003)(26005)(66556008)(66476007)(41300700001)(66946007)(8936002)(6666004)(4326008)(6506007)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o/aYRinbjmEO/5LQremt2gwxSg4gQCPDiE34yG7V46Td6++XXrcKecYVsR//?=
 =?us-ascii?Q?iXATRlCUWwbWH2746qj+MVS/8gEzSRS2+zqgVg86/pD9L2HPxMjGRTh5c5Q8?=
 =?us-ascii?Q?IAHOQm6Aj+S+o3K3SKjX5bnAvWUxZlQNj1XeLlBLr9cE9vk2hmQAWpv5Sg7x?=
 =?us-ascii?Q?h8w09KiwmbF40g3TRoz0rIlC8GkyjyAp8pnIpZrPh89QRAH47si2PCcwnx0h?=
 =?us-ascii?Q?aTuPjXVPgXkF7vkny+v1voGjzDmBPhy9GptYR7BrSWTERbhtqXo0JepbnLX3?=
 =?us-ascii?Q?PMWY/pkGDk1eT4mx10e1fLidGqQmRgiub4uclZi/plyozG6+PSUf2EeNuvgp?=
 =?us-ascii?Q?mUPnXyY6d9oaqgYTd9GMcNrKw37ryo3jDNn4ktlB9NCz8/rUi9PX7Uv8MBiY?=
 =?us-ascii?Q?sQRNJbcQJul5BC5Qz+c7H5pVzFPla9A2vu16qsyQvY3KH9D/j8G+5IC6muIO?=
 =?us-ascii?Q?58iF/gLz6x0uRWxsydb+o8gPkQ5ZS6SI1RvL1e6NvtOPUhX6+1DZHVuoi4B3?=
 =?us-ascii?Q?nETe+ThgN9CjEFwDB755n2PI7sgMmEbK57+gtI2Ay8wBgTVOx890/Jp4tAZg?=
 =?us-ascii?Q?88lwje2Q9UYuWcn6eJFGKggCaMYSbktd+V0KB4hfvATqVsmZO3jOaRaKOnIx?=
 =?us-ascii?Q?OY6X87GDFwPPyKmTKxy9E1m/oEs8GbtWZWbCLJXntZXxY/YvJ7fn23EKaSLM?=
 =?us-ascii?Q?62jmlJNcfL+nLhD/olkLtNYKHia26OUmooQNcvE3YFAeuEol7Inb9pzhvDnA?=
 =?us-ascii?Q?+ePG5VnOPajitgEufncjqYec6WJSfN67o0mD7wE7SMlD/ROtIDS8jKrms/6u?=
 =?us-ascii?Q?m7g5h1dHDitu5ZogEH2Rvz6rKql7Dt1BnAhz82PPJM/ruin9FPanMWbG5HU2?=
 =?us-ascii?Q?NoRMMcvB/FMh8apvddUvmUKFGE3g7ufAVJOUEkvYZNj4VP42A5910QOLtj+7?=
 =?us-ascii?Q?L1/N/0WCwr2Mcqj5GeqLHLKWMKswVkTeTQZ9k9bH0tIZGfCrxlTnKNE2QXve?=
 =?us-ascii?Q?OLuro1zql7LYlT+43OD0RexHHvuC5FT6/3iuCKxMAGaXeum/ucZwuuzZBpgP?=
 =?us-ascii?Q?cA+Jm4NPEGbYBa+EauLWPwmZpwTbX1bJ/YzyLH0OxtRaof2emtZBk8dFSzTw?=
 =?us-ascii?Q?IZ6soe/qR0pH/8fCMwoPmmn7pjq9Hlr0NYW8AITLpLP4kv3Up6Cr/5rSNfPc?=
 =?us-ascii?Q?m/P+1c4xKNsrnnDRa0zui+DAgXqSrJeOBj9L7qIMLliaZhCBg13D/+dy14Iq?=
 =?us-ascii?Q?mv+3NOYnZOhdcf9sWsuzpCZ46f2Qm3r3ubJ/Nelf9yFmsyGRUYJspdqEcYrp?=
 =?us-ascii?Q?VznAq+vSPozmPg1xWHr2G1DAbtcF0VBsdH0mOgW4n4eAIcuNKGEJX28o1aTl?=
 =?us-ascii?Q?Jd66A3CaZx339ShVu3pixOqeprCvDpebtc0vjMnK0eTX8J2/SGWt0rOEakyL?=
 =?us-ascii?Q?TIf/f+d5ofE9IthfHwny+hUZWYpjzriBnn0xyg2zeBBZvh5kYJFbKRuejJ48?=
 =?us-ascii?Q?nsvFaRZH1gZfHLFLSLs2JG2jXrQcwyYm2arLo/MSxk45l2snkbFSM9HUgLh6?=
 =?us-ascii?Q?Z3JrlNVbO3Tpy+EvLIVlYSq72djGa94AAPZeU+vN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b94404be-11d9-467b-b8ce-08dabe99f2ea
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 19:22:44.2878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Y08vLjMJTi9wGn6YpIRsTEu+4HViY49Lhdeqe6HlHA5AQDrxi2LpjMyu62/xtL08jOwJBXWDgdcZV+jrPWhOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add lpspi0 lpspi1 lpspi2 lpspi3 node at common dma subsystem.
Enable lpspi0 at imx8dxl_evk boards dts.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 112 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts |  15 +++
 2 files changed, 127 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index bdbb660c2682..a943a1e2797f 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -20,6 +20,70 @@ dma_ipg_clk: clock-dma-ipg {
 		clock-output-names = "dma_ipg_clk";
 	};
 
+	lpspi0: spi@5a000000 {
+		compatible = "fsl,imx7ulp-spi";
+		reg = <0x5a000000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&spi0_lpcg 0>,
+			 <&spi0_lpcg 1>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_SPI_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <20000000>;
+		power-domains = <&pd IMX_SC_R_SPI_0>;
+		status = "disabled";
+	};
+
+	lpspi1: spi@5a010000 {
+		compatible = "fsl,imx7ulp-spi";
+		reg = <0x5a010000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&spi1_lpcg 0>,
+			 <&spi1_lpcg 1>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_SPI_1 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <60000000>;
+		power-domains = <&pd IMX_SC_R_SPI_1>;
+		status = "disabled";
+	};
+
+	lpspi2: spi@5a020000 {
+		compatible = "fsl,imx7ulp-spi";
+		reg = <0x5a020000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&spi2_lpcg 0>,
+			 <&spi2_lpcg 1>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_SPI_2 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <60000000>;
+		power-domains = <&pd IMX_SC_R_SPI_2>;
+		status = "disabled";
+	};
+
+	lpspi3: spi@5a030000 {
+		compatible = "fsl,imx7ulp-spi";
+		reg = <0x5a030000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&spi3_lpcg 0>,
+			 <&spi3_lpcg 1>;
+		clock-names = "per", "ipg";
+		assigned-clocks = <&clk IMX_SC_R_SPI_3 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <60000000>;
+		power-domains = <&pd IMX_SC_R_SPI_3>;
+		status = "disabled";
+	};
+
 	lpuart0: serial@5a060000 {
 		reg = <0x5a060000 0x1000>;
 		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
@@ -60,6 +124,54 @@ lpuart3: serial@5a090000 {
 		status = "disabled";
 	};
 
+	spi0_lpcg: clock-controller@5a400000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5a400000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_SPI_0 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "spi0_lpcg_clk",
+				     "spi0_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SPI_0>;
+	};
+
+	spi1_lpcg: clock-controller@5a410000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5a410000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_SPI_1 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "spi1_lpcg_clk",
+				     "spi1_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SPI_1>;
+	};
+
+	spi2_lpcg: clock-controller@5a420000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5a420000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_SPI_2 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "spi2_lpcg_clk",
+				     "spi2_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SPI_2>;
+	};
+
+	spi3_lpcg: clock-controller@5a430000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5a430000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_SPI_3 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+		clock-output-names = "spi3_lpcg_clk",
+				     "spi3_lpcg_ipg_clk";
+		power-domains = <&pd IMX_SC_R_SPI_3>;
+	};
+
 	uart0_lpcg: clock-controller@5a460000 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5a460000 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
index f8d416f7fd92..280a9c9d8bd9 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
@@ -359,6 +359,21 @@ &usdhc2 {
 	status = "okay";
 };
 
+&lpspi3 {
+	fsl,spi-num-chipselects = <1>;
+	fsl,spi-only-use-cs1-sel;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpspi3>;
+	pinctrl-assert-gpios = <&pca6416_1 7 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	spidev0: spi@0 {
+		reg = <0>;
+		compatible = "rohm,dh2228fv";
+		spi-max-frequency = <30000000>;
+	};
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
-- 
2.34.1

