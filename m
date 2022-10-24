Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9FD60988A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiJXDN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiJXDNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:13:22 -0400
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2052.outbound.protection.outlook.com [40.107.103.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958497675A;
        Sun, 23 Oct 2022 20:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HP0yc4/dWs7BhgVnFTRea8rQh3TIZfyofn7Xl5fkaXmTGV1cMnybMO/o4udFBlgsbtbMnd+jbsaUSTIESmnLNm4Mx9Plf+Nu6Tc2t/8Z/9cb/7Otv/A/IrEBzkfI48C9EHTnhajR/zIgF9kN0KjzdOepcqav2s0oV9+oSfPKbWumS+34nmADzcNZaSC9ETIVt1zPjd5HWPW4LFTAuxx1ax0wpbzXFU6b24keI/yivVIoRY0ROPlPfSJ1CfHB3q4KernlKbUlIlwb1HjnCVArvua42BYwjKeq8vV4hgGfuKS97PP2MN9tkMkkn3VRQU6xw5FtnskIgGUQC4U7lsJ3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbdE3OLDCM+5a4tx8HPF1bTfXT7NcTr6XCQAn8MThw0=;
 b=i9yuOoAMX4k0eMhtbVY5n6+RdAgXNCNbLN9maFj3GGs8yjOFIU4fRQrkXKBurD4A56orTQEHVljBFcxTUCeJhCOORqtnGArRv93sBp6bMziNsAoLNAlxJi63u+Ou7nWQSmhfeWcv3sBBz5Bg/V/DhgX7BEL+yWFBHXdWKOCGYaX5iY8wvZLqHgQT5oR6O0HV/6wpN7XNOk+OyQtcrH3AoczaYr5nb5FcAW2KktkUo0fd/IYN2Lf1SxbKNd5PCdAlp0jS8r2v+zBDCRDbBcKK6i4NgeqcER2qBy27r6H4bugxD3HOC8NyeUM+fYH4UgZnSktZwzyevnMq7/719+EY5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbdE3OLDCM+5a4tx8HPF1bTfXT7NcTr6XCQAn8MThw0=;
 b=HmLw3c6R2dfL5M0kanXTtAavvjk04K6WbgbXQbwBFdODdGLIYZTqLnBCmvGuBh0n3CAirYINhw+MjlQv5shLoN7x4m/PgLQPfksvgaFBLIQo+OR2GaZVK1dUzCdsYo1YDBsbp2cL5Dq0drz/n7+cEkVitbbXfS6kJH1SmDILng0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM9PR04MB8340.eurprd04.prod.outlook.com (2603:10a6:20b:3e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Mon, 24 Oct
 2022 03:12:43 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 03:12:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 06/15] arm64: dts: imx8mp-evk: enable fspi nor on imx8mp evk
Date:   Mon, 24 Oct 2022 11:13:42 +0800
Message-Id: <20221024031351.4135651-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
References: <20221024031351.4135651-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:3:18::30) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|AM9PR04MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c2fd3f-95a0-41da-1d21-08dab56d9e0e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rsVgrNkQ+B4OgXXT7ft3IRPWbdEUBcGbthqMXWhmOuQiQlZ2zHxdgcLegsJfQsDlEZwVhvfNAwu69Kbbh1FDu6EvX5c6N6F22c6Mjc9l7VRflvRasT26IqEFBH65i+a76iFjS+JYqPYMFtA4p4gp6i+Kbiy0BM0LlfO/9mFZx7m5BtymGJlVnRdqxhaBrRdIo9aa/RDs2zrAOmDpbGfVdvgWnb6jqDENs/20lJqhAjsaH+UUKQ6LbK8/7jYVNH3S3fz3e9xJ+x0d0qjwC/F5yZBoVh/TDBY+glFCHc8oXhr+nmAJ5zt609ilVJmz6xw4e6DtRasXens3pYw2QOi2fB6Y1MwgrxGC2o3UYTgipre3R5ICvNvNrkAk7ydKT+kSx5dxicDzoFvmU1H+J8WekQ7b/ZCypNajnFEpgSvCSkK0CeEBvcAgsnhmsShFwkUvf/d3W8kU5vLmLsPFq0TQPNpos8wzMu9vYki+EQK+54o0IoK+Z+WW6xBcd+5SNJDg7vELJOi10UAGEZ4oK4cfN/AgVFIPwfKdhIKbO8gOI4bmQuHQR8hGql2lXmVg8hzXKNY6fKoLVqvjG/0UaNU1HBiefUfTawyUlEXfpgwLJVTucXhj3zYU4VDb/f3XP5i7UUPfp3MXxKppD+BC0yGfrKrfPm/yWU4OwygawmtFmxQn94c7+t+H5IyoDe9fLSbV+GdtahgBRjnpmt1FW6p3JUOA/9K5weeCsNkJHh9S0KQ+2mdtk7XGif2Isc5cseL525vxE/Opo8sy3SN9O+iyGkqld3FyKYXgt6b9/fUilyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199015)(2906002)(41300700001)(52116002)(86362001)(54906003)(66476007)(66556008)(66946007)(316002)(4326008)(8676002)(8936002)(5660300002)(1076003)(186003)(2616005)(6512007)(26005)(6486002)(478600001)(6506007)(38100700002)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d/FemWvkdGnCFkOa0z6YCTxHyT8S2hHzg0XiAP0pCuMwF2+YeA2WTj1hYLkI?=
 =?us-ascii?Q?0SFe2Vku8dNY/P2bJ1VpdgA8VZAQ6JqIIp9JHP1kpImNi0GobYUurSDJKnRU?=
 =?us-ascii?Q?X6JTrapATvjdo2rfifR53ou/lTa32CDFltOy1mKgn/yfVJbt9a2xR0XMoXQc?=
 =?us-ascii?Q?SWawxs7KtZjaJrxl4liP1+SNMZduW3bcjJnVBa6G8DNi9yfYhJVsl4GHGWeC?=
 =?us-ascii?Q?MllCbMujwpsUSzFoB0QIeYZS4swczSNthXDzWRcASwsJMUzFNyoVk1pjnVYO?=
 =?us-ascii?Q?dQnV6ehDFEFysRdlJOwbfLtHJ+oXft4zFGfjvzu1gx3Z/IoQxrKmjzIiNl+Z?=
 =?us-ascii?Q?zeQ7J5xb1oolYTYAh2ChkjqM8D0LGiMzyqSLXlvvENVjHALuSZoV1opNT0rz?=
 =?us-ascii?Q?UYC8NqgfgfPnZWSg71iFQ1i084lqfq+/kZbR9zyHRxkISFHQdW10U/ngF9ar?=
 =?us-ascii?Q?UV4MiM/xYtWoaLZxOPQxhZlnU0AzCdfivVeAIPQb8SnwXud5sWhtf0/1HOaj?=
 =?us-ascii?Q?mxZhmRfEUJaS2CbORLpMosLvkYC97pH74+nkLGrbt126Kpfp5dpdEoC2kLh+?=
 =?us-ascii?Q?LwpvFVuO9yeZB7NxnVFgD3tOnEqcwnfgC/f+Rs4TUb5T2Av9uf6kC4HWDmrH?=
 =?us-ascii?Q?BYwq3tQziuqGI3T6bVHg0w+iupGnqRvhN+DWOjb/WD+m+zWADwelhu4rRjIC?=
 =?us-ascii?Q?4DW1WqfQt561Bws9Goj8ODq+S0YqvHSoylaKt0tgUaF5AFSp7ogv/DWqP/tw?=
 =?us-ascii?Q?wscQ20954EVvSSYsN/eYurwelNUDoR4xZpnAwrHxplQHbHRyw+0pCtlEPmHR?=
 =?us-ascii?Q?iHyuVKQQ1jbdCiDU1FXGfBBruwouwbLn9DzfSPsowIWxDVsw82FyO03/SpcQ?=
 =?us-ascii?Q?vztnHoSPqn/j1gFnsuF3sskFxwBCyZE9bDrtEJ0XgH5Qf5w8Dzl1WWptklAR?=
 =?us-ascii?Q?U3CP1cZ2bQv3LyNQ/aXWB+/WWrHfHshW3AsmzGIWhHF9uHOccbO8tlGGyb+c?=
 =?us-ascii?Q?76AgWaX+m7u8QT7uecw4z/zFDkRXQ+LJkLFi2QhBGgijRcm5g6o+89AM0utW?=
 =?us-ascii?Q?SVJz0JdZxXJ2ZLsdNjAkPMcl6CEtW9HTW64DfrR/37o3kMvUhnhB47zSOTyV?=
 =?us-ascii?Q?jlWmQYSpZQhz5SYtL+QVqYmbmNm8TtHNGSk3HBR6Q1lI5IIThiyf+RE+rfX9?=
 =?us-ascii?Q?16Bb9HPWDmwUlvsP0Pl22GcagstMKpYp7ITCnghWJ8uN5DYGeqwgZjRIKJ3Y?=
 =?us-ascii?Q?nnV5NRxvzJB2vJtF5iSOc9QZpNnnn4qJnY6/VWMDpsRzj0hgEc//jQEC9INH?=
 =?us-ascii?Q?x9BQYJ7sb0E0uVwzDQ2+dFyGS2LQFDObNBP3gK4x4HnPB1ftnLTzgLKgu0gt?=
 =?us-ascii?Q?PmyuRvZ68XO2uU8oMzmZqtzlbu+rm9XMF1Ed21E7xQ2eXQAD3x8mpWm/DoXl?=
 =?us-ascii?Q?+tM47w7+SBJAhMJOOlT8tfV9GBM/2Fsntz/PhdhxkCDEs0O6ydMGdQI0cPEG?=
 =?us-ascii?Q?5R4DRdIVanCpWgI/IkwDzK1HRPilN9F/VGezjZTEj01HkmiNlY27CcMWS8+A?=
 =?us-ascii?Q?RpQDpuCcZeVmji62SWH+KyOJ2zQeaeYkmT/tPt3p?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c2fd3f-95a0-41da-1d21-08dab56d9e0e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 03:12:43.6166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYGaWdv1cyK9dwWf17iaHnEiZ9F6p6/ky81NkD1fRBPfpfAkKtFHZlhrvFjQaqnbd6IpOFE5dRPmA/OSvJLZsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8340
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
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index b8a7de87ce4c..54dfac4ac63b 100644
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
@@ -567,6 +581,17 @@ MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
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

