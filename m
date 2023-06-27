Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328BA73F4EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjF0Gx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjF0Gxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:53:38 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7571BF8;
        Mon, 26 Jun 2023 23:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1687848817;
  x=1719384817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fchfhPBiXhNezCICPouexBXBWF7mmavFQ5pd/NEGqXA=;
  b=IjeOpBV0fc0KdbU/gmzX0z33VPQfCM6OZKFvMJAKf7r46DLoozSMdehd
   A1f2Gz7C+TfBPQGDG100Avy1YC1HVcEa+yUDYs/O7Gv3rXCDhfp278xul
   z71tDIV95K8vgXtwrx/sYKK7Vw7+21rxt/P6qMGREbBGneZITofYqjwPN
   sbwg5jlLimH65+trYuU3awXstTHGO2hqHFr1L1SfO+2eaWuUCHh/If1Ui
   C1FKs58pwgNDqtRLK0G0xWtIb7Zp4l4ryjySaROpJrmMfASshqwdbC8X+
   BATjhG8iNWhR4et0m1ZmPLge4vtenkLiizgLAxEs8xVS0r5eIKDz9y78c
   Q==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <dmitry.torokhov@gmail.com>
CC:     <jiriv@axis.com>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v4 1/2] dt-bindings: input: microchip,cap11xx: add advanced sensitivity settings
Date:   Tue, 27 Jun 2023 08:53:15 +0200
Message-ID: <20230627065316.1065911-2-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627065316.1065911-1-jiriv@axis.com>
References: <20230627065316.1065911-1-jiriv@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for advanced sensitivity settings and signal guard feature.

Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
---
 .../bindings/input/microchip,cap11xx.yaml     | 77 +++++++++++++++++--
 1 file changed, 72 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 5fa625b5c5fb..b69dac1fba0e 100644
--- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
+++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
@@ -45,13 +45,13 @@ properties:
       Enables the Linux input system's autorepeat feature on the input device.
 
   linux,keycodes:
-    minItems: 6
-    maxItems: 6
+    minItems: 3
+    maxItems: 8
     description: |
       Specifies an array of numeric keycode values to
       be used for the channels. If this property is
       omitted, KEY_A, KEY_B, etc are used as defaults.
-      The array must have exactly six entries.
+      The number of entries must correspond to the number of channels.
 
   microchip,sensor-gain:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -70,6 +70,55 @@ properties:
       open drain. This property allows using the active
       high push-pull output.
 
+  microchip,sensitivity-delta-sense:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 32
+    enum: [1, 2, 4, 8, 16, 32, 64, 128]
+    description:
+      Optional parameter. Controls the sensitivity multiplier of a touch detection.
+      At the more sensitive settings, touches are detected for a smaller delta
+      capacitance corresponding to a “lighter” touch.
+
+  microchip,signal-guard:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    maxItems: 8
+    items:
+      minimum: 0
+      maximum: 1
+    description: |
+      Optional parameter supported only for CAP129x.
+      0 - off
+      1 - on
+      The signal guard isolates the signal from virtual grounds.
+      If enabled then the behavior of the channel is changed to signal guard.
+      The number of entries must correspond to the number of channels.
+
+  microchip,input-treshold:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    maxItems: 8
+    items:
+      minimum: 0
+      maximum: 127
+    description:
+      Optional parameter. Specifies the delta threshold that is used to
+      determine if a touch has been detected.
+      The number of entries must correspond to the number of channels.
+
+  microchip,calib-sensitivity:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    maxItems: 8
+    items:
+      minimum: 1
+      maximum: 4
+    description:
+      Optional parameter supported only for CAP129x. Specifies an array of
+      numeric values that controls the gain used by the calibration routine to
+      enable sensor inputs to be more sensitive for proximity detection.
+      The number of entries must correspond to the number of channels.
+
 patternProperties:
   "^led@[0-7]$":
     type: object
@@ -98,10 +147,23 @@ allOf:
         compatible:
           contains:
             enum:
-              - microchip,cap1106
+              - microchip,cap1188
     then:
       patternProperties:
-        "^led@[0-7]$": false
+        "^led@[0-7]$": true
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - microchip,cap1293
+              - microchip,cap1298
+
+    then:
+      properties:
+        microchip,signal-guard: true
+        microchip,calib-sensitivity: true
 
 required:
   - compatible
@@ -122,6 +184,11 @@ examples:
         reg = <0x28>;
         autorepeat;
         microchip,sensor-gain = <2>;
+        microchip,sensitivity-delta-sense = <16>;
+
+        microchip,signal-guard = <0>, <0>, <0>, <0>, <0>, <0>;
+        microchip,input-treshold = <21>, <18>, <46>, <46>, <46>, <21>;
+        microchip,calib-sensitivity = <1>, <2>, <2>, <1>, <1>, <2>;
 
         linux,keycodes = <103>,	/* KEY_UP */
                          <106>,	/* KEY_RIGHT */
-- 
2.25.1

