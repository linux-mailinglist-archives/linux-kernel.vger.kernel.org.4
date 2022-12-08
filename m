Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC130646CFF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiLHKeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiLHKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:33:16 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD5583258
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:31:39 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id f20so1085934lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WOjKBqSX/bJNurWawr9UIxOhCwY9AfTE5WBw0ZvK0s=;
        b=kJQb28YflwpK3NESU5gQU95yRGilk9HUL2yuzHgwREaj29yOLuHsU1d+muWxXj9JTc
         4ZasRdRWBXFHtROhwYT2c2SjDKJMQK3264B5F5pUDnUkphXf/ypIYtHzl7Sa8PcmUdp7
         S885N8LUQ42hBZRbT6oapU7ac9R6jr8mx8xbWWr6p4yIOGoUM8DyaLr5+vU1IP/WpxKO
         C5oaZYvN9LD+kCoGXXnlCmz/tgHA2Ns6gldZsRNy4N8DoNgJwCwTPn0vMTsP8OuoFEg0
         HDRQ8H9oDJr/pTe7BE6ED/A2Kyxc9aNg6Km7ePO2VH50qDmv/MGiMhjpkw/y/Vzw507M
         c63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WOjKBqSX/bJNurWawr9UIxOhCwY9AfTE5WBw0ZvK0s=;
        b=5SYADyL2ZSiLSP42y0CFF+EjXbRDb57upirtsV0CZJBw1PcxJq1skvKyh3U9+qB71J
         eqMk6OWVyc6e9REuMbZZR+jGBch85A/2Y56C/rFJmle8V6ISm6JEznCLl6nGuDdvAvUo
         z6+77iosfjW7nKjI8XR8eYjWLJArwPSPWidslH88fPulIBI+s8RjfYiA7xaZg1lZy1MC
         /YmWvuWj1n2iLMgp2yB7LPweuzDweUR+PJUlgrxKPZCC6Ju1CxOrCXdMvuDojN9LIPti
         Y8uCwmaz6i+JAFD5gpBiS63a0sPebnBZp4pSIlmu7TnROm43MM3NhkkDVlG2Z6f2besY
         v80w==
X-Gm-Message-State: ANoB5pn758SOd3cMd8ZLTRszuMVx5D3IYaoT2t4pL3eGdVVj8LLEG+OO
        Rx/zcFOYFu7DMB6eKbgLDjR12ls0ucod4Mq+qxg=
X-Google-Smtp-Source: AA0mqf6m4mBUWnejewtw0czAsyfVH1o6wdUJZLZZZH/Uv9O0p48as/hiEsZvE9q4V5RCh7+GTk8YYw==
X-Received: by 2002:a05:651c:2388:b0:279:d60:ee7f with SMTP id bk8-20020a05651c238800b002790d60ee7fmr31670490ljb.404.1670495498246;
        Thu, 08 Dec 2022 02:31:38 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h18-20020a2eb0f2000000b00279e5247dabsm1699580ljl.18.2022.12.08.02.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 02:31:37 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Joe Tessler <jrt@google.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Jeff Chase <jnchase@google.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 6/9] media: dt-bindings: samsung,s5p-cec: convert to DT schema
Date:   Thu,  8 Dec 2022 11:31:12 +0100
Message-Id: <20221208103115.25512-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208103115.25512-1-krzysztof.kozlowski@linaro.org>
References: <20221208103115.25512-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Samsung S5P HDMI CEC adapter bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/media/cec/samsung,s5p-cec.yaml   | 66 +++++++++++++++++++
 .../devicetree/bindings/media/s5p-cec.txt     | 36 ----------
 MAINTAINERS                                   |  2 +-
 3 files changed, 67 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/cec/samsung,s5p-cec.yaml
 delete mode 100644 Documentation/devicetree/bindings/media/s5p-cec.txt

diff --git a/Documentation/devicetree/bindings/media/cec/samsung,s5p-cec.yaml b/Documentation/devicetree/bindings/media/cec/samsung,s5p-cec.yaml
new file mode 100644
index 000000000000..016c8a77c1a6
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/cec/samsung,s5p-cec.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/cec/samsung,s5p-cec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S5PV210 and Exynos HDMI CEC
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+  - Marek Szyprowski <m.szyprowski@samsung.com>
+
+allOf:
+  - $ref: cec-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,s5p-cec
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: hdmicec
+
+  interrupts:
+    maxItems: 1
+
+  samsung,syscon-phandle:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to PMU system controller interface
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - hdmi-phandle
+  - interrupts
+  - samsung,syscon-phandle
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos5420.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    cec@101b0000 {
+        compatible = "samsung,s5p-cec";
+        reg = <0x101B0000 0x200>;
+
+        clocks = <&clock CLK_HDMI_CEC>;
+        clock-names = "hdmicec";
+        interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+        hdmi-phandle = <&hdmi>;
+        needs-hpd;
+        pinctrl-names = "default";
+        pinctrl-0 = <&hdmi_cec>;
+        samsung,syscon-phandle = <&pmu_system_controller>;
+    };
diff --git a/Documentation/devicetree/bindings/media/s5p-cec.txt b/Documentation/devicetree/bindings/media/s5p-cec.txt
deleted file mode 100644
index e847291d4aff..000000000000
--- a/Documentation/devicetree/bindings/media/s5p-cec.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-* Samsung HDMI CEC driver
-
-The HDMI CEC module is present is Samsung SoCs and its purpose is to
-handle communication between HDMI connected devices over the CEC bus.
-
-Required properties:
-  - compatible : value should be following
-	"samsung,s5p-cec"
-
-  - reg : Physical base address of the IP registers and length of memory
-	  mapped region.
-
-  - interrupts : HDMI CEC interrupt number to the CPU.
-  - clocks : from common clock binding: handle to HDMI CEC clock.
-  - clock-names : from common clock binding: must contain "hdmicec",
-		  corresponding to entry in the clocks property.
-  - samsung,syscon-phandle - phandle to the PMU system controller
-  - hdmi-phandle - phandle to the HDMI controller, see also cec.txt.
-
-Optional:
-  - needs-hpd : if present the CEC support is only available when the HPD
-		is high. See cec.txt for more details.
-
-Example:
-
-hdmicec: cec@100b0000 {
-	compatible = "samsung,s5p-cec";
-	reg = <0x100B0000 0x200>;
-	interrupts = <0 114 0>;
-	clocks = <&clock CLK_HDMI_CEC>;
-	clock-names = "hdmicec";
-	samsung,syscon-phandle = <&pmu_system_controller>;
-	hdmi-phandle = <&hdmi>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&hdmi_cec>;
-};
diff --git a/MAINTAINERS b/MAINTAINERS
index 45402e03cda5..05acbaecef52 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2866,7 +2866,7 @@ M:	Marek Szyprowski <m.szyprowski@samsung.com>
 L:	linux-samsung-soc@vger.kernel.org
 L:	linux-media@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/media/s5p-cec.txt
+F:	Documentation/devicetree/bindings/media/cec/samsung,s5p-cec.yaml
 F:	drivers/media/cec/platform/s5p/
 
 ARM/SAMSUNG S5P SERIES JPEG CODEC SUPPORT
-- 
2.34.1

