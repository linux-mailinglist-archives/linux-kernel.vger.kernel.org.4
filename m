Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8626B07AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjCHNAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjCHM71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:59:27 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59B385379
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 04:59:19 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o12so65297633edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 04:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678280359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mfOwfdbZ8exDjskYwjwEpahRmFliTcBB+dyiGdmM5Y=;
        b=ULyvRxpUzy0CMYgaNIiHjXHo5dPts/WbAbqxkj/5ve1xBAKhXPYUSKHTFsw6KEBxgI
         +zBQh/xbnhgIjJSvqtGHhK5FKaGTiEmhz8uGDqCWaeYOdYCa5xP+rVlVz5uUjWtymSsi
         8hTSYC55YFlgpPXufnajXUR2NFM2wqcFZBXps7IQ2WT6dUvrdhuPKRV+aMrltPtBisKR
         P0bMV/bz2UUt/+k0xVVHfH4RnI4Er+cI22gBrt8+sxeCW4Z7etkW52q6S8PIzC7Hndxk
         FMMwP8o0iJUz92d1xMT+Z3KPcLPlvXxsXMXE6HPpaBnJ+oh7TyK+ynmNh7cgvKQJkJcq
         cGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678280359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mfOwfdbZ8exDjskYwjwEpahRmFliTcBB+dyiGdmM5Y=;
        b=BisvysuZTMIlxFGVGrk1Q3WM7xacUF9ZYHsGf/xw3hJtzVdFSBMtT57Fh4pl8DG3er
         pE3GHM2yDQxybXIpGUB4gjQQr39zGUg3D2W3QFFK5ba+LYw+DXlUCVhFHVjcD8q4pHG5
         7o9RwFPmlrZ1NJfMCF2yhaLLLt/WgZ1+W7cfTUVaquUYO0nyrgnWfOn74zAchQAV0YXR
         cS3elmcd/oB5jtzzbDl+5fdfRHz4rR2wJoKrfSfCSM2WhqD2KgficbBNU/gv662EIBRS
         anumyQDOyTHfJtJzjkL7RUGRGDZ3FpZ+9/ytb0h0f1xRPgfUlU7hU6kqF0VXVir0Pog5
         sjVA==
X-Gm-Message-State: AO0yUKUveZczWvNdbtrqXLB5ZDP1eZ2nHWtn9Nd6VlwNot4JEhLT2xxl
        9jfJqDRpA0N/AqsXiBstHTJBGg==
X-Google-Smtp-Source: AK7set9oNdnuX0f4MvhnHStYIyiVAVetbxLKMQwiPT3mSYnsKFPTKtwHVaG7Ct3T6eSirdqajWRyPw==
X-Received: by 2002:a17:907:7f0b:b0:888:7ac8:c0f4 with SMTP id qf11-20020a1709077f0b00b008887ac8c0f4mr17839200ejc.25.1678280359078;
        Wed, 08 Mar 2023 04:59:19 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063b5900b008d0dbf15b8bsm7464141ejf.212.2023.03.08.04.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 04:59:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 11/11] arm64: dts: qcom: msm8996-oneplus: do not enable incomplete nodes
Date:   Wed,  8 Mar 2023 13:59:06 +0100
Message-Id: <20230308125906.236885-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308125906.236885-1-krzysztof.kozlowski@linaro.org>
References: <20230308125906.236885-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

status=okay should appear in final place where all required properties
are provided, because that makes the code the easiest to read.  Move the
status from common OnePlus DTSI to board DTS.  No functional changes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. None
---
 .../boot/dts/qcom/msm8996-oneplus-common.dtsi   | 17 -----------------
 arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts   |  6 ++++++
 arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dts  |  6 ++++++
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
index 104deaee74e5..2adadc1e5b7c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-oneplus-common.dtsi
@@ -85,10 +85,6 @@ wlan_en: wlan-en-regulator {
 	};
 };
 
-&adsp_pil {
-	status = "okay";
-};
-
 &blsp1_i2c3 {
 	status = "okay";
 
@@ -183,10 +179,6 @@ &dsi0_phy {
 	status = "okay";
 };
 
-&gpu {
-	status = "okay";
-};
-
 &hsusb_phy1 {
 	vdd-supply = <&vreg_l28a_0p925>;
 	vdda-pll-supply = <&vreg_l12a_1p8>;
@@ -215,7 +207,6 @@ &mmcc {
 
 &mss_pil {
 	pll-supply = <&vreg_l12a_1p8>;
-	status = "okay";
 };
 
 &pcie0 {
@@ -548,10 +539,6 @@ wcd9335: codec@1,0 {
 	};
 };
 
-&slpi_pil {
-	status = "okay";
-};
-
 &sound {
 	compatible = "qcom,apq8096-sndcard";
 	model = "OnePlus3";
@@ -812,7 +799,3 @@ &usb3_dwc3 {
 
 	maximum-speed = "high-speed";
 };
-
-&venus {
-	status = "okay";
-};
diff --git a/arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts b/arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts
index 1bdc1b134305..dfe75119b8d2 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-oneplus3.dts
@@ -17,6 +17,7 @@ / {
 
 &adsp_pil {
 	firmware-name = "qcom/msm8996/oneplus3/adsp.mbn";
+	status = "okay";
 };
 
 &battery {
@@ -25,6 +26,8 @@ &battery {
 };
 
 &gpu {
+	status = "okay";
+
 	zap-shader {
 		firmware-name = "qcom/msm8996/oneplus3/a530_zap.mbn";
 	};
@@ -33,12 +36,15 @@ zap-shader {
 &mss_pil {
 	firmware-name = "qcom/msm8996/oneplus3/mba.mbn",
 			"qcom/msm8996/oneplus3/modem.mbn";
+	status = "okay";
 };
 
 &slpi_pil {
 	firmware-name = "qcom/msm8996/oneplus3/slpi.mbn";
+	status = "okay";
 };
 
 &venus {
 	firmware-name = "qcom/msm8996/oneplus3/venus.mbn";
+	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dts b/arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dts
index 34f837dd0c12..51fce65e89f1 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dts
+++ b/arch/arm64/boot/dts/qcom/msm8996-oneplus3t.dts
@@ -18,6 +18,7 @@ / {
 
 &adsp_pil {
 	firmware-name = "qcom/msm8996/oneplus3t/adsp.mbn";
+	status = "okay";
 };
 
 &battery {
@@ -26,6 +27,8 @@ &battery {
 };
 
 &gpu {
+	status = "okay";
+
 	zap-shader {
 		firmware-name = "qcom/msm8996/oneplus3t/a530_zap.mbn";
 	};
@@ -34,12 +37,15 @@ zap-shader {
 &mss_pil {
 	firmware-name = "qcom/msm8996/oneplus3t/mba.mbn",
 			"qcom/msm8996/oneplus3t/modem.mbn";
+	status = "okay";
 };
 
 &slpi_pil {
 	firmware-name = "qcom/msm8996/oneplus3t/slpi.mbn";
+	status = "okay";
 };
 
 &venus {
 	firmware-name = "qcom/msm8996/oneplus3t/venus.mbn";
+	status = "okay";
 };
-- 
2.34.1

