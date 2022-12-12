Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C27364A4DB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiLLQfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiLLQfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:35:45 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7497462E7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:35:44 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p8so274618lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5YdFqvc4mvoUpjnEdg6UwW9ItZt44+OzF74arwCzxM=;
        b=ta3FbO7eAitz9phNwFQsTIDDNTTY7yhEWS8RRtjq2+yKHaocAr3LuCL5Ab5XaLVwcL
         NVB+CTo76h+Dxkd9gqxLtuHpDGHO9UiggO+i7WAKyNLP4UfYCJrO4GaGnLfyyMNH/Acf
         KHXZ41jSMnPI2K8Qnc3TJ9HEEz175tu3FYPWq3/uC9knaS3VGzhCwhPenHWbuEQvnY/D
         4eM6ZCNlCiyMBafAS/6Juj1ny23kRutmdgztSLI9HzmEBLESIUQ5CJdNqDUPpsPpe4Xl
         83SZwjs039OX1oAGe+KUM/6iH++7ml/M1+VvXnQqsF6vDTF2uRwjHTCgr0zvysRhyNv4
         +BZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5YdFqvc4mvoUpjnEdg6UwW9ItZt44+OzF74arwCzxM=;
        b=c8Lus0Unk2pVyx6uhR8RQ9qC/tai7W1huTy6vdqsNRp6NgwyCpC9AN5A/YCfJNER7j
         H/qPiNwm2oxFcxam2tI7XxCIi/PzkxKJeFO+mcSeE3itkTKuyio6/+RM3QwtUVqrAxHF
         pxq289Q6KxdgtlK1WYZnDRNdqxt0nVYux8CVgsx1+oEk3GaUCj3X9DqLsb0353jJKpNk
         Sheiw6kniLN+9vXaMeK3oJUcZHM3qAuXgGR62JRX16fc06RwLO/BFhipZER0jvENMazA
         hUw4XLbKHRvUsxESXor+gwaPc9j0i/UQjHVi3Ca46gMvsVZHFTAPnnO4mrGyz3jeN0Xo
         tTCQ==
X-Gm-Message-State: ANoB5pnRFRahMHgB8MAb70HXmRxvRRvUnRZJKqT2ypVN5qO3BNnMhEjt
        E1/O/xwkSnwlmMGrdEAW++q2o1KQUzD3OyAw6gE=
X-Google-Smtp-Source: AA0mqf44jIvXTV5CtEU//Sp9GXDTVSUtJPBn0HWN1nqPi0vsJZ/SOQX+p/GnzP9eHMnZmqPFBrDvtw==
X-Received: by 2002:a19:a41a:0:b0:4b5:8fee:1d71 with SMTP id q26-20020a19a41a000000b004b58fee1d71mr3660656lfc.64.1670862944027;
        Mon, 12 Dec 2022 08:35:44 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v16-20020ac25b10000000b004acff58a951sm29209lfn.133.2022.12.12.08.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:35:43 -0800 (PST)
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
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH 06/12] dt-bindings: watchdog: qcom-wdt: merge MSM timer
Date:   Mon, 12 Dec 2022 17:35:26 +0100
Message-Id: <20221212163532.142533-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
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
index b7fc57f4800e..697caf1937cc 100644
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
+      The frequency of the general purpose timer in Hz in that order.
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

