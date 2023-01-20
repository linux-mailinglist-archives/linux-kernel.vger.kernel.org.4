Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF2C675B93
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjATRb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjATRbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:31:42 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4FBDB78F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:31:26 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso4246393wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPDJ68b8IxMUl5mB1tsFwQDgmc6rDP80xVh613X2ajQ=;
        b=zbCADTBQxsQofsRbTh94uiwCE+Qc648XidbvI5CdCs8O/xacqejqzrThdBrPyrYIzx
         zUmnl8NTcGN9vXQ4Y3gBOqf79/O6o/VHqoGklAh6CXyb8ZFfBxxDMwwb0vWGUD2G8PBn
         XtA/ayeaojCofVcAcBshr3hcui8BeH4dF5g+P/jsABcqRZvfIo6194FQzT2NKc1tu2Xp
         qhA2ztPr3cGKxzuh+wrPY/iURtziL8kRIlhZHHHxB0N1W3UG3iRbi9XoaUNSbH+EF4XO
         drR4VcS0e4PBjxBrUd18u0AM6Ex20n6yoWXDl1Tw11Nzwh11Y0qvnEF/oKssmUXEtQns
         +b/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPDJ68b8IxMUl5mB1tsFwQDgmc6rDP80xVh613X2ajQ=;
        b=JVtiUMjNNRepVpAHNZCyRLy/3n4x7wo+KukKGx0zaoy+PtPnp3U5OBV9qORjW6Lvav
         Symw04HhqAFTcdy+Y/ONbNVuTJD33JisJ9QCt3PebNzHUQTX4LxlJY0FlGwXuc7pyvi7
         pksEaBg3RKMXMm+pe7X8KN27AyJ4isFhOKAA1oX4bERzx2k64BNKGolZ7pWq0AQBDTof
         NMZLkFtU+Fr2xN/guwWqyE06pGWfBQu/Y8su4r8OMx3ucPCoHG426CSwK8DGO2Ryp6n3
         NVaLWNxUkVjLk/NhzOnUlSOnnbhweTeIHUVLh4cDA6BTNeDWLks4vld+Fh9JxsLcAL3a
         5dYQ==
X-Gm-Message-State: AFqh2kpHd8/MhPnnaH/p9hXQ6PAAwY1Q1Thh7pGUjU1Sd7NdZxnhNM7x
        YtYgEqeCm6aW8pW90TfF4ve2oO+rt8kXzrmE
X-Google-Smtp-Source: AMrXdXsVSMzW2njv7OxvmaEwmew5JekBBPV987YVwQLPl7+fvw2taHhYxWLpSoFBtw2wr6Vaul67vg==
X-Received: by 2002:a05:600c:3d8d:b0:3db:2c8:d7e1 with SMTP id bi13-20020a05600c3d8d00b003db02c8d7e1mr15078867wmb.20.1674235884721;
        Fri, 20 Jan 2023 09:31:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id d22-20020a1c7316000000b003db0dbbea53sm2819179wmb.30.2023.01.20.09.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:31:24 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 4/6] arm64: dts: exynos: add VPH_PWR regulator on TM2
Date:   Fri, 20 Jan 2023 18:31:14 +0100
Message-Id: <20230120173116.341270-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120173116.341270-1-krzysztof.kozlowski@linaro.org>
References: <20230120173116.341270-1-krzysztof.kozlowski@linaro.org>
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

VPH_PWR is routed to battery, so it is not configurable.  However few
devices, e.g. WM5110 expect speaker power supplies, thus provide the
regulator for full hardware description.  Audio amplifier also accepts
that power supply.

Keep ordering the nodes by renaming existing IRDA regulator.

This fixes dtbs_check warnings:

  exynos5433-tm2e.dtb: audio-codec@0: 'SPKVDDL-supply' is a required property
  exynos5433-tm2e.dtb: audio-codec@0: 'SPKVDDR-supply' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi      | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 6f701297a665..3785a6580bdf 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -99,11 +99,18 @@ max98504: amplifier@31 {
 
 			DIOVDD-supply = <&ldo3_reg>;
 			DVDD-supply = <&ldo3_reg>;
-			/* PVDD-supply to VPH_PWR */
+			PVDD-supply = <&vph_pwr_regulator>;
 		};
 	};
 
-	irda_regulator: irda-regulator {
+	vph_pwr_regulator: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+		regulator-name = "VPH_PWR";
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
+	};
+
+	irda_regulator: regulator-irda {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpr3 3 GPIO_ACTIVE_HIGH>;
@@ -1298,6 +1305,8 @@ wm5110: audio-codec@0 {
 		CPVDD-supply = <&ldo18_reg>;
 		DBVDD2-supply = <&ldo18_reg>;
 		DBVDD3-supply = <&ldo18_reg>;
+		SPKVDDL-supply = <&vph_pwr_regulator>;
+		SPKVDDR-supply = <&vph_pwr_regulator>;
 
 		controller-data {
 			samsung,spi-feedback-delay = <0>;
-- 
2.34.1

