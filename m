Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FCB6C1AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjCTP7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjCTP6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:58:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DDE5253
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:49:22 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r29so10796150wra.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1679327342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IV/5gf3WuHS5WSbPyj0Moqs6nXNECY+AJ0WjEElkQo8=;
        b=U04Eg/UE/GvHsB3PJEkXCYzKKl633WkkmhWvrwAkuPXvqf9cqu9lHQX7BDVH8pkujH
         5htRWF74ADACFKWUT71UKengwFkV1MOxaMuNu6cqnutWL7TyHZOw2RUB4629y7Wfqjib
         AGmb44Z+cetgwyssRLAL1wZF3oCixfYCsHHd0BsUla9Scu9LH54c39u0UaGw3Zh/oS2o
         p5nqeyajzuUxOAxGHRivWQ3iGwKwtA9mPiCOm2mIHlpfTyPhftt9GZW4CDprQseTdxET
         XNm+M3QBQ1tpLOQfKAepjm9zJKCi7KfbctM7reh/qbOzeCYn7mH0KEzLJu2c0VAVa1kk
         b0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679327342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IV/5gf3WuHS5WSbPyj0Moqs6nXNECY+AJ0WjEElkQo8=;
        b=TaEmRMBWYECjnEUwg+DCAPsauIGG41krtOHmUcSFtPd8O0Fja70aGdY3IU1A8UMCnA
         Nh3qVUO9PM1YPVDoVKufmdmfUQGnQ4by/l5WXiOF4NnMbXO8ZpXWQO3LIeELmHI7FnL+
         6gimIDAZt8JtKjS9LcTvfta66oCatsW/wy3ibfuiNzJTEwMz8ZRN1t0nFemSl98/hH6+
         ZnvabYLHCZm5/hXFBJs7JjkTNBvcHCjKtKdcwkgzmPM1GZgizHO8Y+nR2lxBWdV39TFi
         j1UTg2DPyBVdMceJFp6asVuHHbkF6cIoILAiq163UKA2IgHoSdg/p19MyCrsNT9sBg+g
         LHhQ==
X-Gm-Message-State: AO0yUKX8T2K6xoGXanrkOv6BdiX2C6pSvOTuD/yuPi3dcOOZDjyEZ3eb
        SgrKK0DApZLVE+owhj5nSAOFNw==
X-Google-Smtp-Source: AK7set+lb5fjsl03ZnYIL/Mgm+EDOV21Xc69FH7FdvPo46Cc4VLFOeNr4Xvvt6PcbL/RYaKJMk9dxg==
X-Received: by 2002:a5d:6b0e:0:b0:2c3:db98:3e87 with SMTP id v14-20020a5d6b0e000000b002c3db983e87mr14679713wrw.20.1679327342696;
        Mon, 20 Mar 2023 08:49:02 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d7d9:4f38:38b4:82b4])
        by smtp.gmail.com with ESMTPSA id o6-20020adfeac6000000b002c71a32394dsm9202578wrn.64.2023.03.20.08.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 08:49:02 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 12/15] arm64: dts: qcom: sa8775p: pmic: add thermal zones
Date:   Mon, 20 Mar 2023 16:48:38 +0100
Message-Id: <20230320154841.327908-13-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230320154841.327908-1-brgl@bgdev.pl>
References: <20230320154841.327908-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add the thermal zones and associated alarm nodes for the PMICs that have
them hooked up on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 58 +++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
index 8616ead3daf5..276070b62ccd 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
@@ -6,6 +6,50 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/spmi/spmi.h>
 
+/ {
+	thermal-zones {
+		pmm8654au_1_thermal: pm8775-1-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmm8654au_1_temp_alarm>;
+
+			trips {
+				trip0 {
+					temperature = <105000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <125000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		pmm8654au_3_thermal: pm8775-3-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&pmm8654au_3_temp_alarm>;
+
+			trips {
+				trip0 {
+					temperature = <105000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <125000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
 &spmi_bus {
 	pmm8654au_0: pmic@0 {
 		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
@@ -41,6 +85,13 @@ pmm8654au_1: pmic@2 {
 		reg = <0x2 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		pmm8654au_1_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts-extended = <&spmi_bus 0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
 	};
 
 	pmm8654au_2: pmic@4 {
@@ -55,5 +106,12 @@ pmm8654au_3: pmic@6 {
 		reg = <0x6 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		pmm8654au_3_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts-extended = <&spmi_bus 0x6 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
 	};
 };
-- 
2.37.2

