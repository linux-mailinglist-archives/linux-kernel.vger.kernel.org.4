Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895F16E608D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjDRMCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjDRL7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:59:50 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D31B474
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:57:02 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id r9so16240263ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 04:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681819021; x=1684411021;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mjhT7c5vpFQRJS8nwL3Z88wTyDAD+eZRtyY5BOWpF+w=;
        b=zE8rNev5UcDJboxw+q774X9yDzzU1rT3+U0tnvcPA7hjqzUVSHdPAxHW+C1wK7HdSJ
         F6rtP+MYJQQHG2vydiX6toLHpkg4WJTV526V6HQWOhcEOqwS8Y5v1U8faPPrjJhaiII1
         Qxgr/gp55oA8LhlzVnh6ULHbD+/VzWWuU8w8mr2InLw7Nq/7VPOV0z46MV9Aja+TzCJZ
         9YUtB3R00ECK6g78OsjZ/MqcSUYZK986JmNYHUKHaDtaS3yqNVseEEcLcaKEtUmAHrk/
         dtdemxHeLzOB6AgvosavSlu9kP/hQnLFj/oGDA+MU+/BN4JEqzOT1cgUqpIS2WZbHF8t
         9B4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681819021; x=1684411021;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjhT7c5vpFQRJS8nwL3Z88wTyDAD+eZRtyY5BOWpF+w=;
        b=bRtkH72v55ILJJgvLe+MZ8LfbOhanYtIVlFe//d/QcYDFU0xT+rwNMs3Fnw2chCcG+
         KTWXy+cGaG1+CJST0Wp0DzXnSNFu44w0l0tSI0nPY8VrAfp5lrAnzwDW2bLjtKOR7rz5
         PoApxq98RtzuuXCC0Lavp0/p7TocEUjwzvgrtwXoXyR6vtewNPnKdoRfJvEibFobzdtF
         Y4KxjB0cJrBi0l8QTE7+bAmzqd09XWbIP63mwPxx/wcZikt005vkkx0BY04HpYWj4gvR
         S5Rv3nNv2RBkzyx0pQisutyikt8hzanwnNE1iKNIHU3sHjmVC/KGBhFApR6eH3UdW42u
         Ai5w==
X-Gm-Message-State: AAQBX9fJS9NH4cJAelkZCKKE5rd69v9GX4Lji7RCJH3fxA+KFG6y8wqO
        U07EIVQRPtk/5l0li89DbIU7HA==
X-Google-Smtp-Source: AKy350YWAf8ZWRkhimz4yUkdQ1xEmjTrsRRXXfQoNJVQJkLdcR+DmAPJZnHF+XYSTYDStU9r6OJtig==
X-Received: by 2002:a2e:998b:0:b0:2a8:ace6:bf80 with SMTP id w11-20020a2e998b000000b002a8ace6bf80mr725460lji.8.1681819020917;
        Tue, 18 Apr 2023 04:57:00 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id 2-20020a2eb282000000b00298a8527806sm2550121ljx.93.2023.04.18.04.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 04:57:00 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 18 Apr 2023 13:56:56 +0200
Subject: [PATCH] arm64: dts: qcom: sm6115: Set up CPU cooling maps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230418-topic-cool_bengal-v1-1-c5d53814dc74@linaro.org>
X-B4-Tracking: v=1; b=H4sIAIeFPmQC/x2N7QqDMAwAX0XyewGt7vNVZEibpRooqbTbEMR3X
 9jPOzhuh8pFuMKj2aHwV6pkNehODdDidWaUlzG41vXt0N3wnVchpJzTFFhnn9DFc+zjcHWXO4F
 1wVfGULzSYqV+UjK5Fo6y/Ufj8zh+EDZ0o3gAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681819019; l=8208;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=mw3YwshvzeBPE3qS+R34Cnn7pe3SKVF9EwUI0dpQdR4=;
 b=Gus7uJvwBLIkNjA59xMMfkZ/SLrqjhK7dV5Zhx8X6uTBzRvIN0rycgFhNT2dH9yUhgbdlY+fmy9/
 etJ8mFk+B2JZq3fF1bl53opkOOS5+y4HPUFHTKd4qgvruiQ4OWil
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set up CPU cooling maps to ensure the thermal framework is aware of
the connection between the CPUs and the TSENS sensors.

All of the maps refer to all 4 CPUs within a given cluster at a time,
as that's what can be considered the smallest DVFS target unit - they
all share the same voltage line and clock source.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 137 +++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 631ca327e064..36ff913c1a60 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/thermal/thermal.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -47,6 +48,8 @@ CPU0: cpu@0 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
+
 			L2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -63,6 +66,7 @@ CPU1: cpu@1 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
 		};
 
 		CPU2: cpu@2 {
@@ -75,6 +79,7 @@ CPU2: cpu@2 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
 		};
 
 		CPU3: cpu@3 {
@@ -87,6 +92,7 @@ CPU3: cpu@3 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			#cooling-cells = <2>;
 		};
 
 		CPU4: cpu@100 {
@@ -99,6 +105,8 @@ CPU4: cpu@100 {
 			dynamic-power-coefficient = <282>;
 			next-level-cache = <&L2_1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			#cooling-cells = <2>;
+
 			L2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
@@ -115,6 +123,7 @@ CPU5: cpu@101 {
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			#cooling-cells = <2>;
 		};
 
 		CPU6: cpu@102 {
@@ -127,6 +136,7 @@ CPU6: cpu@102 {
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			#cooling-cells = <2>;
 		};
 
 		CPU7: cpu@103 {
@@ -139,6 +149,7 @@ CPU7: cpu@103 {
 			enable-method = "psci";
 			next-level-cache = <&L2_1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			#cooling-cells = <2>;
 		};
 
 		cpu-map {
@@ -2471,6 +2482,24 @@ cpu4-thermal {
 			polling-delay = <0>;
 			thermal-sensors = <&tsens0 6>;
 
+			cooling-maps {
+				map0 {
+					trip = <&cpu4_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&cpu4_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
 				cpu4_alert0: trip-point0 {
 					temperature = <90000>;
@@ -2497,6 +2526,24 @@ cpu5-thermal {
 			polling-delay = <0>;
 			thermal-sensors = <&tsens0 7>;
 
+			cooling-maps {
+				map0 {
+					trip = <&cpu5_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&cpu5_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
 				cpu5_alert0: trip-point0 {
 					temperature = <90000>;
@@ -2523,6 +2570,24 @@ cpu6-thermal {
 			polling-delay = <0>;
 			thermal-sensors = <&tsens0 8>;
 
+			cooling-maps {
+				map0 {
+					trip = <&cpu6_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&cpu6_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
 				cpu6_alert0: trip-point0 {
 					temperature = <90000>;
@@ -2549,6 +2614,24 @@ cpu7-thermal {
 			polling-delay = <0>;
 			thermal-sensors = <&tsens0 9>;
 
+			cooling-maps {
+				map0 {
+					trip = <&cpu7_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&cpu7_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
 				cpu7_alert0: trip-point0 {
 					temperature = <90000>;
@@ -2575,6 +2658,24 @@ cpu45-thermal {
 			polling-delay = <0>;
 			thermal-sensors = <&tsens0 10>;
 
+			cooling-maps {
+				map0 {
+					trip = <&cpu45_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&cpu45_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
 				cpu45_alert0: trip-point0 {
 					temperature = <90000>;
@@ -2601,6 +2702,24 @@ cpu67-thermal {
 			polling-delay = <0>;
 			thermal-sensors = <&tsens0 11>;
 
+			cooling-maps {
+				map0 {
+					trip = <&cpu67_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&cpu67_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
 				cpu67_alert0: trip-point0 {
 					temperature = <90000>;
@@ -2627,6 +2746,24 @@ cpu0123-thermal {
 			polling-delay = <0>;
 			thermal-sensors = <&tsens0 12>;
 
+			cooling-maps {
+				map0 {
+					trip = <&cpu0123_alert0>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&cpu0123_alert1>;
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
 				cpu0123_alert0: trip-point0 {
 					temperature = <90000>;

---
base-commit: 4aa1da8d99724f6c0b762b58a71cee7c5e2e109b
change-id: 20230418-topic-cool_bengal-2f5f3f47269c

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

