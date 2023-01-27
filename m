Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3490467EE9F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 20:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjA0To0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 14:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjA0TnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 14:43:20 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF23EFBE
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:54 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q5so5947037wrv.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 11:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXF/FT5VGcZwGc673y38gqasO1Ez04eMNkbruDEnIiI=;
        b=gdCf/BsV0BYHDAVQaGj5uEJC9/P5TJgw3sLCjI3tvD5gHFroLZUguanFfSw57RPvHI
         bye/8CUczKtkj9n1YhnsZ3GaqSfodFcfyZDFKw9On2IYALM6xlQkOpZCnETKLul19xX8
         KW0nPXpMlJbXMTNKtbulWGFLKv9hImcMnghQjAv73k/a4SezMjGkOhX34thvQmQMluHN
         6MNFoC7IEyp/bkKPYOHxAo5KVOLiByKXQFSDDc8L9ibSa3QuziNoIn4g9XLwyp/VteK+
         mF/RM1SorxAI+BKuuDh6k5GBuOn1D8/aEtMSWZhF9i8gjCrqyIjIkrbxnQewITtXf5e2
         PbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXF/FT5VGcZwGc673y38gqasO1Ez04eMNkbruDEnIiI=;
        b=31E6UKTOns+O6G7HvvZOVgC0rmblctsw7VJsLnvhuFwIsgz/fFQLHwVMOeE4XGOUsd
         voAdDNHlmJEAkZNVHYIaSNndsXgBZClEZ6VsduY5jaDqKhOMJpA7Npimxj8XnV5pUyQ5
         wfN5pzyTuDMdojfJTxi4X3cGfWOxx78J2UDQbL+VeRen+XtLTyp+il8FyuNz+sNW2gwr
         7GcsgOIh83G44NifdjE5jwGon5rvil2aZdrNXruSpdrSTi5P35P/QfseAgVkiClSJCvB
         5Hzdx3sLV+uQAZabRYR0cffEYI/pvGFNqUJBVwRMrIKbe1mXfm9d+tBZrVfu3s1wOX19
         b6kA==
X-Gm-Message-State: AO0yUKXURs49HdjFGVbagUZVbpWLhY42RO68DNcacF0i6OdPVGTab+tQ
        HQynyjcaq3HlJPA8MWun6Na8dQ==
X-Google-Smtp-Source: AK7set+jJD3RzRxwzaa36W6wlFcd+BsYxdURd8hMG6GYx8fH7v5XbeXGgf7+C6HLF/HWbchZLVIS/Q==
X-Received: by 2002:a05:6000:104a:b0:2bf:ae18:34dd with SMTP id c10-20020a056000104a00b002bfae1834ddmr13491676wrx.56.1674848478404;
        Fri, 27 Jan 2023 11:41:18 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y17-20020adffa51000000b002238ea5750csm5822417wrr.72.2023.01.27.11.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 11:41:18 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/8] ARM: dts: exynos: move DP and MIPI phys to PMU node in Exynos5420
Date:   Fri, 27 Jan 2023 20:40:55 +0100
Message-Id: <20230127194057.186458-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org>
References: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org>
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

The DisplayPort and MIPI phys are actually part of the Power Management
Unit system controller.  They do not have their own address space, thus
keeping the nodes under soc causes warnings:

  exynos5420-smdk5420.dtb: soc: dp-video-phy: {'compatible': ['samsung,exynos5420-dp-video-phy'],
    'samsung,pmu-syscon': [[11]], '#phy-cells': [[0]], 'phandle': [[16]]} should not be valid under {'type': 'object'}

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos5420.dtsi | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index b1051a7d07af..6cdb1a832fb9 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -585,18 +585,6 @@ spi_2: spi@12d40000 {
 			status = "disabled";
 		};
 
-		dp_phy: dp-video-phy {
-			compatible = "samsung,exynos5420-dp-video-phy";
-			samsung,pmu-syscon = <&pmu_system_controller>;
-			#phy-cells = <0>;
-		};
-
-		mipi_phy: mipi-video-phy {
-			compatible = "samsung,exynos5420-mipi-video-phy";
-			syscon = <&pmu_system_controller>;
-			#phy-cells = <1>;
-		};
-
 		dsi: dsi@14500000 {
 			compatible = "samsung,exynos5410-mipi-dsi";
 			reg = <0x14500000 0x10000>;
@@ -822,7 +810,7 @@ jpeg_1: jpeg@11f60000 {
 		};
 
 		pmu_system_controller: system-controller@10040000 {
-			compatible = "samsung,exynos5420-pmu", "syscon";
+			compatible = "samsung,exynos5420-pmu", "simple-mfd", "syscon";
 			reg = <0x10040000 0x5000>;
 			clock-names = "clkout16";
 			clocks = <&clock CLK_FIN_PLL>;
@@ -830,6 +818,16 @@ pmu_system_controller: system-controller@10040000 {
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			interrupt-parent = <&gic>;
+
+			dp_phy: dp-phy {
+				compatible = "samsung,exynos5420-dp-video-phy";
+				#phy-cells = <0>;
+			};
+
+			mipi_phy: mipi-phy {
+				compatible = "samsung,exynos5420-mipi-video-phy";
+				#phy-cells = <1>;
+			};
 		};
 
 		tmu_cpu0: tmu@10060000 {
-- 
2.34.1

