Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5602C70C465
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjEVRek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjEVRee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:34:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F11100;
        Mon, 22 May 2023 10:34:33 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-162.ewe-ip-backbone.de [91.248.208.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2D67E6606E69;
        Mon, 22 May 2023 18:34:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684776871;
        bh=+glCV8Ppsmj02ojEvctTLkB95+84CeD8o7UpyPzMpZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=buQ74jR50Xcc078VNGALUSjE8Gw1t+fRfNqk/WS5gLq/6jxmLRcE9jIFwxZaSbaoB
         4izemo4LJVVw55481x+MsP/lWbPLhBmfkAvKMbY/d8k0a3QXxwPocChBoa4ImS/EyM
         vpoAQo667LDW33XF5xnovwDQuJI0Yz6aYnwQXqaI89a8kim+8KxheE3iSpYjww+Gd0
         q7TG7smhZrhPKZWSLIFMX+jlTQy7fy3g9kq1jhg+sWrhaDxVMty0luLer2mLQYloPm
         JtqsHrY10zLxAWE8t3wY9njfC4Monks1mGOrtSDF1/c9nLHLfigTF/RT0h7lPU57OV
         Y8yO7jmy5SyGw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 8DF3B4807E2; Mon, 22 May 2023 19:34:29 +0200 (CEST)
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
Subject: [PATCH v2 3/6] dt-bindings: ata: ahci: dwc: enforce rockchip clocks
Date:   Mon, 22 May 2023 19:34:20 +0200
Message-Id: <20230522173423.64691-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522173423.64691-1-sebastian.reichel@collabora.com>
References: <20230522173423.64691-1-sebastian.reichel@collabora.com>
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

Provide a specific list of clocks allowed for RK3568 and RK3588
based DWC AHCI controllers.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/ata/snps,dwc-ahci.yaml           | 34 +++++++++++++++++--
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
index c6a0d6c8b62c..37830185b9b5 100644
--- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
@@ -13,9 +13,6 @@ description:
   This document defines device tree bindings for the generic Synopsys DWC
   implementation of the AHCI SATA controller.
 
-allOf:
-  - $ref: snps,dwc-ahci-common.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -41,6 +38,37 @@ required:
   - reg
   - interrupts
 
+allOf:
+  - $ref: snps,dwc-ahci-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3588-dwc-ahci
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: sata
+            - const: pmalive
+            - const: rxoob
+            - const: ref
+            - const: asic
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3568-dwc-ahci
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: sata
+            - const: pmalive
+            - const: rxoob
+
 unevaluatedProperties: false
 
 examples:
-- 
2.39.2

