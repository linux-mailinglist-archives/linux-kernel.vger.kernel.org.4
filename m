Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6C266D4B7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjAQCxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbjAQCwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:52:37 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F412D303F5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:48:56 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso1363058wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyw85nc/PwcD3lfXSO76poeJVDlKaOkIt5Q0MKdYW04=;
        b=twDxjcgl/RQQ3Orm18dRKIPRSGTME5gfP0viRjzx3LmjMZlP1IOIm4eRss5Qul098n
         DWkSnLYZVhkscvX54bIzzMFwmVdR6wt+sX7zz9rosKA8VcRv6GpOWaO+b0la4f0qjNZ4
         uffgatEyo68xWCDqneza15zRn2fU2qEyZeVDKP+AZKG0dGCKoFPwpEWeKc2jdpRZWW0P
         yBseGGs1lUNj2Jzk+fv3cv20kstXMx0JMfp8q9uvlWE8EPK4VcAeB7i7XlrntmplF3Mh
         s9mPYpUnVjGSu4fmFEXxbCb0V0E9xvDNLU2nId1R0FyC51kwo/+yGLO1zmKR7BDzPAdZ
         vA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyw85nc/PwcD3lfXSO76poeJVDlKaOkIt5Q0MKdYW04=;
        b=yIvRYh3ciycHLbJEMQbbnCFfHW5PZMd+nicvPbdAVQjHCeTB4a/7t6Etu66c/cJvxQ
         EFi9NqIiDKpK67QKY7azUUTc5ZUOEqruLuygS9gI2e67siErG2ozZsWwsPP6Qx7nVvvv
         k+BNM2aG0Q+//C5ihj9ADJJPjJQDkFoqp8/4M31Lg0iJi6slKAWPk4/FmUrgQzEOSHb/
         ywfgpTfzdOuw2zckdCQ0G4vmM+9EPDFdGgc6MyU81dANk2K3+cGrTaifyiXEQe4vjjdS
         WKv8E9AVz0ettpENurHNZPRtXGSGrya+Vqe4ViqtDpFb3mZ25IxtCoZSiKs6i1c/3goi
         UgtQ==
X-Gm-Message-State: AFqh2kpunxQjT13HJXzgpK6bWXuyz3/9NRaa8eX17A1O8He3m4N1r8K2
        /fKmP+eJzlv9OGZ6RB7H/FPw2Q==
X-Google-Smtp-Source: AMrXdXuf7LpOYUkAKPb8RlJlYOqBY3py9GDYv92AnmNkSO/1mk8Qb6hT8EKlZxyCgrA6GPhPwyuifA==
X-Received: by 2002:a1c:f617:0:b0:3d2:191d:2420 with SMTP id w23-20020a1cf617000000b003d2191d2420mr1408672wmc.7.1673923735572;
        Mon, 16 Jan 2023 18:48:55 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b003c6bd12ac27sm39482660wmq.37.2023.01.16.18.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 18:48:55 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 6/8] arm64: dts: qcom: Add msm8939-pm8916.dtsi include
Date:   Tue, 17 Jan 2023 02:48:44 +0000
Message-Id: <20230117024846.1367794-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
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
2.38.1

