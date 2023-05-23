Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E806370D740
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbjEWIXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjEWIWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 04:22:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910ED199E
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 01:19:54 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1q1NFB-00042m-Vo; Tue, 23 May 2023 10:19:46 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1q1NFA-002CaT-VV; Tue, 23 May 2023 10:19:44 +0200
Received: from localhost ([::1] helo=dude03.red.stw.pengutronix.de)
        by dude03.red.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1q1NF9-006uEf-PF; Tue, 23 May 2023 10:19:43 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
Date:   Tue, 23 May 2023 10:19:42 +0200
Subject: [PATCH v2 2/3] dt-bindings: display: simple: support non-default
 data-mapping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230523-simplepanel_support_nondefault_datamapping-v2-2-87196f0d0b64@pengutronix.de>
References: <20230523-simplepanel_support_nondefault_datamapping-v2-0-87196f0d0b64@pengutronix.de>
In-Reply-To: <20230523-simplepanel_support_nondefault_datamapping-v2-0-87196f0d0b64@pengutronix.de>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        patchwork-jzi@pengutronix.de, kernel@pengutronix.de,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Zink <j.zink@pengutronix.de>
X-Mailer: b4 0.12.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Displays support more than just a single default lvds data mapping,
which can be used to run displays on only 3 LVDS lanes in the jeida-18
data-mapping mode.

Add an optional data-mapping property to allow overriding the default
data mapping. As it does not generally apply to any display and bus: use
it selectively on the innolux,g101ice-l01, which supports changing the
data mapping via a strapping pin.

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>

---

Changes:

v1 -> v2: - worked in Rob's review findings (thanks for reviewing my
            work): use extracted common property instead of duplicating
	    the property
	  - refined commit message
	  - add an example dts for automated checking
---
 .../bindings/display/panel/panel-simple.yaml       | 26 +++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index ec50dd268314..698301c8c920 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -21,9 +21,9 @@ description: |
 
 allOf:
   - $ref: panel-common.yaml#
+  - $ref: ../lvds-data-mapping.yaml#
 
 properties:
-
   compatible:
     enum:
     # compatible must be listed in alphabetical order, ordered by compatible.
@@ -353,6 +353,17 @@ properties:
   power-supply: true
   no-hpd: true
   hpd-gpios: true
+  data-mapping: true
+
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          const: innolux,g101ice-l01
+then:
+  properties:
+    data-mapping: false
 
 additionalProperties: false
 
@@ -372,3 +383,16 @@ examples:
         };
       };
     };
+  - |
+    panel_lvds: panel-lvds {
+      compatible = "innolux,g101ice-l01";
+      power-supply = <&vcc_lcd_reg>;
+
+      data-mapping = "jeida-24";
+
+      port {
+        panel_in_lvds: endpoint {
+          remote-endpoint = <&ltdc_out_lvds>;
+        };
+      };
+    };

-- 
2.39.2

