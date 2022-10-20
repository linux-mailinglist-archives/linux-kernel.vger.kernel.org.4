Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CACD605C54
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiJTKa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJTKas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:30:48 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA96B106A7A;
        Thu, 20 Oct 2022 03:30:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lb0VWPNqIQrEA5trmCRqN1xyEiLy1vEm8GyXne55MtxI3TzqiuDVBODMl0nguYl5UBJ/ADiYU7zFIqBRc5DJZS4bC/+8cwry/7is0RQ05tpRR2GZaLBVioZO/RYVyeCP042nC7qBgI4Ck1O8Lh9R9MbpYnyo8rwtYIaU/NNnV1CctjHiXN+tetOug1NEOVrQFLBTvJvajKPzLK64U5dnNCyQkKb7QcV5mkrL8bEDCOA1zovR8nD0I8+xJXYzgBEjEZ14LQqPbj6afCZul5b+kVY1Nu2nGK4f29ZDPFhm20tGMESeFYubwXvh2UdbZMFU8wEedcjR+6F7ROdP7Ud7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IL27iNoVpQA+fi1urMB+H2wOV00FlMxMfQ08Y4hbCDM=;
 b=NuSljQxstlHM++5EwdQOFfYDvWcqfm3dcqQIGmzFL8INDT5aTbNHNcg6fez/IQEXM7OJjImFUuYYXhZQPj6Kpoqgd/eaVDK6nVIcoTRbQ9TvaVDdvJ5JIU5foFjRBf1Lq0JOsQyM0KyN06YbhyGNiuGA4dWx0ykqhyg96QP+ovL1qI4y1/Aecfh2eK+GcAZzRRpFXJsb6vV8eh+2kt7kA+AHXAzGU+xAUB23xy3s2nIdVNOC4WedDbZpmJhI9eXioyA9Va+wlaEKTo07JDuyM2li9d6pb+s+zWs+hMELrBqzaR/4enD/d6l+MY/bGy5ddg2s4oeFHSJHoXYxBMNd3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IL27iNoVpQA+fi1urMB+H2wOV00FlMxMfQ08Y4hbCDM=;
 b=Z/PL+ZR+aiLsnqa+NX9XS0/QKE+IzOvySVnFKbo8cklQE26LQ4pR0qLECaMTugtzot+8nLKDYCk7cFVkG7XvDoK/A5LmlijlGBmLHV5ox1/leUdbWAqjXmF4Y/kdl++sowi1IjMTdJElBrWFvNzn1083MTivEi0QBazySoYc/Fw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB8060.eurprd04.prod.outlook.com (2603:10a6:10:1e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 10:30:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 10:30:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH 2/2] arm64: dts: imx8mp: update ecspi compatible and clk
Date:   Thu, 20 Oct 2022 18:31:58 +0800
Message-Id: <20221020103158.2273874-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020103158.2273874-1-peng.fan@oss.nxp.com>
References: <20221020103158.2273874-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: d15e1e4c-e335-4824-213a-08dab2862177
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6K9n1BLDHPDqe4BwugOfJDhEoudDn9cnDskzh7fb+S0FeExHC2OK1qtbTQXEqegSKb9jdt8QwWhDdqGk4WIEpLP+SNvnAsGIkNGqbJUBAiCxyHLciRR1lIcYvJUfMQTUrCGD/l3Yf1vzv24a2Bu1cOOTJVPWZlzdJncYumhfwMTTYX0nz92bCSQSV+UYPXr2OVkY6BKFPYMJZJEqJFRvwUOHgHN/I+XfW3PqEPGSl+43YxT066+EctIwJeXAVM9/Bkm2Skdzw0bf4I3auWn0CN6iwuOIdAprNRId12684m/iV1AkBvIRE1E24qTEfvgAhLlQeLD/Hb3WwnSU3S4qavS/Xx8ZSCq8lIECY2Q+LOZgQwe5w3WtF0wxEdUpSev72G+vNCYFt3Uc9J0c+e6hTWQsrVMSFWP5gYUG7FH0Yg1PR/bvrxCW6Rf0E4dfKA8MfEqBwCbjpx0omT72wwhZupEy5pM2tlhzAX2WrWIlKXN+fnzaRqwDgcAS5HAnzfdV/Me19+7OtUpPlm6+6AgtIpT3phpP5zKla4XHkXvV8tCTzuBBwk5pUSwSq03ITrQ+hhxkg1T3tDddCNCWna4o8OPPy9K+bI9YINw+Y0dBeYGsr8puYfIDcrg1g+HtzGpMyk4xx7BbOjbXWmWqvpcMDO4tgH+f9AlNnLfNZf5CX0jy5MDPrZhGs8lLZkIDslXjd8NLBTxRWiSWRS/b7OfG9pXEVOIri745uB2yO7I6MPH6zu0074mOJYA+VaPPFAFkHwCAXLdnsIiOOd8OlBQf/E780d36TXwV5c04Z5LOki4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199015)(4326008)(54906003)(66946007)(66556008)(8676002)(86362001)(66476007)(52116002)(6512007)(41300700001)(83380400001)(26005)(6506007)(5660300002)(7416002)(316002)(8936002)(6666004)(2616005)(38100700002)(6486002)(2906002)(38350700002)(186003)(1076003)(478600001)(15650500001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZOfX/jFhpMUMOiKwCvgVxiIEJRkudkNnC6ZSZCGeQMNwLKDt/niimGY7yEuS?=
 =?us-ascii?Q?FQ2IJwmA7bjPNU+VY46uJO9e5R5w06rC8Tiz8V0ujrejGv/aGHl1cH687R7x?=
 =?us-ascii?Q?knH2gNfEWw60hKXsD3OwDKd63BUtBV9RUOkIK6GoiJdbDn/NC1vyYCw4wTVr?=
 =?us-ascii?Q?D9/OVhFFCGFvUcgK+ZpT+viU/Xjyzs6VMPzoGKct7xnR2s1hwPHWIZoglFjR?=
 =?us-ascii?Q?maJzCt24orconCNMbOpaOSiFndJ28neaHt3hzd+jxfLpivY09cyvriaxSQ3E?=
 =?us-ascii?Q?Xygb5N5wCLY8EFrGjmFVsUojUmvqecz5B1xTH3zpae2kC2+deD52ELJZrzvL?=
 =?us-ascii?Q?Is+ej8h0yYQdf/0HV8BSAnyADVMgoxOPr+qBvN9cuYTzzyuhOE+M3TjNEQx4?=
 =?us-ascii?Q?XBfHLX2KqvSCWCVIUqVBNixqWr5KA65fc7CaFiW5DeTwA1fjSNKRm8vnE/Eo?=
 =?us-ascii?Q?Z9JVo1KULTS3pRpp5XpDOMgE5SS6AxGhYxy4oTUkicWvv5zwi7JOZEgcZMAP?=
 =?us-ascii?Q?5sr1iSd+K7pKBrNOnbZ9lUhrY+whsmAzupHOqLPhTTerNm59To7iqU0/8TOy?=
 =?us-ascii?Q?ACndSK1Ay/yNMYpLkS6t3iXVsRqxa+pnJDZpqxz+KSYm89a97vtxFVKMC9Fp?=
 =?us-ascii?Q?3BRUaED1ZK+l1GdpJU6+zqbS58yYmygiYXtdMjUzxDS0LLuLJ9ZYetFQ3HmW?=
 =?us-ascii?Q?f4kY2sXmQMK8wW9qxOIPSpHNepdLHqYBkyjDLO/ofUBZb9AdkGeudpYrLt7O?=
 =?us-ascii?Q?oqo8V2/hmJfU/NaTH0/bE167gejD097Is3HYQQkWF5OeiYSvRM9Pwj/Udsnc?=
 =?us-ascii?Q?I/c8rOWJj3G8RCrsmM4AKxxaBNLQ01+iB2EV9g94nfhDFTODMeqvY7BsS5/+?=
 =?us-ascii?Q?fxxM9ISySyGFd7Xf9Doo7gNuyYgxkJ+DKJgqdvsyFZm0Vj84ivgQsIc5CWZi?=
 =?us-ascii?Q?9ivx8CgOOTbIxxyc3Sm0fGmocbbJuMlBzY3shJk4xJON5m7Y1qwO9BpCuIxt?=
 =?us-ascii?Q?22AtQstesKAOTIWnXquYSZG/NyQkqAxTVjEJJTSDSa+hi1m06WRke/LHfF/E?=
 =?us-ascii?Q?jwX//QnRM5N3nIJFfhZZy7jEHyERdXULT3gSmLfxqFu63NQY7W9iSsEml4Tt?=
 =?us-ascii?Q?Xj6TFfka05B7UkN/O9eNW2Fkaa+uQBvsoigTAJrGmqAhcbH7c8HXF5TufJYu?=
 =?us-ascii?Q?vuFJhoRg7kilbRysxh44CQwKYnayssTyGgy7snveCOm3mesSUl9WTrZCK9tB?=
 =?us-ascii?Q?BEXaLCdWyv0GZoud19vLxbOpxGvDQAdXFKZxTnxY/eBWG4imor6nxtzOOFAh?=
 =?us-ascii?Q?afJlKBlAjKynHBituzGRcSl+MZqhQXGOpn7uG9zv2YedLydIYVXR2On7kh5c?=
 =?us-ascii?Q?6hAKhpjPbtF8XTKEyC3hIq1WCe1RGsZj1496mzLQLWWfrQKr2FybEx7UqlN2?=
 =?us-ascii?Q?ApGaAoLjI8scKUiWrHVCU7GndAZkWCgXgOdEYmKqexAhEeFZ7zvWMC8dd9WZ?=
 =?us-ascii?Q?II/AGMS5Q1DvDXfQN+1js68SV1q5VLggBQIfreZkIEcSEI7VbR7nVJmbS7oo?=
 =?us-ascii?Q?rmLreefApZKgEW6qt4S553FQ5NNZAAvfjujXkal1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15e1e4c-e335-4824-213a-08dab2862177
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 10:30:38.6131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ck+N/7XNUhkwUwLtw9cHeyrCe/ez0+Ch2mF5hGMufvJpKhQhlgfFljiWtd5l+QbXrCe748S2Vko5bK8CBJ2gnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8060
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP ECSPI is derived from i.MX6UL, so update compatible
Add assigned-clocks settings

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 732a87179edd..315902fa34c3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -713,12 +713,15 @@ aips3: bus@30800000 {
 			ecspi1: spi@30820000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "fsl,imx8mp-ecspi", "fsl,imx51-ecspi";
+				compatible = "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
 				reg = <0x30820000 0x10000>;
 				interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MP_CLK_ECSPI1_ROOT>,
 					 <&clk IMX8MP_CLK_ECSPI1_ROOT>;
 				clock-names = "ipg", "per";
+				assigned-clock-rates = <80000000>;
+				assigned-clocks = <&clk IMX8MP_CLK_ECSPI1>;
+				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
 				dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
 				dma-names = "rx", "tx";
 				status = "disabled";
@@ -727,12 +730,15 @@ ecspi1: spi@30820000 {
 			ecspi2: spi@30830000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "fsl,imx8mp-ecspi", "fsl,imx51-ecspi";
+				compatible = "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
 				reg = <0x30830000 0x10000>;
 				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MP_CLK_ECSPI2_ROOT>,
 					 <&clk IMX8MP_CLK_ECSPI2_ROOT>;
 				clock-names = "ipg", "per";
+				assigned-clock-rates = <80000000>;
+				assigned-clocks = <&clk IMX8MP_CLK_ECSPI2>;
+				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
 				dmas = <&sdma1 2 7 1>, <&sdma1 3 7 2>;
 				dma-names = "rx", "tx";
 				status = "disabled";
@@ -741,12 +747,15 @@ ecspi2: spi@30830000 {
 			ecspi3: spi@30840000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "fsl,imx8mp-ecspi", "fsl,imx51-ecspi";
+				compatible = "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
 				reg = <0x30840000 0x10000>;
 				interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MP_CLK_ECSPI3_ROOT>,
 					 <&clk IMX8MP_CLK_ECSPI3_ROOT>;
 				clock-names = "ipg", "per";
+				assigned-clock-rates = <80000000>;
+				assigned-clocks = <&clk IMX8MP_CLK_ECSPI3>;
+				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
 				dmas = <&sdma1 4 7 1>, <&sdma1 5 7 2>;
 				dma-names = "rx", "tx";
 				status = "disabled";
-- 
2.37.1

