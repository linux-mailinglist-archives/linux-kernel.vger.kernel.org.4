Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FFA6D09B6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjC3PdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjC3PdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:33:04 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFD51BDA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:32:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v1so19524257wrv.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680190350; x=1682782350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0F5PdgLvylrURdh5hYAlaRFmfzBMWK9DNwfEkmKI090=;
        b=i4e+RCiN7ln5yTHy6y8bMfukQv5Tj6Bg5QvdrA8tfioX7yZPkGvib0leVX6RU18VoL
         XAyPqEVy1/i+Ay9MVLQurI1eZ68M19wggofxgnd2wusorpO7HmXERN8+7xLsARxzjBKY
         M7pT/42O5VIkzpecoeuQo5n1LO2mx8fSJAWva1Caj9LyW7V6ZD4vOO99pJMvJ4yqruKp
         lVH3zv8t2Nd4tZkxuCW01ls+CjVg/CxaxavrGHj7HdwSKHEExzSod9WsAgI0vVPrmU3z
         OZU76A7+DEmBIy7ijrtXCz0xxU9CUI0XI81wQxtzXPeMEXNcZ/8OW7NLiMn0YzJOJHQR
         AAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680190350; x=1682782350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0F5PdgLvylrURdh5hYAlaRFmfzBMWK9DNwfEkmKI090=;
        b=esmYOKcyvecwv3Icl5uNxOAB3sIGhRmHEmrPcR2c7hbVSK15AlsT2zgOdhe27VkBc2
         n5G5xYfuEzmHGbQOWd4Cv+utSYtvB538WeVI5zFDFgx9ZbUXU7nPjMSRPtV7+wInCH41
         ETXUL8otoj04VhVKjxZtwNw1XqGmg3c+4umIBEBfO7iISO/Ilc48OCH/7OI+kkKhTdYX
         jxs233j54hkmL8t1rXdV1lecBpzANjA4VwwiGFFIl09UU+4+I86/Pua0/SPujqf2bAsX
         PFwZRn5PgEQL9pLnN+dWy5wE4/RwtPO80wJdJXIwxZMqP0L8CeUHmlrA5gRJFF8vtNe7
         svpw==
X-Gm-Message-State: AAQBX9fyZo2eX76eVfxNjGMKpkBK3+L6SWjTNSoV3E2rcFH1o/M2J9km
        2W6QF+Vd9RwfQydITiU0WO45EA==
X-Google-Smtp-Source: AKy350YMP4SIEXURx0JeulnjQY3Giw7sndbOUgFG3rNVeviCEb+dgF+e5Hc8eTpT1XwcXhH3qt+lzg==
X-Received: by 2002:a5d:63c1:0:b0:2cf:e8d2:b550 with SMTP id c1-20020a5d63c1000000b002cfe8d2b550mr18745498wrw.14.1680190350497;
        Thu, 30 Mar 2023 08:32:30 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id b7-20020a5d4b87000000b002cfe0ab1246sm33151794wrt.20.2023.03.30.08.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:32:29 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, stephan@gerhold.net
Subject: [PATCH v8 3/5] arm64: dts: qcom: Add msm8939-pm8916.dtsi include
Date:   Thu, 30 Mar 2023 16:32:20 +0100
Message-Id: <20230330153222.2875121-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330153222.2875121-1-bryan.odonoghue@linaro.org>
References: <20230330153222.2875121-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

The msm8939-pm8916.dtsi include configures the regulator supplies of
MSM8939 used together with PM8916, as recommended by Qualcomm. In rare
cases where boards deviate from the recommended design they can just
avoid using this include.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi | 82 ++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi

diff --git a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
new file mode 100644
index 0000000000000..18a1b3cca01d6
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "msm8939.dtsi"
+#include "pm8916.dtsi"
+
+&dsi0 {
+	vdda-supply = <&pm8916_l2>;
+	vddio-supply = <&pm8916_l6>;
+};
+
+&dsi1 {
+	vdda-supply = <&pm8916_l2>;
+	vddio-supply = <&pm8916_l6>;
+};
+
+&dsi_phy0 {
+	vddio-supply = <&pm8916_l6>;
+};
+
+&dsi_phy1 {
+	vddio-supply = <&pm8916_l6>;
+};
+
+&mpss {
+	pll-supply = <&pm8916_l7>;
+};
+
+&pronto {
+	vddpx-supply = <&pm8916_l7>;
+
+	iris {
+		vddxo-supply = <&pm8916_l7>;
+		vddrfa-supply = <&pm8916_s3>;
+		vddpa-supply = <&pm8916_l9>;
+		vdddig-supply = <&pm8916_l5>;
+	};
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8916_l8>;
+	vqmmc-supply = <&pm8916_l5>;
+};
+
+&sdhc_2 {
+	vmmc-supply = <&pm8916_l11>;
+	vqmmc-supply = <&pm8916_l12>;
+};
+
+&usb_hs_phy {
+	v1p8-supply = <&pm8916_l7>;
+	v3p3-supply = <&pm8916_l13>;
+};
+
+&rpm_requests {
+	smd_rpm_regulators: regulators {
+		compatible = "qcom,rpm-pm8916-regulators";
+
+		/* pm8916_s1 is managed by rpmpd (MSM8939_VDDMDCX) */
+		/* pm8916_s2 is managed by rpmpd (MSM8939_VDDCX) */
+		pm8916_s3: s3 {};
+		pm8916_s4: s4 {};
+
+		pm8916_l1: l1 {};
+		pm8916_l2: l2 {};
+		/* pm8916_l3 is managed by rpmpd (MSM8939_VDDMX) */
+		pm8916_l4: l4 {};
+		pm8916_l5: l5 {};
+		pm8916_l6: l6 {};
+		pm8916_l7: l7 {};
+		pm8916_l8: l8 {};
+		pm8916_l9: l9 {};
+		pm8916_l10: l10 {};
+		pm8916_l11: l11 {};
+		pm8916_l12: l12 {};
+		pm8916_l13: l13 {};
+		pm8916_l14: l14 {};
+		pm8916_l15: l15 {};
+		pm8916_l16: l16 {};
+		pm8916_l17: l17 {};
+		pm8916_l18: l18 {};
+	};
+};
-- 
2.39.2

