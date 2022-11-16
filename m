Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D540A62B9C0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbiKPKpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiKPKoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:44:24 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCDC326F2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:32:27 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so1129740wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iftMMDgL5S/VcToy3kI7H5qJYfE9y0xN9U7Vhz0XQVE=;
        b=jrNZFvP90tHBOF9ihO/R34sycyGtdTqa1Ta58Q28ft/08fuNjLtGsY/9j3krvbxOw4
         JYoVWuaba+FJb1b3S+PZx4ucy9nHdkPd7mTqNja5Wf4JUNTBKvzqxOiGWtgKk5DWOch0
         5fpp8renakEMn9GfNRxm82TDHnMG5wRnm8uz9mcqAqmhI8/ziwaOl0tdFNWD2CRCqtny
         /4gINeKIFYnwOFYxhKMglBwplPOBlB9U8UI4002Ns93HyYrwQIc44Np/+VWg4p2asqWF
         iWteVijJISUas4QKX0AaaqG67E8lauSSACwTrCJnT+kUoUBIWzznc8jYdcDaFQK/fUX4
         qQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iftMMDgL5S/VcToy3kI7H5qJYfE9y0xN9U7Vhz0XQVE=;
        b=5Q8ncWtmJJmyKV4b8RCWGDel2kXAVhu8eAYJqU69j53CiZU6Ry/moGWGHf7dM7v3xL
         ng9/iTSuo4n/6R4i/mS6na9JK/4h5N0avk3wHoO4M+wc6Fl5J8U7P1LJHaunqzRDBgLp
         TF+4uwDxktua7P3zARFqFnFbUBnAOnRePm+R4L1IdXbdClLcQvN5RaCQY9IOMQBvHjDb
         aI8xYaGz9z7fGIYwa0VMiYL3STzUEoX+oVY+mITlnfrqlEoedhckD07b3LMLQlzCXyut
         WzcGPU4Fy8AX4ej17FvEMgr//QWkFd9jQwdDPVmkl1vC/6IDdJC59uYpVHQY48F1YzVY
         OwqA==
X-Gm-Message-State: ANoB5pluwxAdSEeM+2fzbvGnbI7gqzoViGMVGwf3Y9T8ylSBgRQGG5pz
        9KdityBRu+xknGNIz78p1/pjiw==
X-Google-Smtp-Source: AA0mqf4ICLiEJfHLnudf30i8CATkmLy7kKY5FH0rb6dMEwMzFhvGzc3nuHzquLDS/LikqDKrWeWQlA==
X-Received: by 2002:a05:600c:4d86:b0:3cf:6a83:c7a3 with SMTP id v6-20020a05600c4d8600b003cf6a83c7a3mr1613570wmp.21.1668594746285;
        Wed, 16 Nov 2022 02:32:26 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id bh9-20020a05600005c900b0022e36c1113fsm15107032wrb.13.2022.11.16.02.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:32:25 -0800 (PST)
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
Subject: [PATCH 04/10] arm64: dts: qcom: Add PM8550 pmic dtsi
Date:   Wed, 16 Nov 2022 12:31:40 +0200
Message-Id: <20221116103146.2556846-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116103146.2556846-1-abel.vesa@linaro.org>
References: <20221116103146.2556846-1-abel.vesa@linaro.org>
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

Add nodes for PM8550 in separate dtsi file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
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

