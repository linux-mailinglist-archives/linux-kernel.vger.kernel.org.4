Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF33659A02
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 16:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbiL3PhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 10:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiL3Pgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 10:36:33 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D371C124
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:36:20 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so13185841wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 07:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctxOvK28D28f3o6Pe3qUkH7ZxEJEHxVrpCcUg+NUh04=;
        b=g+KWhYGJxl7BWHkPVNQW1thWA8kAFGFXKPDHOZ373tFmfHrrrPrIE8mDNU+pEvbUcv
         sYbdVvT4u8d+m/kCUGSTSPZsQvC4+rrnz6+zgo+346ucE9ZCvb/Wx3BHgmR92wKGPbmi
         T9oHmoYYv3xuSLBhnj1fxSNfm4vVXAFA2EG6KHsA5TKAo5ifpHxLny4+OExRO6+uUwXJ
         g5T18A0HRPaIxiNXHMIaIrcovFujD0egizRlMXz6MTMPwMy9FQhJvlyxMmkiIxEx+sBS
         2BnoQnguqkD7JYL3lq4S4xSpGPaW/fkXLLIbdC3L7QDhqaBbrEf8dYHKOhPgJUwEykwA
         Z0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctxOvK28D28f3o6Pe3qUkH7ZxEJEHxVrpCcUg+NUh04=;
        b=Co0NRveoJqu8OrehaHTIL54YDAvcEfECRud4f1RPSYKD5eCzK5Ijrcvn8H6t4Imuij
         NNuO+DsbVD41ChFe5i+t0MZd/ajUIUCEr1DqrTk9kp9Qpetn0wUNNHzLoMBX9tRzgs3j
         MgH4zJYOpe+j+GpSPavM+rRu26rykGiwkDVVtAcOjF/9GNaOqBR5n7RlmNKepAdemZ4L
         CArWhZRqkrMqlYy86Z8VSJsKTYsgZ6XjqIDhmAt4+QQCio80H7VTItOs4/BznZm/dtrS
         IjtHgSw+BMgxsKuEsMgXDgs8viE8vZiNGKfeXwIY/85+hgkqDwIdeUzeMLQxJQKHmk+B
         k0LA==
X-Gm-Message-State: AFqh2kpbrpshw8wWFwqa75AtHALBNzfnk69EENv+OPhShZSYUKvxSmBu
        cjTR0E0/qHVn5OUlQCcv62IPhA==
X-Google-Smtp-Source: AMrXdXupiR1KHz1rC6eEmvSjNUuoXVux4kIV6jTnI6HXoz6vZWYwnghGJbUlafDEiY/R85jV3v2VKw==
X-Received: by 2002:a05:600c:4995:b0:3d3:4f43:fbc2 with SMTP id h21-20020a05600c499500b003d34f43fbc2mr23117665wmp.41.1672414580409;
        Fri, 30 Dec 2022 07:36:20 -0800 (PST)
Received: from prec5560.. (freifunk-gw.bsa1-cpe1.syseleven.net. [176.74.57.43])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003cfbbd54178sm49857993wms.2.2022.12.30.07.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 07:36:20 -0800 (PST)
From:   Robert Foss <robert.foss@linaro.org>
To:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        quic_jesszhan@quicinc.com, robert.foss@linaro.org,
        angelogioacchino.delregno@somainline.org, loic.poulain@linaro.org,
        vkoul@kernel.org, a39.skl@gmail.com, quic_khsieh@quicinc.com,
        quic_vpolimer@quicinc.com, swboyd@chromium.org,
        dianders@chromium.org, liushixin2@huawei.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
        vinod.koul@linaro.org
Subject: [PATCH v4 11/11] arm64: dts: qcom: sm8350-hdk: Enable lt9611uxc dsi-hdmi bridge
Date:   Fri, 30 Dec 2022 16:35:54 +0100
Message-Id: <20221230153554.105856-12-robert.foss@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230153554.105856-1-robert.foss@linaro.org>
References: <20221230153554.105856-1-robert.foss@linaro.org>
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
index 1961f941ff83..6b21897c92dc 100644
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
 &mdss_dsi0 {
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
 
 &mdss_dsi0_phy  {
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
+		rst {
+			pins = "gpio48";
+			function = "normal";
+
+			output-high;
+			input-disable;
+		};
+
+		irq {
+			pins = "gpio50";
+			function = "gpio";
+			bias-disable;
+		};
+	};
 };
-- 
2.34.1

