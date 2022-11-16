Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7D762B9C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238608AbiKPKpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233719AbiKPKoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:44:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C17C32B81
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:32:30 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1154333wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXGEEgZKJBWa8C/rhY3g+R200GQq5Ds7ySOfHwjfhow=;
        b=qHqSZfWZyABjzwKchlejuEOXtVQS2sevYxzBN3HLOsAQFiWQu6/qxZDBHSI/Op50Vt
         TUJu9Km1qAo10FRJeohvUTsPNsPqMBkd7xM/WFx0qrfqftkdoz59yuEGPHs7BOHk31aV
         w7Lcc1lrNosvsSW9Ky1VW1XLY0Hq6wluvAkbaSKlzjo5fNx7yjpmjMe9n1qQtC2B7JmY
         R60YoS8bNxXETss+f9CPmpfgh96eIoRe7CZHMNBDAdYfOr599xZU7voXJ/p4CrKcoL2K
         Rx4TiUCPKQApIoi6+XOown4LIvm7H1uUPgnDIdWYaWz36xjFPIUQZWlUO07xpS9yF8fN
         It1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXGEEgZKJBWa8C/rhY3g+R200GQq5Ds7ySOfHwjfhow=;
        b=8IanijegP4XdK2RwjUnM8pp7bvTHKzQlXCilkcQWb1TUeDwPqmMJ9L619bwC47WcmS
         Cu0VYwDuYp8RrvrdrXldPMnQttwACECRUPps2NLkZoeQ3QJ0GhcVMOtcm1rTGP64U6Hs
         2QJ0Q7HsrDtzuhdrvSRTgvBhXopvJ8p6P5He73R4d5ND63ysr+9DfY5kAtGcC8zK8ro6
         nwSqLio/h2C/ImPlkNHeOx2eOXfeJU/Vwv2Heyz8VwV1fDbVGMEMnEF9Jy6j5vWAdJDy
         zNCzzQjtkfDEl/u/1SkJ92TRpblcZoF/vSCPXhHFkuneTXzjlg70cOq1jPH1uRs6DGCQ
         XOWg==
X-Gm-Message-State: ANoB5pmJ7S88HcxD0dRzBlh15a5FbSw7XpdTSJlyykIjbsxoiIbcmH8q
        /9GtFw4FxhFTl9hVChJK41IZog==
X-Google-Smtp-Source: AA0mqf4CCKSzlShgV+eSdQuFLluWXvTg8/q9bQESmyikcfweXk7rnKJ80Irt4k6QclFR8N0B9xEjHA==
X-Received: by 2002:a05:600c:54c2:b0:3c6:bf5c:a325 with SMTP id iw2-20020a05600c54c200b003c6bf5ca325mr1684136wmb.54.1668594748777;
        Wed, 16 Nov 2022 02:32:28 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id bh9-20020a05600005c900b0022e36c1113fsm15107032wrb.13.2022.11.16.02.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:32:28 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/10] arm64: dts: qcom: Add PM8550ve pmic dtsi
Date:   Wed, 16 Nov 2022 12:31:42 +0200
Message-Id: <20221116103146.2556846-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116103146.2556846-1-abel.vesa@linaro.org>
References: <20221116103146.2556846-1-abel.vesa@linaro.org>
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

Add nodes for PM8550ve in separate dtsi file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8550ve.dtsi | 59 ++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550ve.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8550ve.dtsi b/arch/arm64/boot/dts/qcom/pm8550ve.dtsi
new file mode 100644
index 000000000000..c47646a467be
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8550ve.dtsi
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
+		pm8550ve-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8550ve_temp_alarm>;
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
+	pm8550ve: pmic@5 {
+		compatible = "qcom,pm8550", "qcom,spmi-pmic";
+		reg = <0x5 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8550ve_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x5 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8550ve_gpios: gpio@8800 {
+			compatible = "qcom,pm8550ve-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm8550ve_gpios 0 0 8>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
-- 
2.34.1

