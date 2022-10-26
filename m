Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DBC60E9BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiJZUEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiJZUEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:04:05 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA6D10B7BD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:04:04 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id l9so8988719qkk.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCMOew4GYhYa9VutNSyEqOxm0n7KKviZV3m1tbrXNe8=;
        b=sTTWAIo5k27JetB031FERfXCHBmgKPyJ72n2o8UpQU7LPPUKLhGV/CDya5o/7qVF1q
         uOqEOdGauhJkk9EAWfkObzamE1fBwkEZ4wJLVDNagbXvR6JivctG6utnuSdEvbzDW3AB
         zW/kLgrUcuHCMiczttSb93NiRVPpXwBweiOq8DN+AZmFjpVoBhwVZ+zGiI2LTfE0hqG0
         XzQKPjTLJtg2L99KsgK9xZDOOgDGsSVXxBhFqB+sfbOBJFkBZ51g6UidteeNMBK/VMDh
         dlElAojwU9/5R+8NwyACsGYei27bywaB2tavQdvwraMhkBaOUVMcbM1ryfp3Wfq8SNlk
         bXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCMOew4GYhYa9VutNSyEqOxm0n7KKviZV3m1tbrXNe8=;
        b=4TYpXUZy6xFatYGo6dcEhkm86+MqrZVeXteF1lENSdU4evkj1QQ0MCQHIhZjK/BKmg
         NvSZEa1cljVMKkjcYneztLx02Sxgror4l+9SM1dCONn3m07sFJvm3AZ6IO+o8/ep6w6g
         MaAmyk0QTzbWjfkfyyEQF6sK0xejxATOmLLsxffavs4e5XALGmhic5YLlNPsHAdokDpa
         zniiAeLgSA38SyZ1RW3ynL9rX8PVs9IYsUkvj0yYaA4ao64ufAkWWV0zGGF4XaW0JKPD
         FxzvofCkPLECsj09uMAfsgNWtTUodJULNnhREpAP1B8Hvb7jX+kI23s+eO0Jr1KBFbzY
         epmA==
X-Gm-Message-State: ACrzQf3GsVenk5e/SUhBkjzcwB3bhMSutENhVvfUdO1JG7b458pXDAFT
        tM1HezlhdV9xee8yzXr6OHqUHA==
X-Google-Smtp-Source: AMsMyM4AS50UrpNeey0s5Z7YjYa+fX4boAh819y3K4g+c2NblZIARcITUJAeqCDo2aFHrVHFEuBK0g==
X-Received: by 2002:a05:620a:4487:b0:6ee:bcfd:bd38 with SMTP id x7-20020a05620a448700b006eebcfdbd38mr31661442qkp.468.1666814643576;
        Wed, 26 Oct 2022 13:04:03 -0700 (PDT)
Received: from krzk-bin.. ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id de30-20020a05620a371e00b006e99290e83fsm2942089qkb.107.2022.10.26.13.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:04:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 1/4] arm64: dts: qcom: sm8450: move SDHCI pin configuration to DTSI
Date:   Wed, 26 Oct 2022 16:03:54 -0400
Message-Id: <20221026200357.391635-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221026200357.391635-1-krzysztof.kozlowski@linaro.org>
References: <20221026200357.391635-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SDHCI pin configuration/mux nodes are actually common to all
upstreamed boards, so define them in SoC DTSI to reduce code
duplication.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

In theory drive strength belongs to the board DTS, not SoC DTSI, but I
am following the advice here:
https://lore.kernel.org/lkml/CAD=FV=VUL4GmjaibAMhKNdpEso_Hg_R=XeMaqah1LSj_9-Ce4Q@mail.gmail.com/
---
 .../qcom/sm8450-sony-xperia-nagara-pdx223.dts | 20 -------------------
 arch/arm64/boot/dts/qcom/sm8450.dtsi          | 20 +++++++++++++++++++
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
index 82918c2d956f..718c690af8ad 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
@@ -572,26 +572,6 @@ &spi10 {
 &tlmm {
 	gpio-reserved-ranges = <28 4>;
 
-	sdc2_default_state: sdc2-default-state {
-		clk-pins {
-			pins = "sdc2_clk";
-			drive-strength = <16>;
-			bias-disable;
-		};
-
-		cmd-pins {
-			pins = "sdc2_cmd";
-			drive-strength = <16>;
-			bias-pull-up;
-		};
-
-		data-pins {
-			pins = "sdc2_data";
-			drive-strength = <16>;
-			bias-pull-up;
-		};
-	};
-
 	ts_int_default: ts-int-default-state {
 		pins = "gpio23";
 		function = "gpio";
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 1d1775334575..1df5c964c6f7 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2515,6 +2515,26 @@ tlmm: pinctrl@f100000 {
 			gpio-ranges = <&tlmm 0 0 211>;
 			wakeup-parent = <&pdc>;
 
+			sdc2_default_state: sdc2-default-state {
+				clk-pins {
+					pins = "sdc2_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-pins {
+					pins = "sdc2_cmd";
+					drive-strength = <16>;
+					bias-pull-up;
+				};
+
+				data-pins {
+					pins = "sdc2_data";
+					drive-strength = <16>;
+					bias-pull-up;
+				};
+			};
+
 			sdc2_sleep_state: sdc2-sleep-state {
 				clk-pins {
 					pins = "sdc2_clk";
-- 
2.34.1

