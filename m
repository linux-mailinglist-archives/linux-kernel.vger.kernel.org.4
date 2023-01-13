Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AA0669E1D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjAMQ3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjAMQ2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:28:18 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBB37FC9B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:22:51 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mp20so6870767ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7d41l0HM2BfF3mxFfhv8kgpjTHwRckZQ3XW8jzXEKtA=;
        b=djioHbVFvUz5qObOlYiGdTQALHhMYuwE/IMrkCTY51GlXpqU0Jf1lCUkAXYKBi292o
         rXVpN/kFyEU9DT79ZrY3AZsBcDamrRqdSv7thn7OpU4gMh9ECOnVZE1Wtpj0KRXOi4Cl
         CXxZtotfZVoQTK9soDEdwVYefGn/j1lXCyZ86ZeRhxBV3cq73uFHGIxXKXPX+5I84+hU
         kN0CXcnhXxJjOnhbAxiV9NNNh9BS310S4dRiC3FG0+nMPyGyo+6ogIA3wBCWNfdel9/9
         RPPxxNciVd/fWYM8v/O9Zt6dxglRxPzsNvyj0D8t+CHgOj96vAqpHSdaJwqyoLpzALIw
         BAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7d41l0HM2BfF3mxFfhv8kgpjTHwRckZQ3XW8jzXEKtA=;
        b=yZKxs/w5QPlPedOo0J7eiN+n1seVCwOQrirfnvhlI1AgEgI1gPPZvKQmeiQlBQluX/
         cMS+YZic9M+oA6DP3etlrh+w1jHUj/gppxX0HImkwEZxJXpkoyPRYZ+tIfdJJ6kfndgz
         xApaZ/Pzg/d6JxO32/gn3YA5tGTXjl9rBf0C+j8jwTV87o7Wdj9aa6AzAP7N/JgcotJR
         ZiUPXrunvyy9ZL6DCO8PaJJHq8rNY1+UozS1kQpTGzaFo2ox+XRVbT5efL90dbjVt3pp
         tZlB0uE9nOHYREKgibmD/QzBkrEqy8eAiUZN1ECekuIwCNp7U4jVZLfYQvl1kxUqJidQ
         zXxg==
X-Gm-Message-State: AFqh2kpHJialILb9/YlyKdsM83BIrF5JL54JZzjKaM+vkE6aBGuiEmFL
        LbMkVYALFTwMLzhs3XFzooeIDA==
X-Google-Smtp-Source: AMrXdXtTUjoz3dWiA0ZESis4pRBEtW4cYZ+lfJFUZ/DDZIZdwyn9tSNRE/YzZO7FQ1+XiPg7Sq5qzw==
X-Received: by 2002:a17:906:a186:b0:82d:e2a6:4b0d with SMTP id s6-20020a170906a18600b0082de2a64b0dmr67249105ejy.18.1673626970314;
        Fri, 13 Jan 2023 08:22:50 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090676c100b007c0d4d3a0c1sm8739479ejn.32.2023.01.13.08.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:22:50 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/6] arm64: dts: qcom: sdm845: move WCD9340 codec to separate file
Date:   Fri, 13 Jan 2023 17:22:41 +0100
Message-Id: <20230113162245.117324-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113162245.117324-1-krzysztof.kozlowski@linaro.org>
References: <20230113162245.117324-1-krzysztof.kozlowski@linaro.org>
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

WCD9340 codec node is not a property of the SoC, but board.  Move it to
separate file and include it in the specific boards.  On all others,
keep the Slimbus node disabled as it is empty.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../boot/dts/qcom/sdm845-audio-wcd9340.dtsi   | 69 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  1 +
 .../qcom/sdm845-xiaomi-beryllium-common.dtsi  |  1 +
 .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 60 +---------------
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  1 +
 .../boot/dts/qcom/sdm850-samsung-w737.dts     |  1 +
 7 files changed, 75 insertions(+), 59 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
new file mode 100644
index 000000000000..5bcce7d0d709
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SDM845 SoC device tree source
+ *
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+&slim {
+	status = "okay";
+
+	slim@1 {
+		reg = <1>;
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		wcd9340_ifd: ifd@0,0 {
+			compatible = "slim217,250";
+			reg = <0 0>;
+		};
+
+		wcd9340: codec@1,0 {
+			compatible = "slim217,250";
+			reg = <1 0>;
+			slim-ifc-dev = <&wcd9340_ifd>;
+
+			#sound-dai-cells = <1>;
+
+			interrupts-extended = <&tlmm 54 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+
+			#clock-cells = <0>;
+			clock-frequency = <9600000>;
+			clock-output-names = "mclk";
+			qcom,micbias1-microvolt = <1800000>;
+			qcom,micbias2-microvolt = <1800000>;
+			qcom,micbias3-microvolt = <1800000>;
+			qcom,micbias4-microvolt = <1800000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			wcdgpio: gpio-controller@42 {
+				compatible = "qcom,wcd9340-gpio";
+				gpio-controller;
+				#gpio-cells = <2>;
+				reg = <0x42 0x2>;
+			};
+
+			swm: swm@c85 {
+				compatible = "qcom,soundwire-v1.3.0";
+				reg = <0xc85 0x40>;
+				interrupts-extended = <&wcd9340 20>;
+
+				qcom,dout-ports = <6>;
+				qcom,din-ports = <2>;
+				qcom,ports-sinterval-low = /bits/ 8  <0x07 0x1f 0x3f 0x7 0x1f 0x3f 0x0f 0x0f>;
+				qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0c 0x6 0x12 0x0d 0x07 0x0a>;
+				qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1f 0x00 0x00 0x1f 0x00 0x00>;
+
+				#sound-dai-cells = <1>;
+				clocks = <&wcd9340>;
+				clock-names = "iface";
+				#address-cells = <2>;
+				#size-cells = <0>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 6b355589edb3..3726465acbde 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm845.dtsi"
+#include "sdm845-audio-wcd9340.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 64de4ed9b0c8..e530a676b250 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm845.dtsi"
+#include "sdm845-audio-wcd9340.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index a80c3dd9a2da..f81619c8a3ba 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -13,6 +13,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm845.dtsi"
+#include "sdm845-audio-wcd9340.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
 #include "pm8005.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 4c256431280a..f9b1d7a60fd6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3831,65 +3831,7 @@ slim: slim-ngd@171c0000 {
 			iommus = <&apps_smmu 0x1806 0x0>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-
-			slim@1 {
-				reg = <1>;
-				#address-cells = <2>;
-				#size-cells = <0>;
-
-				wcd9340_ifd: ifd@0,0 {
-					compatible = "slim217,250";
-					reg = <0 0>;
-				};
-
-				wcd9340: codec@1,0 {
-					compatible = "slim217,250";
-					reg = <1 0>;
-					slim-ifc-dev = <&wcd9340_ifd>;
-
-					#sound-dai-cells = <1>;
-
-					interrupts-extended = <&tlmm 54 IRQ_TYPE_LEVEL_HIGH>;
-					interrupt-controller;
-					#interrupt-cells = <1>;
-
-					#clock-cells = <0>;
-					clock-frequency = <9600000>;
-					clock-output-names = "mclk";
-					qcom,micbias1-microvolt = <1800000>;
-					qcom,micbias2-microvolt = <1800000>;
-					qcom,micbias3-microvolt = <1800000>;
-					qcom,micbias4-microvolt = <1800000>;
-
-					#address-cells = <1>;
-					#size-cells = <1>;
-
-					wcdgpio: gpio-controller@42 {
-						compatible = "qcom,wcd9340-gpio";
-						gpio-controller;
-						#gpio-cells = <2>;
-						reg = <0x42 0x2>;
-					};
-
-					swm: swm@c85 {
-						compatible = "qcom,soundwire-v1.3.0";
-						reg = <0xc85 0x40>;
-						interrupts-extended = <&wcd9340 20>;
-
-						qcom,dout-ports = <6>;
-						qcom,din-ports = <2>;
-						qcom,ports-sinterval-low = /bits/ 8  <0x07 0x1f 0x3f 0x7 0x1f 0x3f 0x0f 0x0f>;
-						qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0c 0x6 0x12 0x0d 0x07 0x0a>;
-						qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1f 0x00 0x00 0x1f 0x00 0x00>;
-
-						#sound-dai-cells = <1>;
-						clocks = <&wcd9340>;
-						clock-names = "iface";
-						#address-cells = <2>;
-						#size-cells = <0>;
-					};
-				};
-			};
+			status = "disabled";
 		};
 
 		lmh_cluster1: lmh@17d70800 {
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index d9581f4440b3..5586c95aa1ff 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -13,6 +13,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm850.dtsi"
+#include "sdm845-audio-wcd9340.dtsi"
 #include "pm8998.dtsi"
 
 /*
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
index 6730804f4e3e..40223704a2c7 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -14,6 +14,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm850.dtsi"
+#include "sdm845-audio-wcd9340.dtsi"
 #include "pm8998.dtsi"
 
 /*
-- 
2.34.1

