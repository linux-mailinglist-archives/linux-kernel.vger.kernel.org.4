Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE892612060
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 07:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ2FPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 01:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJ2FPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 01:15:24 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBF25FAF7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:15:20 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so9023742pjh.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 22:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvKcD3l6/5U/0zNEk8IHW582eq6MJZUcXiJ8kdr7C7Q=;
        b=L6lV10orwhzNyzEtNBShFwUInB2CLYL9Ag5+S8uS14i2ILFIWCCS2zhDdr7lAVkjuP
         bvVTyNH1neNo7IbPr5sSuNTGl28gNA3FM+ociY+KsuAAV7Wt+jg0PMZy+wSGjRoE/y7G
         kxRS8smVY6QVglzKxMrU3xWa/YT7xNyR5i47GQjs1bGl77eyggzwJc+l6EWgfU+HYhW/
         s7CRX1jIe2pa6RAxIiP91PRswbrliu1SIE6Ba66YhEQ/R7n/Vsf6btwKqOFDo1oKwraj
         HNqKeOBR5Lu9alxiVDYZlXz8fAiiEGOG/QfWoGQKMGg/FjvNyWH57GfMxdLiI0oYoxLA
         tjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvKcD3l6/5U/0zNEk8IHW582eq6MJZUcXiJ8kdr7C7Q=;
        b=vyXY0N+hjLpJG471tBoEQeVn62+Prpw3yXSbfWRJZUFfsF6gcdBlgWRJ/Wwk/ZtrOi
         4hUhqBwE+WvzC5Ntz65GTBWO1wyy+rxdIlUkvUwWfG60sEyJvE031aXuZZrkAI5bvYiR
         vIhNn1uFedAAPoVabjNPJueD0spKXRse61DPe47JOQaCHdIbgL9ir4laomDSEYrv0l/v
         Xmg0VOxLDqv298gryXQofN8q993AqEESCJ9w2jPIL2oFhFtwfb/lHCCf7bd3pIa41ToZ
         r3MnuvDsAnhXa68QPZtR1hVRt9lgm4ly9dC9vqfAupVn+1IuxkgJ8jcELHDihDfK1TMn
         Xanw==
X-Gm-Message-State: ACrzQf03YeV9Jzt4tJuEE9mrsmtS0vSMQn/YTDXCgSXl255SloHbE6Ej
        gF47AAf+uRiU7ThicFaf5D6X
X-Google-Smtp-Source: AMsMyM6H9Ftr3BYbSd1RofzbaeEoisIRGSgo19CwBFMXqIz2RLgJVrJWTTzgq1KoGTDuXGzYstKcMA==
X-Received: by 2002:a17:902:bb98:b0:186:988d:a0f0 with SMTP id m24-20020a170902bb9800b00186988da0f0mr2755451pls.10.1667020519823;
        Fri, 28 Oct 2022 22:15:19 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.167])
        by smtp.gmail.com with ESMTPSA id f5-20020a170902ce8500b0017e9b820a1asm363150plg.100.2022.10.28.22.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 22:15:19 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        steev@kali.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 03/12] arm64: dts: qcom: sc8280xp-pmics: Add thermal zones for PM8280_{1/2} PMICs
Date:   Sat, 29 Oct 2022 10:44:40 +0530
Message-Id: <20221029051449.30678-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
References: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
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

Add thermal zones for the PM8280_{1/2} PMICs by using the temperature
alarm blocks as the thermal sensors. Temperature trip points are
inherited from PM8350 PMIC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 44 ++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index 5de47b1434a4..397ff4995003 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -7,6 +7,50 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
+/ {
+	thermal-zones {
+		pm8280_1_thermal: pm8280-1-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8280_1_temp_alarm>;
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
+					type = "critical";
+				};
+			};
+		};
+
+		pm8280_2_thermal: pm8280-2-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8280_2_temp_alarm>;
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
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
 &spmi_bus {
 	pmk8280: pmic@0 {
 		compatible = "qcom,pmk8350", "qcom,spmi-pmic";
-- 
2.25.1

