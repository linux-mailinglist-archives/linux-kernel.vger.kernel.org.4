Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F53F701F5D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 22:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjENUAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 16:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjENUAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 16:00:17 -0400
Received: from smtprelay02.ispgateway.de (smtprelay02.ispgateway.de [80.67.18.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91468135;
        Sun, 14 May 2023 13:00:15 -0700 (PDT)
Received: from [92.206.161.29] (helo=note-book.lan)
        by smtprelay02.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <git@apitzsch.eu>)
        id 1pyHs3-0004fW-9E; Sun, 14 May 2023 21:59:07 +0200
From:   =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Date:   Sun, 14 May 2023 21:58:26 +0200
Subject: [PATCH] arm64: dts: qcom: msm8916-longcheer-l8910: Add front flash
 LED
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230514-x5_front_flash-v1-1-3979c8498efa@apitzsch.eu>
X-B4-Tracking: v=1; b=H4sIAGE9YWQC/x2N0QqDMAwAf0XyvIKNCtt+ZQxJa7oGtjoSGYL47
 6s+HsdxGxirsMG92UD5JyZzqeAvDcRM5cVOpsqALXbt4Hu3DmPSuSxjepNlF/31xoihwzRBjQI
 Zu6BUYj6yD9nCeoivcpL1PD2e+/4HhH9Ac3kAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
X-Mailer: b4 0.12.2
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

l8910 uses OCP8110 flash LED driver. Add it to the device tree.

Tested-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts      | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index b79e80913af9..81cebac117f1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -20,6 +20,21 @@ chosen {
 		stdout-path = "serial0";
 	};
 
+	flash-led-controller {
+		compatible = "ocs,ocp8110";
+		enable-gpios = <&msmgpio 49 GPIO_ACTIVE_HIGH>;
+		flash-gpios = <&msmgpio 119 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&camera_front_flash_default>;
+
+		flash_led: led {
+			function = LED_FUNCTION_FLASH;
+			color = <LED_COLOR_ID_WHITE>;
+			flash-max-timeout-us = <250000>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -246,6 +261,14 @@ button_backlight_default: button-backlight-default-state {
 		bias-disable;
 	};
 
+	camera_front_flash_default: camera-front-flash-default-state {
+		pins = "gpio49", "gpio119";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	gpio_keys_default: gpio-keys-default-state {
 		pins = "gpio107";
 		function = "gpio";

---
base-commit: 533c54547153d46c0bf99ac0e396bed71f760c03
change-id: 20230514-x5_front_flash-c189e22b32fd

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>

