Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC916251AA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiKKD2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiKKD2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:28:13 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70042.outbound.protection.outlook.com [40.107.7.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FCE65E6C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:27:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwTu216GPs7arAH0SkFFe6GHnq36ByZoG0vi1KYHGJv9n3VnxxD6BPZJQX/gG+P9b+DgnXcsoZHJSHnIs1650QhhwaTTch6SIxS6T9WYw/o3jfkNl+AYYevryp+b9vCUsDjpTKrrRPUzCg0UV2XFvpyKX/L4UD0Uae2jG0O9kKyc5PjMGgA0UtlYaS8ZjUupDrJCqSyI8ibLdM9hcaoF8gp7vscKmGJIBOxdyiaHsBZSyKuDwF5auu2gPJ24rvjvg2GN3AZw5ImfYg3My4nX0H+H+bfjy/GHX3ktVcdQ9iYLjb1WrV2NVZRyWDOdCWtZUSzqNt8KHVtS2qbY2pbocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqQhrYUqrPGsX58WHIHx+VjV6/HB8iZfsuonkjP5t9I=;
 b=fALoCoN3J19XjczDqgihASLfm7/x9rtt4NEufqY4c+bQM0XOBLWWXLm9tlJXGa1gnlz6qnLgoyzSgLIiogpNJi8h+fAxuRM6cChNdEn1+fszOx40h7ZxYs5r+zuOTMc9TfBoEMYa/2i5iimAQGwASnvx7eyi16ZugXUqu7DIx4e+KsAeWft+omPGxVnS3ijvwQ+vjOcnOAvyzsYYqGsUA5gdNP83IybneAKIo1/DgGODiFcEMY8pVbSxzL7D0n3dJU82t19Jgyok4qp0hZ740VRFjneDmLMqQO7TxLilgDJP9eg67rWMCtmUm5CKUb5zS15q0l5E0crsHz1Dum93mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqQhrYUqrPGsX58WHIHx+VjV6/HB8iZfsuonkjP5t9I=;
 b=LB2XLmCqx6ehCY4QEuRHFcV2wJ7tghTYYMvDisNrs40kiHukheXkCFlGGVnhOOoYsm7NGQsluN/dZTZ3iV1ksbP2mrgC97+CglC2wHMqfTwSW3uF3Rfz5J1LGt0v+rnBYzvt0+5t+3Mzh2qJskDtuIhlszDiw0TGGGbkIIfEZeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 03:27:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 03:27:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Han Xu <han.xu@nxp.com>, Frank Li <frank.li@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V4 05/14] arm64: dts: imx8mp-evk: enable fspi nor on imx8mp evk
Date:   Fri, 11 Nov 2022 11:28:02 +0800
Message-Id: <20221111032811.2456916-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
References: <20221111032811.2456916-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB8PR04MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b697a6a-df19-4da2-cb26-08dac39498f0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U4ro9w9KtfX27eh0q2ZAQv9RZlZyyYLDmYZpz0aEcjT7s/Wdq0e+ax1+kIQ1YmtIEUuauMB+BYqctP/zFSg7NqSkjyBVFIF0kVbYHvrh/TZB33sjwoFBVB9Dm2c6JPV8Am9Y7so1HIq6P9uloh1uMVVFBdFagMPMVEeWSU75ASgNPWq7uxbMCzttYj9jqh3NuO7SHsiVioVkkD9iN1rygIB3VPso3wV2cj+3MROxkXIKhXcl7e+HiQAKpA1fBHt4Ak68KZ2cH05yholFU/wSw/gowF5p1DLge2j5i30bzNZp9VLrKNTzrIZDdJ3+6mSM1vZKSkGnD9UIQZrv4d/Xn7c28yE4XhJ4G7YtBEsTwVeVn9PBvP222A9swfVENFsgnox1OPpI9F/UUHsuOS1MeDHHVcha2zxSwfpqNwLG4bAl0juBseKfHLxSVK2oT0bAy85bdrzGbg55wRWD1WlzH4swUPkFxj3ALnshnMfLPUhtMaWHFmUFg4xGx6Z+duJy8vixD5CeGLhTDS2dx/zd7H2TRZKUxsMXBfaMNbvTTamTMMREytQoj39df9/EjPm4TaVe8VLuryV+owm8v9qjVnyrUYlsPUzxmm9Jb4pae9GfgekQ4SM3RuSPRfyzI08tCQBY8iBP3hAj1XNhe10//aRvp7bSeTNxAvyS+s8QADF5dt0LwG6lln/nq0wBOz7Z2EWYTvutrXEuUwEO2J5S4qV+kKNGF4oNyQwPi4NF50SC+FEY8ODh337XzGK9vKHztnNslNWot6MTq7niG2Ycf38SOK3KH6O61bmW0T2QsRs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(6486002)(8936002)(478600001)(41300700001)(5660300002)(1076003)(186003)(316002)(6506007)(4326008)(38100700002)(38350700002)(6512007)(26005)(86362001)(2616005)(8676002)(2906002)(66556008)(66946007)(66476007)(54906003)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x+fS8x41tA2pCHqNQmCjy1k+e9oH+jmrRHqSOv+BLB2fbeOEz8vVj5J9h7NG?=
 =?us-ascii?Q?ycg2+y2ZmEO2/nil6QO/GuICsiZLdVnHi4kOzzDEyx35kSmyhYvo6+NPvfU7?=
 =?us-ascii?Q?G783SF6JFjnKnXhj2F5CWtVXiabvJX6tayVsubPt2QrOmxKW3Nbfx/Fqc2rA?=
 =?us-ascii?Q?5Q877triTkqiuk3denKQFllxjWfYBkB8miluN31O9595Z2OYiDGBBrITYdTP?=
 =?us-ascii?Q?neg/ZDy3ghQaBDBXA6e4os1SqxeXwjfJZkERfmti1MZew0SHW3PMV/7e74gr?=
 =?us-ascii?Q?F7kUDUJbtWfGYZCkLczLquZNzldSvmb9Um7EEnRdjW/WYrxQlSDTyCMYm4e9?=
 =?us-ascii?Q?7r6oQn1NbY0gPyhdbquzlQAqmjNxh+HSMlZMhY0HCMTDRfv4Wtvkx8TC5YdS?=
 =?us-ascii?Q?n7A31QWfkv+bgBwA1tRisMdEKX+QhpMSHWKwijC94+T62Lq/ntujOaw0Fk4X?=
 =?us-ascii?Q?Oy0dO5O9uRLmIZUUbNbQccRqesQIeTmvI6o5bYHtcb10zlpOzFGH8YiPUNoU?=
 =?us-ascii?Q?gWOn79YGzrZgl7iaCDhmY+W3f/zuIFfpfCwQ+rBA0yimbnHbaGIz8R2DEddG?=
 =?us-ascii?Q?wCdNgkjaX94fm5BanVo1bL2VI+r/xfbe54ORf+FCcTK/JOcfQeDu8+/8A9QM?=
 =?us-ascii?Q?oMlNJOywsXrovaOqVEyIaEzn1IFqUUsy13mpqlCerjxeVdh5o1MyNoccg3RU?=
 =?us-ascii?Q?ZcI6gQTRj4XClsRXV0dOxTDBc/TGe6NDu5SS1NWWttOZd6R9c1v0fp8IZEop?=
 =?us-ascii?Q?HUqV0OBOBGMuo1hoCNG+hxhvRZ0uF7c83IXPTIvj4jB02mnHMwu0t4aacbPo?=
 =?us-ascii?Q?s9d8biJCwcehbZGFENfKk1WAJT10s1nz37Bq2EHyfKGkHkHJUfyeuC14UMkX?=
 =?us-ascii?Q?7d06UbdAQcXFICuAdb5cheKllXjf/KsY6B6gkZZsYhOjCX2QG3fR30KjwGcg?=
 =?us-ascii?Q?4l3hxwt2kKETcOS7YoXDhHdB3X6nB7b7lyALFjdle0cLjA6PHnVFzc/uDtA6?=
 =?us-ascii?Q?c4NwCU4qlbmdHlN6I7SP3nYkrtVszwWVvpVM82GfUquZkr7l0oM7k23Prays?=
 =?us-ascii?Q?9mMp/MBgcz+3tlTQD4K8xni15hjyirr/QL/CtcZGdk4d4Fn0tlkDFnebUTGu?=
 =?us-ascii?Q?1g0q+fFb/yR8KHHKU2UqwJajfF3tGfmRFw0Y8/+pHVtfdO3riVhg1nQysIpL?=
 =?us-ascii?Q?ELgUhI1h+SzxAOgjzJr0xBVwHFva8wRg4DWhkw8LaOsGM0QW2NF1+oMQNDvZ?=
 =?us-ascii?Q?N5KrHyz0hYgNEYOqc2juYH0ZnpOfVI/08DB5wYnKkjT28H5i5+QG5bP1V6QG?=
 =?us-ascii?Q?RqulcZXiLn0ymJPTgbgBqXtZE7neLIr/FpYK1oM2N5/D+8Fl/sMaPvBQ4zJq?=
 =?us-ascii?Q?LUdUpYak2gMJNuLWdAsSgrw7XjKyfJ4NCoBeYQACJClK9qauL7bzjXiYq2BL?=
 =?us-ascii?Q?Xl1YWSHyDYPW8d7BMqSro6i1FpmxWyQNscDP7Y8+mfoPCo0rp/4raPodnXhN?=
 =?us-ascii?Q?LyeXaOGs32B+StNiYFkeOK9a/hVWJkrBUvJKstBIOtk8g/H8o3GGvatL4JKV?=
 =?us-ascii?Q?x/pVXLtVDqbtjJ/dU1DGvNEkxO3ocBiygeWfhmRj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b697a6a-df19-4da2-cb26-08dac39498f0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:27:01.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfLkolUBqdtP1I21XON9nIGUT9Kei3ayDtw4w7Uu3bdlzi9/H63Z227hTSFOb5gpHd5egnsViLfdUsh4JPcpsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020
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

