Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F8C69C818
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjBTJ45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjBTJ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:56:54 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265E9CC2A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:56:51 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id eq27so6974291edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JxyzZLWqH4CmIH4TH2Vy9MuCCxUIYLIZaOnWZ1UUbw=;
        b=pgUcemSNzWrbFTBSg5vIkS/KJ19DqW6lzGGnd/9EwVvdHmuUQ6fluJAajuerUXNle1
         HXLL4lz+A+3fIxpNfDmhWR3wvIZbjrpvKOVW3/rEwCCli8QDHHCquLbAGcpWJrsZVS1P
         FvR+AKpENnJa9r7GCFa7+ZQHVylqiLuKe3qunECPpZbJWWCreVS9NlqPhkmJmQOrP2ov
         StJgwck25ycP8owa5+xBILR72WdjJb07ckBQZcwJARh/5v2dWKu38hwLmJI91LYMcoYv
         Uc+6ZqwFrR0VfFkaCyLwJCOBafZtYZougWKBZFUTPye7H7ZdQbeLuqWDIev2EZ4GlTiK
         4EvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JxyzZLWqH4CmIH4TH2Vy9MuCCxUIYLIZaOnWZ1UUbw=;
        b=75SAKaWhSUcKYFtDNtmVwvmsf60sKYlT+ld7SGuFPTtAtocHT9SC0eip0dbmu2LaD0
         aGFJo8X51PC/I4DvkwXZJpEujz4ERlQNB08ijvUS5a2XaAthieoPBfoD7VgugZxHs7nV
         Bt2Uxmw8dZUgyUiDzV7I1Jn6YNkKdhgqw+CH7wvwq31YaGYtuJbsRQVTEqsHxOlTP2lS
         gWwS0tQaFtVqv5gy/VW4pK3K23n++sZgUH1V9lq71bEIZMa8eZYak3sQEka1xEOBfsHE
         p7YYRvGPsDbQ76ZPVUXDMplgUqLqUAwZviJLq5ynEbv37Ltx4ilHv5UI8Bwq4t/qfeQ0
         mCZg==
X-Gm-Message-State: AO0yUKW2ZCmCltztENoTxw87shOqPH2tMbangzqRhpKTfmmNJCNokxae
        aAJ/Uqe+YbwSow/0JCIfo0djFzrn2MgrfhhM
X-Google-Smtp-Source: AK7set80VzeP05Tf00cqGKyKOMUVYdyTqbqPyH6ydENKRVs7GrKbjY72bowMpNFv8iFRAf2JGwPdPA==
X-Received: by 2002:a17:906:2491:b0:878:7471:6da7 with SMTP id e17-20020a170906249100b0087874716da7mr7846678ejb.66.1676887009189;
        Mon, 20 Feb 2023 01:56:49 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b25-20020a17090636d900b008b129b7f4e4sm5513120ejc.167.2023.02.20.01.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 01:56:48 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ASoC: dt-bindings: qcom,wcd9335: Convert to dtschema
Date:   Mon, 20 Feb 2023 10:56:43 +0100
Message-Id: <20230220095643.64898-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220095643.64898-1-krzysztof.kozlowski@linaro.org>
References: <20230220095643.64898-1-krzysztof.kozlowski@linaro.org>
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

Convert the Qualcomm WCD9335 audio codec binding to DT schema.

Changes against original binding:
1. Drop "mclk2" from clocks as neither Linux driver nor DTS uses it.
2. Do not require vdd-micbias-supply as several DTS do not provide it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Few DTS boards have incomplete WCD9335 node causing dtbs_check warnings.
These are fixed here:
https://lore.kernel.org/linux-arm-msm/42f7d53b-a922-760a-4be2-7498ea0d560a@linaro.org/T/#t
---
 .../bindings/sound/qcom,wcd9335.txt           | 123 --------------
 .../bindings/sound/qcom,wcd9335.yaml          | 156 ++++++++++++++++++
 2 files changed, 156 insertions(+), 123 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9335.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
deleted file mode 100644
index 1f75feec3dec..000000000000
--- a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
+++ /dev/null
@@ -1,123 +0,0 @@
-QCOM WCD9335 Codec
-
-Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC, supports
-Qualcomm Technologies, Inc. (QTI) multimedia solutions, including
-the MSM8996, MSM8976, and MSM8956 chipsets. It has in-built
-Soundwire controller, interrupt mux. It supports both I2S/I2C and
-SLIMbus audio interfaces.
-
-Required properties with SLIMbus Interface:
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: For SLIMbus interface it should be "slimMID,PID",
-		    textual representation of Manufacturer ID, Product Code,
-		    shall be in lower case hexadecimal with leading zeroes
-		    suppressed.  Refer to slimbus/bus.txt for details.
-		    Should be:
-		    "slim217,1a0" for MSM8996 and APQ8096 SoCs with SLIMbus.
-
-- reg
-	Usage: required
-	Value type: <u32 u32>
-	Definition: Should be ('Device index', 'Instance ID')
-
-- interrupts
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: Interrupts via WCD INTR1 and INTR2 pins
-
-- interrupt-names:
-	Usage: required
-	Value type: <String array>
-	Definition: Interrupt names of WCD INTR1 and INTR2
-	Should be: "intr1", "intr2"
-
-- reset-gpios:
-	Usage: required
-	Value type: <String Array>
-	Definition: Reset gpio line
-
-- slim-ifc-dev:
-	Usage: required
-	Value type: <phandle>
-	Definition: SLIM interface device
-
-- clocks:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: See clock-bindings.txt section "consumers". List of
-                three clock specifiers for mclk, mclk2 and slimbus clock.
-
-- clock-names:
-	Usage: required
-	Value type: <string>
-	Definition: Must contain "mclk", "mclk2" and "slimbus" strings.
-
-- vdd-buck-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: Should contain a reference to the 1.8V buck supply
-
-- vdd-buck-sido-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: Should contain a reference to the 1.8V SIDO buck supply
-
-- vdd-rx-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: Should contain a reference to the 1.8V rx supply
-
-- vdd-tx-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: Should contain a reference to the 1.8V tx supply
-
-- vdd-vbat-supply:
-	Usage: Optional
-	Value type: <phandle>
-	Definition: Should contain a reference to the vbat supply
-
-- vdd-micbias-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: Should contain a reference to the micbias supply
-
-- vdd-io-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: Should contain a reference to the 1.8V io supply
-
-- interrupt-controller:
-	Usage: required
-	Definition: Indicating that this is a interrupt controller
-
-- #interrupt-cells:
-	Usage: required
-	Value type: <int>
-	Definition: should be 1
-
-#sound-dai-cells
-	Usage: required
-	Value type: <u32>
-	Definition: Must be 1
-
-audio-codec@1{
-	compatible = "slim217,1a0";
-	reg  = <1 0>;
-	interrupts = <&msmgpio 54 IRQ_TYPE_LEVEL_HIGH>;
-	interrupt-names = "intr2"
-	reset-gpios = <&msmgpio 64 GPIO_ACTIVE_LOW>;
-	slim-ifc-dev  = <&wc9335_ifd>;
-	clock-names = "mclk", "native";
-	clocks = <&rpmcc RPM_SMD_DIV_CLK1>,
-		 <&rpmcc RPM_SMD_BB_CLK1>;
-	vdd-buck-supply = <&pm8994_s4>;
-	vdd-rx-supply = <&pm8994_s4>;
-	vdd-buck-sido-supply = <&pm8994_s4>;
-	vdd-tx-supply = <&pm8994_s4>;
-	vdd-io-supply = <&pm8994_s4>;
-	#sound-dai-cells = <1>;
-}
diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd9335.yaml
new file mode 100644
index 000000000000..34f8fe4da9d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.yaml
@@ -0,0 +1,156 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,wcd9335.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WCD9335 Audio Codec
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description:
+  Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC with in-built
+  Soundwire controller and interrupt mux. It supports both I2S/I2C and SLIMbus
+  audio interfaces.
+
+properties:
+  compatible:
+    const: slim217,1a0
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: mclk
+      - const: slimbus
+
+  interrupts:
+    maxItems: 2
+
+  interrupt-names:
+    items:
+      - const: intr1
+      - const: intr2
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  slim-ifc-dev:
+    description: SLIM IFC device interface
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  '#sound-dai-cells':
+    const: 1
+
+  vdd-buck-supply:
+    description: 1.8V buck supply
+
+  vdd-buck-sido-supply:
+    description: 1.8V SIDO buck supply
+
+  vdd-io-supply:
+    description: 1.8V I/O supply
+
+  vdd-micbias-supply:
+    description: micbias supply
+
+  vdd-rx-supply:
+    description: 1.8V rx supply
+
+  vdd-tx-supply:
+    description: 1.8V tx supply
+
+  vdd-vbat-supply:
+    description: vbat supply
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: dai-common.yaml#
+  - if:
+      required:
+        - slim-ifc-dev
+    then:
+      required:
+        - clocks
+        - clock-names
+        - interrupts
+        - interrupt-names
+        - interrupt-controller
+        - '#interrupt-cells'
+        - reset-gpios
+        - slim-ifc-dev
+        - '#sound-dai-cells'
+        - vdd-buck-supply
+        - vdd-buck-sido-supply
+        - vdd-io-supply
+        - vdd-rx-supply
+        - vdd-tx-supply
+    else:
+      properties:
+        clocks: false
+        clock-names: false
+        interrupts: false
+        interrupt-names: false
+        interrupt-controller: false
+        '#interrupt-cells': false
+        reset-gpios: false
+        slim-ifc-dev: false
+        '#sound-dai-cells': false
+        vdd-buck-supply: false
+        vdd-buck-sido-supply: false
+        vdd-io-supply: false
+        vdd-micbias-supply: false
+        vdd-rx-supply: false
+        vdd-tx-supply: false
+        vdd-vbat-supply: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    tasha_ifd: codec@0,0 {
+        compatible = "slim217,1a0";
+        reg = <0 0>;
+    };
+
+    codec@1,0 {
+        compatible = "slim217,1a0";
+        reg = <1 0>;
+
+        clock-names = "mclk", "slimbus";
+        clocks = <&div1_mclk>, <&rpmcc RPM_SMD_BB_CLK1>;
+
+        interrupt-parent = <&tlmm>;
+        interrupts = <54 IRQ_TYPE_LEVEL_HIGH>,
+                     <53 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "intr1", "intr2";
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        reset-gpios = <&tlmm 64 GPIO_ACTIVE_LOW>;
+        slim-ifc-dev = <&tasha_ifd>;
+        #sound-dai-cells = <1>;
+
+        vdd-buck-supply = <&vreg_s4a_1p8>;
+        vdd-buck-sido-supply = <&vreg_s4a_1p8>;
+        vdd-tx-supply = <&vreg_s4a_1p8>;
+        vdd-rx-supply = <&vreg_s4a_1p8>;
+        vdd-io-supply = <&vreg_s4a_1p8>;
+    };
-- 
2.34.1

