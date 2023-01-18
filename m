Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DAB671A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjARLVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjARLTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:19:52 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7242D6CCED
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:35:08 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id n7so7381591wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frM+OJIW8+YWIIMkRCM2WWed4kr4d1TRkS3GV593Yj0=;
        b=xQRUgdqAtDsyd8GEVNxAU3OGb5rFMqxezTC4M/aakqKpXIvbFut2AOFNORVe4kKiei
         ac26dqi76/W4lotcNZUF/9nbjKCZiDC/XYAuOx7DR9IFG3/YBa1boJ4zfHOIqZihvz2d
         fADSL4vVTp8p1IMH96dE5xSskYSZ7ixPNxCOy7WrPkkCp3m5OtV1R01QQMyQ3qQG4L0Q
         JOCS2evy6xMojVq+Tw5gx49UuayBu6lQAX29moMKgzG+UyDkd6ihohjaVugaitR9RFBY
         n+OPaDq+76pHW8nkb0VdDAYHl5k+8dBl+uAyYD/x9JYRNvfh+pyHhXpYaDdqf/A9XQlL
         2a7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frM+OJIW8+YWIIMkRCM2WWed4kr4d1TRkS3GV593Yj0=;
        b=C15o2YEXWaDnVv9lLrWMCKawYOrY/YWnEZeNno/nnRMzQP4B+ST8vGCwb8sCW0rlXu
         ZsCc/LQce0sX05VxtVGRZK+Rcr80wx8L2GbsX1gRGM10THaI57sPv8mOVa1kcwoReCGG
         lbQEWYXYtzLK8bN0GhgUqNaeEGagQgjbssKrNR4xGGErMHK0qFeqVb69EuOrfjmbz10R
         sT4WNmX49hqGf2hWSX2YLF2OYWYaBr8nasD/TstH3fwDATTnMnHS8Njo4A9Qm8gT9QQa
         SZBqJL0AYLxbMGGfb4/R38+wPSGFJg60agx1/Gf4iNoJzJfN32WEC22mfpkBKBnmP6J4
         2mtA==
X-Gm-Message-State: AFqh2koaSwj0ElYMdmqdL/Hs5uuUeMKvexmb9UdRhJiclSeytTfCUgQj
        sEDb4lEqtRsdJPS4/FXf/f0oPg==
X-Google-Smtp-Source: AMrXdXuG05WWhM2byRAtJGgMaWWbMw89Qh6aCbjge8kSKDZ4c7X4qbGuZCPrUe5D5gFQJ0Ttre3+sg==
X-Received: by 2002:a5d:5608:0:b0:2b6:daf8:52ad with SMTP id l8-20020a5d5608000000b002b6daf852admr1622631wrv.52.1674038106988;
        Wed, 18 Jan 2023 02:35:06 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ba29-20020a0560001c1d00b002b065272da2sm10076731wrb.13.2023.01.18.02.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 02:35:06 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 4/6] arm64: dts: qcom: sdm845: move audio to separate file
Date:   Wed, 18 Jan 2023 11:34:56 +0100
Message-Id: <20230118103458.107434-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118103458.107434-1-krzysztof.kozlowski@linaro.org>
References: <20230118103458.107434-1-krzysztof.kozlowski@linaro.org>
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

Re-organize SDM845 sound components into separate, audio DTSI which
should be included and customized by the SDM845 boards wanting audio.
The DTSI includes:
1. WCD9340 codec node because it is not a property of the SoC, but board.
2. Common sound DAI links, shared with all sound cards.

The Xiaomi Polaris, although includes WCD9340 codec, it lacks sound
node, so it stays disabled.

On all others boards not using audio, keep the Slimbus node disabled as
it is empty.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Move also sound node.
2. Rewrite commit msg.

RFC - please kindly test the boards.
---
 .../boot/dts/qcom/sdm845-audio-wcd9340.dtsi   | 125 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts    |  55 +-------
 .../qcom/sdm845-xiaomi-beryllium-common.dtsi  |  53 +-------
 .../boot/dts/qcom/sdm845-xiaomi-polaris.dts   |   1 +
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  60 +--------
 .../boot/dts/qcom/sdm850-lenovo-yoga-c630.dts |  59 ++-------
 .../boot/dts/qcom/sdm850-samsung-w737.dts     |  60 ++-------
 7 files changed, 151 insertions(+), 262 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
new file mode 100644
index 000000000000..0a94fde6741d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
@@ -0,0 +1,125 @@
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
+
+&sound {
+	compatible = "qcom,sdm845-sndcard";
+	status = "disabled";
+
+	mm1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	mm2-dai-link {
+		link-name = "MultiMedia2";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
+		};
+	};
+
+	mm3-dai-link {
+		link-name = "MultiMedia3";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA3>;
+		};
+	};
+
+	sound_slim_dai_link: slim-dai-link {
+		link-name = "SLIM Playback";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_0_RX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9340 0>;
+		};
+	};
+
+	slimcap-dai-link {
+		link-name = "SLIM Capture";
+		cpu {
+			sound-dai = <&q6afedai SLIMBUS_0_TX>;
+		};
+
+		platform {
+			sound-dai = <&q6routing>;
+		};
+
+		codec {
+			sound-dai = <&wcd9340 1>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 4833e89affc2..11b0554a6aea 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -11,6 +11,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm845.dtsi"
+#include "sdm845-audio-wcd9340.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
 
@@ -726,27 +727,7 @@ &quat_mi2s_sd2_active
 		"MM_DL2",  "MultiMedia2 Playback",
 		"MM_DL4",  "MultiMedia4 Playback",
 		"MultiMedia3 Capture", "MM_UL3";
-
-	mm1-dai-link {
-		link-name = "MultiMedia1";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
-		};
-	};
-
-	mm2-dai-link {
-		link-name = "MultiMedia2";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
-		};
-	};
-
-	mm3-dai-link {
-		link-name = "MultiMedia3";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
-		};
-	};
+	status = "okay";
 
 	mm4-dai-link {
 		link-name = "MultiMedia4";
@@ -769,35 +750,11 @@ codec {
 			sound-dai = <&lt9611_codec 0>;
 		};
 	};
+};
 
-	slim-dai-link {
-		link-name = "SLIM Playback";
-		cpu {
-			sound-dai = <&q6afedai SLIMBUS_0_RX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-
-		codec {
-			sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
-		};
-	};
-
-	slimcap-dai-link {
-		link-name = "SLIM Capture";
-		cpu {
-			sound-dai = <&q6afedai SLIMBUS_0_TX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-
-		codec {
-			sound-dai = <&wcd9340 1>;
-		};
+&sound_slim_dai_link {
+	codec {
+		sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 5de8b4c372fc..54eabacdc031 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm845.dtsi"
+#include "sdm845-audio-wcd9340.dtsi"
 #include "pm8998.dtsi"
 #include "pmi8998.dtsi"
 
@@ -384,57 +385,7 @@ &sound {
 		"AMIC1", "MIC BIAS1",
 		"AMIC2", "MIC BIAS2",
 		"AMIC3", "MIC BIAS3";
-
-	mm1-dai-link {
-		link-name = "MultiMedia1";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
-		};
-	};
-
-	mm2-dai-link {
-		link-name = "MultiMedia2";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
-		};
-	};
-
-	mm3-dai-link {
-		link-name = "MultiMedia3";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
-		};
-	};
-
-	slim-dai-link {
-		link-name = "SLIM Playback";
-		cpu {
-			sound-dai = <&q6afedai SLIMBUS_0_RX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-
-		codec {
-			sound-dai = <&wcd9340 0>;
-		};
-	};
-
-	slimcap-dai-link {
-		link-name = "SLIM Capture";
-		cpu {
-			sound-dai = <&q6afedai SLIMBUS_0_TX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-
-		codec {
-			sound-dai = <&wcd9340 1>;
-		};
-	};
+	status = "okay";
 };
 
 &tlmm {
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
index d55ffd69155e..b979d8ae8698 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -13,6 +13,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm850.dtsi"
+#include "sdm845-audio-wcd9340.dtsi"
 #include "pm8998.dtsi"
 
 /*
@@ -522,57 +523,7 @@ &sound {
 		"MM_DL1",  "MultiMedia1 Playback",
 		"MM_DL3",  "MultiMedia3 Playback",
 		"MultiMedia2 Capture", "MM_UL2";
-
-	mm1-dai-link {
-		link-name = "MultiMedia1";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
-		};
-	};
-
-	mm2-dai-link {
-		link-name = "MultiMedia2";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
-		};
-	};
-
-	mm3-dai-link {
-		link-name = "MultiMedia3";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
-		};
-	};
-
-	slim-dai-link {
-		link-name = "SLIM Playback";
-		cpu {
-			sound-dai = <&q6afedai SLIMBUS_0_RX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-
-		codec {
-			sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
-		};
-	};
-
-	slimcap-dai-link {
-		link-name = "SLIM Capture";
-		cpu {
-			sound-dai = <&q6afedai SLIMBUS_0_TX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-
-		codec {
-			sound-dai = <&wcd9340 1>;
-		};
-	};
+	status = "okay";
 
 	slim-wcd-dai-link {
 		link-name = "SLIM WCD Playback";
@@ -590,6 +541,12 @@ codec {
 	};
 };
 
+&sound_slim_dai_link {
+	codec {
+		sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
index 6730804f4e3e..75773b06701b 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -14,6 +14,7 @@
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
 #include "sdm850.dtsi"
+#include "sdm845-audio-wcd9340.dtsi"
 #include "pm8998.dtsi"
 
 /*
@@ -436,7 +437,6 @@ dai@2 {
 };
 
 &sound {
-	compatible = "qcom,sdm845-sndcard";
 	model = "Samsung-W737";
 
 	audio-routing =
@@ -447,57 +447,7 @@ &sound {
 		"MM_DL1",  "MultiMedia1 Playback",
 		"MM_DL3",  "MultiMedia3 Playback",
 		"MultiMedia2 Capture", "MM_UL2";
-
-	mm1-dai-link {
-		link-name = "MultiMedia1";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
-		};
-	};
-
-	mm2-dai-link {
-		link-name = "MultiMedia2";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
-		};
-	};
-
-	mm3-dai-link {
-		link-name = "MultiMedia3";
-		cpu {
-			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
-		};
-	};
-
-	slim-dai-link {
-		link-name = "SLIM Playback";
-		cpu {
-			sound-dai = <&q6afedai SLIMBUS_0_RX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-
-		codec {
-			sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
-		};
-	};
-
-	slimcap-dai-link {
-		link-name = "SLIM Capture";
-		cpu {
-			sound-dai = <&q6afedai SLIMBUS_0_TX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-
-		codec {
-			sound-dai = <&wcd9340 1>;
-		};
-	};
+	status = "okay";
 
 	slim-wcd-dai-link {
 		link-name = "SLIM WCD Playback";
@@ -515,6 +465,12 @@ codec {
 	};
 };
 
+&sound_slim_dai_link {
+	codec {
+		sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <0 6>, <85 4>;
 
-- 
2.34.1

