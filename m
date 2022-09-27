Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8CD5EC7E7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbiI0Pe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiI0Per (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:34:47 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7F0E42
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:34:43 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a14so11337617ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=adnw/70iR35kRw0Wjt+Tvx+wL5mop5CypxFcUPW7oIA=;
        b=uYM5g7pOfSMKb6bnCbU+BVGkHLs9mATFqL2dbWruIYJVJ//+tlGoFfjLg5r1j/+Ypc
         jcW6P45YsXO2joWu5Jt+jAKHnvXuKfd71jby+hIXF0169nWNUW5auwBgaEArF5ZGlyfZ
         JlS+7nkaJY0WS/T2wUbZpwbsmI5Pcz1FSW1BKQkBAWJ/1uPLAujnNtlhtbPwZUzjvy96
         cbXsbbCH6+W8TVYCjp1/HPHZfrIyrrzWlXuuSDk3kU80/iwUa1XGzxQD8D+7XL74G3pB
         OzKVCJz9Zs13ILT44Puyyw6yCzr1bEbKKoPMey8zii6WRyDOvILEUU2LnDVWNZqlRBG7
         ze/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=adnw/70iR35kRw0Wjt+Tvx+wL5mop5CypxFcUPW7oIA=;
        b=Lqw8Jxr3AsdWTQ4uScUjTZnXVf/sHOBlAxpx8pUCGuQLLjl7paq0hCdkIyjYsNlI0Q
         z0xJeVDhCNjDUbUnrfY3RcXFNMpKRRfHX8PWZw15Gv1XSghOlCF/+Rk3huje3Z1yJlvj
         MWio1FY5vkPukqwaxXg42N9pdrhMKJEo/2ZaGlxWcNGioIls9akf4OMwH8cC0AKRDmyL
         V8R0pBp3G8ISpRAFVgrCOqNWd6m/ZnKRaM9CYLJ4HAEPZdiW7J/i/9AYKx8Hmkz9kZH9
         EWhOhiWTg0ovjMAvZ5LxSamTHzXONDfdXf9O1RM2w7+v5Kua/wJOTQvOdAAdGKxGnGlm
         6JNg==
X-Gm-Message-State: ACrzQf3l0vRjy+YGiIczKvLiNJ1Yus59x9SmpshLZ21lRbA3hdeqjxQX
        pmyn052jlb/HRXQJiADcZjzrCQ==
X-Google-Smtp-Source: AMsMyM4uG318qVxMtsQUl4X+Y7tZq1QxSeKbR282vQxuFwIUXbc/27+rUexo1G155gm0S40YNZ3Wtw==
X-Received: by 2002:a05:651c:1112:b0:26c:7323:3f2c with SMTP id e18-20020a05651c111200b0026c73233f2cmr9909624ljo.4.1664292881644;
        Tue, 27 Sep 2022 08:34:41 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o18-20020a2e7312000000b00268bc2c1ed0sm191592ljc.22.2022.09.27.08.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:34:39 -0700 (PDT)
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
Subject: [PATCH v2 02/12] arm64: dts: qcom: sc7280: align LPASS pin configuration with DT schema
Date:   Tue, 27 Sep 2022 17:34:19 +0200
Message-Id: <20220927153429.55365-3-krzysztof.kozlowski@linaro.org>
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
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 32 ++++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 8823b75a6f1b..28e3fb9992d9 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2432,82 +2432,82 @@ lpass_tlmm: pinctrl@33c0000 {
 			#gpio-cells = <2>;
 			gpio-ranges = <&lpass_tlmm 0 0 15>;
 
-			lpass_dmic01_clk: dmic01-clk {
+			lpass_dmic01_clk: dmic01-clk-state {
 				pins = "gpio6";
 				function = "dmic1_clk";
 			};
 
-			lpass_dmic01_clk_sleep: dmic01-clk-sleep {
+			lpass_dmic01_clk_sleep: dmic01-clk-sleep-state {
 				pins = "gpio6";
 				function = "dmic1_clk";
 			};
 
-			lpass_dmic01_data: dmic01-data {
+			lpass_dmic01_data: dmic01-data-state {
 				pins = "gpio7";
 				function = "dmic1_data";
 			};
 
-			lpass_dmic01_data_sleep: dmic01-data-sleep {
+			lpass_dmic01_data_sleep: dmic01-data-sleep-state {
 				pins = "gpio7";
 				function = "dmic1_data";
 			};
 
-			lpass_dmic23_clk: dmic23-clk {
+			lpass_dmic23_clk: dmic23-clk-state {
 				pins = "gpio8";
 				function = "dmic2_clk";
 			};
 
-			lpass_dmic23_clk_sleep: dmic23-clk-sleep {
+			lpass_dmic23_clk_sleep: dmic23-clk-sleep-state {
 				pins = "gpio8";
 				function = "dmic2_clk";
 			};
 
-			lpass_dmic23_data: dmic23-data {
+			lpass_dmic23_data: dmic23-data-state {
 				pins = "gpio9";
 				function = "dmic2_data";
 			};
 
-			lpass_dmic23_data_sleep: dmic23-data-sleep {
+			lpass_dmic23_data_sleep: dmic23-data-sleep-state {
 				pins = "gpio9";
 				function = "dmic2_data";
 			};
 
-			lpass_rx_swr_clk: rx-swr-clk {
+			lpass_rx_swr_clk: rx-swr-clk-state {
 				pins = "gpio3";
 				function = "swr_rx_clk";
 			};
 
-			lpass_rx_swr_clk_sleep: rx-swr-clk-sleep {
+			lpass_rx_swr_clk_sleep: rx-swr-clk-sleep-state {
 				pins = "gpio3";
 				function = "swr_rx_clk";
 			};
 
-			lpass_rx_swr_data: rx-swr-data {
+			lpass_rx_swr_data: rx-swr-data-state {
 				pins = "gpio4", "gpio5";
 				function = "swr_rx_data";
 			};
 
-			lpass_rx_swr_data_sleep: rx-swr-data-sleep {
+			lpass_rx_swr_data_sleep: rx-swr-data-sleep-state {
 				pins = "gpio4", "gpio5";
 				function = "swr_rx_data";
 			};
 
-			lpass_tx_swr_clk: tx-swr-clk {
+			lpass_tx_swr_clk: tx-swr-clk-state {
 				pins = "gpio0";
 				function = "swr_tx_clk";
 			};
 
-			lpass_tx_swr_clk_sleep: tx-swr-clk-sleep {
+			lpass_tx_swr_clk_sleep: tx-swr-clk-sleep-state {
 				pins = "gpio0";
 				function = "swr_tx_clk";
 			};
 
-			lpass_tx_swr_data: tx-swr-data {
+			lpass_tx_swr_data: tx-swr-data-state {
 				pins = "gpio1", "gpio2", "gpio14";
 				function = "swr_tx_data";
 			};
 
-			lpass_tx_swr_data_sleep: tx-swr-data-sleep {
+			lpass_tx_swr_data_sleep: tx-swr-data-sleep-state {
 				pins = "gpio1", "gpio2", "gpio14";
 				function = "swr_tx_data";
 			};
-- 
2.34.1

