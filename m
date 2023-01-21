Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D28E6767D3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjAUR5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjAUR5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:57:09 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7685828856;
        Sat, 21 Jan 2023 09:57:08 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id z4-20020a17090a170400b00226d331390cso7747660pjd.5;
        Sat, 21 Jan 2023 09:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCzHXrbRvsqfgdDEn1XzlqbZnHOfL3rY2EE1BLX+c/4=;
        b=b6jR9mtPvxcQEgR8UCV6DSGF/rrpXKm+GuXYeJg2HRnf29dsOYV/PqSZ+Us754CymL
         ncst+0JJTnZSxsjQtsp7WB5bdKkWBSANRN3ndNF59Y4HY5GLHdh3oJCd4vdNIr+darHO
         QY+42q2vpWPhuodog7an1v0fnXorCWTZIK1g7M/A4eGEw9SMf82BYjnoApvqTHO78Iec
         nyAFeeC/PovmVgEaiISMwFjXKPS4Y0tq8aglEpBJCUvWcQp5aHYMhWppgNZOcPXTXG7A
         bXeXdvryMuk8B9TVulgCFwMREwP89NBYJ/+NLaMhuqonL8/8WlLVLuitid1EDUhVSslX
         ZKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCzHXrbRvsqfgdDEn1XzlqbZnHOfL3rY2EE1BLX+c/4=;
        b=qfN/q/o7RTSX6asNzVHpf0gnXTe4kTcjlsnemoG1+hthx6zCnalQy6TNW1fdEN/xsQ
         S+dtFjMRp1x2zVyrquku2KBbRtm9SaBKjkHewsYTnQUZSYnEoydU8XzUbswadCWuHcY4
         f/26mfvi64ZVSPowK7A0eIzCt3YzjPfv02j+M9KvZoUiK8ZcM9I3V7ilEPMJDK9YiNjs
         nvVYhfhB7ez5Hobu3KGRxA5icXBp7tJmKKIS69QxEwryqpEm31RAweyPvXObpJ/a+ZKF
         FAn+JJ4x3y8sVJ26rziJ/eksVeRjiPtCR5XHpzD6s0HvPpnl2iNJufCP8c8KW9FDCDGD
         MypA==
X-Gm-Message-State: AFqh2kqgtWefaUNoHdW6nU+2GnCzm7wa0j34BmFuPRoQoY3QsgypCsmV
        VUh7+Em8Nq9JM9TqBTA8zTI=
X-Google-Smtp-Source: AMrXdXsNPj1hcK0B4AslGTcdR5QLntv/D2BXxjsaGDR1forilW70eC0xvgukY8NwZRqWGPEkm6dNWw==
X-Received: by 2002:a17:903:230f:b0:195:f06f:84fc with SMTP id d15-20020a170903230f00b00195f06f84fcmr6012669plh.40.1674323827571;
        Sat, 21 Jan 2023 09:57:07 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id r3-20020a632b03000000b00478e14e6e76sm24857374pgr.32.2023.01.21.09.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 09:57:07 -0800 (PST)
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
Subject: [PATCH v3 2/9] ARM: dts: amlogic: Used onboard usb hub reset on odroid c1
Date:   Sat, 21 Jan 2023 17:56:30 +0000
Message-Id: <20230121175639.12818-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230121175639.12818-1-linux.amoon@gmail.com>
References: <20230121175639.12818-1-linux.amoon@gmail.com>
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v3 - Add Rev by Neil.
     update the subject with odroid C1
     dropped dr_mode
v2 - drop the vendor name from compatible string.
   - move the hub node to USB controller node.
   - drop the usb_otg_pwr since it only liked to OTG port
     and link p5v0 to the vdd-supply.
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 04356bc639fa..04c4bdca0b85 100644
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
@@ -381,5 +368,15 @@ &usb1_phy {
 };
 
 &usb1 {
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

