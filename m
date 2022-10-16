Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832BD600243
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJPRXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 13:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiJPRWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:22:49 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C46433A38
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:22:42 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id m6so5453179qkm.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 10:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+tNRNTlMKDtrm8kNyG1z3UONnnvb9QDoC8vEjCWfXA=;
        b=I/jr0rzMzZ/zJIteQJCX0GhpcyGCIUGVi0JzokJKRpJyQQU9KJoOftFdOl2LBSRX27
         YczHDnxqXYMVn2qa0rALdpxwegiczJBZmG7tFk9Pi0j1UKZsWXwvj1m37XVpaeGVp4uG
         T9huhv4F6CktIVo99BmTbJxdM3XalaSx9PcqQwrostkWH5YTtKHirHBVlmX1lXNRqp2A
         DjpAziZ2O83Br0UbHXP1W7tdnxMai37jx4ysHN3YyilxJX40LsjoK7RfsfT8sGf0gLI4
         5QEJ9+OapCph15cKGFZCysqkCEhbaP6FHxa+HAdnz5OE0q73MbsK+xo+RAqDnO6Et/0j
         +Dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+tNRNTlMKDtrm8kNyG1z3UONnnvb9QDoC8vEjCWfXA=;
        b=jC/Lh3ox6mcgmVAu1PB41Lu0VZxYXemeh+O8qAcS8zqq470DZv6HDR9yMWHNT/7bAn
         Z+oob9ol3owPiwOggcyUakutG2N74d7AbhtUueumh5CLPAPtdsXZ1pE+aF8FFEesrCrG
         ODkqVyoORIigcXvM6Wt85XLrvZ7xeSPFnAYNCqkS1xcI1b9e4SwzsvfarUf+plywzIs3
         t9qNyx2z9BDs5F4waMyUwz7iO32J3QYCxaLVOmuof47ZlzZlpNVUwZEeIOdgqdMXSgel
         ZdQtC6NLDgcHJMUsRA/IGlMupoxd/FPUKdHK8XBy+QWpRhAq2lTGfpICZuiXUh0XevNE
         xRfg==
X-Gm-Message-State: ACrzQf3MHL2bCRiaE0wKCDha9vjFwTr7VgYiAgna5tVzbRZ0h2ld/FH3
        CEKdE5jBnwYj23Ov9IiE4tAO8A==
X-Google-Smtp-Source: AMsMyM5zl/GfLpXgUZA3H24gyb3vSQ+oBijf6nOYuy5h4Rz/DOOHHXRXBe6Ut5b+gb/mXNxu2lOS/Q==
X-Received: by 2002:a05:620a:151c:b0:6ec:be9b:3471 with SMTP id i28-20020a05620a151c00b006ecbe9b3471mr5156943qkk.120.1665940960971;
        Sun, 16 Oct 2022 10:22:40 -0700 (PDT)
Received: from krzk-bin.hsd1.pa.comcast.net ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id r5-20020ac87945000000b003431446588fsm6051008qtt.5.2022.10.16.10.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 10:22:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 07/17] arm64: dts: qcom: msm8953: align TLMM pin configuration with DT schema
Date:   Sun, 16 Oct 2022 13:22:02 -0400
Message-Id: <20221016172212.49105-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221016172212.49105-1-krzysztof.kozlowski@linaro.org>
References: <20221016172212.49105-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects TLMM pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.

  qcom/sdm632-fairphone-fp3.dtb: pinctrl@1000000: 'cd-off-pins', 'cd-on-pins', 'gpio-key-default-pins', ....
    do not match any of the regexes: '-state$', 'pinctrl-[0-9]+'

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 70 +++++++++++++--------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index 6b992a6d56c1..db94e6fd18f5 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -460,229 +460,229 @@ tlmm: pinctrl@1000000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
-			uart_console_active: uart-console-active-pins {
+			uart_console_active: uart-console-active-state {
 				pins = "gpio4", "gpio5";
 				function = "blsp_uart2";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			uart_console_sleep: uart-console-sleep-pins {
+			uart_console_sleep: uart-console-sleep-state {
 				pins = "gpio4", "gpio5";
 				function = "blsp_uart2";
 				drive-strength = <2>;
 				bias-pull-down;
 			};
 
-			sdc1_clk_on: sdc1-clk-on-pins {
+			sdc1_clk_on: sdc1-clk-on-state {
 				pins = "sdc1_clk";
 				bias-disable;
 				drive-strength = <16>;
 			};
 
-			sdc1_clk_off: sdc1-clk-off-pins {
+			sdc1_clk_off: sdc1-clk-off-state {
 				pins = "sdc1_clk";
 				bias-disable;
 				drive-strength = <2>;
 			};
 
-			sdc1_cmd_on: sdc1-cmd-on-pins {
+			sdc1_cmd_on: sdc1-cmd-on-state {
 				pins = "sdc1_cmd";
 				bias-disable;
 				drive-strength = <10>;
 			};
 
-			sdc1_cmd_off: sdc1-cmd-off-pins {
+			sdc1_cmd_off: sdc1-cmd-off-state {
 				pins = "sdc1_cmd";
 				bias-disable;
 				drive-strength = <2>;
 			};
 
-			sdc1_data_on: sdc1-data-on-pins {
+			sdc1_data_on: sdc1-data-on-state {
 				pins = "sdc1_data";
 				bias-pull-up;
 				drive-strength = <10>;
 			};
 
-			sdc1_data_off: sdc1-data-off-pins {
+			sdc1_data_off: sdc1-data-off-state {
 				pins = "sdc1_data";
 				bias-pull-up;
 				drive-strength = <2>;
 			};
 
-			sdc1_rclk_on: sdc1-rclk-on-pins {
+			sdc1_rclk_on: sdc1-rclk-on-state {
 				pins = "sdc1_rclk";
 				bias-pull-down;
 			};
 
-			sdc1_rclk_off: sdc1-rclk-off-pins {
+			sdc1_rclk_off: sdc1-rclk-off-state {
 				pins = "sdc1_rclk";
 				bias-pull-down;
 			};
 
-			sdc2_clk_on: sdc2-clk-on-pins {
+			sdc2_clk_on: sdc2-clk-on-state {
 				pins = "sdc2_clk";
 				drive-strength = <16>;
 				bias-disable;
 			};
 
-			sdc2_clk_off: sdc2-clk-off-pins {
+			sdc2_clk_off: sdc2-clk-off-state {
 				pins = "sdc2_clk";
 				bias-disable;
 				drive-strength = <2>;
 			};
 
-			sdc2_cmd_on: sdc2-cmd-on-pins {
+			sdc2_cmd_on: sdc2-cmd-on-state {
 				pins = "sdc2_cmd";
 				bias-pull-up;
 				drive-strength = <10>;
 			};
 
-			sdc2_cmd_off: sdc2-cmd-off-pins {
+			sdc2_cmd_off: sdc2-cmd-off-state {
 				pins = "sdc2_cmd";
 				bias-pull-up;
 				drive-strength = <2>;
 			};
 
-			sdc2_data_on: sdc2-data-on-pins {
+			sdc2_data_on: sdc2-data-on-state {
 				pins = "sdc2_data";
 				bias-pull-up;
 				drive-strength = <10>;
 			};
 
-			sdc2_data_off: sdc2-data-off-pins {
+			sdc2_data_off: sdc2-data-off-state {
 				pins = "sdc2_data";
 				bias-pull-up;
 				drive-strength = <2>;
 			};
 
-			sdc2_cd_on: cd-on-pins {
+			sdc2_cd_on: cd-on-state {
 				pins = "gpio133";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			sdc2_cd_off: cd-off-pins {
+			sdc2_cd_off: cd-off-state {
 				pins = "gpio133";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			gpio_key_default: gpio-key-default-pins {
+			gpio_key_default: gpio-key-default-state {
 				pins = "gpio85";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-pull-up;
 			};
 
-			i2c_1_default: i2c-1-default-pins {
+			i2c_1_default: i2c-1-default-state {
 				pins = "gpio2", "gpio3";
 				function = "blsp_i2c1";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c_1_sleep: i2c-1-sleep-pins {
+			i2c_1_sleep: i2c-1-sleep-state {
 				pins = "gpio2", "gpio3";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c_2_default: i2c-2-default-pins {
+			i2c_2_default: i2c-2-default-state {
 				pins = "gpio6", "gpio7";
 				function = "blsp_i2c2";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c_2_sleep: i2c-2-sleep-pins {
+			i2c_2_sleep: i2c-2-sleep-state {
 				pins = "gpio6", "gpio7";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c_3_default: i2c-3-default-pins {
+			i2c_3_default: i2c-3-default-state {
 				pins = "gpio10", "gpio11";
 				function = "blsp_i2c3";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c_3_sleep: i2c-3-sleep-pins {
+			i2c_3_sleep: i2c-3-sleep-state {
 				pins = "gpio10", "gpio11";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c_4_default: i2c-4-default-pins {
+			i2c_4_default: i2c-4-default-state {
 				pins = "gpio14", "gpio15";
 				function = "blsp_i2c4";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c_4_sleep: i2c-4-sleep-pins {
+			i2c_4_sleep: i2c-4-sleep-state {
 				pins = "gpio14", "gpio15";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c_5_default: i2c-5-default-pins {
+			i2c_5_default: i2c-5-default-state {
 				pins = "gpio18", "gpio19";
 				function = "blsp_i2c5";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c_5_sleep: i2c-5-sleep-pins {
+			i2c_5_sleep: i2c-5-sleep-state {
 				pins = "gpio18", "gpio19";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c_6_default: i2c-6-default-pins {
+			i2c_6_default: i2c-6-default-state {
 				pins = "gpio22", "gpio23";
 				function = "blsp_i2c6";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c_6_sleep: i2c-6-sleep-pins {
+			i2c_6_sleep: i2c-6-sleep-state {
 				pins = "gpio22", "gpio23";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c_7_default: i2c-7-default-pins {
+			i2c_7_default: i2c-7-default-state {
 				pins = "gpio135", "gpio136";
 				function = "blsp_i2c7";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c_7_sleep: i2c-7-sleep-pins {
+			i2c_7_sleep: i2c-7-sleep-state {
 				pins = "gpio135", "gpio136";
 				function = "gpio";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c_8_default: i2c-8-default-pins {
+			i2c_8_default: i2c-8-default-state {
 				pins = "gpio98", "gpio99";
 				function = "blsp_i2c8";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			i2c_8_sleep: i2c-8-sleep-pins {
+			i2c_8_sleep: i2c-8-sleep-state {
 				pins = "gpio98", "gpio99";
 				function = "gpio";
 				drive-strength = <2>;
-- 
2.34.1

