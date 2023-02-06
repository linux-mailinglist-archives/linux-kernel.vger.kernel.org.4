Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3596C68C1C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjBFPhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjBFPhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:37:15 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF4C2A99F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:36:02 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m14so10726677wrg.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 07:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfu3jmputrK/og1fqi3qU6ALj7vxKy6rZ0t8pc/sq40=;
        b=ZHnYuiRL3ENEjIwA8CHehxzcMS0zC4kw5Iza3g804QEPASmtOWIjX26AeoJOl8d6ik
         CQ4vNjYSK1/ctcPjXRAW3ajeN84Je2bt9qKHOgAPXcD2fkD+xFr3Krn+KJS46jS4m5NZ
         VuttM8+gNd3D4ZkBdhY3HpEAfvY3W35RB0p3m3Y9tOp3+61Yr9PBdwnnlc0I4P8IPgc8
         DsJseBI1jG8lZo1gAJm4TOzqFzlag06ATAsw6I6dYJM1Zzl6wf2eJSqWwVltMou7RPBz
         TbCbBtRmkUL0NbCVsTDmO8siTV+CQch7/CzrbYhrJsXgwS2Sk9s/0wcC4uabLVKEwsIt
         kigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfu3jmputrK/og1fqi3qU6ALj7vxKy6rZ0t8pc/sq40=;
        b=Jhyxe3KKNo0GxA1RKT23WWBhES0sBESGE2UbC9iixDP7afpJg1izyRwR4yUb4Ibcki
         gpjqgVg6pkJFF1wwmex3PRI7VrsMUCB599CuVaXqOITUGowG7cOEe1s6xv52yA3oNVv7
         1qQT05y4eXchJwR5JDNkoavJa9DclkiTPFRptFL66jHWW6O7Tr5lzEfZo/T+OhqdNHjl
         4WuBiEkCxCCgeEFqqdpvK2wl8XaSss4SbPCA6W2SHuy7B9CTWEnnVcZycJDbCaKqhSpu
         zmgKivjn67Y8naXlA/+fWJaTZUXtaaZxZuVH1UmbTXeKw3xQQ8s+wrRwDVdpNgVy08n6
         ikuQ==
X-Gm-Message-State: AO0yUKUtiyxSO9+0/6JnK+m0/vJ7/n3C9aSkO67b1U1Q4Ot9sbvmuJje
        JesKff7z8Qn/t9d384bFUEUEfQ==
X-Google-Smtp-Source: AK7set+OlO3PH8z3y6S9935BmxKTNBfxjdGzm8eW/ChncLIOvUsblIiZQx0RpAzxtxa7Feew7HlELw==
X-Received: by 2002:adf:9c8e:0:b0:2c1:2a15:9dd3 with SMTP id d14-20020adf9c8e000000b002c12a159dd3mr18450773wre.48.1675697699902;
        Mon, 06 Feb 2023 07:34:59 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id e12-20020a5d500c000000b002c3ea9655easm2197317wrt.108.2023.02.06.07.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 07:34:59 -0800 (PST)
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
Subject: [PATCH v2 3/7] ASoC: dt-bindings: meson: convert axg pdm to schema
Date:   Mon,  6 Feb 2023 16:34:45 +0100
Message-Id: <20230206153449.596326-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206153449.596326-1-jbrunet@baylibre.com>
References: <20230206153449.596326-1-jbrunet@baylibre.com>
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
 .../bindings/sound/amlogic,axg-pdm.yaml       | 82 +++++++++++++++++++
 2 files changed, 82 insertions(+), 29 deletions(-)
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
index 000000000000..df21dd72fc65
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml
@@ -0,0 +1,82 @@
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
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,g12a-pdm
+              - amlogic,sm1-pdm
+          - const: amlogic,axg-pdm
+      - const: amlogic,axg-pdm
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
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#sound-dai-cells"
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: dai-common.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,g12a-pdm
+              - amlogic,sm1-pdm
+    then:
+      required:
+        - resets
+
+    else:
+      properties:
+        resets: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/axg-audio-clkc.h>
+
+    audio-controller@ff632000 {
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

