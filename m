Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371506D2747
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 19:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjCaR4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 13:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjCaRzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 13:55:44 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F186923688
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:55:41 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j36-20020a05600c1c2400b003f04057c152so2274574wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 10:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680285341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OS7Sye0IPLu21f+Xi1LC07CtmBlPzToUPrfZNf6CO3E=;
        b=RQS6mklPjc41zmLNoc02XX7Dz9LbkMG9yT78dsLFfOtL7uqkztA3rqDZUREp9uBm/7
         pdaF7hHgV8mCVb0wVsMGwqr99RaWXwvW46TGolwu1SIM+4VkEriSwEV71UGZVqZOF8Sm
         +gve9Ioa0Dr/CSY2jKg73uPt7TRJvIQZbvGBza5skN2eDXl4koH+H+qqQ+tp5Qs9UIMx
         YdziJWOCmYI/V64/zDXl7QgTvN7/rIhjQrtIJXdUHZ4mmV4/GCpHHY0hkY2Qr0Un1T7r
         aV99ZWfzUxuaD+NlWMQ/N1UyL/Zrl9EzSydNl3QjEF3DoSK6yddEM5wqlOLotCECTZtM
         iW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680285341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OS7Sye0IPLu21f+Xi1LC07CtmBlPzToUPrfZNf6CO3E=;
        b=qr1V3TDzxJcUlGx7m4DrvqdbQPm9U1UpOKt/Rg0hbp36ywRkhgDmnkCn7hhquL4RwC
         MW94UtT9etkX8Cr+qobmaEuYQ1o2akdpTzq9zlMHQye7F/+sDoLR02HRJ7IkudMcMGFO
         2M0zaPm/9gpesRrKvbgtb9EWcYk9lGk1oL1GjiJEFhND0JHLVRYb+gFcRelyjznbN4LJ
         l7tm9olWyN3h8CevWkXEPZDTcYAczmg4Ghzv6X951OZqlLXjjX7J1DrSx3hepuQ+EVeP
         QNN+kVFCa0PD2wgbSpIYXJRJGVmhRbusj6lDwyiwvvEa9GovSBJWOJLaWv/4CMgu1Qtr
         ZXsw==
X-Gm-Message-State: AO0yUKU9ueoSmxLtq5lUZtOO3JrmwOt7G/VcgNhROLnE8hdYbToiGyi4
        afv0irNM+ZEmII0k08bEULXnXQ==
X-Google-Smtp-Source: AK7set8hjFirjY6iTMj41oguBQNujELW8tTVlEcwo7ZK1EixQ3Xak/ZSi+ZStfjdJNiOK00oPWbaQw==
X-Received: by 2002:a1c:4c0d:0:b0:3ef:4138:9eef with SMTP id z13-20020a1c4c0d000000b003ef41389eefmr23062906wmf.36.1680285341527;
        Fri, 31 Mar 2023 10:55:41 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 1-20020a05600c22c100b003eeb1d6a470sm3370171wmg.13.2023.03.31.10.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 10:55:41 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 31 Mar 2023 19:54:51 +0200
Subject: [PATCH v4 07/11] arm64: dts: mediatek: add usb controller support
 for mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v4-7-5cffe66a38c0@baylibre.com>
References: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1190; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=fWeFY0N26AVZAJlISCaJeet0l8YjLAinj4NBVfmxvvQ=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkJx6UmmMNd0+mhAls7cBjVg5nJ5pOWyNoAZkADzFZ
 N1h0kcuJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCcelAAKCRArRkmdfjHURTHREA
 C0XpwI/Rzp2tNDdrAql0LQKhMWIqYKn+CaqvSl12DfP/GWVzaENjzwRAYiTdeLgEwMtxXNjkkb6qlO
 mf6XVsHJwjUHvjBycf/UDWKacCf9yEk4ZJ/psvASqqeqR9JTwXw+yprDzAlikqqSZLMsnYlDdPoKzH
 4UJMhnt8LUmEiFzqkOytdBcsU83bJgEm7jkDswJQe4CuNCC7ivvfq/1Krc8dvUawvHcBM3rXpS+G+n
 227RXCPWLJVczH7i9okj+Bm58Y0Ip/pUP1DHwzdw8wFk913b1STPsxd+b93f1neq4Lf1W8YLYQAI1x
 B2wEURlvVDDiWrvLjacbSKGK9PAtbXJit/2l8VCc1uD6omcSu1EyTW2O/b1hlWQrBTT28GIayeNJRi
 aSPpSW3HH69+G8jIbMGEQD+O1Uj/KDRenrNglnWrKf4OuK1g6D8R6DyDcMMy0FrjYb3yQCQTimQ+u6
 AjPcZXAY3qACUvs6BUKRtCZtnuHanb6PBnS33KXSjaLaW3ol388mN6Poh5KsvawhtZnRsAoNFcLUeR
 BlRrQU9PqEZPoLRdBc9HgCvHBv8GuYGtEyNIVbeEwDi575uC7+lajpmkLTk0nLPoiBIO9frPgaJ5+K
 HFLb0a5P5G5GWXmg4fxMyAk+x/nsgVrI9UWrk+TTLUhOuDcW0W8s1xF+mGYA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add support for SuperSpeed USB, in OTG mode, on micro connector.
It also add support for the Extensible Host Controller Interface USB.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index 1c36d8f19525..9760f181eb34 100644
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

