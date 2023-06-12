Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590F972CD0B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjFLRjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjFLRih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:38:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10651BC9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:38:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so6594172a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 10:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686591486; x=1689183486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNLvSqvE3OWBG10u+NGTDOsq6O7ZNO/LdPhT/ZdB0Fw=;
        b=Ef10wwZoAbpHtT7Lhb8V3zzTlSliCxftcgo7fBGKKL4JEDaVAeUojiEtN/UTTE5nsM
         Z2RD16N9C38le4AOmWNPWHf5Bdq/K6aOlSq7gRLTkFZbUZool6r3A1dUeJMVt9OiVi8s
         CzPFsZLAFY1LZOwEh3Ng1xoaGrxEcv53g/g0pCYqhr2BA3JsZgOtiIwosa1oInxWjCAy
         IKbKfasIlXwELrSAb95MbzmtRVskG22kFWP8TUTaVBwrZZedHSJL/qSfZlVYcRZSdwYB
         oo+RNnjyr94vFwHfZg+jBkfpxX7KmoHWolJtZmh749U4Fgyy9gmiB4NpG4CF5+7dNm5+
         EwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686591486; x=1689183486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNLvSqvE3OWBG10u+NGTDOsq6O7ZNO/LdPhT/ZdB0Fw=;
        b=WTq3mgLQ074ppD9jx/bOxGkRNDGrcAqtSUf44kYFPPIOYmSJYNoXyilyoP8YWrqcmt
         hJo/q1WblglZ/Yv+uO0yTsXcp+bpHBqU2XxjCmmXZH0ZC6JGNEM3P945Wx7WVnZ8nPJ4
         HuR9RBOKVOq3UFz2psDjsnfEDRwFKWEO3Vb0nABEv3uSQFG9T4ZCYTzbKwAzXN+bnCSL
         AxuGrGmY5Aas50BvwUxOGSBBkGIqzTPCuBhOtjPBAUDiK6ddkwumSH1Tkz9epP5Y2sfX
         P1RGHk+pcIBLfUyVlJ5SceTyLKD00sb3CgApcURwKE+9X5U+kZIbN8OIu1/i//l5zhrx
         HX6w==
X-Gm-Message-State: AC+VfDyYqhKJjEbrzRTng35j6Pqt+9HrHIqRNXnorsyEJ96bUcYjz+GS
        ILSGGxBlddmc2RNIQEGOZ5JHwg==
X-Google-Smtp-Source: ACHHUZ4TrE+PQvNN4bMlTGHGjb35apk1pQTccfPN26UQQq+YF6sk9yMUx/YpsLBTRM7PB9RR0AnR8g==
X-Received: by 2002:a17:907:3f12:b0:974:6287:f67f with SMTP id hq18-20020a1709073f1200b009746287f67fmr10539860ejc.28.1686591486054;
        Mon, 12 Jun 2023 10:38:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ks27-20020a170906f85b00b00977eec5bb2csm5454093ejb.156.2023.06.12.10.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 10:38:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: sm8550-mtp: add sound card
Date:   Mon, 12 Jun 2023 19:37:58 +0200
Message-Id: <20230612173758.286411-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612173758.286411-1-krzysztof.kozlowski@linaro.org>
References: <20230612173758.286411-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the sound card node with tested playback over WSA8845 speakers and
WCD9385 headset over USB Type-C.  The recording links were not tested,
but should be similar to previous platforms.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on hardware. Should be the same as on QRD8550.
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 81 +++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 54f8957499a3..34b548b3e43d 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -95,6 +95,87 @@ pmic_glink_sbu: endpoint {
 		};
 	};
 
+	sound {
+		compatible = "qcom,sm8550-sndcard", "qcom,sm8450-sndcard";
+		model = "SM8550-MTP";
+		audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
+				"SpkrRight IN", "WSA_SPK2 OUT",
+				"IN1_HPHL", "HPHL_OUT",
+				"IN2_HPHR", "HPHR_OUT",
+				"AMIC2", "MIC BIAS2",
+				"VA DMIC0", "MIC BIAS1",
+				"VA DMIC1", "MIC BIAS1",
+				"VA DMIC2", "MIC BIAS3",
+				"TX DMIC0", "MIC BIAS1",
+				"TX DMIC1", "MIC BIAS2",
+				"TX DMIC2", "MIC BIAS3",
+				"TX SWR_ADC1", "ADC2_OUTPUT";
+
+		wcd-playback-dai-link {
+			link-name = "WCD Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&wcd938x 0>, <&swr1 0>, <&lpass_rxmacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		wcd-capture-dai-link {
+			link-name = "WCD Capture";
+
+			cpu {
+				sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
+			};
+
+			codec {
+				sound-dai = <&wcd938x 1>, <&swr2 0>, <&lpass_txmacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		wsa-dai-link {
+			link-name = "WSA Playback";
+
+			cpu {
+				sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
+			};
+
+			codec {
+				sound-dai = <&left_spkr>, <&right_spkr>, <&swr0 0>, <&lpass_wsamacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+
+		va-dai-link {
+			link-name = "VA Capture";
+
+			cpu {
+				sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
+			};
+
+			codec {
+				sound-dai = <&lpass_vamacro 0>;
+			};
+
+			platform {
+				sound-dai = <&q6apm>;
+			};
+		};
+	};
+
 	vph_pwr: vph-pwr-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
-- 
2.34.1

