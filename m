Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A29C726A95
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjFGURF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjFGUQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:16:57 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE741BD6;
        Wed,  7 Jun 2023 13:16:53 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 521065FD6E;
        Wed,  7 Jun 2023 23:16:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1686169011;
        bh=RNbIjESD+IyeiwtGHiouI+gIk7LwD56yfGxWD9gzuYY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=ety0yB4LR209Ia4Tpu08KUqoQQDhbQZ+t2TyoGNxGor2mgGlh5hOLVskd/puVaQKA
         ItakKRYwyFkzq5qGb6H3nTb02RtnQmbRZzRcLmFaSt9hMznVqEz/6LGOBKct7xvofk
         8/XlN9HqYakI2nqi49c0GsYg8hGwiHU4y0dfxYOsjt1Dl13YZKi9cf5r7dqzrte9XL
         KSi3VXTGXfG662hLgeYiF8N0u4iIXx7mAdKRe1GGcoxMwaSx3zt+PwKoFd2CUUavar
         XRsaLv5zTQZaw+O4Q2knvowWPxZ3lgio6xQbC8R8Dpk/vz68+lH4+bWu/Ol3+JWRH+
         fFQ72fbQsvg1Q==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Wed,  7 Jun 2023 23:16:51 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <conor+dt@kernel.org>
CC:     <kernel@sberdevices.ru>, <sdfw_system_team@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v1 1/6] arm64: dts: meson: a1: introduce PLL and Peripherals clk controllers
Date:   Wed, 7 Jun 2023 23:16:36 +0300
Message-ID: <20230607201641.20982-2-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
References: <20230607201641.20982-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/07 16:55:00 #21454472
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds clkc and clkc_pll dts nodes to A1 SoC main dtsi.
The first one clk controller is responsible for all SoC peripherals
clocks excluding audio clocks. The second one clk controller is used by
A1 SoC PLLs. Actually, there are two different APB heads, so we have two
different drivers.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index eed96f262844..a24228808c9c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -6,6 +6,8 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/meson-a1-gpio.h>
+#include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
+#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
 
 / {
 	compatible = "amlogic,a1";
@@ -126,6 +128,30 @@ uart_AO_B: serial@2000 {
 				status = "disabled";
 			};
 
+			clkc_periphs: clock-controller@800 {
+				compatible = "amlogic,a1-peripherals-clkc";
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
+				clocks = <&clkc_periphs CLKID_FIXPLL_IN>,
+					 <&clkc_periphs CLKID_HIFIPLL_IN>;
+				clock-names = "fixpll_in", "hifipll_in";
+			};
+
 			gpio_intc: interrupt-controller@0440 {
 				compatible = "amlogic,meson-a1-gpio-intc",
 					     "amlogic,meson-gpio-intc";
-- 
2.36.0

