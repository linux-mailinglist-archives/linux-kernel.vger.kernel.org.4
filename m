Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5F66E8BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbjDTHvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjDTHv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:51:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8F459F0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:51:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id xd13so4395500ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681977062; x=1684569062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYQm9bqfWbGovdDlFs25QuaSojyrw56mcHye0Uo4Jns=;
        b=ZyNm3igKig/6Bjtxbz7YFIE2ARwWePlIrMjz9LgoU9obvwIQkmlb8+CFtmdbHlf6eY
         plvmvgUUCXNelZh1Bqsz58ZymGbjdDYggUU8tYyxJwk/MCW5DgyuedyaeE6csl3OETWj
         4w/AUbNfCRCMlvrAJ9CNQYm9K0HJp0ggOjV2hhugx8VFiTWC2b5JNu5zhncD1kX5QQs8
         fe3VKmSV4hCT1SWaA3HdIwYYDfTSmWi9zOQdBbIxebXn37sGQkL+fBUPcuA3PNqL/b04
         1UBntrCGT9lgURlzrayr1GNTYRnKxGxCwgnbzA8ufH4KfoW0itwYGkgSoiyT7GRnCT42
         5YDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681977062; x=1684569062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYQm9bqfWbGovdDlFs25QuaSojyrw56mcHye0Uo4Jns=;
        b=NtMkyb7AENoyT+E4SGF3ePWCVzN7SYpjG/YFptTXbL/O/+2JzaJxoXsUZog02Sxrx8
         NBbF+LBeWPUyoJgx2wus9NSormgv/JrGdbylGW/DT3klZSOTXLz40FqIrrnxEATjeH9j
         dcWQU0RTrYAseS9Qu7JlbFFrfHiMvMFXlpgl4Av0hBANaxA0yuFYWkNRZRT0Md8YVbG+
         xRJqT8gWAhn45sohWjEX8dkKUmICzxNUj5VIQU8uYC9pb0pau5WLnds63wzUeuIA+Keu
         Aj86hzhOHNToBLe9YLHWr9L462yk+XBJbZzKfTVJ0yCD3Hbp2iSxIuiLsEh6NLMggsQQ
         aNGg==
X-Gm-Message-State: AAQBX9d1sbtRDdo8K99K8TiSZrOesdjjdJ9O/4555Z+UAIy0NQz8muiB
        r0psWjal48Se0HlwcmqOcPKniw==
X-Google-Smtp-Source: AKy350avI9KqCaLthA6mKRxJ5xHFUmcS361QfzPf1Splwt09/yu8ixM47ih3GlKA6lZaogoZZdzSDg==
X-Received: by 2002:a17:907:2d8c:b0:94e:4fac:d92b with SMTP id gt12-20020a1709072d8c00b0094e4facd92bmr702396ejc.58.1681977062571;
        Thu, 20 Apr 2023 00:51:02 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bcb8:77e6:8f45:4771])
        by smtp.gmail.com with ESMTPSA id h25-20020a50ed99000000b00505060e4280sm447165edr.94.2023.04.20.00.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 00:51:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 06/10] ARM: dts: qcom: ipq8064: correct LED node names
Date:   Thu, 20 Apr 2023 09:50:49 +0200
Message-Id: <20230420075053.41976-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
References: <20230420075053.41976-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO LEDs is not a bus, so drop unit-address and also start suffix
numbering from 0:

  Warning (unit_address_vs_reg): /soc/leds/led@7: node has a unit name, but no reg or ranges property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts |  2 +-
 arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi  | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
index 47a5d1849c72..52eadefd2fb4 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
@@ -203,7 +203,7 @@ leds {
 			pinctrl-0 = <&leds_pins>;
 			pinctrl-names = "default";
 
-			led@7 {
+			led-0 {
 				label = "rb3011:green:user";
 				color = <LED_COLOR_ID_GREEN>;
 				gpios = <&qcom_pinmux 33 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
index 411c8d63c38e..c5abe7151f14 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
@@ -92,34 +92,34 @@ leds {
 			pinctrl-0 = <&leds_pins>;
 			pinctrl-names = "default";
 
-			led@7 {
+			led-0 {
 				label = "led_usb1";
 				gpios = <&qcom_pinmux 7 GPIO_ACTIVE_HIGH>;
 				linux,default-trigger = "usbdev";
 				default-state = "off";
 			};
 
-			led@8 {
+			led-1 {
 				label = "led_usb3";
 				gpios = <&qcom_pinmux 8 GPIO_ACTIVE_HIGH>;
 				linux,default-trigger = "usbdev";
 				default-state = "off";
 			};
 
-			led@9 {
+			led-2 {
 				label = "status_led_fail";
 				function = LED_FUNCTION_STATUS;
 				gpios = <&qcom_pinmux 9 GPIO_ACTIVE_HIGH>;
 				default-state = "off";
 			};
 
-			led@26 {
+			led-3 {
 				label = "sata_led";
 				gpios = <&qcom_pinmux 26 GPIO_ACTIVE_HIGH>;
 				default-state = "off";
 			};
 
-			led@53 {
+			led-4 {
 				label = "status_led_pass";
 				function = LED_FUNCTION_STATUS;
 				gpios = <&qcom_pinmux 53 GPIO_ACTIVE_HIGH>;
-- 
2.34.1

