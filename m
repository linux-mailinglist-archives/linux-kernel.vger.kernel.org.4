Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A3468EB8C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjBHJfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjBHJfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:35:42 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1E51167F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:35:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j29-20020a05600c1c1d00b003dc52fed235so982607wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 01:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTMZujWm0FeqyY2qheXayCl1H08Q6dG932Xm9nn/YOc=;
        b=QqRsLYLGnloK/ekMeNsNKW+T2qVngTkY597rAckVorSR8Q5Ym01zRr7ZPTdLm8gzng
         F/zmT9k1BbS2LaC8u1NZzWfrKqyr37aaszKCZo+stNk5FJVLP2jMTlhenJOFjgxr0Bt8
         XLmIR0btY7q0ase8dkVK+JgPQMqlDU75UaAF1DF3sUHrYqmmKgyzOOLzdenUB5+znxaL
         OuY+rgyrLX9lJ0sxIAgFIOisLcSFlKZBUVZKu6EkNZllqDunDeEJG+MSPnBpbcEx4vIO
         ljZmOP96vnMYOlp5Lf4gXvTQ7eK3fGawy0PC6bb5FWsI8rIdo8QJhl/Zt4g09wfSsxdF
         KXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTMZujWm0FeqyY2qheXayCl1H08Q6dG932Xm9nn/YOc=;
        b=Se0pMvJa2SNwdaGgbpSOpilgsvWFPFUgkqsZ/FOk83fZskKSdzksaLAazSlD4VWuPU
         gRXaQvJAsBbH9Ly25Au0HneuHieEhgUGL0M5hQIENZiC7Ivem0oH7+j0XftuAmI6y9vP
         Ldqal26sMxSVKgEbgQrPVo3U0vKQ9gXVKSFQAjuGvbS3SzMSBC4pYYvpxr32nzApP+QT
         2rUO4FMm7K7xdDW05pLKTTkasMzodrRMLvIL3NKkVcwLPxmYdV3BLlvml/loit3Rxt5u
         txkA/BGTnn7xxEkQLKvJjYGbQyF0oZW3fBc+ks8n72TMs9YQITXiJDBiTnaKnHBlRT4z
         COBg==
X-Gm-Message-State: AO0yUKWy/qVYDAthRRv6ZKrvsKZPxDZoXYmMFml1lUnj+AzAuxwW3ADF
        4z+9dkv6qEAo00f9LyXYu9yosA==
X-Google-Smtp-Source: AK7set9zRtiIphdKFB2mP77yNfWw29fvn0rYfx664qR92CahMqz8Tkj0PL4Yn+3t7pOptLwfUg30lw==
X-Received: by 2002:a05:600c:3416:b0:3df:50eb:7ca6 with SMTP id y22-20020a05600c341600b003df50eb7ca6mr6064027wmp.15.1675848927781;
        Wed, 08 Feb 2023 01:35:27 -0800 (PST)
Received: from jackdaw.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j23-20020a05600c1c1700b003dc1a525f22sm1375051wms.25.2023.02.08.01.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 01:35:27 -0800 (PST)
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
Subject: [PATCH v3 1/1] ASoC: dt-bindings: meson: convert axg sound card control to schema
Date:   Wed,  8 Feb 2023 10:35:19 +0100
Message-Id: <20230208093520.52843-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208093520.52843-1-jbrunet@baylibre.com>
References: <20230208093520.52843-1-jbrunet@baylibre.com>
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

Convert the DT binding documentation for the Amlogic axg sound card to
schema.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/sound/amlogic,axg-sound-card.txt | 124 ------------
 .../sound/amlogic,axg-sound-card.yaml         | 183 ++++++++++++++++++
 2 files changed, 183 insertions(+), 124 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
deleted file mode 100644
index 80b411296480..000000000000
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
+++ /dev/null
@@ -1,124 +0,0 @@
-Amlogic AXG sound card:
-
-Required properties:
-
-- compatible: "amlogic,axg-sound-card"
-- model : User specified audio sound card name, one string
-
-Optional properties:
-
-- audio-aux-devs : List of phandles pointing to auxiliary devices
-- audio-widgets : Please refer to widgets.txt.
-- audio-routing : A list of the connections between audio components.
-
-Subnodes:
-
-- dai-link: Container for dai-link level properties and the CODEC
-	    sub-nodes. There should be at least one (and probably more)
-	    subnode of this type.
-
-Required dai-link properties:
-
-- sound-dai: phandle and port of the CPU DAI.
-
-Required TDM Backend dai-link properties:
-- dai-format : CPU/CODEC common audio format
-
-Optional TDM Backend dai-link properties:
-- dai-tdm-slot-rx-mask-{0,1,2,3}: Receive direction slot masks
-- dai-tdm-slot-tx-mask-{0,1,2,3}: Transmit direction slot masks
-				  When omitted, mask is assumed to have to no
-				  slots. A valid must have at one slot, so at
-				  least one these mask should be provided with
-				  an enabled slot.
-- dai-tdm-slot-num : Please refer to tdm-slot.txt.
-		     If omitted, slot number is set to accommodate the largest
-		     mask provided.
-- dai-tdm-slot-width : Please refer to tdm-slot.txt. default to 32 if omitted.
-- mclk-fs : Multiplication factor between stream rate and mclk
-
-Backend dai-link subnodes:
-
-- codec: dai-link representing backend links should have at least one subnode.
-	 One subnode for each codec of the dai-link.
-	 dai-link representing frontend links have no codec, therefore have no
-	 subnodes
-
-Required codec subnodes properties:
-
-- sound-dai: phandle and port of the CODEC DAI.
-
-Optional codec subnodes properties:
-
-- dai-tdm-slot-tx-mask : Please refer to tdm-slot.txt.
-- dai-tdm-slot-rx-mask : Please refer to tdm-slot.txt.
-
-Example:
-
-sound {
-	compatible = "amlogic,axg-sound-card";
-	model = "AXG-S420";
-	audio-aux-devs = <&tdmin_a>, <&tdmout_c>;
-	audio-widgets = "Line", "Lineout",
-			"Line", "Linein",
-			"Speaker", "Speaker1 Left",
-			"Speaker", "Speaker1 Right";
-			"Speaker", "Speaker2 Left",
-			"Speaker", "Speaker2 Right";
-	audio-routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
-			"SPDIFOUT IN 0", "FRDDR_A OUT 3",
-			"TDM_C Playback", "TDMOUT_C OUT",
-			"TDMIN_A IN 2", "TDM_C Capture",
-			"TDMIN_A IN 5", "TDM_C Loopback",
-			"TODDR_A IN 0", "TDMIN_A OUT",
-			"Lineout", "Lineout AOUTL",
-			"Lineout", "Lineout AOUTR",
-			"Speaker1 Left", "SPK1 OUT_A",
-			"Speaker2 Left", "SPK2 OUT_A",
-			"Speaker1 Right", "SPK1 OUT_B",
-			"Speaker2 Right", "SPK2 OUT_B",
-			"Linein AINL", "Linein",
-			"Linein AINR", "Linein";
-
-	dai-link@0 {
-		sound-dai = <&frddr_a>;
-	};
-
-	dai-link@1 {
-		sound-dai = <&toddr_a>;
-	};
-
-	dai-link@2 {
-		sound-dai = <&tdmif_c>;
-		dai-format = "i2s";
-		dai-tdm-slot-tx-mask-2 = <1 1>;
-		dai-tdm-slot-tx-mask-3 = <1 1>;
-		dai-tdm-slot-rx-mask-1 = <1 1>;
-		mclk-fs = <256>;
-
-		codec@0 {
-			sound-dai = <&lineout>;
-		};
-
-		codec@1 {
-			sound-dai = <&speaker_amp1>;
-		};
-
-		codec@2 {
-			sound-dai = <&speaker_amp2>;
-		};
-
-		codec@3 {
-			sound-dai = <&linein>;
-		};
-
-	};
-
-	dai-link@3 {
-		sound-dai = <&spdifout>;
-
-		codec {
-			sound-dai = <&spdif_dit>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
new file mode 100644
index 000000000000..bf1234550343
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.yaml
@@ -0,0 +1,183 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/amlogic,axg-sound-card.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic AXG sound card
+
+maintainers:
+  - Jerome Brunet <jbrunet@baylibre.com>
+
+properties:
+  compatible:
+    const: amlogic,axg-sound-card
+
+  audio-aux-devs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: list of auxiliary devices
+
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source.
+
+  audio-widgets:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      A list off component DAPM widget. Each entry is a pair of strings,
+      the first being the widget type, the second being the widget name
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+patternProperties:
+  "^dai-link-[0-9]+$":
+    type: object
+    additionalProperties: false
+    description:
+      Container for dai-link level properties and the CODEC sub-nodes.
+      There should be at least one (and probably more) subnode of this type
+
+    properties:
+      dai-format:
+        $ref: /schemas/types.yaml#/definitions/string
+        enum: [ i2s, left-j, dsp_a ]
+
+      dai-tdm-slot-num:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Number of slots in use. If omitted, slot number is set to
+          accommodate the largest mask provided.
+        maximum: 32
+
+      dai-tdm-slot-width:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: Width in bits for each slot
+        enum: [ 8, 16, 20, 24, 32 ]
+        default: 32
+
+      mclk-fs:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Multiplication factor between the frame rate and master clock
+          rate
+
+      sound-dai:
+        maxItems: 1
+        description: phandle of the CPU DAI
+
+    patternProperties:
+      "^dai-tdm-slot-(t|r)x-mask-[0-3]$":
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 1
+        maxItems: 32
+        description:
+          Transmit and receive cpu slot masks of each TDM lane
+          When omitted, mask is assumed to have to no slots. A valid
+          interface must have at least one slot, so at least one these
+          mask should be provided with an enabled slot.
+
+      "^codec(-[0-9]+)?$":
+        type: object
+        additionalProperties: false
+        description:
+          dai-link representing backend links should have at least one subnode.
+          One subnode for each codec of the dai-link. dai-link representing
+          frontend links have no codec, therefore have no subnodes
+
+        properties:
+          sound-dai:
+            maxItems: 1
+            description: phandle of the codec DAI
+
+        patternProperties:
+          "^dai-tdm-slot-(t|r)x-mask$":
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            minItems: 1
+            maxItems: 32
+            description: Transmit and receive codec slot masks
+
+        required:
+          - sound-dai
+
+    required:
+      - sound-dai
+
+required:
+  - model
+  - dai-link-0
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "amlogic,axg-sound-card";
+        model = "AXG-S420";
+        audio-aux-devs = <&tdmin_a>, <&tdmout_c>;
+        audio-widgets = "Line", "Lineout",
+                        "Line", "Linein",
+                        "Speaker", "Speaker1 Left",
+                        "Speaker", "Speaker1 Right",
+                        "Speaker", "Speaker2 Left",
+                        "Speaker", "Speaker2 Right";
+        audio-routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
+                        "SPDIFOUT IN 0", "FRDDR_A OUT 3",
+                        "TDM_C Playback", "TDMOUT_C OUT",
+                        "TDMIN_A IN 2", "TDM_C Capture",
+                        "TDMIN_A IN 5", "TDM_C Loopback",
+                        "TODDR_A IN 0", "TDMIN_A OUT",
+                        "Lineout", "Lineout AOUTL",
+                        "Lineout", "Lineout AOUTR",
+                        "Speaker1 Left", "SPK1 OUT_A",
+                        "Speaker2 Left", "SPK2 OUT_A",
+                        "Speaker1 Right", "SPK1 OUT_B",
+                        "Speaker2 Right", "SPK2 OUT_B",
+                        "Linein AINL", "Linein",
+                        "Linein AINR", "Linein";
+
+        dai-link-0 {
+            sound-dai = <&frddr_a>;
+        };
+
+        dai-link-1 {
+            sound-dai = <&toddr_a>;
+        };
+
+        dai-link-2 {
+            sound-dai = <&tdmif_c>;
+            dai-format = "i2s";
+            dai-tdm-slot-tx-mask-2 = <1 1>;
+            dai-tdm-slot-tx-mask-3 = <1 1>;
+            dai-tdm-slot-rx-mask-1 = <1 1>;
+            mclk-fs = <256>;
+
+            codec-0 {
+                sound-dai = <&lineout>;
+            };
+
+            codec-1 {
+                sound-dai = <&speaker_amp1>;
+            };
+
+            codec-2 {
+                sound-dai = <&speaker_amp2>;
+            };
+
+            codec-3 {
+                sound-dai = <&linein>;
+            };
+        };
+
+        dai-link-3 {
+            sound-dai = <&spdifout>;
+
+            codec {
+                sound-dai = <&spdif_dit>;
+            };
+        };
+    };
-- 
2.39.1

