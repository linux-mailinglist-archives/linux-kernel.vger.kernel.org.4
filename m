Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6E36C25E5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjCTXm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCTXmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:42:53 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F84E144A0;
        Mon, 20 Mar 2023 16:41:54 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-17aaa51a911so14703777fac.5;
        Mon, 20 Mar 2023 16:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K5DG9ZkQtn4FRPIJJzwqnJ/wNYIHJuC+kgmFbmzvz/8=;
        b=wPXxFU2nQ86V3W6yqqV8tVHwWAaHMYME9OKq3rwnuJtczCcvEDS7/I9Ns/i3y1BOQc
         hBKVdJ9geaSaiLOQt5BidGPbo7t9bGMfv7HcyL0ztFRrQgsOqe9L5uHBCRPUZdi/CU1V
         z4qUK32bmr+eUTeFFPL9ykzAj+5o7oTGv6ewjA9z+vk79cyBn17n8pd94lIDu2RRHUSf
         y7T/y7yMhKA+WvL39y40ZxHGZUc2PPAzjd8MKIa07mN4JNR6rr2QI0Xn8+M9cKbklwa6
         7PJr9rR0iyYRZt9u3HKL/Yy401+orhoOvHvbiDKtFIE0/R+lScUzPMOidHRvAvkXr1fM
         Y3Zw==
X-Gm-Message-State: AO0yUKVl7VKfjR1rQ7jDt2fOer4iQGeNO8BcAmLY2vQUZ3/C9gXWNIvL
        9nudaZXZw/X3hNuRwqzcgQ==
X-Google-Smtp-Source: AK7set+OVVt52OpYolejvcBJwqTnwHsThacTTp8sg0b1O3iBw1LXfEhy6ajkDmdDLpfmiemJlnxhTg==
X-Received: by 2002:a05:6871:88e:b0:172:6cf9:383a with SMTP id r14-20020a056871088e00b001726cf9383amr84969oaq.22.1679355602658;
        Mon, 20 Mar 2023 16:40:02 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d8-20020a0568301b6800b0069bcd7ccf1dsm4511837ote.35.2023.03.20.16.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:40:02 -0700 (PDT)
Received: (nullmailer pid 2921351 invoked by uid 1000);
        Mon, 20 Mar 2023 23:40:00 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Yu Chen <chenyu56@huawei.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-can@vger.kernel.org
Subject: [PATCH] dt-bindings: phy: Drop unneeded quotes
Date:   Mon, 20 Mar 2023 18:39:52 -0500
Message-Id: <20230320233955.2921179-1-robh@kernel.org>
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

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml          | 4 ++--
 .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml         | 2 +-
 .../devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml      | 4 ++--
 .../bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml         | 4 ++--
 .../devicetree/bindings/phy/amlogic,g12a-usb2-phy.yaml      | 4 ++--
 .../devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml | 4 ++--
 .../bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml    | 4 ++--
 .../devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml     | 4 ++--
 .../devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml | 4 ++--
 .../devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml   | 4 ++--
 .../devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml      | 4 ++--
 Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml    | 4 ++--
 Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml   | 4 ++--
 .../devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml      | 4 ++--
 .../devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml      | 6 +++---
 .../bindings/phy/marvell,armada-3700-utmi-phy.yaml          | 4 ++--
 .../bindings/phy/marvell,armada-cp110-utmi-phy.yaml         | 4 ++--
 .../devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml      | 4 ++--
 .../devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml    | 4 ++--
 .../devicetree/bindings/phy/phy-cadence-sierra.yaml         | 4 ++--
 .../devicetree/bindings/phy/phy-cadence-torrent.yaml        | 4 ++--
 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml | 4 ++--
 Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml     | 4 ++--
 Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml   | 4 ++--
 Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml | 4 ++--
 .../devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml     | 4 ++--
 Documentation/devicetree/bindings/phy/qcom,usb-ss.yaml      | 4 ++--
 .../devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml       | 4 ++--
 .../devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml    | 4 ++--
 Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml  | 2 +-
 .../devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml    | 4 ++--
 .../devicetree/bindings/phy/ti,phy-am654-serdes.yaml        | 4 ++--
 Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml  | 4 ++--
 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml | 4 ++--
 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml  | 4 ++--
 35 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml
index c03b83103e87..cf4eed230565 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 Ondrej Jirman <megous@megous.com>
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/allwinner,sun50i-h6-usb3-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/allwinner,sun50i-h6-usb3-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Allwinner H6 USB3 PHY
 
diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
index fe9702e7bdd8..6a4fd4929959 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
@@ -45,7 +45,7 @@ properties:
     maxItems: 1
 
   allwinner,direction:
-    $ref: '/schemas/types.yaml#/definitions/string'
+    $ref: /schemas/types.yaml#/definitions/string
     description: |
       Direction of the D-PHY:
       - "rx" for receiving (e.g. when used with MIPI CSI-2);
diff --git a/Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml
index 5eddaed3d853..64795f170f32 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,axg-mipi-dphy.yaml
@@ -2,8 +2,8 @@
 # Copyright 2020 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/amlogic,axg-mipi-dphy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/amlogic,axg-mipi-dphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic AXG MIPI D-PHY
 
diff --git a/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
index 7aa0c05d6ce4..c8c83acfb871 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic G12A MIPI analog PHY
 
diff --git a/Documentation/devicetree/bindings/phy/amlogic,g12a-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,g12a-usb2-phy.yaml
index bb01c6b34dab..0031fb6a4e76 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,g12a-usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,g12a-usb2-phy.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/amlogic,g12a-usb2-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/amlogic,g12a-usb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic G12A USB2 PHY
 
diff --git a/Documentation/devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml
index 3314711292d6..1a5a12adb72b 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/amlogic,g12a-usb3-pcie-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/amlogic,g12a-usb3-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic G12A USB3 + PCIE Combo PHY
 
diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
index a90fa1baadab..009a39808318 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/amlogic,meson-axg-mipi-pcie-analog.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/amlogic,meson-axg-mipi-pcie-analog.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic AXG shared MIPI/PCIE analog PHY
 
diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
index 45f3d72b1cca..40fbf8ac3271 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-pcie.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/amlogic,meson-axg-pcie.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/amlogic,meson-axg-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic AXG PCIE PHY
 
diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
index 1f085cdd1c85..6f9fd1c953f0 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/amlogic,meson8-hdmi-tx-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/amlogic,meson8-hdmi-tx-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Meson8, Meson8b and Meson8m2 HDMI TX PHY
 
diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
index 03c4809dbe8d..df68bfe5f407 100644
--- a/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/amlogic,meson8b-usb2-phy.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/amlogic,meson8b-usb2-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/amlogic,meson8b-usb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Meson8, Meson8b, Meson8m2 and GXBB USB2 PHY
 
diff --git a/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
index 0f0bcde9eb88..bd527f566c3b 100644
--- a/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/brcm,bcm63xx-usbh-phy.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/brcm,bcm63xx-usbh-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/brcm,bcm63xx-usbh-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: BCM63xx USBH PHY
 
diff --git a/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
index 435b971dfd9b..8467c8e6368c 100644
--- a/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/brcm,sata-phy.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/brcm,sata-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/brcm,sata-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Broadcom SATA3 PHY
 
diff --git a/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml b/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
index 3a07285b5470..c9e65a2facd5 100644
--- a/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/cdns,salvo-phy.yaml
@@ -2,8 +2,8 @@
 # Copyright (c) 2020 NXP
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/cdns,salvo-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/cdns,salvo-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Cadence SALVO PHY
 
diff --git a/Documentation/devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml b/Documentation/devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml
index b11d9873854a..405c6b0b88c0 100644
--- a/Documentation/devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml
+++ b/Documentation/devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml
@@ -19,11 +19,11 @@ properties:
     const: 0
 
   hisilicon,pericrg-syscon:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: phandle of syscon used to control iso refclk.
 
   hisilicon,pctrl-syscon:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: phandle of syscon used to control usb tcxo.
 
   hisilicon,eye-diagram-param:
diff --git a/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml b/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
index 3c69aca6c7eb..a1a8a84dfc54 100644
--- a/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
+++ b/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
@@ -20,15 +20,15 @@ properties:
     const: 0
 
   hisilicon,pericrg-syscon:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: phandle of syscon used to control iso refclk.
 
   hisilicon,pctrl-syscon:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: phandle of syscon used to control usb tcxo.
 
   hisilicon,sctrl-syscon:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: phandle of syscon used to control phy deep sleep.
 
   hisilicon,eye-diagram-param:
diff --git a/Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml
index 632d61c07f40..3aa1a46796dd 100644
--- a/Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml
@@ -2,8 +2,8 @@
 
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/marvell,armada-3700-utmi-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/marvell,armada-3700-utmi-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Marvell Armada UTMI/UTMI+ PHY
 
diff --git a/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
index 43416c216190..9ce7b4c6d208 100644
--- a/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/marvell,armada-cp110-utmi-phy.yaml
@@ -2,8 +2,8 @@
 
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/marvell,armada-cp110-utmi-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/marvell,armada-cp110-utmi-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Marvell Armada CP110/CP115 UTMI PHY
 
diff --git a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
index ff255aa4cc10..bd3bd2f8b1cd 100644
--- a/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/marvell,mmp3-hsic-phy.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 Lubomir Rintel <lkundrak@v3.sk>
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/marvell,mmp3-hsic-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/marvell,mmp3-hsic-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Marvell MMP3 HSIC PHY
 
diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
index c2f4cb0b254a..b35c4d256e40 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/mediatek,mt7621-pci-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/mediatek,mt7621-pci-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Mediatek Mt7621 PCIe PHY
 
diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
index 6a09472740ed..c3d1fa102798 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/phy-cadence-sierra.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/phy-cadence-sierra.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Cadence Sierra PHY
 
diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 2ad1faadda2a..dc92be05fe5f 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/phy-cadence-torrent.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/phy-cadence-torrent.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Cadence Torrent SD0801 PHY
 
diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
index 445b2467f4f6..4790c6238a40 100644
--- a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/phy-tegra194-p2u.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/phy-tegra194-p2u.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: NVIDIA Tegra194 & Tegra234 P2U
 
diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
index 1e104ae76ee6..c4f8e6ffa5c3 100644
--- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
@@ -2,8 +2,8 @@
 
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/qcom,edp-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/qcom,edp-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm eDP PHY
 
diff --git a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
index 7f403e77f320..543c1a2811a5 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qusb2-phy.yaml
@@ -2,8 +2,8 @@
 
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/qcom,qusb2-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/qcom,qusb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm QUSB2 phy controller
 
diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml
index ca6a0836b53c..6c99e02b2b4f 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/qcom,usb-hs-28nm.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/qcom,usb-hs-28nm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Synopsys DesignWare Core 28nm High-Speed PHY
 
diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 85d405e028b9..a26524b7e7b7 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/qcom,usb-snps-femto-v2.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/qcom,usb-snps-femto-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Synopsys Femto High-Speed USB PHY V2
 
diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-ss.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-ss.yaml
index bd1388d62ce0..6e4254ff1cd7 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-ss.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-ss.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/qcom,usb-ss.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/qcom,usb-ss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Synopsys 1.0.0 SuperSpeed USB PHY
 
diff --git a/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml b/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
index 3e7191b168fb..09c614952fea 100644
--- a/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/qcom-usb-ipq4019-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/qcom-usb-ipq4019-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcom IPQ40xx Dakota HS/SS USB PHY
 
diff --git a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
index 28e299a9609d..41df8bb08ff7 100644
--- a/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml
@@ -21,12 +21,12 @@ properties:
     maxItems: 1
 
   samsung,pmu-syscon:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: phandle for PMU system controller interface, used to
                  control PMU registers bits for PCIe PHY
 
   samsung,fsys-sysreg:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: phandle for FSYS sysreg interface, used to control
                  sysreg registers bits for PCIe PHY
 
diff --git a/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
index c5dbb91ac402..782f975b43ae 100644
--- a/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
@@ -35,7 +35,7 @@ properties:
     maxItems: 4
 
   samsung,pmu-syscon:
-    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     maxItems: 1
     items:
       minItems: 1
diff --git a/Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml
index 069d422775bb..57914f214e06 100644
--- a/Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/sunplus,sp7021-usb2-phy.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) Sunplus Co., Ltd. 2021
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/sunplus,sp7021-usb2-phy.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/sunplus,sp7021-usb2-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Sunplus SP7021 USB 2.0 PHY Controller
 
diff --git a/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.yaml b/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.yaml
index 738c92bb7518..2a886b91bf2d 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.yaml
@@ -35,9 +35,9 @@ properties:
       clock.
 
   assigned-clocks:
-    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    $ref: /schemas/types.yaml#/definitions/phandle-array
   assigned-clock-parents:
-    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    $ref: /schemas/types.yaml#/definitions/phandle-array
 
   '#phy-cells':
     const: 2
diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
index 6d46f57fa1b4..3699a06bdf6e 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/ti,phy-gmii-sel.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/ti,phy-gmii-sel.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: CPSW Port's Interface Mode Selection PHY
 
diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index c54b36c104ab..a55fc0f24533 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -2,8 +2,8 @@
 # Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/ti,phy-j721e-wiz.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/ti,phy-j721e-wiz.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TI J721E WIZ (SERDES Wrapper)
 
diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 237295b2b5a8..79dad3e89aa6 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/phy/ti,tcan104x-can.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/phy/ti,tcan104x-can.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TCAN104x CAN TRANSCEIVER PHY
 
-- 
2.39.2

