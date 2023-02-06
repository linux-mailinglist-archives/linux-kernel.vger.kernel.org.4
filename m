Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB54668B3C7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjBFBYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjBFBX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:23:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8591217CF6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 17:23:54 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h16so9000946wrz.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 17:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjzGmXwVljBe8mZ+uk4FOoHWI0FZH42+qdZTdioa4oM=;
        b=xYUPuYdwwi+4MbGt7jf2IlCWMeuWaGyFt5LpKxZikN1d6Vr+PTgDYlYikmZc6ULVp5
         4ETYKa2uzbkA6ZBstACR6KOkishx++PwnF3HsVh61dgfadXkpQipHHNAl+kDm2Csv0GL
         7S1jkL2A+nMcFkpY4/guQjJWAn2f4/swbW57zTnY0j5IPNR+89Yp3CmZt5it3/SBdflo
         J2VBOW5b70KrclLC9rbIfUOVZYfPhw7mzdNHcMLASWMaGP2iw8692hHZ2me+CjW8WzBL
         C2g4kLw2qgoOQOElCZsYjYKT52xHAbSJJIEaLGbLq0tdbHLREWjQf7fbWLL21ep82rlF
         KBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HjzGmXwVljBe8mZ+uk4FOoHWI0FZH42+qdZTdioa4oM=;
        b=rXX9fMJ/5MSgCxpuvA0TNt3/tXnm4j79xseei624MwerIlDBbqlbwv+lvqTSMx54yb
         +th6cSDBKUa2khYLgWOLDZU09a9xovRbryNDd55Mh9gDBYCUisNB4DCgNdmX4qK3fqRr
         b/WVdjQxsdN4HHFEWDJNGE1ZuyRJtq8HpNSFgbflGZJZYqUEeaKk3Rw1JDniQJz2IVD+
         bRDRv+/m9QV4eI8KZ8uH1qEBWbNnjSQkJj9OkhbAse6LCqrkLJPM75u5xlGCzk+iRHix
         Ri59rQZoUlcyViGz3SqK2WxQP33YfkY2gTGr7mJP4NLrqU4uxU7+iqxBN3l4xJnXxwx8
         7IZw==
X-Gm-Message-State: AO0yUKXsnvlYQDi2MqAgyNd/mdkIBkhu67rYyG35znXfWFRgUAba/12Z
        DQKBtmtBNCCepqhOetRbfOBpKA==
X-Google-Smtp-Source: AK7set+u35yy0tRXuJeHkMb0QD76zkyGJqcx5AzL/YZ5afiexCXGXekcQInC2ikZCPqMrUoKX4U+1A==
X-Received: by 2002:adf:edcc:0:b0:2c3:e56c:aaf1 with SMTP id v12-20020adfedcc000000b002c3e56caaf1mr2545298wro.38.1675646633038;
        Sun, 05 Feb 2023 17:23:53 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d2-20020a056000186200b002bddd75a83fsm8048027wri.8.2023.02.05.17.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 17:23:52 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, stephan@gerhold.net
Subject: [PATCH v5 3/5] arm64: dts: qcom: Add msm8939-pm8916.dtsi include
Date:   Mon,  6 Feb 2023 01:23:34 +0000
Message-Id: <20230206012336.2130341-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206012336.2130341-1-bryan.odonoghue@linaro.org>
References: <20230206012336.2130341-1-bryan.odonoghue@linaro.org>
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

