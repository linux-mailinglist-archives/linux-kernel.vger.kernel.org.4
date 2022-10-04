Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093165F3B7E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 04:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJDCku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 22:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJDCkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:40:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2113.outbound.protection.outlook.com [40.107.220.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D529A205E6;
        Mon,  3 Oct 2022 19:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+9FYkdJI6OTLx44w3HawFfDfAd+yRS184o8IzD6ptuhG2/AvezRgiZ6eH5CJvCljQ/l0DIH0sBDwbl87kH8Gd0duGCrwa5Hq3fg4l0xDthhO9N2rsd59TDtQGIXG/wRVvZFy+5/nhm+KH8vXM42GxFA8H9DTL4vRABZcy/rse8gWwsZ9J/+fa37HlyhYSrN122/bi0sBUa6Lfbu0loAfhjM8iNDbtpAbTqWRh22+dzbd33pP76nbxkp+yyPHG4nobiu6rpO3Ciea0K4cIjc1vle6Svv9cFxr2gYn9PUvgXfZaANUdbiIIwzeaORUfMLZFtMelVBvkHpClf55vjBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixN65Pi68lpL3dWvGdKrBSGxdYpRvz3+YIbQGg5kvTo=;
 b=eTYOIXcp9nRCJqaDps9Jft0/flbUiQTfmPJZfWYULtGcvGSliXycibjpUrCTYaX/cv9iqFDAOcE9JoqQdOL4koPny/YWtUMHFZ1VJ8eRnhUUWkFd0aCWpv9jENZ5YE0QZ/Z0Mepcy07wpkYcQBNzBe+89yiB+B67UD/+D5RoD4hYiZC0lgj+9mhegr02FsyRhI4J44H4eSJjO5OosRUg3bK4g57dAvGEIgnZAh2i+t2tqEx+Ea+N8owwKfNOUSxFBwWo1uMu2g3sQPY791GJgGx8M7XvrBQgL1tY/TJNWsheugULZtk1iDbWrTapUw+XyRlqHhA35TM7MFbW4hsBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixN65Pi68lpL3dWvGdKrBSGxdYpRvz3+YIbQGg5kvTo=;
 b=EL0BA9hHgnKMfPvLHwb1eZ6TD7wDbR4LaNu1zZdLcMs3r7PzyzB4sWB9Mn7w82Hmg0dnt3Th8pVSOfMwQawd/+q1nG802PZaQe2nBxvNrxzpZu+XWi6evY9Jki2iUqgY2ppckp0F0GcwmCK0rzrU6yvHNNJP1GvM8gOfRyjsrEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CY8PR10MB6802.namprd10.prod.outlook.com
 (2603:10b6:930:99::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 02:40:41 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::ee5e:cbf9:e304:942f]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::ee5e:cbf9:e304:942f%7]) with mapi id 15.20.5676.028; Tue, 4 Oct 2022
 02:40:41 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, soc@kernel.org,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [RFC v1 1/1] arm: dts: omap4: pcm959: add initial support for phytec pcm959
Date:   Mon,  3 Oct 2022 19:40:12 -0700
Message-Id: <20221004024012.1386218-2-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221004024012.1386218-1-colin.foster@in-advantage.com>
References: <20221004024012.1386218-1-colin.foster@in-advantage.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::39) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|CY8PR10MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a62395-ce58-4eed-2234-08daa5b1d179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5hA+cn5aRtDxPcEpiM9Jv49mV93Uapyas/BxRWuFki4hiTBxpPt9CZbGIHi2aoZ//Skl0f8jJ4NaJW2iRmJzy1mxc7/ub/BjvMq0m3dP6PGyEzF1FRhktVRKBdiYPWj6RB42djhTG6+v0HqzgWd4MFVTGUAyYqJ7jtGo8kNP0M+llANiPADt1eMiUiOnfXXdf2OezcVPPT8ZyZRUDb8hjo8ZbjX5y6trFFCRhpZZvZitlIpnFjNf41uDbk35lMiZuTn9FTt1BeVpC5n8PkyJcwIzXKvcUjcjq5IHGlGLQnx7/BcwMjdKNd5kIH+BD49lewI5ofbabhV7mtPAF3Lvq7TndeX5/164zZmbtKLVXt4Jo+mbHbcc7NtGpt51W6RB3npxEK54WP57/MDBtHqzm0Z2zYjzCbZE4BPrZQLROVR0WEucoo3udGxwaLL3TNv6I8vYnrAR0QHf6Vtmw0a/atrG48V5S87TdjnSVrgac1deeLtnMfGaicN72Wj8a7Mz5OuUb6Nhv93TTOaomwIVEjF7D6emSmsgyG6mzOuyrU/BRvjlZQENQJFZ7bJ+2ZMUNwwUYAj/uT0JMh+x/PtHLndVwIlFggoL4PNi4SN+oNHC6ade/H9B9tzKIJFXawfv1avclfmTds5oOCxUm3w0uBbY68kQ9zXVvlrX5R6u4tASccfrUfXoB/BGw8vqeHhHZ+OKywJcMT0jES3jZwsPOMPtdcOx7nzGDXPRmhn7vxCLPy5VP4liN4FmUD5TsSzrNPUQWl/JGXQQT241xpIiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(346002)(136003)(366004)(39840400004)(451199015)(2906002)(316002)(30864003)(5660300002)(44832011)(66946007)(8676002)(66476007)(66556008)(4326008)(7416002)(86362001)(6666004)(54906003)(6486002)(8936002)(36756003)(41300700001)(6506007)(478600001)(2616005)(52116002)(26005)(6512007)(186003)(1076003)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zOVZK0GVGrpSaNMq7Q1MJ2Y8rQEBlDpWOUxnUYSjnl44qN3vZOwcX3DMuY7W?=
 =?us-ascii?Q?c0oO1ULZac2umiKI2dxkO1WXw1+gxqm65Mj4bUWIiHl+FnzAAHcqzm2UcjV8?=
 =?us-ascii?Q?dNqW6sK28nhaTsxKtxgiAC4OIpGRGRgUVAoJ20gxooQd32m64/gpbED2VCK8?=
 =?us-ascii?Q?MU5TBv2fohl1l9HWzOV+d75C4FgExV2pgolP53FMddXffniH6cLKhweNSvr6?=
 =?us-ascii?Q?9ENS9qEsRv6YdvjUuODOgBCxZxajgS9+fImQB7BlYEjCNzMJ7TQZ4j+Jjlz9?=
 =?us-ascii?Q?qusvb+Mf0SqQindGIUmdYKt8rCyCwY3PqHXY3SrDBYwq+Kl9lOihp0do/2pm?=
 =?us-ascii?Q?O/jH2wZZdYroO7ZzS4HSQj5J5Of6L9j4F1WWGxRigxsECY8NJ9/qRkNhBTwP?=
 =?us-ascii?Q?VUUYOTdQWkttwIWZbkMOc1oA7TYhN8wfngIV21oWGsZfAeMisU2E0iANnvcP?=
 =?us-ascii?Q?nMrAgwssHL3/PFX1ZJ2XZR3dmsKI0sWGiKs7d+210E4NRfwN6rimtiDSbLyu?=
 =?us-ascii?Q?W8eKq1FHXe2lxs3pJxGeFGjstm0rGba7yKNgJhgsoofZS4ciiICII/elE8SI?=
 =?us-ascii?Q?X0VJBHpVEAIxpYJoZHeOWrzr7z3hEiErTTmtchi7FRvlnC++gyKTwN8R4EAn?=
 =?us-ascii?Q?OJ3hJHOxZYhf9quODc2SRDVB9bnMpUQL3Ebmnvzn4ZATZPOJ25sdQZgonoXg?=
 =?us-ascii?Q?9Flij643Dviawl8mjoAEwpPIfbE4C2AxUK35LOD/dSgGYcmCusmIPcOShNp+?=
 =?us-ascii?Q?HUlJiidCg/gRHZrQSUJ3UXwwCCDIOO8QEBDoA/cPNfs9DC+mRx4iZ17HeaL/?=
 =?us-ascii?Q?cqVfztiP6agN/oLkdRA2kHRj2e300kfn1/l/zysXRRow7tLgyPiZtdYW01Xw?=
 =?us-ascii?Q?3TAPEPZ4r6M/fQL1Eir4qN+pHuveN5TPk+NOo1Elgy85UowAEN/O/FAjBlP4?=
 =?us-ascii?Q?YE8K+0179hngj8uoG6qrhM8UNnKcFAn6Q7za8/4MMk/32TD+GWZ1WYC4AhS7?=
 =?us-ascii?Q?VB2CpugZ7qpJN670X6zsjhHy/som2A/bUbLerHK4S9dRvSY+4Xsaq3y5paDP?=
 =?us-ascii?Q?vN6jsV3XJ64wGn1i1ig5Zy3LddwsTscW1uzCkjzhoe96cslPbVJip188YK2I?=
 =?us-ascii?Q?sd3nJe8MkfF3PNQ7nhuUQTD6LbbTtrORLrloiZdRA8LHZZ1Pl1pcifiZS0Km?=
 =?us-ascii?Q?njOhzJFnFMgngS7GO6XKFIZ5u5JCiwP2bpjW010sQoL4jc9KlrtK1vHEYCXj?=
 =?us-ascii?Q?ixXnqLrCOIz/jeEVI34xgs+dCTmM9ynHX/NRRHohAL8BEs6rxGv/khkhVMqa?=
 =?us-ascii?Q?V9MX8yiVyNWMVUmXn7VuZC175IFPErAHnnTLycjKk4nPJNv5UsYJ4gB3uows?=
 =?us-ascii?Q?RRyDDOKezQEnAsdD5Dr3xFHCUdrWK8c0YGQ6i4DrIweK//1WmXz33DnlXq2a?=
 =?us-ascii?Q?tO6HnrT60eJu4Ab8+ckjNKub6ylS7r3aYoeNVeLrwaL5SzRMgBb3i2JtAinR?=
 =?us-ascii?Q?1mrKOGa2pexKdLwj721uE4UMrgwx1H/TApPAff+TYrYbGn2H9fLmboxHqHAZ?=
 =?us-ascii?Q?PgCbKSQSWIHzcAONQi1MptSIYVQkWD3iYVfLWQPvoEJfXHY1Fk5KjpYf8+p0?=
 =?us-ascii?Q?UbgfE8Bltb2b5KK3ZTdoi3Y=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a62395-ce58-4eed-2234-08daa5b1d179
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 02:40:37.0548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujMRSVsqWED0bFSXT3xFP3cVcxAiq0RY6IBFjRSBdnPgXHT+qaKLK6edqDRfuZtwqEvswQHOF0qbs9QYO75nPK+HZrGl4o5rQtN/U2wrUPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6802
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
 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi | 352 ++++++++++++++++++++
 arch/arm/boot/dts/omap4-phytec-pcm-959.dts  | 130 ++++++++
 3 files changed, 483 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
 create mode 100644 arch/arm/boot/dts/omap4-phytec-pcm-959.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 27eec8e670ec..ef225150c5d7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -949,6 +949,7 @@ dtb-$(CONFIG_ARCH_OMAP4) += \
 	omap4-panda.dtb \
 	omap4-panda-a4.dtb \
 	omap4-panda-es.dtb \
+	omap4-phytec-pcm-959.dtb \
 	omap4-sdp.dtb \
 	omap4-sdp-es23plus.dtb \
 	omap4-var-dvk-om44.dtb \
diff --git a/arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi b/arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
new file mode 100644
index 000000000000..05b5cd581f15
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
@@ -0,0 +1,352 @@
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
+		status = "okay";
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <
+			&led_gpio_pins
+		>;
+
+		heartbeat {
+			label = "modul:red:status1";
+			gpios = <&gpio5 0x18 GPIO_ACTIVE_HIGH>; /* GPIO 152 */
+			linux,default-trigger = "heartbeat";
+		};
+
+		mmc {
+			label = "modul:green:status2";
+			gpios = <&gpio5 0x19 GPIO_ACTIVE_HIGH>; /* GPIO 153 */
+			linux,default-trigger = "mmc0";
+		};
+	};
+};
+
+&omap4_pmx_core {
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x122, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_scl */
+			OMAP4_IOPAD(0x124, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c1_sda */
+		>;
+	};
+
+	i2c3_pins: pinmux_i2c3_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x12a, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_scl */
+			OMAP4_IOPAD(0x12c, PIN_INPUT_PULLUP | MUX_MODE0)	/* i2c3_sda */
+		>;
+	};
+
+	i2c4_pins: pinmux_i2c4_pins {
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
+	led_gpio_pins: pinmux_leds_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x156, PIN_OUTPUT | MUX_MODE3)	/* gpio_152 */
+			OMAP4_IOPAD(0x158, PIN_OUTPUT | MUX_MODE3)	/* gpio_153 */
+		>;
+	};
+
+	pinctrl_tempsense: pinmux_pinctrl_tempsense_pins{
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x154, PIN_INPUT_PULLUP | MUX_MODE3)	/* gpio_151 */
+		>;
+	};
+
+	gpmc_pins: gpmc_pins {
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
+	ethernet_pins: ethernet_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x114, PIN_INPUT | MUX_MODE3)		/* gpio_121 */
+		>;
+	};
+
+	tps62361_pins: pinmux_tps62361_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x19c, PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpio_182 */
+		>;
+	};
+
+	mmc1_pins: pinmux_mmc1_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x0e2, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk */
+			OMAP4_IOPAD(0x0e4, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_cmd */
+			OMAP4_IOPAD(0x0e6, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat0 */
+			OMAP4_IOPAD(0x0e8, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat1 */
+			OMAP4_IOPAD(0x0ea, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat2 */
+			OMAP4_IOPAD(0x0ec, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_dat3 */
+		>;
+	};
+
+};
+
+&omap4_pmx_wkup {
+	ethernet_wkgpio_pins: pinmux_ethernet_wkpins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x66, PIN_OUTPUT | MUX_MODE3)
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
+		reg = <0x48>;
+		status = "okay";
+		/* IRQ# = 7 */
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_1N cascaded to gic */
+	};
+
+	core_vdd_reg: tps62361@60 {
+		compatible = "ti,tps62361";
+		reg = <0x60>;
+		status = "okay";
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
+		status = "okay";
+	};
+};
diff --git a/arch/arm/boot/dts/omap4-phytec-pcm-959.dts b/arch/arm/boot/dts/omap4-phytec-pcm-959.dts
new file mode 100644
index 000000000000..dca2b1dd4d51
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-phytec-pcm-959.dts
@@ -0,0 +1,130 @@
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
+	compatible = "ti,omap4460", "ti,omap4430", "ti,omap4";
+};
+
+&omap4_pmx_core {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&sr_wkup_pins
+		&fref_xtal_in_pins
+		&fref_clk3_out_pins
+		&gpio_wk7_pins
+		&fref_clk4_out_pins
+		&sys_pins
+		&tps62361_pins
+	>;
+
+	status = "okay";
+
+	uart3_pins: pinmux_uart3_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x140, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart3_cts */
+			OMAP4_IOPAD(0x142, PIN_OUTPUT | MUX_MODE0)		/* uart3_rts */
+			OMAP4_IOPAD(0x11c, PIN_INPUT | MUX_MODE0)		/* uart3_rx */
+			OMAP4_IOPAD(0x11e, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx */
+		>;
+	};
+
+	uart2_pins: pinmux_uart2_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x118, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts */
+			OMAP4_IOPAD(0x11a, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts */
+			OMAP4_IOPAD(0x11c, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_rx */
+			OMAP4_IOPAD(0x11e, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx */
+		>;
+	};
+};
+
+&gpio1_target {
+	 ti,no-reset-on-init;
+};
+
+&omap4_pmx_wkup {
+	sr_wkup_pins: pinmux_sr_wkup_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x4a, PIN_INPUT_PULLUP | MUX_MODE0)		/* sr_scl */
+			OMAP4_IOPAD(0x4c, PIN_INPUT_PULLUP | MUX_MODE0)		/* sr_sda */
+		>;
+	};
+
+	fref_xtal_in_pins: pinmux_fref_xtal_in_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x4e, PIN_OUTPUT | MUX_MODE0)		/* fref_xtal_in */
+		>;
+	};
+
+	fref_clk3_out_pins: pinmux_fref_clk3_out_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x58, PIN_OUTPUT | MUX_MODE0)		/* fref_clk3_out */
+		>;
+	};
+
+	gpio_wk7_pins: pinmux_gpio_wk7_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x5a, PIN_INPUT | MUX_MODE3)		/* fref_clk4_req */
+		>;
+	};
+
+	fref_clk4_out_pins: pinmux_fref_clk4_out_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x5c, PIN_OUTPUT | MUX_MODE0)		/* fref_clk4_out */
+		>;
+	};
+
+	sys_pins: pinmux_sys_pins {
+		pinctrl-single,pins = <
+			OMAP4_IOPAD(0x5e, PIN_INPUT | MUX_MODE0)		/* sys_32k */
+			OMAP4_IOPAD(0x60, PIN_OUTPUT | MUX_MODE0)		/* sys_nrespwron */
+			OMAP4_IOPAD(0x62, PIN_OUTPUT | MUX_MODE0)		/* sys_nreswarm */
+			OMAP4_IOPAD(0x64, PIN_OUTPUT_PULLUP | MUX_MODE0)	/* sys_pwr_req */
+			OMAP4_IOPAD(0x66, PIN_OUTPUT | MUX_MODE0)		/* sys_pwron_reset_out */
+			OMAP4_IOPAD(0x68, PIN_OUTPUT | MUX_MODE0)		/* sys_boot6 */
+			OMAP4_IOPAD(0x6a, PIN_OUTPUT | MUX_MODE0)		/* sys_boot7 */
+		>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	leddim: leddimmer@62 {
+		compatible = "nxp,pca9533";
+		reg = <0x62>;
+
+		led1 {
+			label = "board:red:free_use1";
+			linux,default-trigger = "none";
+			type = <PCA9532_TYPE_LED>;
+		};
+
+		led2 {
+			label = "board:yellow:free_use2";
+			linux,default-trigger = "none";
+			type = <PCA9532_TYPE_LED>;
+		};
+
+		led3 {
+			label = "board:yellow:free_use3";
+			linux,default-trigger = "none";
+			type = <PCA9532_TYPE_LED>;
+		};
+
+		led4 {
+			label = "board:green:free_use4";
+			linux,default-trigger = "none";
+			type = <PCA9532_TYPE_LED>;
+		};
+	};
+};
+
-- 
2.25.1

