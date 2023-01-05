Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6921265EB19
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233450AbjAEMvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjAEMv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:51:28 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F0E4BD68;
        Thu,  5 Jan 2023 04:51:26 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 6873E420D1;
        Thu,  5 Jan 2023 17:33:57 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1672922038; bh=Q9PyOYwHzV6hYDK9dXXB+GuVnQwRSCoeQeyi78nz73I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O6qIpXLl4UvqKGU1e3SF8yjsLQYthoP8q8EapvOKZSM7nkD1VV+GG6iMn2PPXeMkP
         bTRwHohiJ/XM27qqxd3Axfak4HF9oWRzg27uCoqd1QrIEUDYi1Q/RBv77QlroS/40w
         2Gt6NjuKBLYk7oKXV5lmkdATKd81sIWWO4vMYnthjg7LvXiNMaWTq/L+1E1D9/8J3c
         yfZWxBTuE0hEZtPzlFQG/7IV7pyH75115Ndydc+yo9BTw/sAqC76UHpEca2WyZO9NR
         7fmAbYFMR2ZtVwT/5grR2YqS2YfX0MsUZ+44Ah129iO5j8LMxF/IPa5kg0Wj3rXiDF
         kYWBHR5uQojVw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Siddharth Manthan <siddharth.manthan@gmail.com>,
        Jasper Korten <jja2000@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 4/8] arm64: dts: qcom: msm8916-samsung-gt510: Add Vibrator
Date:   Thu,  5 Jan 2023 17:32:36 +0500
Message-Id: <20230105123240.1089375-5-nikita@trvn.ru>
In-Reply-To: <20230105123240.1089375-1-nikita@trvn.ru>
References: <20230105123240.1089375-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gt510 uses a PWM controllable vibrator, that uses a general purpose
clock output for it's control. Set up the pwm, supply and the vibrator.

Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 .../boot/dts/qcom/msm8916-samsung-gt510.dts   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
index e9916199e5a3..44d527b3f1f6 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt510.dts
@@ -8,4 +8,51 @@ / {
 	model = "Samsung Galaxy Tab A 9.7 (2015)";
 	compatible = "samsung,gt510", "qcom,msm8916";
 	chassis-type = "tablet";
+
+	clk_pwm: pwm {
+		compatible = "clk-pwm";
+		#pwm-cells = <2>;
+
+		clocks = <&gcc GCC_GP2_CLK>;
+
+		pinctrl-0 = <&motor_pwm_default>;
+		pinctrl-names = "default";
+	};
+
+	reg_motor_vdd: regulator-motor-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "motor_vdd";
+		regulator-min-microvolt = <3000000>;
+		regulator-max-microvolt = <3000000>;
+
+		gpio = <&msmgpio 76 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&motor_en_default>;
+		pinctrl-names = "default";
+	};
+
+	vibrator {
+		compatible = "pwm-vibrator";
+
+		pwms = <&clk_pwm 0 100000>;
+		pwm-names = "enable";
+
+		vcc-supply = <&reg_motor_vdd>;
+	};
+};
+
+&msmgpio {
+	motor_en_default: motor-en-default-state {
+		pins = "gpio76";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	motor_pwm_default: motor-pwm-default-state {
+		pins = "gpio50";
+		function = "gcc_gp2_clk_a";
+	};
 };
-- 
2.38.1

