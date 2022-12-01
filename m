Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683D863F1AA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiLANar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiLANao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:30:44 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2D5BF931
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:30:40 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id a7so1854712ljq.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 05:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ILQpLAASTEQxVAHqS2HsUvzwY9XLxYCyDgjgQHgPzU=;
        b=eR9ALniAmj8Rr/MZ8fMkaouXFUfjlssAT56toegyYHVQ1TDZRoXOsvAdt5rJhV+V9U
         8gZwDPU2a7V0Me0ZTWbWhqSV3vgyOTU3cbwup5/rBKe40wn9jaLCmMo1kHbM9/y6DR/2
         OorzZRlGG0knCysTjLO7Y/fWYAFQmGBAbr3xARhqMO+syBiRvEtrH1MD8LhW7vVWCg1k
         IDVPqKmd5i0S3Eo3tR6KkPEImCHtz8Yz33jN8evalkvM82qvdp3OrgviLG2cGDvsda7r
         quhZmXkDLIp/ioY9PxAC668LfCcTG6iE3XsFyo2p4c9G1S6xKyiQWWO7LPW0gAXebrbK
         IS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ILQpLAASTEQxVAHqS2HsUvzwY9XLxYCyDgjgQHgPzU=;
        b=1exxLcpRUZgX8I31VBmUrH9olhfdVjf7u/kuw5zL/eFpEA7BUAxNXzxXyHD/XwzIl7
         fsDTy+yHLNYb4qpD26FrNss+WQiTR/4YGVpITKjSxUNzVJiGwZuxQpnLGiv6mRmPaIgD
         t+7Fr0WCQPUBTM+buq3ZrBkee+Zip/xBD983ZZQlQj3YCEY3Qu6jdv6A0fOGCVWOZ5ct
         3MvUgE0bzxwwPVAfRZz4zP2A88n5TUMrVC+bNMhxXud+nloGoiHNvyBrDAKRPEkakzW5
         F0C8WNAeyAU+6EZQVbu7HVTDOkahmBnjCKPKDGkYwy96odsYno1M75OGvakQHcWQ4SSv
         XBgw==
X-Gm-Message-State: ANoB5pnL4+GQKLIfCsAl+YGfSREZBseQUpzOX2e7O6DxIjTIHbiNa+bd
        uvLSm5eUjxAsHf90Ix/P5X/1ww==
X-Google-Smtp-Source: AA0mqf5OkeTE/cp5ki879BHyFVVAPe8JGTwak2eUMlj2ILnqi8fBN5AEyJqIAguB2W9cicz1mZD4tw==
X-Received: by 2002:a2e:828d:0:b0:276:ffbf:2ee2 with SMTP id y13-20020a2e828d000000b00276ffbf2ee2mr19981993ljg.505.1669901439104;
        Thu, 01 Dec 2022 05:30:39 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p1-20020ac24ec1000000b004991437990esm657494lfr.11.2022.12.01.05.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 05:30:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: serial: qcom,msm-uart: Convert to DT schema
Date:   Thu,  1 Dec 2022 14:30:36 +0100
Message-Id: <20221201133036.45288-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Convert the Qualcomm MSM SoC UART (non-DMA) bindings to DT schema.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/serial/qcom,msm-uart.txt         | 25 ---------
 .../bindings/serial/qcom,msm-uart.yaml        | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uart.txt
 create mode 100644 Documentation/devicetree/bindings/serial/qcom,msm-uart.yaml

diff --git a/Documentation/devicetree/bindings/serial/qcom,msm-uart.txt b/Documentation/devicetree/bindings/serial/qcom,msm-uart.txt
deleted file mode 100644
index ce8c90161959..000000000000
--- a/Documentation/devicetree/bindings/serial/qcom,msm-uart.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-* MSM Serial UART
-
-The MSM serial UART hardware is designed for low-speed use cases where a
-dma-engine isn't needed. From a software perspective it's mostly compatible
-with the MSM serial UARTDM except that it only supports reading and writing one
-character at a time.
-
-Required properties:
-- compatible: Should contain "qcom,msm-uart"
-- reg: Should contain UART register location and length.
-- interrupts: Should contain UART interrupt.
-- clocks: Should contain the core clock.
-- clock-names: Should be "core".
-
-Example:
-
-A uart device at 0xa9c00000 with interrupt 11.
-
-serial@a9c00000 {
-	compatible = "qcom,msm-uart";
-	reg = <0xa9c00000 0x1000>;
-	interrupts = <11>;
-	clocks = <&uart_cxc>;
-	clock-names = "core";
-};
diff --git a/Documentation/devicetree/bindings/serial/qcom,msm-uart.yaml b/Documentation/devicetree/bindings/serial/qcom,msm-uart.yaml
new file mode 100644
index 000000000000..a052aaef21f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/qcom,msm-uart.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/qcom,msm-uart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM SoC Serial UART
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+
+description:
+  The MSM serial UART hardware is designed for low-speed use cases where a
+  dma-engine isn't needed. From a software perspective it's mostly compatible
+  with the MSM serial UARTDM except that it only supports reading and writing
+  one character at a time.
+
+properties:
+  compatible:
+    const: qcom,msm-uart
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: core
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - clock-names
+  - clocks
+  - interrupts
+  - reg
+
+unevaluatedProperties: false
+
+allOf:
+  - $ref: /schemas/serial/serial.yaml#
+
+examples:
+  - |
+    serial@a9c00000 {
+        compatible = "qcom,msm-uart";
+        reg = <0xa9c00000 0x1000>;
+        interrupts = <11>;
+        clocks = <&uart_cxc>;
+        clock-names = "core";
+    };
-- 
2.34.1

