Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51A5629A87
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbiKONch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238416AbiKONcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:32:00 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C427186C6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:31:39 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id u24so21816185edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 05:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEH3pnZJvLD0zwCY2qegZFliLhqKwSFLXksz2qDwd0o=;
        b=D1x/wqV19k5fv0n4vUXYFw/LTQ7LoSF4atWm1OLscqT19XXHPCtwy5apBGGsui5LsW
         ONxmoz0Y+LS1tcQlEG1vvwrYgZVifLVxLQuzg+aoo3PJZqSpvhVEfy/m1O2imwdkGFx1
         jRhwsJa9cdgQvXQgq7G8Itf10juByxY0zakg+3vHvEgAD3+Jt3bqk+dJv7mfSI9da74i
         m0uzywY3N2KBpIVKo1TMx6ewTqIS+pJdG+E6JSgqvzDedqyGGKvFUtq+N3pxZPtmCYjD
         CG0kv1g94J1EgIz00W3PbvJuHTaDrSLQ6z/mG3VJYcTQxQqWBqDDBO93TOyvsJeh3oqj
         Hyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEH3pnZJvLD0zwCY2qegZFliLhqKwSFLXksz2qDwd0o=;
        b=wCjAstDhIWZCcQZsfqkx5n2ml7cf6/DWm1CzIa1Z8E98ydPW7KuLsCMHaHJ5fM2TAH
         JxtFdIK/X4ZVGi0temgwHeg/ckQwTY+grcVfOD1wZv5XE75z4vnETGKNvGWCZn37y4+b
         D47pm0ujbssHLKxcCugt2fAcsvK3pQ2ToOh3Q+3vhV9Jypp1DpR/wExcePxd7zoKEY3q
         pTfgESh/GJ8deGTfzeMBzdNZHaN5ycp/m0uszCIoRHetJg6ioarSebJMR/c+iHGjRpaB
         h1ckJ6xa25ShSn10L4XRaYqwpez9r73FaKobayLbhIrjkJcZ3RVdHdcr+NGnPgWSnEEg
         6gtg==
X-Gm-Message-State: ANoB5pliho9cfLWbBMgZmS9MLaEAM1bhQnBFJPUDngJzxvlxvN8JDW7s
        glVBi/8pZFiXircI/SUhfYXEWg==
X-Google-Smtp-Source: AA0mqf6wssygtYCaiLkY+W5Y5DsDe7rFjCkjG59o0CmzJRKJWKaOjsvLitTNFYRUH8YfNcIJBXWKBQ==
X-Received: by 2002:aa7:d5d4:0:b0:458:e00e:5a85 with SMTP id d20-20020aa7d5d4000000b00458e00e5a85mr15228307eds.171.1668519098302;
        Tue, 15 Nov 2022 05:31:38 -0800 (PST)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id q22-20020aa7d456000000b004618f2127d2sm6162176edr.57.2022.11.15.05.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:31:37 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        quic_kalyant@quicinc.com, swboyd@chromium.org,
        robert.foss@linaro.org, angelogioacchino.delregno@somainline.org,
        loic.poulain@linaro.org, quic_khsieh@quicinc.com,
        quic_vpolimer@quicinc.com, vkoul@kernel.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org, quic_jesszhan@quicinc.com,
        andersson@kernel.org
Subject: [PATCH v2 12/12] arm64: dts: qcom: sm8350-hdk: Enable lt9611uxc dsi-hdmi bridge
Date:   Tue, 15 Nov 2022 14:31:05 +0100
Message-Id: <20221115133105.980877-13-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115133105.980877-1-robert.foss@linaro.org>
References: <20221115133105.980877-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sm8350-hdk ships with the LT9611 UXC DSI/HDMI bridge chip.

In order to toggle the board to enable the HDMI output,
switch #7 & #8 on the rightmost multi-switch package have
to be toggled to On.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 105 ++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 39462c659c58..3aa4ca8271e5 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -20,6 +20,17 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&lt9611_out>;
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
@@ -29,6 +40,31 @@ vph_pwr: vph-pwr-regulator {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	lt9611_1v2: lt9611-1v2-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "LT9611_1V2";
+
+		vin-supply = <&vph_pwr>;
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		gpio = <&tlmm 49 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+
+	lt9611_3v3: lt9611-3v3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "LT9611_3V3";
+
+		vin-supply = <&vreg_bob>;
+		gpio = <&tlmm 47 GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &adsp {
@@ -220,6 +256,15 @@ &dispcc {
 &dsi0 {
 	vdda-supply = <&vreg_l6b_1p2>;
 	status = "okay";
+
+	ports {
+		port@1 {
+			endpoint {
+				remote-endpoint = <&lt9611_a>;
+				data-lanes = <0 1 2 3>;
+			};
+		};
+	};
 };
 
 &dsi0_phy  {
@@ -231,6 +276,46 @@ &gpi_dma1 {
 	status = "okay";
 };
 
+&i2c15 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	lt9611_codec: hdmi-bridge@2b {
+		compatible = "lontium,lt9611uxc";
+		reg = <0x2b>;
+
+		interrupts-extended = <&tlmm 50 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&tlmm 48 GPIO_ACTIVE_HIGH>;
+
+		vdd-supply = <&lt9611_1v2>;
+		vcc-supply = <&lt9611_3v3>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&lt9611_state>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lt9611_a: endpoint {
+					remote-endpoint = <&dsi0_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				lt9611_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+};
+
 &mdss {
 	status = "okay";
 };
@@ -248,6 +333,10 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&qupv3_id_2 {
+	status = "okay";
+};
+
 &slpi {
 	status = "okay";
 	firmware-name = "qcom/sm8350/slpi.mbn";
@@ -544,4 +633,20 @@ usb_hub_enabled_state: usb-hub-enabled-state {
 		drive-strength = <2>;
 		output-low;
 	};
+
+	lt9611_state: lt9611-state {
+		lt9611_rst_pin {
+			pins = "gpio48";
+			function = "normal";
+
+			output-high;
+			input-disable;
+		};
+
+		lt9611_irq_pin {
+			pins = "gpio50";
+			function = "gpio";
+			bias-disable;
+		};
+	};
 };
-- 
2.34.1

