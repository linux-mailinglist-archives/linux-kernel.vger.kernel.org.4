Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58718622D5A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiKIOTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiKIOTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:19:23 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376611BEB4;
        Wed,  9 Nov 2022 06:19:21 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 97842FF808;
        Wed,  9 Nov 2022 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668003560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PbIcdoBUbNEn6Y5YPfAT65AjVDHZNeQtTTtmrwc4noQ=;
        b=bP7tDi5cvmzh1tA7Rh7yplOM6iQqIn0Tra14zST5XG8da961HgUpkQ/uVNfg300UONuIv6
        9WvuwyyeswR0y7w00r+1oBejYgk+XqEkkrtm+3oPsMNdJK2Ei9bll/64VpHcrkdbtNvPlG
        Z1nwlOgsIDbH3GHpZYpF3eRnKSMQH5JfbelvkFtA5kOKfSzz9YN8aJSexDz44A9QLS6YCP
        PFHrnZrEJs8V2A/gOm/pk11Fo34ortDU+9WDHFtO7w8cWyUS0O/MYBpocfCoGOGo8DuIdC
        fFSvcVtEnAC7pLeHNScOSa+en+K8F3f6tKvlhMCrdv/ocvZll0Cinr107HKhSA==
From:   luca.ceresoli@bootlin.com
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: [PATCH 02/23] dt-bindings: display: tegra: vi: add 'vip' property and example
Date:   Wed,  9 Nov 2022 15:18:31 +0100
Message-Id: <20221109141852.729246-3-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109141852.729246-1-luca.ceresoli@bootlin.com>
References: <20221109141852.729246-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

The Tegra20 VI peripheral can receive parallel input from the VIP parallel
input module. Add it to the allowed properties and augment the existing
nvidia,tegra20-vi example to show a 'vip' property.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 .../display/tegra/nvidia,tegra20-vi.yaml      | 68 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
index 782a4b10150a..aab795241dd6 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
@@ -74,6 +74,22 @@ properties:
   avdd-dsi-csi-supply:
     description: DSI/CSI power supply. Must supply 1.2 V.
 
+  vip:
+    $ref: /schemas/display/tegra/nvidia,tegra20-vip.yaml
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Input from the VIP (parallel input capture) module
+
+        properties:
+          endpoint:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+
 patternProperties:
   "^csi@[0-9a-f]+$":
     type: object
@@ -109,6 +125,22 @@ examples:
     #include <dt-bindings/clock/tegra20-car.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
+    i2c3 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        camera@48 {
+            compatible = "aptina,mt9v111";
+            reg = <0x48>;
+            clocks = <&camera_clk>;
+
+            port {
+                mt9v111_out: endpoint {
+                    remote-endpoint = <&vi_vip_in>;
+                };
+            };
+        };
+    };
+
     vi@54080000 {
         compatible = "nvidia,tegra20-vi";
         reg = <0x54080000 0x00040000>;
@@ -116,6 +148,42 @@ examples:
         clocks = <&tegra_car TEGRA20_CLK_VI>;
         resets = <&tegra_car 100>;
         reset-names = "vi";
+
+        vip {
+            compatible = "nvidia,tegra20-vip";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            channel@0 {
+                reg = <0>;
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                    port@0 {
+                        reg = <0>;
+                        vi_vip_in: endpoint {
+                            remote-endpoint = <&mt9v111_out>;
+                        };
+                    };
+                    port@1 {
+                        reg = <1>;
+                        vi_vip_out: endpoint {
+                            remote-endpoint = <&vi_in>;
+                        };
+                    };
+                };
+            };
+        };
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            port@0 {
+                reg = <0>;
+                vi_in: endpoint {
+                    remote-endpoint = <&vi_vip_out>;
+                };
+            };
+        };
     };
 
   - |
diff --git a/MAINTAINERS b/MAINTAINERS
index b43f6f4e8ccf..0a4f66a32e45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20284,6 +20284,7 @@ M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
 L:	linux-media@vger.kernel.org
 L:	linux-tegra@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
 F:	Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
 
 TEGRA XUSB PADCTL DRIVER
-- 
2.34.1

