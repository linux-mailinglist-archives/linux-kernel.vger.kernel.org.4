Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E9763FB30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiLAW6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiLAW5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:57:42 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E455DF23;
        Thu,  1 Dec 2022 14:57:40 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id E67A95FD14;
        Fri,  2 Dec 2022 01:57:38 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669935458;
        bh=bNlxstNU84ePp/QGlEFa5UnW4sFn/xynzmg1ch/OV9o=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Sysgntah8htYD/a6IF0x+iJffTAI+E6jOLImsQ4Xrpx5M0b9EaXeTXwtZbQ6dkWzD
         QPxSd65Ud6OAkCKM2M4S3VrxholSmDn7ffdGXgtEyO6rykXQ9QcyVS7LGby4rqr6jX
         tzYBqaH/YKuCZ1+YvbiofaO2xk+DqorAkAbboiXTyhhYJQ90rCuiJDkA1HGzgkYggz
         5JZHwubT9Df6wa2HuCZH02LIMs9KshbOOAxTzwuFCQ946SeFZ1jwmVRv0b8rwjnz5y
         Vk58FSrd/Ru/NEtuSPmyg000uGzKPWeBLoGZXg1HOAFpAiE/rNCizH99TtLSr7Vp7p
         nfs3vVR8iJmZg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Dec 2022 01:57:38 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <jian.hu@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v8 11/11] arm64: dts: meson: a1: introduce PLL and Peripherals clk controllers
Date:   Fri, 2 Dec 2022 01:57:03 +0300
Message-ID: <20221201225703.6507-12-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/12/01 20:49:00 #20634374
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds clkc_periphs and clkc_pll dts nodes to A1 SoC main dtsi.
The first one clk controller is responsible for all SoC peripherals
clocks excluding audio clocks. The second one clk controller is used by
A1 SoC PLLs. Actually, there are two different APB heads, so we have two
different drivers.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 27 ++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index b4000cf65a9a..38e6517c603c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -6,6 +6,8 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/meson-a1-gpio.h>
+#include <dt-bindings/clock/a1-pll-clkc.h>
+#include <dt-bindings/clock/a1-clkc.h>
 
 / {
 	compatible = "amlogic,a1";
@@ -81,7 +83,6 @@ apb: bus@fe000000 {
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x1000000>;
 
-
 			reset: reset-controller@0 {
 				compatible = "amlogic,meson-a1-reset";
 				reg = <0x0 0x0 0x0 0x8c>;
@@ -124,6 +125,30 @@ uart_AO_B: serial@2000 {
 				clock-names = "xtal", "pclk", "baud";
 				status = "disabled";
 			};
+
+			clkc_periphs: periphs-clock-controller@800 {
+				compatible = "amlogic,a1-periphs-clkc";
+				reg = <0 0x800 0 0x104>;
+				#clock-cells = <1>;
+				clocks = <&clkc_pll CLKID_FCLK_DIV2>,
+					 <&clkc_pll CLKID_FCLK_DIV3>,
+					 <&clkc_pll CLKID_FCLK_DIV5>,
+					 <&clkc_pll CLKID_FCLK_DIV7>,
+					 <&clkc_pll CLKID_HIFI_PLL>,
+					 <&xtal>;
+				clock-names = "fclk_div2", "fclk_div3",
+					      "fclk_div5", "fclk_div7",
+					      "hifi_pll", "xtal";
+			};
+
+			clkc_pll: pll-clock-controller@7c80 {
+				compatible = "amlogic,a1-pll-clkc";
+				reg = <0 0x7c80 0 0x18c>;
+				#clock-cells = <1>;
+				clocks = <&clkc_periphs CLKID_XTAL_FIXPLL>,
+					 <&clkc_periphs CLKID_XTAL_HIFIPLL>;
+				clock-names = "xtal_fixpll", "xtal_hifipll";
+			};
 		};
 
 		gic: interrupt-controller@ff901000 {
-- 
2.36.0

