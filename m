Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8288F6BF90F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjCRIiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCRIiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:38:05 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCADBABB2D;
        Sat, 18 Mar 2023 01:37:53 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id m22so3329131ioy.4;
        Sat, 18 Mar 2023 01:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679128673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nW/scCTY9Dmueil8S8WFtiNyT6dE9CaUDzdfsDXcttU=;
        b=ZgF5nT6i5jtnkCi9JA6sPCKaaRzw20EfQyRs1Ce4dVYwxEHiQT8sErjJsIgm9z3lr2
         OQNrrXgYZjsd3APgMl8WEeNIuPGjLzpVwIFqAAKLIrfMWirF5hags6eVxFeOqa3cYuW4
         gx21owrwi8hULDPDRYMECTD6CYraXX3hMnZi02psbpmcv8mo73oMBlFPyjLmcsZ2RsMy
         VH1XXj1WmjzYTyo7yV5569RwzDDW97o+OM9ZsrnG74NbjVXUdshe4ekjz9mVRJkobtAB
         0RSpKJ+Y3WpyUq3Ew8ft0OyOQGef3FlZONl3FaNIWnZesvqbqqefXvYoKM9NBUY9krS2
         AfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679128673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nW/scCTY9Dmueil8S8WFtiNyT6dE9CaUDzdfsDXcttU=;
        b=xZWBl3oyEw1iVkmWlDUNSvZDqxkMXP3XSDzRJxyvyIHGriuAmp96bCB5ir6hrRpDPw
         iRJVTpm5PSjFa/etk87AQOSod99lknOZrejWGOotU8EeP2jCmF0aZODKSVzz5au1eFGY
         u6FevZAue3HFxeR0p3f7HfnFq4tRE24piyPWFc/igfSL+paftyBn5PcvG8mowXssolMF
         T0ry9gMP3ZwF9YIt1nCbAzo6/nCi7m4RgOTEybeXs1n5uItjCoI/U1NtN3QISqWaV4HZ
         +Y/ijHLTLyagFkH7R4CNb10kxt6ZrltjBIWqUSr5UcybjOsHbg7vLmtjxdFqS0F3zIYc
         Fd4w==
X-Gm-Message-State: AO0yUKVhJWS4xSiTJ3nLIBMEv1QVAFHjoLN96R0KP2sbMjyCrTM6PiEw
        QBZEkt6LwuFyZMDQk97/NI8=
X-Google-Smtp-Source: AK7set8TrXQXrZOn0kgtnZouj6F/JixV39r9b71jOeAjdyf6ZI7PXuvNHY9cSwsPyU/9rXjJMP6FMw==
X-Received: by 2002:a5e:8f43:0:b0:753:9316:76c with SMTP id x3-20020a5e8f43000000b007539316076cmr967563iop.21.1679128673213;
        Sat, 18 Mar 2023 01:37:53 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id h8-20020a6b7a08000000b00746041ecbf9sm1174834iom.39.2023.03.18.01.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 01:37:52 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Peter Geis <pgwipeout@gmail.com>, Andy Yan <andyshrk@163.com>,
        Tianling Shen <cnsztl@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] arm64: dts: rockchip: Add FriendlyARM NanoPi R5C
Date:   Sat, 18 Mar 2023 16:37:43 +0800
Message-Id: <20230318083745.6181-4-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230318083745.6181-1-cnsztl@gmail.com>
References: <20230318083745.6181-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FriendlyARM NanoPi R5C is an open-sourced mini IoT gateway device.

Specification:
- Rockchip RK3568
- 1/4GB LPDDR4X RAM
- 8/32GB eMMC
- SD card slot
- M.2 Connector
- 2x USB 3.0 Port
- 2x 2500 Base-T (PCIe, r8125)
- HDMI 2.0
- MIPI DSI/CSI
- USB Type C 5V

Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-nanopi-r5c.dts   | 112 ++++++++++++++++++
 2 files changed, 113 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index ade66d846a20..a315a8117b0f 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -84,6 +84,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-lubancat-1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-lubancat-2.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-odroid-m1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-radxa-e25.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dts b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dts
new file mode 100644
index 000000000000..f70ca9f0470a
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dts
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2022 FriendlyElec Computer Tech. Co., Ltd.
+ * (http://www.friendlyelec.com)
+ *
+ * Copyright (c) 2023 Tianling Shen <cnsztl@gmail.com>
+ */
+
+/dts-v1/;
+#include "rk3568-nanopi-r5s.dtsi"
+
+/ {
+	model = "FriendlyElec NanoPi R5C";
+	compatible = "friendlyarm,nanopi-r5c", "rockchip,rk3568";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&reset_button_pin>;
+
+		button-reset {
+			debounce-interval = <50>;
+			gpios = <&gpio0 RK_PB7 GPIO_ACTIVE_LOW>;
+			label = "reset";
+			linux,code = <KEY_RESTART>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&lan_led_pin>, <&power_led_pin>, <&wan_led_pin>, <&wlan_led_pin>;
+
+		led-lan {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_LAN;
+			gpios = <&gpio3 RK_PA3 GPIO_ACTIVE_HIGH>;
+		};
+
+		power_led: led-power {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_POWER;
+			linux,default-trigger = "heartbeat";
+			gpios = <&gpio3 RK_PA2 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-wan {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WAN;
+			gpios = <&gpio3 RK_PA4 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-wlan {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_WLAN;
+			gpios = <&gpio3 RK_PA5 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&pcie2x1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie20_reset_pin>;
+	reset-gpios = <&gpio3 RK_PC1 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&pcie3x1 {
+	num-lanes = <1>;
+	reset-gpios = <&gpio0 RK_PA0 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+	status = "okay";
+};
+
+&pcie3x2 {
+	num-lanes = <1>;
+	reset-gpios = <&gpio0 RK_PB6 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_pcie>;
+	status = "okay";
+};
+
+&pinctrl {
+	gpio-leds {
+		lan_led_pin: lan-led-pin {
+			rockchip,pins = <3 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		power_led_pin: power-led-pin {
+			rockchip,pins = <3 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wan_led_pin: wan-led-pin {
+			rockchip,pins = <3 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wlan_led_pin: wlan-led-pin {
+			rockchip,pins = <3 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pcie {
+		pcie20_reset_pin: pcie20-reset-pin {
+			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	rockchip-key {
+		reset_button_pin: reset-button-pin {
+			rockchip,pins = <4 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
-- 
2.40.0

