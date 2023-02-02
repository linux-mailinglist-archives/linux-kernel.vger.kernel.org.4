Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471196886BB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjBBSiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjBBSi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:38:28 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662007ECB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:37:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d14so2545267wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHcTQ2BAGg+MkacXJwMrR2edvtbJn3+EYrwBcjC/8/I=;
        b=Ol+dWYPUCPY2dBcbd6w6cExLMsMOrobov9S0aUXQoGZ5H47VaMO+UiujxXMtAhNA+F
         IxHEFgfw3nkxmtX5CcE4YxDlelZCEEm7uLRwyEgPQ5uTZZdNAbPXNL6U33T89LJfxQ4O
         ZzPmQV9FaIdMksGzccnlyJs6l+clq9ECrJOcnYm5cRI0W7YVY4bpJKbRfO0xHXO6Wcwb
         YLlcXWsz2N4Bzm6JQnwII4mLiMnU+eCil6OYac7GW//Crrdid3R9mfeG3+Z6n6nuHcQZ
         6WQVO4QASUJMJ+9dcz6TzfGzw2eE9H8xEbaTGDfiQmPevqZeNSHM7JKYq9Hc9c8Vh0Q6
         W0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHcTQ2BAGg+MkacXJwMrR2edvtbJn3+EYrwBcjC/8/I=;
        b=y3ZuqMkJXpLhC+sgnN3k2YDZMbqgwbEGOotLxzPaU7CZTP3EybVpe74mHXdjKPTaml
         crIWU3pZoNdJc7VoxVeEe4SpHEhV4fOA7Dylzzko6EjWEe5O195jWmnnKphwK8NlZm2p
         8lI651cxcofcGvdgq0Ujt7mfRV1R6tMqzyshcL4u4sEwdUXsaMbI9FPX9l69iOmxuewr
         IYa3aLJNx/2WRSQGB1TJcM4faONr8Y4mb7cLD0/lVANtx4FQpjWz7PmVXuyB38Khue2X
         sv1EdvhT/L43UgR/aqGDhE/ogjaOR89s8SJhW4RwJaF1JznvW8FpRp/x3mZXJXvJJIN7
         JtoQ==
X-Gm-Message-State: AO0yUKVPHWtxWzp5P8kukbkQwz7mW1SGKwqlCdq7J29rPsau7rlEikqo
        yE3g24VYSj/GsaWWJE3GOggLig==
X-Google-Smtp-Source: AK7set/B53SqoLtzJXsKRY61oKnWcB+meMccnCo4RFMK4i/OPEORfp+Xo0hkgplJDMHVfsx1Vor9iw==
X-Received: by 2002:a5d:4bca:0:b0:242:800:9a7f with SMTP id l10-20020a5d4bca000000b0024208009a7fmr6275648wrt.65.1675363073190;
        Thu, 02 Feb 2023 10:37:53 -0800 (PST)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id p12-20020a5d48cc000000b00241fab5a296sm164664wrs.40.2023.02.02.10.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 10:37:52 -0800 (PST)
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
Subject: [PATCH 8/9] ASoC: dt-bindings: meson: convert axg spdif output to schema
Date:   Thu,  2 Feb 2023 19:36:52 +0100
Message-Id: <20230202183653.486216-9-jbrunet@baylibre.com>
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

Convert the DT binding documentation for the Amlogic axg spdif output to
schema.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-spdifout.txt   | 25 ------
 .../bindings/sound/amlogic,axg-spdifout.yaml  | 83 +++++++++++++++++++
 2 files changed, 83 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
deleted file mode 100644
index 28381dd1f633..000000000000
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-* Amlogic Audio SPDIF Output
-
-Required properties:
-- compatible: 'amlogic,axg-spdifout' or
-	      'amlogic,g12a-spdifout' or
-	      'amlogic,sm1-spdifout'
-- clocks: list of clock phandle, one for each entry clock-names.
-- clock-names: should contain the following:
-  * "pclk" : peripheral clock.
-  * "mclk" : master clock
-- #sound-dai-cells: must be 0.
-
-Optional property:
-- resets: phandle to the dedicated reset line of the spdif output.
-
-Example on the A113 SoC:
-
-spdifout: audio-controller@480 {
-	compatible = "amlogic,axg-spdifout";
-	reg = <0x0 0x480 0x0 0x50>;
-	#sound-dai-cells = <0>;
-	clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
-		 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
-	clock-names = "pclk", "mclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.yaml
new file mode 100644
index 000000000000..c661ce7f8b9d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-spdifout.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,axg-spdifout.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Audio AXG SPDIF Output
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
+              amlogic,axg-spdifout
+      - items:
+          - enum:
+              - amlogic,g12a-spdifout
+              - amlogic,sm1-spdifout
+          - const:
+              amlogic,axg-spdifout
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
+      - description: SPDIF output master clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: mclk
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+  - clocks
+  - clock-names
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - amlogic,g12a-spdifout
+          - amlogic,sm1-spdifout
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
+
+    spdifout: audio-controller@480 {
+    	compatible = "amlogic,axg-spdifout";
+        reg = <0x480 0x50>;
+        #sound-dai-cells = <0>;
+        clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
+                 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
+        clock-names = "pclk", "mclk";
+    };
-- 
2.39.0

