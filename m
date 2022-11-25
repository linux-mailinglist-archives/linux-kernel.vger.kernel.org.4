Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E61638C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiKYOld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiKYOlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:41:24 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD313C6DF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:23 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j4so7253352lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JYPGPhbKSDD4Yi3yKcSWtqL4ohr93TEPpG/GOA7tSMs=;
        b=zCxrDg4KzZC+Q++QDQvHJsB9LqFNwiu+Lu8BJUSHO1CL6NruP6KeKeWVVG5N2Ba1yF
         0eBnn8mHCpKBNAbfSUy65JiYOVO6PHJc+N/zqlq641+hzXA1BwLbKBDhZ4Ih/jGHi6nE
         qS2M6qXusvBlVrvERbCLxfj33hDbLu26Jv75GejqIrSDMuLODpaBzebKSSYyxXSV0PZt
         kPVDnMvUEqkX3Mb6AHjLjfjAulx1pkWsv7z+TZUN0igSa+7dcDqhO5yHt2Ov3J5aEp59
         XekZcDDHDzGHFvYAAzfEN643JeKnhIc173hJhg3R9MvHCa23YRx5X9GtY7ovHA/ASf8Y
         rnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYPGPhbKSDD4Yi3yKcSWtqL4ohr93TEPpG/GOA7tSMs=;
        b=c9Azrmy+XmDKV3kjgn8MeapuqvLMqRbu9xFw9OudUqmOl26i9RMZ3XyzEMFMEygyHJ
         ShXjDmbVXZEMWleMqbaJksqQphV0cWI7YogyjFX3b6VU/Z/C2gW+QBDKR+4HKt3qGPiQ
         w/hJ2br/tzvtCwYCGj3kvEEeCNncK3509e8zxy3JbmE+G7lZCmKsLmMjFvsApEFKcBSl
         xtIs6SWuAgP7Ddd2x0BNZHZx6zal8f6mQ5INxKNoyzMxtpU9CkHsjJxvEwrpMO3gag5h
         7I7HjBndS7aBBH9BX13/LkLfRiKB4Jzel19797y3E1ML76pXJ50hK+c/76gFRwoicZeR
         jRHQ==
X-Gm-Message-State: ANoB5pmOILmuNeWgw089pNlchc++V2/HGaAon5CzXsiuX2sbKRwxy3Nl
        Jz9ubXDFfneQADQ6dlGz5X7RIg==
X-Google-Smtp-Source: AA0mqf7psPSJLNiKBUVKlkpJa5oB0/UKp3ZhlM5uP2H+JThneQXMxRTa4AB5zQyEQ32XmPqYxl8xVw==
X-Received: by 2002:a19:4319:0:b0:499:b108:947e with SMTP id q25-20020a194319000000b00499b108947emr12557043lfa.143.1669387282048;
        Fri, 25 Nov 2022 06:41:22 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s11-20020a056512314b00b004b0317a1035sm548617lfi.109.2022.11.25.06.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:41:21 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: meson: align LED node names with dtschema
Date:   Fri, 25 Nov 2022 15:41:20 +0100
Message-Id: <20221125144120.476933-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The node names should be generic and DT schema expects certain pattern:

  meson8-minix-neo-x8.dtb: gpio-leds: 'blue' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/meson8-minix-neo-x8.dts | 2 +-
 arch/arm/boot/dts/meson8b-ec100.dts       | 2 +-
 arch/arm/boot/dts/meson8b-odroidc1.dts    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/meson8-minix-neo-x8.dts b/arch/arm/boot/dts/meson8-minix-neo-x8.dts
index 56ea875c418c..c6d1c5a8a3bf 100644
--- a/arch/arm/boot/dts/meson8-minix-neo-x8.dts
+++ b/arch/arm/boot/dts/meson8-minix-neo-x8.dts
@@ -27,7 +27,7 @@ memory {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		blue {
+		led-blue {
 			label = "x8:blue:power";
 			gpios = <&gpio_ao GPIO_TEST_N GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index 77d4beeb8010..3da47349eaaf 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -73,7 +73,7 @@ gpio-poweroff {
 	leds {
 		compatible = "gpio-leds";
 
-		power {
+		led-power {
 			label = "ec100:red:power";
 			/*
 			 * Needs to go LOW (together with the poweroff GPIO)
diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 04356bc639fa..73cdfe855689 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -34,7 +34,7 @@ emmc_pwrseq: emmc-pwrseq {
 
 	leds {
 		compatible = "gpio-leds";
-		blue {
+		led-blue {
 			label = "c1:blue:alive";
 			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
-- 
2.34.1

