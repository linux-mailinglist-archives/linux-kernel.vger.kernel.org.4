Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FFC672D06
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjARXxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjARXwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:52:53 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710884E53F;
        Wed, 18 Jan 2023 15:52:10 -0800 (PST)
Received: from fedori.lan (c3e47541.dsl.pool.telekom.hu [::ffff:195.228.117.65])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000068C5C.0000000063C884EF.0028DB3D; Thu, 19 Jan 2023 00:46:55 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>,
        Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 3/3] arm64: dts: qcom: sdm845-oneplus: add tri-state-key
Date:   Thu, 19 Jan 2023 00:46:38 +0100
Message-Id: <20230118234638.189098-4-soyer@irl.hu>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118234638.189098-1-soyer@irl.hu>
References: <20230118234638.189098-1-soyer@irl.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tri-state-key is a sound profile switch found on the OnePlus 6,
Android maps the states to "mute", "vibrate" and "ring", expose them as
ABS_SND_PROFILE events.
The previous GPIO numbers were wrong, the patch updates them to the correct
ones.

Co-developed-by: Caleb Connolly <caleb@connolly.tech>
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 43 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 42cf4dd5ea28..33215ad17513 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -49,6 +49,44 @@ key-vol-up {
 		};
 	};
 
+	tri-state-key {
+		compatible = "gpio-keys";
+		label = "Tri-state key";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tri_state_key_default>;
+
+		state-top {
+			label = "Tri-state key top";
+			linux,input-type = <EV_ABS>;
+			linux,code = <ABS_SND_PROFILE>;
+			linux,input-value = <0>;
+			gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
+			debounce-interval = <50>;
+			linux,can-disable;
+		};
+
+		state-middle {
+			label = "Tri-state key middle";
+			linux,input-type = <EV_ABS>;
+			linux,code = <ABS_SND_PROFILE>;
+			linux,input-value = <1>;
+			gpios = <&tlmm 52 GPIO_ACTIVE_LOW>;
+			debounce-interval = <50>;
+			linux,can-disable;
+		};
+
+		state-bottom {
+			label = "Tri-state key bottom";
+			linux,input-type = <EV_ABS>;
+			linux,code = <ABS_SND_PROFILE>;
+			linux,input-value = <2>;
+			gpios = <&tlmm 24 GPIO_ACTIVE_LOW>;
+			debounce-interval = <50>;
+			linux,can-disable;
+		};
+	};
+
 	reserved-memory {
 		/*
 		 * The rmtfs_mem needs to be guarded due to "XPU limitations"
@@ -588,9 +626,10 @@ &usb_1_hsphy {
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
-	tri_state_key_default: tri_state_key_default {
+	// The GPIOs have a hardware pullup.
+	tri_state_key_default: tri-state-pins {
 		mux {
-			pins = "gpio40", "gpio42", "gpio26";
+			pins = "gpio126", "gpio52", "gpio24";
 			function = "gpio";
 			drive-strength = <2>;
 			bias-disable;
-- 
2.39.0

