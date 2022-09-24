Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E51B5E89B6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 10:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiIXIFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 04:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiIXIFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 04:05:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529DCF1855
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id s6so3513452lfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 01:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=IKv3EVCnm3OfvhFspuLmPC8QUak40NUPqPQWboNeqpg=;
        b=a8Ih4jJzos8myLFJ8pH81tEyuv87eenShm0w5oCV1MWiN68B7AjI9AR4VrP9BRBQc6
         WdgY6Lvl9ipYAxq//zlfGDH+lizqFDE8YEjQtFpG34uhY6NyxXFgZ69A/Q5JvVy/mlgi
         z4IsijSji6hyVGS5fH1KKGQrKjRcCl1YL70dXObjY4SvqyXnuunf64B/HtXHPc4W2Uof
         Q/rDX3RJZ6LFCIbCSCRTTPfMkU1f5A3kXbCi4td7ae8B9lfqvQx/7rPpiUHZf6bei7sc
         ylkLwZzutyMvQPzhDFNS7CwMDBhOt1jA6IkbiN6zrVjOAEQGOFVQmbJOg6NReJi6yloh
         dXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=IKv3EVCnm3OfvhFspuLmPC8QUak40NUPqPQWboNeqpg=;
        b=RMRdoXogGuX0dMN2axUv0qWYSKnUt0XxBB3NNSjBJA9yaXVuDZP78ntgNjeobKbD2x
         NInuhN612YU4fAg1BgHDi2Ksb/BRD/4i+2urEWJHDyQGzOm6CZkQ5BgTbfaLIULtbqWd
         7+yHoDpf11D8yqUNUQX5ojFC+odi3PbnUG9SiX+Q0PjdPR+LP/85OdojVwC2mV4wouGb
         VWZXWQAZGDjzBdCsbvA2zII1G0vcMgeOs/EvcB4c9hd95LlDFkweJmmRxLkGABEJMwl5
         lYDhO16mQ5EciILchk3JsalqXeEAf5fVTXnOGwXC81gC+PXs4bUJ6xG5hoj1nkI44b3f
         NeAw==
X-Gm-Message-State: ACrzQf2ZSs1gWCWOchHIYCYNTujs2YC2lctGX+1c1MO/tLBsGpewpHDI
        IIDqQK3EfCk0pvWGYhZnyK8Nlg==
X-Google-Smtp-Source: AMsMyM56Tg1k54SLIQ6/YlCLFkRW7fBNyJBNCnRzZ4FQqsLY8/b5KE5vm8sMWM+LGw1tMp4TdS3mkA==
X-Received: by 2002:a05:6512:1283:b0:499:d0a3:3ca8 with SMTP id u3-20020a056512128300b00499d0a33ca8mr4607380lfs.665.1664006713675;
        Sat, 24 Sep 2022 01:05:13 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y2-20020a2e5442000000b0026c41574790sm1696668ljd.30.2022.09.24.01.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 01:05:13 -0700 (PDT)
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
Subject: [PATCH 05/32] ARM: dts: qcom: msm8226: align TLMM pin configuration with DT schema
Date:   Sat, 24 Sep 2022 10:04:32 +0200
Message-Id: <20220924080459.13084-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
References: <20220924080459.13084-1-krzysztof.kozlowski@linaro.org>
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

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts |  6 +++---
 arch/arm/boot/dts/qcom-msm8226.dtsi         | 24 ++++++++++-----------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
index 193569f0ca5f..02bef5870526 100644
--- a/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts
@@ -299,8 +299,8 @@ bluetooth_default_state: bluetooth-default-state {
 		input-enable;
 	};
 
-	touch_pins: touch {
-		irq {
+	touch_pins: touch-state {
+		irq-pins {
 			pins = "gpio17";
 			function = "gpio";
 
@@ -309,7 +309,7 @@ irq {
 			input-enable;
 		};
 
-		reset {
+		reset-pins {
 			pins = "gpio16";
 			function = "gpio";
 
diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index cf2d56929428..3b6e746a4af9 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -354,35 +354,35 @@ tlmm: pinctrl@fd510000 {
 			#interrupt-cells = <2>;
 			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
 
-			blsp1_i2c1_pins: blsp1-i2c1 {
+			blsp1_i2c1_pins: blsp1-i2c1-state {
 				pins = "gpio2", "gpio3";
 				function = "blsp_i2c1";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp1_i2c2_pins: blsp1-i2c2 {
+			blsp1_i2c2_pins: blsp1-i2c2-state {
 				pins = "gpio6", "gpio7";
 				function = "blsp_i2c2";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp1_i2c3_pins: blsp1-i2c3 {
+			blsp1_i2c3_pins: blsp1-i2c3-state {
 				pins = "gpio10", "gpio11";
 				function = "blsp_i2c3";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp1_i2c4_pins: blsp1-i2c4 {
+			blsp1_i2c4_pins: blsp1-i2c4-state {
 				pins = "gpio14", "gpio15";
 				function = "blsp_i2c4";
 				drive-strength = <2>;
 				bias-disable;
 			};
 
-			blsp1_i2c5_pins: blsp1-i2c5 {
+			blsp1_i2c5_pins: blsp1-i2c5-state {
 				pins = "gpio18", "gpio19";
 				function = "blsp_i2c5";
 				drive-strength = <2>;
@@ -390,13 +390,13 @@ blsp1_i2c5_pins: blsp1-i2c5 {
 			};
 
 			sdhc1_default_state: sdhc1-default-state {
-				clk {
+				clk-pins {
 					pins = "sdc1_clk";
 					drive-strength = <10>;
 					bias-disable;
 				};
 
-				cmd-data {
+				cmd-data-pins {
 					pins = "sdc1_cmd", "sdc1_data";
 					drive-strength = <10>;
 					bias-pull-up;
@@ -404,13 +404,13 @@ cmd-data {
 			};
 
 			sdhc2_default_state: sdhc2-default-state {
-				clk {
+				clk-pins {
 					pins = "sdc2_clk";
 					drive-strength = <10>;
 					bias-disable;
 				};
 
-				cmd-data {
+				cmd-data-pins {
 					pins = "sdc2_cmd", "sdc2_data";
 					drive-strength = <10>;
 					bias-pull-up;
@@ -418,21 +418,21 @@ cmd-data {
 			};
 
 			sdhc3_default_state: sdhc3-default-state {
-				clk {
+				clk-pins {
 					pins = "gpio44";
 					function = "sdc3";
 					drive-strength = <8>;
 					bias-disable;
 				};
 
-				cmd {
+				cmd-pins {
 					pins = "gpio43";
 					function = "sdc3";
 					drive-strength = <8>;
 					bias-pull-up;
 				};
 
-				data {
+				data-pins {
 					pins = "gpio39", "gpio40", "gpio41", "gpio42";
 					function = "sdc3";
 					drive-strength = <8>;
-- 
2.34.1

