Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3378A644F3E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLFXBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiLFXBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:01:25 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBA04A58F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:01:16 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id qk9so9985671ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 15:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCy2ZKkP+o5zw4JnVQxbpcd6lL2PTAKfa9gdKzWsPa8=;
        b=XFR0ecn+SMk52LNDfTc5CkyBJUUHk1+DojU7Prr2GtElrXYFDdg/6F3i7E48uB7MXV
         lu+zs4DAyBs/zdL8JvIw2qkW010BiiC+TZnU004S/D0nWwUTchl+f85R+gbUHBuAvijk
         0yVrJ4mjfPsWBj9QC0ZLmXT1Oo6Y1h2kaoBM07lygvQUQ7WFRFy/gjWUMSnfA4NCbBuH
         QzeGtqbn3KietFQN3tV2gY2wcAxvAgsdGw0WLYqIevKd0q+K+4KiTLiK+kEQv9391T0O
         nuP/Wfsge9yRr1ZqlPntpowaIvVoV1Cdpu+OELgB0Kf38pflIRxns4Hq3e0CxwANRwiv
         aojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCy2ZKkP+o5zw4JnVQxbpcd6lL2PTAKfa9gdKzWsPa8=;
        b=qaYFW9pH6LKAHYZjBqNhAFcHYEnz+WJwEWvDbfn1/sFrVRiFUl882GXMWoZMnVk3FA
         bQiUOATVekLCqCcQbLKe8faKpex4v3+DUakU6+YoiNachQHeeuX2HvlsxyIPULC7zmv9
         xYPCW2RVvmgz0i2VO1z7iFcUTjEYLOjmVmwkfNAhzM9pjsNKonbaQ2h9omEpnUwSnWNj
         uO7HH/9Ov2S7ml7yd2vJRbrGW3HX6v79vrQfSQgTowCPS64wiCSnHfqS1qdaJVK0JfNY
         LYfVeC6kAJJvES3SHAUR575rtnV3I+Zbgjs1/Zg0Z5AZdhO32i7/2Z8joJtwu7LSGpDI
         WJkw==
X-Gm-Message-State: ANoB5pmShdJ3BL+euzsnveDZeacLEUjCYN2ng5UvHib0erGCCkOmg4qS
        A42cOlM3sF10FPSIMjBvcSAcNg==
X-Google-Smtp-Source: AA0mqf5h15IXYhGDY6Z1VM66um+DSlb18Ic4XWMV58LUtGphXKtD/ZN7vtscDlRGA+zP4TgZWBUCaw==
X-Received: by 2002:a17:906:2cc8:b0:7c1:b67:2d71 with SMTP id r8-20020a1709062cc800b007c10b672d71mr3900433ejr.346.1670367674906;
        Tue, 06 Dec 2022 15:01:14 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906838a00b007c0dacbe00bsm4239320ejx.115.2022.12.06.15.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 15:01:14 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v7 08/10] arm64: dts: qcom: Add PMK8550 pmic dtsi
Date:   Wed,  7 Dec 2022 01:01:00 +0200
Message-Id: <20221206230102.1521053-9-abel.vesa@linaro.org>
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

Add nodes for PMK8550 in separate dtsi file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmk8550.dtsi | 55 +++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pmk8550.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pmk8550.dtsi b/arch/arm64/boot/dts/qcom/pmk8550.dtsi
new file mode 100644
index 000000000000..47213d05bf92
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmk8550.dtsi
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pmk8550: pmic@0 {
+		compatible = "qcom,pm8550", "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmk8550_pon: pon@1300 {
+			compatible = "qcom,pm8998-pon";
+			reg = <0x1300>, <0x800>;
+			reg-names = "hlos", "pbs";
+
+			pon_pwrkey: pwrkey {
+				compatible = "qcom,pmk8350-pwrkey";
+				interrupts = <0x0 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
+				linux,code = <KEY_POWER>;
+				status = "disabled";
+			};
+
+			pon_resin: resin {
+				compatible = "qcom,pmk8350-resin";
+				interrupts = <0x0 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
+				status = "disabled";
+			};
+		};
+
+		pmk8550_rtc: rtc@6100 {
+			compatible = "qcom,pmk8350-rtc";
+			reg = <0x6100>, <0x6200>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+		};
+
+		pmk8550_gpios: gpio@8800 {
+			compatible = "qcom,pmk8550-gpio", "qcom,spmi-gpio";
+			reg = <0xb800>;
+			gpio-controller;
+			gpio-ranges = <&pmk8550_gpios 0 0 6>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
-- 
2.34.1

