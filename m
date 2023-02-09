Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC0868FD8D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjBIC7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjBIC6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:58:25 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2100.outbound.protection.outlook.com [40.107.220.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509CB5B80;
        Wed,  8 Feb 2023 18:55:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bttoFjFjs8of+S7JLLJ9GB60sOJ2zbqBjZocd7eKtNyVYP0biCmbZpkP4cKOjlXVj/u+hgiGMzuCWwSLP+5oI+7T/HRbyS8TN6CrfGTTDJu55eyNKoKNWgAio+/YyiXGbpo4faGtbT576PujD1kyDuLu3BA8z4w1Xi6KT3DHyrBLlNd4GtJRBVcBDXhPc7jSmdCVSvXKkPnK+EYlUzO2hHfPUsk7XQxFI/rL6V2+1+Ph9M9b/Bm4heh+qxPNWX3gHDCwVIFq15/Sz/B2emLc4oE7PAW4rhsj7Up+zO6cOCOYyCL+TWXQTG1VUXuN/vwZg7LkVbGVJqO6RTQvztBNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3d3zEUaq76Xf+AaFo2h+ILuKAU+8A8HgVMCUkdHlzM=;
 b=od9XuxDFbk5dKxMx3WYI7auXVHOkbpbdctjF/DaibVF0HB8054oH/naH2PXTWzxSjDiAW/Yq8AoULTGiltK9HDE7STk/Z6LwK9q37ti41C1R9tAUL8U5B8aXU6Q6zAo0AcT0cx1LPja4XrCOvoIWTzdBv/i4VB5+ke6nvD9d4VQ2i+cuHHoVYUKYMRWMw9AhOsN+2grUQ5qIspILk3vDmUhSHU9OUngtzYTm0rmyFqqA9ENg6v8vzZ8JQuJcAnTmGWkzrKDEskKvtFXUiOi+X4f7lNN3UX7jpmZniHUWHVC1eaveQD+pqKwS9bq2ci0kmb+4apPAM5gf4VVo06xZYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3d3zEUaq76Xf+AaFo2h+ILuKAU+8A8HgVMCUkdHlzM=;
 b=Tl/wQwAQM4xvjmNxW0QsIcM2Y05CIfux/3sRsQzRIDlHJYLgGb2zDxpwX+movl7jhuv8+QvpCDXh6a7+Wmk2UjW7PlIfWaaYGIE6sL+GCw34hC9QMEeE32RgcjqtvdBp+MyYVG1V3bIag2al/r5LoVT20+sgIGpCZV92jQF2EBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by CH2PR10MB4391.namprd10.prod.outlook.com
 (2603:10b6:610:7d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 02:55:43 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa%4]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 02:55:43 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 2/2] arm: dts: omap4: pcm959: add initial support for phytec pcm959
Date:   Wed,  8 Feb 2023 18:55:25 -0800
Message-Id: <20230209025525.148872-3-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230209025525.148872-1-colin.foster@in-advantage.com>
References: <20230209025525.148872-1-colin.foster@in-advantage.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:a03:338::11) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|CH2PR10MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b57e81a-7ab8-4f13-b686-08db0a49225a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Vk3SCsCnz6uQ+TvzgmAX/90nWXSrTUXlfXZXqlHvtAJhov57XtWc7cpxAcbGCOAKrpKCAbiSDWIfY6a8AXC+ZcreKdK9MHptn6kYCRK/hMuon08ivg4MuAPUCwlC2c0cPz4Lnhak11knYE9CGJ3VoDA7pt4PzST4jBbZzTmVSdP6Jr1d3llTrZh3crD4bXyY5543e0MfRp8F/PNdbAnwI5uA4xtziQ11UUDhDNygeI57//Qnn24Mp0HLG/EW7dBdaA16AuwcIHcn1Z5uczEZqfyUw8gtFHaivxZvth/FeYq2hjMFK1qWq5/YlFjvqq8dzcXD6k6iookKqSHa1RAtoS8Ewkrk2sYBY55oeRhY7lPduQEiTpnv4I0hcnHqIldNzzm5YPDqtTf0e7T8wh1NxJ2T5wXSgy6F2ocqPQtzF+dCSYUzYd08mC5f7PFoUzC3huAD4tNqw4zk6Is5QNeiZySXdACdLK9K0+dDqeuWg+bDQ1Tyf5FDd6TQQGc6f0NwEchyCDFsGu1z+8vhrky9kfAWIrLDYHsGBZSEtsMpVIeEhVR+wBuOfXXsJH8pi0wRFQULDrnZxc4hunvajxS3YOF1IVt9XMNRBMgfuNW1RcF9/SjszQ4PAQWGeQwtB556pbGvUTfexdZttsMM3/NAK3J5zUWKtnuuA641+n6XuGklqwv2mOTEGwmOMtTw0bxxlH2Efvy5jZ6nkGLTEDOIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39830400003)(396003)(346002)(376002)(136003)(451199018)(4326008)(8676002)(66946007)(66556008)(66476007)(41300700001)(38100700002)(38350700002)(2616005)(316002)(186003)(26005)(2906002)(8936002)(1076003)(6506007)(6512007)(6666004)(86362001)(478600001)(6486002)(5660300002)(52116002)(54906003)(83380400001)(30864003)(7416002)(44832011)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RBrwha+vhI+sVahB1k38mb/eu/IisL6FRk0QNsATetVrSBPYmtmpA81nbsAx?=
 =?us-ascii?Q?RujjoNY0OAJ9FISnOz088DK+JxtqOatlfA5erHwKQUbk6BXzVsSkIyMQi/0t?=
 =?us-ascii?Q?4f0KckwIJpKiCP+mfqpz2yYRz2AMo8QU/4dN9wThR+oKF+WOnNS8wtQ+R5Ft?=
 =?us-ascii?Q?XIMTEDMLcAlyK9nndm+FYwIEyAOtixl6dY5kpY+FzPG/1iv5jRRA4Cgk+L1b?=
 =?us-ascii?Q?6uBramLs4CtsQHS1JKbkyvObhrN4Csl6HsxNPvcJDmo1kVmSfpuR2PZkvCiW?=
 =?us-ascii?Q?CgArvpWIev9mMNd4gOGlQ7r/813hIq0SL0I4g6AGLWCnfwcZlnZJ/QtAYMDZ?=
 =?us-ascii?Q?luPoL+bp5xAU3yQjCioPtwABH1TIsCPKlw9uv78Dx8oeUCvvM50BP0PKIsJv?=
 =?us-ascii?Q?9KGK99Vzmcz/9sWyl/QJKcS5UczlhdIVyR/UOrGRQZZnHc1XYeV5lnf2hLzI?=
 =?us-ascii?Q?GOvp9hsPn5ZcvDUtYgpmuhZAhWJwGxcf7LSQGikGvYSrveKjqgEeUFJQFcvT?=
 =?us-ascii?Q?qutNsx8/n+fTBAwJcVRQEX4Ic6wm74B8TAONHE4pkBoz50hTKPkOD3bXGcsp?=
 =?us-ascii?Q?8Wfp6cu5Oytjg9Kw5RAxU6hNe2lFnC8FxPsNehDJVJiAVXr/X3GAYa705mSb?=
 =?us-ascii?Q?kuP2OOqRpamNz1Dve0g1KJOl/CYxvfWgKCpxZekVSH85rdrtn6Bq6/WzJLHu?=
 =?us-ascii?Q?7Hx2sSr4mTkOgajflo54KjS2pxhr0HC7XH1hBbpYTIFbo4Aw5BroSow7z30J?=
 =?us-ascii?Q?rY/IzVeNU//JEMZcnaT2PDqWhlp4M35/4pQlP7/vliPzSYXQmKybL39V9xV6?=
 =?us-ascii?Q?zZgMrEfE9pTdSrlUYqSkHuN0cYP7lC1HYNK8XbRfrCpNyqTMUeA8X/S9Co93?=
 =?us-ascii?Q?O/ioV+vOk67sQKwWzljuByUr4j2JfKwNT6fNT+Ll7xvpuj9iAGaqDSDHJDUg?=
 =?us-ascii?Q?lfy4NQvCQufm/d42Xz44SJJmtcpmRQUPvgHWNMs3gThm57wXlkDCm+N7Zqyb?=
 =?us-ascii?Q?Hf1YQNl39ygY1epC30vRtBqHzmdinnSfXaT7C/jrnoe+LkXibw2+zjVzMqyf?=
 =?us-ascii?Q?GiFL8n1EoPipeusD17iD8BV3Btu8W6jf9W67hzn1d4ktFn8qt7aSEoOhIV3g?=
 =?us-ascii?Q?QmmZhVBQ7TKWKkbYVY7Fok5v3IOeA7wkFQ7NuSsTsHDplrvNTrXXRsWEBEFw?=
 =?us-ascii?Q?FwNdmBriykzWJYC+WzrAMnMxm9gW3e8yGrYHQ4Oa+u6ThyfVV+ErfXOvUATa?=
 =?us-ascii?Q?VqTCNuI+i6dXE4WHGj7IohLW3hm2VM4xPdE4TfNJ2eACsMR2BD8GguCkQ/zP?=
 =?us-ascii?Q?doTWRrzyJmjVhlmbq4q6sJuutLwbaK9v0QdWCa6AGodK2LH0k1ksu/cjK5yM?=
 =?us-ascii?Q?8DFf4q2DzHiZZ7BxcP6Z+H78rizgFi/JigluIj6MJBkjE7Oc2AaWMMs23wjO?=
 =?us-ascii?Q?yI7tX6UYUNFZ7SDnJIXrY9NU3Kqk/1rIFLjbrn3zLPlL1gkZlG8VmzYyBzvm?=
 =?us-ascii?Q?QKRp0f2Dor5Pr90mOqDnmTHu4xAARmMLZDzcq9+OFvUaF0TSoMf/HqNGGsVZ?=
 =?us-ascii?Q?xoSgYcTeugVOzIetM0ggGzrFxIqMMDjGIJNmvu+WE0vz3NJTNzD1MpYdBdfI?=
 =?us-ascii?Q?rMHyvIPcC5cbh6gXIxpSbUI=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b57e81a-7ab8-4f13-b686-08db0a49225a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 02:55:43.0817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFehgpiODG7BrcnL+o9APFNHVdQfeOtSKrwBcxD5KGCjBqrk2v5mTPLekV41exWtV8aHYqIBviMHK1KE4T8G6yVGgeAKF9fmnBfp5xPkZdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4391
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

v2->v3
Code review changes:
    * Remove unnecessary "okay" statuses
    * Utilize gpio funciton / color instead of label
    * Clean up pinctrl whitespace
    * Change label of TWL6030 to "pmic"
    * Clean up general whitespace
Behavioral changes:
    * Utilize "gpmc-wait" instead of "rb-gpios". The initial
      configuration would suffer about a 1/100K NAND access
      failure, snowballing into corrupted NAND after enough
      boot cycles / downloads. This one was fun to figure out!
    * Adjustments to gpmc-nand timings from testing.

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
 arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi | 400 ++++++++++++++++++++
 arch/arm/boot/dts/omap4-phytec-pcm-959.dts  |  48 +++
 3 files changed, 449 insertions(+)
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
index 000000000000..3cc029599224
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-phytec-pcm-049.dtsi
@@ -0,0 +1,400 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Innovative Advantage, Inc.
+ */
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
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
+		};
+
+		ipu_memory_region: ipu-memory@98800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x98800000 0x7000000>;
+			reusable;
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
+		pinctrl-0 = <&led_gpio_pins>;
+
+		led-0 {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio5 0x18 GPIO_ACTIVE_HIGH>; /* GPIO 152 */
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-1 {
+			function = LED_FUNCTION_DISK;
+			color = <LED_COLOR_ID_GREEN>;
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
+	pinctrl-0 = <&tps62361_pins>;
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
+	pinctrl-0= <&smartreflex_i2c_pins &fref_xtal_in_pins
+		    &fref_clk3_out_pins &sys_pins>;
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
+	twl: pmic@48 {
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
+	pinctrl-0 = <&gpmc_pins>;
+	status = "okay";
+
+	nandflash: nand@0,0 {
+		compatible = "ti,omap2-nand";
+		reg = <0 0 4>;
+		interrupt-parent = <&gpmc>;
+
+		nand-bus-width = <16>;
+		ti,nand-ecc-opt = "bch8";
+		ti,elm-id=<&elm>;
+		linux,mtd-name = "micron,nand";
+		gpmc,device-nand = "true";
+		gpmc,device-width = <1>;
+
+		gpmc,cs-rd-off-ns = <40>;
+		gpmc,cs-wr-off-ns = <40>;
+		gpmc,adv-rd-off-ns = <25>;
+		gpmc,adv-wr-off-ns = <40>;
+		gpmc,oe-off-ns = <50>;
+		gpmc,we-off-ns = <30>;
+		gpmc,rd-cycle-ns = <75>;
+		gpmc,wr-cycle-ns = <75>;
+		gpmc,access-ns = <55>;
+		gpmc,wr-access-ns = <55>;
+		gpmc,wait-pin = <0>;
+		gpmc,wait-on-write = "true";
+		gpmc,wait-on-read = "true";
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	ethernet@gpmc {
+		reg = <5 0 0xff>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ethernet_pins &ethernet_wkgpio_pins>;
+
+		/* Either GPIO 103 or GPIO 121. Use 121 to match the reference design */
+		interrupt-parent = <&gpio4>;
+		interrupts = <25 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
diff --git a/arch/arm/boot/dts/omap4-phytec-pcm-959.dts b/arch/arm/boot/dts/omap4-phytec-pcm-959.dts
new file mode 100644
index 000000000000..03196e657161
--- /dev/null
+++ b/arch/arm/boot/dts/omap4-phytec-pcm-959.dts
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 Innovative Advantage, Inc.
+ */
+/dts-v1/;
+
+#include <dt-bindings/leds/common.h>
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
+			color = <LED_COLOR_ID_RED>;
+			linux,default-trigger = "none";
+			type = <PCA9532_TYPE_LED>;
+		};
+
+		led-2 {
+			color = <LED_COLOR_ID_YELLOW>;
+			linux,default-trigger = "none";
+			type = <PCA9532_TYPE_LED>;
+		};
+
+		led-3 {
+			color = <LED_COLOR_ID_YELLOW>;
+			linux,default-trigger = "none";
+			type = <PCA9532_TYPE_LED>;
+		};
+
+		led-4 {
+			color = <LED_COLOR_ID_GREEN>;
+			linux,default-trigger = "none";
+			type = <PCA9532_TYPE_LED>;
+		};
+	};
+};
-- 
2.25.1

