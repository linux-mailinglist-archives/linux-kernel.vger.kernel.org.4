Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07D069F400
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjBVMFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjBVME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:04:58 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAC93A09B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:04:21 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o4-20020a05600c4fc400b003e1f5f2a29cso6109293wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 04:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjzGmXwVljBe8mZ+uk4FOoHWI0FZH42+qdZTdioa4oM=;
        b=dg0cLvwnI81FQydXJAP1QT6Igrm2ZMqoIHowk2yLzTLcgO5loHyKU3WOiyleoq1wnj
         UbcIGK41SzGzycBpVL0vn9HLWw3D+6aIjVuWZZ/05O+ovBQavFA8z6zbReitGQD960J/
         Qo6/36RY+T5dplCao7mW1yYFL0T3HFZTIykc/4dHRcBTRS/h4zgYWk+iS0v0jPW1R21p
         JCTQoh7tqGqtPqA+xRubyXzjXpvypnheL9DHDihXDc5IKNLa5sT+tPlGP/NFm3WGz7jG
         quYLCaIle02Ks4GhrPU/EUCbLHxdgLYpYIexAGPqiqSWV3QDsmLB1vtf9bgsdMAiBRlt
         D4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjzGmXwVljBe8mZ+uk4FOoHWI0FZH42+qdZTdioa4oM=;
        b=3HNtBot6WHrgvmz64l69Cqw0MDzuUUPHaOx6xBqj4BMWnOswziI2qtq5NP9Zq09vm4
         qi+u315uyrVo652E82DXiEsq/SKOBJwcxKKfNaq4FeIpIBxmpvML3uXOCHXbwYGtCPV0
         XdaZialiWGJbgdj5RGp40Tx1d6Sx4fRAsTrJ2TqammiJe3X+ue3yhJ2h31iDGzfqfQvX
         6IEne1mSmRAyrpQhJBcwA5bx04863YhxqI4hhLiaByormY0JuSB/hRXaJw51oLhuLqUa
         CN0H7Mz6EGA/VpXbOQDUenAcVEqLluwI3q/ARQwnbCuuH40eyTET7OleZy+Xh0pYGqmC
         RDLQ==
X-Gm-Message-State: AO0yUKVMFfdhCqLRGzhXgBVVVDP/RX8ag5xYJ/54vXozrE0hUA+7LEz+
        VJVHo1+8twIV290o0qu7SDbsSA==
X-Google-Smtp-Source: AK7set+kDpJwlxBSGGiGyRlQK7BBY6vJi6N5b8hbXtCv88CsQ51Pc5r7+Oyclp7LudZ4aQ3BdczE/A==
X-Received: by 2002:a05:600c:1656:b0:3dc:46f6:e607 with SMTP id o22-20020a05600c165600b003dc46f6e607mr5330283wmn.3.1677067459274;
        Wed, 22 Feb 2023 04:04:19 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o27-20020a05600c511b00b003e21dcccf9fsm8447722wms.16.2023.02.22.04.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 04:04:19 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, stephan@gerhold.net
Subject: [PATCH v6 3/5] arm64: dts: qcom: Add msm8939-pm8916.dtsi include
Date:   Wed, 22 Feb 2023 12:04:09 +0000
Message-Id: <20230222120411.55197-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222120411.55197-1-bryan.odonoghue@linaro.org>
References: <20230222120411.55197-1-bryan.odonoghue@linaro.org>
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

From: Stephan Gerhold <stephan@gerhold.net>

The msm8939-pm8916.dtsi include configures the regulator supplies of
MSM8939 used together with PM8916, as recommended by Qualcomm. In rare
cases where boards deviate from the recommended design they can just
avoid using this include.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
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
2.39.1

