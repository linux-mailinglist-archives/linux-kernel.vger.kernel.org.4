Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AB06A8052
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjCBKwa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Mar 2023 05:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCBKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:52:28 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E427F2A9BA;
        Thu,  2 Mar 2023 02:52:24 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 66E2A24E294;
        Thu,  2 Mar 2023 18:52:23 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 2 Mar
 2023 18:52:23 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Thu, 2 Mar 2023 18:52:22 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        William Qiu <william.qiu@starfivetech.com>,
        Ziv Xu <ziv.xu@starfivetech.com>
Subject: [PATCH v1 1/2] dt-bindings: qspi: cdns,qspi-nor: constrain minItems/maxItems of resets
Date:   Thu, 2 Mar 2023 18:52:20 +0800
Message-ID: <20230302105221.197421-2-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302105221.197421-1-william.qiu@starfivetech.com>
References: <20230302105221.197421-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QSPI controller needs three reset items to work properly on JH7110 SoC,
so there is need to change the maxItems's value to 3 and add minItems
whose value is equal to 2. Other platforms do not have this constraint.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 .../bindings/spi/cdns,qspi-nor.yaml           | 37 +++++++++++++++++--
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 4707294d8f59..14821cb6db48 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -19,6 +19,33 @@ allOf:
     then:
       required:
         - power-domains
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jh7110-qspi
+    then:
+      properties:
+        resets:
+          minItems: 2
+          maxItems: 3
+
+        reset-names:
+          minItems: 2
+          maxItems: 3
+          items:
+            enum: [ qspi, qspi-ocp, rstc_ref ]
+
+    else:
+      properties:
+        resets:
+          maxItems: 2
+
+        reset-names:
+          minItems: 1
+          maxItems: 2
+          items:
+            enum: [ qspi, qspi-ocp ]
 
 properties:
   compatible:
@@ -30,6 +57,7 @@ properties:
               - intel,lgm-qspi
               - xlnx,versal-ospi-1.0
               - intel,socfpga-qspi
+              - starfive,jh7110-qspi
           - const: cdns,qspi-nor
       - const: cdns,qspi-nor
 
@@ -79,13 +107,14 @@ properties:
     maxItems: 1
 
   resets:
-    maxItems: 2
+    minItems: 2
+    maxItems: 3
 
   reset-names:
-    minItems: 1
-    maxItems: 2
+    minItems: 2
+    maxItems: 3
     items:
-      enum: [ qspi, qspi-ocp ]
+      enum: [ qspi, qspi-ocp, rstc_ref ]
 
 required:
   - compatible
-- 
2.34.1

