Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D26620698
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbiKHCSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiKHCRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:17:51 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70053.outbound.protection.outlook.com [40.107.7.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4C12C659;
        Mon,  7 Nov 2022 18:17:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=at6kMLXS/lFlP9XaY66HOXk1xDsgVkRqu65zpxxD6FQmzHJNg04Aqe7JNtbpjV/c9owU/jxNk4mfaDSr11atDMIiPZqXD9sNbyIZNDJbGCegyP9fgIopJ89wh5eECkm3iS9/h0ChGQTZq3Rcir/+5DmCEZrzjBvXq5gOSg703qX4KLY0cIpav1qiqrkXE9Ol9vHZF0GX6RUmpouY1R0XXcpnbiv5bl7YEvkJ/UHKJ7qIWuiwcqz81UpFexCdmOAA3bceEQYs23BvcAqtouCH7KINJj3BjzXnr5cRCXhGTPsmRk/l9PlV/1wY2zxHinv1XGj7INO7ZZMSRaxxXW6ESg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMOqevrOfn6aOSvH8+ncOwTcoL5CLsJ0bqXH6/P4n0I=;
 b=ByNHemi815SnjYB8cQhTf0nZqDIQqQhf7HkF0mOJ7ekULqqAoAOVRskFQUczu8NESkdQp+b+qRqa+/7vCAW97YwL4rsTDjMWZc/mKvSvheBpCTPmKeeiNPOoCmForEUp0zDY2EN4kBAju4do1CcA/vavhWwD2qK7qhowtbC44dAwTAKb4FCByhHIjaFDMX/N0f2e12pNmULjZjlnHsKHuetb40ZTDHjIb70Za1WQIUBKSu4ieR9FyP3I/vk6CdZfv3WLRHKRiXuYfcwvP4vY0rNAxBDFQHO8DAl+vJgaXvdJTQNJZyTrG5kgP8G5GA5h8zjTgPumwxLJI8LoVujIqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMOqevrOfn6aOSvH8+ncOwTcoL5CLsJ0bqXH6/P4n0I=;
 b=ccuWeX3Cv7iWuGVvjPd4D6c3sHe3W8pcGQirmV6p76ohnW4Q3DfNSB7PhzrLxfYpoBILLVlANyOO05Ne7mBipiu1UEwk/a42EOgzhBPRfO5kw/fcgfaN4f0hbMW+GI3Lji6t6o4cflwZucCgftM8KgX2r7k/j7bTuEDQB2mF5rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 02:17:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:17:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 09/14] arm64: dts: imx8mn-evk: add i2c gpio recovery settings
Date:   Tue,  8 Nov 2022 10:18:15 +0800
Message-Id: <20221108021820.1854971-10-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
References: <20221108021820.1854971-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ab91cbf-03e9-47c7-5584-08dac12f6d84
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8jcoJymN7Q2QWBpzELMMBsMaUWjzPiaczuYJmn/HXrXZsBnQkNkTmWPGap2hVDL1Q10fwMmajT2FbIV097E1WQNX8Cp7Debr48ekfivr+dEFTLR3q14eGwy9ih7Q6BdNWN4IYJyMqSiSdrN6c/FbnxIKlyttxBZ87mU7ONQHaPHJTXdDAGJDZX0R5rl4/yQ0CC+UMxqQxK3X7hlqy+sbSv0EXiE0poc2x4ziR4EbEUMPeSfdkjsxTsl00kHgLneYTuax26i2RUfx4EfCkNjuqopm1/9M46froFRztM6JwHSJq8lST9qTeAR3G6Io4OlsSElQDd1DZb8tyR/BWHydpDUogemJszRdUR4oJQ3VZdTFtPksT1sTSOIE2RIRWYBuH/1cL/JXNomo7oWKtGsme2L6FJm993bSgn+6EwbH0AelstyCb2AWkhYKxg7Lt3GbVIOqmjFKBY28Uid6OWqoWN0obMwyMd3IzqwyviX1i2gKVcs+r9WzMgZj6y0S/4BDPZYhPq2cvW+xEpKii4nmsKli6WCuJfdtU1StYAJp1Rs+WjnAbk1S8D9PSQKb8SiynD6k+/8RKW2aD9QlR42cHvix5h3ulkibruSC9XH8uMMNEXrjj54FdXW5edjEfBcRiPBqJq8jqT52KQ4F2cUsr+S+9f1F35tlEcrODZDHee26agHZLRroNFm9svAkZZqT64DzVAMDt+yHSpNIGYCp6KE28N/4n4oS4drJlh0f5qv3m5zcrwRScQdlX1ekiD0179oxEJTly1dqPTclSWmcbYhzbys28qRtTw9uO7Wn2nc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(6506007)(38100700002)(478600001)(66556008)(4326008)(66946007)(8676002)(316002)(41300700001)(8936002)(1076003)(5660300002)(6486002)(2906002)(86362001)(6512007)(83380400001)(2616005)(52116002)(38350700002)(66476007)(6666004)(26005)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RP8JWa1/SqPvIeQiXNbPk1yHQIlHENCYuYNREHFpQs0Fdk8QMWMABk/qwbLp?=
 =?us-ascii?Q?zNeeLYrwn5VBtL2qUmZ+DwxkWIk3YT7pd+CXbcRul7ukbny+mmaM8wvVKmCX?=
 =?us-ascii?Q?bJnBS/5QgzQujdxFqAwcDqgrbwW3RHxMiospy1fLnsdnwjQOaTOis0NH2NzU?=
 =?us-ascii?Q?RIn8lhDbNcdubf3pMHVCc4e6Z7lV4b0JVHrCu2eJUqlL/7oUgCXph2I8oNgV?=
 =?us-ascii?Q?4lGID42qrLHTSqq11KG6rvGeTutkwpo1diKU0CibYjePzT08XpN3ZrPVocoA?=
 =?us-ascii?Q?GAaHLYQZuTjbShvbtKf+a46XreF2OkzV5km8x0GRdBQzIM3FOAVQHmisipem?=
 =?us-ascii?Q?yDtp2DJRiey9B5rPqy3fzYTdFroyKInzHCtjZDtUL77f0j5ZbYzySdn94fkX?=
 =?us-ascii?Q?o6tiVTx57q5tp+naNFlKL17mKT4sdWlLrzYOPbXCEDryjse3bH4VeFNSLGYc?=
 =?us-ascii?Q?eqUMEia4cjmS3Dnm0bGhchlXJBC80CLh26coikv8g6dLYc/6+n86CR9w5sOq?=
 =?us-ascii?Q?efKfUTVuAPRmHZ7+b2+3r6MIVgcRMj5eqPiZIdj3i8RIdUe9VedcmuHcs+mF?=
 =?us-ascii?Q?zn+E86Hc70c0aM55iDRH0k4OVQ7F+koih5lncSSjmksDE+zaRdvt9M3Ex8Gz?=
 =?us-ascii?Q?GigM2U7CZmUp/Qk0ugOt8NQFDSUnYVa0nZlWGzCpliJZdlbuYeysb0rTWLEf?=
 =?us-ascii?Q?apJD8bCUiXTQMVzRZv3ozxDNmyUphdF9RwuQYGFMsSLEjBUWnZSesXZUJA5C?=
 =?us-ascii?Q?lvzBhYpL41n6CBsuOkg5WH6f5VsPSuEhVcmiJQuZdvZBR7UG9FzbCz+w9Ynq?=
 =?us-ascii?Q?jEHOIn/FnzdBTA18iFf/v9UGSBmmJ6Le1IWTf1MYVGoj9Z9SkBpjOPmMrV9B?=
 =?us-ascii?Q?STTh+/iqtYbbOnsoXmA7oU8sGDDmur9/9HSFN/3uAD+sR0Lfrj3ryuYqtGXa?=
 =?us-ascii?Q?9koPu2Ubq5YvL5//9JUKCop/NsEW7rVhHfI9T0CWsNZ7ATxZXpUpCv03gObS?=
 =?us-ascii?Q?61gL7blx4hlirdwd9qR/tSRAds4nljpgR3lDxPu4m11C67zAqiEn/Ri58T/A?=
 =?us-ascii?Q?UwgigGMZIdMb0o6D4FUngYLWP0DH7ENXFX8GO/5qgrSSiJmR+DXcWJYgbHdY?=
 =?us-ascii?Q?47P6Urb+A56dcq8I3ZozFzV+K//PapZP8yfzZGInj4P+rlolw7nAzV+CakkM?=
 =?us-ascii?Q?2lGQvvqTtxrCzIyVKk3VAs15GIRiTMNvRX57c51sQdUjZ80rOrPzk8Yz0dsK?=
 =?us-ascii?Q?elWTuYbCJlyZfqUUoDHNhOwP2dh0zel79JXggwMCNFGJpaxS8KNWeJkAXXWx?=
 =?us-ascii?Q?/bLIET0ZT+ceXhGR9tL9TWwIpX0I14keclNyAFUUinY2j4WvdSeGp6qRuXCi?=
 =?us-ascii?Q?Uv/xCrXwbwlzGYl4hgP24jD5OeoO5lTF0h6B75fmxxaGQw8VxVgXHYxRPbC7?=
 =?us-ascii?Q?RS7HTxqd3Nki0X8wmgkkb4n19vfxoiH3g5jhdMsId9/bqnUkaqbipb0PTDMj?=
 =?us-ascii?Q?JRxZ9Uc4PlgpPmq0mAWZNltvPr+GHjdLz+574TwNUuYRufJN4iEV0hpuUPj4?=
 =?us-ascii?Q?FDX2X36xnPZ1imLglSD0XjsEE6RHT34X//exz9JH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab91cbf-03e9-47c7-5584-08dac12f6d84
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:17:47.4015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XelZNPpZDp8e8kFoYFr7W35I3ll5Kgz/YMeDWhve2LGodFeIlgqtxe7fgsJ6e5y3gQKL4+5LWxGm5Dc31xZ6Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
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

