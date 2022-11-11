Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5C36251B4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiKKD3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiKKD2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:28:14 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADF365E6D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:27:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BS6EfGGusiSNAQ5aZsZ4OmXJrUUnWHodbZ3yVpy/sg1ZIQwTdH9KFdQ/g9ym3HEu0pPLXfR7mjgG5JHaQ883T4QULgh+rbDk+jIrMyNM1+NY4f819NsQtpyPlq3lFKVN6yXncLfnF3NuwjUpkSVEDd2nCRMQqjTHoz+RySlwpwviYLKcO65v4PVtk+3rBO4k4F1H+u3nKavnDHdBxMHr1NCncp7Y3EzNR9OotAJHEySwF+8A6qdbv3/rQL5C9vYb0DFCQJBPhbFhEb/YZkcZRDePQp8NWZSYiYfIKEpfOwHu2XDZ7AzoHFdQWunc6BdysVxAHrjlxd/UgoqMZuPfrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMOqevrOfn6aOSvH8+ncOwTcoL5CLsJ0bqXH6/P4n0I=;
 b=Bj1AZKHCOuLEDmpFd3R2qSgx3VQ//LTAbaNcbJYECu24LBXlAMngdVNDj0UT9Vlg85zqrrbDccqkDc7KzrsNrNVuAjiWVcvakrJVxQXqCS15wsZM8ZkWaQpCAynzPUeKihd0iOdOUPSJUtS8gtIcPEXhOlbsSAndf15XIwjNblInEaZqvIm9S4BuoStrPSxP2w+gbqPxseLUCaeJYxz/mTKt5/KYzsOa7gUFMCQ3bs/MrpiBfl6CvWhpcAlGy2kgvLLh2DsFb+9oePXW8VMVxYBalrScoclkHLZmURCbnpFa9xNHze3kZ3zWB8+mIYUzZdtRuP0Ox4AYt75CQeX4Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMOqevrOfn6aOSvH8+ncOwTcoL5CLsJ0bqXH6/P4n0I=;
 b=MH3hSoPVa+AfUMu/az8orIsFSMrX/PhCSmIcBlWRhmcj0lnstzNnHyZbfde8REaIBRfMFYhNJmBY3V+cUlWu8FCfSbnPIZw2Bcj3TeENHgBScEA6hKPMgjhWMduw4bkRajMQz9U+cyyg4YZ+TJxsPY8KcRQO7Yiq1o1cIUJHpWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 03:27:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 03:27:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 09/14] arm64: dts: imx8mn-evk: add i2c gpio recovery settings
Date:   Fri, 11 Nov 2022 11:28:06 +0800
Message-Id: <20221111032811.2456916-10-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 57b4188b-d424-4313-1ea2-08dac394a02a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EB0BAR/iswFU65NO/kkIHtb9w7+iE20joW0MA8aFJBKRR0DuppcANcvoRWPRNU4NNcYWfmDa7zJ/LfXYAgS4EIuWoopi1nBIMtJQqLlXkZgHnPuf+enS0XZhbSozsP71K1SQREJnIQsfI5rn95dOnEiLzuTCGF+LBQ9k3KdOFMQepivNoe7AtsXr3kIQgs6LrHQvqPi6FyNhotMBxpxheNRLX8ng7b0j65fkAxROtr87vVV7rsnGmjohQ86mk6XtdDNZIXhldcIsm11Gi8c+xut/+ixRyNb9EdDr+aKkLM6zffIm86LZgvHeKfz+EYOTyn5EozQjALsolrj8567CidVst1N4tbSppmSa1nroPoi6O3pcEu/Hyzy0Eqt+CKud8kI3LyUqQUIDjeab46JBDEFAobmtGwBacMYIVc8+6YiQtA/Tr4UTedU8lvL9JCJaERWcnL6FOp9l4qrWhDJRDh8lMoZhVI+f8MBYUfRLMkB2yZWCZi/YlZdbII9m3aBaIWDpVKzmok3Af+OFDfqHSmAEhtjgYFqhtu16dfFmEBUeLl62LX/hlJD1ZEsCjsKDYekGmQhibCLKzahy0X3T6jh+JFqm3e7VvmqFqZrZifWLdo2ZwDj1Y93gir78qvJOCQS1pt9p8paWYHG0cpybqOmqfkQUWFIvxHjVhmKwqhgCugf1XxiGfoHQPHat2TJtVFbp/O2IqGdr4q3zQrj1e2Xj266slP8JbOJi32dgQph9eaGipkGj8k+rLw675qaVg4gSxdDhh85zekWcYSj5KNIuT04RA2UtqTVB70CDZKE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(6486002)(83380400001)(6666004)(8936002)(478600001)(41300700001)(5660300002)(1076003)(186003)(316002)(6506007)(4326008)(38100700002)(38350700002)(6512007)(26005)(86362001)(2616005)(8676002)(2906002)(66556008)(66946007)(66476007)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D8wU/zcM/6+mI3VYvwDFOB76V2cSnJI4B9kH/uhQ0saD3r+84ZvbCyd02IyT?=
 =?us-ascii?Q?zJpdy7URat73aT5bKA+jxj0BrM0GtfASOYmuzaa0/Wtx2lCovnDMHECueSm5?=
 =?us-ascii?Q?UIOsvjw577jsbrrwbHeq00AIzHlcoBkrhToVfepu5Hahe5/DjFwi8hSr8+Xx?=
 =?us-ascii?Q?8mIzN4Dwn0WBeND0zVBC2cz1NMY6fHfj88KnJr7zufEJtFs5CSNKh2HVnAHB?=
 =?us-ascii?Q?yLWtyuvxyKBE9isFZFAlfbx42+a0933N8z40To3YbrsT105j2QhiZJvj21Mx?=
 =?us-ascii?Q?ahC0lq9VQ6AQiyinDDIB6OxYoWdlUjrL4M92mLCSbf9M8aI3aUcONkiyxzBj?=
 =?us-ascii?Q?RVNYuqF6TSaBcSXdBl72CI60U0CbWSqJEuMZo/YPuYD8MkwJCdOqL/3NhQFy?=
 =?us-ascii?Q?UMG7eyFpu58jOv+iYTnKEBd/CT8IpBlIN6PBL5A4OPvFsbo4oMKEBo/cbkMR?=
 =?us-ascii?Q?WTDO/+ofzHABWVTZfj396B2hBFfik1YUGkovX5DSZkUWXtfvXnm59pFXclQ2?=
 =?us-ascii?Q?tEkSIBXUM+7DIMBCCqTmJSAI0YgxN/92mf3Qu0FUns/1Aadt5xDHFAecUeol?=
 =?us-ascii?Q?INE4uwlIvqeAbWhTx9BNDI/zvavyQyeE6TcXvKqhOxH/HC6yj1K12bYMGmJU?=
 =?us-ascii?Q?H+u+wTtBFcy3m6QCJWnbZEf6El8GqC40y+F0kjwxyqRf1CSwU75w/jMNjYXK?=
 =?us-ascii?Q?Cjow6Rk139fW894yAVBYdCqYDNNJ+v0Gc2RUWEyLwxJZmY6qLzgeQDfFSzLR?=
 =?us-ascii?Q?1yHyOqUmcYJF0OOxoJNDpKQZVTSQ1rN0yi3AZZscPKSIPBCXastHIaaxxYVm?=
 =?us-ascii?Q?jq/6Q2vqabAKkhWa005olT6mvuGoCHh4Yaf5URe5lQ+Sfs9Ao+dvhwnVAcJe?=
 =?us-ascii?Q?1+/p+PMWuIqXo2ASUtbVXHyaK35jTqqX70VJSAbE0UmsXDk4YDOC8Dhaq6T/?=
 =?us-ascii?Q?b/NOutLZadIQ7mdDPB459OZDst02psyPVLyWrQIi8tUE0uiz1Ja1AcUQ/BoT?=
 =?us-ascii?Q?BH7KII44XK7bq9oYuHmPkVDJBJCVHDmY3FoZTbui11BFBAKNrArr0jQgGubX?=
 =?us-ascii?Q?vJp8nV8TDjRxjbPgjvvI2Z4nP2SLy7zevuIpNt0xvnjnfaiRHT12edcfTAwJ?=
 =?us-ascii?Q?2iXIrQovOe50mSsRb9WeARcEueos7qaMXGdte2e05XxoIKFNCtkoeV6wKt5B?=
 =?us-ascii?Q?4h8eUeEo8+LkNrDE2jmkCcWZZ5+p08wXn8dao/oG7+BnZzkbIO78mqjEYP9w?=
 =?us-ascii?Q?cKOwdeEdZuqp1KMH6wugyiwDiQ2hgQwosNape0Qy9qchY8XsiC9GDONnsS3N?=
 =?us-ascii?Q?4Y/04FJlGJfO7ADQzTR5x3Q0yj2IB/hiErBS/Rdlg9iWEYAwGCKLEIDORFRY?=
 =?us-ascii?Q?04pGnL1gRqVeJ96T/lqqHfFsDeEEDwo9R82+kwy6y8IpZL5yvVIxu/xqgHKt?=
 =?us-ascii?Q?W2zFvdXRZK7myupkB6HoUuOB2DPrAmiIr4HAyegL9reeWBcjOWTbIKbdrvKX?=
 =?us-ascii?Q?J+B2bBBmP4tx62nY34T9rw7e/q1+EaKQQ3Oumne3RwO+qW32k6/bHnBRH2gv?=
 =?us-ascii?Q?3FeHctTJitvgMEsdS/IOGeZgifVcDqwsgT9WylFh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b4188b-d424-4313-1ea2-08dac394a02a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:27:13.8849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spYMVYxy1cO7uGP5+/Lzdrl2TvzGklF0mz8RJzAhdzVFnnfn3ovvUs0j+pBklkoRLa2Q8l+1YGQnTOQn1imFpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020
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
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 2b4395854283..1971f095e4c2 100644
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
@@ -370,6 +376,13 @@ MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
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
@@ -377,6 +390,13 @@ MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
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

