Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4C76B9E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjCNSbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjCNSbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:31:21 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C491E6486A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:31:05 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m18-20020a05600c3b1200b003ed2a3d635eso3099205wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678818664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQCJ+X+YEuYse0CeSshHt8sWYxstXZuzTDTR56rfWH0=;
        b=wMx91kjMzpT4ihmd6YPGDQBW1ZtNyRDXuEqTIp6J/E8+b5atPQw8p64KjONZ7NneTO
         F3V2KVC/YZlMyP+AFqzwYnrdFFCnEHr5MpVGeURUGsSICg6WcE3xHBWL+ItA6igjDrFt
         hOdjKuhC9HdHBWPNwSl9rT7KzFSBOrPcQtX6vBYK5nAeEQzSYPpjYZ70H8CxeyVxUGSI
         nuiZKuxIsvdgrt97m2JHo8wUrhCc+DpY2F3D4U6NRlb7eTK2m38DC50kVlpjFXBx/Fiw
         vUM0aHoRel7WOPFK6Y3kIfWxMePr3k5UOXJpWFJvChZHZI4n1K7pEbgIGSdA2GSInZf8
         hjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678818664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQCJ+X+YEuYse0CeSshHt8sWYxstXZuzTDTR56rfWH0=;
        b=uhFfbroBI/k0xZXJfQCDSoNf6VfnOulUl4FZP4h69W1ffXdmoGF6UMQykU6PFPaq1A
         ry2tVdMtZQ1G5W9AGPII5+0jUbI4bTyOmG/cYHR2QyG4HRSyHvGSwG7+Vn7NZKR+9V8i
         o3m2LgUpmp2cC8ZzUwjSgYwpMv26H7V3MjBFJyUVNLP4x6eIaeujm/EpV26Cq/G2bXKG
         FM6cB/vdNGNAydexSwKUc9IugmeyaixRUMrY3ad+qMA2MMDQFl+jDZi4atN75FwJZBxr
         lFUad5GIwge+B27vhzj3X+azHJHERHO0gaDfZPlw92krZl/GtkxFdZGaX4EYBLu2s+1S
         eh8w==
X-Gm-Message-State: AO0yUKXrFYHKnVk1JLTAHj0GW0eHjGlPBH1fDxg9quuKEY5usU/atRqt
        kAtYNKbfBD9E71JRzCI90rv3fw==
X-Google-Smtp-Source: AK7set/qeIP/8mMepwcAWReZMB1wCc+hQ0lBM+LFouWcxDbfUe/Z3N0OOwLjfvtmbsdj9KUOBUW8fA==
X-Received: by 2002:a05:600c:1910:b0:3ed:22fb:c87 with SMTP id j16-20020a05600c191000b003ed22fb0c87mr8921801wmq.5.1678818664176;
        Tue, 14 Mar 2023 11:31:04 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:fd14:bd52:b53b:d94c])
        by smtp.gmail.com with ESMTPSA id k28-20020a05600c1c9c00b003e209b45f6bsm4083938wms.29.2023.03.14.11.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 11:31:03 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 11/14] arm64: dts: qcom: sa8775p: pmic: add thermal zones
Date:   Tue, 14 Mar 2023 19:30:40 +0100
Message-Id: <20230314183043.619997-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230314183043.619997-1-brgl@bgdev.pl>
References: <20230314183043.619997-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi | 59 +++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
index d55fa5165864..437cfa8aee2f 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p-pmics.dtsi
@@ -6,6 +6,50 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/spmi/spmi.h>
 
+/ {
+	thermal-zones {
+		pm8775_1_thermal: pm8775-1-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8775_1_temp_alarm>;
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
+		pm8775_3_thermal: pm8775-3-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8775_3_temp_alarm>;
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
 	pmk8775_0: pmic@0 {
 		compatible = "qcom,pmm8654au", "qcom,spmi-pmic";
@@ -16,6 +60,7 @@ pmk8775_0: pmic@0 {
 		pmk8775_0_pon: pon@1200 {
 			compatible = "qcom,pmk8350-pon";
 			reg = <0x1200>, <0x800>;
+
 			mode-recovery = <0x1>;
 			mode-bootloader = <0x2>;
 
@@ -39,6 +84,13 @@ pmk8775_1: pmic@2 {
 		reg = <0x2 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		pm8775_1_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts-extended = <&spmi_bus 0x2 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
 	};
 
 	pmk8775_2: pmic@4 {
@@ -53,5 +105,12 @@ pmk8775_3: pmic@6 {
 		reg = <0x6 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+
+		pm8775_3_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts-extended = <&spmi_bus 0x6 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
 	};
 };
-- 
2.37.2

