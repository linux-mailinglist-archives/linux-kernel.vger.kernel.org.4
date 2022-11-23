Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171BC636E72
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiKWXcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiKWXch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:32:37 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2107.outbound.protection.outlook.com [40.107.220.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22041E094;
        Wed, 23 Nov 2022 15:32:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiQaIZws1X2+JjjGWFk8+4Xz8jZUDKby4T5ntihKSMHVkC7V5InNeIQxxcDzjrqiL6PHmJdwz+Oy+RT+7WmXkTk+zLeAExtCDBcUbCUtdyVzeVC4dxWOlQbPa/FiXXRvG6WOhYceDURgU0CoEmTmKTl3CVS7iMqds2qEU1hXR6VHyNZQycttIB7MrC1TvTeLrf6SnvfNwcl7bZOIEXJ2qA2w+mz49d3o8oSlr7UnMYM+MVlOi7NKDhOmNd+W7BHzI2c7KDI1CKfUmeumK9qaM4W5M9W3g2FINB1DSYj7noR3isjZiMmK3c1x4ugI14/9U1aIJ5p6/wfAfiOB71H0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTqBk6937wKHSAfoK/1iSUgScwo3M+NYAU3SgNb+8KQ=;
 b=NScncdQ/Xcn/lOq6WQ59OnzkyvKe84VKb6LiG6yV/0rdkJku92hUGqSnuQy+6PTX5ozIulNYPmeuF6R1NmffiZ3qVsLMP+6yRwyTDmR48RKVRO6JHZvuGHqGk0aqh4nwZxbUe8wTAuTi0lcaEbYpnAZPAKX3uA4ZomhQrRKprCdaKVc83zj6p78+FJAun6+ldpzxDwvYgKCxa0Qxh1bHvFIYkhpvcNP5KtKZr3eU8eEAQfHtnO86y1Vj6WuUEqtxvEqnPeZKp9oYtHJdH7b2Yyev5Iv0/QxBAQf9c2XcY2r5jUzlpOqVcrdLvg8X1FLu56QUjnAMbQ6koswMLVZXCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTqBk6937wKHSAfoK/1iSUgScwo3M+NYAU3SgNb+8KQ=;
 b=H3RImKaO5a0XJZywq2SMQmtuER9Sl/D4tLszS6LUcs7EjYBWstxupSnDNp9qflwj9oVRWwPc3aLNoR/ORGE0kN0kEel6Tb41Px2nrEASr4Ah5b/GeBSC3MMMuXyfA9Trib4jbqP2FhdVwOqCg6mxVW38WDoa/6MVRf0eZYKXFnA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CH0PR10MB4873.namprd10.prod.outlook.com
 (2603:10b6:610:c7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 23:32:29 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::45b5:a860:9cea:a74c]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::45b5:a860:9cea:a74c%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 23:32:29 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/2] arm: dts: omap4: pcm959: add initial support for phytec pcm959
Date:   Wed, 23 Nov 2022 15:32:09 -0800
Message-Id: <20221123233209.1854806-3-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123233209.1854806-1-colin.foster@in-advantage.com>
References: <20221123233209.1854806-1-colin.foster@in-advantage.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:a03:180::38) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|CH0PR10MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d2fd03-21d6-430c-b6a0-08dacdaafc49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0lzq+t5citey+KFmdowNDCNdQ15iG+9gyhhsRada8s4Lk/8T09aCcTCNBAU3KfuwWVByXKllwDgAvZIdPgXUahkxz6flWnrPa5BYI0cQYeJE3dLiku7AnFv2YNiTSxSgOKh3rjwRESpw6YCTYAKQYEH739ghByiXWymT8Cp/r3VD1TPdbDgpLfQFXfhl3vhZFCjCgSRUokGD3TL6OdLHeKLO4XEe7dQj2qZ7+Z9nD6v/DU30e5UieSdfGB7OyDsm9XTJmOHENS1YisMob7tYVxQERiSb6Gl4BCL6uy7WufzNI33iUIFL4d1UMoE9tRv610Qef/eivtK1YBd9xf8AJpVAGAwi8pM85PZKoC+EsPBpDLsPjxUPmftCXGFBMYqi3TB3DDlHUX7gjOVM7mVOCjY6pFf3d7lUIcvAfPWENFwS99zSccnN3bLesg7xgKZr278kU5NZMRRh0B0XJcVSS1snOvT5KWfMInwRgb0S1nrO/p/zYscrjj+czJzx9AK9sn49valGy+b5Vsix+NyIP9/KtKepLSQpFjeBlkmZbv60TCi4oKtsY9zstTQZiJIEIc2OfB+XJGXpyBuMIWB+KWvVkU1XQATyJO7mv6BNNCgY9V99HgEdz6Wwi/RIW8sdmpJuXNIO6gIqLSfNuqO0yntEPzcaZQ9IWNfDi83HtonNI9N3uHR6JmmIqrsBiZx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39840400004)(376002)(346002)(136003)(451199015)(6666004)(41300700001)(478600001)(6486002)(66476007)(30864003)(8676002)(316002)(1076003)(8936002)(26005)(66556008)(66946007)(4326008)(7416002)(186003)(5660300002)(36756003)(54906003)(44832011)(52116002)(6506007)(83380400001)(2616005)(2906002)(86362001)(6512007)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TeK1FlvodET2JPggP7xWomoIbtxGhKMcgE3VLB5O61EG/yfWvnKeWfrj3qIs?=
 =?us-ascii?Q?5ED4vItcpqugausvJkwZyhGXtS8wi7gDYpFIEK1Jf9rv5OV4nrqPqgvIrdI5?=
 =?us-ascii?Q?PT90xTbUFDLf2GZA5LOpy4f294RQQ+XJQrrWO6HCDGnLiie05nauFap3pv01?=
 =?us-ascii?Q?yo5m6o8L6DRYjZsNKayk2P0q5r2iswO8qRURO0DIptI3X4mHP5TRP4L9IuZf?=
 =?us-ascii?Q?1B3LfzKOQlcSRBTd/LMNjv9b1mS4afqKKyNMTK2xX0TKjwHxQZ5y/t9dQPQc?=
 =?us-ascii?Q?dZgALE+d9afWINisax5CcnFRIr0/jzLKYvPvhDZtWQIXHzlAXPxGQvloVkmM?=
 =?us-ascii?Q?u9SalkV5AabwbhZ6O4bPpMKJL+KPHh6EZkTCH4iMJaOnbe46L72PORORUmoR?=
 =?us-ascii?Q?a9Z8qykuyUINdSNsKd7XwpFTG6+9MyULZEA/+AfLez39xw0Cdg49QLBEwGam?=
 =?us-ascii?Q?IhbWDDSHRiW+iRhzSzCKXFiWsCTRAO5OhSn8wPwhm1yJBUHyLPa8B8PjDles?=
 =?us-ascii?Q?jl8o/sN+516ic6PyLSlsglNGAfxawWP9k+jKA+PnVQUdbHzFPcgnPgTBRDzK?=
 =?us-ascii?Q?dHvCD0nazni4OD4giGLwNhs1A6OyEylb8i7Kignavn+T12jqXkzfsnxWFiJe?=
 =?us-ascii?Q?73yaf+PC+hGYeFKoDpnOxVi0rLUgPEoqCO2wUjsc4M3Hq4rKrCw17WN7337N?=
 =?us-ascii?Q?CTqL3JcEcgTmjlr9rH9TE63MBK5E4fZlKC1OpdzCzKFK5mkE72N6tB3kDnHZ?=
 =?us-ascii?Q?PJrFECSvhnhyajlCg74hRPqrQDl0SGY8zf75KcwsZ28SeE7pcYmVSarolXwT?=
 =?us-ascii?Q?BPgjgOsFOQx0/BZhLCrYgzFg54QZ7kyHOlm3bh9g9rCS71xU1uQCxh/VqnfP?=
 =?us-ascii?Q?Ncj5mc9T0L6IWE9K2VGCtDXM2TPbEg8b8baCTxrp7J79DTXcqvPa/fUQJ6AI?=
 =?us-ascii?Q?hYGo+3bpFGOgN8FV4qY9BPFMMsgV+Kc3Z42PrN8+5scDkZ2j6cQLjjanjtTu?=
 =?us-ascii?Q?d3U5dX/jMi3Jjn/78rFJSzm99rXr2YKf0+WooCz9mDsruE22EXlJyUpnANl+?=
 =?us-ascii?Q?GboQKkxQoI7x20kdK9d2jPsU3mL4a+C6nkGv2m1wM2a4COx/fkgMAB7Tqjrr?=
 =?us-ascii?Q?DDhglxsc0J5JwgmPhIhCVBO4aXfIv6dbXjJZpYY9SHd8TRrHh0hWIW2WlJv5?=
 =?us-ascii?Q?lAElhAtjZB4mf9cLhhM06Z2z2VYwVYHEy5/1ccHKbxkCKts/BzFw5AkDXS+0?=
 =?us-ascii?Q?++db2ZFBOGjOoh6u8MUztO9+UKLFUQMpjWso9pFDaH2fcqje4hkBDyJs1HaX?=
 =?us-ascii?Q?7NELQOEiJrsjl18Om2Nq9EBhPuGAZl9kzkuZGc1/NyF3v4iuio/v0mGWkR1I?=
 =?us-ascii?Q?EMpPmbsEF4OnYZ3DZSfU43G+jyUJwrt4djTbVdZ8QF0CsLVJu5vEI1jdnpA4?=
 =?us-ascii?Q?sQm/yAED+BnkFwxAWbdh9PV6ECKWLiTz0CaMQ27BzCt55BytLjehlwrEtdGb?=
 =?us-ascii?Q?Fi+7Zja+FOFUrJLjV0u1Sr+Xe1a18870r2et3hM/Ugvi67b7+Zeiv7DrlM1j?=
 =?us-ascii?Q?qywis4nxyHSQc+/a/QzlfeDUrzDG/O2oUxO7RK0KqP0q66yVRO/+IzvYGDTg?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d2fd03-21d6-430c-b6a0-08dacdaafc49
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 23:32:28.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +TAXN0GvNtYl6H1AiNa1b31gArknVLJfNpHmjjjFoJdHQBUNswDRSyKILLgnj4IWvqbHE2p8i9NK0tM3cbMuo1ZnN4QQRuJNvTOzgYvKdSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4873
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Phytec PCM-959 is a development platform for the Phytec PCM-049 SOM.
Add initial functionality for the board. The verified interfaces and
peripherals are listed below for the SOM (PCM-049) and the dev board
(PCM-959)

The omap2plus_defconfig was used for testing. Only the On-board LEDs
required CONFIG_LEDS_PCA9532 addition.

PCM-049:
i2c1
  * EEPROM at 0x50
  * TMP102 (hwmon) at 0x4b
twl6030
GPMC
  * Ethernet
  * Flash
Serial (ttyS2 console)

PCM959:
MMC1
On-board LEDs (with CONFIG_LEDS_PCA9532)

Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
---

v1->v2
    * Almost everything moved to the SOM (PCM049)
    * Fix where omap_pmx_wkup were actually getting applied to
      omap_pmx_core.
    * Use hyphens instead of underscores for names
    * Remove unnecessary entries of "status=okay"
    * Use generic "regulator" and "led" names
    * add compatible strings for the dev board and SOM

---
 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi | 412 ++++++++++++++++++++
 arch/arm/boot/dts/omap4-phytec-pcm-959.dts  |  48 +++
 3 files changed, 461 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-phytec-pcm-959.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 6aa7dc4db2fc..ae8338cb5bb1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -968,6 +968,7 @@ dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-panda.dtb \
 	omap4-panda-a4.dtb \
 	omap4-panda-es.dtb \
+	omap4-phytec-pcm-959.dtb \
 	omap4-sdp.dtb \
 	omap4-sdp-es23plus.dtb \
 	omap4-var-dvk-om44.dtb \
diff --git a/arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi b/arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
new file mode 100644
index 000000000000..314b37e51082
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Innovative Advantage, Inc.
+ */
+#include <dt-bindings/input/input.h>
+
+/ {
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>; /* 1 GB */
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		dsp_memory_region: dsp-memory@98000000 {
+			compatible = "shared-dma-pool";
+			reg = <0x98000000 0x800000>;
+			reusable;
+			status = "okay";
+		};
+
+		ipu_memory_region: ipu-memory@98800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x98800000 0x7000000>;
+			reusable;
+			status = "okay";
+		};
+	};
+
+	chosen {
+		stdout-path = &uart3;
+	};
+
+	leds: leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <
+			&led_gpio_pins
+		>;
+
+		led-0 {
+			label = "modul:red:status1";
+			gpios = <&gpio5 0x18 GPIO_ACTIVE_HIGH>; /* GPIO 152 */
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			label = "modul:green:status2";
+			gpios = <&gpio5 0x19 GPIO_ACTIVE_HIGH>; /* GPIO 153 */
+			linux,default-trigger = "mmc0";
+		};
+	};
+};
+
+&gpio1_target {
+	ti,no-reset-on-init;
+};
+
+&omap4_pmx_core {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&tps62361_pins
+	>;
+
+	i2c1_pins: pinmux-i2c1-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x122, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
+			OMAP4_IOPAD(0x124, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
+		>;
+	};
+
+	i2c3_pins: pinmux-i2c3-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x12a, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_scl */
+			OMAP4_IOPAD(0x12c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_sda */
+		>;
+	};
+
+	i2c4_pins: pinmux-i2c4-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x12e, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_scl */
+			OMAP4_IOPAD(0x130, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c4_sda */
+		>;
+	};
+
+	uart1_pins: pinmux_uart1_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x126, PIN_INPUT_PULLUP | MUX_MODE1)	/* uart1_rx */
+			OMAP4_IOPAD(0x128, PIN_INPUT_PULLUP | MUX_MODE1)	/* uart1_tx */
+		>;
+	};
+
+	uart2_pins: pinmux-uart2-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x118, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts */
+			OMAP4_IOPAD(0x11a, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts */
+			OMAP4_IOPAD(0x11c, PIN_INPUT | MUX_MODE0)		/* uart2_rx */
+			OMAP4_IOPAD(0x11e, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx */
+		>;
+	};
+
+	uart3_pins: pinmux-uart3-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x140, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart3_cts */
+			OMAP4_IOPAD(0x142, PIN_OUTPUT | MUX_MODE0)		/* uart3_rts */
+			OMAP4_IOPAD(0x144, PIN_INPUT | MUX_MODE0)		/* uart3_rx */
+			OMAP4_IOPAD(0x146, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx */
+		>;
+	};
+
+	led_gpio_pins: pinmux-leds-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x156, PIN_OUTPUT | MUX_MODE3)	/* gpio_152 */
+			OMAP4_IOPAD(0x158, PIN_OUTPUT | MUX_MODE3)	/* gpio_153 */
+		>;
+	};
+
+	pinctrl_tempsense: pinmux-pinctrl-tempsense-pins{
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x154, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpio_151 */
+		>;
+	};
+
+	gpmc_pins: gpmc-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x40, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad0 */
+			OMAP4_IOPAD(0x42, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad1 */
+			OMAP4_IOPAD(0x44, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad2 */
+			OMAP4_IOPAD(0x46, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad3 */
+			OMAP4_IOPAD(0x48, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad4 */
+			OMAP4_IOPAD(0x4a, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad5 */
+			OMAP4_IOPAD(0x4c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad6 */
+			OMAP4_IOPAD(0x4e, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad7 */
+			OMAP4_IOPAD(0x50, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad8 */
+			OMAP4_IOPAD(0x52, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad9 */
+			OMAP4_IOPAD(0x54, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad10 */
+			OMAP4_IOPAD(0x56, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad11 */
+			OMAP4_IOPAD(0x58, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad12 */
+			OMAP4_IOPAD(0x5a, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad13 */
+			OMAP4_IOPAD(0x5c, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad14 */
+			OMAP4_IOPAD(0x5e, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* gpmc_ad15 */
+
+			OMAP4_IOPAD(0x60, PIN_OUTPUT | MUX_MODE0)		/* gpmc_a16 */
+			OMAP4_IOPAD(0x62, PIN_OUTPUT | MUX_MODE0)		/* gpmc_a17 */
+			OMAP4_IOPAD(0x64, PIN_OUTPUT | MUX_MODE0)		/* gpmc_a18 */
+			OMAP4_IOPAD(0x66, PIN_OUTPUT | MUX_MODE0)		/* gpmc_a19 */
+			OMAP4_IOPAD(0x68, PIN_OUTPUT | MUX_MODE0)		/* gpmc_a20 */
+			OMAP4_IOPAD(0x6a, PIN_OUTPUT | MUX_MODE0)		/* gpmc_a21 */
+			OMAP4_IOPAD(0x6c, PIN_OUTPUT | MUX_MODE0)		/* gpmc_a22 */
+			OMAP4_IOPAD(0x6e, PIN_OUTPUT | MUX_MODE0)		/* gpmc_a23 */
+
+			OMAP4_IOPAD(0x82, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* gpmc_noe */
+			OMAP4_IOPAD(0x84, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* gpmc_nwe */
+
+			OMAP4_IOPAD(0x7c, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* gpmc_nwp */
+			OMAP4_IOPAD(0x80, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* gpmc_nadv_ale */
+			OMAP4_IOPAD(0x86, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* gpmc_nbe0_cle */
+			OMAP4_IOPAD(0x8a, PIN_INPUT_PULLUP | MUX_MODE0)		/* gpmc_wait0 */
+			OMAP4_IOPAD(0x8c, PIN_INPUT_PULLUP | MUX_MODE0)		/* gpmc_wait1 */
+
+			OMAP4_IOPAD(0x74, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_ncs0 */
+			OMAP4_IOPAD(0x76, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_ncs1 */
+			OMAP4_IOPAD(0x92, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* gpmc_ncs5 */
+		>;
+	};
+
+	ethernet_pins: ethernet-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x114, PIN_INPUT | MUX_MODE3)		/* gpio_121 */
+		>;
+	};
+
+	tps62361_pins: pinmux-tps62361-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x19c, PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpio_182 */
+		>;
+	};
+
+	mmc1_pins: pinmux-mmc1-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x0e2, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk */
+			OMAP4_IOPAD(0x0e4, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd */
+			OMAP4_IOPAD(0x0e6, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat0 */
+			OMAP4_IOPAD(0x0e8, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1 */
+			OMAP4_IOPAD(0x0ea, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2 */
+			OMAP4_IOPAD(0x0ec, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3 */
+		>;
+	};
+};
+
+&omap4_pmx_wkup {
+	pinctrl-names = "default";
+	pinctrl-0= <
+		&smartreflex_i2c_pins
+		&fref_xtal_in_pins
+		&fref_clk3_out_pins
+		&sys_pins
+	>;
+
+	ethernet_wkgpio_pins: pinmux-ethernet-wkup-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x66, PIN_OUTPUT | MUX_MODE3)		/* gpio_wk29 */
+		>;
+	};
+
+	smartreflex_i2c_pins: pinmux-smartreflex-i2c-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x4a, PIN_INPUT_PULLUP | MUX_MODE0)		/* sr_scl */
+			OMAP4_IOPAD(0x4c, PIN_INPUT_PULLUP | MUX_MODE0)		/* sr_sda */
+		>;
+	};
+
+	fref_xtal_in_pins: pinmux-fref-xtal-in-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x4e, PIN_OUTPUT | MUX_MODE0)		/* fref_xtal_in */
+		>;
+	};
+
+	fref_clk3_out_pins: pinmux-usb-refclk-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x58, PIN_OUTPUT | MUX_MODE0)		/* fref_clk3_out */
+		>;
+	};
+
+	sys_pins: pinmux-sys-pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x5e, PIN_INPUT | MUX_MODE0)		/* sys_32k */
+			OMAP4_IOPAD(0x60, PIN_OUTPUT | MUX_MODE0)		/* sys_nrespwron */
+			OMAP4_IOPAD(0x62, PIN_OUTPUT | MUX_MODE0)		/* sys_nreswarm */
+			OMAP4_IOPAD(0x64, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sys_pwr_req */
+			OMAP4_IOPAD(0x68, PIN_INPUT | MUX_MODE0)		/* sys_boot6 */
+			OMAP4_IOPAD(0x6a, PIN_INPUT | MUX_MODE0)		/* sys_boot7 */
+		>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+
+	clock-frequency = <400000>;
+
+	twl: twl@48 {
+		compatible = "ti,twl6030";
+		reg = <0x48>;
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
+	};
+
+	core_vdd_reg: regulator@60 {
+		compatible = "ti,tps62361";
+		reg = <0x60>;
+
+		regulator-name = "tps62361-vout";
+		regulator-min-microvolt = <500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-coupled-max-spread = <300000>;
+		regulator-max-step-microvolt = <100000>;
+		regulator-boot-on;
+		regulator-always-on;
+		ti,vsel0-gpio = <&gpio5 22 GPIO_ACTIVE_HIGH>;
+		ti,vsel0-state-high;
+	};
+
+	temperature-sensor@4b {
+		compatible = "ti,tmp102";
+		reg = <0x4b>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tempsense>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+		#thermal-sensor-cells = <1>;
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c32";
+		reg = <0x50>;
+	};
+};
+
+#include "twl6030.dtsi"
+#include "twl6030_omap4.dtsi"
+
+&i2c2 {
+	status = "disabled";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	status = "okay";
+
+	clock-frequency = <100000>;
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+	status = "disabled";
+
+	clock-frequency = <400000>;
+};
+
+&vmmc {
+	ti,retain-on-reset;
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+
+	vmmc-supply = <&vmmc>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc2 {
+	status = "disabled";
+};
+
+&mmc3 {
+	status = "disabled";
+};
+
+&mmc4 {
+	status = "disabled";
+};
+
+&mmc5 {
+	status = "disabled";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+	status = "okay";
+};
+
+&uart4 {
+	status = "disabled";
+};
+
+&elm {
+	status = "okay";
+};
+
+#include "omap-gpmc-smsc9221.dtsi"
+
+&gpmc {
+	ranges = <5 0 0x2c000000 0x01000000>,
+		 <0 0 0x08000000 0x01000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&gpmc_pins
+		>;
+	status = "okay";
+
+	nandflash: nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>;
+		interrupt-parent = <&gpmc>;
+		rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>;
+		nand-bus-width = <16>;
+		ti,nand-ecc-opt = "bch8";
+		ti,elm-id=<&elm>;
+		linux,mtd-name = "micron,nand";
+		gpmc,device-nand = "true";
+		gpmc,device-width = <1>;
+
+		gpmc,sync-clk-ps = <0>;
+		gpmc,cs-on-ns = <0>;
+		gpmc,cs-rd-off-ns = <44>;
+		gpmc,cs-wr-off-ns = <44>;
+		gpmc,adv-rd-off-ns = <34>;
+		gpmc,adv-wr-off-ns = <44>;
+		gpmc,we-off-ns = <40>;
+		gpmc,oe-off-ns = <54>;
+		gpmc,access-ns = <64>;
+		gpmc,rd-cycle-ns = <82>;
+		gpmc,wr-cycle-ns = <82>;
+		gpmc,wr-access-ns = <40>;
+		gpmc,wr-data-mux-bus-ns = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	ethernet@gpmc {
+		reg = <5 0 0xff>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <
+			&ethernet_pins
+			&ethernet_wkgpio_pins
+		>;
+
+		/* Either GPIO 103 or GPIO 121. Use 121 to match the reference design */
+		interrupt-parent = <&gpio4>;
+		interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
diff --git a/arch/arm/boot/dts/omap4-phytec-pcm-959.dts b/arch/arm/boot/dts/omap4-phytec-pcm-959.dts
new file mode 100644
index 000000000000..f323d64660d7
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-phytec-pcm-959.dts
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Innovative Advantage, Inc.
+ */
+/dts-v1/;
+
+#include <dt-bindings/leds/leds-pca9532.h>
+#include "omap4460.dtsi"
+#include "omap4-phytec-pcm-049.dtsi"
+
+/ {
+	model = "Phytec PCM-959 Eval Board";
+	compatible = "phytec,pcm959", "phytec,pcm049", "ti,omap4460", "ti,omap4430", "ti,omap4";
+};
+
+&i2c4 {
+	status = "okay";
+
+	leddim: led@62 {
+		compatible = "nxp,pca9533";
+		reg = <0x62>;
+
+		led-1 {
+			label = "board:red:free_use1";
+			linux,default-trigger = "none";
+			type = <PCA9532_TYPE_LED>;
+		};
+
+		led-2 {
+			label = "board:yellow:free_use2";
+			linux,default-trigger = "none";
+			type = <PCA9532_TYPE_LED>;
+		};
+
+		led-3 {
+			label = "board:yellow:free_use3";
+			linux,default-trigger = "none";
+			type = <PCA9532_TYPE_LED>;
+		};
+
+		led-4 {
+			label = "board:green:free_use4";
+			linux,default-trigger = "none";
+			type = <PCA9532_TYPE_LED>;
+		};
+	};
+};
+
-- 
2.25.1

