Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E6E67A596
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjAXWUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjAXWUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:20:33 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6DC37F2F;
        Tue, 24 Jan 2023 14:20:32 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id g2-20020a9d6b02000000b006864bf5e658so10110446otp.1;
        Tue, 24 Jan 2023 14:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eez1m+PXfOfMtBkO1erQPzslo6stvsXK/McJNzS+bhE=;
        b=Y0EqZxzKKFrunEnDMpbyNm9vqKMsPBH3WCDPHj9UnR35f1+8069rQgItBroZcZH5Zc
         gAdtnLWgyPNFCj/rLHCKlzoXoJZ9/eMT49qFr6Zvs/DauhYOYkYnEbRuafQILXsS9Stv
         ZjkeDFoafh/sLe8R78IDx4v8Y0sMb62vxDFhUnsw7do8Mx0+fqVE2kt+/ogmlt2AzKga
         q4Y+xYsdvkREY0dSayC2rBbZ0H7/GFhUpSjz1hwc4VA3qX28PiS58pB/5ojzYC93/NAS
         33xzVijwY/vnQ+O7OfxrnDa0GL5S0A9+osdu2Efasqu8CM+69muvnpeZx7h16u5wAB/L
         Zotw==
X-Gm-Message-State: AFqh2kobLE5Lb15AEnouuCj3VHum8ArM29u1yOYNSPRK/pacYyRbXPHw
        iOFVfJjmmOC7GFXcFGeO5A==
X-Google-Smtp-Source: AMrXdXsQOGXLvDUlDyfIhPA3kuz6+QbLmoFpTLE7cXamFILL4fYDaWa2Qf1wZU85+DoB6HyjAsx7SQ==
X-Received: by 2002:a05:6830:244d:b0:675:410e:7533 with SMTP id x13-20020a056830244d00b00675410e7533mr16096069otr.9.1674598831857;
        Tue, 24 Jan 2023 14:20:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a18-20020a9d74d2000000b00684eaf9018csm1449579otl.34.2023.01.24.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 14:20:31 -0800 (PST)
Received: (nullmailer pid 316282 invoked by uid 1000);
        Tue, 24 Jan 2023 22:20:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: firmware: arm,scmi: Restrict protocol child node properties
Date:   Tue, 24 Jan 2023 16:20:23 -0600
Message-Id: <20230124222023.316089-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCMI protocol child nodes are missing any constraints on unknown
properties. Specifically, either 'unevaluatedProperties' or
'additionalProperties' is needed. The current structure with a regex
match for all child nodes doesn't work for this purpose, so let's move
the common properties '$defs' entry which each specific protocol node
can reference and set 'unevaluatedProperties: false'.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/firmware/arm,scmi.yaml           | 43 ++++++++++++++-----
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 176796931a22..2f7c51c75e85 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -100,7 +100,9 @@ properties:
       Channel specifier required when using OP-TEE transport.
 
   protocol@11:
-    type: object
+    $ref: '#/$defs/protocol-node'
+    unevaluatedProperties: false
+
     properties:
       reg:
         const: 0x11
@@ -112,7 +114,9 @@ properties:
       - '#power-domain-cells'
 
   protocol@13:
-    type: object
+    $ref: '#/$defs/protocol-node'
+    unevaluatedProperties: false
+
     properties:
       reg:
         const: 0x13
@@ -124,7 +128,9 @@ properties:
       - '#clock-cells'
 
   protocol@14:
-    type: object
+    $ref: '#/$defs/protocol-node'
+    unevaluatedProperties: false
+
     properties:
       reg:
         const: 0x14
@@ -136,7 +142,9 @@ properties:
       - '#clock-cells'
 
   protocol@15:
-    type: object
+    $ref: '#/$defs/protocol-node'
+    unevaluatedProperties: false
+
     properties:
       reg:
         const: 0x15
@@ -148,7 +156,9 @@ properties:
       - '#thermal-sensor-cells'
 
   protocol@16:
-    type: object
+    $ref: '#/$defs/protocol-node'
+    unevaluatedProperties: false
+
     properties:
       reg:
         const: 0x16
@@ -160,20 +170,31 @@ properties:
       - '#reset-cells'
 
   protocol@17:
-    type: object
+    $ref: '#/$defs/protocol-node'
+    unevaluatedProperties: false
+
     properties:
       reg:
         const: 0x17
 
       regulators:
         type: object
+        additionalProperties: false
         description:
           The list of all regulators provided by this SCMI controller.
 
+        properties:
+          '#address-cells':
+            const: 1
+
+          '#size-cells':
+            const: 0
+
         patternProperties:
-          '^regulators@[0-9a-f]+$':
+          '^regulator@[0-9a-f]+$':
             type: object
             $ref: "../regulator/regulator.yaml#"
+            unevaluatedProperties: false
 
             properties:
               reg:
@@ -184,15 +205,17 @@ properties:
               - reg
 
   protocol@18:
-    type: object
+    $ref: '#/$defs/protocol-node'
+    unevaluatedProperties: false
+
     properties:
       reg:
         const: 0x18
 
 additionalProperties: false
 
-patternProperties:
-  '^protocol@[0-9a-f]+$':
+$defs:
+  protocol-node:
     type: object
     description:
       Each sub-node represents a protocol supported. If the platform
-- 
2.39.0

