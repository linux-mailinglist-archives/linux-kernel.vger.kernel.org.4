Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA93E6BB8FE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjCOQDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCOQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:03:30 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F3D7DFB9;
        Wed, 15 Mar 2023 09:02:58 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id r4so10618711ila.2;
        Wed, 15 Mar 2023 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678896176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFzqFZRMZgGQdmFzxV9ulZZAbwZchm//ia0DXnJhhKw=;
        b=ncRmZFHUwrkXVVHHCGFYzwNyo5iHMljChv9O+6aMRxW3ZhxGZjAGztuRedOdHkEOaR
         5mKYS/mHqJUYQdlqT3c2hBzKiuInrVH0NWBCwVXQtzE0uMv1m0slEl/z14v55rOo6OXJ
         A1a4O9qmgiJnipBkHRhCp4jl3jJ7ip37ebh7F4ZMHlIwkHWDAiGqvVAA2yu1BhkeTsLl
         OwvuhnE+oYvQSUFQuOW8Ux+eulnpqoslMqLi+o8UwAMfLK7pY/GYoB1QAA0q3yYxjdbr
         kf3W9x5i6F9pQ1mnwMGwQfepoBZDls/wIxioKISVaaOHN4XGGWnCcSO0L9SVtf1XOYKn
         pbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFzqFZRMZgGQdmFzxV9ulZZAbwZchm//ia0DXnJhhKw=;
        b=QY2XSWyoSyQnnbsV1M4uydnEyT/Cde03/4PCmS1l7P+iWkLN2n78do+lwG5XoCa4SJ
         VXGMKpG4hb65ytjBUPhQj2GLPev8McjVW/GCVU+a7A8YP1miFctDb08rovxAUyAS3pKw
         7SroHe7mgYquMnZw1bAdPA5cjyxgrGlZBUQungGy3xj+nkduQe+XGHY7rwA7g2VJJ9Xr
         JD61xRzm0+TYHTomiwXpLJK9iOP+rEaJYdDxMYwhU/YVo+yPLJ443QbtHlS6RlFrdrWr
         hPVS/TUwb1heZvCpeK9o6gKv3B16SgvYJDc3TGCI5dON5cmIJ1D8uP7QEk0snPmeFCeG
         ZQ3A==
X-Gm-Message-State: AO0yUKV0YPSqbTZ0CtMKHIe0maw36yRC81V93s1X2GqrDR8tOk6yRnQq
        BT1VnYNKs23fWB9TFH9ZUUs=
X-Google-Smtp-Source: AK7set+QYCuqCM8GoBYnVx8BMDvR95or95rrZy5638dGLI13hPlwpxUyIrQeWAMDcM0TsiBkp9mR2Q==
X-Received: by 2002:a92:dd88:0:b0:318:a732:2b6f with SMTP id g8-20020a92dd88000000b00318a7322b6fmr4930587iln.20.1678896176540;
        Wed, 15 Mar 2023 09:02:56 -0700 (PDT)
Received: from localhost.localdomain (tunnel785484-pt.tunnel.tserv9.chi1.ipv6.he.net. [2001:470:1f10:aed::2])
        by smtp.googlemail.com with ESMTPSA id l2-20020a92d942000000b00313fa733bcasm1730725ilq.25.2023.03.15.09.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:02:56 -0700 (PDT)
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
Subject: [PATCH 3/5] arm64: dts: rockchip: Add FriendlyElec NanoPi R5C
Date:   Thu, 16 Mar 2023 00:02:26 +0800
Message-Id: <20230315160228.2362-4-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230315160228.2362-1-cnsztl@gmail.com>
References: <20230315160228.2362-1-cnsztl@gmail.com>
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

FriendlyElec NanoPi R5C is an open-sourced mini IoT gateway device.

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
index 000000000000..26b391910464
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-nanopi-r5c.dts
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2022 FriendlyElec Computer Tech. Co., Ltd.
+ * (http://www.friendlyelec.com)
+ *
+ * Copyright (c) 2023 Tianling Shen <cnsztl@immortalwrt.org>
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
2.17.1

