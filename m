Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2AA6197D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiKDN0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiKDNZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:25:12 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859F62EF53;
        Fri,  4 Nov 2022 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1667568259; bh=UgO1xNnlTSFaN2qgupbbM8Ur3DOStS+vykVPuifYPLo=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=POxlVPOzyuqsAyHRx/0M92+BPkcY59Ddwh0JhArQ2LWPBuADYp95DX8DqXGoRmDt8
         ePMJ8gpMJhbIsHOsy5XrAAhWuk40WrCDjVzicU4ALZJ0bDclzPVw2PB5F1gIWU9lSN
         JpytAxF/elmeNr3oZwbgwjU9lI+y442Lvt+Dso58=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Fri,  4 Nov 2022 14:24:19 +0100 (CET)
X-EA-Auth: 4p+PYttiXqTiCOGG50FOja6s6oKhTxS56lC5svw7yIr4FnkQPn3cryCjUKrBJ2w9pr1Aif9YF+wg8uiJ7kMWNSjJISFkiE1sr/OByAIgpU8=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v2 2/3] arm64: dts: qcom: msm8916-alcatel-idol347: add GPIO torch LED
Date:   Fri,  4 Nov 2022 14:23:59 +0100
Message-Id: <20221104132400.1763218-3-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221104132400.1763218-1-vincent.knecht@mailoo.org>
References: <20221104132400.1763218-1-vincent.knecht@mailoo.org>
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
index 668f8ff53229..eadeb1a445fd 100644
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
@@ -276,6 +290,14 @@ gpio_keys_default: gpio-keys-default-state {
 		bias-pull-up;
 	};
 
+	gpio_leds_default: gpio-leds-default-state {
+		pins = "gpio32";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	gyro_int_default: gyro-int-default-state {
 		pins = "gpio97", "gpio98";
 		function = "gpio";
-- 
2.38.1



