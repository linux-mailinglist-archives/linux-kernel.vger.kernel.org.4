Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E8B621F76
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiKHWqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKHWqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:46:00 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E48C606BD;
        Tue,  8 Nov 2022 14:45:58 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A8Mjlnc003045;
        Tue, 8 Nov 2022 16:45:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667947547;
        bh=ZTY4BEftk+Ht4KTV7sRJ7iEuEIU/qA5Kz+qtTCRngcU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mHYN1wWZ8cTgbeD0m068byRQ5c8AyqgLWXolhdrkhq8i+3qTVB0hGEEY7dfRj+3hZ
         6XKKycKDwwFXSKQhOpsM14mMPRVQjBIcabOJ4zW+Nu9VEjR4B4SihGq9iBhYMAKALN
         R2GUAZ2w6bb5JBg0eJg5wNbmLGM85L96qKk6iMOc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A8MjkmJ113864
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Nov 2022 16:45:47 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 8 Nov
 2022 16:45:46 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 8 Nov 2022 16:45:46 -0600
Received: from jti.ent.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A8MjSov071038;
        Tue, 8 Nov 2022 16:45:38 -0600
From:   Georgi Vlaev <g-vlaev@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Vibhore Vardhan <vibhore@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Georgi Vlaev <g-vlaev@ti.com>
Subject: [PATCH v2 1/5] dt-bindings: ti, sci: Add lpm region and firmware-name
Date:   Wed, 9 Nov 2022 00:45:23 +0200
Message-ID: <20221108224527.137179-2-g-vlaev@ti.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221108224527.137179-1-g-vlaev@ti.com>
References: <20221108224527.137179-1-g-vlaev@ti.com>
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

