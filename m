Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE33605BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJTJ7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiJTJ7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:59:11 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140040.outbound.protection.outlook.com [40.107.14.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BD41D1027;
        Thu, 20 Oct 2022 02:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyFlsQ73fGGKlxghjeN2GuIRxfVQoUQcEACL5nmmqv3bDcblDlKjscJ70PuC6B2TRkBBJOyVFssTmIw70jIz+drUOYsoyleMoUiqWiv7Df42ekYw1JywU/vsy3lJpgfDJY9pZihWDw1KPtul65fkN78id9ttd7YMJxRVdWLVfUOp7R7um7NdULaUGJZYELlLIgYP0wBD/nfHO13CV5JeZXtMrui6jCGW/i5V6kypfcni0Fk1g0pkagDfE2CDMycbC5X6P/ukGNhOTvxVdsjOTEtndiE6C5UdhtyM1mSQlEpU9vc3mqUOXOKhccInzabJq0gQOTA9HkTpRKjxszFOnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nk0AYZ7i9pnUdrY8fZD+Ov63T/4O/SF9jHwJod72mto=;
 b=n25sHiezBw0qhqgwuDGDUGXgDVlAehaBKonY6LgGumP+uGlJD5xcPp7e36QYy9gZtjDPj25z9nUUkNpR2dgmBefWu6oAFHkcCEKM3n7KHB4gkXqJ3bq9c4UTYSbT7QMZYWwkdKJhZgRLn6RvZw3pXJoJhgyifhukd6Qi0OIfgBLEice/FoTlAcmXEYjZjgCY1bIXEnibkLABZiJFTKZ6Ah2E+/S3+LmWiGaeDX3Q+kdIPtY9mLw3abz8OBXqngbCqab3j6pK9Of52m09uBTZPTsIY9/xZVC18HrcMLYwq/HjTbg2CoDh3Gjy6Xt/X186ToqvVmiX8bTZgd2S5rr8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nk0AYZ7i9pnUdrY8fZD+Ov63T/4O/SF9jHwJod72mto=;
 b=L2XEyDkD2bKP1+qslvyBEFtpIQ0OQ/DHouGx66U9E423nQzJurZyoV3p6JtCR9qpVEPfxGzsRefLXHYkH+GB/LKoP/YySkxum0IOPyX7Qm/9xYGwNv1ERTmdirdHR6TBD+acABHEUiJcx5E8LGqscAXi2k2H3UmvclBPNVE5I1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8358.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.28; Thu, 20 Oct
 2022 09:58:52 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a5ff:3d28:4bbc:e1ed%6]) with mapi id 15.20.5723.032; Thu, 20 Oct 2022
 09:58:52 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 10/15] arm64: dts: imx8mn-evk: add i2c gpio recovery settings
Date:   Thu, 20 Oct 2022 17:59:29 +0800
Message-Id: <20221020095934.1659449-11-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 232795fa-b409-4b24-ce86-08dab281b179
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VkbpJeWUeEG7kjvd4oqtWsVTQTvSLZBSTiiPk4YzaZitHXmlQKGnhHO4HXKKEHKyydj/ADMUadq2Znn2u1KReebLyDD0a10khbVI3nlJi9rYke75ySruW9AiYsT0ZYLMGQGqDEtldSiVXBEtOhGITrRM6JhkoQKpRUhqQ1qofFgvHQ4PVvTqlyLI1SfixJh21SvyzgPRj1JMf9NLZ2c8XxPqAGfVRf4a8MFBXfS0wSfVb+e4inIk8l/blbktT0AEtm2S6r1x+NIggpIslaHfk3WLp5o1Prwdddkfyt03tOpD/we0VrEXKqkNLRcCe99k4NrNAd7VckXUzDnVPJkmHb8CKNMkaWPYKFOl8bEsv9N9bU+UF6yL4mTTfktj+kpDgX4DbfGUElYF1mWGoqbhSnk7RmluxA26vloI2xebs1z64LQBaH8TKE9FpVBvPSaen4eeBEGmom0PBtOitx/EOOIEEVTTMgq/LYS1s8FFoYpUfVVAbydZQaVD9ke7DRliKukyzkq4IkGIOL0LKbGKVAD7pvWh1j21+ykwM9e/++z36CWuTSNiUOTAgnOYgbU3PZb4clg6q5X2L+3YxbmWa+++Ip30zAiY2mHwDZZUImGDwV/Vw9C/fPQSZzFRUn+hSLTxY4oAmb0jFP0EIlCbXCTMqlDUJkHAwUI7+Fh2gxnsI8EH4Wx/73csvxZyy83YEa24/t0BVbc8Lfnm80kD0NyoDaj1nJGVX5BrT87Xb5KJhH0XKRnLNV06apH+Jp8HJ49ATcRcFOG8GptGsNhQfL9gqcDZaTXKEUA6mmsGEhs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199015)(478600001)(83380400001)(86362001)(6486002)(66556008)(66476007)(6666004)(6506007)(52116002)(8676002)(316002)(6512007)(41300700001)(26005)(4326008)(8936002)(5660300002)(2616005)(66946007)(2906002)(1076003)(186003)(38350700002)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OrMAeIAaMgg8HJ0fwRThRbQfu5lTKBU+/Pl4woD+sgPm5HnuW5S+8n9Y4oUY?=
 =?us-ascii?Q?YAjeGO0pt3e8mAFOEK6gCCpPWu3zmyNJ5m02pQgYDAqnOzq/FtSFBWQ8DpDM?=
 =?us-ascii?Q?OsgD92qeoBUWCUWnS3Da9d5NzxukU16ljyKJJMXcrXgeU313aK2A9wzPFKmF?=
 =?us-ascii?Q?VQdOLyJeChz2xf5qq6ty4q7+aHHoAdYU7Rgq3gIG0tAB+8G8fW6xWH6LeDqq?=
 =?us-ascii?Q?hHmPb8vnxun7teyogFrPBwQn4/N3Ers/6/m/Fm+FLVC2U+Hryxz3qEzrrsTR?=
 =?us-ascii?Q?cbswdkXC04WxrsB8dfIrJKGAaX1rgpabLg+FuRbnP/PZcn8OBB1r0/XtXhsq?=
 =?us-ascii?Q?8iHfRRu32QSnE7VOr+JZkR2uflO7XlNme1Qx12XSPY8N7QdiZpUNDjAMgPiz?=
 =?us-ascii?Q?mehPim8p76VBEe6GRmy8MnokQntqS5xgS+Pk/oNTiXRtk+bUAxX26fDgYX5X?=
 =?us-ascii?Q?lN+TLOFEL6VZHBA6Y+G6EovC5VY41uEz43PksUavFpYS9rdGjl34DJv8n7Ae?=
 =?us-ascii?Q?eYBMAphdZJjdb4+Zmjpq5qTSszIwT7qfD8RHhGqgBti5QEpYL70YZFE83Km3?=
 =?us-ascii?Q?2M6jANHsw0V+8Mpv7HI0xYlp5B12jIDLEgTA5G+QlRsxQCfukGpGXA98V12Y?=
 =?us-ascii?Q?sj7RGrpoMcSxk66o4q2fUmYX0Fhn1SI6mbZx7KPoQ4FF2mJpjwEAJeUMkXjJ?=
 =?us-ascii?Q?X/1u67AX45NrkoCIMLYTVRalgEspN/tu8LPcJ5asH5mPLzra4jnyWk/GhrPU?=
 =?us-ascii?Q?oXXFaL1NnqAcjvpRA4NDQ7gyMpLNwA1Pmp1hRyj0TkqvASlulRIxpKbv9Apk?=
 =?us-ascii?Q?68httDwsSHqG4iS745cyFqxM7ItBTwEbmHmfq3+SDsk3DWQj0wYOU48Y6vv0?=
 =?us-ascii?Q?GxzmqA5N1PuM01UbTFXs5ETrkq+sXMjFGGWv6sUh+0qIn4mYtkwkoMZ+rlhH?=
 =?us-ascii?Q?UY7CihnPH9mLGOeYgzcD8UtMgL33QwiK5bUotmzYlgnyFKngC7jE4uh582Qq?=
 =?us-ascii?Q?EdTW7zAazx1TZhj4gumLt9TFF44xG/CJE+9yL1GbTXaHhVf8T+WibaDrCvCK?=
 =?us-ascii?Q?l8jJYsPPztaJeVLU6vEFVtGVEfmEFUIZQNfd07MRd1Tr95l9OpsaJ8gKi93M?=
 =?us-ascii?Q?XIuCk/Ue6kaf5JynyeliRznuTDesDRGDc++0da1vAjt3BAyoXO9IgFBLkkYO?=
 =?us-ascii?Q?jjDfz6ojLj/Z96wZyJX4huiFOCk22u83VD6LfknJ7relkXmSY3RjsoLudjCO?=
 =?us-ascii?Q?1AOjlIz20G8BTspk2+AoSWqqE/cGX1Etide9W9WZ2WY9oIR00smVVZE0EfQ9?=
 =?us-ascii?Q?LkEy2gSW7FXavFE0mdvRV4bJEYbG1pDT0k+PtoWrn3pr9sL5IfLxxMP1jg2F?=
 =?us-ascii?Q?sw8nVL8IXhjFPtqIVJSAvHGwIXxPfq0Hy23p83yvTXyMvAwvzJGy9IWhxG8w?=
 =?us-ascii?Q?qlvqzMikZ2ZcbHLIVagK6LR3Vbki3Fq8WWuyY2kmnIx0mQuESF9O49gMutNv?=
 =?us-ascii?Q?/k1SHn6nrmEsgNQkfh8iem8mzDAodv0I5Af32uCGpfex572f3eFY363W4wWc?=
 =?us-ascii?Q?LFj6MQUXRTYXgzzovSNzCME378OqZo4UeVPmWH37?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232795fa-b409-4b24-ce86-08dab281b179
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 09:58:52.6452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UWNaK46t7ywDotAbCLsZzaKOtmEcPliJA6jq9awcNvl6wPj99Mwa5zL5ZEVjTUUSCg3mdt3kqgyGhLpjBxlXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8358
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

