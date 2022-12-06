Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A645644F31
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiLFXB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLFXBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:01:15 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACAE4A580
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:01:11 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id kw15so6519541ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 15:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiSyzj5bxhBZ228Fs3MQ7cHv3+MhOBcyO/fL/boI7rc=;
        b=PrG/9mwNwfJUcG0k/OLLvoTzFgIZC4DrTrYYknuygAgCEb3KeNS9Z64RqJrF8Z+Is8
         tStBztdJwcCmyMdB3yWdg7jI668IBGB2JuSyKU0s49cJHaAA+XHS35sAg12Sv7inabT5
         IdlYUzqDCSmMEq3qD6YUp3t9whT0nUeg6/fo0R+krgGSdpIJW9P+URVAxAMTDd806/W3
         uR1qfesG+dETd13MPTLfJwY8mErG3q62lZ/sOkezP3xUQGTDNT/j9mri7nf7XXninnRx
         1JeGBqfLkRVbHKZ7VZ+qJg8fvjj5ubcGG1uZc0aRs2GEV2x/QreL31pQvD/AZGF5tUH1
         VBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiSyzj5bxhBZ228Fs3MQ7cHv3+MhOBcyO/fL/boI7rc=;
        b=Tb3eU0fM9/uqiB9+FS3AdOqWdL6iNovcEfT3izxlkz2sGhHapGuslSVktjF01w+vTi
         X7djLNnfn1UQMe4SpQ2noSLq2cEpY6T7zAruJCasHXbk+kmWBSCvJlAqYMl/xCSC0Xjb
         /lRbYPEqzQ9GMGkm1bTrRHxtQRB/kYzWAj7ZFtGYtRhUgHn2KLUH9AosnisR0suuXALE
         O4d7uTja454d8WLLVDx3c4EWjnUgn8zI05msDoNkWu7PIZwnjAhpKLDbX6GMk2O2TEiK
         0cN2VovvS3lOBxN5EnRfyIaXfVqfBjK1OZr0BJvwo4MJ7f98O07NQ0YXgbeWLL1BE3sg
         Vekw==
X-Gm-Message-State: ANoB5plqDEuH8CU+XBbsdlzPAMa9aJVta0I/CgQXNX9wIR1gKqUkR4eu
        5RAsYusZE3pCOt1QbglNWs5OTw==
X-Google-Smtp-Source: AA0mqf5cyhLO9jnnFH8s3btEuFkq1L8uzfzlOj/PewZIuuY+Wy3RaTxOGSwDJBFHo8LvizKcmT+zlQ==
X-Received: by 2002:a17:906:3b11:b0:7c0:cb36:d6eb with SMTP id g17-20020a1709063b1100b007c0cb36d6ebmr15691254ejf.736.1670367670470;
        Tue, 06 Dec 2022 15:01:10 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906838a00b007c0dacbe00bsm4239320ejx.115.2022.12.06.15.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 15:01:10 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v7 04/10] arm64: dts: qcom: Add PM8550 pmic dtsi
Date:   Wed,  7 Dec 2022 01:00:56 +0200
Message-Id: <20221206230102.1521053-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206230102.1521053-1-abel.vesa@linaro.org>
References: <20221206230102.1521053-1-abel.vesa@linaro.org>
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

Add nodes for PM8550 in separate dtsi file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8550.dtsi | 59 ++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8550.dtsi b/arch/arm64/boot/dts/qcom/pm8550.dtsi
new file mode 100644
index 000000000000..46396ec1a330
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8550.dtsi
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
+		pm8550-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8550_temp_alarm>;
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
+	pm8550: pmic@1 {
+		compatible = "qcom,pm8550", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8550_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8550_gpios: gpio@8800 {
+			compatible = "qcom,pm8550-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm8550_gpios 0 0 12>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
-- 
2.34.1

