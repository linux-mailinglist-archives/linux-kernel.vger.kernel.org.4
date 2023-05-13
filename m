Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE0070166B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 13:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjEMLc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 07:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjEMLcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 07:32:53 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2086.outbound.protection.outlook.com [40.107.222.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49EE449C;
        Sat, 13 May 2023 04:32:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqIZBUhoQdpGaD81Yw0/OVUTcNMa1zrlGetXfJUQEgS9N62pcEW/q9eNGctyBMSFXbA/l+34FL+35pd1SmntbsLUW5HuCGTH/+glcqwcweyrNwkMWn/BxscEEgv0h1LfJJR2mpFIpETAGqhWMADuMHCQRGlSf7S71MYGdenJVH9Iy6309FO4T0Wse3IzVaVs00lXvGjkZRX+e2ksxUyAXKHNVwP3OtlckRurMqLOkFsKgx4lCLxfysPyCW3yJ54Sd54ptqOMeKr0rZRZq4gzpR/VDiD4Y8WN3G/0MKDzgTQ0Grx8v2BPqJ6EYcKTD+9keuAlaGcFeVsRh0stFErCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwYqyzu6AFAGB3Pg7N8RirOWcde3XT+pm8HtSP2pqCM=;
 b=e0+m8i2AdJ5vD7lQognLLFEHD2gijc1023b0swbab9sP4eYXVuHtijkr6jQB6mbtp5f6nlrGepcdsasajHQWgI7owRtU9NkjbdVLcd79EIF/81VM5q6nO4trcpxOCfVJs1aSrhHJZKg3psU6V+SKuIE7+wImc6ike/C03VAcfBKa5vziAMghT8NTgJ1XXNhF+lsdv3GWqtHVJRtPS38R1w37kTZtZto/Jqb62jilcD04OFT+ITzRNg5WOXn+MIflnsqCdporZl/I038sZBECb4/+HdhX0TjqtvHek9YWwb92y9gHTH5n/3u6FEXeeSh/omKbT7t8iilk87TN7R0UqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PNZPR01MB8378.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Sat, 13 May
 2023 11:32:43 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6363.033; Sat, 13 May 2023
 11:32:43 +0000
From:   Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To:     krzysztof.kozlowski@linaro.org
Cc:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Markus Niebel <Markus.Niebel@tq-group.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/3] arm64: dts: Add support for Emtop SoM & Baseboard
Date:   Sat, 13 May 2023 17:01:24 +0530
Message-Id: <20230513113133.1913736-2-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230513113133.1913736-1-himanshu.bhavani@siliconsignals.io>
References: <20230513113133.1913736-1-himanshu.bhavani@siliconsignals.io>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN3PR01CA0110.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::7) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|PNZPR01MB8378:EE_
X-MS-Office365-Filtering-Correlation-Id: b51aa005-8e92-4216-7142-08db53a5c470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4H/hmmz1+QFTy+qGZ2BizhYxFNrxydjmn0wE25rLjnfDZQCu6WS0POhhzSYDOPyQhehyL16ODLY/zJgltGFwjbPIp7KMV1KuzDkIsao1ABM0SgBt9CYEwsQf4aAkyoauxviLAmLHCQabWof/L6wDMqdCKuVuUwtLccZ9wsIyozk7oUuJMatEMPBq/ac7phN39Fn6QCbs0nNFNbBrzQ7CHyZUpHmW6JyVNecvnGjcJzgcS/J6NgD09yCq29rcTj+Emmc/Sb8kZlrqI4eZrpfm5pyzZ7or2DzDIXpSUsCh8lls50/Ji0pa5oRPt1QrCf27MTsIGwTAnt8fiSLVDe8xxbfiuumQIGQJHJAFFFYTBJnYhmBQQuJ1St1bTxSMuq8v2fDgGcabBWrzSsyHQXlwcDpmkygGaB2UYWrqUAedHBz4H4CYSZCiq+t9Hu7vliwBH28/j8zdAH6fZK6CCXm+Hhzag1qoYGICpcON7w8tHNN5sqb6bZezs4r351B1y3zeFlHooYEo04IzrMhvhn+h+a+RCETpzwPA5Q0f04xpiEtG1kbl8NTKbSq7zfsMIkZtpgh5P4nrsDV+yyo+wBo4qVGJkkRYowI6Svk9IR3NLq9Fq8n3Arfz+z+W+OdTDwu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(39830400003)(376002)(396003)(346002)(136003)(451199021)(2616005)(6506007)(1076003)(6512007)(26005)(83380400001)(186003)(36756003)(41300700001)(4326008)(66476007)(6916009)(66946007)(8936002)(66556008)(5660300002)(7416002)(44832011)(8676002)(316002)(86362001)(38350700002)(38100700002)(478600001)(54906003)(6666004)(2906002)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?huJ46Xo3kbZt9fEa8ICM5zUVnRiFAO1v1XjtbFLjzvya02P2F9ceJ4gnUQvT?=
 =?us-ascii?Q?hl/DdE4JiqXBavA1VlFHi3poTsBX8JICSplhg8y1RfrrJphZqv3ngI33pxLJ?=
 =?us-ascii?Q?ojJteynRDxdAYWPItotGa2vMNlaXVbCQvNHamrQh1o5/peLHzfAMGH0BHNbJ?=
 =?us-ascii?Q?3uPF6P6ZrHEVp/FU3NHrwqQVom4RSz9IgIbJfOWZ3AP1rP7iXpVZLUnjMD7c?=
 =?us-ascii?Q?I6TpSarlMwt21KxdNYysa5bXi31vIEhrYnlrREnb1+SmFhb1ie1tFH+ZWDVF?=
 =?us-ascii?Q?9kYEIO0bw/icOsZx2hMMca6dZNzFpLhG+xyKQGZcJP7mXemM0SqqwossqOOO?=
 =?us-ascii?Q?YkOhjWifwklRk9dhksG6ajhhyNjAIGZ6pa8VsWCA5JN1LPh/T9uYVPM8NsMa?=
 =?us-ascii?Q?oWHDTDi8JYllqVw4BK1/JSgnsdpn/fvdSOLNWxzMx1+XlckxyexmVeba5CgL?=
 =?us-ascii?Q?Tr/hqUsm1486Ughnt1fQRC46MiPCqDVd8ulfAz/SKmZFu29Ps0HIdfsNzTl5?=
 =?us-ascii?Q?cVJsmMeblifKN2/nO0MwksBxj21RaROp2BL5ojtIqK3ZIIY/oGsZlPrLZh5B?=
 =?us-ascii?Q?/KEGHshcxUFwrL548cFvEjHOMdhQxhwtMIcmRV3TxWRlH+jHNpRCx249Kvw5?=
 =?us-ascii?Q?6wBcNS6N1fCNuSRpCQnw10PgowxWkqPuJpYnuly2XLQz3rMbbm2gVpRqg3ii?=
 =?us-ascii?Q?GDOQnjHf4tAYcFGZdptli+7IYOnHz8p9hFCvLFnTNJOFBlr5XKL8IBZklb8K?=
 =?us-ascii?Q?OZFaUOzr7XyZGCnbR1AvwW9SI34VPIXbVhI82XogSCJOIvgXgUW0Wk2az+YV?=
 =?us-ascii?Q?ulaLH7A94QFxbI4fdvQYpbk7q7iJ3gJM3hiI9LYw4lsk0vzIdqPWvcsZ2jKv?=
 =?us-ascii?Q?cwODovVD++KhRIFEdq1wfVl62VNp6lj4SW/Dv3jbLFmOrhLpWwpGd05aJU3a?=
 =?us-ascii?Q?i+LkcpX6Y+c+UKDkBQaBlamHm29nIWkSzbk9q+FEDD380Y3DUQkmmVf72bZt?=
 =?us-ascii?Q?d7EYhYQ308HxsIqVZJUy4ENuiCXlF3915vx5MCBEV1rvayolbe8L7VRa328S?=
 =?us-ascii?Q?h60NAQVyTVRti7PxtC1orvoCnhX8nGj6oF2ITU4Xs4RZ+7/IAT09iw0fJNRV?=
 =?us-ascii?Q?vMIRd1t68XpomYsK+pFS3web4gml4ue6KqnEkGHr7Jop6wHzVtddVwWhsmvb?=
 =?us-ascii?Q?mOQgehoFHLcoY9r049tiVmp7VaYPMpmW3cu37Fx/QEr1LxW7qRorMSiAOm87?=
 =?us-ascii?Q?wWV29lFW08VPic8kPzS5ZTW2X66dE1BCK8saln2G+wEm4KEOSdxVTLg/z8cU?=
 =?us-ascii?Q?IaxcCRhCLG+Y2KC6me9JpM7q0TsVYWotxNEA+jwFwkqGtTavgjxlDck/fV9e?=
 =?us-ascii?Q?+2C7wBYHBajRLu9NUXYGouXTWtflLOV7d4DiPT5ig6TTPN9zmhmc1TyKCOei?=
 =?us-ascii?Q?0h6aN4tZN+kxvIjAS17Ji9e8/WiPqdaCm8GvbTUDo1Ff6mtdvqgqoJSllMZM?=
 =?us-ascii?Q?PFKN+SN+5simogPVz1RplMorGsoeNGaU/Wwv/MmnJ3Iq55RDPKBnCGOn+ESh?=
 =?us-ascii?Q?ZwLnPk0PoluZoN0VWEozQKaox0BS1sVKW6f4bob1IVbbPyWWrqUuvPmZVOTM?=
 =?us-ascii?Q?mnXxHuxlg0qUFDSec7IStAA=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: b51aa005-8e92-4216-7142-08db53a5c470
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2023 11:32:43.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6sSFt2HTWQNEWkZ0uPQ0uHDwpjK+nM9zuwCIOVO9KK0oBYqlALp4edPitZ9sDb1SyEgPTzCco5/bPmvitmw9Xs4Nyemykbj2ZqhKqUNtKRDy8Jq4JfryNewn4ykj6fz/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB8378
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree support for the i.MX8MM Based Emtop SOM-IMX8MMLPD4 (V1)
and IMX8M Mini Baseboard (V1). 
Currently supported are serial console, eMMC.

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mm-emtop-baseboard.dts  |  15 +
 .../boot/dts/freescale/imx8mm-emtop-som.dtsi  | 261 ++++++++++++++++++
 3 files changed, 277 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emtop-som.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 198fff3731ae..20e3ed6642ef 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -54,6 +54,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-data-modul-edm-sbc.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-emcon-avari.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-emtop-baseboard.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
new file mode 100644
index 000000000000..724b29b13a86
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 Emtop Embedded Solutions
+ */
+
+/dts-v1/;
+
+#include "imx8mm-emtop-som.dtsi"
+
+/ {
+	model = "Emtop Embedded Solutions i.MX8M Mini Baseboard V1";
+	compatible = "ees,imx8mm-emtop-baseboard", "ees,imx8mm-emtop-som",
+		"fsl,imx8mm";
+
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-emtop-som.dtsi
new file mode 100644
index 000000000000..67d22d3768aa
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-som.dtsi
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 Emtop Embedded Solutions
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/usb/pd.h>
+
+#include "imx8mm.dtsi"
+
+/ {
+	model = "Emtop Embedded Solutions i.MX8M Mini SOM-IMX8MMLPD4 SoM";
+	compatible = "ees,imx8mm-emtop-som", "fsl,imx8mm";
+
+	chosen {
+		stdout-path = &uart2;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_led>;
+
+		led-0 {
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&A53_0 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_1 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_2 {
+	cpu-supply = <&buck2>;
+};
+
+&A53_3 {
+	cpu-supply = <&buck2>;
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic@25 {
+		compatible = "nxp,pca9450c";
+		reg = <0x25>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck3: BUCK3 {
+				regulator-name = "BUCK3";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck4: BUCK4 {
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5 {
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <1950000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <1950000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2: LDO2 {
+				regulator-name = "LDO2";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <945000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3: LDO3 {
+				regulator-name = "LDO3";
+				regulator-min-microvolt = <1710000>;
+				regulator-max-microvolt = <1890000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <945000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1650000>;
+				regulator-max-microvolt = <3600000>;
+			};
+		};
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_gpio_led: emtop-gpio-led-grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16			0x19
+			MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29			0x19
+		>;
+	};
+
+	pinctrl_i2c1: emtop-i2c1-grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL				0x400001c3
+			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA				0x400001c3
+		>;
+	};
+
+	pinctrl_pmic: emtop-pmic-grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3			0x41
+		>;
+	};
+
+	pinctrl_uart2: emtop-uart2-grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX			0x140
+			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX			0x140
+		>;
+	};
+
+	pinctrl_usdhc3: emtop-usdhc3-grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK			0x190
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD			0x1d0
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0			0x1d0
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1			0x1d0
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2			0x1d0
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3			0x1d0
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4			0x1d0
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5			0x1d0
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6			0x1d0
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7			0x1d0
+			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE			0x190
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: emtop-usdhc3-100mhz-grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK			0x194
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD			0x1d4
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0			0x1d4
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1			0x1d4
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2			0x1d4
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3			0x1d4
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4			0x1d4
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5			0x1d4
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6			0x1d4
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7			0x1d4
+			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE			0x194
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: emtop-usdhc3-200mhz-grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_WE_B_USDHC3_CLK			0x196
+			MX8MM_IOMUXC_NAND_WP_B_USDHC3_CMD			0x1d6
+			MX8MM_IOMUXC_NAND_DATA04_USDHC3_DATA0			0x1d6
+			MX8MM_IOMUXC_NAND_DATA05_USDHC3_DATA1			0x1d6
+			MX8MM_IOMUXC_NAND_DATA06_USDHC3_DATA2			0x1d6
+			MX8MM_IOMUXC_NAND_DATA07_USDHC3_DATA3			0x1d6
+			MX8MM_IOMUXC_NAND_RE_B_USDHC3_DATA4			0x1d6
+			MX8MM_IOMUXC_NAND_CE2_B_USDHC3_DATA5			0x1d6
+			MX8MM_IOMUXC_NAND_CE3_B_USDHC3_DATA6			0x1d6
+			MX8MM_IOMUXC_NAND_CLE_USDHC3_DATA7			0x1d6
+			MX8MM_IOMUXC_NAND_CE1_B_USDHC3_STROBE			0x196
+		>;
+	};
+
+	pinctrl_wdog: emtop-wdog-grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B			0xc6
+		>;
+	};
+};
--
2.25.1

