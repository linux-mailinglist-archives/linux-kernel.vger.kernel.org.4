Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B892763FB27
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbiLAW6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiLAW5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:57:40 -0500
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B282FB7FE;
        Thu,  1 Dec 2022 14:57:38 -0800 (PST)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id C126F5FD12;
        Fri,  2 Dec 2022 01:57:35 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1669935455;
        bh=8WuFTtlyje+RAPuOwRdLKN6aHl8n49XuWh4hJVbyhvE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=qdLxOm4exQShUjJgIXX/fzGd0p+4cd4Z3SBfqRkvwdesAeXqhKXocNkJMLsJi2H05
         HK/gfQOAuDcXePOD3hpT+f6Sq1tYSBmg22YiaPT+ukMEyLAz1lDWSqhR8vhqSzaZ1F
         x+pvuiS6s81ANoqwS2I6G2HePklx/XnitXWOglBUV0DMzUGb9+DLsYnflrmYOeVW/R
         cTh/18CHPPLK562AFZLIKjTBTMka9Ei7JCa+DwXWRrLAlMPfiJdcweUbDLzliElCCQ
         TzNY2TNFjBK8vK+Z/GE3WnZa1GMX/P8PApwevfutPKTbk0fhSsYxm4CKo4Kk3/8xfc
         +AtaVzU53e8nw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri,  2 Dec 2022 01:57:35 +0300 (MSK)
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <jian.hu@amlogic.com>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <linux-amlogic@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v8 08/11] dt-bindings: clock: meson: fixup A1 PLL clkc dtb_check errors
Date:   Fri, 2 Dec 2022 01:57:00 +0300
Message-ID: <20221201225703.6507-9-ddrokosov@sberdevices.ru>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/12/01 20:49:00 #20634374
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During running dtbs_check and dt_binding_check checkers the following
problems were found and resolved:
    - $id is not correct, it has wrong url path
    - CLKIDs aren't applied by names, just magic int constants there
    - address and size cells are required for long reg definition
    - wrong indentations

Also this patch adds new A1 clk controllers dt bindings to MAINTAINERS.

Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 27 ++++++++++++-------
 MAINTAINERS                                   |  1 +
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
index d67250fbeece..83f98a73c04e 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
+++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/amlogic,a1-pll-clkc.yaml#"
+$id: "http://devicetree.org/schemas/clock/amlogic,a1-pll-clkc.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
 title: Amlogic Meson A/C serials PLL Clock Control Unit Device Tree Bindings
@@ -10,6 +10,7 @@ maintainers:
   - Neil Armstrong <narmstrong@baylibre.com>
   - Jerome Brunet <jbrunet@baylibre.com>
   - Jian Hu <jian.hu@jian.hu.com>
+  - Dmitry Rokosov <ddrokosov@sberdevices.ru>
 
 properties:
   compatible:
@@ -23,8 +24,8 @@ properties:
 
   clocks:
     items:
-     - description: input xtal_fixpll
-     - description: input xtal_hifipll
+      - description: input xtal_fixpll
+      - description: input xtal_hifipll
 
   clock-names:
     items:
@@ -42,11 +43,17 @@ additionalProperties: false
 
 examples:
   - |
-    clkc_pll: pll-clock-controller@7c80 {
-                compatible = "amlogic,a1-pll-clkc";
-                reg = <0 0x7c80 0 0x18c>;
-                #clock-cells = <1>;
-                clocks = <&clkc_periphs 1>,
-                         <&clkc_periphs 4>;
-                clock-names = "xtal_fixpll", "xtal_hifipll";
+    #include <dt-bindings/clock/a1-clkc.h>
+    apb {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clkc_pll: pll-clock-controller@7c80 {
+            compatible = "amlogic,a1-pll-clkc";
+            reg = <0 0x7c80 0 0x18c>;
+            #clock-cells = <1>;
+            clocks = <&clkc_periphs CLKID_XTAL_FIXPLL>,
+                     <&clkc_periphs CLKID_XTAL_HIFIPLL>;
+            clock-names = "xtal_fixpll", "xtal_hifipll";
+        };
     };
diff --git a/MAINTAINERS b/MAINTAINERS
index e04d944005ba..a02d81edeb4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1837,6 +1837,7 @@ L:	linux-amlogic@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/amlogic*
 F:	drivers/clk/meson/
+F:	include/dt-bindings/clock/a1*
 F:	include/dt-bindings/clock/gxbb*
 F:	include/dt-bindings/clock/meson*
 
-- 
2.36.0

