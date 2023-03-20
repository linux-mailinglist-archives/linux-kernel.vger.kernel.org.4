Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498B56C25D0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCTXlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjCTXl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:41:29 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1998716318;
        Mon, 20 Mar 2023 16:40:35 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso14634456fac.12;
        Mon, 20 Mar 2023 16:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WTjElMD2e38UsgsTs97igwD/ZfRZyIeExtZdYYvY0Bg=;
        b=tuEANuSON0TK8CtCuSGwIK/ZPaX7WclgJLMuL6LaVCeB0RZnW6mtIh+hW1Fom37jys
         LLenkZ9s+RPZOw07wwlmF8EopUbxFihYCLoA4mrB3v/byoWQ4/5rmMheBC7PEtMsEFbe
         FS1YTBviqu0LWnHiWR+N/6MWWKYj867KlTwal8f/xc7k6FEngj0CIThEYxZFb4jpCdTu
         vwP3d1P3qgd2HcFWReh7+0isWcfQ89uMJa3jrZxGVoPXajoSaeb7k5Msys3HUY3IEkXm
         PTR6IgygUbsAQPGM7bDng5mcfylsyW3Xtu2mpeERLYoMVyTycyibBU8fqmkUVjxwE2k8
         2ZXQ==
X-Gm-Message-State: AO0yUKWzzTHYoI/eu6qxAHdBt3JX+Pmk5EUsHUyJt1Ja+oy24HxHf0wU
        1SvGJ/jWrxgX9WxyWS9od4hWyZIflA==
X-Google-Smtp-Source: AK7set+hHdPoFGWzZ5ptnA09Ix+Hy815lPMvG22c3graSik823dt7vi0hqhv7XA1SsJzcgYAnv6ZpQ==
X-Received: by 2002:a05:6870:8325:b0:177:a8a8:657 with SMTP id p37-20020a056870832500b00177a8a80657mr116991oae.10.1679355513269;
        Mon, 20 Mar 2023 16:38:33 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id vl9-20020a0568710e8900b0017ad7a5f57dsm3785814oab.11.2023.03.20.16.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:38:32 -0700 (PDT)
Received: (nullmailer pid 2919676 invoked by uid 1000);
        Mon, 20 Mar 2023 23:38:31 -0000
From:   Rob Herring <robh@kernel.org>
To:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2] dt-bindings: display: Drop unneeded quotes
Date:   Mon, 20 Mar 2023 18:38:21 -0500
Message-Id: <20230320233823.2919475-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Also drop quotes on URLs
---
 .../bindings/auxdisplay/holtek,ht16k33.yaml   |  2 +-
 .../display/amlogic,meson-dw-hdmi.yaml        |  4 ++--
 .../bindings/display/amlogic,meson-vpu.yaml   |  4 ++--
 .../display/bridge/analogix,anx7625.yaml      |  4 ++--
 .../display/bridge/cdns,mhdp8546.yaml         |  4 ++--
 .../bindings/display/bridge/nxp,ptn3460.yaml  |  2 +-
 .../display/bridge/toshiba,tc358767.yaml      |  2 +-
 .../bindings/display/dp-aux-bus.yaml          |  2 +-
 .../bindings/display/imx/nxp,imx8mq-dcss.yaml |  4 ++--
 .../display/mediatek/mediatek,hdmi.yaml       |  2 +-
 .../display/msm/dsi-controller-main.yaml      |  8 +++----
 .../bindings/display/msm/dsi-phy-10nm.yaml    |  2 +-
 .../devicetree/bindings/display/msm/gmu.yaml  |  4 ++--
 .../devicetree/bindings/display/msm/gpu.yaml  |  4 ++--
 .../devicetree/bindings/display/msm/mdp4.yaml |  4 ++--
 .../display/panel/ronbo,rb070d30.yaml         |  2 +-
 .../bindings/display/renesas,du.yaml          |  4 ++--
 .../display/tegra/nvidia,tegra114-mipi.yaml   |  2 +-
 .../display/tegra/nvidia,tegra124-sor.yaml    | 12 +++++-----
 .../display/tegra/nvidia,tegra186-dc.yaml     |  4 ++--
 .../tegra/nvidia,tegra186-dsi-padctl.yaml     |  2 +-
 .../display/tegra/nvidia,tegra20-dsi.yaml     | 12 +++++-----
 .../display/tegra/nvidia,tegra20-hdmi.yaml    |  6 ++---
 .../bindings/display/ti/ti,am65x-dss.yaml     |  6 ++---
 .../bindings/display/ti/ti,j721e-dss.yaml     |  4 ++--
 .../bindings/display/ti/ti,k2g-dss.yaml       |  4 ++--
 .../display/xylon,logicvc-display.yaml        | 22 +++++++++----------
 27 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
index fc4873deb76f..4f6ffb8182a9 100644
--- a/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
+++ b/Documentation/devicetree/bindings/auxdisplay/holtek,ht16k33.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Robin van der Gracht <robin@protonic.nl>
 
 allOf:
-  - $ref: "/schemas/input/matrix-keymap.yaml#"
+  - $ref: /schemas/input/matrix-keymap.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
index 74cefdf1b843..0c85894648d8 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/display/amlogic,meson-dw-hdmi.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/display/amlogic,meson-dw-hdmi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic specific extensions to the Synopsys Designware HDMI Controller
 
diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
index 6655a93b1874..0c72120acc4f 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/display/amlogic,meson-vpu.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/display/amlogic,meson-vpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Meson Display Controller
 
diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
index 4590186c4a0b..b42553ac505c 100644
--- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 Analogix Semiconductor, Inc.
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/display/bridge/analogix,anx7625.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/display/bridge/analogix,anx7625.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Analogix ANX7625 SlimPort (4K Mobile HD Transmitter)
 
diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
index b2e8bc6da9d0..c2b369456e4e 100644
--- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/display/bridge/cdns,mhdp8546.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/display/bridge/cdns,mhdp8546.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Cadence MHDP8546 bridge
 
diff --git a/Documentation/devicetree/bindings/display/bridge/nxp,ptn3460.yaml b/Documentation/devicetree/bindings/display/bridge/nxp,ptn3460.yaml
index 107dd138e6c6..cdeb67bc05f0 100644
--- a/Documentation/devicetree/bindings/display/bridge/nxp,ptn3460.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/nxp,ptn3460.yaml
@@ -18,7 +18,7 @@ properties:
     maxItems: 1
 
   edid-emulation:
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     description:
       The EDID emulation entry to use
       Value  Resolution  Description
diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.yaml
index 140927884418..e1494b5007cb 100644
--- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358767.yaml
@@ -23,7 +23,7 @@ properties:
         i2c address of the bridge, 0x68 or 0x0f, depending on bootstrap pins
 
   clock-names:
-    const: "ref"
+    const: ref
 
   clocks:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/display/dp-aux-bus.yaml b/Documentation/devicetree/bindings/display/dp-aux-bus.yaml
index 5e4afe9f98fb..0ece7b01790b 100644
--- a/Documentation/devicetree/bindings/display/dp-aux-bus.yaml
+++ b/Documentation/devicetree/bindings/display/dp-aux-bus.yaml
@@ -26,7 +26,7 @@ description:
 
 properties:
   $nodename:
-    const: "aux-bus"
+    const: aux-bus
 
   panel:
     $ref: panel/panel-common.yaml#
diff --git a/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml b/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
index 989ab312c1f4..4ae6328cde64 100644
--- a/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
+++ b/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 NXP
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/display/imx/nxp,imx8mq-dcss.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/display/imx/nxp,imx8mq-dcss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: iMX8MQ Display Controller Subsystem (DCSS)
 
diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
index 8afdd67d6780..b90b6d18a828 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.yaml
@@ -50,7 +50,7 @@ properties:
       - const: hdmi
 
   mediatek,syscon-hdmi:
-    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       - items:
           - description: phandle to system configuration registers
diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index e75a3efe4dac..2188d7c9b0bb 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -74,7 +74,7 @@ properties:
 
   syscon-sfpb:
     description: A phandle to mmss_sfpb syscon node (only for DSIv2).
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   qcom,dual-dsi-mode:
     type: boolean
@@ -105,14 +105,14 @@ properties:
     type: object
 
   ports:
-    $ref: "/schemas/graph.yaml#/properties/ports"
+    $ref: /schemas/graph.yaml#/properties/ports
     description: |
       Contains DSI controller input and output ports as children, each
       containing one endpoint subnode.
 
     properties:
       port@0:
-        $ref: "/schemas/graph.yaml#/$defs/port-base"
+        $ref: /schemas/graph.yaml#/$defs/port-base
         unevaluatedProperties: false
         description: |
           Input endpoints of the controller.
@@ -128,7 +128,7 @@ properties:
                   enum: [ 0, 1, 2, 3 ]
 
       port@1:
-        $ref: "/schemas/graph.yaml#/$defs/port-base"
+        $ref: /schemas/graph.yaml#/$defs/port-base
         unevaluatedProperties: false
         description: |
           Output endpoints of the controller.
diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
index 3ec466c3ab38..e6b00d7387ce 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
@@ -58,7 +58,7 @@ properties:
       maximum: 31
 
   qcom,phy-drive-ldo-level:
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     description:
       The PHY LDO has an amplitude tuning feature to adjust the LDO output
       for the HSTX drive. Use supported levels (mV) to offset the drive level
diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index ab14e81cb050..029d72822d8b 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -3,8 +3,8 @@
 %YAML 1.2
 ---
 
-$id: "http://devicetree.org/schemas/display/msm/gmu.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/display/msm/gmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: GMU attached to certain Adreno GPUs
 
diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index d4191cca71fb..5dabe7b6794b 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -2,8 +2,8 @@
 %YAML 1.2
 ---
 
-$id: "http://devicetree.org/schemas/display/msm/gpu.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/display/msm/gpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Adreno or Snapdragon GPUs
 
diff --git a/Documentation/devicetree/bindings/display/msm/mdp4.yaml b/Documentation/devicetree/bindings/display/msm/mdp4.yaml
index 58c13f5277b6..35204a287579 100644
--- a/Documentation/devicetree/bindings/display/msm/mdp4.yaml
+++ b/Documentation/devicetree/bindings/display/msm/mdp4.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/display/msm/mdp4.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/display/msm/mdp4.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Adreno/Snapdragon MDP4 display controller
 
diff --git a/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml b/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
index d67617f6f74a..95ce22c6787a 100644
--- a/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ronbo,rb070d30.yaml
@@ -37,7 +37,7 @@ properties:
 
   backlight:
     description: Backlight used by the panel
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/display/renesas,du.yaml b/Documentation/devicetree/bindings/display/renesas,du.yaml
index d4830f52c512..c5b9e6812bce 100644
--- a/Documentation/devicetree/bindings/display/renesas,du.yaml
+++ b/Documentation/devicetree/bindings/display/renesas,du.yaml
@@ -76,7 +76,7 @@ properties:
     unevaluatedProperties: false
 
   renesas,cmms:
-    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       maxItems: 1
     description:
@@ -84,7 +84,7 @@ properties:
       available DU channel.
 
   renesas,vsps:
-    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       items:
         - description: phandle to VSP instance that serves the DU channel
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml
index d5ca8cf86e8e..f448624dd779 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra114-mipi.yaml
@@ -38,7 +38,7 @@ properties:
     description: The number of cells in a MIPI calibration specifier.
       Should be 1. The single cell specifies a bitmask of the pads that
       need to be calibrated for a given device.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     const: 1
 
 additionalProperties: false
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.yaml
index 907fb0baccae..70f0e45c71d6 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra124-sor.yaml
@@ -69,12 +69,12 @@ properties:
   # Tegra186 and later
   nvidia,interface:
     description: index of the SOR interface
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
 
   nvidia,ddc-i2c-bus:
     description: phandle of an I2C controller used for DDC EDID
       probing
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   nvidia,hpd-gpio:
     description: specifies a GPIO used for hotplug detection
@@ -82,23 +82,23 @@ properties:
 
   nvidia,edid:
     description: supplies a binary EDID blob
-    $ref: "/schemas/types.yaml#/definitions/uint8-array"
+    $ref: /schemas/types.yaml#/definitions/uint8-array
 
   nvidia,panel:
     description: phandle of a display panel, required for eDP
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   nvidia,xbar-cfg:
     description: 5 cells containing the crossbar configuration.
       Each lane of the SOR, identified by the cell's index, is
       mapped via the crossbar to the pad specified by the cell's
       value.
-    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+    $ref: /schemas/types.yaml#/definitions/uint32-array
 
   # optional when driving an eDP output
   nvidia,dpaux:
     description: phandle to a DispayPort AUX interface
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
 
 allOf:
   - if:
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml
index 265a60d79d89..ce4589466a18 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml
@@ -60,13 +60,13 @@ properties:
   nvidia,outputs:
     description: A list of phandles of outputs that this display
       controller can drive.
-    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    $ref: /schemas/types.yaml#/definitions/phandle-array
 
   nvidia,head:
     description: The number of the display controller head. This
       is used to setup the various types of output to receive
       video data from the given head.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dsi-padctl.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dsi-padctl.yaml
index e5a6145c8c53..da75b71e8ece 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dsi-padctl.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra186-dsi-padctl.yaml
@@ -29,7 +29,7 @@ properties:
       - const: dsi
 
 allOf:
-  - $ref: "/schemas/reset/reset.yaml"
+  - $ref: /schemas/reset/reset.yaml
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml
index 511cbe74e729..59e1dc0813e7 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dsi.yaml
@@ -59,12 +59,12 @@ properties:
     description: Should contain a phandle and a specifier specifying
       which pads are used by this DSI output and need to be
       calibrated. See nvidia,tegra114-mipi.yaml for details.
-    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    $ref: /schemas/types.yaml#/definitions/phandle-array
 
   nvidia,ddc-i2c-bus:
     description: phandle of an I2C controller used for DDC EDID
       probing
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   nvidia,hpd-gpio:
     description: specifies a GPIO used for hotplug detection
@@ -72,19 +72,19 @@ properties:
 
   nvidia,edid:
     description: supplies a binary EDID blob
-    $ref: "/schemas/types.yaml#/definitions/uint8-array"
+    $ref: /schemas/types.yaml#/definitions/uint8-array
 
   nvidia,panel:
     description: phandle of a display panel
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   nvidia,ganged-mode:
     description: contains a phandle to a second DSI controller to
       gang up with in order to support up to 8 data lanes
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
 
 allOf:
-  - $ref: "../dsi-controller.yaml#"
+  - $ref: ../dsi-controller.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml
index f65e59cfffa7..f77197e4869f 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-hdmi.yaml
@@ -68,7 +68,7 @@ properties:
   nvidia,ddc-i2c-bus:
     description: phandle of an I2C controller used for DDC EDID
       probing
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   nvidia,hpd-gpio:
     description: specifies a GPIO used for hotplug detection
@@ -76,11 +76,11 @@ properties:
 
   nvidia,edid:
     description: supplies a binary EDID blob
-    $ref: "/schemas/types.yaml#/definitions/uint8-array"
+    $ref: /schemas/types.yaml#/definitions/uint8-array
 
   nvidia,panel:
     description: phandle of a display panel
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
 
   "#sound-dai-cells":
     const: 0
diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
index 5c7d2cbc4aac..b6b402f16161 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 Texas Instruments Incorporated
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/display/ti/ti,am65x-dss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Texas Instruments AM65x Display Subsystem
 
@@ -88,7 +88,7 @@ properties:
           The DSS DPI output port node from video port 2
 
   ti,am65x-oldi-io-ctrl:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
     description:
       phandle to syscon device node mapping OLDI IO_CTRL registers.
       The mapped range should point to OLDI_DAT0_IO_CTRL, map it and
diff --git a/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
index 2986f9acc9f0..fad7cba58d39 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,j721e-dss.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 Texas Instruments Incorporated
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/display/ti/ti,j721e-dss.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/display/ti/ti,j721e-dss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Texas Instruments J721E Display Subsystem
 
diff --git a/Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
index 7ce7bbad5780..96b1439f88e3 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 Texas Instruments Incorporated
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/display/ti/ti,k2g-dss.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/display/ti/ti,k2g-dss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Texas Instruments K2G Display Subsystem
 
diff --git a/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml b/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
index fc02c5d50ce4..76b804b7c880 100644
--- a/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
+++ b/Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 Bootlin
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/display/xylon,logicvc-display.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/display/xylon,logicvc-display.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Xylon LogiCVC display controller
 
@@ -89,25 +89,25 @@ properties:
     description: Display output colorspace (C_DISPLAY_COLOR_SPACE).
 
   xylon,display-depth:
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: Display output depth (C_PIXEL_DATA_WIDTH).
 
   xylon,row-stride:
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     description: Fixed number of pixels in a framebuffer row (C_ROW_STRIDE).
 
   xylon,dithering:
-    $ref: "/schemas/types.yaml#/definitions/flag"
+    $ref: /schemas/types.yaml#/definitions/flag
     description: Dithering module is enabled (C_XCOLOR)
 
   xylon,background-layer:
-    $ref: "/schemas/types.yaml#/definitions/flag"
+    $ref: /schemas/types.yaml#/definitions/flag
     description: |
       The last layer is used to display a black background (C_USE_BACKGROUND).
       The layer must still be registered.
 
   xylon,layers-configurable:
-    $ref: "/schemas/types.yaml#/definitions/flag"
+    $ref: /schemas/types.yaml#/definitions/flag
     description: |
       Configuration of layers' size, position and offset is enabled
       (C_USE_SIZE_POSITION).
@@ -131,7 +131,7 @@ properties:
             maxItems: 1
 
           xylon,layer-depth:
-            $ref: "/schemas/types.yaml#/definitions/uint32"
+            $ref: /schemas/types.yaml#/definitions/uint32
             description: Layer depth (C_LAYER_X_DATA_WIDTH).
 
           xylon,layer-colorspace:
@@ -151,19 +151,19 @@ properties:
             description: Alpha mode for the layer (C_LAYER_X_ALPHA_MODE).
 
           xylon,layer-base-offset:
-            $ref: "/schemas/types.yaml#/definitions/uint32"
+            $ref: /schemas/types.yaml#/definitions/uint32
             description: |
               Offset in number of lines (C_LAYER_X_OFFSET) starting from the
               video RAM base (C_VMEM_BASEADDR), only for version 3.
 
           xylon,layer-buffer-offset:
-            $ref: "/schemas/types.yaml#/definitions/uint32"
+            $ref: /schemas/types.yaml#/definitions/uint32
             description: |
               Offset in number of lines (C_BUFFER_*_OFFSET) starting from the
               layer base offset for the second buffer used in double-buffering.
 
           xylon,layer-primary:
-            $ref: "/schemas/types.yaml#/definitions/flag"
+            $ref: /schemas/types.yaml#/definitions/flag
             description: |
               Layer should be registered as a primary plane (exactly one is
               required).
-- 
2.39.2

