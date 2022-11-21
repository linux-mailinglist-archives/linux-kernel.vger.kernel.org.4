Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98AC632B53
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiKURpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiKURpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:45:07 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1DB41984;
        Mon, 21 Nov 2022 09:45:05 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id vv4so20981090ejc.2;
        Mon, 21 Nov 2022 09:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vc7s+j1I+v53zIS5PmltGaeTsanNeN5sDlFmwluvB4c=;
        b=ZW7YE20LBYtuKZLnhkZfVvIw0tdu4LjJ5muSHbTVqkWxOEaxDM8Po2OsAitkQgNX4N
         DCQRE1JY+E0OJ37N4H9hVjdHD4ey3PtMr/N9mT0uvoeDPkHFvMLu7XoAjx39++8TIXGe
         LK9WRn/LtxTMMLGBkR3t/ncaXH2UKpHENGAq6UDo6tZvxwbMLdBeA0hrnJKtHK7UkSWU
         icXlOnv+MYkFR33qMD0ZdcITLgMeWLPvkmKyatSwhzYY59G0hkl3kAVr/V7l07tAr8Iw
         qiN1gLFQIU13b/NL+NTJu4EM+IkkbKff7UkcxX/7o5AA/P75Pm+F1Y8bD9s1WDXD65SZ
         IEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vc7s+j1I+v53zIS5PmltGaeTsanNeN5sDlFmwluvB4c=;
        b=BnqXbpZlwsBDSoDLfV/zlPlYKf/GEKd85rztUgdKlW4kER+Hi+iC/QGSiGoW+6PqWa
         HdeYhkX4gIIrL8jvWu7KAwSN5EuuFyJDMrCkrb4TPajE0+kCpRObgmVCQtsqhlNTkz1b
         /lZhLBx+O4vxfrEN0ZAq8zEWk/x6LB2ue7n289ZkSH66g8zNwcbUyOHosF7rbxDTJp7q
         XyaUHGkG6sOuv4SJjsOU8FDEwY2LxYLmYtZQ4hky0fSYXu2LoFA+qWIHTLXcUFzd6Crb
         StRBFK4rtIOuI1Odr1oa65mQxiWQRWTqQhzxgyGkZaj/tEBWqPKBgEvmp8DA9AKYbvtC
         i/jg==
X-Gm-Message-State: ANoB5plAQ3bS0mb9wEJFvTQ3Mvka6p67M2I5mxd/KDU4pp5f1ZywuD0K
        5xZcRZ+C1oZzQplsZq5M8lw=
X-Google-Smtp-Source: AA0mqf7lXxnZYpevpsV858rlXSzg0QPJ3/LuKa1iCQAHnmOwNX3SpRCzIWR+qkYbpC56H0BsZIHzcQ==
X-Received: by 2002:a17:907:3ac2:b0:7b7:c1e7:eb54 with SMTP id fi2-20020a1709073ac200b007b7c1e7eb54mr353463ejc.393.1669052703924;
        Mon, 21 Nov 2022 09:45:03 -0800 (PST)
Received: from localhost ([217.131.81.52])
        by smtp.gmail.com with UTF8SMTPSA id x19-20020aa7cd93000000b00467f643585fsm5404201edv.64.2022.11.21.09.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 09:45:03 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND v3 1/4] dt-bindings: pwm: Add Apple PWM controller
Date:   Mon, 21 Nov 2022 20:42:25 +0300
Message-Id: <20221121174228.93670-2-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221121174228.93670-1-fnkl.kernel@gmail.com>
References: <20221121174228.93670-1-fnkl.kernel@gmail.com>
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

Apple SoCs such as the M1 contain a PWM controller used
among other things to control the keyboard backlight.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Sven Peter <sven@svenpeter.dev>
---
 .../bindings/pwm/apple,s5l-fpwm.yaml          | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml

diff --git a/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
new file mode 100644
index 000000000000..142157bff0cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/apple,s5l-fpwm.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/apple,s5l-fpwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple FPWM controller
+
+maintainers:
+  - asahi@lists.linux.dev
+  - Sasha Finkelstein <fnkl.kernel@gmail.com>
+
+description: PWM controller used for keyboard backlight on ARM Macs
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-fpwm
+          - apple,t6000-fpwm
+          - apple,t8112-fpwm
+      - const: apple,s5l-fpwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@235044000 {
+      compatible = "apple,t8103-fpwm", "apple,s5l-fpwm";
+      reg = <0x35044000 0x4000>;
+      power-domains = <&ps_fpwm1>;
+      clocks = <&clkref>;
+      #pwm-cells = <2>;
+    };
-- 
2.38.1

