Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289C6627B07
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbiKNKvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236031AbiKNKuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:50:54 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2BE1D673
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:50:54 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v17so16655120edc.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2J8KU6i0LNpVXOzmIjyZny4wFnncJ84RnmJbirPKtLU=;
        b=Gj/BMvG7+x8u7dhkNTvuxgnGSfDtbLaVdu/ZEtxLq+SUs9TR2afJqm1midawP/WeBk
         0srL4kRvIxO05ufvSYlzzFnSDJIptJraXepcrXfFt3KQkP5yQQfpTXOCR5dEDM89CvzV
         Aa66/8wg2D8cyD7kuez+BvmXJao69cPwRC+cgzb9QhU/PnerOqWxGSLHnZRakBFoZPSa
         eQuLY2CGIIfqmKUiCLGeWe0znuTIrtCEgMKkQo5me082oVfPI+CERPSKkVHDbzAfQm19
         DrsxKjCyaQWaXYkFO6byxL4/raXX0PnuXuc39ujO2POSgn6fSJ3Y3rapK3sSJejsxpG1
         EjVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2J8KU6i0LNpVXOzmIjyZny4wFnncJ84RnmJbirPKtLU=;
        b=xvka6GXRWDEy7I+atpdJNvaKKJykgPLJoCaBMrF5yV5XNhB8VIAVQRgfTZZTfNXN5R
         fAN+PKuXA1jO223dJaM5OinLjuuZ6V9oe5ofYdor4ybfMBdqNSOIe+lGGiZmmX8XNt1O
         rcLA/Mrz2/nE5O8YdA0MDaq9xMjzkZRZ+JA2YJL4Ua5YHo/+Rq9NpH3aY5yS7mLHplRH
         RtYr7aejLesHy8yj7C8CRIxW8aHIxxO2UkmFbVaDvN5g7At1p+1O/zv4Smp5zQ8/5Tpn
         gBPiAe3diANzre2LwueVqzXxXKi35W3d0kY2OsNUxzE5S2m7FkEct5a17YMc6rkBaCGy
         FDIg==
X-Gm-Message-State: ANoB5pnabvim2WFuLqviwi1oRk6S5upLlKlTBXUm2thxr7+KdbDYlQQY
        zTTqsVJb9S1MEic/CLsvn0YMQg==
X-Google-Smtp-Source: AA0mqf4NKLcFeoeapWbT6WEQi+0wjo9kRUUJ2n04xVSr7ZdUU7IxsQK2Snd7zeDzKSFDXc04hqyaQg==
X-Received: by 2002:aa7:ccc2:0:b0:461:bff7:9783 with SMTP id y2-20020aa7ccc2000000b00461bff79783mr10817601edt.200.1668423052646;
        Mon, 14 Nov 2022 02:50:52 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id kv20-20020a17090778d400b007402796f065sm4037053ejc.132.2022.11.14.02.50.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Nov 2022 02:50:52 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: qcom: sm6375-pdx225: Enable SD card slot
Date:   Mon, 14 Nov 2022 11:50:43 +0100
Message-Id: <20221114105043.36698-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221114105043.36698-1-konrad.dybcio@linaro.org>
References: <20221114105043.36698-1-konrad.dybcio@linaro.org>
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

Set SDHCI VMMC/VQMMC to <=2v96 and allow load setting by the SDHCI
driver, as required by this use case.

Configure the SD Card Detect pin, enable the SDHCI2 controller and
assign it the aforementioned regulators.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
No changes in v3.

Changes in v2:
- remove stray newline
- pick up r-b

 .../qcom/sm6375-sony-xperia-murray-pdx225.dts | 33 +++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index d18167bcb41f..4741b9120aa2 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -164,7 +164,8 @@ pm6125_l4: l4 {
 
 		pm6125_l5: l5 {
 			regulator-min-microvolt = <1650000>;
-			regulator-max-microvolt = <3050000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
 		};
 
 		pm6125_l6: l6 {
@@ -246,7 +247,8 @@ pm6125_l21: l21 {
 
 		pm6125_l22: l22 {
 			regulator-min-microvolt = <2704000>;
-			regulator-max-microvolt = <3544000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
 		};
 
 		pm6125_l23: l23 {
@@ -305,6 +307,33 @@ pmr735a_l7: l7 {
 	};
 };
 
+&sdc2_off_state {
+	sd-cd-pins {
+		pins = "gpio94";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&sdc2_on_state {
+	sd-cd-pins {
+		pins = "gpio94";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
+&sdhc_2 {
+	status = "okay";
+
+	vmmc-supply = <&pm6125_l22>;
+	vqmmc-supply = <&pm6125_l5>;
+
+	cd-gpios = <&tlmm 94 GPIO_ACTIVE_HIGH>;
+};
+
 &tlmm {
 	gpio-reserved-ranges = <13 4>;
 
-- 
2.38.1

