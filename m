Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF775F56F8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJEO6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiJEO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:58:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B167D1FB;
        Wed,  5 Oct 2022 07:58:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id z23so19291360ejw.12;
        Wed, 05 Oct 2022 07:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QxTd2irbE3fT1lcVlkhKiLQzr/UYrot8baYcYKlC0xc=;
        b=SmMrgmFXsJM2cd5WiBDwjLrzDEm4ZQpclFl5fQJqvWfhdjtLagDqU4Iq0k4ymXKw4W
         UA8Ntnz52Q+u1QUVHvf9lLHsKg1zZmKD9VWhchClrjHbVDjisX96M5X6ON/hO/UvPBV9
         H8bd1MApY9HHNFklIcM/I+XGG/mx261pYzVw9+BIriNShF3Tyto2IRpikKn3JzPV5Oxc
         TSYQr4hW1KIpxGsG1S7aqa56qRr5eJk11cVC6Hg7EjgaDt9qnl6pBV333fpuX3B2D7jt
         q3CP/zSih1C/64EZwAJ7Nb8dmWxbHAKDRtcmB6HnqkZ/WHqrro6AtoqakCjNTuJkQVqr
         +dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QxTd2irbE3fT1lcVlkhKiLQzr/UYrot8baYcYKlC0xc=;
        b=qURHhKNOxPwdUUsr1wIS5CzV2hebGt09Vl1GU4PSMC0rv7pTsp1E+jkOmACXMpEmdV
         1c5Bshj7ufkeWUiXu6KBbvAoi1+OnrjWRkxonUcmZyetlUDxYShAzcl/pT6bfu9y9fYB
         8rjW7u4mI1FDFM748P2IUFrGOGPSBgpZCIm4G8OoWmkHYBgRO9DNp8dDEmzG45C/iG8b
         9dHa/1VA13zyzWN0xpiNeEi/vy1IPVRVL8UhetGu47gkVJIEDTZI37ZhGtbOr4sW1Rju
         yxfbiLLoJl0arzDtOn+I87IvKRBj6TwQG1ILesTvuCBBvqcoarV8mt/rA9rGSezZzVtM
         EklQ==
X-Gm-Message-State: ACrzQf2uAcvkDi4NOxy2HcDMZn9591zxyY3iXZh90k7yS1SY2olNvjQr
        YEsYTDOTKDKgd/Elfzbaqmo=
X-Google-Smtp-Source: AMsMyM7R7aXCBc2h7atYt9hgjEDpMN/slyKxkpdhU9K6YUVfX8YP2xBy+dG0upo2i4CB2pdB5NJZuQ==
X-Received: by 2002:a17:906:eec9:b0:783:e662:2513 with SMTP id wu9-20020a170906eec900b00783e6622513mr13897ejb.656.1664981885264;
        Wed, 05 Oct 2022 07:58:05 -0700 (PDT)
Received: from fedora.local.tbs-biometrics.cz (176-74-132-138.netdatacomm.cz. [176.74.132.138])
        by smtp.gmail.com with ESMTPSA id m5-20020a50cc05000000b004588ef795easm4023941edi.34.2022.10.05.07.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:58:04 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        gregkh@linuxfoundation.org, jeffrey.l.hugo@gmail.com,
        andersson@kernel.org, Michael.Srba@seznam.cz, saravanak@google.com,
        mani@kernel.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Za=C5=A5ovi=C4=8D?= <m.zatovic1@gmail.com>
Subject: [RFCv2 PATCH 3/4] dt-bindings: gpio: add Wiegand GPIO driver dt documentation
Date:   Wed,  5 Oct 2022 16:57:45 +0200
Message-Id: <20221005145746.172138-3-m.zatovic1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005145746.172138-1-m.zatovic1@gmail.com>
References: <20221005145746.172138-1-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Wiegand GPIO driver uses two GPIO lines to transmit data -
data-hi and data-lo. These lines need to be defined in the
devicetree, otherwise the driver will not probe successfully.

Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
---
 .../bindings/gpio/gpio-wiegand.yaml           | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-wiegand.yaml

diff --git a/Documentation/devicetree/bindings/gpio/gpio-wiegand.yaml b/Documentation/devicetree/bindings/gpio/gpio-wiegand.yaml
new file mode 100644
index 000000000000..3b235667ae17
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-wiegand.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/gpio-wiegand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wiegand GPIO controller
+
+description: |
+  Wiegand GPIO controller running under Wiegand bus.
+
+maintainers:
+  - Martin Zaťovič <m.zatovic1@gmail.com>
+
+properties:
+  $nodename:
+    pattern: "^wiegand-gpio@[0-9a-f]+$"
+
+  compatible:
+    const: wiegand,wiegand-gpio
+
+  data-hi-gpios:
+    description: GPIO spec for data-hi line to use
+    maxItems: 1
+
+  data-lo-gpios:
+    description: GPIO spec for data-lo line to use
+    maxItems: 1
+
+required:
+  - compatible
+  - data-hi-gpios
+  - data-lo-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    wiegand {
+        compatible = "wiegand";
+
+        wiegand-gpio {
+            compatible = "wiegand,wiegand-gpio";
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_uart2_wiegand>;
+            data-hi-gpios = <&gpio2 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+            data-lo-gpios = <&gpio2 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+        };
+    };
+
+...
-- 
2.37.3

