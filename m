Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEC2612414
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJ2O5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ2O4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:56:51 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA5127DF8;
        Sat, 29 Oct 2022 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1667055391; bh=Rjnk2GfEtjhc7aPN1HinZjHZRnbPWaoByT5yL4fs8vY=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=KQVEns2j3bnqIGavDI94PVQtVcUmOhfJ2CgzISs3tHKmeNqCKIsTfz4CqvMk0m0hm
         LQ0nUYAUg6WfEo/d0qBD3pxqldEfdZt5/IHo/uIo2Birs7iuTUKT8ue74bVTMurB7b
         T5u+KqpKCHgoBfw5R03dS3gQ7VNa+LM3X6pVP0NI=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.207]
        Sat, 29 Oct 2022 16:56:31 +0200 (CEST)
X-EA-Auth: ffC9z5VMk1EziQcyiKwrCnIHjLobvY6isyGnBPrFPMjwQU8iLOhLQsjJ+rgjWc3rKFkDJnz7m3fzshX4JKVV/EnakQzGs4eEFIoHfeMap7Q=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v1 1/2] arm64: dts: qcom: msm8916-alcatel-idol347: add GPIO torch LED
Date:   Sat, 29 Oct 2022 16:55:56 +0200
Message-Id: <20221029145557.106920-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for torch LED on GPIO 32.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index 3dc9619fde6e..3a0a593899ae 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -5,6 +5,7 @@
 #include "msm8916-pm8916.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "Alcatel OneTouch Idol 3 (4.7)";
@@ -34,6 +35,19 @@ button-volume-up {
 		};
 	};
 
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_leds_default>;
+
+		led-0 {
+			gpios = <&msmgpio 32 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "torch";
+			function = LED_FUNCTION_TORCH;
+		};
+	};
+
 	usb_id: usb-id {
 		compatible = "linux,extcon-usb-gpio";
 		id-gpio = <&msmgpio 69 GPIO_ACTIVE_HIGH>;
@@ -276,6 +290,14 @@ gpio_keys_default: gpio-keys-default {
 		bias-pull-up;
 	};
 
+	gpio_leds_default: gpio-leds-default {
+		pins = "gpio32";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	gyro_int_default: gyro-int-default {
 		pins = "gpio97", "gpio98";
 		function = "gpio";
-- 
2.37.3



