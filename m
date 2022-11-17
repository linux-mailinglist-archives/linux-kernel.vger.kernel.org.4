Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E64262D77D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiKQJxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239435AbiKQJxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:53:12 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E4870A33
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:52:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4c3/0LiHKPoIVW0gc/9fdrdvqPGARYNy7Xa9XbHaJ1Zg7ZpOKKAxlbD5KSZWuGx/Iphnvy/TveLx4FXzEi8sxFhoD1C8upxTfZWGkl3asMrdqoD4xfOaasMkcZ8/9R7tYc+TIO/RgvPCA+RZOZpHblqWT8Yg4/jBozIRWXCGclABsF7Y7QbzaAR+fJiGYuYLxdTr7Xpfuge3qOwewvEcb6bbjEV/SRcKe/Y03h2qASZz0RKwrloSMdfYZvih34Fg+TKXcJhgEQopr5UQOkkIYVmlbQl8oxkgvTG8qJxw8V633E8wAlpE8Cp0chGgMoWdpbW95g/M/BMTM51hZEGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqQhrYUqrPGsX58WHIHx+VjV6/HB8iZfsuonkjP5t9I=;
 b=mqaQLVTWj+XoFR2AcadpGE1MJD3jrRGOZVacj8BQwiVVnLCSomNAeb5vG8TzeCHlSBBGfvt5DlKmtSNczLrYxzGyDqZIPoeSg7kcvXOHsNYaxcNWkTkQE/AMvoietOQMSBnRmnLadMi4Su4da6xC02DJzugixFtGdIArLOmd30pdRAqIH+Tv+fIVNtLd4IDqn9dwyA90ICjTs/siUdjx01X9vUHSdeYNzux2KI5ZcI5qDLvRaixuQpdbD4G+XZqsKHXT+ZOOJdcIgg3fhwjE3BWuSXSYWDd7UaVRiZHGIuxKTgLqm319SFLT2ZrG0oCWjWb3CQaGRXsxtLy/hiXs0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqQhrYUqrPGsX58WHIHx+VjV6/HB8iZfsuonkjP5t9I=;
 b=lJ2aGnBQOQNyxPup/TprMg+sjE7N4qphjmR68o3f5J+aMa5tumWS0qp/BcnJanTSw3HaPnNOpbze9svOEOM9xa21K4G2l3mzMsNgualopLAbhr+/BmCGBQOmbf/F5RSRvTkGeA+PngcTQXCTONvqL65eSEsNkR4zOjhcjy/Q/84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8223.eurprd04.prod.outlook.com (2603:10a6:102:1c9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Thu, 17 Nov
 2022 09:52:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 09:52:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Han Xu <han.xu@nxp.com>, Frank Li <frank.li@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V6 05/12] arm64: dts: imx8mp-evk: enable fspi nor on imx8mp evk
Date:   Thu, 17 Nov 2022 17:53:56 +0800
Message-Id: <20221117095403.1876071-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e59165-411a-49db-c358-08dac8817f92
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mc88P3wO7ho4rl/jqDqhvuiH3UkIe6YptbeFifvXfN6rD9bBOc//SO3vPA4Bo4oDe1O/ha8gnoevJ9b3nTwA7LaFV+4F4p1OyvaHIO9pVp5kupj13aVohrx0G2xJIOKgCXVzCGM1Xjca33nwV3HGvFeMI2tcSaELedz7RIg2lwZEP0eSzNELB6R6mDbwFDTp+nRdBZ8nByxbBuK8J6cNntaI/mhlQLcW9p4VPolSG6JYEpX21A1UuP2ZZnUtGu0K0xnuOFRWJ2/etC9d1Bfi7Yx4YOeQnbC3DjlJ7+j4+lDRr33lA5+yKtjnwaVxvqvp+qvMO55wAYu8ytmU2QoL2HGZI3twYy37zAzMZWO3oJ4lp/VQAWzXa2SwKVD7PgjWFHfZ4QgNy3UVmd4CNRxnxaWUk1j37iSP48rRFSdBl8E0M0qYTI/I1iFUVPn8yDuPcfiAP8/QAcQy9V89aOUIK+b3HcN6UukrjV37FgqevcyFp8wTRDUZQKUcGfmP9h2oUKohrx9accn4Ldr9WZQ1e7HrqKCfQrsfVn3iS3bx5Cf7lrTFgcPi69/2NH5SXyKVaY5hn+WNtbBk/31l4bQqJYWIXpyB3kT+kpG1Xoo7JwXYkOo1T6i/SUP6Is+u7Virb1kTXDfuDvPk7BnR69NsSRB2Tg/zTrWL/1DTqOpIHJ866BUEYN76aijWR7B68i6KgcShxQMXCXMc50McLqfS3AUHtGxnI7iDBP78B7zmgP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(451199015)(86362001)(38350700002)(38100700002)(8936002)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(41300700001)(5660300002)(52116002)(6512007)(6506007)(26005)(2616005)(186003)(1076003)(316002)(54906003)(478600001)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yljcBi92H59Auamw/HPdn9LjD/WQggKaKyM/QhZil5o0IbU7d6Qz5IU6i33P?=
 =?us-ascii?Q?RODfLVZuZLO/7lRxv5u++BD3bd7R4K17mgbImuBzDTf8+1Q47yrj2yQfuEYt?=
 =?us-ascii?Q?iLgRsTWc8ah7ModwX5cDmi2xWjTbVouAMJBt/f35np2thYHn6WeZ9QGEXe4q?=
 =?us-ascii?Q?XbyERFJGxtPDGexuWtlvQpqPlT0T93K+SNSsuIdQ/0ebqxZp2ahz62zhr1HV?=
 =?us-ascii?Q?o6TXsTvOTWlN7RQswzNVRZ5R9KRLP2HXCRdgoDZVDy4Mg1Xp3ZqNhHhch3Gi?=
 =?us-ascii?Q?Utr9i//W/vPO2jUIYy1Sn7shx9Yr32H1iip4FM4w59Gau6/cnq0sNeTCHcTc?=
 =?us-ascii?Q?iIXj1RuzbkZCwuOGYc/o7viuciQ70Ol+NcKhY1x47P2Vd7wxvtIARRmb4Ra7?=
 =?us-ascii?Q?8h7rCPA0r2Fskz2If2fioAaaqGDDobbCf4CzN/s4/0YRKT+rebYbtpCPPrQo?=
 =?us-ascii?Q?ty4gZgQlCv2Ka7bg9aYFczxBeJas7gjIcVUq63Y13glNBFf3NwyxfhR1NY+2?=
 =?us-ascii?Q?Fo0oe4HixwqN9HX2vzqEM3865Gw6fQLTpnCLSHcNuoGBNWf5XwomK47GlzTg?=
 =?us-ascii?Q?Gf/Xt53LdzffA5UP8fmjyYuyAU+KrJo+bIQ93L/9uDhfK0gMgP8zxD7XkkK1?=
 =?us-ascii?Q?WVvYjYHQfLWFAm8w/On93sUhgWKVF9frjCtBaOIkqZH7AYVm06WmSOZFfBQ8?=
 =?us-ascii?Q?iu8jUGUDP1z/uRQw4lt4yfXoHK3k6Y3bNkA1fskWT20F2eabBEzYLYEM+v2c?=
 =?us-ascii?Q?fMZXt2uTnYYsCL5pxhckpPbINc3bRhZY5irTKOheHDFhAIkTrHq8JIkCwZbF?=
 =?us-ascii?Q?kpaNHNR5JwZfMmTLXG4OGHpUMEt1+dgr8ebqGoi2iMZCBfonFFkHH1eSBJMw?=
 =?us-ascii?Q?CsGqOi4iigqOM5Z7sECjEwH5GMDNLMYdMIYep4qrNuUtFwMYAk5i+1ydYyjL?=
 =?us-ascii?Q?AO81ZnXbjCRYSJZVifUetJ4O6KAXc8+fWctc0hSmd/pmTl7crgg9yJHpbnDr?=
 =?us-ascii?Q?v6n82HH0qIMKNg/pNnU03MXZzlY4zRU3dXiHEktq/UMR/sqMMSehkz6HFmHg?=
 =?us-ascii?Q?uxPHzY/rOkjWcSXH5o+akJrIOYq+7ms/xtFu7PL/tOlEm88o+Lw37uDQc8fI?=
 =?us-ascii?Q?QXayiKARa/hkqWTV+rT2icWzNF8MJ2KUfryDgieIWeyjmR698DewQD4z3c4N?=
 =?us-ascii?Q?8cWw9dv7pl8J8jNcUUXvbOGfDIdvUl7ZnVlGjV0mrbn268yKnJLA1FtNmLOB?=
 =?us-ascii?Q?cCpwgt/f5YjVO0tWCR57NIcTFskiX9oMZZJeOboMtvYrWc/pjgK41USKDnGG?=
 =?us-ascii?Q?ipd9Hu2WiAusMDUEA3I1loznIsOKctgYhjHsKtjoqS9Uo8huo0N5mJ658LFv?=
 =?us-ascii?Q?YYmmH16QmFsE5tNlrQt5WaMrND+81Of9I6sB93pRWf02BC13dErTatpJJtOE?=
 =?us-ascii?Q?z2iV9kwr3zmhP+o6qYWckB83AHROFsjCONXbX9CLmuI8G/PtSH5mVBD9+PJf?=
 =?us-ascii?Q?kQIWQRr6kY3Yzy+tJwME1862OwuFDoSlee34hxpJ3S9bxu45YSBvWkqay0Vs?=
 =?us-ascii?Q?jxJtu1fG/NKrKS9Pki8iQh/vcudn7U1QZ9yrLp8U?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e59165-411a-49db-c358-08dac8817f92
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 09:52:54.5507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xq8dtB/DnN8mhWcSausFID3Zkl4c5ROJiCGmcHSnJvud3j6faao4qW7xlujiaLqnxeU/076jtEOFKLoF+zNXyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8223
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Han Xu <han.xu@nxp.com>

enable fspi nor on imx8mp evk dts

Reviewed-by: Frank Li <frank.li@nxp.com>
Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 29472502d547..4164f69a89a6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -85,6 +85,20 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 	};
 };
 
+&flexspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <80000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
 &A53_0 {
 	cpu-supply = <&reg_arm>;
 };
@@ -551,6 +565,17 @@ MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
 		>;
 	};
 
+	pinctrl_flexspi0: flexspi0grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_NAND_ALE__FLEXSPI_A_SCLK           0x1c2
+			MX8MP_IOMUXC_NAND_CE0_B__FLEXSPI_A_SS0_B        0x82
+			MX8MP_IOMUXC_NAND_DATA00__FLEXSPI_A_DATA00      0x82
+			MX8MP_IOMUXC_NAND_DATA01__FLEXSPI_A_DATA01      0x82
+			MX8MP_IOMUXC_NAND_DATA02__FLEXSPI_A_DATA02      0x82
+			MX8MP_IOMUXC_NAND_DATA03__FLEXSPI_A_DATA03      0x82
+		>;
+	};
+
 	pinctrl_gpio_led: gpioledgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
-- 
2.37.1

