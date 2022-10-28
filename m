Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C246611DC3
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiJ1Wz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiJ1Wzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:55:42 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60F71D441A;
        Fri, 28 Oct 2022 15:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666997727; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8fNxdddGM77vcHk/0yqRmbXWir62aBErY4gRc5JUiCw=;
        b=VR4p+0NC6nSMVR2ccrFgESFuFGCFuETqs+ZwWDQyh3U87liaLemoSCnJz7LEF2/C+CxVxh
        wRddo3vkGjB7oWieN1dDQGXUBgEbVWMW18TMW328k7xBDt10JxEXGYJN0xdj25nMTAggf4
        cvJeJqdcxZfn8VQ8OHzfzuu0omA4bkI=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        od@opendingux.net, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/4] dt-bindings: rtc: ingenic: Rework compatible strings and add #clock-cells
Date:   Fri, 28 Oct 2022 23:55:16 +0100
Message-Id: <20221028225519.89210-2-paul@crapouillou.net>
In-Reply-To: <20221028225519.89210-1-paul@crapouillou.net>
References: <20221028225519.89210-1-paul@crapouillou.net>
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

Therefore, the ingenic,jz4770-rtc and ingenic,jz4780-rtc strings do not
fall back anymore to ingenic,jz4760-rtc. The ingenic,jz4780-rtc string
now falls back to the ingenic,jz4770-rtc string.

Additionally, since the RTCs in the JZ4770 and JZ4780 support outputting
the input oscillator's clock to the CLK32K pin, the RTC node is now also
a clock provider on these SoCs, so a #clock-cells property is added.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

 v2: - add constraint on which SoCs can have the #clock-cells property
     - add JZ4780 example which has a #clock-cells

 .../devicetree/bindings/rtc/ingenic,rtc.yaml  | 32 +++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml b/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
index b235b2441997..d63bb727cee5 100644
--- a/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml
@@ -11,6 +11,16 @@ maintainers:
 
 allOf:
   - $ref: rtc.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - ingenic,jz4770-rtc
+    then:
+      properties:
+        "#clock-cells": false
 
 properties:
   compatible:
@@ -18,14 +28,14 @@ properties:
       - enum:
           - ingenic,jz4740-rtc
           - ingenic,jz4760-rtc
+          - ingenic,jz4770-rtc
       - items:
           - const: ingenic,jz4725b-rtc
           - const: ingenic,jz4740-rtc
       - items:
           - enum:
-              - ingenic,jz4770-rtc
               - ingenic,jz4780-rtc
-          - const: ingenic,jz4760-rtc
+          - const: ingenic,jz4770-rtc
 
   reg:
     maxItems: 1
@@ -39,6 +49,9 @@ properties:
   clock-names:
     const: rtc
 
+  "#clock-cells":
+    const: 0
+
   system-power-controller:
     description: |
       Indicates that the RTC is responsible for powering OFF
@@ -83,3 +96,18 @@ examples:
       clocks = <&cgu JZ4740_CLK_RTC>;
       clock-names = "rtc";
     };
+
+  - |
+    #include <dt-bindings/clock/ingenic,jz4780-cgu.h>
+    rtc: rtc@10003000 {
+      compatible = "ingenic,jz4780-rtc", "ingenic,jz4770-rtc";
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
2.35.1

