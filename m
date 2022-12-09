Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE2C648168
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 12:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiLILPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 06:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiLILPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 06:15:01 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865AE6F0CC;
        Fri,  9 Dec 2022 03:15:00 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o7-20020a05600c510700b003cffc0b3374so3185130wms.0;
        Fri, 09 Dec 2022 03:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k6iH6ye4eNPwympT1HKSV19Z/5AZl0oVvTiapSuckY=;
        b=hrhgHHiKsH7JP6w4UAYp9tudWblnD8ZqogfdP9k14lVZ6lXwBGwk0gcagrzu08jXes
         U69+zpsdP5w40wDcrxOc6UTPQBrM+zA8ETBzdH7MwItV3bTprVZJNnACsUR544QBV8LX
         AXE3pVSLox7781JxAax/vOlXJBwzpLgNGRELx/iuTvhCduJEuQd8YCSy01vpcVatdw2v
         E0FCqGrl9Vzf0dMHAas5NuqU2UPfbs3I7H4RHZlHQDJI6yKVvXGEXwFG6qsLaznEgzeB
         SMKc/aobVedkkLNA2fCVR+XKYyIXDqde20J0Qb25YA0sjxLzGS70P7+lMGLWMYCBJDNX
         oPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6k6iH6ye4eNPwympT1HKSV19Z/5AZl0oVvTiapSuckY=;
        b=gnoXJo9TgJaAZGdp2+4ktAUbTH9kNQD0kX6ryywny59UaCCDr+BWuwrcjBWJaie00T
         tPjxcR/4Bde4a07BICf5VtihUw2ohgUF86QbJuE/CpOsHu90M19yJ//ByBok0iTEMhFY
         /Hr3erkizfu47ZYfSM8PypTBtW9SwFGF3KvEi1vAjFm8VNV0t4+6aI3PhJHm4ABMZlBS
         tjMVVYj7pJpYXLFXTPBXE8kYodQTkFVN9ZUOfjumBRB8NaF13G/qdtmI/qzYCT6f6NzM
         funlJ8+6B7vc7BRUng/2lJcejQh4KS1L/a4jrtrGTkWjupCe7i33Z1LF48xYMWKHKCl6
         AeHQ==
X-Gm-Message-State: ANoB5pkKGRF/OZLhEtQ8bwPEhf+t0jw/7eOHB3a0Q4nfE3aF2hRRoCnF
        dcbKS8cCbKO8bshSSkZYWno=
X-Google-Smtp-Source: AA0mqf7AAF5pODM5Mn55YfbXa5rog8PuTL6atFFeVRuqeK0xc7uhmLmkSm8wyj6uOOF7D7B+tpHsJA==
X-Received: by 2002:a05:600c:1d02:b0:3cf:d365:1ea3 with SMTP id l2-20020a05600c1d0200b003cfd3651ea3mr4788859wms.12.1670584499097;
        Fri, 09 Dec 2022 03:14:59 -0800 (PST)
Received: from localhost ([217.131.81.52])
        by smtp.gmail.com with UTF8SMTPSA id x4-20020a05600c2d0400b003d1e763ba46sm1461344wmf.10.2022.12.09.03.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 03:14:58 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: pwm: Add Apple PWM controller
Date:   Fri,  9 Dec 2022 14:13:10 +0300
Message-Id: <20221209111313.2701-2-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20221209111313.2701-1-fnkl.kernel@gmail.com>
References: <20221209111313.2701-1-fnkl.kernel@gmail.com>
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

