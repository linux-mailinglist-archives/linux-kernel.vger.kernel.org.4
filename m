Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3263659BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 21:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbiL3UXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 15:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbiL3UWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 15:22:49 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5651C43D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:22:47 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id co23so20686608wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 12:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFy4mpBpGJLVajWjtu3C2lS5gW1c9EpDqZmyzJeWXJI=;
        b=ZEEynkzOp/Bvt3TxAqfS0w9XKQiQuOBYFHIvCLMwrvSVVa98TrOh5SDGJSDNkkOfcg
         nIwMSk2MJ00WuOeD3eVD6QzEwY6gsRj/7VNsJbtbHWD4OeosSZE7wrABNSpEBXfdAqRY
         zmj5dj2aRJsCflpkrEx+fRQysndO/2EyE6m6XNlFOuxSw5OHqVOkk+RJi9rz1/LTVB65
         v/i4Jb1OBueMqmcQaWqtRWZTrYd9afNrqI5PFAOqGkdnHTCFVU5H5tT3m/PWFUJxl74O
         CM52tRHYJ/LCSVeOaBngFPwKdVxstPVRg4kiTYyIWGF95WUvaBNr+38xYDVIKBTxlvYo
         Asbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFy4mpBpGJLVajWjtu3C2lS5gW1c9EpDqZmyzJeWXJI=;
        b=ytARZWVkxToOA61HxOeFdbSE+M1V0DBdg+oHVK1hRwLP85FIMcJwsA13yPerke8yH9
         gHoM73JwD4XFcBAKzNiQRhOIuOI7hnzkEK+6WX3JGYzZr6zYXwAWHCvJVJt0dFRqvwT8
         oi/aDOJ/HZLhXmI2o2vHoZBpIbkd/f+hRP4XJ3fsqMlsOO/1aJsYXu465YzIBI1T8Ngu
         dWUjGpLcMSyffq1lbi5QKSToAhu6u6PRFXcWLOOJGDZWRGRBvBvIY9MtYex2GFAAy85K
         4kyr4UHyGWbf6RewWpAiMC50gvjWqFOWwBpU12++BMOPkDoEkgQ09n7TtCKUfb6pR041
         1XIw==
X-Gm-Message-State: AFqh2korfJ5aD737adS+9VvF4dsIYZHDuW2XMEwHZXhyR0+g4LV0y6Pu
        M0IxPs2OKooby+kI+clAm7jhH1j/+AtdXiu4
X-Google-Smtp-Source: AMrXdXuNf2/kLt2MOAefpX/Fix9eY4WrnFpaoc+9HwrKMdh3oyhVSJhkirRRqdH146qeUJb/YWPJKA==
X-Received: by 2002:adf:f043:0:b0:26a:6d87:559a with SMTP id t3-20020adff043000000b0026a6d87559amr21204616wro.53.1672431766294;
        Fri, 30 Dec 2022 12:22:46 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id z1-20020adfdf81000000b00268aae5fb5bsm21359142wrl.3.2022.12.30.12.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 12:22:45 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v8 05/10] arm64: dts: qcom: Add PM8550b pmic dtsi
Date:   Fri, 30 Dec 2022 22:22:25 +0200
Message-Id: <20221230202230.2493494-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230202230.2493494-1-abel.vesa@linaro.org>
References: <20221230202230.2493494-1-abel.vesa@linaro.org>
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

Add nodes for PM8550b in separate dtsi file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8550b.dtsi | 59 +++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550b.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8550b.dtsi b/arch/arm64/boot/dts/qcom/pm8550b.dtsi
new file mode 100644
index 000000000000..16bcfb64d735
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8550b.dtsi
@@ -0,0 +1,59 @@
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
+		pm8550b-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8550b_temp_alarm>;
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
+	pm8550b: pmic@7 {
+		compatible = "qcom,pm8550", "qcom,spmi-pmic";
+		reg = <0x7 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8550b_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x7 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8550b_gpios: gpio@8800 {
+			compatible = "qcom,pm8550b-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm8550b_gpios 0 0 12>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
-- 
2.34.1

