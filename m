Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5C160D486
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbiJYTP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiJYTPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:15:33 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B653E7F0B3;
        Tue, 25 Oct 2022 12:15:32 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29PJFKxl074680;
        Tue, 25 Oct 2022 14:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666725320;
        bh=kJg2w2YyvaAxJz6O0g5hLPC43gY8IVp6CZbO0QPsoSg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pZzv909EivZAOWAJDa+qpC3J1LTxdWQ/vamvOL1iuxQVvsmA2uLPaHZEJdveOMXbD
         aeoPOmr1sm+YpP1zqiBMzjCz95RBiYByIzlTyPXZtcsv/KQ9t17W7CDqYptwwGlddC
         OoVqPrnJBiK++fOdUHThRSTcECy5jRVTGH4bDXiE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29PJFJBk065993
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Oct 2022 14:15:20 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 25
 Oct 2022 14:15:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 25 Oct 2022 14:15:19 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29PJFJQD056997;
        Tue, 25 Oct 2022 14:15:19 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>
CC:     Keerthy <j-keerthy@ti.com>, Linux PM <linux-pm@vger.kernel.org>,
        Device Trees <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LKML ARM <linux-arm-kernel@lists.infradead.org>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 06/11] dt-bindings: thermal: k3-j72xx: conditionally require efuse reg range
Date:   Tue, 25 Oct 2022 14:15:10 -0500
Message-ID: <20221025191515.9151-7-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025191515.9151-1-bb@ti.com>
References: <20221025191515.9151-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1447; h=from:subject; bh=9FYBQiKpTMnTu19yT0LGLoV8d9yOv5BwuV30CxJBgHY=; b=owNCWmg5MUFZJlNZpo8qqwAAbH///v9/l/Pv+2/3R/n1n62/vfz/5Vd9be7/X/uZ/1nF/1cwARs1 aOTQ0BoANDQaBoAA09ID1DQAaAA0AADQAMgAAM1DIAANonqaH6oDQ8UeodAaAaADQaGgaAB6gGj0ga A0bUA0AANqAAAHpAA0B6gxqGg9QAxND1A9TNDvVNPUHqB6g0aaA0GgNqNA0BpkAANADTQAANAZDTQN GjEAAGgA0ABoGQ/UmCCbLVQD7R9EKgm2wU6SUeLjxOoz5BNO9q5oqpGNTOBIhDcqsCDJ7ywR/Ij5gg 5GQIIM+m5NIz7sDSUdweBGsJSH7xLNdPUJXORinPI1wK83ROoeiPCHDe8MsImPcJKjHRFf1Xxq/02L uuTYKKvQLCBku0bk9Zb2bDJ4fmoowlm8WvAMpNkCOY3IuJy4Gj1tcOpABdKK3nvXqdVajf7rmC2eeZ k2rAa6LsIOEjigDNkQbs5cq8QM5CVx0lT9xCJttQYKbxgIvqHQh0teNEhKb+FLrX2VCvT4ST6ye00U xE/PSOA+gmif48r6Rh9unBhCjHGdg/BAntYNW9Bsj6sPL1W5Kg1JXzmwolgnsOx/BBdcJogsmhgYtm VaMGLyF9gAspmQrQqjMQRo9xO//A/9+o2CsgdMhuM/CfV7mBGUV4i+gTp/i7kinChIU0eVVYA=
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only some of TI's J721E SoCs will need a eFuse register range mapped to
determine if they're affected by TI's i2128 erratum. All other SoC will
not need this eFuse range to function properly

Update the bindings for the k3_j72xx_bandgap thermal driver so other
devices will only need two register ranges

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 .../bindings/thermal/ti,j72xx-thermal.yaml       | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
index 3bb870a26872f..0509c9cec224d 100644
--- a/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/ti,j72xx-thermal.yaml
@@ -37,6 +37,7 @@ properties:
           devices to function properly. This eFuse region provides
           the information needed for these SoCs to report
           temperatures accurately.
+    minItems: 2
 
   power-domains:
     maxItems: 1
@@ -44,6 +45,21 @@ properties:
   "#thermal-sensor-cells":
     const: 1
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,j721e-vtm
+    then:
+      properties:
+        reg:
+          minItems: 3
+    else:
+      properties:
+        reg:
+          maxItems: 2
+
 required:
   - compatible
   - reg
-- 
2.38.1

