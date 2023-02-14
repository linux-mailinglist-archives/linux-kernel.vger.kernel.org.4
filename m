Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02AB696158
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjBNKrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjBNKrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:47:23 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B577A5E6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:46:59 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso13322492wmp.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnqWFP3S/mYpdJd7jNi0qKprTXE1O3AHQErMdEIJxhE=;
        b=avOC9QTWD8RCAuWqkP5IuS9rGHaXHiQsbVXP9Nef+4+UVowge+lzXCJm4RFY/LF7f1
         78u03dnYKdLJbu7mVEg6/P/DwPnILj6uo3hCyEZbKEU8g3WmVRSXwyEYixe3dymoG2TL
         w8Dw8pOWk/bDpmYRrpq8yJt6SqeZW0eFDEWdIKX+ZFKvYSuuxNQAwVnLQhI4AiOteJzD
         GxhKWw8PW0Agm1zxGBv0ZywL7ez2nJISExqhw5wGjBzriy7+5z5bSV2bZI6G1mLkOXQQ
         WM6eBdCTGIoe7OJxXgUVq4JWUK8EzmX2cweo7N+g7N3S9i25je+46ygOyN5mtofJSutg
         OFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnqWFP3S/mYpdJd7jNi0qKprTXE1O3AHQErMdEIJxhE=;
        b=zt8y+w5KDRsfV73PTa9/CaEXhP8OCR9Ok+Ui25uMTcAl2aLhf4pYqRmS2L0tZNOqI4
         XFVcN8nxWkhS1BXJeeG6hr+lWZFVv2NLqyp/VRA8alx1bxtQqAWqsTf8Hq2ZluRg5zhV
         Ka5/kjXoZHGn9iTMIcRQQ+4XZtMPc3/Xpw80g6usCqBZeqJMC6AXmsJ2svhseL95eN2L
         GJ1NrmAAe1u3k1WjKDratCoboJ0EaFlGRetsNDALAvS8Jf+/7IIxcgQcdAa2/v4ndR57
         ggY5mR6EQh2tG1g+H7f4QSoWTqzP2ldFWr2ye7QmoWOC23251y7KFP2zTcGghRRykz0R
         1CqQ==
X-Gm-Message-State: AO0yUKW42FbF+1AQPeqvVO3WRXGp5agWJIXAwbXOrTK26jfd5RtAs+Dg
        d6ozms/ncmsF/B8cNXl73su1qg==
X-Google-Smtp-Source: AK7set9BkT2oW7eg6yytmGLcVa/22qTmI97q+YMv7gYEupY6JIWy48JUWnCsx94FGxn/cd5aOsPD9g==
X-Received: by 2002:a05:600c:3412:b0:3dd:b0b3:811b with SMTP id y18-20020a05600c341200b003ddb0b3811bmr1565945wmp.31.1676371616865;
        Tue, 14 Feb 2023 02:46:56 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b003e1f319b87bsm2623719wmq.24.2023.02.14.02.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 02:46:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 4/7] media: dt-bindings: samsung,exynos4212-fimc-lite: convert to dtschema
Date:   Tue, 14 Feb 2023 11:45:05 +0100
Message-Id: <20230214104508.51955-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230214104508.51955-1-krzysztof.kozlowski@linaro.org>
References: <20230214104508.51955-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Samsung Exynos SoC series camera host interface (FIMC-LITE)
bindings to DT schema.  Changes during conversion - adjust to existing
DTS and Linux driver: add iommus and power-domains.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/media/exynos-fimc-lite.txt       | 16 -----
 .../media/samsung,exynos4212-fimc-lite.yaml   | 63 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 64 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/exynos-fimc-lite.txt
 create mode 100644 Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-lite.yaml

diff --git a/Documentation/devicetree/bindings/media/exynos-fimc-lite.txt b/Documentation/devicetree/bindings/media/exynos-fimc-lite.txt
deleted file mode 100644
index 0bf6fb7fbeab..000000000000
--- a/Documentation/devicetree/bindings/media/exynos-fimc-lite.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Exynos4x12/Exynos5 SoC series camera host interface (FIMC-LITE)
-
-Required properties:
-
-- compatible	: should be one of:
-		  "samsung,exynos4212-fimc-lite" for Exynos4212/4412 SoCs,
-		  "samsung,exynos5250-fimc-lite" for Exynos5250 compatible
-		   devices;
-- reg		: physical base address and size of the device memory mapped
-		  registers;
-- interrupts	: should contain FIMC-LITE interrupt;
-- clocks	: FIMC LITE gate clock should be specified in this property.
-- clock-names	: should contain "flite" entry.
-
-Each FIMC device should have an alias in the aliases node, in the form of
-fimc-lite<n>, where <n> is an integer specifying the IP block instance.
diff --git a/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-lite.yaml b/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-lite.yaml
new file mode 100644
index 000000000000..f80eca0a4f41
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-lite.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/samsung,exynos4212-fimc-lite.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC series camera host interface (FIMC-LITE)
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+description:
+  Each FIMC device should have an alias in the aliases node, in the form of
+  fimc-lite<n>, where <n> is an integer specifying the IP block instance.
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos4212-fimc-lite
+      - samsung,exynos5250-fimc-lite
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: flite
+
+  interrupts:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos4.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    fimc-lite@12390000 {
+        compatible = "samsung,exynos4212-fimc-lite";
+        reg = <0x12390000 0x1000>;
+        clocks = <&isp_clock CLK_ISP_FIMC_LITE0>;
+        clock-names = "flite";
+        interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+        power-domains = <&pd_isp>;
+        iommus = <&sysmmu_fimc_lite0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 0882e304c8f9..2789c436c875 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18466,6 +18466,7 @@ L:	linux-media@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.linuxtv.org/project/linux-media/list/
 F:	Documentation/devicetree/bindings/media/samsung,exynos4210-csis.yaml
+F:	Documentation/devicetree/bindings/media/samsung,exynos4212-fimc-lite.yaml
 F:	drivers/media/platform/samsung/exynos4-is/
 
 SAMSUNG SOC CLOCK DRIVERS
-- 
2.34.1

