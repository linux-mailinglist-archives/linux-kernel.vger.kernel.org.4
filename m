Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4D9660144
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 14:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjAFNbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 08:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbjAFNaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:30:30 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3946D76822;
        Fri,  6 Jan 2023 05:30:25 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id D0C214000B;
        Fri,  6 Jan 2023 13:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673011824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fwN9f1Uf9OnuRKb5i5JlqxFqzREU6PwCAerriE9fsNU=;
        b=B832sqgAaoSwHkU07+7/0+oJEu8BXJTq9OItkXRSgTypGSyfXDgbQH4GmAKHmr1N85oQB6
        NH+vmxoj6O4urHmiQvwyQfy+pjwxjZDt9bdf+pJPP0aboYNr2BGR+cWL94QTFY4OhYMaml
        NgXr2s+tjaELZLpaLOSfaHpG7RF17nG3kCD4utFNG5nLh+fLt+JPQIN2n6w6oRxu4YC5sA
        tWEsoTKJuQTk5Ux52HmWGdKnt921yBjwk9j8i/gO4jAdDwhD0hM4cbWbkOPgDuOo3qsfzu
        E8oF1yXrFhXq4p6l9CUUIJ8z3dG1XOoptM21oXtsLzjqGKyVq63S7Xx08BaWEA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 08/10] dt-bindings: sound: Add support for QMC audio
Date:   Fri,  6 Jan 2023 14:29:49 +0100
Message-Id: <20230106132951.392271-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230106132951.392271-1-herve.codina@bootlin.com>
References: <20230106132951.392271-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMC (QUICC mutichannel controller) is a controller
present in some PowerQUICC SoC such as MPC885.
The QMC audio is an ASoC component that uses the QMC
controller to transfer the audio data.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/sound/fsl,qmc-audio.yaml         | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml b/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
new file mode 100644
index 000000000000..b3774be36c19
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,qmc-audio.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,qmc-audio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QMC audio
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description: |
+  The QMC audio is an ASoC component which uses QMC (QUICC Multichannel
+  Controller) channels to transfer the audio data.
+  It provides as many DAI as the number of QMC channel used.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,qmc-audio
+
+  '#address-cells':
+    const: 1
+  '#size-cells':
+    const: 0
+  '#sound-dai-cells':
+    const: 1
+
+patternProperties:
+  "^dai@([0-9]|[1-5][0-9]|6[0-3])$":
+    description:
+      A DAI managed by this controller
+    type: object
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 63
+        description:
+          The DAI number
+
+      qmc-chan:
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        description: phandle to the QMC channel
+        maxItems: 1
+
+    required:
+      - reg
+      - qmc-chan
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+  - '#sound-dai-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    qmc_audio: qmc_audio {
+        compatible = "fsl,qmc-audio";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #sound-dai-cells = <1>;
+        dai@16 {
+            reg = <16>;
+            qmc-chan = <&scc_qmc 16>;
+        };
+        dai@17 {
+            reg = <17>;
+            qmc-chan = <&scc_qmc 17>;
+        };
+    };
+
+    sound {
+        compatible = "simple-audio-card";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        simple-audio-card,dai-link@0 {
+            reg = <0>;
+            format = "dsp_b";
+            cpu {
+                sound-dai = <&qmc_audio 16>;
+            };
+            codec {
+                sound-dai = <&codec1>;
+                dai-tdm-slot-num = <4>;
+                dai-tdm-slot-width = <8>;
+                /* TS 3, 5, 7, 9 */
+                dai-tdm-slot-tx-mask = <0 0 0 1 0 1 0 1 0 1>;
+                dai-tdm-slot-rx-mask = <0 0 0 1 0 1 0 1 0 1>;
+            };
+        };
+        simple-audio-card,dai-link@1 {
+            reg = <1>;
+            format = "dsp_b";
+            cpu {
+                sound-dai = <&qmc_audio 17>;
+            };
+            codec {
+                sound-dai = <&codec2>;
+                dai-tdm-slot-num = <4>;
+                dai-tdm-slot-width = <8>;
+                /* TS 2, 4, 6, 8 */
+                dai-tdm-slot-tx-mask = <0 0 1 0 1 0 1 0 1>;
+                dai-tdm-slot-rx-mask = <0 0 1 0 1 0 1 0 1>;
+            };
+        };
+    };
-- 
2.38.1

