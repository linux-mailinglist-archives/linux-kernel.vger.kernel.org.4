Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3B369145D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjBIX0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjBIX0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:26:10 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EB5658EE;
        Thu,  9 Feb 2023 15:26:00 -0800 (PST)
Received: from localhost.localdomain (51b6913b.dsl.pool.telekom.hu [::ffff:81.182.145.59])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006F771.0000000063E58107.002B65BC; Fri, 10 Feb 2023 00:25:59 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
Subject: [PATCH v2 3/3] arm64: dts: qcom: sdm845-oneplus: add tri-state-key
Date:   Fri, 10 Feb 2023 00:25:56 +0100
Message-Id: <20230209232556.91554-1-soyer@irl.hu>
X-Mailer: git-send-email 2.39.1
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

The tri-state-key is a sound profile switch found on the OnePlus 6,
Android maps the states to "mute", "vibrate" and "ring". Expose them as
ABS_SND_PROFILE events.
The previous GPIO numbers were wrong. Update them to the correct
ones.

Co-developed-by: Caleb Connolly <caleb@connolly.tech>
Signed-off-by: Caleb Connolly <caleb@connolly.tech>
Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 64638ea94db7..e45d4fdead82 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -52,6 +52,43 @@ key-vol-up {
 		};
 	};
 
+	tri-state-key {
+		compatible = "gpio-keys";
+		label = "Tri-state key";
+		pinctrl-names = "default";
+		pinctrl-0 = <&tri_state_key_default>;
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
+
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
@@ -754,7 +791,7 @@ &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
 	tri_state_key_default: tri-state-key-default-state {
-		pins = "gpio40", "gpio42", "gpio26";
+		pins = "gpio126", "gpio52", "gpio24";
 		function = "gpio";
 		drive-strength = <2>;
 		bias-disable;
-- 
2.39.1

