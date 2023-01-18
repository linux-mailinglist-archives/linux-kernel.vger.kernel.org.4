Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C52E6712B8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjAREpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjAREoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:44:54 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06750577D2;
        Tue, 17 Jan 2023 20:44:52 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id 127so7981932pfe.4;
        Tue, 17 Jan 2023 20:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itXWojnygtxjpIeaCDfV4R7hBZ6s5zXg2DD6bBlDmBs=;
        b=eftewbe2CBi/5TV64gKK9OavY/tDi6b+9se+BEA3Z28iy4AcsbG082daQioK7e3Loi
         804DCiNVLoBU7Mh3a2+1Li+ryCxBdytyRgUd00pGZsFgDegiZiKbMWPY9mZwcMMUPbQY
         SOi7EZ3xkmngdy0yPw7iMuvyve+0A8DhScdS/+HQwhB2tWzssJE4qPcgy4sEuBGzcaYf
         Bmb9MsJMk/PGphbVBl7Op+mFA71C5FNYN8qO5cu8jiC1v+eMPCV2hKmSnVSkRYzpeYXc
         oUpqg6WrvR1pt60FnCNTD0kWYUTVMPE9WZTa1cH84ZuYbQjp5tjOy7x64Lpx3x9f5Rsa
         8f1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itXWojnygtxjpIeaCDfV4R7hBZ6s5zXg2DD6bBlDmBs=;
        b=i0VUYEIpU708b43lmCEV0/y0uYcaB6XIBJPqdPERp9LUl0swq+yVV8AryScpkVtBm6
         odhdrJ+rohGIG9yoonIUT4ZFK4V/8kPUfMonckMTLuFel8u5/JfVJMjGLHZosuMI2N12
         wr4UDVhX5eo/TEaP4/tHhNWkF/Ngv5g3tc+Z3BsvEl2xh1vFnukeg4PD22+skrmt9hpu
         qqX0FWs/0G1wrqTsPoERaXyrcGaOyBXpKJb6Ghmh8OmObQGz5zaHX7oD01aTxtrInLA1
         0oMVxIMdAZxYrX7Stv3aV2LrHeY+oM0FylggvOG4NiS88YhzFhuIhgfrOpR4dD86x6Bs
         CGMA==
X-Gm-Message-State: AFqh2krrLprpl5CwztZT4FrZr8piha1Y2xfxzH656XUv6KWeu95S4Txa
        Ft8JTu+T5hYW3FIihI3nTVY=
X-Google-Smtp-Source: AMrXdXtBJtSFjDvd+tEKeroo4rlbneH5l+K+HTCDwQ7LNibIc+cAzkuTh9IotDPhn2l/gjbk/m3wtA==
X-Received: by 2002:a05:6a00:2986:b0:58c:8bdd:2e3c with SMTP id cj6-20020a056a00298600b0058c8bdd2e3cmr5927506pfb.20.1674017092407;
        Tue, 17 Jan 2023 20:44:52 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id i1-20020a056a00004100b00581a156b920sm8682770pfk.132.2023.01.17.20.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 20:44:52 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/9] arm64: dts: amlogic: Used onboard usb hub reset on odroid c2
Date:   Wed, 18 Jan 2023 04:44:11 +0000
Message-Id: <20230118044418.875-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230118044418.875-1-linux.amoon@gmail.com>
References: <20230118044418.875-1-linux.amoon@gmail.com>
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

On Odroid c2 previously use gpio-hog to reset the usb hub,
switch to used on-board usb hub reset to enable the usb hub
and enable power to hub.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2 - drop the vendor name from compatible string.
   - move the hub node to USB controller node.
   - drop the usb_otg_pwr since it only liked to OTG port
         and link p5v0 to the vdd-supply.
---
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 26 ++++++++-----------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 201596247fd9..01356437a077 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -250,21 +250,6 @@ eth_phy0: ethernet-phy@0 {
 	};
 };
 
-&gpio_ao {
-	/*
-	 * WARNING: The USB Hub on the Odroid-C2 needs a reset signal
-	 * to be turned high in order to be detected by the USB Controller
-	 * This signal should be handled by a USB specific power sequence
-	 * in order to reset the Hub when USB bus is powered down.
-	 */
-	hog-0 {
-		gpio-hog;
-		gpios = <GPIOAO_4 GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "usb-hub-reset";
-	};
-};
-
 &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
@@ -414,5 +399,16 @@ &usb0 {
 };
 
 &usb1 {
+	dr_mode = "host";
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
+
+	hub@1 {
+		/* Genesys Logic GL852G USB 2.0 hub */
+		compatible = "usb5e3,610";
+		reg = <1>;
+		vdd-supply = <&p5v0>;
+		reset-gpio = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
+	};
 };
-- 
2.38.1

