Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC8B5FD7F8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 12:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiJMKwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 06:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJMKvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 06:51:53 -0400
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D42FF279;
        Thu, 13 Oct 2022 03:51:36 -0700 (PDT)
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 13 Oct 2022 18:51:35 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
        by mse.ite.com.tw with ESMTP id 29DApTjX073258;
        Thu, 13 Oct 2022 18:51:29 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from VirtualBox.internal.ite.com.tw (192.168.70.46) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.14; Thu, 13 Oct 2022 18:51:29 +0800
From:   allen <allen.chen@ite.com.tw>
CC:     Allen Chen <allen.chen@ite.com.tw>,
        Pin-yen Lin <treapking@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: it6505: add properties to restrict output bandwidth
Date:   Thu, 13 Oct 2022 18:51:13 +0800
Message-ID: <20221013105116.180380-2-allen.chen@ite.com.tw>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221013105116.180380-1-allen.chen@ite.com.tw>
References: <20221013105116.180380-1-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.70.46]
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP: C902D7E551BA36576A4CA1E87E219A4A356FAF4AE9A8A8A4F6E008F209DF59172002:8
X-MAIL: mse.ite.com.tw 29DApTjX073258
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: allen chen <allen.chen@ite.com.tw>

Add properties to restrict dp output data-lanes and clock.

Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
---
 .../bindings/display/bridge/ite,it6505.yaml   | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
index 833d11b2303a7..f2c3d1d10359e 100644
--- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
@@ -52,10 +52,51 @@ properties:
     maxItems: 1
     description: extcon specifier for the Power Delivery
 
+  data-lanes:
+    oneOf:
+      - minItems: 1
+        maxItems: 1
+        uniqueItems: true
+        items:
+          enum:
+            - 0
+            - 1
+        description: For one lane operation.
+
+      - minItems: 2
+        maxItems: 2
+        uniqueItems: true
+        items:
+          enum:
+            - 0
+            - 1
+        description: For two lanes operation.
+
+      - minItems: 4
+        maxItems: 4
+        uniqueItems: true
+        items:
+          enum:
+            - 0
+            - 1
+            - 2
+            - 3
+        description: For four lanes operation.
+
   port:
     $ref: /schemas/graph.yaml#/properties/port
     description: A port node pointing to DPI host port node
 
+    properties:
+      endpoint:
+        $ref: /schemas/graph.yaml#/$defs/endpoint-base
+
+        properties:
+          link-frequencies:
+            minItems: 1
+            maxItems: 1
+            description: Allowed max link frequencies in Hz.
+
 required:
   - compatible
   - ovdd-supply
@@ -84,10 +125,12 @@ examples:
             pwr18-supply = <&it6505_pp18_reg>;
             reset-gpios = <&pio 179 1>;
             extcon = <&usbc_extcon>;
+            data-lanes = <0 1>;
 
             port {
                 it6505_in: endpoint {
                     remote-endpoint = <&dpi_out>;
+                    link-frequencies = /bits/ 64 <150000000>;
                 };
             };
         };
-- 
2.25.1

