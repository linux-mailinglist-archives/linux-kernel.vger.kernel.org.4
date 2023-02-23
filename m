Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9466A0D20
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjBWPhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjBWPhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:37:09 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5590F58B74
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:37:03 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o4-20020a05600c4fc400b003e1f5f2a29cso10970979wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vM1VbzTrcJFX2kv+QNORedSDbeBiRIY8moeW3HsVyE=;
        b=VFh3qIZStHfobxfjGkjeGzZeOlKCm7e1dBqQAKLLL7YaoMnNESuT0A04sPZNPOIo9p
         tkAQvAFSlssK8fiX4LWeqwSx8+ewcpvRlZFx4zWsrLZ61lD/UBxJtrsTRvFpPa8L9gpr
         MEKUM8DRBAqUc5dFsFQuQxz8c1g/vBbjRY3w8nvpQ7VVdoM4M5hQoHYR7YvZuEwSQ6Lk
         JXXafsa/6xYgqt94/3EXUcuo7NGWXamS0teFCE6BXpKiXJ0o379d74hcg12QZTvYWzR4
         AxUEDJNkfGoeBIbdwvJ3iCFSnIlAYOw/SWAOxrwQwk6TlrBsTu0IPsuGCcEBOn11kkcG
         ubJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vM1VbzTrcJFX2kv+QNORedSDbeBiRIY8moeW3HsVyE=;
        b=Pp23sRQS+dO9GhaH47yu2gHx4J2hA62epCo8Fa5AZF1VnaxF18xWKLUiYbT0khzgEi
         BvlvLPzd8FT6OuO2j6CmOVHB6WeuxvkP353TMP0bJOcNIPeC5x+ecD4GLcQhcSaeHdoX
         KpkdJKTTDj4vrJhoi0EvwEiuJUWNUgW2nY+acDqpM4O9yOThxxJlZpa+uANu/1oo+MQC
         rJnvKjVvuljvX8jqyvmA8viQAtNJ0uzSdoWl24y8UpZlD7jzLXp/bm6ocjWrxWJaMMw6
         KxpLaB0NNTWYD6AQlte7NszAE6bXyyXXUGwdFAGaMWvz1c96WePZt5vSXvxfzyxchizn
         UUtA==
X-Gm-Message-State: AO0yUKVp2GC8AwfJKq8VEZd5Wam5r0S79AdUe5b/COimwwxnVV6h8rVA
        YX2+LyNyAregvtujDv7xhbg31Q==
X-Google-Smtp-Source: AK7set/FrTr77uOkLhOM1AU6VZ37Q+dZn6O3+u7S8c27BjgX8hPCEIHajXXCB8XisL54/QB5n3bgZw==
X-Received: by 2002:a05:600c:1614:b0:3e2:662:ade6 with SMTP id m20-20020a05600c161400b003e20662ade6mr4049170wmn.26.1677166621865;
        Thu, 23 Feb 2023 07:37:01 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18-20020a05600c0a5200b003e733a973d2sm11076978wmq.39.2023.02.23.07.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 07:37:01 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, stephan@gerhold.net
Subject: [PATCH v7 3/5] arm64: dts: qcom: Add msm8939-pm8916.dtsi include
Date:   Thu, 23 Feb 2023 15:36:53 +0000
Message-Id: <20230223153655.262783-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230223153655.262783-1-bryan.odonoghue@linaro.org>
References: <20230223153655.262783-1-bryan.odonoghue@linaro.org>
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
2.39.1

