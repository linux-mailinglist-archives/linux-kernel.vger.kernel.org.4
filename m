Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A5065990B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbiL3NvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiL3Nuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:50:54 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BCE101D7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:50:52 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id cf42so31815275lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nI8e/WlhysOYJ8g3aZB6ye/hx/UC/4lV7s/lAfytAMA=;
        b=DoJBDYzaxIgvqgtCMXGZjRrqxt1XPGWyQEyqPp2hvqpp+jwCENNL0UOHZyRiFxTmjs
         mH7VRDUeMe4Ld3V9XCl1JZOXnQeDU3jYBQhhfcO3mnWGlfrIfhLOcSXUburaWj4RE4Lj
         YpW4a+CWW+8DNXkoHWaaSGT71pDdzUhq0iZwT79R2rBGfJrRZnf+YrlEhtyuM9TO1Eqn
         Oc35Qpz5H/9ILAcDTAnVXUYlgZQxmJky9T9sdXgSMbtXt1r/KU46UVpx5X4szHJg3Z/c
         BH8goMedx9OunzykLfr21mhw/0K203SnEShrdcXQqETk5TtKDc8HcfgY0lnbveQGuotS
         z/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nI8e/WlhysOYJ8g3aZB6ye/hx/UC/4lV7s/lAfytAMA=;
        b=sZRM+N0ZV9G2Ik2SDJ420akxAfOlGUw3znrfNrVTfgsSYT17VmZOjWC3bqo8R/TBC5
         26eqyDVkh6NzecUM/aBEALYV/03pXF1youHWK4sshDLlPrUeOdQYF8OquwgCCa8U85nk
         cqjOT7tbdo9dCkOdqu/z+tyorBuCWHwSHzsE1sMNSfvZQR+ME3z9gdp4gS9Yt7fFaOeK
         SKh4MduOkrQl1j1GCTazm/TWPqmELgjVTaYCdSTT4pg6g4K/lPNEyQ9wF2sX/tkW3s64
         QAQtmg4M9TFKZ9nBd5fVw5+XoBf1tyIW+y0QNeIQRHlwAq5eZskFdnnquJn0Sx8N4OqQ
         IpfQ==
X-Gm-Message-State: AFqh2koHlnKnldvIgW8o5Ip+fx3rk6VZe1R8t1bOJUUUOOb9j5GgYV6A
        tvGKF72Wfa+SSjtCgcxj0NhXkw==
X-Google-Smtp-Source: AMrXdXu3mXETrCUP3x0pgC0Ic/4KHE60wiE62LKDmBWJULVEhYTmhFAoQCDcu0Lzr+j93aV9LAJT+Q==
X-Received: by 2002:a05:6512:25ac:b0:4b5:8053:5bcc with SMTP id bf44-20020a05651225ac00b004b580535bccmr9463538lfb.47.1672408250400;
        Fri, 30 Dec 2022 05:50:50 -0800 (PST)
Received: from localhost.localdomain (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id e16-20020ac24e10000000b004b4ea0f4e25sm3447970lfr.301.2022.12.30.05.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 05:50:50 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: sm8250: Sort audio hw nodes
Date:   Fri, 30 Dec 2022 14:50:44 +0100
Message-Id: <20221230135044.287874-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221230135044.287874-1-konrad.dybcio@linaro.org>
References: <20221230135044.287874-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Half of the audio hardware nodes were not sorted properly. Fix that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 142 +++++++++++++--------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index dffce681d417..0b6a6a809503 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2214,77 +2214,6 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
-		wsamacro: codec@3240000 {
-			compatible = "qcom,sm8250-lpass-wsa-macro";
-			reg = <0 0x03240000 0 0x1000>;
-			clocks = <&audiocc LPASS_CDC_WSA_MCLK>,
-				 <&audiocc LPASS_CDC_WSA_NPL>,
-				 <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-				 <&aoncc LPASS_CDC_VA_MCLK>,
-				 <&vamacro>;
-			clock-names = "mclk",
-				      "npl",
-				      "macro",
-				      "dcodec",
-				      "va",
-				      "fsgen";
-
-			pinctrl-names = "default";
-			pinctrl-0 = <&wsa_swr_active>;
-
-			#clock-cells = <0>;
-			clock-frequency = <9600000>;
-			clock-output-names = "mclk";
-			#sound-dai-cells = <1>;
-			status = "disabled";
-		};
-
-		swr0: soundwire-controller@3250000 {
-			compatible = "qcom,soundwire-v1.5.1";
-			reg = <0 0x03250000 0 0x2000>;
-			interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&wsamacro>;
-			clock-names = "iface";
-
-			qcom,din-ports = <2>;
-			qcom,dout-ports = <6>;
-
-			qcom,ports-sinterval-low =	/bits/ 8 <0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x0f 0x0f>;
-			qcom,ports-offset1 =		/bits/ 8 <0x01 0x02 0x0c 0x06 0x12 0x0d 0x07 0x0a>;
-			qcom,ports-offset2 =		/bits/ 8 <0xff 0x00 0x1f 0xff 0x00 0x1f 0x00 0x00>;
-			qcom,ports-block-pack-mode =	/bits/ 8 <0x0 0x0 0x1 0x0 0x0 0x1 0x0 0x0>;
-
-			#sound-dai-cells = <1>;
-			#address-cells = <2>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		audiocc: clock-controller@3300000 {
-			compatible = "qcom,sm8250-lpass-audiocc";
-			reg = <0 0x03300000 0 0x30000>;
-			#clock-cells = <1>;
-			clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-				 <&q6afecc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
-			clock-names = "core", "audio", "bus";
-		};
-
-		vamacro: codec@3370000 {
-			compatible = "qcom,sm8250-lpass-va-macro";
-			reg = <0 0x03370000 0 0x1000>;
-			clocks = <&aoncc LPASS_CDC_VA_MCLK>,
-				 <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
-				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
-			clock-names = "mclk", "macro", "dcodec";
-
-			#clock-cells = <0>;
-			clock-frequency = <9600000>;
-			clock-output-names = "fsgen";
-			#sound-dai-cells = <1>;
-		};
-
 		rxmacro: rxmacro@3200000 {
 			compatible = "qcom,sm8250-lpass-rx-macro";
 			reg = <0 0x03200000 0 0x1000>;
@@ -2388,6 +2317,77 @@ swr2: soundwire-controller@3230000 {
 			status = "disabled";
 		};
 
+		wsamacro: codec@3240000 {
+			compatible = "qcom,sm8250-lpass-wsa-macro";
+			reg = <0 0x03240000 0 0x1000>;
+			clocks = <&audiocc LPASS_CDC_WSA_MCLK>,
+				 <&audiocc LPASS_CDC_WSA_NPL>,
+				 <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&aoncc LPASS_CDC_VA_MCLK>,
+				 <&vamacro>;
+			clock-names = "mclk",
+				      "npl",
+				      "macro",
+				      "dcodec",
+				      "va",
+				      "fsgen";
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&wsa_swr_active>;
+
+			#clock-cells = <0>;
+			clock-frequency = <9600000>;
+			clock-output-names = "mclk";
+			#sound-dai-cells = <1>;
+			status = "disabled";
+		};
+
+		swr0: soundwire-controller@3250000 {
+			compatible = "qcom,soundwire-v1.5.1";
+			reg = <0 0x03250000 0 0x2000>;
+			interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&wsamacro>;
+			clock-names = "iface";
+
+			qcom,din-ports = <2>;
+			qcom,dout-ports = <6>;
+
+			qcom,ports-sinterval-low =	/bits/ 8 <0x07 0x1f 0x3f 0x07 0x1f 0x3f 0x0f 0x0f>;
+			qcom,ports-offset1 =		/bits/ 8 <0x01 0x02 0x0c 0x06 0x12 0x0d 0x07 0x0a>;
+			qcom,ports-offset2 =		/bits/ 8 <0xff 0x00 0x1f 0xff 0x00 0x1f 0x00 0x00>;
+			qcom,ports-block-pack-mode =	/bits/ 8 <0x0 0x0 0x1 0x0 0x0 0x1 0x0 0x0>;
+
+			#sound-dai-cells = <1>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		audiocc: clock-controller@3300000 {
+			compatible = "qcom,sm8250-lpass-audiocc";
+			reg = <0 0x03300000 0 0x30000>;
+			#clock-cells = <1>;
+			clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6afecc LPASS_CLK_ID_TX_CORE_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "core", "audio", "bus";
+		};
+
+		vamacro: codec@3370000 {
+			compatible = "qcom,sm8250-lpass-va-macro";
+			reg = <0 0x03370000 0 0x1000>;
+			clocks = <&aoncc LPASS_CDC_VA_MCLK>,
+				 <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+				 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+			clock-names = "mclk", "macro", "dcodec";
+
+			#clock-cells = <0>;
+			clock-frequency = <9600000>;
+			clock-output-names = "fsgen";
+			#sound-dai-cells = <1>;
+		};
+
 		aoncc: clock-controller@3380000 {
 			compatible = "qcom,sm8250-lpass-aoncc";
 			reg = <0 0x03380000 0 0x40000>;
-- 
2.39.0

