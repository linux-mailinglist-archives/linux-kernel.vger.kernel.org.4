Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2297166AB8D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 14:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjANN1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 08:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjANN0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 08:26:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6941C9036;
        Sat, 14 Jan 2023 05:26:47 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so20491493wmb.2;
        Sat, 14 Jan 2023 05:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k6iH6ye4eNPwympT1HKSV19Z/5AZl0oVvTiapSuckY=;
        b=LGJyVHoh7bFUcgHskMeiLfEebpwxP7jpmgJ2QOGPbwzKSPfWG88fc+eATSK+XMQdpH
         dl29IWyidRKX850QEHlEY9AjAVUJs6N9elD+IO36UMh0CgAFzFjFZsneML17Y6r8d5Uo
         486v15sjYIMPdBg8OIe7stsWi3cTazN5yxuSH6EhvKMhTEQIl4T7L5Mr4r1XPcVJVjt6
         geW5JjgujZPAqP0V0PumeOiPPuMMZ21Ftt+254U95MHyERyJxZ4RAnHCr9OL+qC7jRNs
         4Jw/DNgDxVrANr37/24gOXGzeiGqSMX9ApakFkaD6d8XliFOT1xkzqUXw68BXhQRGZ9a
         HSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6k6iH6ye4eNPwympT1HKSV19Z/5AZl0oVvTiapSuckY=;
        b=hqbOz7LftvC7vsBmfnwbL4/7CyliuRqX/FSI02n2BP2Gd5D0ImHGX+re71tUkTAb0S
         A2/yxsxSZPVT5t1MiiblqQhfdD8tXBkbFDu9EexGxcGVpA+Rh4SEl6all1BXjZsk8uen
         +epNWTVraCTDx4UrLvuHiyT8kfbWQTd8/HvlIoVUTCH9DpT7EUE/XiaRjFWprx/13fcQ
         6cbktilLstFh9DpJdH/zMk2lrQHGJLxa2gG7Q7wI22bGXQ0/uXpc8+sO0uXSHb1LU2p8
         afivOdwI8MPlss1vPTo0Q0rCksynBsOFRWtW8ysibYMYhVEbwOE+MRP+aDT++J5lyo7j
         zg/g==
X-Gm-Message-State: AFqh2koOcsUhnmxVsvrWvoMTkssa1EGxG4M8AWLauWkUVHgZn3dLsXnJ
        OhWqEn3asEoRGauiKsa1JFA=
X-Google-Smtp-Source: AMrXdXv2ygbzN0IqAO7jz1qfWtxdayFzAWT2QW9B4EUCVZZiRwTBzJY+EvkyQ1u9vF19laIqorIQHw==
X-Received: by 2002:a05:600c:4e02:b0:3d3:5c21:dd94 with SMTP id b2-20020a05600c4e0200b003d35c21dd94mr2715473wmq.9.1673702805919;
        Sat, 14 Jan 2023 05:26:45 -0800 (PST)
Received: from localhost ([176.234.9.57])
        by smtp.gmail.com with UTF8SMTPSA id u2-20020a05600c210200b003d98f92692fsm6221455wml.17.2023.01.14.05.26.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 05:26:45 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/5] dt-bindings: pwm: Add Apple PWM controller
Date:   Sat, 14 Jan 2023 16:25:04 +0300
Message-Id: <20230114132508.96600-2-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230114132508.96600-1-fnkl.kernel@gmail.com>
References: <20230114132508.96600-1-fnkl.kernel@gmail.com>
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
2.37.1 (Apple Git-137.1)

