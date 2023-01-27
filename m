Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2865C67F03C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjA0VQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjA0VQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:16:03 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2E88A54F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:15:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so6235757wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 13:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=smuQo4geAWNJOxGHerqBUE4luc859AqeHaJfREjKn6k=;
        b=TKYaTnlPCJXzUlUuoiMXOsYJ9mzHNkAuMvU0eC8uoS4KLrDVikMnh14coxBjOtinzg
         sPXwL0xNcCC0soLP7ahjYO45rySby6got1EIXVy17ddsAU6kV1xzPQ5PoM1WgrbiOE/S
         tCCW2QnIW+4FItE9bSwdCHM86hG2HBGcFertfs9iDmCMmaDchdaqvLVKvxaYaOsGIgb1
         JqEKcDPRAxlaWzgTSU4uvkzjdhr0q4w+zek26zX9BfyEO5wfnVPztHFiUglcNS3AY/bV
         K8YK7aD0l0vidUoD2gMToc3hm+Q+3xV3AkaJE5M0REOWoaMcsHirZuRo/1iIa1ebB5yM
         pGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smuQo4geAWNJOxGHerqBUE4luc859AqeHaJfREjKn6k=;
        b=jtg405loUsgiNFehoP4NNfD5GZtie4UbV+5l0faaWGXPxBf08gDU2ySUdDhqVsu9v7
         43J2pKRPKhtb2J7yMn5D6GIF5+ZW8/Ogdqy4QzF/OSGCHDlnrVZjDI+cviKwRBgj0lOm
         6qvyNB8H46mvxS+ZOS5wbwF98Fmve0Ai2W6Q+WSBNdeIbFYa913Ugr2a/Mki9c4T/oyA
         8bmh7h59Vay4HMQ0PxvVG4gDCEsAvu7DJYk62Su431vfxaqy8Uazd48FdN9dyi22Reyq
         gUmT+S/g8RDVITeQrZniXBoJI79xmdR61PKJYrAMjTYoPcbLYaeB2uKLhE1XIlzgmdW+
         FT5w==
X-Gm-Message-State: AO0yUKXd1q4E4hK6ktASJrQIrcCJuClCuxzExLDPfZnR9Io5kTI/M0fV
        daDE+4qXYScJBV8SQ2K9d7R6vg==
X-Google-Smtp-Source: AK7set++T0+otINhEwRRF0+uWq9i5p8hoTzW1FAWYK+36ztUqu67rhVSd6l7suDxXAlNZ5vjAxn/7Q==
X-Received: by 2002:a1c:7c0d:0:b0:3dc:445f:642 with SMTP id x13-20020a1c7c0d000000b003dc445f0642mr748298wmc.37.1674854135371;
        Fri, 27 Jan 2023 13:15:35 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc350000000b003d9aa76dc6asm10513504wmj.0.2023.01.27.13.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 13:15:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     replicant@osuosl.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 1/4] ARM: dts: exynos: add unit address to DWC3 node wrapper in Exynos5250
Date:   Fri, 27 Jan 2023 22:15:24 +0100
Message-Id: <20230127211527.260060-1-krzysztof.kozlowski@linaro.org>
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

Neither simple-bus bindings nor dtc W=1 accept device nodes in soc@ node
which do not have unit address.  Therefore usethe address space
of child device (actual DWC3 Controller) as the wrapper's address to
fix:

  exynos5250-smdk5250.dtb: soc: usb3: {'compatible': ['samsung,exynos5250-dwusb3'],
    ... } should not be valid under {'type': 'object'}

  exynos5250.dtsi:638.16-653.5: Warning (simple_bus_reg): /soc/usb3: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. Use ranges with values and drop reg from usb-wrapper node.
2. Keep "usb" as wrapper's node name.
---
 arch/arm/boot/dts/exynos5250.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 97e89859ba3d..a5db4ac213d5 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -635,17 +635,17 @@ i2s2: i2s@12d70000 {
 			#sound-dai-cells = <1>;
 		};
 
-		usbdrd: usb3 {
+		usbdrd: usb@12000000 {
 			compatible = "samsung,exynos5250-dwusb3";
 			clocks = <&clock CLK_USB3>;
 			clock-names = "usbdrd30";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges;
+			ranges = <0x0 0x12000000 0x10000>;
 
-			usbdrd_dwc3: usb@12000000 {
+			usbdrd_dwc3: usb@0 {
 				compatible = "snps,dwc3";
-				reg = <0x12000000 0x10000>;
+				reg = <0x0 0x10000>;
 				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&usbdrd_phy 0>, <&usbdrd_phy 1>;
 				phy-names = "usb2-phy", "usb3-phy";
-- 
2.34.1

