Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FA8677692
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjAWIn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjAWInQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:43:16 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D181C1E9E6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:43:14 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k16so8369256wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+50E74LIwt2qnQP5k9lnFoKkan1KmgeAjiTYyPnB5qY=;
        b=JsZBpButlSUwVfHf7fEWZdB9s6KlsWPz9sJibHjsO3RCLOUluoxx0g3ptbN7RlBPn+
         pIe2TM9FFz7Ei+ssqv//eg5fQf0QY12vh52mgOLbu7eeoeTv4IeHccFPYlkhqlR2EoC+
         dL1rItZru80U9fH7q7zKlZ0Rdi6h0b7Cc57L6jxHHuXzJjYxUEZY2jfmB+96ekvsw44O
         R5Dar3oy9tM9HxUZGxuZZ+aUQtlyqG+gOoYGY/upv0/PhHGP3Mji99P8e12gWyr0DxdL
         yp2Y3RY4cE9t3+kqniiUKUvrYiKmzuWxVxKF6d3GvHpHXhupIlYcH4mEB2h9HftYcTsT
         bfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+50E74LIwt2qnQP5k9lnFoKkan1KmgeAjiTYyPnB5qY=;
        b=aWJ6Kzv/CFeqrde5ppoyHwy2hbsRmMzUcTzWihX7+VfXBR5r6uj5ASXGtK1OoauE47
         eo+rAzxmOObPg4XHugkS6qkdhRv/JebJgEZUHWoN1pFpsrNghrlGM7mrWzMQHHvVcqW2
         f2kahk4AA7uyF/MHfiNzwAB5e7kRfGIB/QOaFVkUcCC57PlBxynuhqbGcq1pB5MMk6HB
         oiw376ikY/SvAIxjoMVlODQi9NCcMt/WrykirjfyzKhOUFtaIOxw9XYXFSRzYeIHOcnZ
         KIqnrMRyzmAfY+BBcMn1TPNrj/OZiakqqR+MEu7MHtfDTkm+7C/ydewOX/Hxc0GwP6cL
         3oXA==
X-Gm-Message-State: AFqh2krktyMMcL3UZ6qJfpuPdFFqdDA9ZGHMXYCSbog031VmXGbd3p5m
        ag0F/Ec4AV7kPxymhP5Zjh/T0g==
X-Google-Smtp-Source: AMrXdXvqEufLZtBgMATbVgfRXbfErpXQawD3j31EcFUJLKPeX+QEQWJtefDvaS65FGyUvMf0zoJURA==
X-Received: by 2002:a05:600c:1695:b0:3da:f502:83b5 with SMTP id k21-20020a05600c169500b003daf50283b5mr23316158wmn.2.1674463394438;
        Mon, 23 Jan 2023 00:43:14 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l30-20020a05600c1d1e00b003c6b70a4d69sm10974120wms.42.2023.01.23.00.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 00:43:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v3 6/6] arm64: dts: qcom: sdm845-audio-wcd9340: commonize clocks
Date:   Mon, 23 Jan 2023 09:43:00 +0100
Message-Id: <20230123084300.22353-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123084300.22353-1-krzysztof.kozlowski@linaro.org>
References: <20230123084300.22353-1-krzysztof.kozlowski@linaro.org>
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

Clock for WCD9340 is coming from the SoC and is the same in all users,
so move it to common file to reduce the code duplication (which still
allows further customizations per board).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v2:
1. None

Changes since v1:
1. Add Rb tag.
2. Split from previous patchset.
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts                   | 2 --
 arch/arm64/boot/dts/qcom/sdm845-wcd9340.dtsi                 | 3 +++
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 --
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts           | 2 --
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts         | 2 --
 arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts             | 2 --
 6 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index c7a12257ac75..90c981bccc14 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -1078,8 +1078,6 @@ &venus {
 };
 
 &wcd9340 {
-	clock-names = "extclk";
-	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
 	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
 	vdd-buck-supply = <&vreg_s4a_1p8>;
 	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-wcd9340.dtsi b/arch/arm64/boot/dts/qcom/sdm845-wcd9340.dtsi
index 33718cb95c83..0d7c37f39176 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-wcd9340.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-wcd9340.dtsi
@@ -29,6 +29,9 @@ wcd9340: codec@1,0 {
 			interrupt-controller;
 			#interrupt-cells = <1>;
 
+			clock-names = "extclk";
+			clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
+
 			#clock-cells = <0>;
 			clock-frequency = <9600000>;
 			clock-output-names = "mclk";
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index 57f1c5925cb0..d9ad762c8d01 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -534,8 +534,6 @@ &venus {
 };
 
 &wcd9340 {
-	clock-names = "extclk";
-	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
 	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
 	vdd-buck-supply = <&vreg_s4a_1p8>;
 	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-polaris.dts
index 468867363f18..3dadcfc40341 100644
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
index a461cb7f6bd2..5380ccf976f9 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -738,8 +738,6 @@ &venus {
 };
 
 &wcd9340 {
-	clock-names = "extclk";
-	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
 	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
 	vdd-buck-supply = <&vreg_s4a_1p8>;
 	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
index d4ae2788bada..23af707741df 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -647,8 +647,6 @@ &venus {
 };
 
 &wcd9340 {
-	clock-names = "extclk";
-	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
 	reset-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
 	vdd-buck-supply = <&vreg_s4a_1p8>;
 	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
-- 
2.34.1

