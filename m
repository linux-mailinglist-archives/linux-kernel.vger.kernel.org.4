Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F55668E12C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 20:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBGT3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 14:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjBGT3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 14:29:03 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD6F3B0FC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 11:29:02 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so13926535wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 11:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPt0d21EGc/jow/fpKXjyuyxRoi0vr0T/kgkjEZ24Nk=;
        b=Hen3NJo56OhW8DFZAq4lQYwYUmAbzFS5GJedAd8Sdq669L9i1UG3eQQOeb44CbNj++
         2Y73Igg8vusNGGf87qDyF7ISQ65fAjt8+57ROeYxRyNFRJUx+bcRsPRd6s3cOdw7tFxZ
         jQq7TqB/1yvjmY0Y4m6bfRo7HjM8cnFyYML+bkk3qD1beGYioGGG3QhcBjopb2OWNoeV
         flpfekOHUf1wQaoDfBGkl43WmYUfgsDta9lsRoT4rY+1XZCYXzVOiWUjIB5AlWOaNb93
         C9capCo3nYoEjLIQftbRFSEKJFh31w/Bap2bro74dqmPJf5f4mOe748u6GQZOgbtFqBz
         HREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPt0d21EGc/jow/fpKXjyuyxRoi0vr0T/kgkjEZ24Nk=;
        b=z2Rtep9e3Kl/8VtkaVRgZyUJT1/qF9ACFCLAC5+mEYXXnMCDz4i2j3Dqtybh/c9bym
         lDN/x4eKQwkGqqa4v8FijBVgA7xs0np8OhT2/prnaKIhBe7OrPRh4WhzE2auIfwDjARs
         2v9nhhY6ULBV2BrWzblapg+LB3JfmBC2DMt+cf8aiQrzK1iDnmSxrTDRQ6zcbbudmuEd
         lZMJW16iqpSg5PFXumRVuXxUeqEYiHXro59gN3XySWXZnNBv0FW5/ls5ClFF2O3Fx8s3
         cCx6XfBzu/ARnNwEfFnamS7bxzxuGaYVf9CWu3B+wP2SVTbeL1RR1I2hNx5NaNg3+Dxq
         rrHw==
X-Gm-Message-State: AO0yUKUUyDmdX57yxvw1T6HcHw0FhRdVzm15NFgr/LCC8A2NxJZZd9C/
        0u6relApoEvzhwfkKl43eTkyow==
X-Google-Smtp-Source: AK7set9fz9HQsmLNOGzGZf/2oRs8JqN+jVQHS/qsjtqeFz0RSJPY2xc0aDbDxYtYUoOxixEXOHdJBg==
X-Received: by 2002:a05:600c:3513:b0:3dc:c5c:b94f with SMTP id h19-20020a05600c351300b003dc0c5cb94fmr4084434wmq.39.1675798141001;
        Tue, 07 Feb 2023 11:29:01 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b003db0ad636d1sm22770818wms.28.2023.02.07.11.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 11:29:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] ARM: dts: exynos: move MIPI phy to PMU node in Exynos4
Date:   Tue,  7 Feb 2023 20:28:51 +0100
Message-Id: <20230207192851.549242-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207192851.549242-1-krzysztof.kozlowski@linaro.org>
References: <20230207192851.549242-1-krzysztof.kozlowski@linaro.org>
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

The MIPI phy is actually part of the Power Management Unit system
controller.  It does not have its own address space, thus keeping the
node under soc causes warnings:

  xynos4412-i9305.dtb: soc: video-phy: {'compatible': ['samsung,s5pv210-mipi-video-phy'],
    '#phy-cells': [[1]], 'syscon': [[11]], 'phandle': [[13]]} should not be valid under {'type': 'object'}

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos4.dtsi    | 13 ++++++-------
 arch/arm/boot/dts/exynos4412.dtsi |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 44dcb1377475..8dd6976ab0a7 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -105,12 +105,6 @@ memory-controller@12570000 {
 			reg = <0x12570000 0x14>;
 		};
 
-		mipi_phy: video-phy {
-			compatible = "samsung,s5pv210-mipi-video-phy";
-			#phy-cells = <1>;
-			syscon = <&pmu_system_controller>;
-		};
-
 		pd_mfc: power-domain@10023c40 {
 			compatible = "samsung,exynos4210-pd";
 			reg = <0x10023c40 0x20>;
@@ -181,11 +175,16 @@ sys_reg: syscon@10010000 {
 		};
 
 		pmu_system_controller: system-controller@10020000 {
-			compatible = "samsung,exynos4210-pmu", "syscon";
+			compatible = "samsung,exynos4210-pmu", "simple-mfd", "syscon";
 			reg = <0x10020000 0x4000>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			interrupt-parent = <&gic>;
+
+			mipi_phy: mipi-phy {
+				compatible = "samsung,s5pv210-mipi-video-phy";
+				#phy-cells = <1>;
+			};
 		};
 
 		dsi_0: dsi@11c80000 {
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 11f9dd94b6b3..7fa3e5fd6801 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -798,7 +798,7 @@ &pmu {
 };
 
 &pmu_system_controller {
-	compatible = "samsung,exynos4412-pmu", "syscon";
+	compatible = "samsung,exynos4412-pmu", "simple-mfd", "syscon";
 	clock-names = "clkout0", "clkout1", "clkout2", "clkout3",
 			"clkout4", "clkout8", "clkout9";
 	clocks = <&clock CLK_OUT_DMC>, <&clock CLK_OUT_TOP>,
-- 
2.34.1

