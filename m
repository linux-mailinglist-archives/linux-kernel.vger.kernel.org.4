Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6F65F15C1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiI3WGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbiI3WGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:06:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D599FDD34B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:06:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gf8so2826839pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=qhJ10BC+9JqsECi1vQaUiPXWyfUAkATX0JrVFr73hqA=;
        b=OJKtn5fwi4j+Xi77j0kc1NZ/k6lGTAPs76KCaUGA21EB4Vo3yrLbG02Rp4mEE+vZ7f
         E7htBrnN3dw5MNu+MwzKArvHGcGO0sqqxLpuJhfAiROXa0y7j5RbkbTnyt5dzI0hae0L
         vJcZbU8Zg/ALBiuvL+BKwkrkg0g0damKxVKB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qhJ10BC+9JqsECi1vQaUiPXWyfUAkATX0JrVFr73hqA=;
        b=H9BQUoWt7W6LsPHiWb76yCxzDlvdhnnuwDsn7MfyHwvEHye7RByIKMZSTTyFqwtkiG
         kyZAVLE50Cv4aEdzm7vHLassC4FAjW3UUN0R31iHyul9G5C8pz8obl4uBYpxPwZmTIwE
         dA51zi1R3k8SMVwuLNApFhkZsOF+ELPhNXftuJeHwsW3eI+jRvvXgEQQWjiGAb9aM6OW
         iwvUOVXy/VM0XPjWkdotUu8zvhM+PDufshUgFNv3bt2IIKilCm7wJfAwMJ5eDHRyUT9r
         2WTzB+kcSAGe6Iznd3LZGTazfKzvrmk9Mazjz22XPwmf7kDOrwPPtVG9J9RHCXVqhi+k
         nm2g==
X-Gm-Message-State: ACrzQf1RHjB1EWoA45QwJoevPOV+w1tip4pIi9Iy/Oi+vCFiZyrlcP/5
        S9F1vAiBxEERvl4l7HI2gTxf5g==
X-Google-Smtp-Source: AMsMyM41rQ14CGsbdypcJITBFcT6yPNyM8gK6tqItOMAUX+ifty7tpKLBB6IpuPi/tDQ3vrBV1CdEw==
X-Received: by 2002:a17:902:f683:b0:176:cc02:ce83 with SMTP id l3-20020a170902f68300b00176cc02ce83mr10754262plg.88.1664575573546;
        Fri, 30 Sep 2022 15:06:13 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:9d:2:ab9d:610e:ee54:d4ca])
        by smtp.gmail.com with ESMTPSA id f91-20020a17090a706400b001facf455c91sm5769364pjk.21.2022.09.30.15.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 15:06:12 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/4 v5] dt-bindings: memory: Factor out common properties of LPDDR bindings
Date:   Fri, 30 Sep 2022 15:06:03 -0700
Message-Id: <20220930220606.303395-1-jwerner@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings for different LPDDR versions mostly use the same kinds of
properties, so in order to reduce duplication when we're adding support
for more versions, this patch creates a new lpddr-props subschema that
can be referenced by the others to define these common parts. (This will
consider a few smaller I/O width and density numbers "legal" for LPDDR3
that are usually not used there, but this should be harmless.)

Signed-off-by: Julius Werner <jwerner@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../ddr/jedec,lpddr-props.yaml                | 52 +++++++++++++++++++
 .../memory-controllers/ddr/jedec,lpddr2.yaml  | 40 ++------------
 .../memory-controllers/ddr/jedec,lpddr3.yaml  | 32 ++----------
 3 files changed, 60 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml

Changelog:

- v2:
  - removed minItems
  - reordered io-width enum from lowest to highest
  - moved `$ref` below `mainainers`
  - removed part about undeprecating manufacturer-id
- v3:
  - no changes
- v4:
  - removed quotes from schema $ref strings
- v5:
  - updated acked-by list

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
new file mode 100644
index 00000000000000..02700ac3c387ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,lpddr-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common properties for LPDDR types
+
+description:
+  Different LPDDR types generally use the same properties and only differ in the
+  range of legal values for each. This file defines the common parts that can be
+  reused for each type.
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  revision-id:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Revision IDs read from Mode Register 6 and 7. One byte per uint32 cell (i.e. <MR6 MR7>).
+    maxItems: 2
+    items:
+      minimum: 0
+      maximum: 255
+
+  density:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Density in megabits of SDRAM chip. Decoded from Mode Register 8.
+    enum:
+      - 64
+      - 128
+      - 256
+      - 512
+      - 1024
+      - 2048
+      - 4096
+      - 8192
+      - 16384
+      - 32768
+
+  io-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      IO bus width in bits of SDRAM chip. Decoded from Mode Register 8.
+    enum:
+      - 8
+      - 16
+      - 32
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
index 9d78f140609b6c..e5e15d288d89b2 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr2.yaml
@@ -9,6 +9,9 @@ title: LPDDR2 SDRAM compliant to JEDEC JESD209-2
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
+allOf:
+  - $ref: jedec,lpddr-props.yaml#
+
 properties:
   compatible:
     oneOf:
@@ -41,41 +44,6 @@ properties:
       Property is deprecated, use revision-id instead.
     deprecated: true
 
-  revision-id:
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-    description: |
-      Revision IDs read from Mode Register 6 and 7. One byte per uint32 cell (i.e. <MR6 MR7>).
-    minItems: 2
-    maxItems: 2
-    items:
-      minimum: 0
-      maximum: 255
-
-  density:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Density in megabits of SDRAM chip. Obtained from device datasheet.
-    enum:
-      - 64
-      - 128
-      - 256
-      - 512
-      - 1024
-      - 2048
-      - 4096
-      - 8192
-      - 16384
-      - 32768
-
-  io-width:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      IO bus width in bits of SDRAM chip. Obtained from device datasheet.
-    enum:
-      - 32
-      - 16
-      - 8
-
   tRRD-min-tck:
     $ref: /schemas/types.yaml#/definitions/uint32
     maximum: 16
@@ -168,7 +136,7 @@ required:
   - density
   - io-width
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
index 48908a19473c3f..0f7ab51842ae09 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr3.yaml
@@ -9,6 +9,9 @@ title: LPDDR3 SDRAM compliant to JEDEC JESD209-3
 maintainers:
   - Krzysztof Kozlowski <krzk@kernel.org>
 
+allOf:
+  - $ref: jedec,lpddr-props.yaml#
+
 properties:
   compatible:
     items:
@@ -20,24 +23,6 @@ properties:
     const: 1
     deprecated: true
 
-  density:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      Density in megabits of SDRAM chip.
-    enum:
-      - 4096
-      - 8192
-      - 16384
-      - 32768
-
-  io-width:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description: |
-      IO bus width in bits of SDRAM chip.
-    enum:
-      - 32
-      - 16
-
   manufacturer-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
@@ -45,15 +30,6 @@ properties:
       deprecated, manufacturer should be derived from the compatible.
     deprecated: true
 
-  revision-id:
-    $ref: /schemas/types.yaml#/definitions/uint32-array
-    minItems: 2
-    maxItems: 2
-    items:
-      maximum: 255
-    description: |
-      Revision value of SDRAM chip read from Mode Registers 6 and 7.
-
   '#size-cells':
     const: 0
     deprecated: true
@@ -206,7 +182,7 @@ required:
   - density
   - io-width
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.31.0

