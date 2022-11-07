Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B8561FE17
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiKGS7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbiKGS7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:59:39 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F0924953
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:59:36 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id k19so17757986lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 10:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6+tifRwm98rAaw+GHP74ruEoAmooOK+xQD6j6mXEfs=;
        b=mBleVDhIojdtiptSbA/vSs3qVkg4VMpPsrlPMfPe2VtoRCCLCELsPQ4dqELBh2sfpN
         DNhwKEoswbG5mI1fFV3MFttf8Cr/3dlD7LJj3pOAtd25oQcXXpEls/1M5GV2clWa09ve
         DVGd+rHSS8MGAUFhGA4hw9kikrpDPQBhplG4QosIOBO3oB1AGYjzh11NJbN6uVWkLW4Z
         Zm+HgTQ+deFRoVLAZCo8kRu2b/3R9VDIfmLJhBVKNXAf1yA2VHjrwAQ9ogdfMUM6zz+w
         WuRbXKkOqcOoSEQjJl4cuZ66Flyp9X3iRMfHEYkmmMhBYI+dvMM0ybSndZm/rBl0Q8KP
         lT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6+tifRwm98rAaw+GHP74ruEoAmooOK+xQD6j6mXEfs=;
        b=cnyqxpEruZOHDZNqcz5McEccccfCg7lBV7mUjRtCWcF8tJvhfTE+OGmJgdhhYkigdW
         dPW4byRsADG4J28QtH0OLP8fdWW5m+sO9ta8ce7sdgwhEZwPWx6S/YSThYssoJ1q1gqx
         E8xiXu/40kiPQXQ80mynu3T+LD2D+LXB4M/zyKsxpec617Q+apkQfhtaZSogFFFAjBWA
         DrdSF1dpBjCPOk9SOOv1NvqSJs5KNDEpO62cR93n/HglrNUhgMVDTzjl6dAU9bKQODC6
         akuSYEtLtbsxSL4rdhPlXb3DqDiDkx+YDmp2X0+h014JjxmTJt8oW4dx1K1btV7MYOfN
         tXjw==
X-Gm-Message-State: ACrzQf1OPI8LFB9etFJ3W5X1ZDa/fnDx7BsHCoMA6py+YY/fojh+HXql
        FvF6/KWIQeYP1XEXbfUoOt++3A==
X-Google-Smtp-Source: AMsMyM4bvRAD5pFcUnjckx8kRc0DjR32qWX+6xs08zUhVp9Yl6EplB/pie2qvUv/MMlfAvmm+qyEhg==
X-Received: by 2002:a2e:b2d1:0:b0:277:c68:874b with SMTP id 17-20020a2eb2d1000000b002770c68874bmr5414236ljz.261.1667847575315;
        Mon, 07 Nov 2022 10:59:35 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id y5-20020a05651c106500b002770a9ed61bsm1327875ljm.66.2022.11.07.10.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:59:34 -0800 (PST)
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
Subject: [PATCH 2/2] ARM: dts: qcom-apq8060: align TLMM pin configuration with DT schema
Date:   Mon,  7 Nov 2022 19:59:31 +0100
Message-Id: <20221107185931.22075-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107185931.22075-1-krzysztof.kozlowski@linaro.org>
References: <20221107185931.22075-1-krzysztof.kozlowski@linaro.org>
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

DT schema expects TLMM pin configuration nodes to be named with
'-state' suffix and their optional children with '-pins' suffix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../arm/boot/dts/qcom-apq8060-dragonboard.dts | 126 +++++++-----------
 1 file changed, 51 insertions(+), 75 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index 0baf202a82ba..7a4c59e04af6 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -789,28 +789,24 @@ &sdcc5 {
 
 &tlmm {
 	/* eMMC pins, all 8 data lines connected */
-	dragon_sdcc1_pins: sdcc1 {
-		mux {
-			pins = "gpio159", "gpio160", "gpio161",
-			     "gpio162", "gpio163", "gpio164",
-			     "gpio165", "gpio166", "gpio167",
-			     "gpio168";
-			     function = "sdc1";
-		};
-		clk {
+	dragon_sdcc1_pins: sdcc1-state {
+		clk-pins {
 			pins = "gpio167"; /* SDC1 CLK */
+			function = "sdc1";
 			drive-strength = <16>;
 			bias-disable;
 		};
-		cmd {
+		cmd-pins {
 			pins = "gpio168"; /* SDC1 CMD */
+			function = "sdc1";
 			drive-strength = <10>;
 			bias-pull-up;
 		};
-		data {
+		data-pins {
 			/* SDC1 D0 to D7 */
 			pins = "gpio159", "gpio160", "gpio161", "gpio162",
 			     "gpio163", "gpio164", "gpio165", "gpio166";
+			function = "sdc1";
 			drive-strength = <10>;
 			bias-pull-up;
 		};
@@ -820,18 +816,18 @@ data {
 	 * The SDCC3 pins are hardcoded (non-muxable) but need some pin
 	 * configuration.
 	 */
-	dragon_sdcc3_pins: sdcc3 {
-		clk {
+	dragon_sdcc3_pins: sdcc3-state {
+		clk-pins {
 			pins = "sdc3_clk";
 			drive-strength = <8>;
 			bias-disable;
 		};
-		cmd {
+		cmd-pins {
 			pins = "sdc3_cmd";
 			drive-strength = <8>;
 			bias-pull-up;
 		};
-		data {
+		data-pins {
 			pins = "sdc3_data";
 			drive-strength = <8>;
 			bias-pull-up;
@@ -839,101 +835,82 @@ data {
 	};
 
 	/* Second SD card slot pins */
-	dragon_sdcc5_pins: sdcc5 {
-		mux {
-			pins = "gpio95", "gpio96", "gpio97",
-			    "gpio98", "gpio99", "gpio100";
-			function = "sdc5";
-		};
-		clk {
+	dragon_sdcc5_pins: sdcc5-state {
+		clk-pins {
 			pins = "gpio97"; /* SDC5 CLK */
+			function = "sdc5";
 			drive-strength = <16>;
 			bias-disable;
 		};
-		cmd {
+		cmd-pins {
 			pins = "gpio95"; /* SDC5 CMD */
+			function = "sdc5";
 			drive-strength = <10>;
 			bias-pull-up;
 		};
-		data {
+		data-pins {
 			/* SDC5 D0 to D3 */
 			pins = "gpio96", "gpio98", "gpio99", "gpio100";
+			function = "sdc5";
 			drive-strength = <10>;
 			bias-pull-up;
 		};
 	};
 
-	dragon_gsbi3_i2c_pins: gsbi3_i2c {
-		mux {
-			pins = "gpio43", "gpio44";
-			function = "gsbi3";
-		};
-		pinconf {
-			pins = "gpio43", "gpio44";
-			drive-strength = <8>;
-			/* These have external pull-up 2.2kOhm to 1.8V */
-			bias-disable;
-		};
+	dragon_gsbi3_i2c_pins: gsbi3-i2c-state {
+		pins = "gpio43", "gpio44";
+		function = "gsbi3";
+		drive-strength = <8>;
+		/* These have external pull-up 2.2kOhm to 1.8V */
+		bias-disable;
 	};
 
-	dragon_gsbi8_i2c_pins: gsbi8_i2c {
-		mux {
-			pins = "gpio64", "gpio65";
-			function = "gsbi8";
-		};
-		pinconf {
-			pins = "gpio64", "gpio65";
-			drive-strength = <16>;
-			/* These have external pull-up 2.2kOhm to 1.8V */
-			bias-disable;
-		};
+	dragon_gsbi8_i2c_pins: gsbi8-i2c-state {
+		pins = "gpio64", "gpio65";
+		function = "gsbi8";
+		drive-strength = <16>;
+		/* These have external pull-up 2.2kOhm to 1.8V */
+		bias-disable;
 	};
 
-	dragon_gsbi12_i2c_pins: gsbi12_i2c {
-		mux {
-			pins = "gpio115", "gpio116";
-			function = "gsbi12";
-		};
-		pinconf {
-			pins = "gpio115", "gpio116";
-			drive-strength = <16>;
-			/* These have external pull-up 4.7kOhm to 1.8V */
-			bias-disable;
-		};
+	dragon_gsbi12_i2c_pins: gsbi12-i2c-state {
+		pins = "gpio115", "gpio116";
+		function = "gsbi12";
+		drive-strength = <16>;
+		/* These have external pull-up 4.7kOhm to 1.8V */
+		bias-disable;
 	};
 
 	/* Primary serial port uart 0 pins */
-	dragon_gsbi12_serial_pins: gsbi12_serial {
-		mux {
-			pins = "gpio117", "gpio118";
-			function = "gsbi12";
-		};
-		tx {
+	dragon_gsbi12_serial_pins: gsbi12-serial-state {
+		tx-pins {
 			pins = "gpio117";
+			function = "gsbi12";
 			drive-strength = <8>;
 			bias-disable;
 		};
-		rx {
+		rx-pins {
 			pins = "gpio118";
+			function = "gsbi12";
 			drive-strength = <2>;
 			bias-pull-up;
 		};
 	};
 
-	dragon_ebi2_pins: ebi2 {
+	dragon_ebi2_pins: ebi2-state {
 		/*
 		 * Pins used by EBI2 on the Dragonboard, actually only
 		 * CS2 is used by a real peripheral. CS0 is just
 		 * routed to a test point.
 		 */
-		mux0 {
+		mux0-pins {
 			pins =
 			    /* "gpio39", CS1A_N this is not good to mux */
 			    "gpio40", /* CS2A_N */
 			    "gpio134"; /* CS0_N testpoint TP29 */
 			function = "ebi2cs";
 		};
-		mux1 {
+		mux1-pins {
 			pins =
 			    /* EBI2_ADDR_7 downto EBI2_ADDR_0 address bus */
 			    "gpio123", "gpio124", "gpio125", "gpio126",
@@ -951,22 +928,21 @@ mux1 {
 	};
 
 	/* Interrupt line for the KXSD9 accelerometer */
-	dragon_kxsd9_gpios: kxsd9 {
-		irq {
-			pins = "gpio57"; /* IRQ line */
-			bias-pull-up;
-		};
+	dragon_kxsd9_gpios: kxsd9-state {
+		pins = "gpio57"; /* IRQ line */
+		function = "gpio";
+		bias-pull-up;
 	};
 
-	dragon_tma340_gpios: tma340 {
-		reset {
+	dragon_tma340_gpios: tma340-state {
+		reset-pins {
 			/* RESET line, TS_ATTN, WAKE_CTP */
 			pins = "gpio58";
 			function = "gpio";
 			drive-strength = <6>;
 			bias-disable;
 		};
-		irq {
+		irq-pins {
 			pins = "gpio61"; /* IRQ line */
 			function = "gpio";
 			drive-strength = <2>;
-- 
2.34.1

