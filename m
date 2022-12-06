Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB461644F3A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiLFXBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiLFXBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:01:25 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437724A5BA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:01:15 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id vp12so9948210ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 15:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIVcLPhGW2y+mTG7vdx75MRunoC7E7rBcueTJOw2jNc=;
        b=yvmZfyaTbYvX+Enwv0jZTENse2nwPIS++LmEUF6RpXFAFSrA9Y9Ygf16wYwWALE6gV
         j/ErQOgfpV+5qrqX52gE/Ho9NhkAnKUgPtNV7rYDaxJPlUN3vp3xqlw/VDUMC+9ZFhKd
         mRSawuvQz8McoDmI3NADKYxeN6cfWf7LABWSXIe4lKFUSX/+8OpGLR+gC2mvNw9ySUbG
         dIGIJhxSWKEbQGa7rN1kI2AkLu8VL16EV1ZTpI65l8bpKXzanhR8Vz7KPZ2BuWtnaWO5
         Emb/vk6wzbWYc+kUwYATyAFhZuJSYeA1+1+2xQXAA0qHX4Px6hh+OpqocIcXU6ZUIADI
         RiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIVcLPhGW2y+mTG7vdx75MRunoC7E7rBcueTJOw2jNc=;
        b=exMlB68Ysstjn02Jbilr1/Qoc3u5Jm3Lug2QRkNRTW8gsuP1bFrYgL8VNsVMEeNXZV
         HSxrOo5dhrnr1S5K6CY9QA1K4wNlgQSeocAvctyrjzZxWVX++lb6KH8mRBIg6lIp8ODJ
         07sPKxqxnWI5pwEAsffkv8Dfs4SDk5Ap9S6sXqCkT8MdVjCB9T+mmP6lP/GrJfFXcqlE
         cdPIll5hMLbC38QSTs48rCjGCpv3OXG2MqF/RlcatG0iC+rjCfzCV5glHx1C1qviB7Tq
         ZbW9Z0OPT4sb0ArcgqFdiw0PLYEVbtbhfNskgkHuT+Ve8f8Kpf5jbCtymNLrsRWf+kZr
         8aBw==
X-Gm-Message-State: ANoB5plqsDKWd+y3SKQ0tqRte1+xfFGYIyOqpNDhp7Y6AWsijZSG5ukc
        LPQ3h+Kh0Vb4eexILTuMRPSx5A==
X-Google-Smtp-Source: AA0mqf5b81hXxFG9l+5co5NdUAnsqZ2r5nWpVqhFmWSY8ITadSVRXTPhYEyMaRHJ3X68awtcw7FMkg==
X-Received: by 2002:a17:907:76f2:b0:7c0:eb3c:1037 with SMTP id kg18-20020a17090776f200b007c0eb3c1037mr10264468ejc.663.1670367673830;
        Tue, 06 Dec 2022 15:01:13 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906838a00b007c0dacbe00bsm4239320ejx.115.2022.12.06.15.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 15:01:13 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v7 07/10] arm64: dts: qcom: Add PM8550vs pmic dtsi
Date:   Wed,  7 Dec 2022 01:00:59 +0200
Message-Id: <20221206230102.1521053-8-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206230102.1521053-1-abel.vesa@linaro.org>
References: <20221206230102.1521053-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <neil.armstrong@linaro.org>

Add nodes for PM8550vs in separate dtsi file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8550vs.dtsi | 194 +++++++++++++++++++++++++
 1 file changed, 194 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550vs.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8550vs.dtsi b/arch/arm64/boot/dts/qcom/pm8550vs.dtsi
new file mode 100644
index 000000000000..97b1c18aa7d8
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8550vs.dtsi
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	thermal-zones {
+		pm8550vs-c-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8550vs_c_temp_alarm>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+			};
+		};
+
+		pm8550vs-d-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8550vs_d_temp_alarm>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+			};
+		};
+
+		pm8550vs-e-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8550vs_e_temp_alarm>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+			};
+		};
+
+		pm8550vs-g-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8550vs_g_temp_alarm>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "hot";
+				};
+			};
+		};
+	};
+};
+
+
+&spmi_bus {
+	pm8550vs_c: pmic@2 {
+		compatible = "qcom,pm8550", "qcom,spmi-pmic";
+		reg = <0x2 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8550vs_c_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8550vs_c_gpios: gpio@8800 {
+			compatible = "qcom,pm8550vs-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm8550vs_c_gpios 0 0 6>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pm8550vs_d: pmic@3 {
+		compatible = "qcom,pm8550", "qcom,spmi-pmic";
+		reg = <0x3 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8550vs_d_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x3 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8550vs_d_gpios: gpio@8800 {
+			compatible = "qcom,pm8550vs-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm8550vs_d_gpios 0 0 6>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pm8550vs_e: pmic@4 {
+		compatible = "qcom,pm8550", "qcom,spmi-pmic";
+		reg = <0x4 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8550vs_e_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x4 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8550vs_e_gpios: gpio@8800 {
+			compatible = "qcom,pm8550vs-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm8550vs_e_gpios 0 0 6>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pm8550vs_g: pmic@6 {
+		compatible = "qcom,pm8550", "qcom,spmi-pmic";
+		reg = <0x6 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8550vs_g_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x6 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8550vs_g_gpios: gpio@8800 {
+			compatible = "qcom,pm8550vs-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm8550vs_g_gpios 0 0 6>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
-- 
2.34.1

