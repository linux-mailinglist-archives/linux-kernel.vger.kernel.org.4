Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CBF637ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiKXN6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiKXN6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:58:02 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAED12E223
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:57:05 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so4547005wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X81SH+RvtQMdJQyeeQQaEGGr7kZrUwq921y0hQmKIlM=;
        b=Y93QpfpBRa8z2B9SXGt9UosHxoJlzmYBGBwYSxFAPurn2YSOFq6RHZyl109ptccqW+
         xrB5EPJTMhABgI5uOWpNw6AMTm9I9XHXvZi+QAH9wnzZujnEikDusZnMfGBAErtaV1Fv
         s6H/DspGiv/XTNQJ9zcaGgyqbCAhuEhKKvOo3C68rFPXUXHprrNlfsWqc1/6/fr4Lqo5
         dCc0JI1eCLq+ddYDMRVIbhclTQlJD+sqjfVGJj/XeuR1/YXMNcClZBB6UbhkdDq1X/AT
         cRMAK9Abtcy/Op2wvFqFqT3TpYEK9IOwF4+c5YFHy9O8C+UllMVbCDb21Tdctgs0rP5V
         stXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X81SH+RvtQMdJQyeeQQaEGGr7kZrUwq921y0hQmKIlM=;
        b=dj75dbVci2Y/kalLpX/EHL9XLMDU6I0g/iM7cQvGW+WOJBBKMDzWHKdiznwccxiDeB
         GYcTT43m7gbe0mw5ZFdE8+CIZC9XMiSQ4q2dJ17j6I7UVUguAOdlD3G0V9HllFDAekZa
         XHFwl2pLoSXAb0f9sea+TM6ELSuQb3xK4r7NcNhs389rVNDIcr+kna4Qr1y4GvtQemv3
         82W8Ugr09+ysZIonNAtN9ti1NSy+PwlAph22tsq0FlrHdqW+rrXAdj1LuBwK9Uj+5hhb
         c7JbsQCfJAbO/J86cu1LlVXKHYrCxUEHpywGdklLgToAr8gs94wcxmjXxGIsHh+futsH
         fqgw==
X-Gm-Message-State: ANoB5plopoZI80hQ8aTzP+aiUiBKjCydRwWYvLWluFlwOpWdwGzE3c5s
        m7n8qvdb7+kPMXOCZezRFsgazw==
X-Google-Smtp-Source: AA0mqf6vidJoAhs8CtXm5tdiARpJxztFkO/2AtNGN9MgSwaeuVYYGlk6+rtZJ0DdTHEVeKpxFqNx2w==
X-Received: by 2002:a05:600c:a0c:b0:3cf:a851:d2ef with SMTP id z12-20020a05600c0a0c00b003cfa851d2efmr12903589wmp.88.1669298217908;
        Thu, 24 Nov 2022 05:56:57 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v14-20020adfebce000000b00241d21d4652sm1414322wrn.21.2022.11.24.05.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 05:56:57 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 05/10] arm64: dts: qcom: Add PM8550b pmic dtsi
Date:   Thu, 24 Nov 2022 15:56:41 +0200
Message-Id: <20221124135646.1952727-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221124135646.1952727-1-abel.vesa@linaro.org>
References: <20221124135646.1952727-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v1:
 * added Konrad's R-b tag

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

