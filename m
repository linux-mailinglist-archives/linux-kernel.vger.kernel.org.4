Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A0D5EC7EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiI0PfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiI0Pe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:34:56 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6065D25D0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:34:51 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a14so11338166ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4+1bZaIVoOr4/FZ9DpEoNNyvB6I9uDIqPPe+8PG5bQg=;
        b=zAbG5b5HaidcQCMd4jIXgylrhvaZAD92Bie270Vav8ot1kGjk+g0++X431acbMi/SK
         e6xytcSQYtVnQqRLO9mB/GUpWFVg8gFlQeIg3VX7HG0pZYcdYXFoGd68z+b+LRBH8+ZV
         5LIa0qeQ1zJ11k5ZpsYn9kJogjIXL4Cq5H32ztOsrgEMgF7o8PRUCzrUnucYf1EXT4qy
         4WYp/dLtP1efmdsLChFKJHMCuPuhKJRm2V3YBSbxjlybda46oMPQayCEP8x1BQA8Jc55
         CwSKQbPDPWC12GIczl2vlQ9WenRh9/nhcS/Ist4SFWb3ZO4GFOAsPwKZJrEqIUkPsGQj
         TYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4+1bZaIVoOr4/FZ9DpEoNNyvB6I9uDIqPPe+8PG5bQg=;
        b=cWTJQuhaYW8RRvWK2TvMHFkx6p0xB67+nDIRHAQbkucE46xehXJlpXlBNbmao0Vcws
         DmM5l8HYQDHAOYcNHktJSydEwWOnvSU+SB5ZHD8xhccqfIdgX4FtVtc5tp6TtJoPtY2Q
         7/kZ5ia3rX4Af/panutqJ4ERQXuPCtu+6DRtPGEvgxlB7pnjd1G/wSxgycrT4eP8b3xo
         vrCuo90CRPKTprYb8yoMMM1oTZxjlAz8vMoDNleH6YiHTwFXCMk1MfZYtNcisZ2BWJSi
         0mM7HB0CgpGrY2ZR+QVbEEtkgM5LC+7s6mCPLvPXx4HF9aE1h5tSm+G/7vmYt/8HOHZc
         x9tQ==
X-Gm-Message-State: ACrzQf31uYsCgj+c0DMhPP7ctJK1WJMyfcHoAtnv9KIvaVM2oBpMeajC
        F8HgrKV44fkbEjXKK4lgZxN45g==
X-Google-Smtp-Source: AMsMyM5CdotfUrBMlNvOE8ZSHN8K5zaL5iFuWe2NPU9hYKVlv+nFMZsXS32c6nWY1wdnpKzMIaWmbg==
X-Received: by 2002:a2e:9608:0:b0:26a:a73b:b8c1 with SMTP id v8-20020a2e9608000000b0026aa73bb8c1mr10335965ljh.328.1664292891469;
        Tue, 27 Sep 2022 08:34:51 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o18-20020a2e7312000000b00268bc2c1ed0sm191592ljc.22.2022.09.27.08.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:34:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 04/12] arm64: dts: qcom: sm8250: align LPASS pin configuration with DT schema
Date:   Tue, 27 Sep 2022 17:34:21 +0200
Message-Id: <20220927153429.55365-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927153429.55365-1-krzysztof.kozlowski@linaro.org>
References: <20220927153429.55365-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects LPASS pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 44 ++++++++++++++--------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 8f402b912c62..e0416d611b66 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2388,8 +2388,8 @@ lpass_tlmm: pinctrl@33c0000{
 				<&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
 			clock-names = "core", "audio";
 
-			wsa_swr_active: wsa-swr-active-pins {
-				clk {
+			wsa_swr_active: wsa-swr-active-state {
+				clk-pins {
 					pins = "gpio10";
 					function = "wsa_swr_clk";
 					drive-strength = <2>;
@@ -2397,7 +2397,7 @@ clk {
 					bias-disable;
 				};
 
-				data {
+				data-pins {
 					pins = "gpio11";
 					function = "wsa_swr_data";
 					drive-strength = <2>;
@@ -2407,8 +2407,8 @@ data {
 				};
 			};
 
-			wsa_swr_sleep: wsa-swr-sleep-pins {
-				clk {
+			wsa_swr_sleep: wsa-swr-sleep-state {
+				clk-pins {
 					pins = "gpio10";
 					function = "wsa_swr_clk";
 					drive-strength = <2>;
@@ -2416,7 +2416,7 @@ clk {
 					bias-pull-down;
 				};
 
-				data {
+				data-pins {
 					pins = "gpio11";
 					function = "wsa_swr_data";
 					drive-strength = <2>;
@@ -2426,14 +2426,14 @@ data {
 				};
 			};
 
-			dmic01_active: dmic01-active-pins {
-				clk {
+			dmic01_active: dmic01-active-state {
+				clk-pins {
 					pins = "gpio6";
 					function = "dmic1_clk";
 					drive-strength = <8>;
 					output-high;
 				};
-				data {
+				data-pins {
 					pins = "gpio7";
 					function = "dmic1_data";
 					drive-strength = <8>;
@@ -2441,8 +2441,8 @@ data {
 				};
 			};
 
-			dmic01_sleep: dmic01-sleep-pins {
-				clk {
+			dmic01_sleep: dmic01-sleep-state {
+				clk-pins {
 					pins = "gpio6";
 					function = "dmic1_clk";
 					drive-strength = <2>;
@@ -2450,7 +2450,7 @@ clk {
 					output-low;
 				};
 
-				data {
+				data-pins {
 					pins = "gpio7";
 					function = "dmic1_data";
 					drive-strength = <2>;
@@ -2459,8 +2459,8 @@ data {
 				};
 			};
 
-			rx_swr_active: rx_swr-active-pins {
-				clk {
+			rx_swr_active: rx-swr-active-state {
+				clk-pins {
 					pins = "gpio3";
 					function = "swr_rx_clk";
 					drive-strength = <2>;
@@ -2468,7 +2468,7 @@ clk {
 					bias-disable;
 				};
 
-				data {
+				data-pins {
 					pins = "gpio4", "gpio5";
 					function = "swr_rx_data";
 					drive-strength = <2>;
@@ -2477,8 +2477,8 @@ data {
 				};
 			};
 
-			tx_swr_active: tx_swr-active-pins {
-				clk {
+			tx_swr_active: tx-swr-active-state {
+				clk-pins {
 					pins = "gpio0";
 					function = "swr_tx_clk";
 					drive-strength = <2>;
@@ -2486,7 +2486,7 @@ clk {
 					bias-disable;
 				};
 
-				data {
+				data-pins {
 					pins = "gpio1", "gpio2";
 					function = "swr_tx_data";
 					drive-strength = <2>;
@@ -2495,8 +2495,8 @@ data {
 				};
 			};
 
-			tx_swr_sleep: tx_swr-sleep-pins {
-				clk {
+			tx_swr_sleep: tx-swr-sleep-state {
+				clk-pins {
 					pins = "gpio0";
 					function = "swr_tx_clk";
 					drive-strength = <2>;
@@ -2504,7 +2504,7 @@ clk {
 					bias-pull-down;
 				};
 
-				data1 {
+				data1-pins {
 					pins = "gpio1";
 					function = "swr_tx_data";
 					drive-strength = <2>;
@@ -2512,7 +2512,7 @@ data1 {
 					bias-bus-hold;
 				};
 
-				data2 {
+				data2-pins {
 					pins = "gpio2";
 					function = "swr_tx_data";
 					drive-strength = <2>;
-- 
2.34.1

