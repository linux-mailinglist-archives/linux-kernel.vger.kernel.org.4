Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A15D62941B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiKOJRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiKOJQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:16:35 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B2B21E39
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:16:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J8NCpUEbI9YPXKKbm5aJ101r+oHKCYLMTt93Sek7FhvlQkDqgFvAXIAkb+RKHij7msX1AAR/q0xV6Dyzafmaqhngti8rv0EmBcrPVvW63GFmMQqfk24IueElIMwirEcaZjwwtOOH385lfrSybgtF2v9VphBi2Ym8WWv4a4q78v66XlvDszZ6ZlsLjgUmdzqKxyDGSq/t0NZKsU0aKoFlr/qrsS2x+5AQoXKmlRH5axlewZywC+Ll11LaRz5V7Csg9eD2sPcwo19kmINHuuk0TbwHnJ+QpHCKMPRQgQlpMY054lEB3RrJvryCphXXLXRr6QEL/GJHC35PW6jMHiguGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMOqevrOfn6aOSvH8+ncOwTcoL5CLsJ0bqXH6/P4n0I=;
 b=YV+tGCvTe0rQIoR2EpKDMe3EF0V8+sJFrZ+fsxgsqOMrS8m2YcX0RQt0fWPhnGr8pjXpJ8+bkzkFA2+IabgenXyPUXGuSqkJtgSkMcgGHFB1IqOWCBX+/n2+p2AkxCOs+EiPimqH7YYgKF7g9XvnmKiuqzbKWLTnie3Zb61JjDA0Zgho1ZBmlxTWJz7Bej2DYm1V+mGqmCkCd7vKb7rjQ41I4Nv/3D6A05HjrZd8w6Zm3rH6dUvBeLS7O8m5so6PReCaMedm3G1o0joNABDDFbRgDPilJA8EDojmH35LHR9gOtYtpTXXVP3q6gOUZVcZDKqbs1EFXL18A5xDilyYzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMOqevrOfn6aOSvH8+ncOwTcoL5CLsJ0bqXH6/P4n0I=;
 b=VL24jUamZDcBJ8PY5WMtZpou0dYD1Ea310Xho2uk4okwsMPrFLFNQL3U3PnR1C+XXptpsFKfMzUQl85fI2FcxPUYdg4oIqF8rWfx4QU5ZZQx/O4axnWcS8peLrfPA3tIPysDadn2Uw8SgePrGcBSew3fbF4bdYj5Jc4JzI/dO74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7899.eurprd04.prod.outlook.com (2603:10a6:10:1e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Tue, 15 Nov
 2022 09:16:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Tue, 15 Nov 2022
 09:16:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 09/12] arm64: dts: imx8mn-evk: add i2c gpio recovery settings
Date:   Tue, 15 Nov 2022 17:17:06 +0800
Message-Id: <20221115091709.2865997-10-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
References: <20221115091709.2865997-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DBBPR04MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d26fb1-1988-43ae-7554-08dac6ea0bcc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPXPVrJUNXVnITOUrxEVaWQV3bxtev4gJzLJo3VGWdFl0HRW0FcxfSrG0pHeQMgvAWezbUFIl6L/lQNJt3+G/NDYKfyE+A0mgb0utZa7/e4b3mmLkGECal2fIeaEzz9OFPLktH9SF8VSFd3OJhsqdKZlGmp457m1IS5Uuxd7M092XjDJJWGjYlr2/GHOsnNntNw2qCk8iOllRJ9+zfWebBWDWK5v/GRW87loeCnYrYw6lPbXu7RmbnPc9799hpwDQcMbau/VZ0Ot+mssPLhzeESRfDvGP0DvtJsAxij4+7pHwNMrDI63aobrjUrOw285AQ4+HRmXA1hVNcztNTdjj7XKIw5DaLHqBTCR3E1yLEUpisxuKubpJK4DAZ4KFgKAhpeKGn71aNWGuaKuY6YStUZoDZ2z1fgB+MYIuclJn6ymOJjT3QK8ga2oih6nZFbQiMtmVCNgZgLeswu4FpAj7q3LsB1sZvePb+zya999hmhy7NOnvCFO9g1HJwEW64e1FZuck9MeuXWNT4kSov3pZe/DRX/DH8xDDoSE8GbzbM5qNYIgU5IvHVsrvkq86x00/1x6hPx4Ep4Nilw1IgSBbr7vtQLZrekop9M6cXXsT5ShaeP4jEebEjBghiWQQDGrwQ54xVULEurMvZ2BZy/RiCtvjJofIn0ZZGzeSDWZwyuyIf43sSHGM+aVUUcf3COz3itlwfoepSs0ocYpKSt8sdFbkyMx/Xa4roeevB13uyaMlkUgskILOr1IoVJLzxxSNfOP9qTt2/rCO3zXqnNVwFht1kbcYMAZK+GpfeGIO1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199015)(1076003)(52116002)(6506007)(6666004)(186003)(478600001)(26005)(2616005)(6512007)(41300700001)(8936002)(5660300002)(66946007)(4326008)(66556008)(66476007)(2906002)(86362001)(6486002)(316002)(8676002)(38350700002)(83380400001)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JCRStkIbdeDH8hmLk++/BsFbn++qmkCI2x31dE3vrRN+C35rrH4JefdNnwFF?=
 =?us-ascii?Q?/38v7JunZaHqMSTwSFYfMte5yCfuuKo+FqMHGKzQaOR/TdqSp9lxLMQoTn6e?=
 =?us-ascii?Q?VV7T5oY1nXS6uOCA/XbiU+fsPl6KeLUXuIITyAYp8NB5kQ/NxFJcd+7/ye88?=
 =?us-ascii?Q?LDbVsOib+XtxcayCjk+l7kAeBd8jDqqELZUdp1griWDUzKZn9Tcwwgi1N+Gv?=
 =?us-ascii?Q?l2Jxrecv6fDT7b363kUQQTlW0R5a+MInvRvzJPLz/Lq8gq8V6s57IfAsN6Tq?=
 =?us-ascii?Q?OHEyoJ8UZDXaqj41g9gtdOt2Y9/6WGioHPa1AMbaauHNK97yY1oIgBN1Cgms?=
 =?us-ascii?Q?lMOx2pZxmN4h58u4dLaAvJz0iyOtqrvkFvIryo42iuaoIFcQIxU1KUjUnNlx?=
 =?us-ascii?Q?RDuKIFShCHcu0L4pzy27rtj5+5SJk4zjg1Txvwmq1bU/UJvmzMynT5cIDq+w?=
 =?us-ascii?Q?mw8VSBoSul6Zf4TtyOdUAh/hb6ZrPu9Y9uhoPOWL90aelrZnPGGbLTMTmfM4?=
 =?us-ascii?Q?sw6LYK7VkUXOMy3Yd723urzi7lFDqw5fxiEkqgJTf/avpTRcEU5MtsyWl2bI?=
 =?us-ascii?Q?r3EiBWijW1C5rDsVtFPLIalI5WFIbu/HWnFZULipAgVfG7lMEwSN0zTjFyfC?=
 =?us-ascii?Q?TZqkkYTWDdY1xetQHi30RMyNqfoeTAGHqHyxJB7Nw7in39nx4OZUUIUdpVUM?=
 =?us-ascii?Q?IuirBiEOoRkOFcx4yy9MaEzDcPC+50yvHiZyLV3uG+oRv9hCp+0AQC6803ti?=
 =?us-ascii?Q?I3czpKqq40T6vaqRu4MdtZTX+HVYMCIp1HWqSN9rXuLNkBCW2/iGpdeUESR2?=
 =?us-ascii?Q?g3aZiqIS22I0YKVFuNDgoo9d80LD1zAQbo+0MOWqvkZFtIC6MLI2+F1M0/Oo?=
 =?us-ascii?Q?vSGRmhqqf84OK+sLgRKyi+/KAVsyfQIK4IYFRouLhpCLlxEVm8UZsG/sskkb?=
 =?us-ascii?Q?o9mIlDXefa7HqPc2VODnXUwJIyAePdSf/dzL2yaslnfM/61FKTNKEz+0ASqN?=
 =?us-ascii?Q?V27V+/M1DjHkm7cpkdoQUgXHLSc+4RtNc0g/axF/LjKLiTTAjqDxNc9/6DHW?=
 =?us-ascii?Q?6e04LIE+4/m2PIT1AYgky0G4diZvnIIIklfTnMqf8RbWinlSMuw5BJSx3Trw?=
 =?us-ascii?Q?jm3NZXrrsX55lwEw1qQ32vxRCWNcRjhrcxR3neirTKuq8LTAIY+cwrhbJtvg?=
 =?us-ascii?Q?lqQipeQmz9DEmL9qKQHVfzP3uGGModKoVR35PsqfTSmBVymPTdTsnkpBkLRL?=
 =?us-ascii?Q?F/7KWTs04FZJO58rbWIkwO/XxfxBVb28BLWS7bI07vH3S42n3o/gPVnXmudV?=
 =?us-ascii?Q?SyJX8tEwripxWdS9c489VpOYowac+tbK2aa80aQ687G9G3Obq0jvHG14X/RE?=
 =?us-ascii?Q?Z5maWmr59GpoxEw0imiNAdhpgGAgKlhLMWYF2YdjARa+Lk5nkwP2Kb2tblNI?=
 =?us-ascii?Q?I6c9NsjvFVO9eeqA+L4mAk6SPMZT5wTWISUmjFhHKwUTIuT/fiVqITL0l581?=
 =?us-ascii?Q?UNnnFfV/ao+XJvD0SCDn7kKqqiMx/98MOYJeda9RzyBt+jPW7kQnvwiTlxn9?=
 =?us-ascii?Q?dkhxpcRKLuVILB0MqkDO86sCAWHF7rxc7H5VI+K4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d26fb1-1988-43ae-7554-08dac6ea0bcc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 09:16:15.2535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVs+Twd6ZrI4hD73bYq+30C3lIPrgKh0MD7NZdIiS9yNm1Z0/b1mjwNlN4ckzKn70aFni8rwmTt+28Upn3fh9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7899
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

