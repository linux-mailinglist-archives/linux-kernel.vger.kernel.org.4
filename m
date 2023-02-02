Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D109C6886B4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjBBSi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjBBSiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:38:22 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1F91E9E7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:37:47 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bk16so2535782wrb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qzWJ+PJWjjXt1zQX9IH2K8XJiUf6DeC3wzgQPgc4GE=;
        b=FOpoHF3f8QzmBlP4tl0/Yl5Eb99/+m1gDJTugenbzY8kup1MBbDbxZmTLbURQXOMeS
         Gx4qKZJIhYyjaGRlQk3ceTo2nSf+ALBZD0JZy8Ced9QTim/z7DSctzKjORaTmeMaq8He
         iWP7XRNFWI8I7n2V5jc/AGauFGnQy2rTKzaU+f/ZoPNbm+Gy0PfB+qR5S8kKRWxDaEra
         Bv8IR6aN5kFwjGQao/5nSDDu5YrHO1i7bxcRs2FGdsGt3MQpxPYhrRTxsry8t/gpw3LN
         pfJFNywFnH6ieUuSToVTsMyeT3QXaa58Nj7pi45zDbH07DifystOpcm7wOfCfE6NUx2o
         WKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/qzWJ+PJWjjXt1zQX9IH2K8XJiUf6DeC3wzgQPgc4GE=;
        b=Nh7rTrzmuaoSF68eJ4IjTDoKYV641ruV7cnEIh/F0AUCE4fbp0XneDM6vB2zmBcT0f
         /Tg5Qj8WhilfOl9ZpmG1r1eDoNlPMnxHpn8NiDW5ZFsqYPyuy8Vc27F6sLLKyGNApTCv
         H/5SMbhITRF8Odbtnzu1w9cuQxYdCcZTJGNy8NCgd/1iLYrQQ+Cy9F2D87WmemwIAVmP
         GzwgglC2XEOuzAGgYEMhZbbP9+BVW7+A1FjlwRjM1lMgbH3+Zo3L+VaC3XlnLDRdds+4
         kI4MjW0cZhyLgAMDsFKWa2w3+gpSoLNePOZBHVoAwpFKUbakSyLMrQ0/3r+aNtt4fpGT
         FoZg==
X-Gm-Message-State: AO0yUKXinFFyn4wi1FvvtDtJo/wvtJC5v4d3oWnNpUkKSK27i7sewfoh
        p27IhYCU/DQfq7yzQ3KElAFc+g==
X-Google-Smtp-Source: AK7set8onuVp4cHeXmcTC8LpsEEAQcnGWYTri6tZ8J2QzpQkkVkE/HiDhb+ly+kJ1rLPravbxzeOUQ==
X-Received: by 2002:a05:6000:15cd:b0:2bf:d8ed:ba46 with SMTP id y13-20020a05600015cd00b002bfd8edba46mr8007620wry.47.1675363065020;
        Thu, 02 Feb 2023 10:37:45 -0800 (PST)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id p12-20020a5d48cc000000b00241fab5a296sm164664wrs.40.2023.02.02.10.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 10:37:44 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] ASoC: dt-bindings: meson: convert axg fifo to schema
Date:   Thu,  2 Feb 2023 19:36:50 +0100
Message-Id: <20230202183653.486216-7-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202183653.486216-1-jbrunet@baylibre.com>
References: <20230202183653.486216-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the DT binding documentation for the Amlogic axg audio FIFOs to
schema.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-fifo.txt       |  34 -----
 .../bindings/sound/amlogic,axg-fifo.yaml      | 116 ++++++++++++++++++
 2 files changed, 116 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
deleted file mode 100644
index fa4545ed81ca..000000000000
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-* Amlogic Audio FIFO controllers
-
-Required properties:
-- compatible: 'amlogic,axg-toddr' or
-	      'amlogic,axg-toddr' or
-	      'amlogic,g12a-frddr' or
-	      'amlogic,g12a-toddr' or
-	      'amlogic,sm1-frddr' or
-	      'amlogic,sm1-toddr'
-- reg: physical base address of the controller and length of memory
-       mapped region.
-- interrupts: interrupt specifier for the fifo.
-- clocks: phandle to the fifo peripheral clock provided by the audio
-	  clock controller.
-- resets: list of reset phandle, one for each entry reset-names.
-- reset-names: should contain the following:
-  * "arb" : memory ARB line (required)
-  * "rst" : dedicated device reset line (optional)
-- #sound-dai-cells: must be 0.
-- amlogic,fifo-depth: The size of the controller's fifo in bytes. This
-  		      is useful for determining certain configuration such
-		      as the flush threshold of the fifo
-
-Example of FRDDR A on the A113 SoC:
-
-frddr_a: audio-controller@1c0 {
-	compatible = "amlogic,axg-frddr";
-	reg = <0x0 0x1c0 0x0 0x1c>;
-	#sound-dai-cells = <0>;
-	interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
-	clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
-	resets = <&arb AXG_ARB_FRDDR_A>;
-	fifo-depth = <512>;
-};
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
new file mode 100644
index 000000000000..f6222ad08880
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,axg-fifo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic AXG Audio FIFO controllers
+
+maintainers:
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  $nodename:
+    pattern: "^audio-controller@.*"
+
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,axg-toddr
+              - amlogic,axg-frddr
+      - items:
+          - enum:
+              - amlogic,g12a-toddr
+              - amlogic,sm1-toddr
+          - const:
+              amlogic,axg-toddr
+      - items:
+          - enum:
+              - amlogic,g12a-frddr
+              - amlogic,sm1-frddr
+          - const:
+              amlogic,axg-frddr
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+  clocks:
+    items:
+      - description: Peripheral clock
+
+  interrupts:
+    maxItems: 1
+
+  resets:
+    items:
+      - description: Memory ARB line
+      - description: Dedicated device reset line
+
+  reset-names: true
+
+  amlogic,fifo-depth:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Size of the controller's fifo in bytes
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+  - clocks
+  - interrupts
+  - resets
+  - amlogic,fifo-depth
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - amlogic,g12a-toddr
+          - amlogic,sm1-toddr
+          - amlogic,g12a-frddr
+          - amlogic,sm1-frddr
+then:
+  properties:
+    resets:
+      minItems: 2
+    reset-names:
+      items:
+        - const: arb
+        - const: rst
+  required:
+    - reset-names
+else:
+  properties:
+    resets:
+      maxItems: 1
+    reset-names:
+      const: arb
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/axg-audio-clkc.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
+    #include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
+
+    frddr_a: audio-controller@1c0 {
+        compatible = "amlogic,g12a-frddr", "amlogic,axg-frddr";
+        reg = <0x1c0 0x1c>;
+        #sound-dai-cells = <0>;
+        clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
+        interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
+        resets = <&arb>, <&clkc_audio AUD_RESET_FRDDR_A>;
+        reset-names = "arb", "rst";
+        amlogic,fifo-depth = <512>;
+    };
-- 
2.39.0

