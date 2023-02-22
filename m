Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5C669FD1E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjBVUjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjBVUjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:39:16 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2091.outbound.protection.outlook.com [40.107.237.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C28A301A7;
        Wed, 22 Feb 2023 12:39:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLGM0WljJnYqf8g5felWQ0VrXcVCXTytE3vT+L0XVOTSqBCbXo82sdVaCHXsBcapcqIYXLXl9qSG7EiUrrv6KJJ9gH7zwliV9QfOGoNRVLaYBWT8YjQVvTgzyhBn1zl+CQhB+d9/dhttakR3pYU3Ep7FEnEwhh1jr1Aa8cuRDOPnFTyfuciao/z3gH7YdsJ6amLi9VjHeF49KHXPZNUdpgQ+QvQ0ZPcB+bwKz7iORvdyEOQOofw/9moPl/ibgvdA8L4mgH4FP6MkHnuIlVNVCeP3j70xU9DWkgAnnHTYQ96bSnwd2k69BkN3D3zp2cNsCtb974KT2HrcKzLBvHTMlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs+BLGMRJ1Q3gQVOsoSGsbvWegu/KmC6Zj39tXZ8bEY=;
 b=OsVRZxOOVKP5MJhab7AVYiGQTU/l+Wj4S1loD+KtVJXpf5qH1OOlW4YwVoVlxMdzzAibJPaFMzdqDkumBKdYLAJkE4Ia0L5cmF0PE2YW4luMQNYxXwKYC7lIAkT30fvm5cJAHNPFKtDqDJqZ9a8I06wKBZRna2yb8doln77o3B5xh9RZJkzkZ9xoQ10g5PUxhWyqikayLn6f3OhOXtn3ZbkFioUybFzXt1CwiDeftBp/RAtPabneHuYXK57IDI+V3qWvlR7I3GAKJV5c9Ag2FTNNXJPUNzHVVxzkFqG7H+qEl9/WYFBCNczHtCULusXsAQ9Io4K06xM8hnypGBmTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs+BLGMRJ1Q3gQVOsoSGsbvWegu/KmC6Zj39tXZ8bEY=;
 b=MJiQmUJ3eTgrG7yZHjuIZnBJ9Y5z2OgmvnBIaNJqCwFZhpKtN4B1RrdNaeMmaA8yEtm/p33rWefJ0I18ZJ1V4HXuYOfoW+aIurN6w2czu12AkqKA5EybCGTLVEa7Z6Tf1vBhRnfnJnWdDzNzn9KRaqX4pU6dJrAijQjYvJoTqAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by PH7PR10MB6033.namprd10.prod.outlook.com
 (2603:10b6:510:1ff::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 20:39:10 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::1897:6663:87ba:c8fa%4]) with mapi id 15.20.6111.010; Wed, 22 Feb 2023
 20:39:10 +0000
From:   Colin Foster <colin.foster@in-advantage.com>
To:     linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        soc@kernel.org, Olof Johansson <olof@lixom.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v4 2/2] arm: dts: omap4: pcm959: add initial support for phytec pcm959
Date:   Wed, 22 Feb 2023 12:38:47 -0800
Message-Id: <20230222203847.2664903-3-colin.foster@in-advantage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230222203847.2664903-1-colin.foster@in-advantage.com>
References: <20230222203847.2664903-1-colin.foster@in-advantage.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:a03:54::19) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2351:EE_|PH7PR10MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 46dd60cf-324f-4dfb-6aa5-08db1514d9c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OlcW3zx3svb8wUpWRIKeyiVO31/fuaA7rW3PpeOLJxmuyUpBo+9dZ6lUVAN83eENSI8TR9F/hNrzYrOIRYK/bVjSC2JaT83SRTt7RHCq1SuB/r+amazY0uYm8adVcbMevX5GOgGnYqdQYS3it8ZkPW2+gitV5zrOjV3VFpCaoDQRRM/rBUnXdsBKpNCJHI+9iTF6jU1LWM9CjV4x4EEdhswT5SwFnW+OxFs4STbTEAKC/V/WoRMR02zDLU6obd+SRZiHKAQDZr8pgbOS6XZmPhGe6Kx5xlhSonNQrwgHSDFdaYLWW0lBSDv2Ct9nnv73fUms12xEWQa2TRDisfDwJGBmSDAj8ItxvmZu2LeT7MEnaYlmXPFF/087fL65kQ2sO/Gziwr//bMSAaAe1o74I0MsU93GO3lB0dlYDyinDg+Xpz+HfY8bEisCVgUuTY8e4abGxtI4y/6N7+1OkyUjuoP12sdv9LFKl3/K1rW/9/yqnFCq3cRkvI77QI/92bt7sJpibdCcGHZp7aA+uOBpl28v0vdOgJakM3utCeyTYlWdbshYx4O8Bdj3NLdgFxdRSCGqWKbEynIZhgs6zvMlThJjih8O5aeZ5WBdJ0rvwwtvwN+KNpGTmN4qrlV8jQ8LVMNCR8YcJ2P6JVlw2zN59eOvJIhAagiRawDGk+uUcxHB+f4uEskpzMZwM4oPUJJQE39CnXlw7IIuOd01/B0Fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39830400003)(366004)(376002)(136003)(451199018)(478600001)(38100700002)(30864003)(38350700002)(86362001)(2906002)(44832011)(316002)(54906003)(41300700001)(36756003)(8936002)(7416002)(4326008)(66556008)(8676002)(66946007)(66476007)(83380400001)(5660300002)(26005)(6486002)(186003)(1076003)(6506007)(6666004)(2616005)(6512007)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R40qHR7DOJLqqB9hXBwSOZAgMwkFHV6nELQENkMBdYfob0u8v/oUglCKD4VF?=
 =?us-ascii?Q?e621Z6XK4osVO/n2Ldk5h3wTwFws/CnRiU6XShK7w4GeKrA5Za8CF9o7qK9z?=
 =?us-ascii?Q?O91UTUK1KiOmUiFf4Raml8QtZXXlNZteMIWD7XPo0PGRsWtb7m8Pbv1n7vbw?=
 =?us-ascii?Q?sw1WF62CbZqrup7ic+Nvuy+jIXne/yv3M2px1rIwpJ8tC5EVYCYP3YvXkPB/?=
 =?us-ascii?Q?GYa2yprYrFWhm2UYqYEmcARYMpBiJQsLjRUa9jg2HzCwZeKYK1hqElId8QUi?=
 =?us-ascii?Q?qtVa+4cv7rciOnSYywS31D8g1ulgmViPM9fs72Mrkpx95tyhWOKw1HeP3oIz?=
 =?us-ascii?Q?0230PhZlrPzSRGhGgkixnci+mpLmNW4FWiGvO/40eSs16r31U8ZjFterE6Cb?=
 =?us-ascii?Q?rKolJNU1K/nN2hEQ9bGP5MmhtAsXOfaRJWMpEW9UDuhg1J0iCfxK5Gf00f65?=
 =?us-ascii?Q?SeTq+gMZ9KGE5oVBGT+iq9zjPzD/j72kWBpIfvV//gDTqJkQZS2r4xq/Zu22?=
 =?us-ascii?Q?vVhcN2tomEXZc0WMEcf3XinAHnpb8kPTsGHFpVutSFBBR2K7PtNGk/Vno48+?=
 =?us-ascii?Q?VcHSKZI4tymWFwIpd6fyKvPHWJGm1wsKv9fN5DvRVFr5oOEJriHLM/V22i2s?=
 =?us-ascii?Q?G/vDFVxDQgo2y+u/C4I02J/wVaoF1rdHEaVy8lFuBf2PpNYWumle8tPg6stH?=
 =?us-ascii?Q?E6/h9GmQUz2crGgPCxLpe/1RdtPN4zcbpCc4JJbuYUD2bqEtplQCd0qLF3Tb?=
 =?us-ascii?Q?Nkb8KG6PRaiTuTaWSe2sNMR+3cl7s0OsucqnZgUC3jiyPWQaR2oZwCLKH2KV?=
 =?us-ascii?Q?Ku1FWlWvVi21HWA3Ed3I/cWqatrbFX7Tw8VB4GcStJO80jTW6cUihLhn+GE+?=
 =?us-ascii?Q?nXkpwgmY6KcKVw0u68FDhjzBOwldCf9UuEisfWjCUWZBqsSWa517hlc+7NV7?=
 =?us-ascii?Q?XHzWT/l6QeoBIAP9GuLFgDkARh1bfi/OWlT0bzRStRGwj3IKIav4ddsYS7Aw?=
 =?us-ascii?Q?S5DWyPtnGn98RvQQQqNVp7kvsMCg8cSoJNjAVjbVbrjANClhG/Fv7R/hNJp2?=
 =?us-ascii?Q?4kxnCbMAclhOCKcfYCbOqia+OKMi00ZHOzHBDGwzbGs7vc6+ogjZgFRHtw8l?=
 =?us-ascii?Q?rpVKel5JOkzeHBwX3yYo8MNsLlkuBJ7AmjyQZvwJMwaLx1MgR6pwjEUc9mLT?=
 =?us-ascii?Q?WB72Z5uW04RzKusYDtB77zrHzy86fGN7rIL5R4XIu/fD7Q5gQ15cjqrM3aHh?=
 =?us-ascii?Q?0ghhoEruv6N2lUhWk9NaKDiGMY6zeGL8OCLtuMJMMYOYN7dQBbmtA5yEXPVW?=
 =?us-ascii?Q?5bkI07lKTMHew9LuzKosU0uF3Uo45dqLndNwzU1jg4dET6hSY6zBbc6hkq7F?=
 =?us-ascii?Q?X6RG7Jo9o+usFQV/N9huEVz+XAYKpqLP+9kQuKQLWG6FqAkaKlGqE8vEuyOG?=
 =?us-ascii?Q?KkJs+74L0rBpG3p0Vu8T+IHUgRzYRBBQ+HEiCC6/ZOiJD3UTW1ITBEvkobvL?=
 =?us-ascii?Q?4++WIss/tRjcRolFk6Tf/tXsyzSDVJ9qc9lj36PM4j0CIMnwz0xC5GnXagiG?=
 =?us-ascii?Q?bCS8iC1EH3tq2y+Ha+8rOa0eLSZM/XuPIGHE+XtF4qcK8WCMYBf64podhRns?=
 =?us-ascii?Q?5/hI9lGHwTLGOSkO/4V03gk=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46dd60cf-324f-4dfb-6aa5-08db1514d9c9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 20:39:10.2160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Tdeq3eoszU65Ky+C0YBaUIsbjn6wBx4unOrblkS66xQw2P/UD7MjCudw4RAwV41u0Yyc6IM/Yje78SaOaSPVhGynRYFgny/Pn8JgzB5cIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6033
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

v3->v4
    * Remove unnecessary "omap-4430" compatible string

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
index 000000000000..e1fee183d4c9
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
+	compatible = "phytec,pcm959", "phytec,pcm049", "ti,omap4460", "ti,omap4";
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

