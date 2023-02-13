Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B9C693DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 05:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjBME4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 23:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjBME4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 23:56:12 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 416DD13D42;
        Sun, 12 Feb 2023 20:55:40 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 13 Feb 2023 13:54:42 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 65ADF2020783;
        Mon, 13 Feb 2023 13:54:42 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 13 Feb 2023 13:54:42 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id E591DC1E22;
        Mon, 13 Feb 2023 13:54:41 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v2] dt-bindings: ata: Add UniPhier controller binding
Date:   Mon, 13 Feb 2023 13:54:32 +0900
Message-Id: <20230213045432.32614-1-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UniPhier SATA controller compatible string to the platform binding.
This controller needs maximum three reset controls.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/ata/ahci-platform.yaml  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

Changes since v1:
- Restrict resets property changes with compatible strings
- Fix maxItems from two to three

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index 7dc2a2e8f598..25dd5ffaa517 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
@@ -45,6 +45,9 @@ properties:
               - marvell,armada-8k-ahci
               - marvell,berlin2-ahci
               - marvell,berlin2q-ahci
+              - socionext,uniphier-pro4-ahci
+              - socionext,uniphier-pxs2-ahci
+              - socionext,uniphier-pxs3-ahci
           - const: generic-ahci
       - enum:
           - cavium,octeon-7130-ahci
@@ -76,6 +79,20 @@ properties:
   resets:
     maxItems: 1
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - socionext,uniphier-pro4-ahci
+          - socionext,uniphier-pxs2-ahci
+          - socionext,uniphier-pxs3-ahci
+then:
+  properties:
+    resets:
+      minItems: 1
+      maxItems: 3
+
 patternProperties:
   "^sata-port@[0-9a-f]+$":
     $ref: /schemas/ata/ahci-common.yaml#/$defs/ahci-port
-- 
2.25.1

