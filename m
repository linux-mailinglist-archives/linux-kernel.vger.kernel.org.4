Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F8F6141B8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJaX1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiJaX13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:27:29 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8275512095;
        Mon, 31 Oct 2022 16:27:28 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRGG3106686;
        Mon, 31 Oct 2022 18:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667258836;
        bh=i4FyJ9+wFGH1WYq6OT4ovHtAHbJIpIoaqp6lWcMTEDc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wCaW+X+GyUJ2OoHcny1AxrEn6PsUCDTkgD5FVBsukj2aZ7VZXLSmkYi+4YArwr/kp
         mxr56tFDE1tjZmXZtTmfo0bszvNFpmJxUkWcR3P+FbLHfiiWzogRflfyozd9XTbemf
         BZI1EJ5cYtfiMxPVgmOIq4eX4T6wqE/8r78QnQEo=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29VNRGtI023424
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Oct 2022 18:27:16 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 31
 Oct 2022 18:27:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 31 Oct 2022 18:27:15 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29VNRFxw124774;
        Mon, 31 Oct 2022 18:27:15 -0500
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
        Bryan Brattlof <bb@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 06/11] dt-bindings: thermal: k3-j72xx: conditionally require efuse reg range
Date:   Mon, 31 Oct 2022 18:26:57 -0500
Message-ID: <20221031232702.10339-7-bb@ti.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221031232702.10339-1-bb@ti.com>
References: <20221031232702.10339-1-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514; h=from:subject; bh=zQFnRZirEDAR1saQhH/S1yZ3qKsjNcR+QWeALNN71T8=; b=owNCWmg5MUFZJlNZyCid4gAAZP///77Pu6vu7Tf+fv/r/D7+evt/36yb+tr/+Hi76v9++vewARsw Iek0yNADQaNADRoAAANNABpo0aAANAA0AGjT1DRoGgDIaaAHpNDJmiGnqZNlDoDIDTQANNDIABoGjQ AMhoADENABpoYjaEyaA0A9Ro8o009QNNDQZAepoNAB00ZGmIAMjTRoANNMmQxGTRoNAABo0YEaZADQ MhhGgyA0aA0GmgA0aANDCAQJiF9O2uJBL8a+QfvAZ1vDkFEkEoX32/Q4iBAH1ln1APsDl1+makPF4e uBTsfk2Taqytr5XL/PBXS4vM1CWPNozgrH9O5YgpI9Q78rGwUnOHg116UTgBxBdjsg83WfprhWDFND j9d/x0A2fT5TXTCkhRNF8Z7oXdkYIkpqDA1PrHAjCJTSKpiQ5prsdOtX7w2OlKWPmmkkq0c/niZwJ6 3RHcU86v3EPi2BtfiiV2jFIB73hk/Vmp6TAKchd5hXooQWCRX9N9q+J1Rkcy5QsIg2IdrICbgUy0Op VYgoAZ2M7TSYwOIsYH7Wd6/0OR6PPZBdxQyZP+7VgV6NwVKREgritDLtpaXyVbEAS8j1gCFCKrXMyS It1BixIEx4qKoQkxNjIhyCCc0ciyK/ksoIiCjbY3yGd0DR+0ZiAgCzShcpL79w0aDDf4u5IpwoSGQU TvEA
X-Developer-Key: i=bb@ti.com; a=openpgp; fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

