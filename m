Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1945B9824
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiIOJwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiIOJv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:51:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A91E9AF8D;
        Thu, 15 Sep 2022 02:49:21 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fv3so17264528pjb.0;
        Thu, 15 Sep 2022 02:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YJZ/oJ0LmKZrFDGAJdP7uLjsccIJ2kxypc2pDmCPi/o=;
        b=lV4OkWpt12wnKoW6s9O6R47dmV7GKJ+iG+pGU7p74u5q2X3CI8u2yC5cfNBZDr5xVk
         NhI0HVs8Rt1TNXdPbeMySKU/ke7pEumaRcZxVnglYXFtoip8JAzZ4yf8LfM2QcTcLAHN
         ntCsrvh6V5OfR20wilfrZ+U+1oq2EyL+QlKMvIwQqkKUdhUJPPGvSnS6kVNbVYvjqSf8
         3Dtwej4d347LB/nG58FmnvKfH61oTjTra2szZp4C+w2lzslZ6gwheua6khZrzyJcfoqS
         0PUxaO1VnEinq6vfAxm+v6EQI5NKdZ5a9TXfT5w3O9yyvdx+lYUuRnwCVDNXeSsmS1n5
         R+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YJZ/oJ0LmKZrFDGAJdP7uLjsccIJ2kxypc2pDmCPi/o=;
        b=iyN0RgSHtQkvxUSfs43kUZ7+WdbCtM97VdnCn0pzlIqcdxOE/WILNFwpYw+cWE9SrW
         hnwR1+F7mRAjiU4e5tTMBwowiSIjxd4HzKUTvcO/c/6VY033T20gI+FG3ApUIkr3y0Vq
         BOEJT8dWJxaDAuzaIQFd/6HI9WBNP4GYsqQt3aUV0P6qHoyh1jQAfutrf4MNuDzjXiRy
         TWSM/fBlu3hNKxVIaVkgOTQM7SL/S/P+uc0zrYwT9HgX9mKgHCyvaQUOabnfph0mW0bU
         0NmImwQtIZfL1erdmHVsc+2oMQ/WQnx1FWWWPTAwnaDWV5y/7bGx2aAUtk8AerqxAI4j
         AT6g==
X-Gm-Message-State: ACrzQf0TR3yInOPDgslAAGl7+BIN1DFOZRcnioRAZFTBCQ5DC86gHFIW
        GFDg1JO7dLNZA2VDTrgTV9Y=
X-Google-Smtp-Source: AMsMyM7Km2Yy5YowQOjMN6xN5IT17fSs/eADlQaLVHxDP0xjYVs6KZ6Q/fgN4nx4cDUhd2TCHtu8Ng==
X-Received: by 2002:a17:90b:4f89:b0:202:8e4a:addd with SMTP id qe9-20020a17090b4f8900b002028e4aadddmr9622786pjb.131.1663235336027;
        Thu, 15 Sep 2022 02:48:56 -0700 (PDT)
Received: from RD-3580-24288.rt.l (114-137-177-189.emome-ip.hinet.net. [114.137.177.189])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903110400b00176675adbe1sm12669010plh.208.2022.09.15.02.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 02:48:55 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, jic23@kernel.org, lars@metafoo.de,
        broonie@kernel.org, mazziesaccount@gmail.com,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v11 1/8] dt-bindings: power: supply: Add MediaTek MT6370 Charger
Date:   Thu, 15 Sep 2022 17:47:29 +0800
Message-Id: <9382254831bb6ed8c228398a68896b0e8e61c7c4.1663254344.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663254344.git.chiaen_wu@richtek.com>
References: <cover.1663254344.git.chiaen_wu@richtek.com>
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

From: ChiaEn Wu <chiaen_wu@richtek.com>

Add MediaTek MT6370 Charger binding documentation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
v11
- Add more detailed description of irqs.
- Adujust the order of irqs
---
 .../power/supply/mediatek,mt6370-charger.yaml      | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
new file mode 100644
index 0000000..fd491c5
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/mediatek,mt6370-charger.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/mediatek,mt6370-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6370 Battery Charger
+
+maintainers:
+  - ChiaEn Wu <chiaen_wu@richtek.com>
+
+description: |
+  This module is part of the MT6370 MFD device.
+  Provides Battery Charger, Boost for OTG devices and BC1.2 detection.
+
+properties:
+  compatible:
+    const: mediatek,mt6370-charger
+
+  interrupts:
+    description: |
+      Specify what irqs are needed to be handled by MT6370 Charger driver.
+      We need to use the IRQ "MT6370_IRQ_OVPCTRL_UVP_D" to know when USB
+      is plugged in, and then the driver will enable BC1.2 detection.
+      After the hardware of MT6370 completes the BC1.2 detection,
+      IRQ "MT6370_IRQ_ATTACH" will be triggered, and the driver will know
+      the result of BC1.2 detection.
+      When the IRQ "MT6370_IRQ_CHG_MIVR" is triggered, it means that the
+      hardware enters the "Minimum Input Voltage Regulation loop" and
+      a workaround needs to be applied at this time.
+      In summary, "MT6370_IRQ_OVPCTRL_UVP_D", "MT6370_IRQ_ATTACH" and
+      "MT6370_IRQ_CHG_MIVR" are required in this charger driver.
+    items:
+      - description: irq of "USB is plugged in"
+      - description: irq of "BC1.2 is done"
+      - description: irq of "Minimum Input Voltage Regulation loop is active"
+
+  interrupt-names:
+    items:
+      - const: uvp_d_evt
+      - const: attach_i
+      - const: mivr
+
+  io-channels:
+    description: |
+      Use ADC channel to read VBUS, IBUS, IBAT, etc., info.
+    minItems: 1
+    items:
+      - description: |
+          VBUS voltage with lower accuracy (+-75mV) but higher measure
+          range (1~22V)
+      - description: |
+          VBUS voltage with higher accuracy (+-30mV) but lower measure
+          range (1~9.76V)
+      - description: the main system input voltage
+      - description: battery voltage
+      - description: battery temperature-sense input voltage
+      - description: IBUS current (required)
+      - description: battery current
+      - description: |
+          regulated output voltage to supply for the PWM low-side gate driver
+          and the bootstrap capacitor
+      - description: IC junction temperature
+
+  io-channel-names:
+    minItems: 1
+    items:
+      - const: vbusdiv5
+      - const: vbusdiv2
+      - const: vsys
+      - const: vbat
+      - const: ts_bat
+      - const: ibus
+      - const: ibat
+      - const: chg_vddp
+      - const: temp_jc
+
+  usb-otg-vbus-regulator:
+    type: object
+    description: OTG boost regulator.
+    unevaluatedProperties: false
+    $ref: /schemas/regulator/regulator.yaml#
+
+    properties:
+      enable-gpios:
+        maxItems: 1
+
+required:
+  - compatible
+  - interrupts
+  - interrupt-names
+  - io-channels
+
+additionalProperties: false
+
+...
-- 
2.7.4

