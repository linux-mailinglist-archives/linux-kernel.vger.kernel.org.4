Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6011691F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjBJM2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjBJM23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:28:29 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA499735AC;
        Fri, 10 Feb 2023 04:28:27 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id o18so4927289wrj.3;
        Fri, 10 Feb 2023 04:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96shaXIQtfSOpk1V2rzXl80X1bE5l20ZAqgUNK1DbvU=;
        b=RE/Wr27m9sEApv2s1qrJJM+eayomNFEo2RBl1PPDJP/TtxoFTGk/vOZuq/UuQ9mbLn
         vrTnandG9q62o+Su9jWdKwqY8MCX1PwwlgpnMz4DHlfvuA8VQTI7ha8vE7r14A0pu38D
         w0Xyhgh3KyR4QM5vjQ6Qayy4Jb/trLyjV0fSS03XVTGjmBHoZPgDccJKRlTK8e7Hlhyt
         e9b47bWYpGg3SQQ18aZyBt/BgSPt1D3nDpAB2kbGhp2nux5vPUpnhcvAFFaQYLRs0jkY
         68keMPReixiEN4z2hjWy4AIeMR2LtbPlrA/YwYQs7Sz/rPDb7nCWySC0ecTPLr6rQqRm
         aOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96shaXIQtfSOpk1V2rzXl80X1bE5l20ZAqgUNK1DbvU=;
        b=5CMcG3ZI9s8Q/mgx3HehNMwjY2fgcWHWFJ7+jg22JlR7UVvtZpxKF4DIPlSTVFpw2Q
         OIgBOqxNOH7Z4g/RO+VYCznRHsQTHO8gUGxI0+hFo9wWJu/qo9IaVlNhwK8CDbMZywqG
         jCFxXR2ZXEApDm5GAMU00yG6rfQg8nU0nn/oPv29jzQzlN2aBq8TU2NlmgphvRe8X6aN
         Pf9Abnk4x47sIM5Mef4kiSvsCBthBlHX2xfMv/kdDOO8jyRrdlaowTn2pqeq8aHztc6J
         ot4idWCXiydMq/6gvFWcahUPa+fkyg+pdNqf7+kS6dYbBsPEhrNR6HVg0sYstXfrG13r
         EPCw==
X-Gm-Message-State: AO0yUKWrLOmb7vNhQvSEzW1JyY3FnyD/WofutRiYQMlwJsdvXmgxkTnR
        /lSa60njSB5DQdlo31qFCXoqMMJSTNI4Dg==
X-Google-Smtp-Source: AK7set+t0+m6XIrOzmtRzoIAnUN/GgzwO1HROtUPFwytx/bCrcDytT0e7JqMLb9G+nqozFSXrVjohQ==
X-Received: by 2002:adf:f212:0:b0:2c3:f250:f217 with SMTP id p18-20020adff212000000b002c3f250f217mr14814903wro.1.1676032106485;
        Fri, 10 Feb 2023 04:28:26 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d4388000000b002c5493a17efsm1540989wrq.25.2023.02.10.04.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 04:28:25 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Ferass El Hafidi <vitali64pmemail@protonmail.com>
Subject: [PATCH 1/3] arm64: dts: meson: gxbb-kii-pro: sort and tidy the dts
Date:   Fri, 10 Feb 2023 12:28:15 +0000
Message-Id: <20230210122817.1027765-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230210122817.1027765-1-christianshewitt@gmail.com>
References: <20230210122817.1027765-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alpha-sort the nodes, move the default line in the LED node to where it's
normally found, and remove excess spacing. No functional changes.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Tested-by: Ferass El Hafidi <vitali64pmemail@protonmail.com>
---
 .../boot/dts/amlogic/meson-gxbb-kii-pro.dts   | 32 ++++++++-----------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
index 6d8cc00fedc7..9bfdb54d912a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts
@@ -6,21 +6,22 @@
 /dts-v1/;
 
 #include "meson-gxbb-p20x.dtsi"
-
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
+
 / {
 	compatible = "videostrong,kii-pro", "amlogic,meson-gxbb";
 	model = "Videostrong KII Pro";
 
 	leds {
 		compatible = "gpio-leds";
+
 		status {
 			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_LOW>;
-			default-state = "off";
 			color = <LED_COLOR_ID_RED>;
 			function = LED_FUNCTION_STATUS;
+			default-state = "off";
 		};
 	};
 
@@ -34,24 +35,8 @@ button-reset {
 			gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
 		};
 	};
-
-};
-
-
-
-&uart_A {
-	status = "okay";
-	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
-	pinctrl-names = "default";
-	uart-has-rtscts;
-
-	bluetooth {
-		compatible = "brcm,bcm4335a0";
-	};
 };
 
-
-
 &ethmac {
 	status = "okay";
 	pinctrl-0 = <&eth_rmii_pins>;
@@ -78,3 +63,14 @@ eth_phy0: ethernet-phy@0 {
 &ir {
 	linux,rc-map-name = "rc-videostrong-kii-pro";
 };
+
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+
+	bluetooth {
+		compatible = "brcm,bcm4335a0";
+	};
+};
-- 
2.34.1

