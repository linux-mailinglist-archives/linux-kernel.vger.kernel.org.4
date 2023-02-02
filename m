Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840376886B3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 19:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjBBSib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 13:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbjBBSiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 13:38:21 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3DEBBAA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 10:37:44 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q5so2606474wrv.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 10:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8C7ku/hdu5/TzCYZjswOMzLUyQCwBVMzHPFGN9cKzy0=;
        b=K6j+XbgiXMKA4me6MPCQUDOi7uYQTQpYaO+uCV6lbFgsRH3NnCqmx/HSMYzBbP0FlP
         1AX9OXdTocgEAi76fVpp4BCazKbE2kI5j8A9zZtINn7iOm1Wr92dIs0/JqCWUObBn5sv
         bP6wzmFdk6YVVQrNM7TkU2WBJHqrrL1tnaIzriIckujVTXHqidrL3x7Rn8iBX60PMHRj
         wSLX5jlAefjq8ul/YUxbNBo4htf15B6FmN0qBCKFK8Map+JQX7NXB1YP/OY0fHb/xwSh
         fSog8uAtx8A0RL5EPgPudL90JFs0XWQb+xQrc960qoLDq6frjJutDeJAmNXLbv8ft0Zm
         PZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8C7ku/hdu5/TzCYZjswOMzLUyQCwBVMzHPFGN9cKzy0=;
        b=fUglRJpeXuphUFEkc8aM65/Mr3bv7jvfz9Q34KJ6z+5OkqLx0WjLbZSVqbYhdOYrkS
         mllAmwlnk+8e5Hwk4A9Ankq0ujmUJQdXHdUUbBtOUl5mP2f02XzkPFNpwHh0zwb6wDNa
         U0KWQIp+qSdpBAl1GyGEEYNvitgezgbHJg0wipXyeH6SwErD6aeDKFwT6KI1pqVHbYdy
         rBXkp90YVYqOPXbIUpVHYxKMRY/XXzY1H73Pk5NyjHC/cxLeKM/cZKZWu3qpAJaILpCc
         MOq4RIB33NTnWjzsRltRYnAeCOJNL4ok3sRrScctiIAKmgDpU5AkcrMYQmEzfdq17eyQ
         gDnA==
X-Gm-Message-State: AO0yUKX/0JTqpW9/nhxlXZ6KitzhyKmhhYcjeM2B224/XK50tQWdujbd
        dSN8JYGlQWeNJrm89k/aDF8qCA==
X-Google-Smtp-Source: AK7set9GEst5k0yE0VCUCrw/5WgzY3bbUupi4GHxUPPVXRNzsllK9jWdJzCeKvEvJc434Ov6GNCQUQ==
X-Received: by 2002:adf:c70b:0:b0:2bf:9478:a91d with SMTP id k11-20020adfc70b000000b002bf9478a91dmr6840276wrg.39.1675363061634;
        Thu, 02 Feb 2023 10:37:41 -0800 (PST)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id p12-20020a5d48cc000000b00241fab5a296sm164664wrs.40.2023.02.02.10.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 10:37:41 -0800 (PST)
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
Subject: [PATCH 5/9] ASoC: dt-bindings: meson: convert axg pdm to schema
Date:   Thu,  2 Feb 2023 19:36:49 +0100
Message-Id: <20230202183653.486216-6-jbrunet@baylibre.com>
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

Convert the DT binding documentation for the Amlogic axg PDM device to
schema.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-pdm.txt        | 29 -------
 .../bindings/sound/amlogic,axg-pdm.yaml       | 86 +++++++++++++++++++
 2 files changed, 86 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
deleted file mode 100644
index 716878107a24..000000000000
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-* Amlogic Audio PDM input
-
-Required properties:
-- compatible: 'amlogic,axg-pdm' or
-	      'amlogic,g12a-pdm' or
-	      'amlogic,sm1-pdm'
-- reg: physical base address of the controller and length of memory
-       mapped region.
-- clocks: list of clock phandle, one for each entry clock-names.
-- clock-names: should contain the following:
-  * "pclk"   : peripheral clock.
-  * "dclk"   : pdm digital clock
-  * "sysclk" : dsp system clock
-- #sound-dai-cells: must be 0.
-
-Optional property:
-- resets: phandle to the dedicated reset line of the pdm input.
-
-Example of PDM on the A113 SoC:
-
-pdm: audio-controller@ff632000 {
-	compatible = "amlogic,axg-pdm";
-	reg = <0x0 0xff632000 0x0 0x34>;
-	#sound-dai-cells = <0>;
-	clocks = <&clkc_audio AUD_CLKID_PDM>,
-		 <&clkc_audio AUD_CLKID_PDM_DCLK>,
-		 <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
-	clock-names = "pclk", "dclk", "sysclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
new file mode 100644
index 000000000000..d3da2f8ba7b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,axg-pdm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Audio AXG PDM input
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
+              - amlogic,g12a-pdm
+              - amlogic,sm1-pdm
+          - const:
+              amlogic,axg-pdm
+      - items:
+          - const:
+              amlogic,axg-pdm
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
+      - description: PDM digital clock
+      - description: DSP system clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: dclk
+      - const: sysclk
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
+          - amlogic,g12a-pdm
+          - amlogic,sm1-pdm
+then:
+  properties:
+    resets:
+      items:
+        - description: Dedicated device reset line
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
+    pdm: audio-controller@ff632000 {
+        compatible = "amlogic,axg-pdm";
+        reg = <0xff632000 0x34>;
+        #sound-dai-cells = <0>;
+        clocks = <&clkc_audio AUD_CLKID_PDM>,
+                 <&clkc_audio AUD_CLKID_PDM_DCLK>,
+                 <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
+        clock-names = "pclk", "dclk", "sysclk";
+    };
-- 
2.39.0

