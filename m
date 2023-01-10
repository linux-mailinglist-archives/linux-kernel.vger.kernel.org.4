Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4E06636EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjAJBuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbjAJBud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:50:33 -0500
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7B3FD29;
        Mon,  9 Jan 2023 17:50:31 -0800 (PST)
Received: from SHSend.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTP id 30A1ntxn015779;
        Tue, 10 Jan 2023 09:49:55 +0800 (+08)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from ubt.spreadtrum.com (10.0.74.87) by BJMBX02.spreadtrum.com
 (10.0.64.8) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 10 Jan
 2023 09:49:51 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        "Chunyan Zhang" <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V4 3/3] dt-bindings: gpio: Add compatible string for Unisoc UMS512
Date:   Tue, 10 Jan 2023 09:49:43 +0800
Message-ID: <20230110014943.2196046-4-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110014943.2196046-1-chunyan.zhang@unisoc.com>
References: <20230110014943.2196046-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.74.87]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com 30A1ntxn015779
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UMS512 use the same GPIO and EIC controller with SC9860.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/gpio/sprd,gpio-eic.yaml          | 33 +++++++++++++++----
 .../devicetree/bindings/gpio/sprd,gpio.yaml   |  7 +++-
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
index a21350bd0f2c..99fcf970773a 100644
--- a/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
+++ b/Documentation/devicetree/bindings/gpio/sprd,gpio-eic.yaml
@@ -42,12 +42,33 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - sprd,sc9860-eic-debounce
-      - sprd,sc9860-eic-latch
-      - sprd,sc9860-eic-async
-      - sprd,sc9860-eic-sync
-      - sprd,sc2731-eic
+    oneOf:
+      - enum:
+          - sprd,sc9860-eic-debounce
+          - sprd,sc9860-eic-latch
+          - sprd,sc9860-eic-async
+          - sprd,sc9860-eic-sync
+          - sprd,sc2731-eic
+      - items:
+          - enum:
+              - sprd,ums512-eic-debounce
+          - const: sprd,sc9860-eic-debounce
+      - items:
+          - enum:
+              - sprd,ums512-eic-latch
+          - const: sprd,sc9860-eic-latch
+      - items:
+          - enum:
+              - sprd,ums512-eic-async
+          - const: sprd,sc9860-eic-async
+      - items:
+          - enum:
+              - sprd,ums512-eic-sync
+          - const: sprd,sc9860-eic-sync
+      - items:
+          - enum:
+              - sprd,sc2730-eic
+          - const: sprd,sc2731-eic
 
   reg:
     minItems: 1
diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
index 40924123d184..483168838128 100644
--- a/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
@@ -19,7 +19,12 @@ description: |
 
 properties:
   compatible:
-    const: sprd,sc9860-gpio
+    oneOf:
+      - const: sprd,sc9860-gpio
+      - items:
+          - enum:
+              - sprd,ums512-gpio
+          - const: sprd,sc9860-gpio
 
   reg:
     maxItems: 1
-- 
2.25.1

