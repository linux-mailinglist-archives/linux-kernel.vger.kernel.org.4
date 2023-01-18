Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381CC6712B6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjAREow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjAREos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:44:48 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6285529A;
        Tue, 17 Jan 2023 20:44:46 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 141so23666951pgc.0;
        Tue, 17 Jan 2023 20:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOZIHycE9J4e+QjHg9b0KwNQ3/76PPTpjk62HfVA/Y0=;
        b=OJuw6le0pCCAULCnT1UzwWJNBacWJkKrbd/NOWxdmdIpKeNJl+KuBpxAJU0lhgAj82
         Az+VloMvKZMSNoSLxnVhk0DnG82GaMNSnGvd7WyDZFNrY1sElMr5KZaaiT7JcbZzBEDI
         BGHaYwe2DPyRcLPpqGXdFJvu+ZPTxePpFogNXwsxAn9IhdhFkC2n/t8WejM1zSa79t7p
         9EPwmUdf0/xonjMwlTmZ/g6pAEYB1xHEHMyW2tvhOqpKVDBGnhqA5smuD4jW/MGOC1Yl
         RqWf8pGAckns4JS/9KHOacHQpNFuF1Q8/5dMzzYP1qQQLeTMzv6qfQ3KljxZViULmBcJ
         Brbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hOZIHycE9J4e+QjHg9b0KwNQ3/76PPTpjk62HfVA/Y0=;
        b=gnc3fmCVi1DsnyJqw5ESM42rpbllrIkOADBIuSWiA93NxK2dl1m10iKto9gFeuFGK9
         e5PXnyU/Expb8TnaoknvniV9FCaggmN7p9BFqnTljW/4hjjuzn84SZu2gCTxK+dZcDIg
         E46H2ifgyLeP+mmejV6Fangn1tTqLr8NMkVvwqrsSLLSq5nqYODkqbDhrusMoz+HmJoD
         cCSpbYFPWTdGydcz4lmBbo7K2LIR0vqzQy/Is4OhEH08ySRiVOkafs2V80WJVTTNHfu4
         MnuTPAcyqvFDEkVeDmq/joaaulqMsGRB6uvSlJaNMy9Q8fNxvQlrGaV9uFKKcuGYYbJi
         wpmw==
X-Gm-Message-State: AFqh2kppOvfJllLnAk5BqJvrucYd1I03iUCWY5iDY3yBwBX38LgZVve5
        K4UCN+q5qDLzp7t1ziJlY/0=
X-Google-Smtp-Source: AMrXdXvtjMCHbEKdsAUmKaxlXp3Tsvme02JBcCymuXFPHvzlJDaW/HcLu3W2EYIjcknflJ+yFESyFg==
X-Received: by 2002:aa7:9a12:0:b0:587:25ea:4fcb with SMTP id w18-20020aa79a12000000b0058725ea4fcbmr4641059pfj.19.1674017085950;
        Tue, 17 Jan 2023 20:44:45 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id i1-20020a056a00004100b00581a156b920sm8682770pfk.132.2023.01.17.20.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 20:44:45 -0800 (PST)
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
Subject: [PATCH v2 2/9] ARM: dts: amlogic: Used onboard usb hub reset to enable usb hub
Date:   Wed, 18 Jan 2023 04:44:10 +0000
Message-Id: <20230118044418.875-3-linux.amoon@gmail.com>
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

On Odroid c1 previously use gpio-hog to reset the usb hub,
switch to used on board usb hub reset to enable the usb hub
and enable power to usb hub.

Add usb hub regulator as per the schematic.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2 - drop the vendor name from compatible string.
   - move the hub node to USB controller node.
   - drop the usb_otg_pwr since it only liked to OTG port
     and link p5v0 to the vdd-supply.
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 04356bc639fa..d1f9ce4742a8 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -281,19 +281,6 @@ &gpio_ao {
 			  "J7 Header Pin 6", "J7 Header Pin 5",
 			  "J7 Header Pin 7", "HDMI_CEC",
 			  "SYS_LED", "", "";
-
-	/*
-	 * WARNING: The USB Hub on the Odroid-C1/C1+ needs a reset signal
-	 * to be turned high in order to be detected by the USB Controller.
-	 * This signal should be handled by a USB specific power sequence
-	 * in order to reset the Hub when USB bus is powered down.
-	 */
-	usb-hub {
-		gpio-hog;
-		gpios = <GPIOAO_4 GPIO_ACTIVE_HIGH>;
-		output-high;
-		line-name = "usb-hub-reset";
-	};
 };
 
 &ir_receiver {
@@ -381,5 +368,16 @@ &usb1_phy {
 };
 
 &usb1 {
+	dr_mode = "host";
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
+
+	hub@1 {
+		/* Genesys Logic GL852G usb hub */
+		compatible = "usb5e3,610";
+		reg = <1>;
+		vdd-supply = <&p5v0>;
+		reset-gpio = <&gpio_ao GPIOAO_4 GPIO_ACTIVE_LOW>;
+	};
 };
-- 
2.38.1

