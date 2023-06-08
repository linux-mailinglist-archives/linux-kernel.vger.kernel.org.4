Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9030727BAF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjFHJnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjFHJnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:43:33 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A0E213C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:43:31 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso692539a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 02:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686217410; x=1688809410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMC88QQAA9RPIa06r4K5M7PIg1TlAytJw9EvMNW3qYI=;
        b=yqCN5+NybBshfFlfntbvo1wEgfge2vvnNCctUyYvuulYfum5FMNlLSQpKBnx+oWXQ6
         /EY2X45Oin0tcfAJ1Iv+2tVTalNGcT8YD/Gu9hao6Sm5SRHOO6bdtBE6heu2kzF/dJtC
         YzyeCIJwVvQccRzaJhIjEj06kw7fPnZVlalRcQ/oXIZsfRkfILEgNljBcj5VRX37YjTZ
         stnxHx9n7ywK0LUCUz8+I+MknmcaZF9ppkP0jYOR0CrL435zXpDMArnT0xxMYhWhQ1FN
         tuok7MZmIL5jZq2BJuZfFN43NRL/+egNT7JlSY75tVm6Kmb7mbfUCtc96TERAmamWiEn
         /+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686217410; x=1688809410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMC88QQAA9RPIa06r4K5M7PIg1TlAytJw9EvMNW3qYI=;
        b=MMiQMOzDqu20ElvtZ5b9K9svv1EdbSubDJkF5n4ErjniDHIvCpJdvb47Rogwj6oxzg
         d57uw3X2Tv0jWSzyVTSL1MIhPGWOf3YvfiIApREWW5UtDkU04Yiekg90sxybor8RkOCd
         bgVYU+DCGRGgcMR6kLNMzKNhuH8fovju+S/v1WKACetqdBNq18tmvsCLSKfor88frCGO
         4Rn0W+0MsMLGjv/MGN7bDNk+r4PD2OUFz0KORsp2sC/Cq3frLY1mWPcR0xsTnW3x6gjZ
         snb68gzEAngZZBzUOdrNEMp8mTy1IZ04KXnk5HeqwvVMvhw0dlxQTyb3sfeGe2YbkbTj
         CGbg==
X-Gm-Message-State: AC+VfDzw5THNSktKMMjs9QPG88unDTOPf8x38la0TUrMToGdClEjjxRA
        +JrJSQ5bvyhPdjNtRfGoDcTMUA==
X-Google-Smtp-Source: ACHHUZ4CxH2k8IG+1O5HW0R3ye6vuV0QPdLhMzrY4obxAD9anLnPIB8/gsB1qhBfPBOjpbPypIfcxQ==
X-Received: by 2002:a17:907:3e21:b0:974:5ce6:f9ff with SMTP id hp33-20020a1709073e2100b009745ce6f9ffmr9475227ejc.32.1686217410148;
        Thu, 08 Jun 2023 02:43:30 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id v26-20020aa7dbda000000b0050cc4461fc5sm331020edt.92.2023.06.08.02.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 02:43:29 -0700 (PDT)
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
Subject: [PATCH 2/2] arm64: dts: qcom: sm8550-mtp: add WSA8845 speakers
Date:   Thu,  8 Jun 2023 11:43:23 +0200
Message-Id: <20230608094323.267278-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608094323.267278-1-krzysztof.kozlowski@linaro.org>
References: <20230608094323.267278-1-krzysztof.kozlowski@linaro.org>
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

Add Qualcomm WSA8845 Soundwire smart speaker amplifiers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested, but based on schematics and downstream DTS, should be the
same as on QRD8550.
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 48 +++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index fe6fe97d734e..d1bee3106397 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -419,6 +419,24 @@ vreg_l3g_1p2: ldo3 {
 	};
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
@@ -553,6 +571,36 @@ &sleep_clk {
 	clock-frequency = <32000>;
 };
 
+&swr0 {
+	status = "okay";
+
+	/* WSA8845 */
+	left_spkr: speaker@0,0 {
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
+	/* WSA8845 */
+	right_spkr: speaker@0,1 {
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

