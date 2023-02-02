Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86FE6886B8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjBBSim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjBBSiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:38:24 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A86E1F937
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:37:52 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t7so2566280wrp.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/DpEQ3WT95j3ahVb/iuTFbCoKMlDfa2nVQ/If2Wf7k=;
        b=XFC0aibouZzGFjMHLXWdXmvocR41v3JmQLwFe6dfxGMv2H0B3HTHKK8LuoR2YSJ1Sz
         EKV3TA8m38zbc0Qza1c38ZQDYA78BnvyVqYaUXILvjDe4p+dHqK8IJjxsOX4vbcPk7BT
         1PptwKV3Gv+uO6/JX0mqv5TlH7/dEP4P0vEc4Mm8qil+8v/40SdWGgXJlnBgi15twE0g
         Rxgsb2FqRedulHGjr/d6SliPgQ2g1LI2FySqufXW51c5llTSV8MgPNl7UebicvKdyJaF
         hB0HE4rLz1n79kv8+HXZMfGdmQTt6I6vceCpJA2q6p0FhSTNDQAjZgqq0RiP3D904ABh
         eP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/DpEQ3WT95j3ahVb/iuTFbCoKMlDfa2nVQ/If2Wf7k=;
        b=fI2wK6hKfXFSf1fcFJS1XsMlhJWSLlFrthrEmLTUjUl6+++mPqROMCENGSoOJ0nhFk
         lhyf68OORXOGShW7xQmSnTfEC2doxK8BmclFk2ez/Sm4nXixtw8FvZs6o0hXcCklp0Vi
         Ic/Jpw3bia2D9Eo4NY5Jc2bHgiFHW22mTvL4jKzpJckZlJo23zQY4NoROXjVjAP0lFjt
         DXv+NRtgl3Gsvg6PawVJ7myW95YMqSPS3XMXgVK088zf6HMUCD0SXW00GfeZX1LCzdq0
         QMeX4j0hjruXsFPbtvwU22pbjDk5QAdGdQ6sOzr1sGYkT+G+kkvV2XqTmc7miP3JgaFP
         ORhw==
X-Gm-Message-State: AO0yUKWJ//oIBL1hIjQ1lsgiTURTxUvBG9PoKQDTlnc16S1abrge/s0a
        TNiIP+Je31kFLMORtPYewEoN1Q==
X-Google-Smtp-Source: AK7set/mu/M0m0ZjgRhQ0UpFb3NmI4SGF/qka+7qsN5S+fwfyRnOR3+Qw6MHJWSEFfzIeB2bM2SR+g==
X-Received: by 2002:a05:6000:982:b0:2bf:b199:c7eb with SMTP id by2-20020a056000098200b002bfb199c7ebmr6137905wrb.54.1675363069295;
        Thu, 02 Feb 2023 10:37:49 -0800 (PST)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id p12-20020a5d48cc000000b00241fab5a296sm164664wrs.40.2023.02.02.10.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 10:37:48 -0800 (PST)
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
Subject: [PATCH 7/9] ASoC: dt-bindings: meson: convert axg spdif input to schema
Date:   Thu,  2 Feb 2023 19:36:51 +0100
Message-Id: <20230202183653.486216-8-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202183653.486216-1-jbrunet@baylibre.com>
References: <20230202183653.486216-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the DT binding documentation for the Amlogic axg spdif input to
schema.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-spdifin.txt    | 27 ------
 .../bindings/sound/amlogic,axg-spdifin.yaml   | 90 +++++++++++++++++++
 2 files changed, 90 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
deleted file mode 100644
index df92a4ecf288..000000000000
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-* Amlogic Audio SPDIF Input
-
-Required properties:
-- compatible: 'amlogic,axg-spdifin' or
-	      'amlogic,g12a-spdifin' or
-	      'amlogic,sm1-spdifin'
-- interrupts: interrupt specifier for the spdif input.
-- clocks: list of clock phandle, one for each entry clock-names.
-- clock-names: should contain the following:
-  * "pclk" : peripheral clock.
-  * "refclk" : spdif input reference clock
-- #sound-dai-cells: must be 0.
-
-Optional property:
-- resets: phandle to the dedicated reset line of the spdif input.
-
-Example on the A113 SoC:
-
-spdifin: audio-controller@400 {
-	compatible = "amlogic,axg-spdifin";
-	reg = <0x0 0x400 0x0 0x30>;
-	#sound-dai-cells = <0>;
-	interrupts = <GIC_SPI 87 IRQ_TYPE_EDGE_RISING>;
-	clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
-		 <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
-	clock-names = "pclk", "refclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml
new file mode 100644
index 000000000000..4f7e4c21acc1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifin.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,axg-spdifin.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Audio AXG SPDIF Input
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
+          - const:
+              amlogic,axg-spdifin
+      - items:
+          - enum:
+              - amlogic,g12a-spdifin
+              - amlogic,sm1-spdifin
+          - const:
+              amlogic,axg-spdifin
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
+      - description: SPDIF input reference clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: refclk
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+  - clocks
+  - clock-names
+  - interrupts
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - amlogic,g12a-spdifin
+          - amlogic,sm1-spdifin
+then:
+  properties:
+    resets:
+      items:
+        - description: dedicated device reset line
+
+  required:
+    - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/axg-audio-clkc.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    spdifin: audio-controller@400 {
+    	compatible = "amlogic,axg-spdifin";
+        reg = <0x400 0x30>;
+        #sound-dai-cells = <0>;
+        interrupts = <GIC_SPI 87 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
+                 <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
+        clock-names = "pclk", "refclk";
+    };
-- 
2.39.0

