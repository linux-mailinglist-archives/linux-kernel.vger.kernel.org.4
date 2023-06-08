Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096467284C8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 18:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjFHQWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 12:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjFHQWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 12:22:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC552712;
        Thu,  8 Jun 2023 09:22:43 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-092.ewe-ip-backbone.de [91.248.189.92])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EB8676606F24;
        Thu,  8 Jun 2023 17:22:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686241362;
        bh=d5W9cB5m/2xTUJ3EBNif6t03N/4rl9ZbDzQL72k7Itw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V399m8BxIm0sskCAfXqxPOGJP/hCAWJRkGRMzdjWsXTs/b3sj1aS8itGiSFIvfkLC
         01nY3deP4LQAK7XUvlnDjHIALP7YYcPQSlvVYaLSk4KaB5OaPJwwWnpgP7jXTS9ubD
         Qd6arz46D65sIhXjO5HQVzsJw1HO2xplt4NT7lhdVfSV/gpBs+JNY8stu5KBei0x1n
         qhXbfZyXiOzF2D8ko/RdXK0qxr0SaVc9IUHOAYuN93d1NGBtgubIcDpE2I6osRv/7/
         Da8241ZE14m0dEbh0/2BDyzq9ymTTkGxFkJ4Ei1dcjuHQF8SQv55m0Z5b7M1JAhnoD
         ArC/q0LDeT2AA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id CDCFD4807E2; Thu,  8 Jun 2023 18:22:39 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 3/5] dt-bindings: phy: rockchip: rk3588 has two reset lines
Date:   Thu,  8 Jun 2023 18:22:36 +0200
Message-Id: <20230608162238.50078-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608162238.50078-1-sebastian.reichel@collabora.com>
References: <20230608162238.50078-1-sebastian.reichel@collabora.com>
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

The RK3588 has two reset lines for the combphy. One for the
APB interface and one for the actual PHY.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../phy/phy-rockchip-naneng-combphy.yaml      | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
index 9ae514fa7533..d3cd7997879f 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
@@ -31,8 +31,14 @@ properties:
       - const: pipe
 
   resets:
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    minItems: 1
     items:
-      - description: exclusive PHY reset line
+      - const: phy
+      - const: apb
 
   rockchip,enable-ssc:
     type: boolean
@@ -78,6 +84,32 @@ required:
   - rockchip,pipe-phy-grf
   - "#phy-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-naneng-combphy
+    then:
+      properties:
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-naneng-combphy
+    then:
+      properties:
+        resets:
+          minItems: 2
+        reset-names:
+          minItems: 2
+      required:
+        - reset-names
+
 additionalProperties: false
 
 examples:
-- 
2.39.2

