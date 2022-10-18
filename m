Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B5560275E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiJRIoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiJRIoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:44:00 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CA83D591;
        Tue, 18 Oct 2022 01:43:59 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29I8hfnH057247;
        Tue, 18 Oct 2022 03:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666082622;
        bh=ggsSmW4eC8Q4/ZsmDAMWjCpaZTayi8U8s2kFeDJikag=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AdlTAyjeHi5Jk5Dvzlm0WDsLuyw7fyKZEUwAWkTv/QNuf5K3wAxUIj7Nva2NoiAJb
         wZXl/Fx2jiIju49VXjOrrXk6W2S/9ui+pNHPk7fgg+9JRnUt+j7+NZJPPTnfBeBHdd
         31drq45CSoXhkldNhnmi3P7p+ZbikiE15cc11e+E=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29I8hf0n007194
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Oct 2022 03:43:41 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 18
 Oct 2022 03:43:41 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 18 Oct 2022 03:43:41 -0500
Received: from uda0492258.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29I8hXCQ076871;
        Tue, 18 Oct 2022 03:43:38 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee@kernel.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@kernel.org>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <s-vadapalli@ti.com>
Subject: [PATCH v2 1/3] dt-bindings: phy: ti: phy-gmii-sel: Add bindings for J721e
Date:   Tue, 18 Oct 2022 14:13:31 +0530
Message-ID: <20221018084333.149790-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221018084333.149790-1-s-vadapalli@ti.com>
References: <20221018084333.149790-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI's J721e SoC supports additional PHY modes like QSGMII and SGMII
that are not supported on earlier SoCs. Add a compatible for it.

Extend ti,qsgmii-main-ports property to support selection of upto
two main ports at once across the two QSGMII interfaces.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 .../bindings/phy/ti,phy-gmii-sel.yaml         | 48 +++++++++++++++----
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
index da7cac537e15..afe210cde307 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
@@ -54,6 +54,7 @@ properties:
       - ti,dm814-phy-gmii-sel
       - ti,am654-phy-gmii-sel
       - ti,j7200-cpsw5g-phy-gmii-sel
+      - ti,j721e-cpsw9g-phy-gmii-sel
 
   reg:
     maxItems: 1
@@ -63,14 +64,17 @@ properties:
   ti,qsgmii-main-ports:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description: |
-      Required only for QSGMII mode. Array to select the port for
-      QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
-      ports automatically. Any one of the 4 CPSW5G ports can act as the
-      main port with the rest of them being the QSGMII_SUB ports.
-    maxItems: 1
-    items:
-      minimum: 1
-      maximum: 4
+      Required only for QSGMII mode. Array to select the port/s for QSGMII
+      main mode. The size of the array corresponds to the number of QSGMII
+      interfaces and thus, the number of distinct QSGMII main ports,
+      supported by the device. If the device supports two QSGMII interfaces
+      but only one QSGMII interface is desired, repeat the QSGMII main port
+      value corresponding to the QSGMII interface in the array.
+    minItems: 1
+    maxItems: 2
+      items:
+        minimum: 1
+        maximum: 8
 
 allOf:
   - if:
@@ -81,12 +85,39 @@ allOf:
               - ti,dra7xx-phy-gmii-sel
               - ti,dm814-phy-gmii-sel
               - ti,am654-phy-gmii-sel
+              - ti,j7200-cpsw5g-phy-gmii-sel
+              - ti,j721e-cpsw9g-phy-gmii-sel
     then:
       properties:
         '#phy-cells':
           const: 1
           description: CPSW port number (starting from 1)
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,j7200-cpsw5g-phy-gmii-sel
+    then:
+      properties:
+        ti,qsgmii-main-ports:
+          maxItems: 1
+          items:
+            minimum: 1
+            maximum: 4
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,j721e-cpsw9g-phy-gmii-sel
+    then:
+      properties:
+        ti,qsgmii-main-ports:
+          minItems: 2
+
   - if:
       not:
         properties:
@@ -94,6 +125,7 @@ allOf:
             contains:
               enum:
                 - ti,j7200-cpsw5g-phy-gmii-sel
+                - ti,j721e-cpsw9g-phy-gmii-sel
     then:
       properties:
         ti,qsgmii-main-ports: false
-- 
2.25.1

