Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7AF63D79C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 15:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiK3OGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 09:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiK3OGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 09:06:18 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E34577223
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:06:16 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so1496441wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 06:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newflow-co-uk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eBK4M6em14NDAYl08ahmQwtvd1CwNFvnLrorbySUXHw=;
        b=Oh3OfFnWdBAvdmF7mYVNDPK+5Ub6/d/oZSk0EAQHF3XbUnw2DsEVrhisiP6VzHpbn+
         ZEKlVZlMDHGahIkmz/kgfoeWCSRbMTL1IbLE/1vp8KEtmqzIMnVFMLJZhkR3VqkAaV0W
         iCRyoi8vZD/1IdTKwpiZdIDlMxUSA76QwIDIsDdW9Yu68+pKYEYTEfgU2DOSxCbRc+yL
         9YYfbThJhDYM8el9DmvfgZh41sVNEIvsDW4ml61tljSfHK/0SNdA1/dh6/7iD0CdLsIr
         VZy2O9ZVjtcQZZ3r/r9Laluvm9CdZG7UETd0v7LGYO4RStbcttrNdouuJ018OxKjT9Bg
         88Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBK4M6em14NDAYl08ahmQwtvd1CwNFvnLrorbySUXHw=;
        b=SQ3KOqCO4woJmVqWGC3gqCK54a7OUl6rcZ86CZctQt4Ro+QPxRzVT351ZRBBN1YIXK
         LR4wvL3MCROOyMW2OBs9ySZfWG6to5OTbfr4A0zrwYvtamwjQbxgoJ7gLZP6yLmGUpYh
         Kya9T011jlBqZ96cLYGu6b28n0fq0JtsJw/22+wmuCev7pdVQgxTaixsU/cgm/+h2Y+r
         3ph7RgQgn6G0j5Ztx5KYs4e5Y+VMtLE2D5dGz3q31IwvwLwa+l7U6WL0HDbr9as0YdD7
         fFfui1sB4w/QmkWzsvDbmTt6Ksm8dyTfPYUXG4tGZ22NIKGQZi2tZmzQ5RjZVFEQOqVh
         w7xA==
X-Gm-Message-State: ANoB5pkLD6jPbNfukxv/PiDXpMMjzCLbouQWaWgGP/CHUEcoIA4AMpXY
        rL9HE6P+9kY2h8o5N/Tts6pFbSeZ6gDRWI1b
X-Google-Smtp-Source: AA0mqf7SpsdXJ3SmPlIzmGJAvhcfMZ1cBYNUejxnKxqCWEOlrLhIcnXylQkuL+fr7tGNkvjIm6N60A==
X-Received: by 2002:a05:600c:3d0c:b0:3cf:f66c:9246 with SMTP id bh12-20020a05600c3d0c00b003cff66c9246mr32407715wmb.27.1669817174956;
        Wed, 30 Nov 2022 06:06:14 -0800 (PST)
Received: from mpfj-unity.. ([94.12.112.226])
        by smtp.gmail.com with ESMTPSA id v128-20020a1cac86000000b003cfa80443a0sm2062542wme.35.2022.11.30.06.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 06:06:14 -0800 (PST)
From:   Mark Jackson <mpfj@newflow.co.uk>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Mark Jackson <mpfj@newflow.co.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND 1/5] ARM: dts: am335x-nano: Fix GPIO settings for RTS/CTS pins on UART3 & 4
Date:   Wed, 30 Nov 2022 14:05:43 +0000
Message-Id: <20221130140547.295859-2-mpfj@newflow.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221130140547.295859-1-mpfj@newflow.co.uk>
References: <20221130140547.295859-1-mpfj@newflow.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NanoBone platform uses GPIO pins for RTS/CTS control.
The DTS still uses the hardware RTS/CTS pins so this needs fixing.

Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
---
 arch/arm/boot/dts/am335x-nano.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index b6f2567bd65a..05cbfe24f778 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -120,8 +120,8 @@ AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_OUTPUT, MUX_MODE1)		/* spi0_d0.uart2_txd
 
 	uart3_pins: uart3_pins {
 		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_LCD_DATA10, PIN_INPUT_PULLUP, MUX_MODE6)	/* lcd_data10.uart3_ctsn */
-			AM33XX_PADCONF(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE6)		/* lcd_data11.uart3_rtsn */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA10, PIN_INPUT_PULLUP, MUX_MODE7)	/* lcd_data10.gpio2[16] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE7)		/* lcd_data11.gpio2[17] */
 			AM33XX_PADCONF(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE1)		/* spi0_cs1.uart3_rxd */
 			AM33XX_PADCONF(AM335X_PIN_ECAP0_IN_PWM0_OUT, PIN_OUTPUT, MUX_MODE1)		/* ecap0_in_pwm0_out.uart3_txd */
 		>;
@@ -129,8 +129,8 @@ AM33XX_PADCONF(AM335X_PIN_ECAP0_IN_PWM0_OUT, PIN_OUTPUT, MUX_MODE1)		/* ecap0_in
 
 	uart4_pins: uart4_pins {
 		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_LCD_DATA12, PIN_INPUT_PULLUP, MUX_MODE6)	/* lcd_data12.uart4_ctsn */
-			AM33XX_PADCONF(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE6)		/* lcd_data13.uart4_rtsn */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA12, PIN_INPUT_PULLUP, MUX_MODE7)	/* lcd_data12.gpio0[8] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE7)		/* lcd_data13.gpio0[9] */
 			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_INPUT, MUX_MODE1)		/* uart0_ctsn.uart4_rxd */
 			AM33XX_PADCONF(AM335X_PIN_UART0_RTSN, PIN_OUTPUT, MUX_MODE1)		/* uart0_rtsn.uart4_txd */
 		>;
-- 
2.34.1

