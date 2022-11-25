Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21F7638C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiKYOlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiKYOl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:41:26 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644593D900
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:25 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id q7so5390366ljp.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HgxiuTX4VKScSQmCWe4o7A4ExXScF28UXl1daTYv5tk=;
        b=MfJxCWZewN2Ho8Uj0JLRI4j0u2uSNLQ9sZjUuZLphViWREscRwZxCTwopdBiDkqlUT
         zw9X4PXnXH0BlbGlogVs/6ql9vncE+XrfFE2irnEXWMh/38XV+re368Yl8bNibctwP6F
         00mLisi2x/nqN0ljrfn6lRhyFvOE9WUHr7hOSmvLrP9sOCz1AGgXae+D5CPqG8uEffNz
         l7tva+R73R/H+7XLUD8fTqmziDEhiL3FdAAwRjrXRyUrh+tUhu2guykZ8QuiEFdUfAKm
         uppB4W0zz3wdB1ZCBoIafZxNQRxqbhPAUm3rx9h8gK2omAqtEo0/rPIU5ONnb5gy4Z+C
         oTqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgxiuTX4VKScSQmCWe4o7A4ExXScF28UXl1daTYv5tk=;
        b=uyrkJ54y3hqZoBilp7fo8J5Mhw8k8jN4gK3ye059PNQbne4jiAtE5uM23Az2dKAisz
         3Wg0x9bii96RPbIYI+/ykVtZTDJJ5N5kaJEVoSFrO6hkHrM9rINClSCuQ2SHVg6aKwIt
         R9BsWzphWq0hN5rivP+nqJdczZBHqbGDL5EgIAJrZ3oO16s4jBWfsdryFN8r+Wq/B4ku
         GyqGTtutLsI4EihihiDbnPSLnLds75XF4HsN/0bE9SisCHv4FcGjV4ZRyzCx/5bQ6zAW
         Zp9IuV0Bua0Mg6E59c2rTWNr0nl4K+vvSx2Jidg7+2io6eAKn0+nIhtK7YbwXLmoglYI
         tPvA==
X-Gm-Message-State: ANoB5pld0vEJ7ACwmQt5Luj4JTkLWse7/CbWpew/U2H3Nw3yRy+F5bQc
        s/EX5S2enqwjsk0AbUA/ZhuRuA==
X-Google-Smtp-Source: AA0mqf65T7kwiHapuwH6q5HKEBXtq8vsYGeGbYkaEWBpbZdRMS0S/J4e5m4PZqH90IrTlO8zdGsfkQ==
X-Received: by 2002:a2e:b818:0:b0:277:206:9c45 with SMTP id u24-20020a2eb818000000b0027702069c45mr13528833ljo.457.1669387283702;
        Fri, 25 Nov 2022 06:41:23 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o13-20020a056512052d00b004b48cc444ccsm545334lfc.100.2022.11.25.06.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:41:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: logicpd: align LED node names with dtschema
Date:   Fri, 25 Nov 2022 15:41:22 +0100
Message-Id: <20221125144122.476962-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and DT schema expects certain pattern:

  logicpd-torpedo-37xx-devkit.dtb: leds: 'user0' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
index 3a5228562b0d..72b5af475d09 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@ -20,7 +20,7 @@ memory@80000000 {
 
 	leds {
 		compatible = "gpio-leds";
-		user0 {
+		led-user0 {
 			label = "user0";
 			gpios = <&twl_gpio 18 GPIO_ACTIVE_LOW>;	/* LEDA */
 			linux,default-trigger = "none";
-- 
2.34.1

