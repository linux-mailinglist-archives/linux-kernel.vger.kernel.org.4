Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF5263AA66
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiK1OFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiK1OFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:05:45 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACF5178B0;
        Mon, 28 Nov 2022 06:05:44 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2ASE5cQ6080222;
        Mon, 28 Nov 2022 08:05:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1669644338;
        bh=EL2GD7RH1r/qBE+G7f9QX035vVk4JvRCI5hwA6WOgqA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fU9uCxWvs4f9JT4QP8p+JcLrRSMUc+/EwBIuvKT8Hxz29kiW0Qi4mPmBuXlu816+L
         2LA4CdCXfRvpXHOHUxJAqQfQWJWQ7fA6/DMffWTilTNqr7OzOlqmQeOHa47YMxdpv6
         TMsBujxLfOlLOPSumN+ZKz8tYDsg4GBZ5YNVr36Q=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2ASE5c8c023701
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Nov 2022 08:05:38 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 28
 Nov 2022 08:05:37 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 28 Nov 2022 08:05:37 -0600
Received: from jti.ent.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2ASE5NQa125815;
        Mon, 28 Nov 2022 08:05:31 -0600
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
        Georgi Vlaev <g-vlaev@ti.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/6] dt-bindings: ti, sci: Add lpm region and firmware-name
Date:   Mon, 28 Nov 2022 16:05:17 +0200
Message-ID: <20221128140522.49474-2-g-vlaev@ti.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221128140522.49474-1-g-vlaev@ti.com>
References: <20221128140522.49474-1-g-vlaev@ti.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

