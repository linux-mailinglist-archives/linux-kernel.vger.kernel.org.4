Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0163641F10
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 20:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiLDTFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 14:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiLDTFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 14:05:48 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E12E14026
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 11:05:47 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id l8so11209668ljh.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 11:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fOkUWfwAEqEzsDfAQfX1TNmcS7jrk017aaxtEsZwg3w=;
        b=ZTNbddQHgd0LLg/hU58f9CCn3qYyhVi0Q3mLdmb9Nt1UWSvhp53RY3wnohjjeRwH8+
         y+Ij0CYqea/Mcmxdm4AT3exMzkes2CjXLMGbXVPSAzJoAbEJO5YSlJhHmtE/UAlF2nTi
         ojEwrPdqqSxlBM+SuAstOQH31k0Gj1qzgx7BXZL+pI3hYl5bzrCRI5Jp+VYn72KmgEYN
         ZJEl13lKCJpCUVQmHlO7Jqzwa4NMx6FHlrSUlH2fGhGsblXM7AhQwpVDl141RKdixOF2
         pvrp36nzg+cNOEAVO6hiydz0PYnf5e/kakjQYqWpbkLm+OEdQrPAu4angmV7XcD0SUdD
         mV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOkUWfwAEqEzsDfAQfX1TNmcS7jrk017aaxtEsZwg3w=;
        b=V7X91rGOpL1H3SyUnqemK8ggoi1C4jTWj6zOaapr5dnXX3Qv/0qzvYe60s+p042ik7
         YFok9Q3oF6EDhrknH/w3MmYdo3X+ZvsNgaKAh1Cm4ulHHmc60tjMi5n/GM0OJBsZUsjH
         FvbP41nBDVEfpJnjNbJ/UNUYQbTICYP6XaYWoconSkjYg7AxWms+cRVCGRfUwLlxmF59
         2knVGtjvl7AqEefz7MaPCY+/tyCpKGcYvTlvo2TatHHnt0RsrajeGUp8Z3ocOipgZae0
         D95j1sfzNNZnHpEnSY3TUsqCOnWfbk0Em1MlI5o1s/q07bZC1S/pyqsve61ASLhFG/rg
         YX3w==
X-Gm-Message-State: ANoB5pmuo1/cLfF2crIEdhqzqh+1vI3C5jpPhkwjDPQaWFYfWMoanp+v
        X+9Sprlgdr/qCcltcvy+GIprJg==
X-Google-Smtp-Source: AA0mqf6i9EYbQ5z5XJ5cwHtDd0TwyN5OKNT8DDDYNQOmW60uA4XuhaUv1KRzgYurPQSEqIzuDU4Fxw==
X-Received: by 2002:a2e:b943:0:b0:277:1d7e:9f6b with SMTP id 3-20020a2eb943000000b002771d7e9f6bmr23156379ljs.421.1670180745459;
        Sun, 04 Dec 2022 11:05:45 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bi35-20020a0565120ea300b004ac6a444b26sm1847644lfb.141.2022.12.04.11.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 11:05:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: exynos: drop unsupported I2C properties in Espresso
Date:   Sun,  4 Dec 2022 20:05:42 +0100
Message-Id: <20221204190543.143986-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The Samsung HSI2C (High Speed I2C) bindings do not allow
samsung,i2c-sda-delay (present in older S3C24xx I2C bindings):

  exynos7-espresso.dtb: i2c@13660000: Unevaluated properties are not allowed ('samsung,i2c-sda-delay', 'samsung,i2c-max-bus-freq' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
index e38c59cf18dc..b846c0be90e3 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
+++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
@@ -83,8 +83,6 @@ &adc {
 };
 
 &hsi2c_4 {
-	samsung,i2c-sda-delay = <100>;
-	samsung,i2c-max-bus-freq = <200000>;
 	status = "okay";
 
 	pmic@66 {
-- 
2.34.1

