Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC8D6B8FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjCNK0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjCNKZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:25:28 -0400
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6905562868
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:25:06 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PbV4v6YwjzMqQWF;
        Tue, 14 Mar 2023 11:24:31 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PbV4v2qyjz2N4G;
        Tue, 14 Mar 2023 11:24:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678789471;
        bh=oDmzZoOyBIwUWooe1ysmdzU43k7yTVJ0y76naMMCSc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xqcfc8pzlw3nVLalZ5+XdRNpmrKGfarIZjlHjR2JE4dM8VdIjWCcpl3XMdn0JEdFt
         PcpQfJQac63WZ9F+wjwpVDRVMmqV2PHibEbmTKlaESlCf8MjzmOTkkkJko9cCRm1VI
         0HuolR6VBirKJfpa3XuH2wmMm/3Rq+AwsgZTlma0=
From:   Philippe Schenker <dev@pschenker.ch>
To:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/23] arm64: dts: colibri-imx8x: Move gpio-keys to som level
Date:   Tue, 14 Mar 2023 11:24:04 +0100
Message-Id: <20230314102410.424773-19-dev@pschenker.ch>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314102410.424773-1-dev@pschenker.ch>
References: <20230314102410.424773-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
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

(no changes since v1)

 .../dts/freescale/imx8x-colibri-eval-v3.dtsi     | 16 +++-------------
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi | 15 +++++++++++++++
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
index 14d479b50656..7264d784ae72 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri-eval-v3.dtsi
@@ -17,20 +17,10 @@ clk16m: clock-16mhz {
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
 
 &i2c1 {
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 1e41965e2d01..ff5ad88febc8 100644
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
 		regulator-name = "+V3.3";
-- 
2.39.2

