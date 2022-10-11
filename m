Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBE75FBE47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 01:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJKXSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 19:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJKXSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 19:18:17 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C775244E;
        Tue, 11 Oct 2022 16:18:14 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29BNI3pK005692;
        Tue, 11 Oct 2022 18:18:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665530283;
        bh=cR268UZvfBM1FlE0yMkmHq1DV0bRnQaCFdVx4NiAZW4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Ah50Newn2/6TzODu00VwBWZPIwRtC80EfIxafxg1VS9j9fIQzVUSOM0obubjjejSC
         gqNWnxcOrkmxFg2L15V2WPsDKJ4n9DMUJbRSQk7m/AoIsfVpV1c/SGTEETr1ccR1Xx
         X/jHs0B6Gvtyx4xksXaWxq1WlvWBwd2qRrYCmZb4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29BNI386029505
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Oct 2022 18:18:03 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 11
 Oct 2022 18:18:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 11 Oct 2022 18:18:02 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29BNI2bQ059088;
        Tue, 11 Oct 2022 18:18:02 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Linux Thermal <linux-pm@vger.kernel.org>,
        Linux Device Tree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 06/11] dt-bindings: thermal: k3-j72xx: conditionally require efuse reg range
Date:   Tue, 11 Oct 2022 18:17:22 -0500
Message-ID: <20221011231727.8090-7-bb@ti.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221011231727.8090-1-bb@ti.com>
References: <20221011231727.8090-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2213; h=from:subject; bh=392o2SIsDC1TRw+VXUL68Q4QmibPK2Rjnky1U7t/3gE=; b=owNCWmg5MUFZJlNZGbDbUgAAan/////9+uvvzcru7OcZ+4c+2U362e1//9+R93z8/bXO+vewARsw IeoDQAaNNAB6QAaANAAaNNMQDQxDQAaGIDQABoNNNGjE0DTTQeptQ2jUbU/VDoaaZGmjIDJkAAaAZP QhoAZGgaBoaaAGTIxMJ6gaBkNDIwjI9TEGmhkBpoAdNMTQyMjQwgGmgaDJppphNAGhoAYhk0wRoyGB MJhAAAYgMEAAaDQABg8IMdCJgQiNnz8TIkuavngDGMNCq0/DEXAsUAs1sGIyFfRtD4fhmgu8kWYdov xguio2arETPjgAr10QiqFfLxFimu4m2IbQjOBdPkJrQ8HgQDdKsaFLr6aK6k6fIK42nt+5ZhbdbpPb PHBxv4+gng2490wMxfvp8kMwC2PgDLOOYDdACNO16WMsDqgQkb0ixfqOxbAUVe5NlSOBA3oVM8rQpD SruWyBMFTh3wCo3G7B7h1NGjjRInfxIzIeO5oiM1Y1X5aulQEUa38bWZY0+p2J7ADH62BwoxIxU8yf AFbomYriq2fU2XL+Pw0SjsDGcNlKHrW3hK9Y0bKUjUFrALGqUgdCLUImbLJJBHqwIPhmgFN35HEf1y 6cC8hmqpMu9LQxp/uxDDt8g4ycMQBx9cTnUZDkj+C0IR0LGlZn+rT7gAP8XckU4UJAZsNtSA==
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
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

Only some of TI's J721E SoCs will need a eFuse register range mapped to
determine if they're affected by TI's i2128 erratum. All other SoC will
not need this eFuse range to be mapped to function properly

Update the bindings for the k3_j72xx_bandgap thermal driver so other
devices will only need to define two register ranges

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 .../bindings/thermal/ti,j72xx-thermal.yaml    | 34 +++++++++++++------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
index 0b6a6fa07a532..387628ab35959 100644
--- a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
@@ -33,16 +33,6 @@ properties:
       - ti,j721e-vtm
       - ti,j7200-vtm
 
-  reg:
-    items:
-      - description: VTM cfg1 register space
-      - description: VTM cfg2 register space
-      - description: |
-          A software trimming method must be applied to some Jacinto
-          devices to function properly. This eFuse region provides
-          the information needed for these SoCs to report
-          temperatures accurately.
-
   power-domains:
     description: |
       Should contain the phandle to a power management (PM) domain
@@ -52,6 +42,30 @@ properties:
   "#thermal-sensor-cells":
     const: 1
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ti,j721e-vtm
+then:
+  properties:
+    reg:
+      items:
+        - description: VTM cfg1 register space
+        - description: VTM cfg2 register space
+        - description: |
+            A software trimming method must be applied to some Jacinto
+            devices to function properly. This eFuse region provides
+            the information needed for these SoCs to report
+            temperatures accurately.
+else:
+  properties:
+    reg:
+      items:
+        - description: VTM cfg1 register space
+        - description: VTM cfg2 register space
+
 required:
   - compatible
   - reg
-- 
2.38.0

