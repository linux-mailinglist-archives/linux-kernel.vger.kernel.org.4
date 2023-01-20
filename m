Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC2D67594C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjATPzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjATPyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:54:44 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B2E5E536
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:54:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so6130321wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSgM6n49EcyShr7fktwdqot3K5AnX5J3htXp++CJjcc=;
        b=CqA6PkaGMtx+7DxIVeb9sNrO2cMLSAP4jLzXDmtYGVMDnO4n8FKU1XsKN/ScyoB+mP
         CY8gJO9tKusLityrvFcnX5NQ5qAhbdj/2ixMEGQfCZ4UhVz3yECHfq63a8w+33n8YtkE
         U3k8drugwg1A7LA21QHPQqRAiB4oeiGJiaRV7z0BH3iN3tMrJp1Nf5wot/i+INxG8V6z
         RcT1hvLvRc2jRv+ls1Ho2ZWBd68Lx4iJgGGR9qHAI/p9vfL+trU5Zd6/kq2y/ZxTiUxA
         9mSkRLMIK4hh+rVAZX9MNc5hfmm7xSpXqnH1nv8kcl0bfHn86ORS2QWIGOYCN87s5gii
         uWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSgM6n49EcyShr7fktwdqot3K5AnX5J3htXp++CJjcc=;
        b=CS7cTGRH0n1hgQYu0NIelk8OPEpDk67t0v5dwBFZ+xiBmnPgyJFojHwy74XcW91l3t
         VfoeniVzQ0lVoHdG4Nu7U51V23L7wP6ZOkj7aCxwIgm1y9nAWss/dCJB08fWFwbf+9EY
         Qn6d63n7PCCDGbKB1JXSnGZY04gkbEShtJ82EeY5RopYbL+I7nBcfFGBllZIZ4NBDsFj
         1Qf4zbBAN+rdcZ2LrMRTb5AIzdUcK/EWI3uQa9W86fdfFKr9lWuR932+iwYJeDaG9u4p
         EjvWvOO2H8fvltbXNEM7ZSXehJc0QPvwTkv9vRMWit4ZmC01e9AmlnAQuPyfw0ALltkw
         GT8g==
X-Gm-Message-State: AFqh2kp8G2QOORbcmWcThUsaWx8TTS+6t9QmR23gC6jJ18YQtdqL/XtV
        bV1v+r4o6uMFPLG4UWc4+2aNHw==
X-Google-Smtp-Source: AMrXdXtfWuN/VpvBtso8zJRkonoucoMHvJlt8jabUZsECy6yV9zjjBJaMqPyhxI1boBEX6X3fA8krA==
X-Received: by 2002:a05:600c:600e:b0:3da:fb0b:849f with SMTP id az14-20020a05600c600e00b003dafb0b849fmr14952401wmb.25.1674230069613;
        Fri, 20 Jan 2023 07:54:29 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n42-20020a05600c3baa00b003d96efd09b7sm3349596wms.19.2023.01.20.07.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:54:29 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 11/11] ARM: dts: exynos: correct HSI2C properties in Exynos5410 Odroid XU
Date:   Fri, 20 Jan 2023 16:54:04 +0100
Message-Id: <20230120155404.323386-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120155404.323386-1-krzysztof.kozlowski@linaro.org>
References: <20230120155404.323386-1-krzysztof.kozlowski@linaro.org>
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

The HSI2C controller uses clock-frequency and does not have
i2c-sda-delay.  The properties were copy-pasted from the slower
S3C-family I2C controller:

  exynos5410-odroidxu.dtb: i2c@12ca0000: Unevaluated properties are not allowed ('samsung,i2c-max-bus-freq', 'samsung,i2c-sda-delay' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/exynos5410-odroidxu.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
index d1cbc6b8a570..232561620da2 100644
--- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
+++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
@@ -164,8 +164,7 @@ map2 {
 };
 
 &hsi2c_4 {
-	samsung,i2c-sda-delay = <100>;
-	samsung,i2c-max-bus-freq = <400000>;
+	clock-frequency = <400000>;
 	status = "okay";
 
 	usb3503: usb-hub@8 {
-- 
2.34.1

