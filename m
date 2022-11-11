Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36133625EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiKKPsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbiKKPsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:48:38 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2086.outbound.protection.outlook.com [40.107.247.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760EA7BE46;
        Fri, 11 Nov 2022 07:48:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfPDG72iDZnT06wVSr2VnWnRrMiUuKUfJSPhHr4ZM0DkLvvaIqNKoPcn3g/UIP9FiuznyK2dMtwYpfh7nZDovyAFMCBQ7VRWsmSacQtmIwtLG7BXKcscF7WLutaaq56NG9myfiNcNEdZ3ivMb4qDicGsCrm0AzyGtxPMyx28VR3321/KXFpK2byd2M8EPYTUGcKwNu0KcB5iYCc731k6sKz0ZvoC01u1XHMPJ+4c9EpqgcslMd5LXtZj5r3jwYKig+GafQh3wAZcLlHZIIQ5aspqQfPZUycG7Itygarzi70LhKVyP8/eCDxZljwBfFRksvTPShIrlvBRFd3enJn5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ0WcNqBF7K1eMoPzh+//1EM6f7v0duVmRxXvfCzfXM=;
 b=Ji/HxX7P1rblR9+dVrGvGqCpxsvvznUMyTM7W2hei1FwvP+ghTjIPpMf+hqgMWWbOpzL1Rj9oK3/B5EZUWPflX0OaR1r3hnLmR4nxrcLm6B/zvCKCFSV52SqyXL72f2aMnMIcktYqRlIxoosXRxtbjtUtVUE/B9Ycn4DZHuXV28KPtWzI9ndXCsg4WlpK97cTbf9lNSxrOxbAf5JjCyrnhLTcaj9ExelAOdtBTlamZaCEd4zitsfkznVaveW5IQ+vVx3ZvzFdNIasYuq1wTNnZMKNIRnqauB6UAl+Jc33+4ZXlJOCRCWivYAtcF17xqNYvs46pHhGghfF8nraaJzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ0WcNqBF7K1eMoPzh+//1EM6f7v0duVmRxXvfCzfXM=;
 b=flYrRYwk3MdRLhHbt6Aeaid/tnb86GuC24eYGtyv73DkK0kRQdDtu/c7fmk175utfkKqaYDsE3rnyjEWQlu+Bsk9tKUFCwBi69VYvTvBZp2UzpvKpbHK5U4SM6ERTVHknmvJgrl18v9Fw/Zlp9jVVqBYGYBYsRXMSDTTFYJNjCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com (2603:10a6:3:24::22)
 by DU2PR04MB8982.eurprd04.prod.outlook.com (2603:10a6:10:2e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 15:48:28 +0000
Received: from HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230]) by HE1PR0401MB2331.eurprd04.prod.outlook.com
 ([fe80::a405:3557:91bc:9230%12]) with mapi id 15.20.5813.013; Fri, 11 Nov
 2022 15:48:28 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     shawnguo@kernel.org
Cc:     Frank.Li@nxp.com, aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        festevam@gmail.com, han.xu@nxp.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shenwei.wang@nxp.com
Subject: [PATCH v2 5/6] arm64: dts: imx8dxl: add lpspi support
Date:   Fri, 11 Nov 2022 10:47:41 -0500
Message-Id: <20221111154742.2753318-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221111154742.2753318-1-Frank.Li@nxp.com>
References: <20221111154742.2753318-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To HE1PR0401MB2331.eurprd04.prod.outlook.com
 (2603:10a6:3:24::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2331:EE_|DU2PR04MB8982:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c294279-ced2-434d-2dcb-08dac3fc2d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dj1UVcggMF+49hXtc21DbxgUyY/U++LTZJNACbzKZm0VLKcAiodIh424js9BMyyjkjJJsjiFJXEcQW2hc2Rq6HS7vji/eL6zEQKKH9RPGaGtmY/vvXThmG9+UKxUhACE5zHjnXo5hOPH4EXBLeMkYFlsoLdTK77el4Sa2AGPDODveNioPY41oTacz/8NA1Qqclbt2osU3279n2OEXzcL9bqpRrdBsQqNEYq29tdnvGe8FKjl7ZIG9S3K8MzsmZqgw+m47oDYouujdyfeO00eRkvvIiempxgTXSvHS/J7gQ/lXV5kIRDzYvYotpgXKe9RzyIelZUGUT2G47bmii6l0Wi9MfhcMvve0kmnZhiKsnWgXAqFMTFY/ChoNTb+KCPFQPMOzmELfAinmxUWtQ2l++lepvQDp2VH0XLBsuoDoCmowLvcWBQCtJGBK9U4Y1VXrIAqc8YDGtK0cEDwTuZFlFlSlJPUykvHiS2spVdH8MykIWNJv3PywvFFeCAJSFGMhUDMwsf+n/Hn3sHQiUYpEHffDH01U5w8ebRK34LVscMdEPg375wk9cDCvKOP5arSHZqMvRiOt1OfqYh3r/Z7ZnVP5tSx5NxdG2Fr631BQGg49NvNXDBN4+GOCz2RE6j0dprZimjpFwvr9huSG9s+g+2w6I0gKqbsb918wc5Se7w5Hmz16SoTq/lwIcX+Omo6FdLpwriMkKBNVne5/2xLm7De4pM5m7U4UtkWeEQPeaEEKOMyJ6tHXCXSoRXhsvhnxnt3aEKyidZJ3OKEvQMlsTwLqjkBc1fT/JApMC7LzU4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(451199015)(8936002)(86362001)(7416002)(5660300002)(36756003)(316002)(66556008)(66476007)(41300700001)(38350700002)(66946007)(38100700002)(4326008)(8676002)(83380400001)(1076003)(186003)(6916009)(6486002)(478600001)(26005)(2616005)(6506007)(6666004)(6512007)(52116002)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uANyFERNxROnEDzubZmw2V2eyi9JbOAq3BRXCf2P6xe3u+P6cYHNKK4jHB2y?=
 =?us-ascii?Q?Qg2C4ZfsvpvAgCNE9kBO5QpsNyqFYkDzdjyZ9B8YqKTB4idELlBBduavRzdk?=
 =?us-ascii?Q?zFEyMugUaizCwMhIIUiq6GR/E9niMBsVFA9OeZRh7JiwUOrK9WgV/HTK5BXx?=
 =?us-ascii?Q?nsarfmQGAgH3c0+iafWd5cWnnceyGw9xS+f72IR9wlNfMI9wyOk5tXFbtDhg?=
 =?us-ascii?Q?ZXWONrx91Bz1uUNjuTDiVuy8xUuXiKuSGZGzfe1OwdaPJtPrpoYEHIzEzigg?=
 =?us-ascii?Q?cqbLnXO4ZUQWxWoIfzLMujyBumWXPToyRMszvQ2wDp1wNfWz9HAPSSA4aAsW?=
 =?us-ascii?Q?CP/X+fmu23yfzpJUfSs96hd4ocs+9J3hmdPgwuxOVlbvJxZKY/f/R5HwWjh1?=
 =?us-ascii?Q?T7LvJ0UI/nJL4DpamlL/tQ+CsgGta4QNft8ZjcaM+d6Em1ExAABC73NKd0pe?=
 =?us-ascii?Q?N0tbg+5oN2DtlOomJvqwWB9Ge3bQVCGBotn8rKKcaQzbCkYUqq7Mmnvs6EqF?=
 =?us-ascii?Q?DMJ9eT43lqPSZDBrcC3doyMkaECgnXJAZR821Bz1HX8F4dvHuo1diL7VVLjc?=
 =?us-ascii?Q?ofML2TwWaHsDKU8xsoSHBqfwrUiglKrUxjsTsAubCxrxLoF7+/gyKbuPcFF/?=
 =?us-ascii?Q?3bAh3w6/YsqQvqleLLr29MkhN0M2HxtadKaWZwa2v99QZD2VsVFiJe0eazYG?=
 =?us-ascii?Q?TsWDT3Nx7r/gpwv/Ta4SRQEytVNZI0kduoc8CQWNGDwi8D1O5ivMEwi6gBXL?=
 =?us-ascii?Q?Zfa27ZcDZ+uBY6+L3EuCqiumUPPMQhy8FxiUC28VP2X84yoTBn6W3+YPfLFe?=
 =?us-ascii?Q?qjnmp8ziIxRk5cwKhIFG5pMKGpf6/d6L8OpI6M5CZXb5ZHecOBQU+rZnGQzW?=
 =?us-ascii?Q?2rWZehs8k8bcg4XpeRiPzdvYpGXEUz8Fzk+25PqQ+yX4jnI/Xgte1s7vb9xL?=
 =?us-ascii?Q?shopmK8qHSV4NrKTdz29JbeJdOevmF5LVNpnEZlSM6ZsMfRkbcnqWxQ+2bRD?=
 =?us-ascii?Q?me0WOPV+gUeeCUpDM8EihQD6RYvv0zCAeE9vC7NHgvV54h36K4xR1R5GU4R3?=
 =?us-ascii?Q?lgx92zu3ggyMlLR9QOwzAKhtfakz5lSMUZW0T1U7T7uBKtAjIMw+aHWaCd+c?=
 =?us-ascii?Q?In2QNMvMCYHlor7NvR66P/rmZ71bAG51PQo1qMh0xDhEHiLvS7610tyOxqlb?=
 =?us-ascii?Q?sd4PtK7gb6HP+CP10Is5G1YTXaEnOerZVeVBKQKLwJzQwrtwzjqpvYk8jYrN?=
 =?us-ascii?Q?aphcQYeRaNM0LXBjOy2zEGUu++5VeB97WtwIY23YdvoRDIRFVt3XGb+Tq0tQ?=
 =?us-ascii?Q?2nKDRe3/+iw4xmo8y1Qagwi5BI9eCPTFqH+RLWTuI+KaDbQS/eEYtyiS+mbk?=
 =?us-ascii?Q?xQa7xvVzpLa8mKPC1N5zXfgvtBMr5mY8Yh1j/i0bY2Rc0mqe29THASH3ypY6?=
 =?us-ascii?Q?F7LRA00bih/2nGmSIa1NTdIw911Vw1CFTT+AS4mExfoFtrsx+bdrOWwNCVwB?=
 =?us-ascii?Q?fe92cftXGKUUooAbAJqRBhCyoD0WfR8mItYeDfc5+P9ho8BmBKpTiVR/wp66?=
 =?us-ascii?Q?pTXbULTLMOBb8do7he8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c294279-ced2-434d-2dcb-08dac3fc2d4f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 15:48:28.7716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icNOaP39qoKURtDNUsCa5Gfi2S5kgaBi5e4ESYG7GTcmIWwUWXrH6wpGwRfkoaCNy76WLqPlls12DIAHfiFvRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8982
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
Change irq number for 8dxl.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 112 ++++++++++++++++++
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   |  16 +++
 2 files changed, 128 insertions(+)

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
diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
index ac3362e32811..6881330ab4c6 100644
--- a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
@@ -54,3 +54,19 @@ &lpuart3 {
 	compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
 	interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
 };
+
+&lpspi0 {
+	interrupts = <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&lpspi1 {
+	interrupts = <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&lpspi2 {
+	interrupts = <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&lpspi3 {
+	interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.34.1

