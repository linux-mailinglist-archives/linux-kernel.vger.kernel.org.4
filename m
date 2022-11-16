Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9C62C753
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234223AbiKPSNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbiKPSNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:13:48 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2847E201A7;
        Wed, 16 Nov 2022 10:13:45 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AGIDReT001327;
        Wed, 16 Nov 2022 12:13:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668622407;
        bh=ZTY4BEftk+Ht4KTV7sRJ7iEuEIU/qA5Kz+qtTCRngcU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=c1m7HBdqQK/zZfdj0wYLnKOgxZh5rE1qkgFM+sYllyBUhS+CNHwNUZv4yefe6nzOV
         IOt21IEJlVIMXJ7c4UqGvjHb/NqnwADTKkrwmLFmJ8gE4oHw3pPX8i41Md8F/VyAH6
         xwG2Xfb6pj7EVyk0IVN5pTlZ8DXbSPVFp7TRDRD4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AGIDRE3013596
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Nov 2022 12:13:27 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 16
 Nov 2022 12:13:26 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 16 Nov 2022 12:13:27 -0600
Received: from jti.ent.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AGID8MF026690;
        Wed, 16 Nov 2022 12:13:19 -0600
From:   Georgi Vlaev <g-vlaev@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Georgi Vlaev <g-vlaev@ti.com>
Subject: [PATCH v4 1/5] dt-bindings: ti, sci: Add lpm region and firmware-name
Date:   Wed, 16 Nov 2022 20:13:03 +0200
Message-ID: <20221116181307.198209-2-g-vlaev@ti.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221116181307.198209-1-g-vlaev@ti.com>
References: <20221116181307.198209-1-g-vlaev@ti.com>
MIME-Version: 1.0
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

From: Dave Gerlach <d-gerlach@ti.com>

Add documentation for the lpm region which tells the ti-sci driver where
to load the FS Stub low power mode firmware and also the firmware-name
which tells the driver which binary to load. Both of these are optional
for normal system operation but required to enabled suspend-to-mem usage
of Deep Sleep state.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
---
 .../bindings/arm/keystone/ti,sci.yaml         | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
index 34f5f877d444..4c5213de24bc 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
@@ -42,12 +42,19 @@ properties:
           - const: ti,am654-sci
 
   reg-names:
-    description: |
-      Specifies the debug messages memory mapped region that is optionally
-      made available from TI-SCI controller.
-    const: debug_messages
+    items:
+      - const: debug_messages
+      - const: lpm
+    minItems: 1
 
   reg:
+    items:
+      - description: |
+          Specifies the debug messages memory mapped region that is optionally
+          made available from TI-SCI controller.
+      - description: |
+          Specifies the lpm memory mapped region where the FS Stub low power
+          firmware is to be loaded.
     minItems: 1
 
   mbox-names:
@@ -83,6 +90,12 @@ properties:
     type: object
     $ref: /schemas/reset/ti,sci-reset.yaml#
 
+  firmware-name:
+    description: |
+      Name of binary of FS Stub low power firmware located on the
+      firmware search path.
+    $ref: /schemas/types.yaml#/definitions/string
+
 required:
   - compatible
   - mbox-names
-- 
2.30.2

