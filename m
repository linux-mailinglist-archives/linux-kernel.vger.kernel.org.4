Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D496251B3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiKKD30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKKD2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:28:15 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70042.outbound.protection.outlook.com [40.107.7.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4118C59867
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:27:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nq4Np1UmJhjrKhIopwhafbodzSfeIfKicRq4FJihONpAHpbYeWko9PTaPvQn7z3KWq4sLoT/WmKIG/nAt6BTqnhghpGr4lb2aGYRGE4xRnf11IEdJXGDdgl2bHEF/h9UWWYrr0nWrw6AHmYoN8ozreV685R+YjiXapGsWZUbXO9U6DS5pXib/40jjkZQBohDdpgZnR27n19zAyWv65I0igeLraWhiuLzpxp5Zyt+wbGw+sqZ0JXDKVpub7KxgK9KyWxUi7ku0Uy61laVNVnIe1Pb+O+U3ik2fNvuv0w+H81F7TrS8fPJtYf07Fo2AgvK/zh7Qd4tiG0LriPyRsd22g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcs6qJGrx2moPgQKdN7CpWXH4H1CSg+/f8Gc6KXv9Ew=;
 b=AYK1g2vEgb7BwuN8b0PPBuzuN/wn6ERygBvXga6bb9xnWTVHCZHVJZWoaQ7PJdacxoSse1J+AwKSPfL8esdvtmXNENUl9RFl9JDl3Ga8m961pfgQ1vDz/5bh750iRVYF8cHxwlDe5VTq5JG2sXNeK/NW+fF+3Jytx0dvMNdPTnKDZ5cFGa9UnO3e4eTQd1CYCxDqK3rCOs8MG4RYgL0Ai6KkEDTch+7FrrgxWHRNFJ5PgFygoCK3P34uPKnDbZQvUuXPIZbz5NoOpzVXPNoPJnCz+VmQttCyiXNwzoLSkXYfY5IXjvTvMx9zkGSUudiFMFtTNYSufK9IDXuMvxrB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcs6qJGrx2moPgQKdN7CpWXH4H1CSg+/f8Gc6KXv9Ew=;
 b=TBO0e6KgZuzVK6YsE8Tbq37/uC+QCqVfjxtnXibUw70RbYeUpK9SHWDZOzGFMcJZO7AHKeFXWQnqq2Tv53cQzFYMPMuhH425q+7GG+axBsCePy4/CqipC7BnAQVM6PBPz9BC2HEKwcG5rmjYniIXsDCblHyW7jKnxfZBpWCSdYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB7020.eurprd04.prod.outlook.com (2603:10a6:10:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 03:27:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ac6c:bcb8:674c:35d0%4]) with mapi id 15.20.5813.013; Fri, 11 Nov 2022
 03:27:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sherry Sun <sherry.sun@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 12/14] arm64: dts: imx8mm-evk: Enable usdhc1 to support wifi
Date:   Fri, 11 Nov 2022 11:28:09 +0800
Message-Id: <20221111032811.2456916-13-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1f586751-58b5-4e7f-4f82-08dac394a572
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lC5Nx72JiLIURl0gQV9lSAwOI5Im6QnqJaKdFYlE6VdOXBH5Q+5BiM2PjLxUbJsEKyoNEZbw8JQXWEOSzfbVKhXetPwa9vj1Yi0xfNZm9xbr926Il8oxC0XwwfB/HOAx/TZIQKFzu9n1rHp+m7Gdbf7giXSaz0Pd93ShPeOWz2efFHXBcC3MfxFqs5GoxI5FEVD049RGkLQApI7IloZpmAjvN+ZUAlnQGYx86bJ+HRon+bSMsi4RgVLyuaLR784t863oXOgobxMBTQR0Tpql0PCXAqvGWEEfGAH/UKFGjiGnp+iIfyidMfKkXOL3bKV+0RYUNWpVSoHafKZ4EznDa2urgu76mCW9jHcd7BSxya+twa6Lkh1etgHLjygRFoGb1Z3wHRz91210+F+O71j7Rs/QzJCd5+5e9o5wQMP5JpylG1wFvue3irUv7plS2hqNAYwNmhxho0NqCZmBtl7vXjWLMtgbSxaXfvQ7NWndjJsU/fjJlgKeBfAPnrKBwav9C9I3vDra1sBDdFc7ZCW0aeZQc87VXEth+xJT6h76FKUvIKhsCs83n3B+XTXwyT0hIHnjdzYQEbjNT4aYOgjHqxFWXKAh2ZOuONx7UwwG1tl5l6ED1hKielM/1LwCEUopF3pjRZbORFAVScJY0bPWox+9xjlgOuQGoAeWM5Y9xB/GpwqftCTEeiKXC8l4fzZOk5kgnZFHyTeLBrKWfM1wmLTE7c8d1x5dlIwzusF5BtQQRjOQs+5ap8gJz2o1jixHole0fccEau1rtd0pRQUpWRnxJ76MeJMu8cPa5STYL/Apwd26maHxvVy9pqx4a2iB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(6486002)(83380400001)(6666004)(8936002)(478600001)(41300700001)(5660300002)(1076003)(186003)(316002)(6506007)(4326008)(38100700002)(38350700002)(6512007)(26005)(86362001)(2616005)(8676002)(2906002)(66556008)(66946007)(66476007)(54906003)(52116002)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cam9msy0w5XWRahP0XmnOOfwO0oML4DoY7GZcHHNKhLKewc4YJ4E0UAM4Jyy?=
 =?us-ascii?Q?TZoQBvMxc3m+XBb7R2KYn2YvtNiOpQJ1yBAovv1D+oWTPyPBvqIw/xtSG4lU?=
 =?us-ascii?Q?wzaCNXRNoBE+TjHYL4NCSbzMLFZZ33D3LenKOW/yic2DB5Errst+iQFPqFT0?=
 =?us-ascii?Q?EcwljgLjT26uwET6wv/e+Bu5zCZxmEGLt4q4cQ08MMhLtDt9OnFU45em9fOf?=
 =?us-ascii?Q?91MYXIvl1+s/J5ipfYmgZC3B8JM49U5bGN61TmfZSrX02WU3fkbnZQkG2WNP?=
 =?us-ascii?Q?+eW5y8Z+zSjMUo28uBl+7aFZc19MbAjC3rESB/mztzdxj0IYwLYYBkAEXZ9c?=
 =?us-ascii?Q?fW8zpQRDBUQRGYSG7SY38w2njIvxKOCdjq/6WZsMDrmMT8IjOSDfJsovIfXT?=
 =?us-ascii?Q?/qQdHynHBLVwYTkhPyYjMxgLwAKnUJmZ5Th49lxRa23kDA5OW5Q2gCZaj9uz?=
 =?us-ascii?Q?yV73A7gXkuBaZcpGv6DiVpRmCYkbWzgvmdIiyaF7F4ixwblRb6lGE6cWqFg8?=
 =?us-ascii?Q?vNAVF5PrkBZM4sA/qLSxuJAZo4PD7qiugCNuU/NnHanAmBeiZMQQXKH8r2Wv?=
 =?us-ascii?Q?TZMzY+gcVDSFBMqUpKKse/atDkZh1D60irof2qc2fXSF2ycqsIM8fxZEb4Zr?=
 =?us-ascii?Q?muV3VPSFqfV/vLUInL4pG5mNlGceNCzvNLxHQkU93MCss0Vi7gDMOINv3HxB?=
 =?us-ascii?Q?ky61ysimhrPNurmOMAb/SUZRAVNd+E87knoRD5vy1bPnLz5AaSFnu+uvH3A7?=
 =?us-ascii?Q?Hj/eXkx6BWKRFoh5aS5cKhwhM5YlmE+tsLfuk1ajB0kP5mJd1rxuq5YJUkuR?=
 =?us-ascii?Q?YZs9GqZOYt0XVB9AFCfBaB9h8fvDWdcmGmGb6YlqjXFZ1fTnqsdZYaq9ufmf?=
 =?us-ascii?Q?Yljcfl6Vt2Xh9lciLYb0Txo9xJxD4XpvlvYgbLB1iX61Rjyftqrwq0STw9DK?=
 =?us-ascii?Q?LNqKdke8znORaN2hSWnLBaOSaLK/1qz21Yy0E/yLL0CjHM0ky3MGvAkEwnjF?=
 =?us-ascii?Q?75wcclU0PpfLr9HIBdNUfFKLZmUaJHKZvOMbZnOrRzwZS6dnle2OAytTRD3i?=
 =?us-ascii?Q?5uNjfi5JaLzU6BiE2enx5xeKFqlxtqFOgvags94O6cXXGjo4yQN2CATyD72Z?=
 =?us-ascii?Q?NMenrqevnrehwXmb/pA0wZH8KtdJ6+ZW6dqEneeg8jwra+nNOmIRL9Q+ahfJ?=
 =?us-ascii?Q?A/fTQZzvM5XRiofqLo0ZPwMRGpQZp1qYtTjI2Vf0aNb7J6KwaFBPOAS/jDdV?=
 =?us-ascii?Q?yup18OrhMInhjq1xqug1maYfa8IoXxfKRwznpaImsi5NZdh58z8qB0eKxirF?=
 =?us-ascii?Q?WfJX2aw79+OP0BZ5moJ6IJtkk17tIMkPHjGdTnwEt9QpN+uZ/N3FJ8A0Z/YV?=
 =?us-ascii?Q?xXhYfq5m+iA9bDpe9GSiBTFB/j6XjT5XgHtqr3X3Ajgdvh3O9l72weEKVz1K?=
 =?us-ascii?Q?CTIyc9+0OXbop6urLC736bxAJ+pycz8AZ6TfilahYnQannKJ3HUwW+HiRzVr?=
 =?us-ascii?Q?H1hZvEYMtN1maqqkFxkvzycPOJbb9hWRHMdruCp6xcYuvqTrBPkXylb0pHTL?=
 =?us-ascii?Q?VVIHy23jKoRHJtGQUAUXlHJl28vqxaQNdFIBM0tb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f586751-58b5-4e7f-4f82-08dac394a572
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2022 03:27:22.6686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyZTDRvaej1bRfbzV7CelsR7jR8HU+UGNzLSnNH38USLBHAbklFVVo1DUIawHcu+nIsK8rMkVrMmZcXSZMKxwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7020
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sherry Sun <sherry.sun@nxp.com>

Enable usdhc1 which is used for wifi.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts  | 27 +++++++++++++
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 39 +++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index a2b24d4d4e3e..7b80f144327d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -15,6 +15,13 @@ / {
 	aliases {
 		spi0 = &flexspi;
 	};
+
+	usdhc1_pwrseq: usdhc1_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_usdhc1_gpio>;
+		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &ddrc {
@@ -53,6 +60,19 @@ flash@0 {
 	};
 };
 
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_wlan>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>, <&pinctrl_wlan>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_wlan>;
+	bus-width = <4>;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&usdhc1_pwrseq>;
+	non-removable;
+	wakeup-source;
+	status = "okay";
+};
+
 &usdhc3 {
 	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
 	assigned-clock-rates = <400000000>;
@@ -125,4 +145,11 @@ MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7              0x1d6
 			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE           0x196
 		>;
 	};
+
+	pinctrl_wlan: wlangrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x141
+			MX8MM_IOMUXC_SD1_DATA7_GPIO2_IO9		0x159
+		>;
+	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 7d6317d95b13..ce450965e837 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -559,6 +559,45 @@ MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
 		>;
 	};
 
+	pinctrl_usdhc1_gpio: usdhc1grpgpio {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_RESET_B_GPIO2_IO10	0x41
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x190
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d0
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d0
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d0
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d0
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d0
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x194
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d4
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d4
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d4
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d4
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			MX8MM_IOMUXC_SD1_CLK_USDHC1_CLK		0x196
+			MX8MM_IOMUXC_SD1_CMD_USDHC1_CMD		0x1d6
+			MX8MM_IOMUXC_SD1_DATA0_USDHC1_DATA0	0x1d6
+			MX8MM_IOMUXC_SD1_DATA1_USDHC1_DATA1	0x1d6
+			MX8MM_IOMUXC_SD1_DATA2_USDHC1_DATA2	0x1d6
+			MX8MM_IOMUXC_SD1_DATA3_USDHC1_DATA3	0x1d6
+		>;
+	};
+
 	pinctrl_usdhc2_gpio: usdhc2grpgpiogrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x1c4
-- 
2.37.1

