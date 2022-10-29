Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BCA612413
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJ2O4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJ2O4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:56:51 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9F01A831;
        Sat, 29 Oct 2022 07:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1667055393; bh=cnHB/4wJLTp97pHPmNGyrytKlD90FNbK6YTVOWwFjM0=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=lZ+latLXQv3zvEePk//cFDAIpwxMiWZTxKcFeTvDSxh5LGT69dDzsPhZmnDuo7cYQ
         Q96Cf+swjxsY33wOxzfOaqHxj7ukEmfbMkqdckPDqAwEMpMXd44dve/w6WFZDUbPdQ
         VjBc8q41aaLVw1qNJoyrX1TWdKIJzXLr5IvECxgI=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.207]
        Sat, 29 Oct 2022 16:56:33 +0200 (CEST)
X-EA-Auth: ICeHAvWj9qLZjB+ctyqYPt4DioJaU/Djg+uFctKL2Y03oPkzlKncDD3xawmzWga5ooQLzFwsNw1TaxOkcDKyklx/+0fJ0VjqkolTrdLhTgU=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v1 2/2] arm64: dts: qcom: msm8916-alcatel-idol347: add LED indicator
Date:   Sat, 29 Oct 2022 16:55:57 +0200
Message-Id: <20221029145557.106920-2-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221029145557.106920-1-vincent.knecht@mailoo.org>
References: <20221029145557.106920-1-vincent.knecht@mailoo.org>
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

Add si-en,sn3190 LED controller to enable white LED indicator.

This requires adding the additional "enable" gpio that the OEM
choose to use, despite it not being mentioned in si-en,sn3190
datasheet nor supported by the driver.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index 3a0a593899ae..952ae092e6ae 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -130,6 +130,27 @@ gyroscope@68 {
 	};
 };
 
+&blsp_i2c6 {
+	status = "okay";
+
+	led-controller@68 {
+		compatible = "si-en,sn3190";
+		reg = <0x68>;
+		shutdown-gpios = <&msmgpio 89 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_enable_default &led_shutdown_default>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@1 {
+			reg = <1>;
+			led-max-microamp = <5000>;
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_WHITE>;
+		};
+	};
+};
+
 &pm8916_resin {
 	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
@@ -306,6 +327,29 @@ gyro_int_default: gyro-int-default {
 		bias-disable;
 	};
 
+	/*
+	 * The OEM wired an additional GPIO to be asserted so that
+	 * the si-en,sn3190 LED IC works. Since this GPIO is not
+	 * part of the IC datasheet nor supported by the driver,
+	 * force it asserted here.
+	 */
+	led_enable_default: led-enable-default {
+		pins = "gpio102";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+		output-high;
+	};
+
+	led_shutdown_default: led-shutdown-default {
+		pins = "gpio89";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	mag_reset_default: mag-reset-default {
 		pins = "gpio8";
 		function = "gpio";
-- 
2.37.3



