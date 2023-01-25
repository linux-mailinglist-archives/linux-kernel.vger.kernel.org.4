Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B55C67BFBA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbjAYWOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbjAYWO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:14:29 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117255DC36;
        Wed, 25 Jan 2023 14:14:23 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id d16-20020a4a5210000000b004f23d1aea58so38627oob.3;
        Wed, 25 Jan 2023 14:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRsSGAl2CGcYFcqgB1OeEgrNSIUIRdd1BXIPULvuyvI=;
        b=D9DiXb9c4OqE/DjkRaBlswSX3xb9MJM5R+fK31hcYMsZbukcajAfxpkPeDGU83MPVi
         D7z9kUcVJ88pcMTUF2rbBZKxgvt6zW2JE1M2O21NA0ip4z5ksphEqc35HPrXydeGNxgx
         cZ4+wCwoOya6rDNWDFmL73yk9UwnosPTwpYO+/HQiXYag9Ls0or7QYMmsIyKCy3/VElB
         Tn2LxyuMoKUe+XG6dnHGZ0DbG6mVG1P0Txy930oK+HQcRkl9bH20Q42+4ZVexLE+uM0r
         Dxo1kPSirNeDn2izauo6L9MAR230rIQoptXahDKBxTzaeQ6ycPiI8oZWq9bN8kJalwYo
         kiPA==
X-Gm-Message-State: AFqh2kqZiwNcy62m5r5Qz9mBIWUupSaZkKcFYLRHBlFYEdCxo2pl/EZe
        JbsM7t+ZDvfgMLlzgDhxUFep4o3R7g==
X-Google-Smtp-Source: AMrXdXs889ebHzWIpbHPxUkkawgOwkSLjH7nH2aak7Zb4nrjTTK9awgrKpOifPbczyp1GaTDyJjadg==
X-Received: by 2002:a4a:c189:0:b0:4f3:6e99:e6c1 with SMTP id w9-20020a4ac189000000b004f36e99e6c1mr15181059oop.4.1674684862253;
        Wed, 25 Jan 2023 14:14:22 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x1-20020a4aaa01000000b00499527def25sm2337009oom.47.2023.01.25.14.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 14:14:21 -0800 (PST)
Received: (nullmailer pid 3058167 invoked by uid 1000);
        Wed, 25 Jan 2023 22:14:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: input: azoteq: Fix differing types
Date:   Wed, 25 Jan 2023 16:14:16 -0600
Message-Id: <20230125221416.3058051-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'azoteq,ati-base' and 'azoteq,thresh' properties are defined in multiple
bindings, but have differing types defined. Both 'uint32' and
'uint32-array' are used. Unify these to use 'uint32-array' everywhere.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/input/azoteq,iqs7222.yaml        | 12 ++++---
 .../devicetree/bindings/input/iqs269a.yaml    | 34 +++++++++++--------
 .../devicetree/bindings/input/iqs626a.yaml    | 12 ++++---
 3 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml b/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
index 9ddba7f2e7aa..f2382a56884d 100644
--- a/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
+++ b/Documentation/devicetree/bindings/input/azoteq,iqs7222.yaml
@@ -354,10 +354,11 @@ patternProperties:
         description: Specifies the channel's ATI target.
 
       azoteq,ati-base:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        multipleOf: 16
-        minimum: 0
-        maximum: 496
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        items:
+          - multipleOf: 16
+            minimum: 0
+            maximum: 496
         description: Specifies the channel's ATI base.
 
       azoteq,ati-mode:
@@ -440,7 +441,8 @@ patternProperties:
               slider gesture).
 
           azoteq,thresh:
-            $ref: /schemas/types.yaml#/definitions/uint32
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            maxItems: 1
             description:
               Specifies the threshold for the event. Valid entries range from
               0-127 and 0-255 for proximity and touch events, respectively.
diff --git a/Documentation/devicetree/bindings/input/iqs269a.yaml b/Documentation/devicetree/bindings/input/iqs269a.yaml
index 3c430d38594f..4fa20f0f6847 100644
--- a/Documentation/devicetree/bindings/input/iqs269a.yaml
+++ b/Documentation/devicetree/bindings/input/iqs269a.yaml
@@ -334,9 +334,10 @@ patternProperties:
           3: Full
 
       azoteq,ati-base:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [75, 100, 150, 200]
-        default: 100
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        items:
+          - enum: [75, 100, 150, 200]
+            default: 100
         description: Specifies the channel's ATI base.
 
       azoteq,ati-target:
@@ -391,10 +392,11 @@ patternProperties:
 
         properties:
           azoteq,thresh:
-            $ref: /schemas/types.yaml#/definitions/uint32
-            minimum: 0
-            maximum: 255
-            default: 10
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            items:
+              - minimum: 0
+                maximum: 255
+                default: 10
             description: Specifies the threshold for the event.
 
           linux,code: true
@@ -408,10 +410,11 @@ patternProperties:
 
         properties:
           azoteq,thresh:
-            $ref: /schemas/types.yaml#/definitions/uint32
-            minimum: 0
-            maximum: 255
-            default: 8
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            items:
+              - minimum: 0
+                maximum: 255
+                default: 8
             description: Specifies the threshold for the event.
 
           azoteq,hyst:
@@ -432,10 +435,11 @@ patternProperties:
 
         properties:
           azoteq,thresh:
-            $ref: /schemas/types.yaml#/definitions/uint32
-            minimum: 0
-            maximum: 255
-            default: 26
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            items:
+              - minimum: 0
+                maximum: 255
+                default: 26
             description: Specifies the threshold for the event.
 
           azoteq,hyst:
diff --git a/Documentation/devicetree/bindings/input/iqs626a.yaml b/Documentation/devicetree/bindings/input/iqs626a.yaml
index 7a27502095f3..dbd63d48605c 100644
--- a/Documentation/devicetree/bindings/input/iqs626a.yaml
+++ b/Documentation/devicetree/bindings/input/iqs626a.yaml
@@ -234,8 +234,9 @@ patternProperties:
           about the available RUI options.
 
       azoteq,ati-base:
-        $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [75, 100, 150, 200]
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        items:
+          - enum: [75, 100, 150, 200]
         description:
           Specifies the channel's ATI base. The default value is a function
           of the channel and the device's RUI.
@@ -475,9 +476,10 @@ patternProperties:
 
         properties:
           azoteq,thresh:
-            $ref: /schemas/types.yaml#/definitions/uint32
-            minimum: 0
-            maximum: 255
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            items:
+              - minimum: 0
+                maximum: 255
             description: Specifies the threshold for the event.
 
           azoteq,hyst:
-- 
2.39.0

