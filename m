Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891126CB4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjC1Dcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjC1DcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:32:06 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02402D43;
        Mon, 27 Mar 2023 20:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVkilHc5LKiOExncnIgbghAFQHFuBkBCmitAiu+DNcT1l4VliUlwwKlJj6HZZNl4aORrlAsSbtRnmMkJAqQbT0MwW/AqxAPixtBvhHorhRvCo89Fjn4W2+SZhcdf3+L4K8LH4hnUPv8AIFxUqDXF70CgQu5nLN9nHnRtBAK53uASjw6WiLd7cGuZwHUVNNw3FxTq9tD/8RjHwrMHfAQ3K9GkBvwFK3xO5nRk2KPZS3Nfq+VnwV7SkEIcEdMov12OY+RzqGKHM4/NP3H8mhj4pzmTbjriud9NcLRDE01IyUrYYB1cKmhx3IgeH9D35bTDuawebii2jIMo00LP1zRHhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JtV9QmL3donjdhR63nPXhGD/xv21+KgBQHurgFMKCsw=;
 b=GeK3MX4eHCpcOVymBrWTOCKt7q4xc8vrqujucuC7GSyIG9kx/a87zEOBeeWhkAEu5BKKRgeLoZ9PGdRLinDeDv6VTDvbLPRm7Mh8z3e+tslbQOfnr9IC3bVC3JXy3F7TxabSnwfiWRpXxliFxCF8yqwq9yBvQ9Y0erkeTL4PdGljWO7TIQkQOhH5r39aerDJSnfYcdUoDJTxR5qvnEwnPxtsKeUV2y5Hn3Cr/dHW2KZS64LQO7kynjF31ZIEprHjlk0dr/N8DK9rkdAjttf4DHF1znPiWiUhzHPbZBEQ8OIRjhQv8fBQVlr/ccqSZKohRQUfH+KZ1qVqpAUPpjg+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JtV9QmL3donjdhR63nPXhGD/xv21+KgBQHurgFMKCsw=;
 b=UD8qZ39a95KlLoMMmUYUZucJTZ1urguZT79YxURZ7vshX8yK3VEICQ/Xlizx0ZMG9yMFoo5hN8qTu+sbtcHb4c8txeDypBDuup9hIa1I7RNd3OHfa0Z66YhHicKrsSRNfDmFtz2AKIcXXuh/poPGqu3W2ChHLg2lJtI26X/92vE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB7184.eurprd04.prod.outlook.com (2603:10a6:800:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 03:31:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::778e:19d0:cba0:5cc0%4]) with mapi id 15.20.6222.028; Tue, 28 Mar 2023
 03:31:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 5/6] arm64: dts: imx8mn-bsh-smm: update pinctrl to match dtschema
Date:   Tue, 28 Mar 2023 11:36:39 +0800
Message-Id: <20230328033640.1930104-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230328033640.1930104-1-peng.fan@oss.nxp.com>
References: <20230328033640.1930104-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VI1PR04MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 627b8351-3abe-45b7-06ed-08db2f3cfa8d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lpqEVkfHmTApW0+Bw+Hu6Dls/YRrMQzmkd2RAelV0rswuTX33cc+q2tF0citIhwJ+2pRd2ULo01YDrmKklniE1DdIHANYtFR1855YEHX8F732xEC08/3piUwHT1Q0tltqyz4YNLgxB+KfWF+hO3NvuPrzehHFHi3k8XzuNzVmg8sfmZr2HGYH0fRgFGqoPFYhqwQkh/DyaI115zKd8qN/rYmxvhfSaU3/I//0AFIMMfkPFpmZq7hWkeZZyyZ0DRMw7/Gz2wWZXBsVTfpqdOOQG4K/3Oo6h8ESisU6NNkauMRMDrg/TPl3Ldskp1brhJrwidYMbhOhxtXF3VzguNmiGThCuLaXQjzlCINWNfyhXL4Y89R16hI2oP9JlTmwY2bs4sCET78RqD3FrxNlyKxMJi1ogLWZ2VSEXQQQmGI4hgzZ5payDdbc2vxTswEljmxWsJrohfgozzgzi6Fgpk1ociqVM6Ym5U1IzoQzm9qXRM1GA8uCBxiMQbFXjJNb3NERBVgxvS4aEOGIF6M+9XQc4uKH+kJrq5g+cvc//dGykFR8eoBXVdqlXWjWEfCDrZyDkxQFOJRyqOOs5ebjRnegCqY4Ehx7x5gUeWY4vG6HIozlbtWuvbsfZtgPPrpxvLsdulNdyo9D1HIfJo9VtVj0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(86362001)(6506007)(1076003)(26005)(186003)(2616005)(83380400001)(6512007)(8936002)(5660300002)(6666004)(6486002)(41300700001)(52116002)(4326008)(66946007)(38350700002)(15650500001)(2906002)(38100700002)(316002)(66556008)(8676002)(66476007)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ox1pXX3xbCdznBYc5voY3dfaN9gCzlg6D1aLO5vm8fOC1d+pqh7fnWnGS6m?=
 =?us-ascii?Q?7UCwm4fSf40MpxNLVGDHeeSGG2Qbr3iB06k//vu0g6Y7KzDahQnpiw8lN2cS?=
 =?us-ascii?Q?6gC4Tqt7yzUUgvcV90SL8RJKiY3vzhhIiX0DFjUCzt1rMbzVBYHO2hU/HQAi?=
 =?us-ascii?Q?1BID9KMK8jmp0wTCcw4KJsuj8dWlovTYNTce4E3oXR3yF0W36/M48npbOcB6?=
 =?us-ascii?Q?XZKanJovsa6hB/7wAu1YWfH25WRxr0L7oBc3OnKxkT3fUnS+l4hBrfYGBjH3?=
 =?us-ascii?Q?Ejzee++Idby49K+uLaTQtCXHZpL7waLcNFk/boMiu8B1TYQ5u4MgR7CdmlAs?=
 =?us-ascii?Q?0BJBB2yXW9MkbttH1mJEfGjP0X2pXiyDBNGa6c9yLVxZ7v7CCYiA9Eg0i1vQ?=
 =?us-ascii?Q?4oADXlwMLr5WOcH4oprMwOlMM7YvGwX1VxxufUuvl303D/v6j8vWYfLTP+Qc?=
 =?us-ascii?Q?+y6/Bb/ogDbSBjdtxE2yDGxAI/u9vCtQRoVxyI+IdXR4MDKFXRZrX+VUi2jz?=
 =?us-ascii?Q?u3WQpmLV6t/Rhf2NQ++mOdT5Z4BKJ2oPFaacWvH/iqxbxoEMBoyoB7B1tIjJ?=
 =?us-ascii?Q?oCAYAzpY4gyLg37qgSgrLM/LmZ1+ipOyHEvi5mcbITDGOQA+4/DXM98IMCwa?=
 =?us-ascii?Q?sLzGb5Sy668A7xMZBdn2r7FI4k0i7uTMrko3veOqPSLjHtDoodh7RrO8GL0C?=
 =?us-ascii?Q?QaJa7qnQoKyPU0c4X9tftWUfoNoqztsy2RGvdo2LiYJJFsQjXi+irm+44bT7?=
 =?us-ascii?Q?R3Em+KCHaAiWqGxghR9FyRE7AOY7lK+CLOMX6cFw/MB7fgnxc4VaRdQ4/MYg?=
 =?us-ascii?Q?vCWTPCnXua44wkd1sopeQQZNr/54QiOi8AdhlKjLYzV4FJV9m2GS23xREr15?=
 =?us-ascii?Q?jr2utOtbmr74EdcFqdAIi6uJXzMbjzAAime1qth4QXeChJGz/3fr1rmwfVaI?=
 =?us-ascii?Q?ViA1+JqCxkos9yfWUrFCojHxdl2BuWbibASVpAMi4m8qSpvDKWgczWoPPRyP?=
 =?us-ascii?Q?2eziTaCsiSqR0BE+2US4lv2/r3WhU3q+LpZEKl4qr70Iu4pOWFGIm6RlGHKb?=
 =?us-ascii?Q?/nfQI95wN93UsQG3RR8tNwOiFkUIXNF1qeruvuGn/4QhexHp+GdDmuzETFx6?=
 =?us-ascii?Q?y4eaSRhtilqUfnWe10eEBSDL7UOlOJTGtmBk3qZTMqO5BGtrP2tTwcZ1791O?=
 =?us-ascii?Q?b7vFfl+vKF5lPB6ox/eMdA22Pcx+VmrM0sx2abmR/QpF0hOYRXLvAQ4vWtaa?=
 =?us-ascii?Q?7LquQ318aXz0yPzz5J/aW5KYJZlatylLuTeJYg4M3qDLqQJ74y8k8lXyal7a?=
 =?us-ascii?Q?QOpRXX6FX0haGK8YIW1mE3yWL0gPSxQERXuTiUhIQL1OigpoPEUAucUTO6yq?=
 =?us-ascii?Q?8fCickxAeUTlE6PeDRqwxRpGtLgudgxDqooVDtbK8Y3v9x+5X24pJrwcL+kb?=
 =?us-ascii?Q?yC8nNSa9MYqcnKvzAFbcgdaZtzxCLNaGjoxDNTd2werAhDqPOPMIfipHdx6y?=
 =?us-ascii?Q?8odZy0FemVB2NrI/apE4tgFwYd6juYkF1IweJXsDvpGsJkPPiPa8o6XQz+Hs?=
 =?us-ascii?Q?EEPIYXoFQy/Mhkg+9IUFFPvPGHTNW2KW9cDo4lm0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627b8351-3abe-45b7-06ed-08db2f3cfa8d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 03:31:55.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8xgJ9I30toHL4FLA/Yi9rg9HebCraJQcV6wJ6SKD53tttP2WVh1iTczwM2xBQV2N3zfAu4/Na2Pf4HzwmNWWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7184
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The dtschema requires 'grp' in the end, so update the name

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi | 6 +++---
 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dts         | 2 +-
 arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
index c11895d9d582..8e100e71b8d2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2-common.dtsi
@@ -341,7 +341,7 @@ MX8MN_IOMUXC_I2C4_SDA_I2C4_SDA			0x400000c2
 		>;
 	};
 
-	pinctrl_pmic: pmicirq {
+	pinctrl_pmic: pmicirqgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3		0x040
 		>;
@@ -381,7 +381,7 @@ MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x0d0
 		>;
 	};
 
-	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK			0x094
 			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD			0x0d4
@@ -392,7 +392,7 @@ MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x0d4
 		>;
 	};
 
-	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK			0x096
 			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD			0x0d6
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dts b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dts
index 33f98582eace..7acc5a960dd9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2.dts
@@ -26,7 +26,7 @@ &gpmi {
 };
 
 &iomuxc {
-	pinctrl_gpmi_nand: gpmi-nand {
+	pinctrl_gpmi_nand: gpminandgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_NAND_ALE_RAWNAND_ALE		0x00000096
 			MX8MN_IOMUXC_NAND_CE0_B_RAWNAND_CE0_B		0x00000096
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts
index fbbb3367037b..c6ad65becc97 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-bsh-smm-s2pro.dts
@@ -136,7 +136,7 @@ MX8MN_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x090
 		>;
 	};
 
-	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK			0x40000094
 			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD			0x0d4
@@ -152,7 +152,7 @@ MX8MN_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x094
 		>;
 	};
 
-	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK			0x40000096
 			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD			0x0d6
-- 
2.37.1

