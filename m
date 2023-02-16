Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA641699611
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 14:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBPNnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 08:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjBPNnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 08:43:00 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F75483CC;
        Thu, 16 Feb 2023 05:42:54 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id B532B20002;
        Thu, 16 Feb 2023 13:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1676554972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2XcpzqiuXoodLoCSyJGYr9JR/UvrrToFSQtYF8ypm80=;
        b=dQl0exTTqR4hKMOozFwI8nHJtRGo5u4kMARC+XXCxAdOqBsNtpRjGzWVPdjue0xbmFUqaf
        KZOt2KqCf6xc9y7MSxS3QAoTHER7tSEyubLcLvLPViIA1g6SdFs+yyDv3ibNgSBtFYWwPz
        lV7NTax3bO/Stg60eadmHYACoIZmjfA5XUHjCQeCcOMxqco5EMpoL2PvN04dqmm3wG0Q/Y
        PoAP75uA4MaHwQx6JAbrHdKFejj/kQXJWwSoIPj6iOkmaVy5bbrbxsellI7Bnm0HW/MhuN
        RfDyLdGWMADQFNwnLsfEy74CubsNgMU596nz6ty/opYSI9/OKz5+FsmKzOmUaQ==
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
Subject: [PATCH v5 05/10] dt-bindings: soc: fsl: cpm_qe: Add QMC controller
Date:   Thu, 16 Feb 2023 14:42:21 +0100
Message-Id: <20230216134226.1692107-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216134226.1692107-1-herve.codina@bootlin.com>
References: <20230216134226.1692107-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the QMC (QUICC Multichannel Controller)
available in some PowerQUICC SoC such as MPC885 or MPC866.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml      | 172 ++++++++++++++++++
 1 file changed, 172 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml

diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
new file mode 100644
index 000000000000..cb3994c412dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
@@ -0,0 +1,172 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PowerQUICC CPM QUICC Multichannel Controller (QMC)
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+description:
+  The QMC (QUICC Multichannel Controller) emulates up to 64 channels within one
+  serial controller using the same TDM physical interface routed from TSA.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,mpc885-scc-qmc
+          - fsl,mpc866-scc-qmc
+      - const: fsl,cpm1-scc-qmc
+
+  reg:
+    items:
+      - description: SCC (Serial communication controller) register base
+      - description: SCC parameter ram base
+      - description: Dual port ram base
+
+  reg-names:
+    items:
+      - const: scc_regs
+      - const: scc_pram
+      - const: dpram
+
+  interrupts:
+    maxItems: 1
+    description: SCC interrupt line in the CPM interrupt controller
+
+  fsl,tsa-serial:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to TSA node
+          - enum: [1, 2, 3]
+            description: |
+              TSA serial interface (dt-bindings/soc/fsl,tsa.h defines these
+              values)
+               - 1: SCC2
+               - 2: SCC3
+               - 3: SCC4
+    description:
+      Should be a phandle/number pair. The phandle to TSA node and the TSA
+      serial interface to use.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  '#fsl,chan-cells':
+    $ref: /schemas/types.yaml#/definitions/uint32
+    const: 1
+    description:
+      QMC consumers that use a phandle to QMC need to pass the channel number
+      with this phandle.
+      For instance "fsl,qmc-chan = <&qmc 16>;".
+
+patternProperties:
+  '^channel@([0-9]|[1-5][0-9]|6[0-3])$':
+    description:
+      A channel managed by this controller
+    type: object
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 63
+        description:
+          The channel number
+
+      fsl,operational-mode:
+        $ref: /schemas/types.yaml#/definitions/string
+        enum: [transparent, hdlc]
+        default: transparent
+        description: |
+          The channel operational mode
+            - hdlc: The channel handles HDLC frames
+            - transparent: The channel handles raw data without any processing
+
+      fsl,reverse-data:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          The bit order as seen on the channels is reversed,
+          transmitting/receiving the MSB of each octet first.
+          This flag is used only in 'transparent' mode.
+
+      fsl,tx-ts-mask:
+        $ref: /schemas/types.yaml#/definitions/uint64
+        description:
+          Channel assigned Tx time-slots within the Tx time-slots routed by the
+          TSA to this cell.
+
+      fsl,rx-ts-mask:
+        $ref: /schemas/types.yaml#/definitions/uint64
+        description:
+          Channel assigned Rx time-slots within the Rx time-slots routed by the
+          TSA to this cell.
+
+    required:
+      - reg
+      - fsl,tx-ts-mask
+      - fsl,rx-ts-mask
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - fsl,tsa-serial
+  - '#address-cells'
+  - '#size-cells'
+  - '#fsl,chan-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/fsl,tsa.h>
+
+    qmc@a60 {
+        compatible = "fsl,mpc885-scc-qmc", "fsl,cpm1-scc-qmc";
+        reg = <0xa60 0x20>,
+              <0x3f00 0xc0>,
+              <0x2000 0x1000>;
+        reg-names = "scc_regs", "scc_pram", "dpram";
+        interrupts = <27>;
+        interrupt-parent = <&CPM_PIC>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #fsl,chan-cells = <1>;
+
+        fsl,tsa-serial = <&tsa FSL_CPM_TSA_SCC4>;
+
+        channel@16 {
+            /* Ch16 : First 4 even TS from all routed from TSA */
+            reg = <16>;
+            fsl,mode = "transparent";
+            fsl,reverse-data;
+            fsl,tx-ts-mask = <0x00000000 0x000000aa>;
+            fsl,rx-ts-mask = <0x00000000 0x000000aa>;
+        };
+
+        channel@17 {
+            /* Ch17 : First 4 odd TS from all routed from TSA */
+            reg = <17>;
+            fsl,mode = "transparent";
+            fsl,reverse-data;
+            fsl,tx-ts-mask = <0x00000000 0x00000055>;
+            fsl,rx-ts-mask = <0x00000000 0x00000055>;
+        };
+
+        channel@19 {
+            /* Ch19 : 8 TS (TS 8..15) from all routed from TSA */
+            reg = <19>;
+            fsl,mode = "hdlc";
+            fsl,tx-ts-mask = <0x00000000 0x0000ff00>;
+            fsl,rx-ts-mask = <0x00000000 0x0000ff00>;
+        };
+    };
-- 
2.39.1

