Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B475E8DEC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbiIXP3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 11:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiIXP2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 11:28:42 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F19AE9C4;
        Sat, 24 Sep 2022 08:28:40 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E06001C0005;
        Sat, 24 Sep 2022 15:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1664033319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PcAx96hQWyvOVHMIzU0gp4tFx7K/DUMSyJG/y50Qklo=;
        b=IUaxIX/5E5mDE7r8ZfueH/z48LI4wd6j9GtXLSy0QAOg0+JpssLhrfAhF77VDkRn4k1IRI
        fmnNXvyk7w1YWHNQq4DHZiDToDzda4pSThPfKrqnhGd6sM8uvSuPYM+K6KS9DqPjvKk3sV
        91tvO5vLfYjKRo+0aH3H2iT1/aVbUgHHdPpRiUUOQ5K5BEXuyO+bzG/DRVxIp9VOD+LpDj
        Q6c5Pduq/kUd1U0UVUoP6ZNAR6X3c4DcMrEIO2WnxW9GQ6jcqHYDSD9lQhDxOi2uGMTvKY
        dHBCwlrEvtZC2s0EN4AdM4i+qjYfU6m48nSF1v1YKGewu7TzRfNd5Z6a9ukXTw==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v6 7/7] ARM: dts: sun8i-a83t: Add BananaPi M3 OV8865 camera overlay
Date:   Sat, 24 Sep 2022 17:28:20 +0200
Message-Id: <20220924152820.77149-8-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220924152820.77149-1-paul.kocialkowski@bootlin.com>
References: <20220924152820.77149-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an overlay supporting the OV8865 from the BananaPi Camera v3
peripheral board. The board has two sensors (OV5640 and OV8865)
which cannot be supported in parallel as they share the same reset
pin and the kernel currently has no support for this case.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../sun8i-a83t-bananapi-m3-camera-ov8865.dts  | 109 ++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-a83t-bananapi-m3-camera-ov8865.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 1f1173efeb14..cf0ab67b430b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1340,6 +1340,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-a83t-allwinner-h8homlet-v2.dtb \
 	sun8i-a83t-bananapi-m3.dtb \
 	sun8i-a83t-bananapi-m3-camera-ov5640.dtbo \
+	sun8i-a83t-bananapi-m3-camera-ov8865.dtbo \
 	sun8i-a83t-cubietruck-plus.dtb \
 	sun8i-a83t-tbs-a711.dtb \
 	sun8i-h2-plus-bananapi-m2-zero.dtb \
diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3-camera-ov8865.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3-camera-ov8865.dts
new file mode 100644
index 000000000000..0656ee8d4bfe
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3-camera-ov8865.dts
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0 OR X11
+/*
+ * Copyright 2022 Bootlin
+ * Author: Kévin L'hôpital <kevin.lhopital@bootlin.com>
+ * Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/clock/sun8i-a83t-ccu.h>
+#include <dt-bindings/gpio/gpio.h>
+
+&{/} {
+	/*
+	 * These regulators actually have DLDO4 tied to their EN pin, which is
+	 * described as input supply here for lack of a better representation.
+	 * Their actual supply is PS, which is always-on.
+	 */
+
+	ov8865_avdd: ov8865-avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "ov8865-avdd";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&reg_dldo4>;
+	};
+
+	ov8865_dovdd: ov8865-dovdd {
+		compatible = "regulator-fixed";
+		regulator-name = "ov8865-dovdd";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		vin-supply = <&reg_dldo4>;
+	};
+
+	ov8865_dvdd: ov8865-dvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "ov8865-dvdd";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&reg_dldo4>;
+	};
+};
+
+&ccu {
+	assigned-clocks = <&ccu CLK_CSI_MCLK>;
+	assigned-clock-parents = <&osc24M>;
+	assigned-clock-rates = <24000000>;
+};
+
+&csi {
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pe_pins>;
+	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ov8865: camera@36 {
+		compatible = "ovti,ov8865";
+		reg = <0x36>;
+
+		clocks = <&ccu CLK_CSI_MCLK>;
+		assigned-clocks = <&ccu CLK_CSI_MCLK>;
+		assigned-clock-parents = <&osc24M>;
+		assigned-clock-rates = <24000000>;
+
+		avdd-supply = <&ov8865_avdd>;
+		dovdd-supply = <&ov8865_dovdd>;
+		dvdd-supply = <&ov8865_dvdd>;
+
+		powerdown-gpios = <&pio 4 17 GPIO_ACTIVE_LOW>; /* PE17 */
+		reset-gpios = <&pio 4 16 GPIO_ACTIVE_LOW>; /* PE16 */
+
+		port {
+			ov8865_out_mipi_csi2: endpoint {
+				remote-endpoint = <&mipi_csi2_in_ov8865>;
+				link-frequencies = /bits/ 64 <360000000>;
+				data-lanes = <1 2 3 4>;
+			};
+		};
+	};
+};
+
+&mipi_csi2 {
+	status = "okay";
+};
+
+&mipi_csi2_in {
+	mipi_csi2_in_ov8865: endpoint {
+		remote-endpoint = <&ov8865_out_mipi_csi2>;
+		data-lanes = <1 2 3 4>;
+	};
+};
+
+&pio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&csi_mclk_pin>;
+};
+
+&reg_dldo4 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+};
-- 
2.37.3

