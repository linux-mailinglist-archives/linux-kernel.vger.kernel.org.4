Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130DC67FEBF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 13:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjA2MFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 07:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjA2MFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 07:05:00 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4FF2201D;
        Sun, 29 Jan 2023 04:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1674993890; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmzCO3n3U4/L50Mpe2KY2BIPAp1YjeA7+C44XKCNUsI=;
        b=BUv8aLYI4kiwCnIZRxlhkKBg2BeXO+xipryTGl6AW5RoFe2JXGR8qP3aRk9VayGti023BR
        t1g7UESAy7EHgpxI6hwoDUUepgu7qdTcXA26rjiTZAN2QUY9yAcjgi5Syi39mZC2VLTMZs
        zWUAsTWYKWa1wdhGjz3se3w0lS/RoNk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        list@opendingux.net, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 1/4] dt-bindings: rtc: Add #clock-cells property
Date:   Sun, 29 Jan 2023 12:04:39 +0000
Message-Id: <20230129120442.22858-2-paul@crapouillou.net>
In-Reply-To: <20230129120442.22858-1-paul@crapouillou.net>
References: <20230129120442.22858-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC in the JZ4770 is compatible with the JZ4760, but has an extra
register that permits to configure the behaviour of the CLK32K pin. The
same goes for the RTC in the JZ4780.

With this change, the RTC node is now also a clock provider on these
SoCs, so a #clock-cells property is added.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>

---
 v2: - add constraint on which SoCs can have the #clock-cells property
     - add JZ4780 example which has a #clock-cells
 v3: Don't break ABI anymore.
---
 .../devicetree/bindings/rtc/ingenic,rtc.yaml  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml b/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
index af78b67b3da4..de9879bdb317 100644
--- a/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
@@ -11,6 +11,17 @@ maintainers:
 
 allOf:
   - $ref: rtc.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - ingenic,jz4770-rtc
+                - ingenic,jz4780-rtc
+    then:
+      properties:
+        "#clock-cells": false
 
 properties:
   compatible:
@@ -39,6 +50,9 @@ properties:
   clock-names:
     const: rtc
 
+  "#clock-cells":
+    const: 0
+
   system-power-controller:
     description: |
       Indicates that the RTC is responsible for powering OFF
@@ -83,3 +97,18 @@ examples:
       clocks = <&cgu JZ4740_CLK_RTC>;
       clock-names = "rtc";
     };
+
+  - |
+    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
+    rtc: rtc@10003000 {
+      compatible = "ingenic,jz4780-rtc", "ingenic,jz4760-rtc";
+      reg = <0x10003000 0x4c>;
+
+      interrupt-parent = <&intc>;
+      interrupts = <32>;
+
+      clocks = <&cgu JZ4780_CLK_RTCLK>;
+      clock-names = "rtc";
+
+      #clock-cells = <0>;
+    };
-- 
2.39.0

