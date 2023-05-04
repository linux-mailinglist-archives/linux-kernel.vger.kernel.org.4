Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FD06F7768
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjEDUtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEDUtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:49:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E58C46B9;
        Thu,  4 May 2023 13:48:32 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E03A66605700;
        Thu,  4 May 2023 21:07:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683230822;
        bh=MaX5xiMpkREv1mrGy3uq4EJmAVpURoqntpnyiSAp4pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nYzofxzlXC5bJnckergPL6/YhJyiLjHvHA+dWpDbHjxUQU6PiBTLpJh5XmAsiipiJ
         cgWK9F4V9Xm2vSHp0oT2N45u3oWekNfvXLT/6wERI1Gj+FSCQshNE/ufUR3Rheuged
         Hkwh8HC6lL9O9YhjNqBu67KwodpU82PAgd8p0kprR1HNvP/Z6/hkpESQkSK0oLx8D0
         T19DOyzLAlpHU/euxIkcPEWYSu1zMRh+5NlcbkgN8aBpFhSsz6kUht/IwDQ5PN00/b
         dqjQvZOW2iw9NOP+ydWdjUkEGz4jcuTiEQEoYgWiZSaW59RkvQ2YxGSagh4MqJ/a6b
         fxqh04rEBITMg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Vincent Legoll <vincent.legoll@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 2/8] dt-bindings: nvmem: rockchip,otp: Add compatible for RK3588
Date:   Thu,  4 May 2023 23:06:42 +0300
Message-Id: <20230504200648.1119866-3-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230504200648.1119866-1-cristian.ciocaltea@collabora.com>
References: <20230504200648.1119866-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the OTP memory found on Rockchip RK3588 SoC.

Since RK3588 uses different clocks & resets configurations than PX30 /
RK3308, provide the required changes in the binding to be able to handle
both variants.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/nvmem/rockchip,otp.yaml          | 54 ++++++++++++++++---
 1 file changed, 47 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
index 4cd425ae2823..9c6eff788928 100644
--- a/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rockchip,otp.yaml
@@ -9,33 +9,35 @@ title: Rockchip internal OTP (One Time Programmable) memory
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
-    maxItems: 3
+    minItems: 3
+    maxItems: 4
 
   clock-names:
+    minItems: 3
     items:
       - const: otp
       - const: apb_pclk
       - const: phy
+      - const: arb
 
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
@@ -45,6 +47,44 @@ required:
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
+          maxItems: 3
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
+        resets:
+          minItems: 3
+        reset-names:
+          items:
+            - const: otp
+            - const: apb
+            - const: arb
+
 unevaluatedProperties: false
 
 examples:
-- 
2.40.0

