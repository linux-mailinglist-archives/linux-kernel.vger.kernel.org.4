Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357FA672533
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjARRkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjARRjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:39:53 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49DA59B47
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:39:48 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r2so34723129wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8zAUxFAa6lgoBmjDrVTvJWNlnuKPEoPpig68boL1vlc=;
        b=wiyLrKzuIwLqu0gkfqhRUOcgUSvxSnHWc+GoURfGb5vd1vItbsEZP0qVQ2W4UTjxFS
         YLRkwIXhykjmiEMcXtiXHYurzSRQg9iL2zZPjtX1CDaAWuvCX9ORGO1eZaCYAd2JjUcw
         unxKalcXAkbCuzPr4KhrdoSMorIkKFY0fhQ7UjplSFVvZdJizlpHflFJ5+jtR6eBDWUG
         ttPOkBP5ERSC5etHjjIg/jSpnwxOsL4Hfj96rEPER/DLogHbAfUqIll46wYsT0ZQ3Bo6
         MdF4uI3eNTfBT4ZrDDSRKdJSn4pwj6wT/W/PW5bPo8NloVY4BJ+/fq4fToYe0NRm8qgL
         ZafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zAUxFAa6lgoBmjDrVTvJWNlnuKPEoPpig68boL1vlc=;
        b=VyJUYh66XhC9sShi9N+063gd40/5N+UpKJEjJU5jKsTelfXCMT3Op67Lfc+hZfNlgW
         nIwDUhOhqw8t72zeWgBEx5qL8VMBGaUnT8tCCxvUnZyPPL++RlOGfqIwXVHMqJQzF0rN
         Bg7S2ISkqJdcWbp2spMLfEpIOt3HBktGQUfxFvx686IKZoLSqo+8ukdc1x4fA0NnXllZ
         oYm+zku2DbddacazkBD8CJkiQaz62+Vzfec00eTFw6T09UIRd2bPNJ1l7UijgIgxHmOJ
         cDr1qYQUDwky8r0e0m0N1yo8UFZRons7XtjLJCHF3SqwJJmModgxpeGSqXQxHcg6CivL
         Et8A==
X-Gm-Message-State: AFqh2kohEued7fjb53oJEou2qLsguXPSQ7z86gtBc/ED2YDMHp7pZ0KQ
        oAfxYDkVQfraETjZGQablCkqDg==
X-Google-Smtp-Source: AMrXdXsVdcmkimY1ohFAGq7ca4IHJWAZdDJmZXDKvF5dDjw0VyKjn3H85j4r6k/iD1JYDrl22B3FSQ==
X-Received: by 2002:adf:f10b:0:b0:2bd:e215:4372 with SMTP id r11-20020adff10b000000b002bde2154372mr6131854wro.20.1674063587368;
        Wed, 18 Jan 2023 09:39:47 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u24-20020adfa198000000b002bc84c55758sm28730074wru.63.2023.01.18.09.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 09:39:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, Han Xu <han.xu@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?q?=82ecki?= <rafal@milecki.pl>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>,
        Leilk Liu <leilk.liu@mediatek.com>,
        Gabor Juhos <juhosg@openwrt.org>,
        Bert Vermeulen <bert@biot.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anson Huang <Anson.Huang@nxp.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] spi: dt-bindings: drop unneeded quotes
Date:   Wed, 18 Jan 2023 18:39:31 +0100
Message-Id: <20230118173932.358153-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup by removing unneeded quotes from refs and redundant blank lines.
No functional impact except adjusting to preferred coding style.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/spi/allwinner,sun4i-a10-spi.yaml  |  2 +-
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml  |  2 +-
 .../bindings/spi/amlogic,meson-gx-spicc.yaml   |  6 +++---
 .../bindings/spi/amlogic,meson6-spifc.yaml     |  6 +++---
 .../bindings/spi/aspeed,ast2600-fmc.yaml       |  2 +-
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml |  2 +-
 .../devicetree/bindings/spi/cdns,xspi.yaml     |  6 +++---
 .../bindings/spi/fsl,spi-fsl-qspi.yaml         |  2 +-
 .../devicetree/bindings/spi/fsl-imx-cspi.yaml  |  2 +-
 .../bindings/spi/mediatek,spi-mt65xx.yaml      |  2 +-
 .../spi/mediatek,spi-slave-mt27xx.yaml         |  2 +-
 .../bindings/spi/mikrotik,rb4xx-spi.yaml       |  2 +-
 .../bindings/spi/mxicy,mx25f0a-spi.yaml        |  2 +-
 .../devicetree/bindings/spi/mxs-spi.yaml       |  2 +-
 .../bindings/spi/nvidia,tegra210-quad.yaml     |  2 +-
 .../bindings/spi/qcom,spi-qcom-qspi.yaml       |  5 ++---
 .../bindings/spi/realtek,rtl-spi.yaml          |  2 +-
 .../bindings/spi/snps,dw-apb-ssi.yaml          |  2 +-
 .../devicetree/bindings/spi/spi-cadence.yaml   |  2 +-
 .../devicetree/bindings/spi/spi-fsl-lpspi.yaml |  2 +-
 .../devicetree/bindings/spi/spi-gpio.yaml      |  4 ++--
 .../devicetree/bindings/spi/spi-mux.yaml       |  4 ++--
 .../devicetree/bindings/spi/spi-nxp-fspi.yaml  |  2 +-
 .../devicetree/bindings/spi/spi-pl022.yaml     | 18 +++++++++---------
 .../devicetree/bindings/spi/spi-rockchip.yaml  |  2 +-
 .../devicetree/bindings/spi/spi-sifive.yaml    |  6 +++---
 .../bindings/spi/spi-sunplus-sp7021.yaml       |  2 +-
 .../devicetree/bindings/spi/spi-xilinx.yaml    |  2 +-
 .../bindings/spi/spi-zynqmp-qspi.yaml          |  2 +-
 .../devicetree/bindings/spi/sprd,spi-adi.yaml  |  5 ++---
 .../devicetree/bindings/spi/st,stm32-qspi.yaml |  2 +-
 .../devicetree/bindings/spi/st,stm32-spi.yaml  |  2 +-
 .../bindings/spi/xlnx,zynq-qspi.yaml           |  2 +-
 33 files changed, 53 insertions(+), 55 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
index f1176a28fd87..eb0567b2971a 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Allwinner A10 SPI Controller
 
 allOf:
-  - $ref: "spi-controller.yaml"
+  - $ref: spi-controller.yaml
 
 maintainers:
   - Chen-Yu Tsai <wens@csie.org>
diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index 58b7056f4a70..acf218507d22 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Allwinner A31 SPI Controller
 
 allOf:
-  - $ref: "spi-controller.yaml"
+  - $ref: spi-controller.yaml
 
 maintainers:
   - Chen-Yu Tsai <wens@csie.org>
diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
index 53eb6562b979..e5eca3a6f132 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/spi/amlogic,meson-gx-spicc.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/spi/amlogic,meson-gx-spicc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Meson SPI Communication Controller
 
@@ -41,7 +41,7 @@ properties:
     maxItems: 2
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
index ac3b2ec300ac..806043fed4d1 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/spi/amlogic,meson6-spifc.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/spi/amlogic,meson6-spifc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Meson SPI Flash Controller
 
@@ -11,7 +11,7 @@ maintainers:
   - Neil Armstrong <neil.armstrong@linaro.org>
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 description: |
   The Meson SPIFC is a controller optimized for communication with SPI
diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
index e6c817de3449..aae6fb139b5b 100644
--- a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
+++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
@@ -15,7 +15,7 @@ description: |
   SPI) of the AST2400, AST2500 and AST2600 SOCs.
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 4707294d8f59..9be4e2c5d1ee 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -47,7 +47,7 @@ properties:
   cdns,fifo-depth:
     description:
       Size of the data FIFO in words.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     enum: [ 128, 256 ]
     default: 128
 
diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
index b8bb8a3dbf54..eb0f92468185 100644
--- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -2,8 +2,8 @@
 # Copyright 2020-21 Cadence
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/spi/cdns,xspi.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/spi/cdns,xspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Cadence XSPI Controller
 
@@ -16,7 +16,7 @@ description: |
   read/write access to slaves such as SPI-NOR flash.
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
index e58644558412..f2dd20370dbb 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Han Xu <han.xu@nxp.com>
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
index 12cb76711000..2f593c7225e5 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Shawn Guo <shawnguo@kernel.org>
 
 allOf:
-  - $ref: "/schemas/spi/spi-controller.yaml#"
+  - $ref: /schemas/spi/spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
index 8d2a6c084eab..b6249880c3f9 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Leilk Liu <leilk.liu@mediatek.com>
 
 allOf:
-  - $ref: "/schemas/spi/spi-controller.yaml#"
+  - $ref: /schemas/spi/spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml
index 7977799a8ee1..d19c9f73978f 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Leilk Liu <leilk.liu@mediatek.com>
 
 allOf:
-  - $ref: "/schemas/spi/spi-controller.yaml#"
+  - $ref: /schemas/spi/spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/mikrotik,rb4xx-spi.yaml b/Documentation/devicetree/bindings/spi/mikrotik,rb4xx-spi.yaml
index 3fd0a8adfe9a..303f6dca89c0 100644
--- a/Documentation/devicetree/bindings/spi/mikrotik,rb4xx-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/mikrotik,rb4xx-spi.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Bert Vermeulen <bert@biot.com>
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml b/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
index a3aa5e07c0e4..221fe6e2ef53 100644
--- a/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/mxs-spi.yaml b/Documentation/devicetree/bindings/spi/mxs-spi.yaml
index 51f8c664323e..e2512166c1cd 100644
--- a/Documentation/devicetree/bindings/spi/mxs-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/mxs-spi.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Marek Vasut <marex@denx.de>
 
 allOf:
-  - $ref: "/schemas/spi/spi-controller.yaml#"
+  - $ref: /schemas/spi/spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 899100e783c9..9f78b2c06494 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Jonathan Hunter <jonathanh@nvidia.com>
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
index b622bb7363ec..85e7770703bd 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
@@ -1,9 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/spi/qcom,spi-qcom-qspi.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/spi/qcom,spi-qcom-qspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Qualcomm Quad Serial Peripheral Interface (QSPI)
 
diff --git a/Documentation/devicetree/bindings/spi/realtek,rtl-spi.yaml b/Documentation/devicetree/bindings/spi/realtek,rtl-spi.yaml
index 2f938c293f70..70330d945a70 100644
--- a/Documentation/devicetree/bindings/spi/realtek,rtl-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/realtek,rtl-spi.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Birger Koblitz <mail@birger-koblitz.de>
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index d33b72fabc5d..a132b5fc56e0 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Mark Brown <broonie@kernel.org>
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
index 64bf4e621142..b0f83b5c2cdd 100644
--- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Michal Simek <michal.simek@xilinx.com>
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
index 94caa2b7e241..e91425012319 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Anson Huang <Anson.Huang@nxp.com>
 
 allOf:
-  - $ref: "/schemas/spi/spi-controller.yaml#"
+  - $ref: /schemas/spi/spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/spi-gpio.yaml b/Documentation/devicetree/bindings/spi/spi-gpio.yaml
index f29b89076c99..9ce1df93d4c3 100644
--- a/Documentation/devicetree/bindings/spi/spi-gpio.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-gpio.yaml
@@ -14,7 +14,7 @@ description:
   dedicated GPIO lines.
 
 allOf:
-  - $ref: "/schemas/spi/spi-controller.yaml#"
+  - $ref: /schemas/spi/spi-controller.yaml#
 
 properties:
   compatible:
@@ -41,7 +41,7 @@ properties:
   num-chipselects:
     description: Number of chipselect lines. Should be <0> if a single device
       with no chip select is connected.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
 
   # Deprecated properties
   gpio-sck: false
diff --git a/Documentation/devicetree/bindings/spi/spi-mux.yaml b/Documentation/devicetree/bindings/spi/spi-mux.yaml
index 7ea79f6d33f3..fb2a6039928c 100644
--- a/Documentation/devicetree/bindings/spi/spi-mux.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-mux.yaml
@@ -30,8 +30,8 @@ description: |
       +------------+
 
 allOf:
-  - $ref: "/schemas/spi/spi-controller.yaml#"
-  - $ref: "/schemas/spi/spi-peripheral-props.yaml#"
+  - $ref: /schemas/spi/spi-controller.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 maintainers:
   - Chris Packham <chris.packham@alliedtelesis.co.nz>
diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
index 1b552c298277..a813c971ecf6 100644
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Kuldeep Singh <singh.kuldeep87k@gmail.com>
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
index 0e382119c64f..91e540a92faf 100644
--- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Linus Walleij <linus.walleij@linaro.org>
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 # We need a select here so we don't match all nodes with 'arm,primecell'
 select:
@@ -45,7 +45,7 @@ properties:
     description: delay in ms following transfer completion before the
       runtime power management system suspends the device. A setting of 0
       indicates no delay and the device will be suspended immediately.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
 
   pl022,rt:
     description: indicates the controller should run the message pump with realtime
@@ -81,7 +81,7 @@ patternProperties:
     properties:
       pl022,interface:
         description: SPI interface type
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         enum:
           - 0      # SPI
           - 1      # Texas Instruments Synchronous Serial Frame Format
@@ -89,7 +89,7 @@ patternProperties:
 
       pl022,com-mode:
         description: Specifies the transfer mode
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         enum:
           - 0      # interrupt mode
           - 1      # polling mode
@@ -98,30 +98,30 @@ patternProperties:
 
       pl022,rx-level-trig:
         description: Rx FIFO watermark level
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 4
 
       pl022,tx-level-trig:
         description: Tx FIFO watermark level
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 4
 
       pl022,ctrl-len:
         description: Microwire interface - Control length
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0x03
         maximum: 0x1f
 
       pl022,wait-state:
         description: Microwire interface - Wait state
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         enum: [0, 1]
 
       pl022,duplex:
         description: Microwire interface - Full/Half duplex
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         enum: [0, 1]
 
 required:
diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
index 66e49947b703..e4941e9212d1 100644
--- a/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-rockchip.yaml
@@ -11,7 +11,7 @@ description:
   as flash and display controllers using the SPI communication interface.
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 maintainers:
   - Heiko Stuebner <heiko@sntech.de>
diff --git a/Documentation/devicetree/bindings/spi/spi-sifive.yaml b/Documentation/devicetree/bindings/spi/spi-sifive.yaml
index 6e7e394fc1e4..5bffefb9c7eb 100644
--- a/Documentation/devicetree/bindings/spi/spi-sifive.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-sifive.yaml
@@ -12,7 +12,7 @@ maintainers:
   - Palmer Dabbelt <palmer@sifive.com>
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 properties:
   compatible:
@@ -51,14 +51,14 @@ properties:
   sifive,fifo-depth:
     description:
       Depth of hardware queues; defaults to 8
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     enum: [8]
     default: 8
 
   sifive,max-bits-per-word:
     description:
       Maximum bits per word; defaults to 8
-    $ref: "/schemas/types.yaml#/definitions/uint32"
+    $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 1, 2, 3, 4, 5, 6, 7, 8]
     default: 8
 
diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
index 3a58cf0f1ec8..69a463305274 100644
--- a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
@@ -8,7 +8,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Sunplus sp7021 SPI controller
 
 allOf:
-  - $ref: "spi-controller.yaml"
+  - $ref: spi-controller.yaml
 
 maintainers:
   - Li-hao Kuo <lhjeff911@gmail.com>
diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
index bbb735603f29..6bd83836eded 100644
--- a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Michal Simek <michal.simek@xilinx.com>
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
index 546c416cdb55..20f77246d365 100644
--- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
@@ -10,7 +10,7 @@ maintainers:
   - Michal Simek <michal.simek@xilinx.com>
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml b/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
index a3ab1a1f1eb4..903b06f88b1b 100644
--- a/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
+++ b/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
@@ -1,9 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
-
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/spi/sprd,spi-adi.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/spi/sprd,spi-adi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Spreadtrum ADI controller
 
diff --git a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
index 1eb17f7a4d86..8bba965a9ae6 100644
--- a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
@@ -11,7 +11,7 @@ maintainers:
   - Patrice Chotard <patrice.chotard@foss.st.com>
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
index 1cda15f91cc3..d35c6f7e2dd5 100644
--- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
@@ -17,7 +17,7 @@ maintainers:
   - Fabrice Gasnier <fabrice.gasnier@foss.st.com>
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml b/Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
index 1f1c40a9f320..83e8fb4a548d 100644
--- a/Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/xlnx,zynq-qspi.yaml
@@ -11,7 +11,7 @@ description:
   memory devices.
 
 allOf:
-  - $ref: "spi-controller.yaml#"
+  - $ref: spi-controller.yaml#
 
 maintainers:
   - Michal Simek <michal.simek@xilinx.com>
-- 
2.34.1

