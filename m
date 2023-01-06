Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2DF6607F5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbjAFUMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbjAFULP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:11:15 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB067FEE5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 12:11:04 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so4357701wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 12:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIVcLPhGW2y+mTG7vdx75MRunoC7E7rBcueTJOw2jNc=;
        b=mqsa1P9jrW7NeuMOeXpkwXVcUA0C+x7jyMVg9ed/e1fkjCnqAyJ1xQycr92VKoVem2
         M8eeRPv6syQN4ro7efD48TdRdbRXWjaJ2zBez92bQc14I2sCN+TbFwuxCDrzunhn42z0
         WIeH/g055/pJprK8ugOgCi8OoVghHILpWIdF1PTGkbUQ4G/ZkhdHOVBxAwSHYQZjIvWk
         Kvd+TDHVxKDLkXxvvvuVukK4dM/rSvhzpj5jFfC7qKEFWI98x//Z/J3XneYZMsTXL9kG
         nrP0EpwGx+ReLNQEaOlosuwehTLNy/ogrpTqLi/SQnDPBUIrLaVbQwBR1evr5kkR3Pqg
         8P+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIVcLPhGW2y+mTG7vdx75MRunoC7E7rBcueTJOw2jNc=;
        b=rMY+wbcyu6A+jFrfhOlkQaRKupFTTBp9XLK2LDmaN1HtxXxMy3HN78l0wYA9x1uXw/
         1rHwjXYP3R6x2OSLpJuZMRjJzv8FQHHQWp+DX1LOb5cZZIc5n8WpUufmt52Lt5MkZgY9
         jSsViv8iDauwPryuUMKUHxzoTiwCxlXB+y25FBrKyRvBeizhsTiXp1/RSZ5mYT2NufHi
         pzDpkeGiFMDp+DalbspspIMqx8tokigxlAvojuMA4Hskg2aLHvcPtjHwjN7wX9NP+weX
         ZXO9ytQFKfm36dIHjGuso9yI6uDpFNU5/hHeeVH7dLfYa7DOH5e23lbmHEq7v5aZmBIB
         frpA==
X-Gm-Message-State: AFqh2koJ+rvqrwm/exXgS4Ou0fOQh1XjlB2UYDaLBqOKRmnWrJniwyLx
        YW9RQL46QngAYLms1+NzLlPeng==
X-Google-Smtp-Source: AMrXdXskyzJWjksK/5B6/MbteYf66V/svXM9C3agge/xOk0t/dF+VsS5EY40SMq68kTlOcpbb5eWog==
X-Received: by 2002:a05:600c:4da2:b0:3d2:39dc:f50e with SMTP id v34-20020a05600c4da200b003d239dcf50emr40241563wmp.7.1673035863376;
        Fri, 06 Jan 2023 12:11:03 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c220e00b003d99fad7511sm2665240wml.22.2023.01.06.12.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 12:11:02 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v9 07/10] arm64: dts: qcom: Add PM8550vs pmic dtsi
Date:   Fri,  6 Jan 2023 22:10:44 +0200
Message-Id: <20230106201047.337409-8-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106201047.337409-1-abel.vesa@linaro.org>
References: <20230106201047.337409-1-abel.vesa@linaro.org>
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

