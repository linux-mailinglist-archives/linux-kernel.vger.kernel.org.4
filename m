Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720AD6B07BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjCHNBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjCHNAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:00:34 -0500
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [IPv6:2001:1600:4:17::42aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A187907AC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:59:54 -0800 (PST)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWsgL52tszMrV3l;
        Wed,  8 Mar 2023 13:53:18 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWsgL1LbNzMslsG;
        Wed,  8 Mar 2023 13:53:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678279998;
        bh=0aQVO4QE3EMr93GN5aXwmbhmG3BGBh3gFzNFrkt2N0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gsg65/KV/cgzEWYToZ/LwcomvquWGvXDVck548yXZVn0mIHYPi/a9Izsza8lHr8vO
         x9bbrNwrU2cngGB6Q5otz7ha1f0DvP3Rd8wJnkBFQH4+JUP2STcgdDTLEo8UoxKLeO
         qOUcQlZH4jCLmeRF6DrKYDwmUJUI/UM1RmNhX26Y=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 20/25] arm64: dts: colibri-imx8x: Move gpio-keys to som level
Date:   Wed,  8 Mar 2023 13:52:54 +0100
Message-Id: <20230308125300.58244-21-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308125300.58244-1-dev@pschenker.ch>
References: <20230308125300.58244-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

SODIMM_45 that is connected to "&lsio_gpio3 10" is defined in the
Colibri standard to be a wakeup pin.
Move this to the SoM level device-tree and keep it disabled by default
but do enable it again on the carrier-board.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---

 .../dts/freescale/imx8x-colibri-eval-v3.dtsi     | 16 +++-------------
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
index e7e3cf462408..8dfcb2cfdb68 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
@@ -17,20 +17,10 @@ clk16m: clock-16mhz-fixed {
 		#clock-cells = <0>;
 		clock-frequency = <16000000>;
 	};
+};
 
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpiokeys>;
-
-		key-wakeup {
-			label = "Wake-Up";
-			gpios = <&lsio_gpio3 10 GPIO_ACTIVE_HIGH>;
-			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
-			wakeup-source;
-		};
-	};
+&colibri_gpio_keys {
+	status = "okay";
 };
 
 /* Colibri FastEthernet */
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 2f86a2eb4ff3..e93e22c4053b 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -8,6 +8,21 @@ chosen {
 		stdout-path = &lpuart3;
 	};
 
+	colibri_gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiokeys>;
+		status = "disabled";
+
+		key-wakeup {
+			debounce-interval = <10>;
+			gpios = <&lsio_gpio3 10 GPIO_ACTIVE_HIGH>;
+			label = "Wake-Up";
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
+
 	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
 		regulator-max-microvolt = <3300000>;
-- 
2.39.2

