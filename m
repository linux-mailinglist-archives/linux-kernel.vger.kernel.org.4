Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6D1639CD8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiK0Ucy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiK0Uct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:32:49 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A19B1E5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:32:47 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id l8so10994015ljh.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDF3wtVae7sFV7RHSN3RWyepCJgWam189Cxle5ELR+0=;
        b=svDjpxjGgEYAtvQEU782VlP0v8qkhnR89/c3bV98qc+sPcuYmy9NlECraEuztBL/H9
         +yagQWGEQ/Jf8d/SQYlAIBd0n+O3WBKmJLe5oOMOTUp0D9g88+KGpgCUUa/uf62AVFN2
         dCu7gd/D6fE4sDMCIBbYe154EjfgAfuaNAjBskpzwYc8btoBwA/rBDquUqwI5X2h58R9
         3HaBeJDl/UoPVioW8vEWJHuf8JRmk+NUST/cfGJdJr3yqj6D3SgneiYIViChc3zn11Hf
         Dv4EiUbNrfW3S7ubpc0YQ9tXPlX2DMroWqgwW6BmsTlFR7od2U5hbylBAKoHFQ4m+0ny
         fhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDF3wtVae7sFV7RHSN3RWyepCJgWam189Cxle5ELR+0=;
        b=O5tw0aeATng3iaQVaECNzy8p/lBNLe1Mv0uDYCt5l5GfustHuVHF/YxYyvPRZcGmkb
         YYIcjOnoJtktrWAYzH+SScYmBKmRZyNe76zeOf8I9Ywn//sOFadsAERU4Kv5XtCHmyGY
         u7lUxvzB6dtRWnuwSESGHfshjdiwJuLVYAv26EwpW0n3QTW+bHKrUIwTGxZu9GPjXRko
         s+YhCNJoQ9zeBPrba8pXr16VtczqC4uHflx4rTN5G6wjhvrIWQFQ2DYJyVM25fKMhgKi
         9EkeBKQ0yzK7oij1RrS9gmmPmBWz55JUPcCDlvX+NAxJ5zCLw/hLo+CHzSMJVAtaN6N/
         vGxw==
X-Gm-Message-State: ANoB5pnD5i6wzMP1PKJke2PrRo5mDHC4vHpGKsjqN80izkN6VcmLlvAd
        JPAI9huh2svqI1M51CY1Yahqmw==
X-Google-Smtp-Source: AA0mqf5emVQaTM9KtZ2LkxfssBLpH/7Ag1JkNnoIUclLXQ0BN1SY+nseOw+cqpq0ULrLYl9T3ni5tw==
X-Received: by 2002:a2e:3e17:0:b0:279:96c4:2c2d with SMTP id l23-20020a2e3e17000000b0027996c42c2dmr3088855lja.153.1669581165273;
        Sun, 27 Nov 2022 12:32:45 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w10-20020a05651234ca00b00494942bec60sm1412827lfr.17.2022.11.27.12.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 12:32:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] ARM: dts: qcom: align LED node names with dtschema
Date:   Sun, 27 Nov 2022 21:32:40 +0100
Message-Id: <20221127203240.54955-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221127203240.54955-1-krzysztof.kozlowski@linaro.org>
References: <20221127203240.54955-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and DT schema expects certain pattern:

  qcom-ipq4018-ap120c-ac.dtb: leds: 'wlan2g', 'wlan5g' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. Add Rb
---
 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts | 6 +++---
 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts     | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
index cf7da1ab177c..1b27edce9d4f 100644
--- a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
+++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
@@ -9,7 +9,7 @@ / {
 	leds {
 		compatible = "gpio-leds";
 
-		power {
+		led-power {
 			label = "ap120c-ac:green:power";
 			function = LED_FUNCTION_POWER;
 			color = <LED_COLOR_ID_GREEN>;
@@ -17,14 +17,14 @@ power {
 			default-state = "on";
 		};
 
-		wlan {
+		led-wlan {
 			label = "ap120c-ac:green:wlan";
 			function = LED_FUNCTION_WLAN;
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
 		};
 
-		support {
+		led-support {
 			label = "ap120c-ac:green:support";
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&tlmm 2 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
index c4f89b712fd9..a707057c887d 100644
--- a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
+++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
@@ -7,7 +7,7 @@ / {
 	leds {
 		compatible = "gpio-leds";
 
-		status: status {
+		status: led-status {
 			label = "ap120c-ac:blue:status";
 			function = LED_FUNCTION_STATUS;
 			color = <LED_COLOR_ID_BLUE>;
@@ -15,7 +15,7 @@ status: status {
 			default-state = "keep";
 		};
 
-		wlan2g {
+		led-wlan2g {
 			label = "ap120c-ac:green:wlan2g";
 			function = LED_FUNCTION_WLAN;
 			color = <LED_COLOR_ID_GREEN>;
@@ -23,7 +23,7 @@ wlan2g {
 			linux,default-trigger = "phy0tpt";
 		};
 
-		wlan5g {
+		led-wlan5g {
 			label = "ap120c-ac:red:wlan5g";
 			function = LED_FUNCTION_WLAN;
 			color = <LED_COLOR_ID_RED>;
-- 
2.34.1

