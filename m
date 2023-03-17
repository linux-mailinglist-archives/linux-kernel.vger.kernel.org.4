Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FA06BF68E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 00:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjCQXhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 19:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCQXgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 19:36:48 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024CF6703F;
        Fri, 17 Mar 2023 16:36:46 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id bp11so3566878ilb.3;
        Fri, 17 Mar 2023 16:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679096205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4XTbDitSJ3rKysE1DLB9E8NyDF7QczD+upv2sRYh/A=;
        b=MC4YINorqYBhsFbpcR4YtnGpZceDJPpHfc+Ov6YITUw2DWJlajX/9RwreFYlbag1P8
         ivUwvC43aa2+PwEJxMG03U9lcCA6d2qMA9NBk7XvF10A53/9W5GWTjQSqPW4mpBt/gBu
         hAJCN4bM3ks9iMQr8ys89E0ffqKmBSUUjRXiN1EmLz7LWj8Am/3rOGSN+4XxGK+5EtZM
         6gRAkOEfrQn52Bjl2Zkzd1G3XHW0CJ5XSNqWYXrTyM28Ey8MWz7FF2R6xyCKoutRP8lJ
         mlYLDCL7dnM5C2Na8M7SwwGHAb9VYpwiZzy2r5jtDi2ZClH37yScz65yGbNXR9auqoq/
         uf6A==
X-Gm-Message-State: AO0yUKUSq2jDsR8lLeiU+N19z1CcsmdiEBv/crdc2SyL15SCsPtPfmJp
        yCetmN4CfOijnGPQAgLYHw==
X-Google-Smtp-Source: AK7set8aHEa/CzpkLLAxRrITL3AbBi24Em4TUycz18OMjy74rr/iSfbAP+RwpGIsk3i1yF/MYXGnsg==
X-Received: by 2002:a05:6e02:1ca3:b0:323:5d8:57d2 with SMTP id x3-20020a056e021ca300b0032305d857d2mr180521ill.4.1679096205572;
        Fri, 17 Mar 2023 16:36:45 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id y19-20020a056e02119300b0031830e2c987sm962469ili.20.2023.03.17.16.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 16:36:45 -0700 (PDT)
Received: (nullmailer pid 3968975 invoked by uid 1000);
        Fri, 17 Mar 2023 23:36:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: nvmem: Drop unneeded quotes
Date:   Fri, 17 Mar 2023 18:36:39 -0500
Message-Id: <20230317233640.3968821-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml      | 2 +-
 Documentation/devicetree/bindings/nvmem/apple,efuses.yaml       | 2 +-
 Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml         | 2 +-
 Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml | 2 +-
 Documentation/devicetree/bindings/nvmem/imx-iim.yaml            | 2 +-
 Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml          | 2 +-
 .../devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml         | 2 +-
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml     | 2 +-
 .../devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml       | 2 +-
 Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml          | 2 +-
 Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml       | 2 +-
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml        | 2 +-
 Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml     | 2 +-
 Documentation/devicetree/bindings/nvmem/rmem.yaml               | 2 +-
 Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml     | 2 +-
 .../devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml     | 2 +-
 Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml     | 2 +-
 .../devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml         | 2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
index 14c170c6a86e..296001e7f498 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Maxime Ripard <mripard@kernel.org>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
index 5ec8f2bdb3a5..e0860b6b85f3 100644
--- a/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
+++ b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
@@ -15,7 +15,7 @@ maintainers:
   - Sven Peter <sven@svenpeter.dev>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
index 25033de3ef6b..36def7128fca 100644
--- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
+++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
@@ -20,7 +20,7 @@ maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index 3b4e6e94cb81..70fb2ad25103 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -14,7 +14,7 @@ description: |
   unique identifier per part.
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/imx-iim.yaml b/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
index 7aac1995cfaf..e9d9d8df4811 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-iim.yaml
@@ -14,7 +14,7 @@ description: |
   i.MX25, i.MX27, i.MX31, i.MX35, i.MX51 and i.MX53 SoCs.
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index d0a239d7e199..9876243ff1e8 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -15,7 +15,7 @@ description: |
   i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN and i.MX8MP SoCs.
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
index fe2cd7f1afba..e89fd879c968 100644
--- a/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml
@@ -10,7 +10,7 @@ maintainers:
   - PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index 75e0a516e59a..d16d42fb98b6 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -15,7 +15,7 @@ maintainers:
   - Lala Lin <lala.lin@mediatek.com>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   $nodename:
diff --git a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
index c3c96fd0baac..a296d348adb4 100644
--- a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
+++ b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
@@ -15,7 +15,7 @@ description: |
   settings, chip identifiers) or user specific data could be stored.
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
index ff317fd7c15b..8938eec22b52 100644
--- a/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mxs-ocotp.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Anson Huang <Anson.Huang@nxp.com>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml b/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
index f93bc50c40d7..6c26800f8b79 100644
--- a/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nintendo-otp.yaml
@@ -17,7 +17,7 @@ maintainers:
   - Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 2173fe82317d..e952907ad1d5 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
index e08504ef3b6e..34818683f80c 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
@@ -15,7 +15,7 @@ description: |
   to/from the PBUS.
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/rmem.yaml b/Documentation/devicetree/bindings/nvmem/rmem.yaml
index a4a755dcfc43..38a39c9b8c1c 100644
--- a/Documentation/devicetree/bindings/nvmem/rmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rmem.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
index febee8129aa9..c5403e149080 100644
--- a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Heiko Stuebner <heiko@sntech.de>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
index dc790d2cd9f0..b8bca0599c45 100644
--- a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   "#address-cells": true
diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
index 172597cc5c63..a69de3e92282 100644
--- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
@@ -16,7 +16,7 @@ maintainers:
   - Fabrice Gasnier <fabrice.gasnier@foss.st.com>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
index a7644ebbc2ca..8877c2283e9e 100644
--- a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Vincent Shih <vincent.sunplus@gmail.com>
 
 allOf:
-  - $ref: "nvmem.yaml#"
+  - $ref: nvmem.yaml#
 
 properties:
   compatible:
-- 
2.39.2

