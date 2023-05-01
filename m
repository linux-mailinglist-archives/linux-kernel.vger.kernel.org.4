Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7406F2F59
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 10:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjEAIoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 04:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEAIoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 04:44:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D0B10E7;
        Mon,  1 May 2023 01:44:12 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EC90866031F8;
        Mon,  1 May 2023 09:44:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682930651;
        bh=yOu4hxNG9H8E3BYZJ09jRWvIMd5u45GgHcAb3KhsBXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dDtM4xXkSvrO9zdyBpA378ZJAH4M4xhc/dBOhKHaCOt+9q5hwE0pELA34MPZ+5FYv
         7jqO+uj9fguFhOi6cHFI4hkdJX3pJppxA3yD92B7JYgdPfiXahOU0yyskQch7zhtho
         y0Fi5zukqvta1IISIzKQWtPUIc8IaskyI6nDtLiaHC+WFb8A6K7hRNdFRVtYD8pydi
         twf95xDWKxcWNTw6i8HBMpHlXcAZOEZZCaZUXcbWC82fB1frbWIYFfWuUdbjpE+EG+
         pBJCVYA9hYqPLOZyX7Lk6mBvjolYDh6aNl3eZ0LlapUSoJ/+X6C9TI51ZCRXl+AUu0
         YWtqnDKAxOK9A==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 2/8] dt-bindings: nvmem: rockchip-otp: Add compatible for RK3588
Date:   Mon,  1 May 2023 11:43:54 +0300
Message-Id: <20230501084401.765169-3-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
References: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the OTP memory found on Rockchip RK3588 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 .../bindings/nvmem/rockchip-otp.yaml          | 71 ++++++++++++++++---
 1 file changed, 60 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml
index 658ceed14ee2..84a11382c6e7 100644
--- a/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rockchip-otp.yaml
@@ -9,34 +9,31 @@ title: Rockchip internal OTP (One Time Programmable) memory
 maintainers:
   - Heiko Stuebner <heiko@sntech.de>
 
-allOf:
-  - $ref: nvmem.yaml#
-
 properties:
   compatible:
     enum:
       - rockchip,px30-otp
       - rockchip,rk3308-otp
+      - rockchip,rk3588-otp
 
   reg:
     maxItems: 1
 
   clocks:
     minItems: 3
-    maxItems: 3
+    maxItems: 4
 
   clock-names:
-    items:
-      - const: otp
-      - const: apb_pclk
-      - const: phy
+    minItems: 3
+    maxItems: 4
 
   resets:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   reset-names:
-    items:
-      - const: phy
+    minItems: 1
+    maxItems: 3
 
 required:
   - compatible
@@ -46,6 +43,58 @@ required:
   - resets
   - reset-names
 
+allOf:
+  - $ref: nvmem.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,px30-otp
+              - rockchip,rk3308-otp
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: otp
+            - const: apb_pclk
+            - const: phy
+        resets:
+          maxItems: 1
+        reset-names:
+          items:
+            - const: phy
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3588-otp
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          items:
+            - const: otpc
+            - const: apb
+            - const: arb
+            - const: phy
+        resets:
+          minItems: 1
+          maxItems: 3
+        reset-names:
+          items:
+            - const: otpc
+            - const: apb
+            - const: arb
+
 unevaluatedProperties: false
 
 examples:
-- 
2.40.0

