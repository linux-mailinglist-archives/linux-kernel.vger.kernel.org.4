Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B736EF2B3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240586AbjDZKuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbjDZKtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:49:45 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B840A49D5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f1e2555b5aso27132185e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682506182; x=1685098182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i+MV2YRPMb42Ec6VMXrDn54MdXbA5Kj57aOu4iXdrhk=;
        b=25Nzod8AU4qYFSkCvMZLHKZUCAimmEJz1CJiYrbOFIimjx4RXU37ipuhmlhIaxKglJ
         7bK2TLm1s2YX/43jwLbQBmpIl/BsIat2N8WoUFTHwH5idsYYBiIbu+FgtsMfqUGkVpyg
         haJUs8+BWafhWxm8j1nIQgAKJuF+jsu+QKF1ZSaSBPY3ebzjSgDRETMmy5nf4XeHpia9
         TFwdcR6p+tzmmIKMSsWTCN0hkgoe3cJ0Eda0Lkv9CQs+N0UlpKnA6VqaGP+A/1MNVQ8N
         xbBf/ADgvVd3OufWPGEvFUjLNU9pFLmdc++aFElnBpw5aL9gcEaQ+E40HkNdn/EOcRWr
         YHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682506182; x=1685098182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+MV2YRPMb42Ec6VMXrDn54MdXbA5Kj57aOu4iXdrhk=;
        b=WwopWqUBTt3f6Tv63xQUPck9dJjccxOqtLvrXFqqVm3JpOOGFOwtaprrJhUtMr5a3l
         jT1b7rnM1KzIpdAWpB2leRhYeXfpaodE9borA3tKUlCv6FEHpFDhjVq0b97jKfidEmrz
         EpbErBbpiUoBxE6OIINr0z6HTULhF89T/7FC1TQDCqWz3miqmjJ45H4QVi9tSLuU/E6+
         pYbiwV7ZEzjCCqJMov25oJ5sb2mYHZmkCvjNOfEGFf+13Eo6hcrGyt9sVQAsT2NzOk0b
         f6pQUitlc+bcK3MXatglp/bcF1nbdmy3oKgVMKtATfw8jBiVTOk2V2MSYyVV7RIObg6e
         kWlA==
X-Gm-Message-State: AAQBX9cwRw1hB1aJJtJVn/gH+ZTZq77FT767LDTuioCvOMMOrN37sGQp
        DCtMjQLwhefW1rFSjwiDt/5hhg==
X-Google-Smtp-Source: AKy350ZsqXIA6dY/zcCkAn4eA6AnADYf5wsjoH0O5TQug54dyT+/wRZ5gGNhDP0aLZELRLUO1JQKgw==
X-Received: by 2002:a7b:cbd9:0:b0:3f1:952c:3c70 with SMTP id n25-20020a7bcbd9000000b003f1952c3c70mr10898307wmi.40.1682506182141;
        Wed, 26 Apr 2023 03:49:42 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 25-20020a05600c025900b003ed2c0a0f37sm17601988wmj.35.2023.04.26.03.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 03:49:41 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 26 Apr 2023 12:49:05 +0200
Subject: [PATCH v6 05/12] arm64: dts: mediatek: add mt6357 PMIC support for
 mt8365-evk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v6-5-8d6b1cfe7f29@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1093; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=k4aaIXAKDcyErU7IaTZAPbHBHYNzTOzKpV3NgRmyt84=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkSQG/XO3wImOfkSs/V7BzeswXYzrfzBA/gpK6oOyH
 N9RR9ayJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZEkBvwAKCRArRkmdfjHURUHtD/
 9bwGPmZ80v1QqrJc78yl8L1dYH3ttxEwwnHAsb5LbV7rubQNUr6T5URp30LcHI1FKYjzSEIhTxLYv2
 Ol74OmRcBVIJrVk6ZVRDdG6+GE9D2Bt5aJX+qayY6DpttRJsnVreWYNPI1tqK7H9hF/o0MV6odU3H9
 6QVqfna9Jaz0AgG7U6N6oE6k4wkeYa8CrV4Om62qtRTMfOBeQ2zekOyOYGzKlwl1AE7pAjElCfvss3
 q3eQkiFUE0f33MPElo7Xd2nlhG69jaV0NdzbzaxBbMYDon2NTHffowrf7K9I/y31AdcUNLN8mP5CMP
 vY8yn3DOUj916wsOtpsf6YmZ4p0LIEWglGs67BjtE9Vcw5RS9QhHp2THZf3vLNFmz/q71cQRagdhRJ
 34jkUiMXJDb6lOv4eqWC/GdUy0Rv8tW9tZ7hrpwJ1wgZ/jkkCwao1xKFmnr75Xljwq9KmGfFmxYLwt
 MjrOPdkOIP/NRV13KaKPoblT2a9lYzuPWMcbN/oud6kt1UOyY2iUzwieIE4VDBwLd5e27Y151Ny9sS
 fI+UNvqnjLoqS6n601z6jGV0t78HYroxQY4guYb43oGutBus4dJuqqS5gFH8oA0/0esKOXJA1Z5RKv
 cYysCLdbVeZNcRD18CbLZ0WabaZUOdZ3UP18QulllW+TSJ5JTi2suwpDFmJQ==
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

This power management system chip integration helps to manage regulators
and keys.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
index dd7da86420cf..a238bd0092d2 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
@@ -12,6 +12,7 @@
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/pinctrl/mt8365-pinfunc.h>
 #include "mt8365.dtsi"
+#include "mt6357.dtsi"
 
 / {
 	model = "MediaTek MT8365 Open Platform EVK";
@@ -94,6 +95,12 @@ &i2c0 {
 	status = "okay";
 };
 
+&mt6357_pmic {
+	interrupts-extended = <&pio 145 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+};
+
 &pio {
 	gpio_keys: gpio-keys-pins {
 		pins {

-- 
2.25.1

