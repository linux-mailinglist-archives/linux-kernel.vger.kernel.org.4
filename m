Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639156FDCA9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbjEJLY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbjEJLYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:24:49 -0400
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2070.outbound.protection.outlook.com [40.107.222.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69116EA1;
        Wed, 10 May 2023 04:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtOoTMzgDJp8iuyObHwufTSgOGIhP9zwOeWkuzjVMSjWZskjKOEAyk5xcBMWuHOQgvIwLqTRpgqjnQ6Kv3ZciNbiKZsXLbEzxhC0YV3kd8RbQFlNBzSD+M5XhQuQGWtBkSBkzeVX5XggMAeQNK5Atc99hcKt06VBvsBXkv0jLnY+Uh/VmE9NBCCH1jiz/dtGE1PPTXXLQUigOcLG4Q0w7eVJOK7ePLTUyS+f/jR2PHMiEY0b9ilFgaw05slgZ2BcKSCa07JpiQNpr0+0vutg+F0jfO2eZJ2gQMNaE9yZW/jsYvkSBjzEDOiu27sA/ZPyP10WmTopQDCncJu0TCb2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jIP1yYZ3aqeWCeWupCDK1t9ahKQeoLmStiiARgvXC8=;
 b=B7bFn693P+2gKQV/aqNfA1wEOQsC8ixOMXEIVtS9mJMyKWNm7pkaF/TvkDfLqp08vlKSKNFP87VSPwqwTiyLAlNTTuj43o+qRTuGMMesCjiFMxInRu9lwnBRotbwsknseffIjVxeEWPAQ4xEBvSRu+rZKgflWlmKphUnGV0bBBq3+c6/0hOV81CTu3ZLWi4AP+2kHZCZINxUaqOL1cZ49EPIPNXPSxv8hkt9tdOvDTL0yAwNHzqo2GI8v8EcpxG4QVf2BLppDDoCu5eCPpjy3B+v76AYEh4gUpAeZTD4eUdlw6pqxCNGJ1B8o70w4ip8q7qzet2I4a3h8kRTJIy6fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PN0PR01MB9138.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:165::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 11:24:29 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::a54e:e611:b89d:7470%3]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 11:24:29 +0000
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
        Linus Walleij <linus.walleij@linaro.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/3] arm64: dts: Add device tree for the Emtop SOM IMX8MM
Date:   Wed, 10 May 2023 16:53:39 +0530
Message-Id: <20230510112347.3766247-2-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230510112347.3766247-1-himanshu.bhavani@siliconsignals.io>
References: <20230510112347.3766247-1-himanshu.bhavani@siliconsignals.io>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: PN3PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::10) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|PN0PR01MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 1afaafb3-10b8-4192-4677-08db51491e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0nX2ERjQYAk0fpVrGyyV2/yY7Q5LBcUE2XxtB3kaGlYFCwXN5Ssr3tPhdLMLiVjr2Pwv5Xge1lTdIXeU6RW/Zfh/GDAI+k9pVLt2BSCCVoq5CTj+Z9r7G+I53BzpaA/Q7+TA1PqbwxPtY7WH4jORceFBTkFDCgyHcQ6i8SkLQK1fnwj14BF0KLcUTYR0tmd+gP0Px+xdWmeDxgG3XQMhsSLt9uSKa9dICxoOQm0eeYK7XFi0K7BKKqnC5wwtWbK8aLYxqwU7sJalqtyWCjmLBhTNdoDn/dX0NZKKUXBkoVxlERx179uuHNOvx5i975fDHzebZiPTMe9HixXqXmuznlgpiWLcbXNFWRmzeqLEpKGBWbaTDeb6S4ijNxaCa+3Lhqt73E3nz6kx6KQWG/vTzxNCNVOIwnifB/SfHdtDW2v/H5bES1jZOE0ZXrGBXRD07nlmbcodxkfiPvntZYUfkwQhODYZ+96uGW5ZQRqCAGtYPSG4nfy/Ucf5o4s+ykmhuUgon/18tlRh9iBACGXIX1VWQ0aZw+WenbPr3+7zCQblt8fgNCkPch0uzfTT4c6zPX1pkAXFnZ6kisP8rAHRTBz13lq2G0T07RETI2x6hzI2ZXzRsInNKA9m+bM09gPswuMVMcaRViWpy+/zKixNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39830400003)(366004)(346002)(376002)(396003)(136003)(451199021)(41300700001)(38100700002)(52116002)(6486002)(38350700002)(44832011)(5660300002)(7416002)(8936002)(8676002)(478600001)(54906003)(316002)(6666004)(6916009)(36756003)(4326008)(66476007)(66556008)(66946007)(2616005)(86362001)(186003)(2906002)(83380400001)(6512007)(6506007)(26005)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pApqts+1Mf8yKlgk/holCWhToq3777HFXC6KY6+FUd+o4tBWu1AR8/8vmhkR?=
 =?us-ascii?Q?DmYqtKFaRMvmCg/yP8/SvLkcfdD7MGJGQbb6mLDzsJ3jnhIjU31+4ugIe5f1?=
 =?us-ascii?Q?STSR2apWrTYRRtS+wrqc4Mxwp/yBY1NvYC0P935tvHNNifmhcanVmUzKy/Qc?=
 =?us-ascii?Q?5GWIFdaWG+W8zpjdBx3yk0uCeiSo/jRc4pL6sdwOvLQ5fKjxXZF9jbcHO2B/?=
 =?us-ascii?Q?tUEWX0XD+IDahbz4qP/Z7yGZ/8bF9+MEdL/npZCnlZ7TR85yYfoWJvyS0xyT?=
 =?us-ascii?Q?gGOuTg4PjQhf+6LCRu2xKNCoMVvg1lSEIJlcRzFXtmHG599xFVzdqJCyZ3Ca?=
 =?us-ascii?Q?GX6Ul/zDYtl5mdxHGNyC7zLGfPIajg9z244IboAf9ZuX52QnTUBN4mTOvC4V?=
 =?us-ascii?Q?KCCx7LDMharVzDrvgw9RJnZEz3vcK6AA+LK/c+r2NwjiYz5UUCc70PxE8wLo?=
 =?us-ascii?Q?AGe4FV/YwQ62vYMEwmrq9zXwbTARwKdFqBzkTWqE100qeEKyoik3s7Rse7G1?=
 =?us-ascii?Q?Va2llZNTREhWANFFPe7oCSoXUFqIa75Y83RBiDGpP8QjpTCiUusk6qjIadK2?=
 =?us-ascii?Q?0a/mkrvyR98qr+ieBePCcPi4XQSYS/LLwu/3KDg+hx0dHpaMtSDVz64vrACO?=
 =?us-ascii?Q?h1Mj08hbekyRD+kA+YxL3tl9hmdEoUH4SNW5kT07Abt45XKLPafrmM2Q7Z1E?=
 =?us-ascii?Q?FlYYz48Qu6cqOyXkrIRZa9ybNcJKYLkJgRApvDmrsW5qHwwtxc93gKBUE4kl?=
 =?us-ascii?Q?w8Aep8rW4z0s2ZfQrSA7wGNdzCIjvJ9VOove1GaJoSXwMtzw3cGu8aWvFEFj?=
 =?us-ascii?Q?P19aEcpuVX19kSNAjX4xoeq8BVIYZW+GIaCXe3kS19XRCubUv+fF8Mcv6b7e?=
 =?us-ascii?Q?5YNqVZN51yowNxYRK4RAPOcT36nbsSBW3adqPuFeLt8lGW3wELOsdjHuwv+t?=
 =?us-ascii?Q?npKJ5Rrg/KAg7hwdCCCPArU1NFhAVYJ3x6Og2PVhC7p1BaRU1NGHRqAnYtbj?=
 =?us-ascii?Q?SCUQ9sVaIegmv8qdIM4iBLHONPZzhWXZ7N9Ab3bQO3vdSfoJEDU6fqrnUs71?=
 =?us-ascii?Q?XGGp+P/sPM/Vr6DRJkOuFc7Q29VrhV1v0aDbSW2QjgP6QCKTH+M3fjaf7eYZ?=
 =?us-ascii?Q?hEz7LRh2Iplx2AewFTC/PcfFIF3Z3C3pUQKehV5hKQQmnbnvTS8BX2kMuqiP?=
 =?us-ascii?Q?yQBUe4YVsk6sJ1/1rtSMLVOKrO/b65UpwNRdhn9qcK1vy0EWpF5JJJ3y8Lot?=
 =?us-ascii?Q?peRAkd8BRmuAiywCfVybuKC1BBbBnCQ+vEozX9ftxrAxmE+JXsQrTDwUNqgT?=
 =?us-ascii?Q?GHwdR9SQEhSOsawwpjricfYIzajJS3PneDF0NdzfeXWuemx1TuUBKxIjI1Sp?=
 =?us-ascii?Q?cZ4nVls66HVEEE/vaN8by7QDtAry5D20mSN+Lfcn0vKGMkF9SQqClLlgbHrm?=
 =?us-ascii?Q?39rGGazvI2KD/QVxMP7yAQHvb6b6YZHNDo5tpTtCrGrKfF4t4ejvaIb1y4ZI?=
 =?us-ascii?Q?A9TW/WaumHQf8g12rgA6qvXE3ATTbODlrnRB3MaY7OvKwk2sMhsyfDbtA1nL?=
 =?us-ascii?Q?bwBNemYnyFSxvxpUYXFHCihaXq8ij7SKXvCJf+0u8eqiPLwtNixlA4PQZzdu?=
 =?us-ascii?Q?fQaPXYXLMAZZuqZOzQHuAL0=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 1afaafb3-10b8-4192-4677-08db51491e22
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 11:24:29.4292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtG9L6OiIUX8Xe/ZedeGkcIICTNnM2+DrP/3sfIXZPhRR0s3I9N81zAqjZAb4w42ft4EKpSWH7EgfusYHD8HxcPKTk0SZQFdLeyMv9r0xjpI6C0PhhR1WIRKrS0K7Gsg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9138
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree file describing the Emtop SOM IMX8MM

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
---
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../arm64/boot/dts/freescale/imx8mm-emtop.dts | 261 ++++++++++++++++++
 2 files changed, 262 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-emtop.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 198fff3731ae..36590515fbc1 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -54,6 +54,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-beacon-kit.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-data-modul-edm-sbc.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-ddr4-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-emcon-avari.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mm-emtop.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-ctouch2.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-icore-mx8mm-edimm2.2.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts b/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
new file mode 100644
index 000000000000..461e1ef5dcb4
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop.dts
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 Emtop
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
+	model = "Emtop SOM i.MX8MM";
+	compatible = "emtop,imx8mm-emtop", "fsl,imx8mm";
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
+&iomuxc {
+	pinctrl_gpio_led: gpioledgrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16			0x19
+			MX8MM_IOMUXC_SAI3_RXC_GPIO4_IO29			0x19
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_I2C1_SCL				0x400001c3
+			MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA				0x400001c3
+		>;
+	};
+
+	pinctrl_pmic: pmicirq {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3			0x41
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX			0x140
+			MX8MM_IOMUXC_UART2_TXD_UART2_DCE_TX			0x140
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
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
+	pinctrl_usdhc3_100mhz: usdhc3-100mhzgrp {
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
+	pinctrl_usdhc3_200mhz: usdhc3-200mhzgrp {
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
+	pinctrl_wdog: wdoggrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B			0xc6
+		>;
+	};
+};
-- 
2.25.1

