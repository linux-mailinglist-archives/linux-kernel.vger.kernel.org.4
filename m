Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE70B6E2CF2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDNXi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjDNXix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:38:53 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA79526E;
        Fri, 14 Apr 2023 16:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1681515532;
  x=1713051532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SpLMjeGM/opNypIBwbbL34Zq2CgvgZH99FHYABysyCM=;
  b=k7Nfc/x/6cRH72h9fg7JCb+jKF4vbeCGPsO/7eWfv6FTt0uw0aO4mgJI
   yoLZO3mF98guuvaEZRIOIJD7HoQElDo8ptaYzV37AmyeyJYhY5EtAGm41
   Vgv0FIGZtlzsXHYnxB35sEPN0An6wninEJh14HSAZAcs6oQcCNj5TF1JQ
   FykzngC757S8BVPsaU9ahY6Dq8iha3DgBBc+O0z/x76kWQCAizS4I1Psl
   oOYRAjcoYEm+Fct5sBuvH04tKeDuWLgaV6/MrieeFsbXW4OjYG9CVsGJj
   IJCq+mmsr3e2mTCGRWu5hvjEF7WO6pqZA9SqQ3LhElqvGSQDvIIZ7n58H
   A==;
From:   Jiri Valek - 2N <jiriv@axis.com>
To:     <dmitry.torokhov@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <jiriv@axis.com>, <devicetree@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/2] dt-bindings: input: microchip,cap11xx: add advanced sensitivity settings
Date:   Sat, 15 Apr 2023 01:38:14 +0200
Message-ID: <20230414233815.4004526-2-jiriv@axis.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414233815.4004526-1-jiriv@axis.com>
References: <20230414233815.4004526-1-jiriv@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for advanced sensitivity settings and signal guard feature.

Signed-off-by: Jiri Valek - 2N <jiriv@axis.com>
---
 .../bindings/input/microchip,cap11xx.yaml     | 64 ++++++++++++++++++-
 1 file changed, 61 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 5fa625b5c5fb..08e28226a164 100644
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
@@ -70,6 +70,58 @@ properties:
       open drain. This property allows using the active
       high push-pull output.
 
+  microchip,sensitivity-delta-sense:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 32
+    enum: [1, 2, 4, 8, 16, 32, 64, 128]
+    description: |
+      Optional parameter. Controls the sensitivity multiplier of a touch detection.
+      At the more sensitive settings, touches are detected for a smaller delta
+      capacitance corresponding to a “lighter” touch.
+
+  microchip,sensitivity-base-shift:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 256
+    enum: [1, 2, 4, 8, 16, 32, 64, 128, 256]
+    description: |
+      Optional parameter. Controls data scaling factor.
+      The higher the value of these bits, the larger the range and the lower
+      the resolution of the data presented. These settings will not affect
+      touch detection or sensitivity.
+
+  microchip,signal-guard:
+    minItems: 3
+    maxItems: 8
+    enum: [0, 1]
+    default: 0
+    description: |
+      Optional parameter supported only for CAP129x.
+      The signal guard isolates the signal from virtual grounds.
+      If enabled then the behavior of the channel is changed to signal guard.
+      The number of entries must correspond to the number of channels.
+
+  microchip,input-treshold:
+    minItems: 3
+    maxItems: 8
+    minimum: 0
+    maximum: 127
+    default: 64
+    description: |
+      Optional parameter. Specifies the delta threshold that is used to
+      determine if a touch has been detected.
+      The number of entries must correspond to the number of channels.
+
+  microchip,calib-sensitivity:
+    minItems: 3
+    maxItems: 8
+    enum: [1, 2, 4]
+    default: 1
+    description: |
+      Optional parameter supported only for CAP129x. Specifies an array of
+      numeric values that controls the gain used by the calibration routine to
+      enable sensor inputs to be more sensitive for proximity detection.
+      The number of entries must correspond to the number of channels.
+
 patternProperties:
   "^led@[0-7]$":
     type: object
@@ -122,6 +174,12 @@ examples:
         reg = <0x28>;
         autorepeat;
         microchip,sensor-gain = <2>;
+        microchip,sensitivity-delta-sense = <16>;
+        microchip,sensitivity-base-shift = <128>;
+
+        microchip,signal-guard = <0>, <0>, <0>, <0>, <0>, <0>;
+        microchip,input-treshold = <21>, <18>, <46>, <46>, <46>, <21>;
+        microchip,calib-sensitivityj = <1>, <2>, <2>, <1>, <1>, <2>;
 
         linux,keycodes = <103>,	/* KEY_UP */
                          <106>,	/* KEY_RIGHT */
-- 
2.25.1

