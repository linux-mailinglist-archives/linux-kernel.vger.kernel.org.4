Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB253733894
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345632AbjFPS6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345397AbjFPS6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:58:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13BC35AD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:57:52 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-985fd30ef48so157331866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686941871; x=1689533871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CKTz+ECJJ1xR/6J7416GLcEdSbydcxFm07UhQz5Pzj8=;
        b=P/hhpPQeVTpVKWg+DfW5P0kXKCfMvVHT/CIq8yTb/levXeSzttr564zo9k0qr/pDGb
         tIze5nXvZM/fCKX2YMaAr7fv6aItU3jtpn1pP7LSXwEhaC8yCidh5z4oSNu+EEh59Mr7
         t0PKzz6tLT5lwop60yS45NaDbJmkTXZyHB/9uy7MAExTMKptMVrnBHAO5XUAM+K8LBYU
         g4dYm3ml03ex9ln74r6/Rv0NQV5y7x0OmSTxWOaWu9rkKDT/OJt7UjhT+kKzl2i5mN1x
         1U+rT2Db0BSh6Fd4PUXJPjlXFuOHVM717ozfHhzHkKlUDKTEXDCD56O567BFewCCSSg1
         NTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686941871; x=1689533871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKTz+ECJJ1xR/6J7416GLcEdSbydcxFm07UhQz5Pzj8=;
        b=lE/SDDP0NrdB/AmSQSWKeoy7aHEo+fOhQ2l5mRUB+ivZ9VW6M+ajavpC/bPaYD3XDm
         HB+ucvrQWaRGZvkf50oIucJ1wGSLR9GibrnR3mLaFeevkwQOctdX5t2FQx5lKnNU37JO
         eAhyaI1YytchNwwTkBGjnA/FnxY6qtSZrgr+MtHqZzmIVYzSBwaXQ0Sl2V4nkzdGjwAB
         4PzU7OezgL/Wd39nrdhWpMcv1dgky39QCvcXLDXwIym59tM0B0Dd8K06aKqa5kQEWjAC
         bTLTAcni+VESiuDa6hbloqtmi46EsvSN2qyxElSeNj6DfrZ6YkUlBIEA+TS1ak/32twc
         tk5g==
X-Gm-Message-State: AC+VfDxVyhnyKRPW0j+kU3N9tTq/8+PPt+MFRlWPRVxRKP9ZtsU+UQsc
        nN64wkB+PXCgWq/Q30Uj6DL42A==
X-Google-Smtp-Source: ACHHUZ7QOhWl4ZotYAtorsVbcSUPPcqt7jop574ulM+AAcl+g0a0zt32AadG1g+t90gxQraRhellmQ==
X-Received: by 2002:a17:907:2689:b0:965:9602:1f07 with SMTP id bn9-20020a170907268900b0096596021f07mr2988204ejc.39.1686941871070;
        Fri, 16 Jun 2023 11:57:51 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id e24-20020a170906081800b009786c8249d6sm11284606ejd.175.2023.06.16.11.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 11:57:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: pinctrl: qcom,sm8350-lpass-lpi: add SM8350 LPASS TLMM
Date:   Fri, 16 Jun 2023 20:57:40 +0200
Message-Id: <20230616185742.2250452-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bidings for pin controller in SM8350 Low Power Audio SubSystem
(LPASS).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../qcom,sm8350-lpass-lpi-pinctrl.yaml        | 144 ++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml
new file mode 100644
index 000000000000..0fb2002772b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8350 SoC LPASS LPI TLMM
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description:
+  Top Level Mode Multiplexer pin controller in the Low Power Audio SubSystem
+  (LPASS) Low Power Island (LPI) of Qualcomm SM8350 SoC.
+
+properties:
+  compatible:
+    const: qcom,sm8350-lpass-lpi-pinctrl
+
+  reg:
+    items:
+      - description: LPASS LPI TLMM Control and Status registers
+      - description: LPASS LPI MCC registers
+
+  clocks:
+    items:
+      - description: LPASS Core voting clock
+      - description: LPASS Audio voting clock
+
+  clock-names:
+    items:
+      - const: core
+      - const: audio
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    description: Specifying the pin number and flags, as defined in
+      include/dt-bindings/gpio/gpio.h
+    const: 2
+
+  gpio-ranges:
+    maxItems: 1
+
+patternProperties:
+  "-state$":
+    oneOf:
+      - $ref: "#/$defs/qcom-sm8350-lpass-state"
+      - patternProperties:
+          "-pins$":
+            $ref: "#/$defs/qcom-sm8350-lpass-state"
+        additionalProperties: false
+
+$defs:
+  qcom-sm8350-lpass-state:
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+    $ref: /schemas/pinctrl/pincfg-node.yaml
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          pattern: "^gpio([0-9]|1[0-9]|2[0-2])$"
+
+      function:
+        enum: [ dmic1_clk, dmic1_data, dmic2_clk, dmic2_data, dmic3_clk,
+                dmic3_data, dmic4_clk, dmic4_data, ext_mclk1_a, ext_mclk1_b,
+                ext_mclk1_c, ext_mclk1_d, ext_mclk1_e, gpio, i2s0_clk,
+                i2s0_data, i2s0_ws, i2s1_clk, i2s1_data, i2s1_ws, i2s2_clk,
+                i2s2_data, i2s2_ws, i2s3_clk, i2s3_data, i2s3_ws, i2s4_clk,
+                i2s4_data, i2s4_ws, slimbus_clk, slimbus_data, swr_rx_clk,
+                swr_rx_data, swr_tx_clk, swr_tx_data, wsa_swr_clk,
+                wsa_swr_data, wsa2_swr_clk, wsa2_swr_data ]
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+      drive-strength:
+        enum: [2, 4, 6, 8, 10, 12, 14, 16]
+        default: 2
+        description:
+          Selects the drive strength for the specified pins, in mA.
+
+      slew-rate:
+        enum: [0, 1, 2, 3]
+        default: 0
+        description: |
+          0: No adjustments
+          1: Higher Slew rate (faster edges)
+          2: Lower Slew rate (slower edges)
+          3: Reserved (No adjustments)
+
+      bias-bus-hold: true
+      bias-pull-down: true
+      bias-pull-up: true
+      bias-disable: true
+      input-enable: true
+      output-high: true
+      output-low: true
+
+    required:
+      - pins
+      - function
+
+    additionalProperties: false
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - gpio-controller
+  - "#gpio-cells"
+  - gpio-ranges
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/sound/qcom,q6afe.h>
+
+    lpass_tlmm: pinctrl@33c0000 {
+        compatible = "qcom,sm8350-lpass-lpi-pinctrl";
+        reg = <0x033c0000 0x20000>,
+              <0x03550000 0x10000>;
+
+        clocks = <&q6afecc LPASS_HW_MACRO_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>,
+                 <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
+        clock-names = "core", "audio";
+
+        gpio-controller;
+        #gpio-cells = <2>;
+        gpio-ranges = <&lpass_tlmm 0 0 15>;
+
+    };
-- 
2.34.1

