Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5143B62D783
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbiKQJyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbiKQJxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:53:17 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFA376143
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:53:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxzXJsElnytJF5Fl9NjTFZ3bCwp9TgEAv3B9abmSmoknvOTXjoKhFxuU0YA1wB4eaP/QoDFdSPtHrZu34XBZ2o+I5gC6FFwyDJQt3I/teQqOTr3/Xu2FjY3l0ng6k0nQN1OEo5TWNjV5NY+GIVeU7NP/b24ogDkjMXprCaxFpYyRZ2sB3/IfFxwCCrjXvJsi5+XccJkVnyDq8cLjgzsxUozlb9bDCzmAUyU8WtjcLbl5gVO1kmUDncp4Gu9t+LqrVwzl21H8f0HesjtE8qtcSKKctCA54knkEPd9HaXUfW1ekt01Ue1+ScPDjC2tDCKb1IR7c/ozPC7qCF3HR+00yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XQ+tn+AQ5Rz0zhv0oCeoG3hmiAdSwe5QLsVwoE/ktE=;
 b=E2vAiGvREE4NHjIv5JCZ6DipHqcIYgiwwlt9fP+dd0n+RIEtEU5iZl989hJQ9ZX2wUT/dR2DvDZJONXZWCVfikP6Vs/WoDzl7nUYp/q8tLiIvR//qQ7qn26Q79A4C9OZ4psCIjEdUbYs/gSpKO4LbiKMlspZWIvAPyDXq2DSIcHcwBrkld+V5zpeHZYGxI2DqrmE1FH/dee5942Z71UscLmbbq5BRpzNcIM7+GGhwhLreh8UW/sGw/vvYBcP+arXXwoSxmelCh24YY0Ho129PyoK9F/b7zb64DZFKiPXE/Pb0UbJvLDEEVU2C1TZOB54AIFZKYcPH4gAfSkzbUk+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XQ+tn+AQ5Rz0zhv0oCeoG3hmiAdSwe5QLsVwoE/ktE=;
 b=leuwv5mUdIM0y2TQn/Z2Vmj4AbGqS0goBuYTABO5n5Ya4+sWE62CHRvjMZeIxi6EIaXdBwzZoYNZZ722O3ad+0Tc1iZZh4z62WGNH12uUEeCsD1nvElVEW9lPRY8S6pDA8J/wVtoBw9UP3CFBYM/nbqkaN++uvqVhBqoXUiOkPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8469.eurprd04.prod.outlook.com (2603:10a6:20b:414::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.15; Thu, 17 Nov
 2022 09:53:07 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Thu, 17 Nov 2022
 09:53:07 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V6 09/12] arm64: dts: imx8mn-evk: add i2c gpio recovery settings
Date:   Thu, 17 Nov 2022 17:54:00 +0800
Message-Id: <20221117095403.1876071-10-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c18bcb9-71e2-4878-9db0-08dac8818710
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fb8zdFDwViyaawzBV+jBSz2nxrtcPM+jL1iA9Gxlk2Ys7fBaGJUIpHE03pzd10u4fa0mdSzonoq9VdHehBOA5T3MJTJbxO9PWt8wb1oEfxx1aH1Jrg/zzLP1zXXFeo9UzyB2uhR4vRy+93cD+VldB/O/yrD7ccC04pkqE2M9dgHQXSMh2SzhUgcistqotKdFl09Pnut9okspZOig9XO3/2hhhBcfE227qR8GPMTQZnVKkKk5oECjXtVxBizmfXtvMw+Q9KzD+aMC3AbVqWLJuRkbujZCOJ+cBo6QoZYED24JE7QFj45C0kd8C7es+Vou5DBS7mXBj5CENz91kSDCloRUKWypIYYz+HSlDaUy+ACZWbGM/+T50dAkwHzLa6Hu+L01+KFCgIwtF/55Ks4XlD4IaPibmFDhUB+VgPHfCx4G/h2xamizakTHAxSjysUBZ6B1zC/PZkl3q0TrQkYCMfj/cJZGDwD2fjpCG0nMrlAUAGw6L8h0yAiSwo1EuWzRwZi0a88eZAbCCeXUkBpTBBq/BzAp84yzPtE5vuhMiUNjPDeF7m6GZSLw2aPD7gA12GK/g5rNweI3UODiJnr/rV85QHJl3zLUGqCb0kADwq1qbbwK6E2uA0g4sIgl1C3rkiXwuZjuf/PhyI9ZYsaDSKOf72svT6sIVTtiOSELdFTtX0vLRQIPCECYkWJsJbMu6cjV0Yux+5AqkHv8g+r5LXGOUQDR98XQcXtOpd2IzB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(451199015)(66556008)(4326008)(66946007)(8676002)(316002)(66476007)(8936002)(86362001)(41300700001)(5660300002)(478600001)(2616005)(186003)(1076003)(6666004)(6512007)(52116002)(26005)(6506007)(54906003)(38100700002)(38350700002)(6486002)(83380400001)(2906002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v8L9Z5TTpQcN/CFTAHBAxESN+q+FjvPV6SzJ3XqE1g8DXLwZlx2FHvDglYAN?=
 =?us-ascii?Q?AYgb4rXR4TtKVpEq0bYx3MlE/dXAgFy/JGyOM2JHoQqlwhA3WjlfQvUDvR2i?=
 =?us-ascii?Q?lcCS6Hc7LCq81g7+l4toZ7//rf1dw7rRlll5dsBAt6nmfpzxfzKeiUmSTbg1?=
 =?us-ascii?Q?XQ24OfTDjkhOYorENn8waTcJJEJW3LFdnkbvT8ootLzrR9MaiPYG26VCz/hl?=
 =?us-ascii?Q?uG6D8285kg4b1A9Qjeip4DUbr20kDeZGd8vc+V6mYdgD3XJ+Vyuaw/LDqEmG?=
 =?us-ascii?Q?/xpJ4HMsBc5L/TRBMVlHknH2fUbkXWsZwZFb+gqrPnJuxHU45CQ8doVuPIhi?=
 =?us-ascii?Q?+Kc/ddsoby3ySBPt4m7DwwhUZl92HNjBIL/cPoJKxORmOWnbs7n6jVK57f5u?=
 =?us-ascii?Q?I6RrTvoOlYhJm8Yiqf3sHytT8TnYsm9NYZHHVCkcC/edFly5IjU0X3CU0fQI?=
 =?us-ascii?Q?9CCqSzfG4V9dI0TeUcVfSIqTJuiHHY1Bd33JvbayPgFW3pvrzBkJ/JZRQ4xF?=
 =?us-ascii?Q?maa6UMTdUH/PRLel9kR3jDo/Upz2YY+SC3IiArR6o9nzoZTk02k2fp2kQPX8?=
 =?us-ascii?Q?V7xauJOLLsecTfprOkT+pm6CRrTh9CmVocnVJsI29MopqfQNtBI6AvNSvcFG?=
 =?us-ascii?Q?BMYm07PBKRA9Fnx3xBLHaZm/6cvvL/kjk/RR1UgFJoIjCmOvUpyizUFnrBwA?=
 =?us-ascii?Q?D7mibZ5aRz+cERhW3JS+/5VcFFfdlu9deLg5x32qX4QQ5Yz4jI9I/tSRQ5ft?=
 =?us-ascii?Q?EYAS+zGNFqPg/B6hx40Pzch1BxRTqmlwbpMnXdrTbEOiMF37CYcSsC1KXK7h?=
 =?us-ascii?Q?KPD7PN6tgpsmdDA2MuPrMSNodiGKrP+eGETXlYHuc0qouCL4AZOcBEsIvtlN?=
 =?us-ascii?Q?EgWfG0CQ1pwJnsIpO2XZNobotgYQViSO7LuyDNUKgOEIxFxgJyIGLdIQtzYy?=
 =?us-ascii?Q?NSuk3zXKNEFqqUpgkkyyhJCK4B5BY4XuIjt+dcH2jVXF3e9pi1BlqEX+3NAo?=
 =?us-ascii?Q?Ujm9kR+EXtCbH+73deRuojYZrdd2tvCaKExsZeZWbCY0dBI8BF4s9HQWnQ1p?=
 =?us-ascii?Q?YAXMZkQM44KbMMIhQ/A+oF/NOtstXt/ijooy7YLiYxDVErnz0J8uX3EOt4O2?=
 =?us-ascii?Q?4GzBNFv3VzgLWYezKhljK6dA+tlw6t+x5La3CUsf6Y3kmZixwEIjGLhHZeg2?=
 =?us-ascii?Q?LcmRRbZYTSo/dexCVbi4TXzjAO5w1JsmvmDmfCQd0lKzvWzrHJBpz+JT1jJ6?=
 =?us-ascii?Q?mcsDEDqFa9xgbq61dE9zzu8QdhnyvwNKmy5FEwiAc8xId3Uuutr7ydRT253W?=
 =?us-ascii?Q?TLrquvLl0Gfc3zGDoA2bRl9wUFcYi8PD4U1jWjiqdrL4YKnrY8k0Hw/Frwn4?=
 =?us-ascii?Q?nO2hv0egnrKhfxLPLkf8TEwiEU4SE5fyTMeQRH10y+pq9ODXuq9c4UUDG4QW?=
 =?us-ascii?Q?WR08DPODkzXgqchk24zHsN4Ui9JwBYZ/3IdJB8YwQiw3iNHPAL6vrfmgttnK?=
 =?us-ascii?Q?cwS72CNCoFsYCV5l+S9OQejm5WKKySlwvoyDU9ym5VfsiSCmUH/Us99DTIxL?=
 =?us-ascii?Q?a+IIuPdRy/Jog1frFnwkExguZKKvU2q+qYei/F/y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c18bcb9-71e2-4878-9db0-08dac8818710
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 09:53:07.0726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ufuPJJpfb5ghxVWyY80RjTNhXpygoewtWbr1MEm2PKL2/fMr4CSFb+tlhnadA5sieINXHQOJf3uBLkzz/qk7LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8469
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add I2C gpio recovery iomuxc settings

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index e066fa9af834..2439b91e51d8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -160,8 +160,11 @@ &i2c1 {
 
 &i2c2 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio5 16 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 
 	ptn5110: tcpc@50 {
@@ -196,8 +199,11 @@ typec1_con: connector {
 
 &i2c3 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	scl-gpios = <&gpio5 18 GPIO_ACTIVE_HIGH>;
+	sda-gpios = <&gpio5 19 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 
 	pca6416: gpio@20 {
@@ -374,6 +380,13 @@ MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c2_gpio: i2c2grp-gpio {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C2_SCL_GPIO5_IO16	0x1c3
+			MX8MN_IOMUXC_I2C2_SDA_GPIO5_IO17	0x1c3
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX8MN_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
@@ -381,6 +394,13 @@ MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c3_gpio: i2c3grp-gpio {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C3_SCL_GPIO5_IO18	0x1c3
+			MX8MN_IOMUXC_I2C3_SDA_GPIO5_IO19	0x1c3
+		>;
+	};
+
 	pinctrl_pmic: pmicirqgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x141
-- 
2.37.1

