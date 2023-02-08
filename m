Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAC168E9B8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 09:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjBHIUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 03:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjBHIT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 03:19:57 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04AF42DD2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 00:19:55 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so836064wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 00:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzoZmM2w7PeBTom9yNdvc5OXYKnV9IqwuE8rFX7laqI=;
        b=Qa1LbNp/QUT892u7sd6LVLVzp6L8lzq9Saf861r0Gj37d2GiLwN5Z9RG9zSgvIe3d+
         oaARVkQvX85MByBg47kKF3iX4jQbCts20zw9Atr86DzTID+eIx5IdJM3PsvKSjiQGLbi
         UXf+SCUejyWdO6YAGzFVvSv8uW9rgP0icUsafGB/5DBLj68YSNQc8z+3LY8EdaEn14c9
         qNdEdx7/0iQ9JIY1UOVfNAA8dotdAg0JUulEL/89Yiim2ZrRluzdZgY3QpY/7mhZesPj
         OZqNJ+RSSZvAcYxuJidvZHuDfivICTccu330cz5ZtUMa8ENaSjKGoff5nCgdA0o8Zjiv
         kstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzoZmM2w7PeBTom9yNdvc5OXYKnV9IqwuE8rFX7laqI=;
        b=urNNbSosLN5BytxLJbP28Ew2fmUNtoWd9cZZbAGM19FM4o6+rKHqHtJJBhztXKy6th
         CnupB7pZRWdTGFdJ4wirsFLV4p21s6anrTqMifS7rMv0MwGupngi1Q1Bdq9YA9kd/3FA
         YF4n1v62IvOfd9daP4bpa8f4OaIEeRvMeQPJ26nrWWk3OOWxmJLNsVIqUm589gb0Qkvf
         czfZXcdI/TCRiv087ztkUFk0e0oNdtO5hgTAPqYz9bgjDRRb5o2KGYIMMWQUqLwJtBfP
         NlbOXNzIgSDpIphvzsUxOPLIXQpEu/HtAu/d3t7VVNR6L+FiuIsHkGIxjmKzXFraTpDE
         pAOg==
X-Gm-Message-State: AO0yUKVExd1dLcgSo4yiKzgy41/Dnqnjq793Tz8vIWFHrfd68mhm7xGa
        PURItZoo0bGvlT8lnJdwvNualA==
X-Google-Smtp-Source: AK7set8w0a3Vm55SCQRUUEeEd9/0ZJueDgKPJ3EpSvBT0f8q+1Zxz5qM2bMtqLYjNXxlVsCsGyWzxw==
X-Received: by 2002:a05:600c:4b1e:b0:3df:e549:da54 with SMTP id i30-20020a05600c4b1e00b003dfe549da54mr5728376wmp.17.1675844394512;
        Wed, 08 Feb 2023 00:19:54 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id a3-20020a05600c224300b003db01178b62sm1142452wmm.40.2023.02.08.00.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 00:19:53 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] arm64: dts: qcom: sm8550: Add bias pull up value to tlmm i2c data clk states
Date:   Wed,  8 Feb 2023 10:18:36 +0200
Message-Id: <20230208081836.984673-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208081836.984673-1-abel.vesa@linaro.org>
References: <20230208081836.984673-1-abel.vesa@linaro.org>
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

The default bias pull up value for the tlmm i2c data clk states is
2.2kOhms. Add this value to make sure the driver factors in the i2c pull
up bit when writing the config register.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

This patch does not have a v2 (or a v1). This is an entirely new patch and it is
part of this patchset to provide full context.

 arch/arm64/boot/dts/qcom/sm8550.dtsi | 30 ++++++++++++++--------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 1dea055a6815..6e60afc748cf 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2695,7 +2695,7 @@ qup_i2c0_data_clk: qup-i2c0-data-clk-state {
 				pins = "gpio28", "gpio29";
 				function = "qup1_se0";
 				drive-strength = <2>;
-				bias-pull-up;
+				bias-pull-up = <2200>;
 			};
 
 			qup_i2c1_data_clk: qup-i2c1-data-clk-state {
@@ -2703,7 +2703,7 @@ qup_i2c1_data_clk: qup-i2c1-data-clk-state {
 				pins = "gpio32", "gpio33";
 				function = "qup1_se1";
 				drive-strength = <2>;
-				bias-pull-up;
+				bias-pull-up = <2200>;
 			};
 
 			qup_i2c2_data_clk: qup-i2c2-data-clk-state {
@@ -2711,7 +2711,7 @@ qup_i2c2_data_clk: qup-i2c2-data-clk-state {
 				pins = "gpio36", "gpio37";
 				function = "qup1_se2";
 				drive-strength = <2>;
-				bias-pull-up;
+				bias-pull-up = <2200>;
 			};
 
 			qup_i2c3_data_clk: qup-i2c3-data-clk-state {
@@ -2719,7 +2719,7 @@ qup_i2c3_data_clk: qup-i2c3-data-clk-state {
 				pins = "gpio40", "gpio41";
 				function = "qup1_se3";
 				drive-strength = <2>;
-				bias-pull-up;
+				bias-pull-up = <2200>;
 			};
 
 			qup_i2c4_data_clk: qup-i2c4-data-clk-state {
@@ -2727,7 +2727,7 @@ qup_i2c4_data_clk: qup-i2c4-data-clk-state {
 				pins = "gpio44", "gpio45";
 				function = "qup1_se4";
 				drive-strength = <2>;
-				bias-pull-up;
+				bias-pull-up = <2200>;
 			};
 
 			qup_i2c5_data_clk: qup-i2c5-data-clk-state {
@@ -2735,7 +2735,7 @@ qup_i2c5_data_clk: qup-i2c5-data-clk-state {
 				pins = "gpio52", "gpio53";
 				function = "qup1_se5";
 				drive-strength = <2>;
-				bias-pull-up;
+				bias-pull-up = <2200>;
 			};
 
 			qup_i2c6_data_clk: qup-i2c6-data-clk-state {
@@ -2743,7 +2743,7 @@ qup_i2c6_data_clk: qup-i2c6-data-clk-state {
 				pins = "gpio48", "gpio49";
 				function = "qup1_se6";
 				drive-strength = <2>;
-				bias-pull-up;
+				bias-pull-up = <2200>;
 			};
 
 			qup_i2c8_data_clk: qup-i2c8-data-clk-state {
@@ -2751,14 +2751,14 @@ scl-pins {
 					pins = "gpio57";
 					function = "qup2_se0_l1_mira";
 					drive-strength = <2>;
-					bias-pull-up;
+					bias-pull-up = <2200>;
 				};
 
 				sda-pins {
 					pins = "gpio56";
 					function = "qup2_se0_l0_mira";
 					drive-strength = <2>;
-					bias-pull-up;
+					bias-pull-up = <2200>;
 				};
 			};
 
@@ -2767,7 +2767,7 @@ qup_i2c9_data_clk: qup-i2c9-data-clk-state {
 				pins = "gpio60", "gpio61";
 				function = "qup2_se1";
 				drive-strength = <2>;
-				bias-pull-up;
+				bias-pull-up = <2200>;
 			};
 
 			qup_i2c10_data_clk: qup-i2c10-data-clk-state {
@@ -2775,7 +2775,7 @@ qup_i2c10_data_clk: qup-i2c10-data-clk-state {
 				pins = "gpio64", "gpio65";
 				function = "qup2_se2";
 				drive-strength = <2>;
-				bias-pull-up;
+				bias-pull-up = <2200>;
 			};
 
 			qup_i2c11_data_clk: qup-i2c11-data-clk-state {
@@ -2783,7 +2783,7 @@ qup_i2c11_data_clk: qup-i2c11-data-clk-state {
 				pins = "gpio68", "gpio69";
 				function = "qup2_se3";
 				drive-strength = <2>;
-				bias-pull-up;
+				bias-pull-up = <2200>;
 			};
 
 			qup_i2c12_data_clk: qup-i2c12-data-clk-state {
@@ -2791,7 +2791,7 @@ qup_i2c12_data_clk: qup-i2c12-data-clk-state {
 				pins = "gpio2", "gpio3";
 				function = "qup2_se4";
 				drive-strength = <2>;
-				bias-pull-up;
+				bias-pull-up = <2200>;
 			};
 
 			qup_i2c13_data_clk: qup-i2c13-data-clk-state {
@@ -2799,7 +2799,7 @@ qup_i2c13_data_clk: qup-i2c13-data-clk-state {
 				pins = "gpio80", "gpio81";
 				function = "qup2_se5";
 				drive-strength = <2>;
-				bias-pull-up;
+				bias-pull-up = <2200>;
 			};
 
 			qup_i2c15_data_clk: qup-i2c15-data-clk-state {
@@ -2807,7 +2807,7 @@ qup_i2c15_data_clk: qup-i2c15-data-clk-state {
 				pins = "gpio72", "gpio106";
 				function = "qup2_se7";
 				drive-strength = <2>;
-				bias-pull-up;
+				bias-pull-up = <2200>;
 			};
 
 			qup_spi0_cs: qup-spi0-cs-state {
-- 
2.34.1

