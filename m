Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A2A671A6E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjARLVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjARLTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:19:53 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573766D343
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:35:14 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h16so33436049wrz.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lu9NeKrCPTgPXNywztLAN6YS+xgp77uKV6p8fRsddmw=;
        b=NklBNzdHxym8hhVOWn75ZpV/v0klHWGimQbSivaGHxeh4WmoqwWI4muR9Rpd6273F3
         ywsFfhV3Rx1Dqdb9L7bklr9jci8wcHarRTKbdp4mUUHxySllUtCfQumHW9qEW9W0XTCt
         HOHffaB6rQfy/j/4HJEfU1q4HQDxnB0xF6AlD16h+VcjQwvi6SR387iyRsSKshwmefp3
         RN52LAMZ7P5HlBBMjYknXHM+gNvPJj+F70PMOiRJKEU8fc8CP5JN3PTztq1b6pZB4HD9
         cp8MP+f5NNLlbrQQg+l6ViOTa+pieOHwGzpk6+xtiZr1CfXFR+wwJv69fgbIQz4fwpdh
         NHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lu9NeKrCPTgPXNywztLAN6YS+xgp77uKV6p8fRsddmw=;
        b=uQRcOQ7cOlxw8dEeAQ6tAiOFl0fgd6bWnHk/+X2ysSuvTGDjq0su+W35hq1+t+gGZs
         XG6KrNbskp8N1+DyVJhNXLudsRBqKf9Tl6lN5tUtm2uTqkv18vh8AkrNWKWFTrGGyeze
         pgvtrQVSePvDAnQA8DZBP+S/fYEfqpgohbWZU96mk6JkXW2mC+eDEljkiFg4xkJ6QrNd
         qPLhzF/hjnMuDtH2arXQL4Dy/yYr1eMmSXdJ2ZIYEp17PnwhVfMtFDYuR8JaraGoAUR2
         KAajOPkF/ie1Og/OOHNKw4uu9S7IC7Z91bF60KJ+qjmjECFS+76AW2dhX4U0b6v0dIUO
         TZJA==
X-Gm-Message-State: AFqh2kqj+eOTQY/O4lgGQdUWuoB+rVapOuYw82nq8cYjcuGxUJwnjz9w
        oH//PxscerArI4yL0GGtEkVT6Q==
X-Google-Smtp-Source: AMrXdXuioPX3CcOJ7PqYvQD4+aEm5IPY4MEt5v4JJcsEMuPl9hiGn+yVSIB9gvNaUNgqdw1BwAjPBg==
X-Received: by 2002:adf:e5ce:0:b0:2bd:dd95:4cad with SMTP id a14-20020adfe5ce000000b002bddd954cadmr14575194wrn.40.1674038112906;
        Wed, 18 Jan 2023 02:35:12 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ba29-20020a0560001c1d00b002b065272da2sm10076731wrb.13.2023.01.18.02.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 02:35:10 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 6/6] arm64: dts: qcom: sdm845-audio-wcd9340: commonize clocks
Date:   Wed, 18 Jan 2023 11:34:58 +0100
Message-Id: <20230118103458.107434-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118103458.107434-1-krzysztof.kozlowski@linaro.org>
References: <20230118103458.107434-1-krzysztof.kozlowski@linaro.org>
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

Clock for WCD9340 is coming from the SoC and is the same in all users,
so move it to common file to reduce the code duplication (which still
allows further customizations per board).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. Add Rb tag.
2. Split from previous patchset.
---
 arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi           | 3 +++
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts                   | 2 --
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 --
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts           | 2 --
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts         | 2 --
 arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts             | 2 --
 6 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
index d0c77a8c1985..c82a8f21cbdc 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-audio-wcd9340.dtsi
@@ -29,6 +29,9 @@ wcd9340: codec@1,0 {
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
+			clock-names = "extclk";
+			clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
+
 			#clock-cells = <0>;
 			clock-frequency = <9600000>;
 			clock-output-names = "mclk";
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index e0289973d3e4..d9dd0136ff62 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -1034,8 +1034,6 @@ &venus {
 };
 
 &wcd9340 {
-	clock-names = "extclk";
-	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
 	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
 	vdd-buck-supply = <&vreg_s4a_1p8>;
 	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 5aca280b3994..fb41ac8707f0 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -484,8 +484,6 @@ &venus {
 };
 
 &wcd9340 {
-	clock-names = "extclk";
-	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
 	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
 	vdd-buck-supply = <&vreg_s4a_1p8>;
 	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 1ceeea0885b9..d9c4af06ab63 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
@@ -692,8 +692,6 @@ &venus {
 };
 
 &wcd9340 {
-	clock-names = "extclk";
-	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
 	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
 	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
 	vdd-buck-supply = <&vreg_s4a_1p8>;
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index db868af1f399..aeee716a1f9a 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -694,8 +694,6 @@ &venus {
 };
 
 &wcd9340 {
-	clock-names = "extclk";
-	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
 	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
 	vdd-buck-supply = <&vreg_s4a_1p8>;
 	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
index 6a9ced334f19..7ff6ac6f820e 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -602,8 +602,6 @@ &venus {
 };
 
 &wcd9340 {
-	clock-names = "extclk";
-	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
 	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
 	vdd-buck-supply = <&vreg_s4a_1p8>;
 	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
-- 
2.34.1

