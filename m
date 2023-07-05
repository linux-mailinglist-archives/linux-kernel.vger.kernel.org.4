Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F255874870B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 16:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjGEO6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 10:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjGEO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 10:58:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7A3FF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:58:01 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9923833737eso612070366b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569080; x=1691161080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9TXmyffj6SDIx2DlhbRmyINxNWCM9g8iPJmckmavVI0=;
        b=eza3My4Ao3j9TghRrLi5iuA6532Yv8j10igwzA6GPNFf7gVBb43uQ1IQg4smmoA1De
         HJ4N5cVqwnLAdf7EU7cO+gBBlcAfx82/5f1WDlD234mBdcOmr/MJcHZQVzDVKLe3B7Td
         isPQUgTT+zEvYvXPlajkMdUOiczzoac3y6trVnt0yLXiwhoxPNDyJknEcNpYq2wDmDIs
         vevYCfqPJphpfne1Rt0kw46nlazbprYt6dvn4rbpDvDKXPj70K02ApnDD+l6hPHEtju0
         GYi9u1ebG2TpUGsPbajGyyEOt+s8etxCpHXDJRO6nfy/99K5wc6wDN19yhhsbKVJ/gZG
         SmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569080; x=1691161080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9TXmyffj6SDIx2DlhbRmyINxNWCM9g8iPJmckmavVI0=;
        b=eNblXRbqH3q0wOqXFKzvlc/BWE6uxq6EVINlqCIFfFEAPxs17j7e5NFcQ8WhCm+FjX
         PN01QvmB9OzQ1FspVm+F8AIpO0mcdtIH7KvHfGafJj2YcG6j2JPCTkW5PVvaScTE9X+p
         pVureR0YSy1u2QwMc+jtnPKbpVQef07GVabX1wiKqp/qfy+zfcUIj4AhFJlXoiB4XfS1
         /jJI3aF2iUq9hs7EU53EV1gjnbfkJVeitPpYxC1oMO8t0CI4KZxYfR7yKJw//f9Jwjqr
         nOTvDbJ7sqo5unemCvCQnwmuycLzHxHKyMKAkqJRfsQ5gPbhze80awK+k/1vUVzKwsih
         QnRA==
X-Gm-Message-State: ABy/qLbEARkJzfOIhhxvQWKviWu1Mz74ehP8/X17ZSnTImVgmFK5h53w
        AjH+NvDslRpIIu4pVpwlaynT6A==
X-Google-Smtp-Source: APBJJlEbtA05Ax7aea+dVyf3c8SLdBrzK2FOyV4V9q1C8xtMUNRr5C5jxL3lrdZNSbn2yzI1sBVYuQ==
X-Received: by 2002:a17:906:27d8:b0:992:a90a:5d1f with SMTP id k24-20020a17090627d800b00992a90a5d1fmr13016183ejc.68.1688569080031;
        Wed, 05 Jul 2023 07:58:00 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id t19-20020a170906065300b009882e53a42csm14650339ejb.81.2023.07.05.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 07:57:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     David Lechner <david@lechnology.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: ti: add missing space before {
Date:   Wed,  5 Jul 2023 16:57:54 +0200
Message-Id: <20230705145755.292927-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/ti/davinci/da850-lego-ev3.dts | 2 +-
 arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi | 2 +-
 arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts    | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/ti/davinci/da850-lego-ev3.dts b/arch/arm/boot/dts/ti/davinci/da850-lego-ev3.dts
index afd04a423856..17a1632a8ac1 100644
--- a/arch/arm/boot/dts/ti/davinci/da850-lego-ev3.dts
+++ b/arch/arm/boot/dts/ti/davinci/da850-lego-ev3.dts
@@ -391,7 +391,7 @@ &spi1 {
 	pinctrl-names = "default";
 	cs-gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
 
-	display@0{
+	display@0 {
 		compatible = "lego,ev3-lcd";
 		reg = <0>;
 		spi-max-frequency = <10000000>;
diff --git a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
index 8949578e62e8..2062fe561642 100644
--- a/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi
@@ -137,7 +137,7 @@ uart01_spi2_pins: uart01-spi2-pins {
 				>;
 			};
 
-			dfesync_rp1_pins: dfesync-rp1-pins{
+			dfesync_rp1_pins: dfesync-rp1-pins {
 				pinctrl-single,bits = <
 					/* DFESYNC_RP1_SEL */
 					0x0 0x0 0x2
diff --git a/arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts b/arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts
index 863552393c07..edaddc7b6a5e 100644
--- a/arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts
+++ b/arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts
@@ -58,7 +58,7 @@ vdd_core: fixed-regulator-vdd_core {
 		vin-supply = <&vdd_corereg>;
 	};
 
-	v1_8dreg: fixed-regulator-v1_8dreg{
+	v1_8dreg: fixed-regulator-v1_8dreg {
 		compatible = "regulator-fixed";
 		regulator-name = "V1_8DREG";
 		regulator-min-microvolt = <1800000>;
@@ -68,7 +68,7 @@ v1_8dreg: fixed-regulator-v1_8dreg{
 		vin-supply = <&v24_0d>;
 	};
 
-	v1_8d: fixed-regulator-v1_8d{
+	v1_8d: fixed-regulator-v1_8d {
 		compatible = "regulator-fixed";
 		regulator-name = "V1_8D";
 		regulator-min-microvolt = <1800000>;
@@ -78,7 +78,7 @@ v1_8d: fixed-regulator-v1_8d{
 		vin-supply = <&v1_8dreg>;
 	};
 
-	v1_5dreg: fixed-regulator-v1_5dreg{
+	v1_5dreg: fixed-regulator-v1_5dreg {
 		compatible = "regulator-fixed";
 		regulator-name = "V1_5DREG";
 		regulator-min-microvolt = <1500000>;
@@ -88,7 +88,7 @@ v1_5dreg: fixed-regulator-v1_5dreg{
 		vin-supply = <&v24_0d>;
 	};
 
-	v1_5d: fixed-regulator-v1_5d{
+	v1_5d: fixed-regulator-v1_5d {
 		compatible = "regulator-fixed";
 		regulator-name = "V1_5D";
 		regulator-min-microvolt = <1500000>;
-- 
2.34.1

