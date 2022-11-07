Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7ABF61F0CD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiKGKfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiKGKeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:34:31 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 55A1A193E9;
        Mon,  7 Nov 2022 02:34:17 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Nov 2022 19:34:16 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id BD28A20584CE;
        Mon,  7 Nov 2022 19:34:16 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 7 Nov 2022 19:34:16 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 2AE7AB62A4;
        Mon,  7 Nov 2022 19:34:16 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2 3/5] ARM: dts: uniphier: Add Pro5 board support
Date:   Mon,  7 Nov 2022 19:34:08 +0900
Message-Id: <20221107103410.3443-4-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107103410.3443-1-hayashi.kunihiko@socionext.com>
References: <20221107103410.3443-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial version of devicetree sources for Pro5 EPCORE and ProEX boards.

Pro5 EPCORE board is a kind of Pro5 reference board with PCIe endpoint
card edge connector.

ProEX board also has PCIe endpoint card edge, and some peripherals are
shared with other system and can't be used in Linux.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/Makefile                 |  2 +
 arch/arm/boot/dts/uniphier-pro5-epcore.dts | 76 ++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-pro5-proex.dts  | 59 +++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 arch/arm/boot/dts/uniphier-pro5-epcore.dts
 create mode 100644 arch/arm/boot/dts/uniphier-pro5-proex.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 13ceb456e00f..474eba34ea7a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1456,6 +1456,8 @@ dtb-$(CONFIG_ARCH_UNIPHIER) += \
 	uniphier-pro4-ace.dtb \
 	uniphier-pro4-ref.dtb \
 	uniphier-pro4-sanji.dtb \
+	uniphier-pro5-epcore.dtb \
+	uniphier-pro5-proex.dtb \
 	uniphier-pxs2-gentil.dtb \
 	uniphier-pxs2-vodka.dtb \
 	uniphier-sld8-ref.dtb
diff --git a/arch/arm/boot/dts/uniphier-pro5-epcore.dts b/arch/arm/boot/dts/uniphier-pro5-epcore.dts
new file mode 100644
index 000000000000..ed759dcc3216
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-pro5-epcore.dts
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Source for UniPhier Pro5 EP-CORE Board (Pro5-PCIe_EP-CORE)
+ *
+ * Copyright (C) 2021 Socionext Inc.
+ *   Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+ */
+
+/dts-v1/;
+#include "uniphier-pro5.dtsi"
+#include "uniphier-support-card.dtsi"
+
+/ {
+	model = "UniPhier Pro5 EP-CORE Board";
+	compatible = "socionext,uniphier-pro5-epcore", "socionext,uniphier-pro5";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	aliases {
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		i2c0 = &i2c0;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+};
+
+&ethsc {
+	interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&serialsc {
+	interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&serial1 {
+	status = "okay";
+};
+
+&serial2 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+};
+
+&sd {
+	status = "okay";
+};
+
+&pcie_ep {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-pro5-proex.dts b/arch/arm/boot/dts/uniphier-pro5-proex.dts
new file mode 100644
index 000000000000..2cfb84f73cc0
--- /dev/null
+++ b/arch/arm/boot/dts/uniphier-pro5-proex.dts
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Device Tree Source for UniPhier Pro5 ProEX Board
+ *
+ * Copyright (C) 2021 Socionext Inc.
+ *   Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
+ */
+
+/dts-v1/;
+#include "uniphier-pro5.dtsi"
+
+/ {
+	model = "UniPhier Pro5 ProEX Board";
+	compatible = "socionext,uniphier-pro5-proex", "socionext,uniphier-pro5";
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	aliases {
+		serial1 = &serial1;
+		serial2 = &serial2;
+		i2c0 = &i2c0;
+		i2c1 = &i2c3;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x40000000>;
+	};
+};
+
+&serial1 {
+	status = "okay";
+};
+
+&serial2 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
+&emmc {
+	status = "okay";
+};
+
+&pcie_ep {
+	status = "okay";
+};
-- 
2.25.1

