Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFD5641CB3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 12:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiLDLi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 06:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiLDLiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 06:38:46 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A63117A9E
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 03:38:45 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id cf42so8653988lfb.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 03:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWCnTBAXgMLf9K5izu+NUfHfWe3RS/uwzoe6Lzffpls=;
        b=h6tH2DTAswtfjXxwkyuaAx7a0AmHdjQl+sM1onabkrtPyEiiJOPCUGAt5zGkk6Yg33
         KffFd773Kny+MkxvJiVofGjnQpy7SAL2haneFyzSD7dbKf+T36hanJETPJ4dsWw+p+GT
         eIfWIrV0hefz2HeIof7+I48iYaAnFD2SPiNlMA3LpbExH43T8gDp9EGjCZR0BH2pFTnH
         hraBUtyMoEc5AvI77eo6fjilrw/sh4Osmidu/ckto0YKTJpgKZ4iLYMApZGUAyfFvMbc
         5VX0ijLeGdTIyfpb63IBsLmZb2pF/Z2vWLLi/gt9Mcf0SDuw0plDvq1HlNyMwyp5XrPr
         yLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWCnTBAXgMLf9K5izu+NUfHfWe3RS/uwzoe6Lzffpls=;
        b=WCPFdgjZP3THlcHoJ6vZm0KBJdt6uFnTGvRmSTlSrzXYM5Fd+lNOfN7kA2qZh2bugT
         TK2ZM+qtZpRf4XjFjPldpSZ3S1yVdH87mNOpqoAsvhFYkZZz0tra9xM1PQjHbZbMJjAU
         F85wH+DUsrYstCp6bf/a3LYsm0zNfsVz3RS5MI9YsibUPmYrpKv/8IPtNthICgpxX35m
         KvGz/aCSV1dQA67m167Atb42yynEvPZ03mXzVXecILzQqOI0z4JxndueXax3b6W8Y6fn
         mV5hVyMg5aGus8QRvihIVJSJ750XNGenrNiSjv8jDR/h94DT2OS743+7ATbl5Om6ZNYj
         z/5g==
X-Gm-Message-State: ANoB5pms8LSc57+upGTjajLumJ26aelDZU8Kjxj/yVGrYjGGo4jxJCOu
        fUurMRlCHK89gHbCkEvPkzPsgA==
X-Google-Smtp-Source: AA0mqf48lyZX3QBPnm83zQP9tqlmdt3n3Q4v0C/QwavZb7shI+7UyhpzrG85H3klFGTWQLY41BxXRA==
X-Received: by 2002:a05:6512:3416:b0:498:f589:c1b3 with SMTP id i22-20020a056512341600b00498f589c1b3mr20163577lfr.406.1670153923578;
        Sun, 04 Dec 2022 03:38:43 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a11-20020ac25e6b000000b0048a9e899693sm1762826lfr.16.2022.12.04.03.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 03:38:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RFT 2/3] arm64: dts: exynos: drop clock-frequency from CPU nodes in TM2
Date:   Sun,  4 Dec 2022 12:38:38 +0100
Message-Id: <20221204113839.151816-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221204113839.151816-1-krzysztof.kozlowski@linaro.org>
References: <20221204113839.151816-1-krzysztof.kozlowski@linaro.org>
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

The CPU frequencies are determined by OPP table, so drop the
'clock-frequency' property.  It is not parsed by any driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

"It is not parsed" - I hope...
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 8619920da4b6..88983d912479 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -89,7 +89,6 @@ cpu0: cpu@100 {
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x100>;
-			clock-frequency = <1300000000>;
 			clocks = <&cmu_apollo CLK_SCLK_APOLLO>;
 			clock-names = "apolloclk";
 			operating-points-v2 = <&cluster_a53_opp_table>;
@@ -108,7 +107,6 @@ cpu1: cpu@101 {
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x101>;
-			clock-frequency = <1300000000>;
 			operating-points-v2 = <&cluster_a53_opp_table>;
 			#cooling-cells = <2>;
 			i-cache-size = <0x8000>;
@@ -125,7 +123,6 @@ cpu2: cpu@102 {
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x102>;
-			clock-frequency = <1300000000>;
 			operating-points-v2 = <&cluster_a53_opp_table>;
 			#cooling-cells = <2>;
 			i-cache-size = <0x8000>;
@@ -142,7 +139,6 @@ cpu3: cpu@103 {
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x103>;
-			clock-frequency = <1300000000>;
 			operating-points-v2 = <&cluster_a53_opp_table>;
 			#cooling-cells = <2>;
 			i-cache-size = <0x8000>;
@@ -159,7 +155,6 @@ cpu4: cpu@0 {
 			compatible = "arm,cortex-a57";
 			enable-method = "psci";
 			reg = <0x0>;
-			clock-frequency = <1900000000>;
 			clocks = <&cmu_atlas CLK_SCLK_ATLAS>;
 			clock-names = "atlasclk";
 			operating-points-v2 = <&cluster_a57_opp_table>;
@@ -178,7 +173,6 @@ cpu5: cpu@1 {
 			compatible = "arm,cortex-a57";
 			enable-method = "psci";
 			reg = <0x1>;
-			clock-frequency = <1900000000>;
 			operating-points-v2 = <&cluster_a57_opp_table>;
 			#cooling-cells = <2>;
 			i-cache-size = <0xc000>;
@@ -195,7 +189,6 @@ cpu6: cpu@2 {
 			compatible = "arm,cortex-a57";
 			enable-method = "psci";
 			reg = <0x2>;
-			clock-frequency = <1900000000>;
 			operating-points-v2 = <&cluster_a57_opp_table>;
 			#cooling-cells = <2>;
 			i-cache-size = <0xc000>;
@@ -212,7 +205,6 @@ cpu7: cpu@3 {
 			compatible = "arm,cortex-a57";
 			enable-method = "psci";
 			reg = <0x3>;
-			clock-frequency = <1900000000>;
 			operating-points-v2 = <&cluster_a57_opp_table>;
 			#cooling-cells = <2>;
 			i-cache-size = <0xc000>;
-- 
2.34.1

