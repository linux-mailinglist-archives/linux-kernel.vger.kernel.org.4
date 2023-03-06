Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD686ACAF2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCFRoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjCFRoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:44:02 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154173A871;
        Mon,  6 Mar 2023 09:43:23 -0800 (PST)
Received: from fedori.lan (softdnserr [::ffff:81.182.156.141])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006FE69.00000000640625E2.0008999E; Mon, 06 Mar 2023 18:41:54 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gergo Koteles <soyer@irl.hu>
Subject: [PATCH] arm64: dts: qcom: sdm845-oneplus-common: add Hall sensor
Date:   Mon,  6 Mar 2023 18:41:47 +0100
Message-Id: <20230306174147.185239-1-soyer@irl.hu>
X-Mailer: git-send-email 2.39.2
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the Hall effect sensor (flip cover) for OnePlus 6/6T.
The GPIO is mapped to SW_LID events as in msm8916, msm8994,
msm8998 devices.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 64638ea94db7..b01542d79ae2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -29,6 +29,23 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	gpio-hall-sensor {
+		compatible = "gpio-keys";
+		label = "Hall effect sensor";
+
+		pinctrl-0 = <&hall_sensor_default>;
+		pinctrl-names = "default";
+
+		event-hall-sensor {
+			gpios = <&tlmm 124 GPIO_ACTIVE_LOW>;
+			label = "Hall Effect Sensor";
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		label = "Volume keys";
@@ -753,6 +770,14 @@ &usb_1_hsphy {
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
+	hall_sensor_default: hall-sensor-default-state {
+		pins = "gpio124";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		input-enable;
+	};
+
 	tri_state_key_default: tri-state-key-default-state {
 		pins = "gpio40", "gpio42", "gpio26";
 		function = "gpio";
-- 
2.39.2

