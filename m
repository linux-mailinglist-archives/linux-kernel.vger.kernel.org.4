Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14A66197D1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiKDNZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiKDNYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:24:54 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1412FC30;
        Fri,  4 Nov 2022 06:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1667568260; bh=/VuTcksTYzQcmTVddTorAaSINvFG5kEAozPNxmP6P0k=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding;
        b=X7k/7N+Vu71B3AuVpAKMN44ePg8unhWCDJK5VnPVpvEtC0fIxFbmCXrrC1rmUNouh
         ovC7E1G7tWzOWew5cXzKcHJI+3D7tiTypW2Dp8H7zmxbbEeakXjzmGdyvp5ZttgaTR
         kKGEKVKi2go630EvVCseM8Rq2wgxJ/RtP2ZJUzsE=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Fri,  4 Nov 2022 14:24:20 +0100 (CET)
X-EA-Auth: MBXKOFvLNcjuDq1qBH+FDXkViUMQsA7Hp6gAIFNEdb1ykPMxL1HfK1DFo7RY5OsAe4h/EV1PvpkfwVbk083EliZqx1ANLoHEIK3S6UucV5A=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v2 3/3] arm64: dts: qcom: msm8916-alcatel-idol347: add LED indicator
Date:   Fri,  4 Nov 2022 14:24:00 +0100
Message-Id: <20221104132400.1763218-4-vincent.knecht@mailoo.org>
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

Add si-en,sn3190 LED controller to enable white LED indicator.

This requires adding the additional "enable" gpio that the OEM
choose to use, despite it not being mentioned in si-en,sn3190
datasheet nor supported by the driver.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index eadeb1a445fd..701a5585d77e 100644
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
@@ -306,6 +327,29 @@ gyro_int_default: gyro-int-default-state {
 		bias-disable;
 	};
 
+	/*
+	 * The OEM wired an additional GPIO to be asserted so that
+	 * the si-en,sn3190 LED IC works. Since this GPIO is not
+	 * part of the IC datasheet nor supported by the driver,
+	 * force it asserted here.
+	 */
+	led_enable_default: led-enable-default-state {
+		pins = "gpio102";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+		output-high;
+	};
+
+	led_shutdown_default: led-shutdown-default-state {
+		pins = "gpio89";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	mag_reset_default: mag-reset-default-state {
 		pins = "gpio8";
 		function = "gpio";
-- 
2.38.1



