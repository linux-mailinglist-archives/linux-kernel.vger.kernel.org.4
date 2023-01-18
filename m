Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC82671DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjARN03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjARNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:25:39 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFA59EE09;
        Wed, 18 Jan 2023 04:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674046363;
  x=1705582363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9tpzvI7fdZDoAPrHN+US7UGk+e/yxtX1rAxxB7G8nrs=;
  b=Iy+5CP26+TNYmwUfX0m5NAr/r09Z11LCCPN4aobXxgHRcPSxR7vic8KZ
   tYWuvLK71Du6z7TegR/4dE/T3fikMYoTgr0uKmyrpjesCts4H8JC2uBL7
   Li8Ba1JrWooLLUsJ+KMcel0TPlWgB5g0N+fn/AujQihFdHfsrVHeTYUUs
   /NLiUoFH915l91i0X/+nNCY3taUVndjIOH3UBqWcafbJ/tjv79YM+D/cE
   phw96VsabNtBz08UTAkVPTZJ8hpPWIvu7uZANxGeBoIkodtPzFgTutOFK
   8AGsq6XYngTSiCrKruMrprpkZ3xyaUFtX9l0KKeiAamf6iYsu/uJZg2S9
   Q==;
From:   Astrid Rost <astrid.rost@axis.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC:     <kernel@axis.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Astrid Rost <astrid.rost@axis.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v1 4/4] ASoC: dt-bindings: simple-card: create jack for aux_devs
Date:   Wed, 18 Jan 2023 13:52:26 +0100
Message-ID: <20230118125226.333214-5-astrid.rost@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230118125226.333214-1-astrid.rost@axis.com>
References: <20230118125226.333214-1-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add simple-card,aux-jack-types:
Array of snd_jack_type to create jack-input-event for jack devices in
aux-devs. If the setting is 0, the supported type of the device is used.
A device which has the functions set_jack and get_jack_supported_type
counts as jack device.

Signed-off-by: Astrid Rost <astrid.rost@axis.com>
---
 .../bindings/sound/simple-card.yaml           | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
index ed19899bc94b..2635b1c04fc9 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
@@ -199,6 +199,13 @@ properties:
     maxItems: 1
   simple-audio-card,mic-det-gpio:
     maxItems: 1
+  simple-audio-card,aux-jack-types:
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    description: |
+      Array of snd_jack_type to create jack-input-event for jack
+      devices in aux-devs. If the setting is 0, the supported
+      type of the device is used. A device which has the functions
+      set_jack and get_jack_supported_type counts as jack device.
 
 patternProperties:
   "^simple-audio-card,cpu(@[0-9a-f]+)?$":
@@ -498,3 +505,31 @@ examples:
             };
         };
     };
+#--------------------
+# Add a headphone and a headset mic jack,
+# which use an auxiliary jack detector e.g. via i2c.
+# The events, which should be enabled are:
+# SND_JACK_HEADPHONE = 1
+# SND_JACK_MICROPHONE = 2
+#--------------------
+  - |
+    sound {
+        compatible = "simple-audio-card";
+        simple-audio-card,widgets =
+            "Headphone", "Headphone Jack",
+            "Headset Mic", "Headset Mic Jack";
+        simple-audio-card,routing =
+            "Headphone Jack", "HPLEFT",
+            "Headphone Jack", "HPRIGHT",
+            "LEFTIN", "Headset Mic",
+            "RIGHTIN", "Headset Mic";
+        simple-audio-card,aux-devs = <&hp_jack>, <&hs_mic_jack>;
+        simple-audio-card,aux-jack-types = <1 2>;
+        simple-audio-card,cpu {
+            sound-dai = <&ssi2>;
+        };
+        simple-audio-card,codec {
+            sound-dai = <&codec>;
+            clocks = <&clocks>;
+        };
+    };
-- 
2.30.2

