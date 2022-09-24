Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DD75E8977
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiIXIFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbiIXIFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:05:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5409210976E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:10 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k10so3534042lfm.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bp5cvx9fIhQfhCXFHIFjM/9YPHYEQQKS2L+foqEXDwU=;
        b=wJaX0XRVq3/HZcH49cBDOzAe4aCvXxOxOloXb8EDWyAQWOSrEtbyE2hWHFCaASDn9q
         sJgD4SFII00/svLYpcYTNrrWm4xLUzWTzKyiMeMZCoqkGKblTm8BexpInHOgiop+S0t0
         uCYfTKQLVm3li+9RTLfS5vTQj1VcqIgwlSHqhHYgOnCaHo/fvq3juOUmnf5+aGpD1vkq
         c6hiF8kLp4oE9vqjw0a0zxyWia+TfCFYgg94h3cSC+ZjPAtrYZ8TI1y0QczR3WIMhCRI
         YgJbSmxemhQQermEYrqGcGgPi9yvmOoSYERkLsX8TmSroD2lUoVWKk7/BunmuDV5YUHj
         bPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bp5cvx9fIhQfhCXFHIFjM/9YPHYEQQKS2L+foqEXDwU=;
        b=Pi9vSteButb5+31/tQ9Lg0ts7cc1RmL/Rz+3zv6tA/0/ghBTmkHaPvt4CBz94v5Q7P
         T6+BjAtBkRDzbeMeYccVpRPz3m6aWzOhajI8r0uBY+o2bQ74ZPf/Lr4P+lyr3/wyS7f+
         2ysxTrcuGeGzFq+ezKm7OSIN1ZiJA1cB4U5L51eoPydUrd7nOkaUtIlK7TZyZavM1Ony
         Lr7R/6NMgGpgXeha2XBgTkrLdl7kBfMmnAuITbYDMOasCGeYV5BlwOLcsG2p9jZW2tCT
         yRD6JkgHtOFGa4nX3gSzoVyFzod5lEfqX1j/0FYsrEJpuFpohh0U4ickMsGQ5W8sMWOV
         z9NA==
X-Gm-Message-State: ACrzQf1NNdU9rSg5qQr0o+c0LoyU9BWb5I09KICvbeP1BWnDOTdoU3Ks
        SKfr830p+U4IGQOed0f70zqUhQ==
X-Google-Smtp-Source: AMsMyM6bZXfKpMDBxJtKN2BWrQlxVCqwlI4LunI8dKDoGfkDPbMiROPC1xEYqiOJpcSWzRrFNlAlkw==
X-Received: by 2002:a05:6512:613:b0:497:a8a6:464e with SMTP id b19-20020a056512061300b00497a8a6464emr4630199lfe.604.1664006708705;
        Sat, 24 Sep 2022 01:05:08 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y2-20020a2e5442000000b0026c41574790sm1696668ljd.30.2022.09.24.01.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 01:05:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 01/32] arm64: dts: qcom: ipq6018-cp01-c1: correct blspi1 pins
Date:   Sat, 24 Sep 2022 10:04:28 +0200
Message-Id: <20220924080459.13084-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
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

When BLSPI1 (originally SPI0, later renamed in commit f82c48d46852
("arm64: dts: qcom: ipq6018: correct QUP peripheral labels")) was added,
the device node lacked respective pin configuration assignment.   It
used also blsp0_spi function but that was probably the same mistake as
naming it SPI0.

Fixes: 5bf635621245 ("arm64: dts: ipq6018: Add a few device nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
index 1ba2eca33c7b..afc2dc79767d 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
+++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
@@ -37,6 +37,8 @@ &blsp1_i2c3 {
 
 &blsp1_spi1 {
 	cs-select = <0>;
+	pinctrl-0 = <&spi_0_pins>;
+	pinctrl-names = "default";
 	status = "okay";
 
 	flash@0 {
@@ -57,7 +59,7 @@ i2c_1_pins: i2c-1-pins {
 
 	spi_0_pins: spi-0-pins {
 		pins = "gpio38", "gpio39", "gpio40", "gpio41";
-		function = "blsp0_spi";
+		function = "blsp1_spi";
 		drive-strength = <8>;
 		bias-pull-down;
 	};
-- 
2.34.1

