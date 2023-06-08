Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1781B72809E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbjFHMxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbjFHMxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:53:38 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3F42D65
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:53:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f7ebb2b82cso5245365e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 05:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686228806; x=1688820806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YziHmynId4IR2Mgz/ERaoYyCAyNCy8u3tHZC018mD34=;
        b=GmeKnsJNkH9RgaU5I6GNV2jUY/27u/Q+UISP0gAJd/UouxtIkVuvvV30YjprH6vWrY
         8YUIS85NUSmwCeE+WqwDBw9jp4irOsN4MsN8QxNJ1p3Jj9FBMkOztrK+7foF9kyWW0w7
         AgWz+ejXqS6Kv9uxcdrttSIzfuPTAEcDpoGFOprm/GVCkCvm6IrDGZsbFhLrZ8WXAZya
         sWWSGwot9gL4wEyFYGfIOC9Pm1Tw4yM84e7P8wNVgSyMD9rTG2z06rdNObdEEjnVTEoe
         5AvPSbcuPBjfUJCpbHU6CFNakw6X2r8aoqVK78qjtp+8E5CsDUgN0kMDue8wXq3+Q0wi
         2B/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686228806; x=1688820806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YziHmynId4IR2Mgz/ERaoYyCAyNCy8u3tHZC018mD34=;
        b=l6ZMWI6muyUkTO/CBwb0xj2bpMmg3XnN7gd8nmN0wywFAKqD10wxD4wGs3XQo21O8W
         LUjdZW2egTfaKYTPPrIQnpGRF50m1l+E7IQUsaVW3UEKKZjqUwNRbxIGzUgdyOpdy+w6
         BCHLqYFUS30yteQMjHFzuyHX1CD3rnimwESCINe+m45Y79iTShSogr9ViqspFWa2v7jz
         6W15t+oX3zv54JBPumiEAQmIRgMOtjHOqk199dmaAKQ6OOoMK1KlltF6BVzSuEUrp74Q
         kBR23qVKh9wc1d4x6nsjW2sqCKyui6cSLPut7ATVCEdcvrpVOfqTHMq51qARwUcE9ST8
         LUqw==
X-Gm-Message-State: AC+VfDxPdFm868b/39WCDkG/TSBlZis0U2avfyUnAZj+MRyZEHmcfg6z
        AbdYPtAHmakePIqYq5hvI1eVdA==
X-Google-Smtp-Source: ACHHUZ7BrzAIuHkrq174/toNK5CUMVb9aoCuERW7BtZkWlPdgazcEJDsCiEUUaS/yJchmKVLaCFVTQ==
X-Received: by 2002:a7b:ca46:0:b0:3f7:34ee:413f with SMTP id m6-20020a7bca46000000b003f734ee413fmr1265342wml.5.1686228805846;
        Thu, 08 Jun 2023 05:53:25 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bce16000000b003f7e4d143cfsm1894032wmc.15.2023.06.08.05.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 05:53:25 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 5/6] arm64: dts: qcom: sc8280xp: add resets for soundwire controllers
Date:   Thu,  8 Jun 2023 13:53:14 +0100
Message-Id: <20230608125315.11454-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230608125315.11454-1-srinivas.kandagatla@linaro.org>
References: <20230608125315.11454-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soundwire controllers on sc8280xp needs an explicit reset, add
support for this.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 6730349e34f4..6b1bb203b1d1 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
 #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/clock/qcom,sc8280xp-lpasscc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc8280xp.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -2560,6 +2561,8 @@ swr1: soundwire-controller@3210000 {
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rxmacro>;
 			clock-names = "iface";
+			resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
+			reset-names = "swr_audio_cgcr";
 			label = "RX";
 
 			qcom,din-ports = <0>;
@@ -2634,6 +2637,8 @@ swr0: soundwire-controller@3250000 {
 			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&wsamacro>;
 			clock-names = "iface";
+			resets = <&lpass_audiocc LPASS_AUDIO_SWR_WSA_CGCR>;
+			reset-names = "swr_audio_cgcr";
 			label = "WSA";
 
 			qcom,din-ports = <2>;
@@ -2656,6 +2661,13 @@ swr0: soundwire-controller@3250000 {
 			status = "disabled";
 		};
 
+		lpass_audiocc: clock-controller@32a9000 {
+			compatible = "qcom,sc8280xp-lpassaudiocc";
+			reg = <0 0x032a9000 0 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		swr2: soundwire-controller@3330000 {
 			compatible = "qcom,soundwire-v1.6.0";
 			reg = <0 0x03330000 0 0x2000>;
@@ -2665,6 +2677,8 @@ swr2: soundwire-controller@3330000 {
 
 			clocks = <&txmacro>;
 			clock-names = "iface";
+			resets = <&lpasscc LPASS_AUDIO_SWR_TX_CGCR>;
+			reset-names = "swr_audio_cgcr";
 			label = "TX";
 			#sound-dai-cells = <1>;
 			#address-cells = <2>;
@@ -2858,6 +2872,13 @@ data-pins {
 			};
 		};
 
+		lpasscc: clock-controller@33e0000 {
+			compatible = "qcom,sc8280xp-lpasscc";
+			reg = <0 0x033e0000 0 0x12000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		sdc2: mmc@8804000 {
 			compatible = "qcom,sc8280xp-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x08804000 0 0x1000>;
-- 
2.25.1

