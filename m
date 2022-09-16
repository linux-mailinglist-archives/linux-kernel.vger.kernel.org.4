Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6C55BAF58
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiIPO0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiIPOZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:25:55 -0400
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A64B2CEC;
        Fri, 16 Sep 2022 07:25:54 -0700 (PDT)
Received: from robin.home.jannau.net (unknown [91.200.110.112])
        by soltyk.jannau.net (Postfix) with ESMTPSA id 8485A26F07A;
        Fri, 16 Sep 2022 16:25:52 +0200 (CEST)
From:   Janne Grunau <j@jannau.net>
To:     asahi@lists.linux.dev
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/10] dt-bindings: apple,aic2: Add CPU PMU per-cpu pseudo-interrupts
Date:   Fri, 16 Sep 2022 16:25:42 +0200
Message-Id: <20220916142550.269905-3-j@jannau.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220916142550.269905-1-j@jannau.net>
References: <20220916142550.269905-1-j@jannau.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Advertise the two pseudo-interrupts that tied to the two PMU
flavours present in the Apple M1 Pro/Max/Ultra SoC.

We choose the expose two different pseudo-interrupts to the OS
as the e-core PMU is obviously different from the p-core one,
effectively presenting two different devices.

Imported from "apple,aic".

Signed-off-by: Janne Grunau <j@jannau.net>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Marc Zyngier <maz@kernel.org>

---

Changes in v1:
- Added Krzysztof's and Marc's ack


---
 .../interrupt-controller/apple,aic2.yaml      | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
index 47a78a167aba..06948c0e36a5 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic2.yaml
@@ -69,6 +69,35 @@ properties:
   power-domains:
     maxItems: 1
 
+  affinities:
+    type: object
+    additionalProperties: false
+    description:
+      FIQ affinity can be expressed as a single "affinities" node,
+      containing a set of sub-nodes, one per FIQ with a non-default
+      affinity.
+    patternProperties:
+      "^.+-affinity$":
+        type: object
+        additionalProperties: false
+        properties:
+          apple,fiq-index:
+            description:
+              The interrupt number specified as a FIQ, and for which
+              the affinity is not the default.
+            $ref: /schemas/types.yaml#/definitions/uint32
+            maximum: 5
+
+          cpus:
+            $ref: /schemas/types.yaml#/definitions/phandle-array
+            description:
+              Should be a list of phandles to CPU nodes (as described in
+              Documentation/devicetree/bindings/arm/cpus.yaml).
+
+        required:
+          - apple,fiq-index
+          - cpus
+
 required:
   - compatible
   - '#interrupt-cells'
-- 
2.35.1

