Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B325767768C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjAWInW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjAWInP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:43:15 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216611E2B1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:43:12 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso4151666wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9If+JSkFzojuFUTOP8x6BCS0M/klfUAgvUIkh+Y7QU=;
        b=FW859MoFegTf9Ta3DQs4WgGwR4+mE6lILGJuL5EL3/wlXpjX6WIgoEl83uByhWkzdl
         sOR3FXONMrC6yoBiCONBUkcGDjQ4OY6bN38706D+aAlpSkJj7CdCun9sJg3XPQbPS3ae
         28uJHduUjAWlqBUnkW2fIny2+KwME4prdx+eZ/r+OEuKT1NYLeOWCkh9MeqZjl3NQZTl
         akSLCklkxpdGUWUgorwsJSdgPAHFkek6H8vNMrp5S2rTf6jqC1vnAebNmA1arUNq70wj
         ESM8n807U9Y+7QDHxlQgfUnAibdY/Mr2fQmfY2I9nnnD8spk0ZvJd2PhsVvFBtL88U08
         lHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9If+JSkFzojuFUTOP8x6BCS0M/klfUAgvUIkh+Y7QU=;
        b=IfKonQFU9E+dsENvrXZ8Ad0+mUR5L0Zjklrhk8RQDL7qxVHgFU+F4WTeUFzazuC0ch
         LrBYidf3ryvU9Q62Z4bmRNc3NVaeXriUhko/AtBORs65YBXsf4Ijl2Yl7UzEoycuDe0X
         EafoiNVmYXlhpCLs8vw8DC8jK1UIbG/VUVuBTsRJ+EXjSaMLtoQyjncg/leSZnOtH9Ge
         oIH9KjYRKLk2LKCSPTg4h2RTxXtqXo5+vHDk3L14263K306ndijcndnMIEG/GWfqjcKk
         hcf23g8VtznyL2eHLHKklUjuSjBrHwsB78n0m+UT5QesKfvDl5TdWwSIHIoCrogsQ9nL
         wL1w==
X-Gm-Message-State: AFqh2koSidQFbLeRHvcF4G9qWSjTzQJozHmTLPJrdY3k9W9uP+Lxam0U
        6ske5naJx4TgzODTZ4+WJv3vQQ==
X-Google-Smtp-Source: AMrXdXs4nCsJAPu/TZizee0w6XXad2Uj3G/RATHR+P3tpuORrdEZMyi33qJulR0dw9YtPYsERm9lJg==
X-Received: by 2002:a05:600c:224a:b0:3da:fa15:8658 with SMTP id a10-20020a05600c224a00b003dafa158658mr26764786wmm.32.1674463391538;
        Mon, 23 Jan 2023 00:43:11 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l30-20020a05600c1d1e00b003c6b70a4d69sm10974120wms.42.2023.01.23.00.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 00:43:11 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 4/6] arm64: dts: qcom: sdm845: move codec to separate file
Date:   Mon, 23 Jan 2023 09:42:58 +0100
Message-Id: <20230123084300.22353-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123084300.22353-1-krzysztof.kozlowski@linaro.org>
References: <20230123084300.22353-1-krzysztof.kozlowski@linaro.org>
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

Re-organize SDM845 audio codec into separate, audio DTSI which
should be included and customized by the SDM845 boards wanting audio.
The codec node is anyway not a property of the SoC, but the boards.

On all others boards not using audio, keep the Slimbus node disabled as
it is empty.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v2:
1. Drop sound node in DTSI - affects devices.
2. Drop "audio" from DTSI file name.

Changes since v1:
1. Move also sound node.
2. Rewrite commit msg.

RFC - please kindly test the boards.
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  1 +
 arch/arm64/boot/dts/qcom/sdm845-wcd9340.dtsi  | 69 +++++++++++++++++++
 .../qcom/sdm845-xiaomi-beryllium-common.dtsi  |  1 +
 .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |  1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          | 60 +---------------
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  1 +
 .../boot/dts/qcom/sdm850-samsung-w737.dts     |  1 +
 7 files changed, 75 insertions(+), 59 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-wcd9340.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 4833e89affc2..118cc50ce49b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm845.dtsi"
+#include "sdm845-wcd9340.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-wcd9340.dtsi b/arch/arm64/boot/dts/qcom/sdm845-wcd9340.dtsi
new file mode 100644
index 000000000000..5bcce7d0d709
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-wcd9340.dtsi
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
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 5de8b4c372fc..a472c716f966 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm845.dtsi"
+#include "sdm845-wcd9340.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index a80c3dd9a2da..ea2a1a9fb3ff 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -13,6 +13,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm845.dtsi"
+#include "sdm845-wcd9340.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
 #include "pm8005.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0f1cb2c8addd..27d1917f5358 100644
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
index d55ffd69155e..6d253fbe0267 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -13,6 +13,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm850.dtsi"
+#include "sdm845-wcd9340.dtsi"
 #include "pm8998.dtsi"
 
 /*
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
index 6730804f4e3e..6758b0698acc 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -14,6 +14,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm850.dtsi"
+#include "sdm845-wcd9340.dtsi"
 #include "pm8998.dtsi"
 
 /*
-- 
2.34.1

