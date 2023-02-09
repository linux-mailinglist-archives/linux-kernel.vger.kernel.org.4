Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF746905FB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjBIK7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjBIK7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:59:39 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C67FBBBA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:59:11 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h16so1319457wrz.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 02:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4qWySFdPWlDDj6CvZ29MtpOtvG59NiLUFJ1wNv+nZw=;
        b=EUolExRwf4LfrDwUiAGQ5FhG8nDREc494r+eapphjzQWifcAV3dtqumlcac504K2Az
         Tf03G8fnZvqpWdSJNyXO7uU6tOm3RZ7bYASOq76hlPN9fpu1dRqe6S5ciPUKRsJDvxE+
         vQPDbJjmsVJ+zSsyY/z0FBVPlX9qR2TzhkD/Ek+D0wmkuoKZ0xNx3QUZ0K3fzgL9vXhC
         U9ok/0mXFFxluDXd7o+0UaEvwmnTTxkuNik4H3yzoa5OdD2p/z9OzKNAFB+4pNCT72ON
         glEJGsLpXqvlVLf4UNynoBVvtiAty1QGC4Sx8T85Em1uJsVhddPZLSafG06nvQ2mnXOK
         db5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4qWySFdPWlDDj6CvZ29MtpOtvG59NiLUFJ1wNv+nZw=;
        b=aet/ImDrGdQ587dpMYOkxv/XlNcWWFbNjoN5eJw0pkOR3aaS8/WTbdHjafHj+1jEuv
         pKp4H4SdXOYsu57aXFan1h08MJbgO9O1n1MSwcB3CnQEdT6tOkx82dgAHhCyFYzTyFU4
         VJ5Ji4iBxa25Ba7K6Xvg6Wn8F9X5pNPXqya9eYcHm+SJ9IAn2CBG/vFmE/Z/a2um/Gvc
         XVdJ4/CngGKTl74zUbbSBunRM3FX5ECuZnTgume+EqLjxcsFeYFeHz4M+KLeZ+bQA4Zt
         5NmwlwXRbe2vIHSivNF1eek9f8mritB8770kRlPeKzemvpY7BnGvlRb5Xx1T4nje9FOJ
         Qykw==
X-Gm-Message-State: AO0yUKWOkeiObN4o3qleCs5/9g51HfnYDEVVVAUiEscCw33HYTb25JOw
        LVhpRHTfw43H0PzZVNSy1vmuRw==
X-Google-Smtp-Source: AK7set+atwKYMV7RT2tbpxUR8z1N14xNVSqX1awpewm7AY0VYOHXhzDGhP8g+m7t5X7BRFFIqUmsAg==
X-Received: by 2002:a05:6000:124f:b0:2c3:ea68:c580 with SMTP id j15-20020a056000124f00b002c3ea68c580mr3963480wrx.11.1675940334812;
        Thu, 09 Feb 2023 02:58:54 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d6987000000b002be063f6820sm927987wru.81.2023.02.09.02.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 02:58:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Lukasz Majewski <l.majewski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Anand Moon <linux.amoon@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH 6/6] ARM: dts: exynos: correct TMU phandle in Odroid XU3 family
Date:   Thu,  9 Feb 2023 11:58:41 +0100
Message-Id: <20230209105841.779596-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230209105841.779596-1-krzysztof.kozlowski@linaro.org>
References: <20230209105841.779596-1-krzysztof.kozlowski@linaro.org>
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

TMU node uses 0 as thermal-sensor-cells, thus thermal zone referencing
it must not have an argument to phandle.  This was not critical before,
but since rework of thermal Devicetree initialization in the
commit 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree
initialization"), this leads to errors registering thermal zones other
than first one:

  thermal_sys: cpu0-thermal: Failed to read thermal-sensors cells: -2
  thermal_sys: Failed to find thermal zone for tmu id=0
  exynos-tmu 10064000.tmu: Failed to register sensor: -2
  exynos-tmu: probe of 10064000.tmu failed with error -2

Fixes: f1722d7dd8b8 ("ARM: dts: Define default thermal-zones for exynos5422")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index a6961ff24030..e6e7e2ff2a26 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -50,7 +50,7 @@ fan0: pwm-fan {
 
 	thermal-zones {
 		cpu0_thermal: cpu0-thermal {
-			thermal-sensors = <&tmu_cpu0 0>;
+			thermal-sensors = <&tmu_cpu0>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
@@ -139,7 +139,7 @@ cpu0_cooling_map4: map4 {
 			};
 		};
 		cpu1_thermal: cpu1-thermal {
-			thermal-sensors = <&tmu_cpu1 0>;
+			thermal-sensors = <&tmu_cpu1>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
@@ -212,7 +212,7 @@ cpu1_cooling_map4: map4 {
 			};
 		};
 		cpu2_thermal: cpu2-thermal {
-			thermal-sensors = <&tmu_cpu2 0>;
+			thermal-sensors = <&tmu_cpu2>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
@@ -285,7 +285,7 @@ cpu2_cooling_map4: map4 {
 			};
 		};
 		cpu3_thermal: cpu3-thermal {
-			thermal-sensors = <&tmu_cpu3 0>;
+			thermal-sensors = <&tmu_cpu3>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
@@ -358,7 +358,7 @@ cpu3_cooling_map4: map4 {
 			};
 		};
 		gpu_thermal: gpu-thermal {
-			thermal-sensors = <&tmu_gpu 0>;
+			thermal-sensors = <&tmu_gpu>;
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 			trips {
-- 
2.34.1

