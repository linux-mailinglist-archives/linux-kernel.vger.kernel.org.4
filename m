Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C4867E0F7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 11:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbjA0KCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 05:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjA0KCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 05:02:46 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0365327995;
        Fri, 27 Jan 2023 02:02:45 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h16so4437292wrz.12;
        Fri, 27 Jan 2023 02:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y9M27q2IpS/Qgdn1yNsrG13oA6vUzw3FyxyzlhUf80=;
        b=Q7trYkSTlAZXOsRcsKdlmUhZ4OcdIPxi3dKRXSGOGiTkY4l4C/m54LLcxVbmvswsQC
         t7JUNwdTVFnGo+yKKFKArZL3sCJUWS1AzWZQlyn+wvR0180ZW/YNF2/jC5MF2B8F09II
         +sLeAIVSoaKP4fYdurhARzf2YP2CCPawhLdsW01oBH8z1JAe8rMX/t6HOnsrppjCWfPk
         xvf6MuT3PMnGj1LR0DqKidpFKF3mh07In2fSSfbjsLx3WvRsXzRxrvRcPlQtRQcqoPK1
         EB5NJrwBZJSvOx1XRx/PhmU1Ty1bz1WM8AUmQCwZzWSW3weGht6rO/BbAksWPTS+3GJr
         7+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Y9M27q2IpS/Qgdn1yNsrG13oA6vUzw3FyxyzlhUf80=;
        b=i083SKyS2jDUimKvxyTt/b1D3NH9L4Zn8k1z15wc8tR8WPi3jWxTUs3g7vFyxiCt65
         9q0dWO3wxHW2R5EEV5NgjW+WuDRcdk87b53k+rkA2ZYEV/xTvcfeYZNEocpOSPr43Jdi
         db/cU3OiW/1WBJRx+Gx6Q5/T1ZE6XXnCYp2dL/+ZPCuNUJbEYPnBOq8HQzF0PNGHPTiQ
         7ROKYHu0LuUUr8zUjanwDPSzUFWSUnhjPaIMWqiU4HCZtS8CmQ0FvldImEPOCr6OciWU
         R+swLkF5a26qnfQMwlyXCrjdolMLw2Dfo8grKucvbGuKREhyooDMGf77p6FYOG+b9S19
         hzfQ==
X-Gm-Message-State: AO0yUKX1ZMR10AFguHU6RlVxh64aPnB2Zq+1LCfw6ZwEbBeq31wTRZQb
        PYxt5WEPS/2ZlJ/IYvlPf9g=
X-Google-Smtp-Source: AK7set/bea8R4a7pU7mw3gImSMnY5LW+aEE3W1TZxCFJ4/PKThhDxuyEH5F0EavmFGz6uhoskwGlow==
X-Received: by 2002:a5d:4e82:0:b0:2bf:d333:219d with SMTP id e2-20020a5d4e82000000b002bfd333219dmr1510512wru.17.1674813763430;
        Fri, 27 Jan 2023 02:02:43 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id l7-20020adffe87000000b002bfbe30e8f8sm3493858wrr.98.2023.01.27.02.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 02:02:42 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/4] arm64: dts: meson: bananapi-m5: switch VDDIO_C pin to OPEN_DRAIN
Date:   Fri, 27 Jan 2023 10:02:33 +0000
Message-Id: <20230127100236.3385154-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127100236.3385154-1-christianshewitt@gmail.com>
References: <20230127100236.3385154-1-christianshewitt@gmail.com>
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

For proper warm (re)boot from SD card the BPI-M5 board requires TFLASH_VDD_EN
and VDDIO_C pins to be switched to high impedance mode. This can be achieved
using OPEN_DRAIN instead of ACTIVE_HIGH to leave the GPIO pins in input mode
and retain high state (pin has the pull-up).

This change is inspired by meson-sm1-odroid.dtsi where OPEN_DRAIN has been
used to resolve similar problems with the Odroid C4 board (TF_IO in the C4
dts is the equivalent regulator).

Fixes 976e920183e4 ("arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts")
Suggested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
index 028220ed45ad..3c1267a7ffef 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
@@ -123,7 +123,7 @@ vddio_c: regulator-vddio_c {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
 
-		enable-gpio = <&gpio_ao GPIOE_2 GPIO_ACTIVE_HIGH>;
+		enable-gpio = <&gpio_ao GPIOE_2 GPIO_OPEN_DRAIN>;
 		enable-active-high;
 		regulator-always-on;
 
-- 
2.34.1

