Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC73B6EF2B9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbjDZKuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240525AbjDZKts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:49:48 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368365253
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f1e2555b5aso27132745e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682506185; x=1685098185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRMYoVROwFE1MJOO/HSe+KnQh9ytWH/O+ref06Ejh6s=;
        b=noxV53LL1sTVmsRPLGvKYJ/jkt0aDQj25kZMBmkWqLZcLjV3iUzbBzSa2t9aytnfRj
         HGT8VkZUxjCT6DFTPGoUYFty70vTMLTVPivLmutpcYK8VVErrzGDSAO6aemqI1v93V/9
         +Xq5AU7M0IRCY1qENTfqtS4IzAsRWl4ozQ4Oz/SJXn+mXALyc9zEwOcrXBFF+oeq9gal
         oE33P/E4i8VBcBtJgyc/4Pn0VNMNpHQomwvCUUSXyIseW44WzmFzHenSDYwPLgmWlWFS
         8E0gIO65jk1KOApAa9TgT1ycdABhZW1vB1VRLLjLS2XxPO6AdLf8ersdA9jjQNYgRVVV
         uOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682506185; x=1685098185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRMYoVROwFE1MJOO/HSe+KnQh9ytWH/O+ref06Ejh6s=;
        b=hS/OYi2baFR5HpcA7gUGPLJWCEc6fBwyCG4/ULYr658aRGE/UXqrPmQhpJHIvGAm+V
         8zpKi+GxsCOafAZQi4c7UCQnWVabNqIAqiXIY0ALD34iWIRIT2fV7k6xsPQRQIyAk3JU
         SoPrVtIEm/EYK3YEqDkayzgE1BzNOKg55LBQd3k5V8Q8wz9E8QIWfGdf+r3Mh8VE9hA5
         6aKt6/vhtyMbAlovIJXim+HHi1Iiu9zgl7k2g+uUSOmTMhCMRtI3p5J1QmU6WXxachA8
         xOH68Ft9xp+SBhVykkh2HQY2yMQhxmreS8xwQIU5eS+3dH6G/oz3rSlXgFB4ZCUPjnvd
         0VSA==
X-Gm-Message-State: AAQBX9e/EeJJYD4pM/ZOnQd5QFg2hHEGlKh8PmSYVo7XTEks+nhIhmNI
        YIpgYsyG4HItCh4IYuXjo9nfcudAM2ngvBCKseQ=
X-Google-Smtp-Source: AKy350amTGjWve9HimTCpqgKJdop6gEGzttQT/PYEMwRM+uQoAeO13PL3BxsXPJowcJVo9yOJR694g==
X-Received: by 2002:a7b:cbd9:0:b0:3f1:952c:3c70 with SMTP id n25-20020a7bcbd9000000b003f1952c3c70mr10898438wmi.40.1682506185718;
        Wed, 26 Apr 2023 03:49:45 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 25-20020a05600c025900b003ed2c0a0f37sm17601988wmj.35.2023.04.26.03.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 03:49:45 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 26 Apr 2023 12:49:08 +0200
Subject: [PATCH v6 08/12] arm64: dts: mediatek: add usb controller support
 for mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v6-8-8d6b1cfe7f29@baylibre.com>
References: <20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=EI+ro2edTOCiZWpy9DB8h18gK0kLHGZDj7cwd9DAutA=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkSQG/3oY1c/N0cq7rTjsSOZ+XwNF1OtLwxd6d/joR
 53AddaKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZEkBvwAKCRArRkmdfjHURTF9EA
 DHW3qBSMNWMCVVBF5sejDSKAq+dam8iOE9EDDeOaXUiYDMetQCD4oJSmKdmR1XqhtF8boL5Bovb+G1
 268Lb9gwBdoiVUI3e5M/zoM+aXRYy3JX0iwPrKsJCy+NwchHAlmLCFU7RMrLHyWENGOe9tQHoufEr9
 kB5c8ecvGo9oGIOQ98ZZigN5CTN7ZfqBrkFa4Wozzx2/QbiQBe9myaJ+oWrdWZQXAOWPFG0KaVEjdk
 /BR7wuS2nERFKR42yJW3VK+WgUbInGHjPccOB7m3zMF+JiQ6GPWdYwbUOc94NeU/EBcWUvQWpflgsB
 o5PhH/6jnAIzI7dXYwCt3IXDgMzr0GlTi77+L7cxACmHnq9daIwjZjU091iI3KrZGwUBVX2bzF76KG
 xtEeFSE5NR/wYPoklkaOOhE14+2904nk1BdEskp2ibuKjPx6lMEJzr1mdQnsC7GdJ0DWmgsGs0Lnvz
 Yl9LJMr2VzKBgeAktsv7WT1YFWfujpmYicPSFnxFMlyoj1xtlGHrtZsVxml6b7nl/EyrOnFWclrs8s
 vjvoCk6kaU9FWkliInOaMAWk3Y2wPshA2voqPOgi09xJrQKIIgW0vwGDcZdDsl6WISILH5WNMioqYt
 5Gt04wSNINgkqLI95WDphim0nvQrUFvMAWETUe0neeSQr/Vj9+TYQrbh/yog==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for SuperSpeed USB, in OTG mode, on micro connector.
It also add support for the Extensible Host Controller Interface USB.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index ceed6cb8152b..913e09545030 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -314,6 +314,28 @@ &pwm {
 	status = "okay";
 };
 
+&ssusb {
+	dr_mode = "otg";
+	maximum-speed = "high-speed";
+	pinctrl-0 = <&usb_pins>;
+	pinctrl-names = "default";
+	usb-role-switch;
+	vusb33-supply = <&mt6357_vusb33_reg>;
+	status = "okay";
+
+	connector {
+		compatible = "gpio-usb-b-connector", "usb-b-connector";
+		id-gpios = <&pio 17 GPIO_ACTIVE_HIGH>;
+		type = "micro";
+		vbus-supply = <&usb_otg_vbus>;
+	};
+};
+
+&usb_host {
+	vusb33-supply = <&mt6357_vusb33_reg>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_pins>;
 	pinctrl-names = "default";

-- 
2.25.1

