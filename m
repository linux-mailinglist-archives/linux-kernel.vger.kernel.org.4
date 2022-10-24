Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF5760988E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 05:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiJXDOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 23:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiJXDNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 23:13:37 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033697755C;
        Sun, 23 Oct 2022 20:13:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djbbU357FVKAiLGbOJTKKUQSVMkLbttz6aeIYnEi2Px38TVWP93GwsshzRg3QgcRD/TUI9cph3zqj/WbvLFJdxFVKO0nYsNpykHg1eHs7B4D1W04nfnlNgU/eYO9wFWPOlA5MMdy4UoJWwazoGFNyg00OM9Vl8odnSQ+K3rKLmxrkZvnbELd3npo3SxS17DELKcVOBNsX3RLN1oT7AwOcK9m24AuPZxDTOexVMcfqg2EaqhwjcP/R1OhHbPJ/I7GBP3IF47OVMcf9LgKvd9JYBtCvvCrS0xOZPhmRCnZBC/CCQClIFHt2TxvCrEIXc0PEPvcrmyxV0FbVVDMm/zRbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nk0AYZ7i9pnUdrY8fZD+Ov63T/4O/SF9jHwJod72mto=;
 b=mCAmOHT9DQ3C/y1nOSGwwi1Zl09KGplRS+vnV0FrpJwTEWCmvqzdMtzyo1DJRl1ojhWs3+tnh2n8XWAPAQU67EBQDaRiNMwPKRr4F+UpqRSdowuoAAOUtQQ2umsT7VOiNYY0eD/eO9Biyb2vUbDzwl2bw79aLHEjfOybtAwNeTqnOHzGRsC/MfxXHe2ez6Sah6IS/YEYmSeydCIWltP85aR/yqDlPlFwm/oyfNyBH4w+TRyYl3IGVVJN9cxeKxQThjSPIniN472/B4HYz+KPvjJZzmXDkZfodWxg/SCAF7WNFgjHIdgsbf3UYLORR7saHdqhMH+wuWUFwLIs4FDHgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nk0AYZ7i9pnUdrY8fZD+Ov63T/4O/SF9jHwJod72mto=;
 b=eeMENeW8Kkr/HLYx+TZnO/Btg5Ki9d7/6jtzA9cYvZSFYOSM/f+FJ52JR2tBfaGegqXHQDFFnZGVzrG5hf+AK56v7GmnVP65qsWzaf5m5LNM7vspNdoK/psBizSOCsTbPs6+YoDAzcOV7QO+UIMYXgXzXteyXI57EGYN2mYstGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by DB8PR04MB6825.eurprd04.prod.outlook.com (2603:10a6:10:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Mon, 24 Oct
 2022 03:12:57 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9344:660:a20d:8a85%7]) with mapi id 15.20.5746.021; Mon, 24 Oct 2022
 03:12:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 10/15] arm64: dts: imx8mn-evk: add i2c gpio recovery settings
Date:   Mon, 24 Oct 2022 11:13:46 +0800
Message-Id: <20221024031351.4135651-11-peng.fan@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|DB8PR04MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e30cb6b-89e0-4a67-02ce-08dab56da651
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6W9DitX82o6S1fAw4aTYhpq+UBU1Vh1qiSDTVZckMRK8TzbSy+KndQlCP3RAKcsrHnBCoJVVqlrHX8L4j20Rtqqt+ksBMAB8bR1CLa9Blg9o6RLYdFXraoaJh9y/3sPoFpM5tKWx8JiQlpiK/xLTDBL6udspKU0h8rKjo7LfgWJdz16tFxwrPfOY3NnqfLpeao/lLw+UIrwNw0dejgoICTvOaBO9KeXpSq9nW6vADwh/opaw5egudV1SBz3/OyHD071dsW5kEKVYsRDY3NfaFn4c6fhciEsUkRpb5NftTwwePdVj+4ZJnwEwyKsW03WcJwGRfswvwxLxLOsawMN6NFsMbWB0sOg381xzV31jKt3Yh4rz1lo3qGa1M4mW2taVmatMksjPf2S+mBm/oD0esqXFeOm9l8PVsFmZ9jG9/JwVA5PdCQSXVtYxLbaX9FxGbQ/b5Ec4cx2D9Sv88X3Mvjh7QpvONGLX4Fojr/+WhkIO1MVo6m1JxhTgsiJqTW5MBwwjxcLvNS8HqQALvmQV36E9m0LfVq9J2U1LCXAwAactXr0MM51drORrep8qz8rvKtvfMBCp6jHtrxZcETN1xUzZ212jxTmNFU428yi/kn+MN82jTUKYEf4RPc2xsZ60KcZ7tn4N7k7fkPG+W3AKSTB1vvDqgdFjslmIgS1mifgawNmPYjswLx/Nlx1CS7FGqbSP4kwBQ+RPneeSgy94+pobc8gjFtomhZ5NkSfNesEqgsIORKFLNWN4eWt5ZAwevD5/UVhraDYBihHu4wyzXbqlojvK3s+pfGt4r7Vwo/0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(186003)(38350700002)(38100700002)(83380400001)(8936002)(4326008)(2906002)(66556008)(66476007)(8676002)(66946007)(5660300002)(41300700001)(86362001)(316002)(2616005)(6506007)(52116002)(26005)(6512007)(6666004)(478600001)(1076003)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ICVAfbTeQty9JqwCCBt3vu+0JEvghSbVLjMn/M38l46WJOmE4X401F4dtNsl?=
 =?us-ascii?Q?jX89ZyNTxhNNMtUztHeFEu97qRKKPCXiGJQYJ6qkPv47R6MBy6VOu0DGXbBJ?=
 =?us-ascii?Q?ADBHQe+IRd393X0aIaP4Ka+LpSDgg1oXJCXlXwmJuLk0OMFURn1gCqoSRNzM?=
 =?us-ascii?Q?MJJ81SqjPNd63tYGXL1Hi8JetgSpBYiuiMckGOmGR7tvH3N2vD6OXD+0QQet?=
 =?us-ascii?Q?tQftUo6bRFTt8ucRJRz9zVAZ3Dz12G19yFLCKTm8gTAHg3OUX6RoBFXlMQtd?=
 =?us-ascii?Q?xzCDXa/lj8FfYmP3pMT+dT7MzE9UEl32LKSp2hprI83X1frp3Y2UX7pGTZ4N?=
 =?us-ascii?Q?dCgo2nprCcbEszyKcfBIvrSGg7WYOaMXXftsf1AGDWo0dbtt44sKN/dD89bl?=
 =?us-ascii?Q?25H3FFd+s32zjqXJl2QgkGaZ7fVC5s2K4VFZiAZNx0afPwq+9xfSAHq9Z3iT?=
 =?us-ascii?Q?aj5gxtgy40i7Pz5LDvqqDI5PrNVxkVCHvJyVT+tOOpJNOI2wmF4byK2vVM2S?=
 =?us-ascii?Q?FFD+uCbVWDRq+JF1XCi+vk6MfAZ0dzIRo0fi7p/0m1GuE7aSspjqq1lI0yn0?=
 =?us-ascii?Q?w72bqlJMOk6XNcezqwAR4mwRFvfxZuRhOdQ3TAjscKYE3+F6G7NdJCq7ibV+?=
 =?us-ascii?Q?SFaffueDQFt1I040nuy+3Ce5WHyhYlnh7WVhbgFFhRW4j94SJjCSIpGI9nqV?=
 =?us-ascii?Q?aNlqvyyvPZI+9rUGeAd+t6wdLf6LM/ROYIGnRrCnemxDXMh7WQpM3Xpeht3O?=
 =?us-ascii?Q?UGiwxcF0SAjntUmXUqPG7948aA5yACUd1UUpJtSc8h6+htO0u0ZYJrI9bEIn?=
 =?us-ascii?Q?aKvfC9Wh3Pm2CW0ORcozthDR7q+orfMIV3idc0u7Ee3vAF4piHmHhldAEb91?=
 =?us-ascii?Q?O1wgsTfTqUyQEN+bM1J0ynayRtM0bJ3UdtctPKcQloUq5U3089vKRqDgb5kR?=
 =?us-ascii?Q?DxaQE2L7Up0i9DzUUzs3oZ/o7KGrlfB8ZU4neJU//nXYNqVtf+YrkymVna3r?=
 =?us-ascii?Q?kTmjBd7PP+mKOPY6KBss4jbTanNJh/mhZH05IFfHNqJNcXiO14lgp8wLA8AC?=
 =?us-ascii?Q?SwrSzYdYOHWp3Hd2Th8F5PA3q9FEQ9lXVgCCCuLoRGPQ6UAIFKfPHofDszD6?=
 =?us-ascii?Q?qsGyagtb1fd6bfw2yq7hFWX65UJ0V4YN+D6VKetZVFS74ZaE8FOsENFGYpdT?=
 =?us-ascii?Q?xvBqd12kOd4pRJT54l8yE3oLVwuzS+motCtTrPpaIlDJ+SYXrxqOFeyVd4Fh?=
 =?us-ascii?Q?C3f5DpSINwO1xH2QWsYux7vZYJF5liYE0sCXn6f4SQZ75kg39qqVosGkp7wC?=
 =?us-ascii?Q?60IQYSXWbJqLF454I2IyncMTiteTh3YO7sYoUXO3TIB4jNXUEoch/WzrSlZQ?=
 =?us-ascii?Q?18HPM0Uvtmyk+85ln0yp+BQbxxofDC+dZgmyAiZPNFWQVTwWD0oGArrmFcKf?=
 =?us-ascii?Q?FAW752v2nc3ZQnzIlXVkmLOPP6pmnN/96lSyl8BY1ZwWg8dz6SXwgYo4Qbge?=
 =?us-ascii?Q?BXpCvbdvR4YeJiF9yZeaoUI2Nljqz1J3KXrrvW3Q1bg4LpUDkwKTGtkvhVN1?=
 =?us-ascii?Q?/89s9YvozDbCFakXBuDT8p8yopEVy0OVHHrYDMc4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e30cb6b-89e0-4a67-02ce-08dab56da651
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 03:12:57.4765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DesMg2bqJ9Q4XwQ5O3KQyU4/HnvxzNzoCuxJ7m/J6oCe1FD9rc9bIP0+wvZuIIYz9O1ixJFQWtSrt4Zn0QT/kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6825
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
index 2b4395854283..a37a165b40ec 100644
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
@@ -344,6 +350,13 @@ MX8MN_IOMUXC_NAND_READY_B_GPIO3_IO16	0x19
 		>;
 	};
 
+	pinctrl_i2c2_gpio: i2c2grp-gpio {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C2_SCL_GPIO5_IO16		0x1c3
+			MX8MN_IOMUXC_I2C2_SDA_GPIO5_IO17		0x1c3
+		>;
+	};
+
 	pinctrl_gpio_wlf: gpiowlfgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_I2C4_SDA_GPIO5_IO21	0xd6
@@ -377,6 +390,13 @@ MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c3_gpio: i2c3grp-gpio {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C3_SCL_GPIO5_IO18		0x1c3
+			MX8MN_IOMUXC_I2C3_SDA_GPIO5_IO19		0x1c3
+		>;
+	};
+
 	pinctrl_pmic: pmicirqgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x141
-- 
2.37.1

