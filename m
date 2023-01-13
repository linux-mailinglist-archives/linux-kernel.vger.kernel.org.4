Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035F3669447
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241224AbjAMKeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241136AbjAMKeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:34:21 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162B84F13B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:34:03 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ud5so51334534ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Gyn9HlBhvG4T1CTbJfaQi/2bfhTMYRBumH9jkT1kFo=;
        b=Dirg2tpLP8+rcNqEkyKVP6uRTQeGQGRa4uG2INybsbvSSXfqjmMb0/S+oki+yIiT8y
         77gAnDPyH8DPq5FypF6XwFUD9ZnnPf3tT6G4KELGve2xLKpf4rPKIJcMHe+MfQWievwF
         sI7rOQtxcqsxq0vMkpe0zTrD7dZ/tiPzmUCjD//EFNZaBJkYG/qtC+YA2saJ5nubNuH7
         /qPO/xthLIpBV2JPvUnXOKZhXWSQ3SbDooL69c0ii/uRATbOUZYMrj0MpX2+M4/n0EnX
         czZH/BrMx036PUOKqmL9Yr0RQWFKVyvOw5RCuxZSzOjdz4dopJ5N3mg90J80FvVwb3N5
         NOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Gyn9HlBhvG4T1CTbJfaQi/2bfhTMYRBumH9jkT1kFo=;
        b=hxkmp91OYVbqdUErZstyvTncAGyk+xEKt50UTL6l5hHS6JVkDbbj1iudUylNnVREsf
         K/nZrfPrXWDwWLEt3H5/kQoxWlKiZ7VoYxO45P4gZYjRqYbC8UvB9+5rKv6cMZZM+EFv
         1nN1j7B8E1XjBT0q2TLMth/ME153xyZXRTiCiDM7215cU8ve1ajVffqb2dNLdMbC8lN8
         WspydjI+wtdg+fdC1uv3NQseR1HExIkZi4gkhvcCIMbTsMXj48lZ2tNQsLTnhyCm+9RJ
         RHrdCtfP9PhU9aKpylMfsNgDhRXWGSIWg0X0fehnEc+4QV+Sbl+hM43Sy2HTtpfGl8kS
         vunw==
X-Gm-Message-State: AFqh2krNU98DWGf86gkZEpetMVrptSEDRbqjxu3mvRf/rpqOz5TbDZ42
        uPqAylkBFKjikZcsc+KBmcdWkg==
X-Google-Smtp-Source: AMrXdXuQvabCkxOh7cAxMXM4m2p4oeMARrjXif6sQoJ3LgBjWJMi3vYQ1AMC8eD/VWTBhI0JdvyAIw==
X-Received: by 2002:a17:907:8e93:b0:7ae:bfec:74c7 with SMTP id tx19-20020a1709078e9300b007aebfec74c7mr73244720ejc.72.1673606041624;
        Fri, 13 Jan 2023 02:34:01 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id qw25-20020a1709066a1900b007ae1e528390sm8296926ejc.163.2023.01.13.02.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 02:34:01 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 6/7] dt-bindings: watchdog: qcom-wdt: merge MSM timer
Date:   Fri, 13 Jan 2023 11:33:45 +0100
Message-Id: <20230113103346.29381-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113103346.29381-1-krzysztof.kozlowski@linaro.org>
References: <20230113103346.29381-1-krzysztof.kozlowski@linaro.org>
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

Merge Qualcomm MSM timer bindings into watchdog, because the timer
compatibles are already included here and the hardware is quite similar.

While converting the MSM timer bindings, adjust clock-frequency
property to take only one frequency, instead of two, because:
1. DT schema does not allow to frequencies,
2. The Linux timer driver reads only first frequency.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

---

Changes since v1:
1. Add tag.
2. Correct clock-frequency description (Rob).
---
 .../bindings/timer/qcom,msm-timer.txt         | 47 ------------------
 .../bindings/watchdog/qcom-wdt.yaml           | 49 +++++++++++++++++++
 2 files changed, 49 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/qcom,msm-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/qcom,msm-timer.txt b/Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
deleted file mode 100644
index 5e10c345548f..000000000000
--- a/Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-* MSM Timer
-
-Properties:
-
-- compatible : Should at least contain "qcom,msm-timer". More specific
-               properties specify which subsystem the timers are paired with.
-
-               "qcom,kpss-timer" - krait subsystem
-               "qcom,scss-timer" - scorpion subsystem
-
-- interrupts : Interrupts for the debug timer, the first general purpose
-               timer, and optionally a second general purpose timer, and
-               optionally as well, 2 watchdog interrupts, in that order.
-
-- reg : Specifies the base address of the timer registers.
-
-- clocks: Reference to the parent clocks, one per output clock. The parents
-          must appear in the same order as the clock names.
-
-- clock-names: The name of the clocks as free-form strings. They should be in
-               the same order as the clocks.
-
-- clock-frequency : The frequency of the debug timer and the general purpose
-                    timer(s) in Hz in that order.
-
-Optional:
-
-- cpu-offset : per-cpu offset used when the timer is accessed without the
-               CPU remapping facilities. The offset is
-               cpu-offset + (0x10000 * cpu-nr).
-
-Example:
-
-       timer@200a000 {
-               compatible = "qcom,scss-timer", "qcom,msm-timer";
-               interrupts = <1 1 0x301>,
-                            <1 2 0x301>,
-                            <1 3 0x301>,
-                            <1 4 0x301>,
-                            <1 5 0x301>;
-               reg = <0x0200a000 0x100>;
-               clock-frequency = <19200000>,
-                                 <32768>;
-               clocks = <&sleep_clk>;
-               clock-names = "sleep";
-               cpu-offset = <0x40000>;
-       };
diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
index b7fc57f4800e..837ce9112071 100644
--- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
@@ -10,6 +10,9 @@ maintainers:
   - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
 
 properties:
+  $nodename:
+    pattern: "^(watchdog|timer)@[0-9a-f]+$"
+
   compatible:
     oneOf:
       - items:
@@ -48,6 +51,20 @@ properties:
   clocks:
     maxItems: 1
 
+  clock-names:
+    items:
+      - const: sleep
+
+  clock-frequency:
+    description:
+      The frequency of the general purpose timer in Hz.
+
+  cpu-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Per-CPU offset used when the timer is accessed without the CPU remapping
+      facilities. The offset is cpu-offset + (0x10000 * cpu-nr).
+
   interrupts:
     minItems: 1
     maxItems: 5
@@ -67,12 +84,27 @@ allOf:
             const: qcom,kpss-wdt
     then:
       properties:
+        clock-frequency: false
+        cpu-offset: false
         interrupts:
           minItems: 1
           items:
             - description: Bark
             - description: Bite
 
+    else:
+      properties:
+        interrupts:
+          minItems: 3
+          items:
+            - description: Debug
+            - description: First general purpose timer
+            - description: Second general purpose timer
+            - description: First watchdog
+            - description: Second watchdog
+      required:
+        - clock-frequency
+
 unevaluatedProperties: false
 
 examples:
@@ -86,3 +118,20 @@ examples:
       interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
       timeout-sec = <10>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    watchdog@200a000 {
+      compatible = "qcom,kpss-wdt-ipq8064", "qcom,kpss-timer", "qcom,msm-timer";
+      interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
+                   <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
+                   <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
+                   <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
+                   <GIC_PPI 5 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
+      reg = <0x0200a000 0x100>;
+      clock-frequency = <25000000>;
+      clocks = <&sleep_clk>;
+      clock-names = "sleep";
+      cpu-offset = <0x80000>;
+    };
-- 
2.34.1

