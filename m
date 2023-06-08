Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04627727BAD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbjFHJne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbjFHJna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:43:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C992F26AE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:43:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9768fd99c0cso318267066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 02:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686217408; x=1688809408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p9uQq0Xl0TqARAO6EcFF43rVZmZjmeHfFCIqAhFy67I=;
        b=I23qF6O7TBDPqvPGEs1xJb3WPMl6F7vC75IYWV8T4zBVQykERe0g1WFbi6uwIzsh9O
         zwnyxHxWX4fQ455VkMDmVshp280w2auU0w6YBbc5x5xG/D6Untpa9iofE/TWHrILu95n
         ctWNCjSUCaMPlG6f4yYJH1uZ62ydN8XHBMdXDnXTcmAeEvJtdcxBVKY3q1hG9h+Cee2g
         Qd0kdc6DDlzL3mZE+IkyZsEQC+CNWt29Y1aRvvI/e1kbNfQdTT1Jc8dxmtmUzCBKvJJX
         9GCixgru2JFtsl2RZdNjw5Z3wCM+ArsCRusuqrstT++gkejQU00LNmg4UfPola1y2M5D
         rsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686217408; x=1688809408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9uQq0Xl0TqARAO6EcFF43rVZmZjmeHfFCIqAhFy67I=;
        b=X0Le7C2RO/BJ5dGTvdQZ7NVpvfgeKIFgnwVt1lEF0ov54hVQbl5bzQnLtvT4Aw7Bzv
         bu7U1stkIUw5csEyCEVrR2m0kTSgCYqk8H9ed6ymXo14aMAg3eGr2OM5ZPiVUATx4Caw
         kMKz8abbezvWuNXSmjQ1zk77EFORvKcQS/9/P7IuH6FoTBB3Zye71a4wU6mfdSoPs7UA
         nEFlYT7oNGOm4140Pjfyw7X+7tOfuckp/rcFh5p39WRgQCT1O+pjYWK1VbSt8DrzQo6n
         fat04fOUfd0CXet0oSnaCzT1xXaz6F6IWr9P+RELER8TDZyRfXe9uSYJ9HsU/y6RvNNQ
         fnBQ==
X-Gm-Message-State: AC+VfDxNNzxBSwA4sXqn9VdrmOAWWImbPKHHB2lLW2b3XDY2cTqLMNXi
        MtFAjVHEDCsAHwKk7C0iNrBE0g==
X-Google-Smtp-Source: ACHHUZ6ijCJwjELB4YLtTm9kUOKWe+dt82lVWWCoEP+BVagBiOmP9YnLySXSBKmkD1NusPmhlDacAw==
X-Received: by 2002:a17:907:7253:b0:96f:7636:65ca with SMTP id ds19-20020a170907725300b0096f763665camr1700947ejc.3.1686217408313;
        Thu, 08 Jun 2023 02:43:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7dbda000000b0050cc4461fc5sm331020edt.92.2023.06.08.02.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 02:43:27 -0700 (PDT)
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
Subject: [PATCH 1/2] arm64: dts: qcom: sm8550-qrd: add WSA8845 speakers
Date:   Thu,  8 Jun 2023 11:43:22 +0200
Message-Id: <20230608094323.267278-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Add Qualcomm WSA8845 Soundwire smart speaker amplifiers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Bindings and driver:
https://lore.kernel.org/linux-arm-msm/20230608085023.141745-1-krzysztof.kozlowski@linaro.org/T/#m923115d37c93e16302ae9a451baad432d940f0b7
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 48 +++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 97cb7d00b89f..45c684c0a062 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -431,6 +431,24 @@ &gcc {
 		 <&usb_dp_qmpphy QMP_USB43DP_USB3_PIPE_CLK>;
 };
 
+&lpass_tlmm {
+	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
+		pins = "gpio17";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+
+	spkr_2_sd_n_active: spkr-2-sd-n-active-state {
+		pins = "gpio18";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+		output-low;
+	};
+};
+
 &mdss {
 	status = "okay";
 };
@@ -551,6 +569,36 @@ &sleep_clk {
 	clock-frequency = <32000>;
 };
 
+&swr0 {
+	status = "okay";
+
+	/* WSA8845, Speaker North */
+	north_spkr: speaker@0,0 {
+		compatible = "sdw20217020400";
+		reg = <0 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spkr_1_sd_n_active>;
+		powerdown-gpios = <&lpass_tlmm 17 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrLeft";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l3g_1p2>;
+	};
+
+	/* WSA8845, Speaker South */
+	south_spkr: speaker@0,1 {
+		compatible = "sdw20217020400";
+		reg = <0 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spkr_2_sd_n_active>;
+		powerdown-gpios = <&lpass_tlmm 18 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrRight";
+		vdd-1p8-supply = <&vreg_l15b_1p8>;
+		vdd-io-supply = <&vreg_l3g_1p2>;
+	};
+};
+
 &swr1 {
 	status = "okay";
 
-- 
2.34.1

