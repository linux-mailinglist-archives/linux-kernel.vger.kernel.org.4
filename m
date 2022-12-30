Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26537656C26
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiL0OpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiL0OoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:44:16 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901EFBE2A;
        Tue, 27 Dec 2022 06:44:15 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BREi7L8054103;
        Tue, 27 Dec 2022 08:44:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672152247;
        bh=ZzVZ1vdhUxdDsNmsKgKE/FkegAGuC8OOwlXzFELrHco=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vnXwN/jXxoV9QAwEqfOMzY/IYiz5KRCPNQlZsq2bg/Wq+gFbBmt/i2mzE3bYp4ogq
         OVm7276pyIRhadOq5UFV+9M3jwXtHQ7n/F7sAzcZFosALB0uyFyIFvpKMrgdk9DJSN
         w/JKGFddUHVWbDra3S8pBWcZIH800Ci7FfYtnnT4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BREi7ga048261
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Dec 2022 08:44:07 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 27
 Dec 2022 08:44:07 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 27 Dec 2022 08:44:07 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BREi6tD064006;
        Tue, 27 Dec 2022 08:44:06 -0600
From:   Devarsh Thakkar <devarsht@ti.com>
To:     <andersson@kernel.org>, <devicetree@vger.kernel.org>,
        <mathieu.poirier@linaro.org>, <p.zabel@pengutronix.de>,
        <linux-remoteproc@vger.kernel.orgi>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <s-anna@ti.com>
CC:     <hnagalla@ti.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <devarsht@ti.com>
Subject: [PATCH v4 1/2] dt-bindings: remoteproc: ti: Add new compatible for AM62 SoC family
Date:   Tue, 27 Dec 2022 20:14:03 +0530
Message-ID: <20221227144404.25184-2-devarsht@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221227144404.25184-1-devarsht@ti.com>
References: <20221227144404.25184-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM62 family of devices don't have a R5F cluster, instead
they have single core DM R5F.
Add new compatible string ti,am62-r5fss to support this scenario.

When this new compatible is used don't allow cluster-mode
property usage in device-tree as this implies that there
is no R5F cluster available and only single R5F core
is present.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V2: Avoid acronyms, use "Device Manager" instead of "DM"
V3:
- Use separate if block for each compatible for ti,cluster-mode property
- Rearrange compatibles as per alphabatical order
V4: Place each enum in separate line in allOf
---
 .../bindings/remoteproc/ti,k3-r5f-rproc.yaml  | 65 ++++++++++++++-----
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
index fb9605f0655b..b1602cc42888 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
@@ -21,6 +21,9 @@ description: |
   called "Single-CPU" mode, where only Core0 is used, but with ability to use
   Core1's TCMs as well.
 
+  AM62 SoC family support a single R5F core only which runs Device Manager
+  firmware and can also be used as a remote processor with IPC communication.
+
   Each Dual-Core R5F sub-system is represented as a single DTS node
   representing the cluster, with a pair of child DT nodes representing
   the individual R5F cores. Each node has a number of required or optional
@@ -28,16 +31,20 @@ description: |
   the device management of the remote processor and to communicate with the
   remote processor.
 
+  Since AM62 SoC family only support a single core, there is no cluster-mode
+  property setting required for it.
+
 properties:
   $nodename:
     pattern: "^r5fss(@.*)?"
 
   compatible:
     enum:
+      - ti,am62-r5fss
+      - ti,am64-r5fss
       - ti,am654-r5fss
-      - ti,j721e-r5fss
       - ti,j7200-r5fss
-      - ti,am64-r5fss
+      - ti,j721e-r5fss
       - ti,j721s2-r5fss
 
   power-domains:
@@ -80,7 +87,9 @@ patternProperties:
       node representing a TI instantiation of the Arm Cortex R5F core. There
       are some specific integration differences for the IP like the usage of
       a Region Address Translator (RAT) for translating the larger SoC bus
-      addresses into a 32-bit address space for the processor.
+      addresses into a 32-bit address space for the processor. For AM62x,
+      the R5F Sub-System device node should only define one R5F child node
+      as it has only one core available.
 
       Each R5F core has an associated 64 KB of Tightly-Coupled Memory (TCM)
       internal memories split between two banks - TCMA and TCMB (further
@@ -100,10 +109,11 @@ patternProperties:
     properties:
       compatible:
         enum:
+          - ti,am62-r5f
+          - ti,am64-r5f
           - ti,am654-r5f
-          - ti,j721e-r5f
           - ti,j7200-r5f
-          - ti,am64-r5f
+          - ti,j721e-r5f
           - ti,j721s2-r5f
 
       reg:
@@ -208,19 +218,38 @@ patternProperties:
 
     unevaluatedProperties: false
 
-if:
-  properties:
-    compatible:
-      enum:
-        - ti,am64-r5fss
-then:
-  properties:
-    ti,cluster-mode:
-      enum: [0, 2]
-else:
-  properties:
-    ti,cluster-mode:
-      enum: [0, 1]
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,am64-r5fss
+    then:
+      properties:
+        ti,cluster-mode:
+          enum: [0, 2]
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,am654-r5fss
+            - ti,j7200-r5fss
+            - ti,j721e-r5fss
+            - ti,j721s2-r5fss
+    then:
+      properties:
+        ti,cluster-mode:
+          enum: [0, 1]
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - ti,am62-r5fss
+    then:
+      properties:
+        ti,cluster-mode: false
 
 required:
   - compatible
-- 
2.17.1

