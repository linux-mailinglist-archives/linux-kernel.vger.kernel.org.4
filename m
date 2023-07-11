Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2248474FACB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbjGKWP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjGKWP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:15:26 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E959110EF;
        Tue, 11 Jul 2023 15:15:24 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1qJLdg-0074mC-7o; Tue, 11 Jul 2023 22:15:20 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm64: dts: imx8mp: add imx8mp-venice-gw74xx-imx219 overlay for rpi v2 camera
Date:   Tue, 11 Jul 2023 15:15:18 -0700
Message-Id: <20230711221518.2127861-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the RaspberryPi Camera v2 which is an IMX219 8MP module:
 - https://datasheets.raspberrypi.com/camera/camera-v2-schematics.pdf
 - has its own on-board 24MHz osc so no clock required from baseboard
 - pin 11 enables 1.8V and 2.8V LDO which is connected to
   GW74xx MIPI_GPIO4 (IMX8MP GPIO1_IO4) so we use this as a gpio

Support is added via a device-tree overlay.

The IMX219 supports RAW8/RAW10 image formats.

Example configuration:
media-ctl -l "'imx219 3-0010':0->'csis-32e40000.csi':0[1]"
media-ctl -v -V "'imx219 3-0010':0 [fmt:SRGGB8/640x480 field:none]"
media-ctl -v -V "'crossbar':0 [fmt:SRGGB8/640x480 field:none]"
media-ctl -v -V "'mxc_isi.0':0 [fmt:SRGGB8/640x480 field:none]"
v4l2-ctl --set-fmt-video=width=640,height=480,pixelformat=RGGB
v4l2-ctl --stream-mmap --stream-to=frame.raw --stream-count=1
convert -size 640x480 -depth 8 gray:frame.raw frame.png
gst-launch-1.0 v4l2src ! \
  video/x-bayer,format=rggb,width=640,height=480,framerate=10/1 ! \
  bayer2rgb ! fbdevsink

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm64/boot/dts/freescale/Makefile        |  2 +
 .../imx8mp-venice-gw74xx-imx219.dtso          | 80 +++++++++++++++++++
 2 files changed, 82 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 60a69e114442..9dc3c1be1899 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -156,6 +156,7 @@ imx8mm-venice-gw73xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice
 imx8mm-venice-gw73xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-rs232-rts.dtbo
 imx8mm-venice-gw73xx-0x-rs422-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-rs422.dtbo
 imx8mm-venice-gw73xx-0x-rs485-dtbs	:= imx8mm-venice-gw73xx-0x.dtb imx8mm-venice-gw73xx-0x-rs485.dtbo
+imx8mp-venice-gw74xx-imx219-dtbs	:= imx8mp-venice-gw74xx.dtb imx8mp-venice-gw74xx-imx219.dtbo
 imx8mp-venice-gw74xx-rpidsi-dtbs	:= imx8mp-venice-gw74xx.dtb imx8mp-venice-gw74xx-rpidsi.dtbo
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw72xx-0x-imx219.dtb
@@ -168,6 +169,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rpidsi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs232-rts.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs422.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-venice-gw73xx-0x-rs485.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx-imx219.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx-rpidsi.dtb
 
 dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso
new file mode 100644
index 000000000000..270a9114da97
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx-imx219.dtso
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2023 Gateworks Corporation
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "imx8mp-pinfunc.h"
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	compatible = "gw,imx8mp-gw74xx", "fsl,imx8mp";
+
+	reg_cam: regulator-cam {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_cam>;
+		compatible = "regulator-fixed";
+		regulator-name = "reg_cam";
+		gpio = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	cam24m: cam24m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "cam24m";
+	};
+};
+
+&i2c4 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	imx219: sensor@10 {
+		compatible = "sony,imx219";
+		reg = <0x10>;
+		clocks = <&cam24m>;
+		VDIG-supply = <&reg_cam>;
+
+		port {
+			/* MIPI CSI-2 bus endpoint */
+			imx219_to_mipi_csi2: endpoint {
+				remote-endpoint = <&mipi_csi_0_in>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+				link-frequencies = /bits/ 64 <456000000>;
+			};
+		};
+	};
+};
+
+&isi_0 {
+	status = "okay";
+};
+
+&mipi_csi_0 {
+	status = "okay";
+
+	ports {
+		port@0 {
+			mipi_csi_0_in: endpoint {
+				remote-endpoint = <&imx219_to_mipi_csi2>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
+&iomuxc {
+	pinctrl_reg_cam: regcamgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_GPIO1_IO04__GPIO1_IO04	0x41
+		>;
+	};
+};
-- 
2.25.1

