Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C93722A21
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjFEPBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjFEPBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:01:35 -0400
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9046FF;
        Mon,  5 Jun 2023 08:01:33 -0700 (PDT)
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id C5E5041D13A7;
        Mon,  5 Jun 2023 16:01:31 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Mon, 05 Jun 2023 16:01:31 +0100
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Liviu Dudau <liviu@dudau.co.uk>
Subject: [PATCH v3 1/2] mips: dts: ralink: Add support for TP-Link HC220 G5 v1 board
Date:   Mon,  5 Jun 2023 16:01:13 +0100
Message-Id: <20230605150114.601102-2-liviu@dudau.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605150114.601102-1-liviu@dudau.co.uk>
References: <20230605150114.601102-1-liviu@dudau.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This WiFi AP is based on a MT7621 SoC with 128MiB RAM, 128MiB NAND,
a MT7603 2.4GHz WiFi and a MT7613 5GHz WiFi chips integrated on the board,
connected to the main SoC over PCIe.

The device uses NMBM over NAND, which is not currently supported in the
mainline, so NAND node is skipped in this revision.

Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
---
 arch/mips/boot/dts/ralink/Makefile            |  3 +-
 .../dts/ralink/mt7621-tplink-hc220-g5-v1.dts  | 92 +++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts

diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
index 11732b8c8163a..d27d7e8c700fe 100644
--- a/arch/mips/boot/dts/ralink/Makefile
+++ b/arch/mips/boot/dts/ralink/Makefile
@@ -8,6 +8,7 @@ dtb-$(CONFIG_DTB_VOCORE2)	+= vocore2.dtb
 
 dtb-$(CONFIG_SOC_MT7621) += \
 	mt7621-gnubee-gb-pc1.dtb \
-	mt7621-gnubee-gb-pc2.dtb
+	mt7621-gnubee-gb-pc2.dtb \
+	mt7621-tplink-hc220-g5-v1.dtb
 
 obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
new file mode 100644
index 0000000000000..859aaa1c1bc2b
--- /dev/null
+++ b/arch/mips/boot/dts/ralink/mt7621-tplink-hc220-g5-v1.dts
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/dts-v1/;
+
+#include "mt7621.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	compatible = "tplink,hc220-g5-v1", "mediatek,mt7621-soc";
+	model = "TP-Link HC220 G5 v1";
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "earlycon console=ttyS0,115200";
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-reset {
+			label = "reset";
+			gpios = <&gpio 8 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_RESTART>;
+		};
+
+		key-wps {
+			label = "wps";
+			gpios = <&gpio 16 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_WPS_BUTTON>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		red {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_FAULT;
+			gpios = <&gpio 13 GPIO_ACTIVE_HIGH>;
+		};
+
+		green {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_POWER;
+			gpios = <&gpio 14 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+		};
+
+		blue {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_WPS;
+			gpios = <&gpio 15 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&pcie {
+	status = "okay";
+
+	pcie@0,0 {
+		compatible = "mediatek,mt76";
+	};
+
+	pcie@1,0 {
+		compatible = "mediatek,mt76";
+	};
+};
+
+&switch0 {
+	ports {
+		port@0 {
+			status = "okay";
+			label = "lan2";
+		};
+
+		port@1 {
+			status = "okay";
+			label = "lan1";
+		};
+
+		port@2 {
+			status = "okay";
+			label = "wan";
+		};
+	};
+};
-- 
2.40.1

