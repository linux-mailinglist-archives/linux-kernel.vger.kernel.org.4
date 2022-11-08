Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB5162069C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiKHCSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbiKHCSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:18:02 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C122CC9C;
        Mon,  7 Nov 2022 18:17:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRfrYt5QBoea4ghpMUSnaoCC+EWvWqdZgomapomml6jfWlqzSTq7azkAZzcjCrkGfXRuLniJQyIDE6UEfRz+zMlti8AieTSucUK1wNgiGAAy6j7IGi6TSrIKzXG4NXCb1Zfwru49TUrikGUoX/abetlnaphh7CnOtbs5qSXemiMB64GAPAgoq9sLjXubgZ/mUiULCqm13ifPH5kFHp9swVBzsu3dp9/DGOVHdf7NxURsTRTSewT2M/H41Jqi2l9J1Ja/pDyAa11VjFRm9T7/reyT3IMFpneZdOcBd1H7KLS/Vm4bMB1Sclq2AmzbUWj08AlzElVdqzOjCZgacneV5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVAUHetCMZ+sku9azKuQuKBLE05gtFtDIRn7I/rkx80=;
 b=fbn0RG2wjbRHhu6tJnwn6bU66ssdweE5Uti+AZRa4P4Vf/1tWx7x0x2NNSDweFH0fcuX2oZL8avNu/SgbRNOIPMzu44/FBIs+Z7j9Vugv6CJqPr19c3YKCBkQNg1xq2DjDwx1a3ohEcAy40ckrRAwarxM60Lge8q/tsJ8VbCb70LYAdTUcIDixusUD1IhFM63rL7Dpov1vNPADK4XcoIxOosivNiH/oZ1dHQViYPoEHYKUBp0Ai+5Pg2LTAq86CYTnocXS/1KPpc0x16eA50kqsEgSnwKDQjNNO5DRYNZEjwHVu8wB8BDN8Rn2nWiH7ey7y8cLQREYezcHsbJHrzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVAUHetCMZ+sku9azKuQuKBLE05gtFtDIRn7I/rkx80=;
 b=S/U9J62IfcHqMBWq1mLLBNUWXtphVesNpSAcVqzhyDEOO1ufHnZX/gK/1hMgIUlo7wawc461N2lftYMjT0pIuTYkWSx7FGHEyOHmuoaN37dbocHSKRNxnZVFEezhefWae+udXDiyH0bT6BxxgNAOHQds5UDKGhXCNUpmaT+VVjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 02:17:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::36a4:e1fc:67a2:c701%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 02:17:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 11/14] arm64: dts: imx8mn-evk: enable usdhc1
Date:   Tue,  8 Nov 2022 10:18:17 +0800
Message-Id: <20221108021820.1854971-12-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0d383dd6-32a3-462c-e5ea-08dac12f734f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pu+sKbqvtz7tWHhj+swqBQBJ7M2S2pKZBmjuKRHoot9+sfmSGUIn/n6V3ZGI8o5Ajhn+Swd3lTct1ND3C7ucBn5tTS3FqBYX96W8W5cnMqf6KlFvD5ybDhJM6KwaEX/8NF0fdRhGrR4n878mhRi9gx60dnr5rJSQMgT+GRiFFw9YYqPstN2bah8C+NWe18jCdms0DWdjo2c2Yuae2bpItxMqYtEw4l66cGF61i6pKNy0Xw1cZA4WMGDs6jMXLb7RTNL9PYCDemlGI05cx0LwEGCsULBGzBjTrLlmHkY/a0Qm7ivZPgeyxFy0WWHM3PrAwaZP+p94KyJEKozZeah54rno6SQMZ62JSuU3SnZw0GmSs00+k7VZEbIyrxCKZcfXV7sNyNE3xDO8wRHgUzJblIj66rM+IepnIlXA/id9rBm8ii7WoBLBBNN+J4lxz/m1TGuvR1XnZ9vSYy9wC25jjMVSQSotR+eccfS6Fm9peDgMR++071zyPRZ/CBq5rqYesthHaqRDJ6ejEte9udSqrN1gzpZtMsgPS9Bp/sQPGg0OJLhigKXjVbsyFq2kQR+hA5EMCrg+D313VwQLUNAhNwTIGWNpqcLyeXCcCRtRvL+iJOJO2lI8vbSp01YWOnybT0GwojKSoV6R7KoFwJgcna+l8wUBlDC+zPfwsfL6R/UMLoPAruVO/XDtKV8yjId30oa3GIRucMFeBMCZTO8LYamrLYP2cFFbMAllE7kHLBEN9vhVzBca0ZW1Vj9PiLawCEg5zEibcMy9leNlJ1b9A84eEeG125LAlISF8MYg60GSM+c8fFt/eNR2VQOoEwb4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199015)(6506007)(38100700002)(478600001)(66556008)(4326008)(66946007)(8676002)(316002)(41300700001)(8936002)(1076003)(5660300002)(6486002)(2906002)(86362001)(6512007)(83380400001)(2616005)(52116002)(38350700002)(66476007)(6666004)(26005)(186003)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TQUropnPwtVYdcvTisJ0mu4svM92tYD7F/lrULy4hpvIPJMUu+0bvy36EVUo?=
 =?us-ascii?Q?tkPCoRkP6V0Pt/KzMKOPhnsF95BVNT106fJPbDd8m86tz5wvarvipl4EwafD?=
 =?us-ascii?Q?IJqjIDvUzqd4MBPvIOf1MiUuGc0YKjzu+TatBL4sVDkiUPGunZ7Mhwe5Ov2j?=
 =?us-ascii?Q?FPfop/8oShbtzQ7AwbAqpmx5BujG31K/pzTLkZcsNaWKl82eK4CDzGX2BIw8?=
 =?us-ascii?Q?D092IrQFjCZRCjk7fIkQ+VLC4KcWO6LxaYZi8ITg1RlpsAt+s6Tcrpi+m3lY?=
 =?us-ascii?Q?1tc718xGz9fcVwbB9C1bamjeKY6sVWycPrSVeXZRcGcXlQqfJDYetWwaNxxg?=
 =?us-ascii?Q?k55CU6PsKsjF22FiuUW+7IqiG5zWJg83x1EuAq2ID12tAexRnYVh2oK7+XZd?=
 =?us-ascii?Q?5kav4ZuXlSZsZEEjp6JZNaMNbTr1nyR6fvbocmFEssAIHa96g6ZtKOHumkCy?=
 =?us-ascii?Q?m4YedIZmXzWAX8CGYYgWc69zj9laR3xCMUiwA/ttfEa2X3fW5/ss+TXFztDb?=
 =?us-ascii?Q?ci9A0EqA7j79aUT/EEjUt78dM38Wt9uqcuJCNC+z94HtPaYDTX51CvD/Eiyf?=
 =?us-ascii?Q?A0+Enmfjw90kmD8OpE+47TFcn0jA7V9Le/rE0XDc7Lq6BM1V0c9ABncl1bMq?=
 =?us-ascii?Q?CVrFYW65UP6buWMlzeZXOOCptqse9mN8q3Mqy7D1L1vFl7aG932tWby8pO0S?=
 =?us-ascii?Q?rvRLB18DvcCSpDbfJA88Pr/8vpRvvcO5lgrLqIVtCmrWy6ulgKp04aHVQ38P?=
 =?us-ascii?Q?Kp8qKnD+v+N1hZ5QhoimUjgBxWQM60xvYCzCRMSnHsGAMljqU5TbfTMAsIq2?=
 =?us-ascii?Q?L0cLH7GlF4qGADtVBqa+S8jCGUJEHkz5MiNGZpK/jUtX7mQNk5/ieSnk2rdS?=
 =?us-ascii?Q?IvMTQf9tKAA7RXso9bhiO1NWYP95iWqIssLK0CQwUUicek88vtspO8Wil/56?=
 =?us-ascii?Q?9HlR6cwfLt0U+xtzgWj5/i+gYl6hmalhZ1SFTpOszSOtTD0q+tStMhA9SYl0?=
 =?us-ascii?Q?AsN7RuZbC02mbFO/zK0eyybl57BLmvIo1IVwItcX8AVN+GX8KQZ8PE5Gttqz?=
 =?us-ascii?Q?mgsp869idSOGcDKoLX6rZVKjYqfaSIdtOdq14mW2GR+NkNFtMA/ppCh4R1o9?=
 =?us-ascii?Q?KvEVZl4TPkZLaIaGgGPxrsqrU5vbfAhmEFDPTCDPqS6zwMSZT/VfVn0HAWZD?=
 =?us-ascii?Q?kSa3o2pwTPMJjGYNmpQmmLB4yKh9uzcAqmJMEUrJZZa1yfZiXhKNR8RQuLfr?=
 =?us-ascii?Q?OtddWZK4VkpYq5GR1FVvjH/XAnUaQA3zO3y//q2YeoeJW8QZVpjHrj2gmAkZ?=
 =?us-ascii?Q?4qu/Cvm7r0xVlMS1cmeQvCpslFFsNice9AuJ6ZPRvzTUQ1dBU379XOSnYSGv?=
 =?us-ascii?Q?WBu8g/KCvo6AOT/wHPD4HLYPsF1aji8QH9XHlxrF6/RvIr1/I41/lIdze7SD?=
 =?us-ascii?Q?J4t2tfv7siYhuxtNYBQN9fUEoatlfceAW8agIDCopTEToNFomUf3bstJrtrB?=
 =?us-ascii?Q?KadDN1RvHykednzmL1qlH0yUJ3CXnsXwil4aGKA5rGvIcHJ0zJFxhzvHd5hh?=
 =?us-ascii?Q?OfQ+fz03oBqjo/Vbb2YmMFl/JASP9oy6LbMV/vgv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d383dd6-32a3-462c-e5ea-08dac12f734f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 02:17:57.0304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrSXa7nA9oyjWIpNzAdiDxuTSoQoCDNB44qcllCVMSDE6+i4mG66jFpDLCANdFnJU2PrM0B3jn+2TmruT+yT8Q==
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

Enable usdhc1 for wlan usage, the wifi device node not included.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index 12dc5d398a03..8d498718e0ca 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -28,6 +28,13 @@ memory@40000000 {
 		reg = <0x0 0x40000000 0 0x80000000>;
 	};
 
+	usdhc1_pwrseq: usdhc1_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc1_gpio>;
+		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -271,6 +278,20 @@ &uart3 {
 	status = "okay";
 };
 
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_wlan>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_wlan>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_wlan>;
+	bus-width = <4>;
+	keep-power-in-suspend;
+	non-removable;
+	wakeup-source;
+	fsl,sdio-async-interrupt-enabled;
+	mmc-pwrseq = <&usdhc1_pwrseq>;
+	status = "okay";
+};
+
 &usbotg1 {
 	dr_mode = "otg";
 	hnp-disable;
@@ -474,6 +495,45 @@ MX8MN_IOMUXC_ECSPI1_MISO_UART3_DCE_CTS_B	0x140
 		>;
 	};
 
+	pinctrl_usdhc1_gpio: usdhc1grpgpio {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_RESET_B_GPIO2_IO10	0x41
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
+			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
+			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
+			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
+			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
+			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
+			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
+			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d4
+			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d4
+			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d4
+			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX8MN_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
+			MX8MN_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
+			MX8MN_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d6
+			MX8MN_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d6
+			MX8MN_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d6
+			MX8MN_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d6
+		>;
+	};
+
 	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x1c4
@@ -569,4 +629,11 @@ pinctrl_wdog: wdoggrp {
 			MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0x166
 		>;
 	};
+
+	pinctrl_wlan: wlangrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x141
+			MX8MN_IOMUXC_SD1_DATA7_GPIO2_IO9		0x159
+		>;
+	};
 };
-- 
2.37.1

