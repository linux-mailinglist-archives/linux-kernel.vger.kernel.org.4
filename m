Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFDD679336
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjAXIeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjAXIeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:34:04 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B481E7EF7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:33:56 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so10343210wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 00:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+nxm6AUQrdND9hhv0fMGvZp0eeAkpWlOdH7gphjJuI=;
        b=F5EtfmWAs7GPnYDrFQA3qmog15Uouc0N5eHuu9MQT8H2T6aDjEdcdx6q4XF1aYYbaJ
         rbwCf0tZscxlRycuE90c1IDIIYSkTVn6+h5a7tyAiGlxsWcdO0soiLhxFb8WtixiaCy2
         WhJ7z1uWeJG3cB8kdbcxsXHLILrdicAwZQwK3ABCRS3cgWDvH+Noz8yeqWEdjLT3Adfl
         xIoYzEWZLOmTO25Qa6Z52Pr2d0ZuTw6ENohjnwx1ee9VkWdrhhCjjUzkjdm+I3XLz0h2
         1aVovCbXImM9IRjLIsfp/mQTfRMevBV5hGf/qmeILQbAth9fbOj/6XP0FHJANAst6ttN
         Kmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+nxm6AUQrdND9hhv0fMGvZp0eeAkpWlOdH7gphjJuI=;
        b=EI6wgrxzdRb9v7zjdpnmgMl4S/Oi6yOeMCiLBMPsAP8kg74aUT789i00k7r+MNsvmW
         Tj4E+ir/G2sMfMMQocS3/zyopn+2Bj0NF99weVaVJ8piyqlCM8oMULzR5EfYcm7ZVRtl
         L2LTFDJvsD4Hs6zqkYfxGb/dNXwCpLH/1vMMFLD//0fHMXFJz6eO/0n37SKRPxdJJeZq
         ZN1qxqZgTW8hZ/KKilOADxTwio5R2UHwe4mP+aU6gUHSM48BqigEWXZPMOPgYKoKMuGn
         TVD1eKETXOC+4RfypXvsoDWblv/Brf7USfu/FscyQ7L89qQq+J8PTsUPH2NY5ocapDhx
         9vnA==
X-Gm-Message-State: AFqh2kpnrvgvABSh4QlDKN8zfqxq//QS87ezBpE/jpWjabUzG2agidJr
        WcazCuzONG6WI/uoBpIMRgil3A==
X-Google-Smtp-Source: AMrXdXva1GteWUvLjwso/FKOzr72v0f91fSczdeUW3DCTAHFGCcG58kJzxHtnlRqyRT3RNGgPZZBjg==
X-Received: by 2002:a1c:ed0a:0:b0:3d3:4a47:52e9 with SMTP id l10-20020a1ced0a000000b003d34a4752e9mr26816656wmh.15.1674549235084;
        Tue, 24 Jan 2023 00:33:55 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n34-20020a05600c182200b003da286f8332sm1319075wmp.18.2023.01.24.00.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 00:33:54 -0800 (PST)
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
Subject: [PATCH v2 2/2] spi: dt-bindings: cleanup examples - indentation, lowercase hex
Date:   Tue, 24 Jan 2023 09:33:42 +0100
Message-Id: <20230124083342.34869-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230124083342.34869-1-krzysztof.kozlowski@linaro.org>
References: <20230124083342.34869-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup examples:
 - use 4-space indentation (for cases when it is neither 4 not 2 space),
 - drop redundant blank lines,
 - use lowercase hex.

No functional impact except adjusting to preferred coding style.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas
Reviewed-by: Andrew Jeffery <andrew@aj.id.au> # aspeed
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org> # meson

---

Changes since v1:
1. Adjust indentation in two more examples (cdns,qspi-nor, st,stm32-spi)
2. Add tags
---
 .../bindings/spi/amlogic,meson-gx-spicc.yaml  |  26 +--
 .../bindings/spi/amlogic,meson6-spifc.yaml    |  22 +--
 .../bindings/spi/aspeed,ast2600-fmc.yaml      |  24 +--
 .../bindings/spi/brcm,spi-bcm-qspi.yaml       | 156 +++++++++---------
 .../bindings/spi/cdns,qspi-nor.yaml           |  34 ++--
 .../bindings/spi/nvidia,tegra210-quad.yaml    |  42 ++---
 .../bindings/spi/qcom,spi-qcom-qspi.yaml      |   1 -
 .../devicetree/bindings/spi/renesas,rspi.yaml |  22 +--
 .../bindings/spi/spi-sunplus-sp7021.yaml      |   4 +-
 .../devicetree/bindings/spi/st,stm32-spi.yaml |  23 ++-
 10 files changed, 176 insertions(+), 178 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
index e5eca3a6f132..4e28e6e9d8e0 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
@@ -100,17 +100,17 @@ unevaluatedProperties: false
 examples:
   - |
     spi@c1108d80 {
-          compatible = "amlogic,meson-gx-spicc";
-          reg = <0xc1108d80 0x80>;
-          interrupts = <112>;
-          clocks = <&clk81>;
-          clock-names = "core";
-          #address-cells = <1>;
-          #size-cells = <0>;
-
-          display@0 {
-              compatible = "lg,lg4573";
-              spi-max-frequency = <1000000>;
-              reg = <0>;
-          };
+        compatible = "amlogic,meson-gx-spicc";
+        reg = <0xc1108d80 0x80>;
+        interrupts = <112>;
+        clocks = <&clk81>;
+        clock-names = "core";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0 {
+            compatible = "lg,lg4573";
+            spi-max-frequency = <1000000>;
+            reg = <0>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
index 806043fed4d1..8e769ccda97f 100644
--- a/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
+++ b/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
@@ -40,15 +40,15 @@ unevaluatedProperties: false
 examples:
   - |
     spi@c1108c80 {
-          compatible = "amlogic,meson6-spifc";
-          reg = <0xc1108c80 0x80>;
-          clocks = <&clk81>;
-          #address-cells = <1>;
-          #size-cells = <0>;
-
-          flash: flash@0 {
-              compatible = "spansion,m25p80", "jedec,spi-nor";
-              reg = <0>;
-              spi-max-frequency = <40000000>;
-          };
+        compatible = "amlogic,meson6-spifc";
+        reg = <0xc1108c80 0x80>;
+        clocks = <&clk81>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash: flash@0 {
+            compatible = "spansion,m25p80", "jedec,spi-nor";
+            reg = <0>;
+            spi-max-frequency = <40000000>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
index aae6fb139b5b..57d932af4506 100644
--- a/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
+++ b/Documentation/devicetree/bindings/spi/aspeed,ast2600-fmc.yaml
@@ -60,23 +60,23 @@ examples:
         interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 
         flash@0 {
-                reg = < 0 >;
-                compatible = "jedec,spi-nor";
-                spi-max-frequency = <50000000>;
-                spi-rx-bus-width = <2>;
+            reg = < 0 >;
+            compatible = "jedec,spi-nor";
+            spi-max-frequency = <50000000>;
+            spi-rx-bus-width = <2>;
         };
 
         flash@1 {
-                reg = < 1 >;
-                compatible = "jedec,spi-nor";
-                spi-max-frequency = <50000000>;
-                spi-rx-bus-width = <2>;
+            reg = < 1 >;
+            compatible = "jedec,spi-nor";
+            spi-max-frequency = <50000000>;
+            spi-rx-bus-width = <2>;
         };
 
         flash@2 {
-                reg = < 2 >;
-                compatible = "jedec,spi-nor";
-                spi-max-frequency = <50000000>;
-                spi-rx-bus-width = <2>;
+            reg = < 2 >;
+            compatible = "jedec,spi-nor";
+            spi-max-frequency = <50000000>;
+            spi-rx-bus-width = <2>;
         };
     };
diff --git a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
index ec5873919170..28222aae3077 100644
--- a/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
@@ -99,98 +99,98 @@ required:
 examples:
   - | # BRCMSTB SoC: SPI Master (MSPI+BSPI) for SPI-NOR access
     spi@f03e3400 {
-            compatible = "brcm,spi-brcmstb-qspi", "brcm,spi-bcm-qspi";
-            reg = <0xf03e3400 0x188>, <0xf03e3200 0x50>, <0xf03e0920 0x4>;
-            reg-names = "mspi", "bspi", "cs_reg";
-            interrupts = <0x5>, <0x6>, <0x1>, <0x2>, <0x3>, <0x4>, <0x0>;
-            interrupt-parent = <&gic>;
-            interrupt-names = "mspi_done",
-                              "mspi_halted",
-                              "spi_lr_fullness_reached",
-                              "spi_lr_session_aborted",
-                              "spi_lr_impatient",
-                              "spi_lr_session_done",
-                              "spi_lr_overread";
-            clocks = <&hif_spi>;
-            #address-cells = <0x1>;
-            #size-cells = <0x0>;
-
-            flash@0 {
-                    #size-cells = <0x2>;
-                    #address-cells = <0x2>;
-                    compatible = "m25p80";
-                    reg = <0x0>;
-                    spi-max-frequency = <0x2625a00>;
-                    spi-cpol;
-                    spi-cpha;
-            };
+        compatible = "brcm,spi-brcmstb-qspi", "brcm,spi-bcm-qspi";
+        reg = <0xf03e3400 0x188>, <0xf03e3200 0x50>, <0xf03e0920 0x4>;
+        reg-names = "mspi", "bspi", "cs_reg";
+        interrupts = <0x5>, <0x6>, <0x1>, <0x2>, <0x3>, <0x4>, <0x0>;
+        interrupt-parent = <&gic>;
+        interrupt-names = "mspi_done",
+                          "mspi_halted",
+                          "spi_lr_fullness_reached",
+                          "spi_lr_session_aborted",
+                          "spi_lr_impatient",
+                          "spi_lr_session_done",
+                          "spi_lr_overread";
+        clocks = <&hif_spi>;
+        #address-cells = <0x1>;
+        #size-cells = <0x0>;
+
+        flash@0 {
+            #size-cells = <0x2>;
+            #address-cells = <0x2>;
+            compatible = "m25p80";
+            reg = <0x0>;
+            spi-max-frequency = <0x2625a00>;
+            spi-cpol;
+            spi-cpha;
+        };
     };
   - | # BRCMSTB SoC: MSPI master for any SPI device
     spi@f0416000 {
-            clocks = <&upg_fixed>;
-            compatible = "brcm,spi-brcmstb-mspi", "brcm,spi-bcm-qspi";
-            reg = <0xf0416000 0x180>;
-            reg-names = "mspi";
-            interrupts = <0x14>;
-            interrupt-parent = <&irq0_aon_intc>;
-            interrupt-names = "mspi_done";
-            #address-cells = <1>;
-            #size-cells = <0>;
+        clocks = <&upg_fixed>;
+        compatible = "brcm,spi-brcmstb-mspi", "brcm,spi-bcm-qspi";
+        reg = <0xf0416000 0x180>;
+        reg-names = "mspi";
+        interrupts = <0x14>;
+        interrupt-parent = <&irq0_aon_intc>;
+        interrupt-names = "mspi_done";
+        #address-cells = <1>;
+        #size-cells = <0>;
     };
   - | # iProc SoC
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     spi@18027200 {
-            compatible = "brcm,spi-nsp-qspi", "brcm,spi-bcm-qspi";
-            reg = <0x18027200 0x184>,
-                  <0x18027000 0x124>,
-                  <0x1811c408 0x004>,
-                  <0x180273a0 0x01c>;
-            reg-names = "mspi", "bspi", "intr_regs", "intr_status_reg";
-            interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
-                         <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names = "mspi_done",
-                              "mspi_halted",
-                              "spi_lr_fullness_reached",
-                              "spi_lr_session_aborted",
-                              "spi_lr_impatient",
-                              "spi_lr_session_done";
-            clocks = <&iprocmed>;
-            num-cs = <2>;
-            #address-cells = <1>;
-            #size-cells = <0>;
+        compatible = "brcm,spi-nsp-qspi", "brcm,spi-bcm-qspi";
+        reg = <0x18027200 0x184>,
+              <0x18027000 0x124>,
+              <0x1811c408 0x004>,
+              <0x180273a0 0x01c>;
+        reg-names = "mspi", "bspi", "intr_regs", "intr_status_reg";
+        interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "mspi_done",
+                          "mspi_halted",
+                          "spi_lr_fullness_reached",
+                          "spi_lr_session_aborted",
+                          "spi_lr_impatient",
+                          "spi_lr_session_done";
+        clocks = <&iprocmed>;
+        num-cs = <2>;
+        #address-cells = <1>;
+        #size-cells = <0>;
     };
   - | # NS2 SoC
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     spi@66470200 {
-            compatible = "brcm,spi-ns2-qspi", "brcm,spi-bcm-qspi";
-            reg = <0x66470200 0x184>,
-                  <0x66470000 0x124>,
-                  <0x67017408 0x004>,
-                  <0x664703a0 0x01c>;
-            reg-names = "mspi", "bspi", "intr_regs", "intr_status_reg";
-            interrupts = <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>;
-            interrupt-names = "spi_l1_intr";
-            clocks = <&iprocmed>;
-            num-cs = <2>;
+        compatible = "brcm,spi-ns2-qspi", "brcm,spi-bcm-qspi";
+        reg = <0x66470200 0x184>,
+              <0x66470000 0x124>,
+              <0x67017408 0x004>,
+              <0x664703a0 0x01c>;
+        reg-names = "mspi", "bspi", "intr_regs", "intr_status_reg";
+        interrupts = <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "spi_l1_intr";
+        clocks = <&iprocmed>;
+        num-cs = <2>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
             #address-cells = <1>;
-            #size-cells = <0>;
-
-            flash@0 {
-                    #address-cells = <1>;
-                    #size-cells = <1>;
-                    compatible = "m25p80";
-                    reg = <0x0>;
-                    spi-max-frequency = <12500000>;
-                    spi-cpol;
-                    spi-cpha;
-            };
+            #size-cells = <1>;
+            compatible = "m25p80";
+            reg = <0x0>;
+            spi-max-frequency = <12500000>;
+            spi-cpol;
+            spi-cpha;
+        };
     };
diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 9be4e2c5d1ee..5c01db128be0 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -103,21 +103,21 @@ unevaluatedProperties: false
 examples:
   - |
     qspi: spi@ff705000 {
-      compatible = "cdns,qspi-nor";
-      #address-cells = <1>;
-      #size-cells = <0>;
-      reg = <0xff705000 0x1000>,
-            <0xffa00000 0x1000>;
-      interrupts = <0 151 4>;
-      clocks = <&qspi_clk>;
-      cdns,fifo-depth = <128>;
-      cdns,fifo-width = <4>;
-      cdns,trigger-address = <0x00000000>;
-      resets = <&rst 0x1>, <&rst 0x2>;
-      reset-names = "qspi", "qspi-ocp";
-
-      flash@0 {
-              compatible = "jedec,spi-nor";
-              reg = <0x0>;
-      };
+        compatible = "cdns,qspi-nor";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0xff705000 0x1000>,
+              <0xffa00000 0x1000>;
+        interrupts = <0 151 4>;
+        clocks = <&qspi_clk>;
+        cdns,fifo-depth = <128>;
+        cdns,fifo-width = <4>;
+        cdns,trigger-address = <0x00000000>;
+        resets = <&rst 0x1>, <&rst 0x2>;
+        reset-names = "qspi", "qspi-ocp";
+
+        flash@0 {
+            compatible = "jedec,spi-nor";
+            reg = <0x0>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 9f78b2c06494..9ae1611175f2 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -74,25 +74,25 @@ examples:
     #include <dt-bindings/reset/tegra210-car.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     spi@70410000 {
-            compatible = "nvidia,tegra210-qspi";
-            reg = <0x70410000 0x1000>;
-            interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-            #address-cells = <1>;
-            #size-cells = <0>;
-            clocks = <&tegra_car TEGRA210_CLK_QSPI>,
-                     <&tegra_car TEGRA210_CLK_QSPI_PM>;
-            clock-names = "qspi", "qspi_out";
-            resets = <&tegra_car 211>;
-            dmas = <&apbdma 5>, <&apbdma 5>;
-            dma-names = "rx", "tx";
-
-            flash@0 {
-                    compatible = "jedec,spi-nor";
-                    reg = <0>;
-                    spi-max-frequency = <104000000>;
-                    spi-tx-bus-width = <2>;
-                    spi-rx-bus-width = <2>;
-                    nvidia,tx-clk-tap-delay = <0>;
-                    nvidia,rx-clk-tap-delay = <0>;
-            };
+        compatible = "nvidia,tegra210-qspi";
+        reg = <0x70410000 0x1000>;
+        interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        clocks = <&tegra_car TEGRA210_CLK_QSPI>,
+                 <&tegra_car TEGRA210_CLK_QSPI_PM>;
+        clock-names = "qspi", "qspi_out";
+        resets = <&tegra_car 211>;
+        dmas = <&apbdma 5>, <&apbdma 5>;
+        dma-names = "rx", "tx";
+
+        flash@0 {
+            compatible = "jedec,spi-nor";
+            reg = <0>;
+            spi-max-frequency = <104000000>;
+            spi-tx-bus-width = <2>;
+            spi-rx-bus-width = <2>;
+            nvidia,tx-clk-tap-delay = <0>;
+            nvidia,rx-clk-tap-delay = <0>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
index 85e7770703bd..e94d915e28c8 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
@@ -87,7 +87,6 @@ examples:
                 spi-tx-bus-width = <2>;
                 spi-rx-bus-width = <2>;
             };
-
         };
     };
 ...
diff --git a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
index f45d3b75d6de..4d8ec69214c9 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rspi.yaml
@@ -141,15 +141,15 @@ examples:
     #include <dt-bindings/power/r8a7791-sysc.h>
 
     qspi: spi@e6b10000 {
-            compatible = "renesas,qspi-r8a7791", "renesas,qspi";
-            reg = <0xe6b10000 0x2c>;
-            interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
-            clocks = <&cpg CPG_MOD 917>;
-            dmas = <&dmac0 0x17>, <&dmac0 0x18>, <&dmac1 0x17>, <&dmac1 0x18>;
-            dma-names = "tx", "rx", "tx", "rx";
-            power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
-            resets = <&cpg 917>;
-            num-cs = <1>;
-            #address-cells = <1>;
-            #size-cells = <0>;
+        compatible = "renesas,qspi-r8a7791", "renesas,qspi";
+        reg = <0xe6b10000 0x2c>;
+        interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cpg CPG_MOD 917>;
+        dmas = <&dmac0 0x17>, <&dmac0 0x18>, <&dmac1 0x17>, <&dmac1 0x18>;
+        dma-names = "tx", "rx", "tx", "rx";
+        power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+        resets = <&cpg 917>;
+        num-cs = <1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
     };
diff --git a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
index 69a463305274..edb5ba71af3a 100644
--- a/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-sunplus-sp7021.yaml
@@ -59,9 +59,9 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
-    spi@9C002D80 {
+    spi@9c002d80 {
         compatible = "sunplus,sp7021-spi";
-        reg = <0x9C002D80 0x80>, <0x9C002E00 0x80>;
+        reg = <0x9c002d80 0x80>, <0x9c002e00 0x80>;
         reg-names = "master", "slave";
         interrupt-parent = <&intc>;
         interrupt-names = "dma_w",
diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
index d35c6f7e2dd5..9ca1a843c820 100644
--- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
@@ -84,18 +84,17 @@ examples:
     #include <dt-bindings/clock/stm32mp1-clks.h>
     #include <dt-bindings/reset/stm32mp1-resets.h>
     spi@4000b000 {
-      #address-cells = <1>;
-      #size-cells = <0>;
-      compatible = "st,stm32h7-spi";
-      reg = <0x4000b000 0x400>;
-      interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
-      clocks = <&rcc SPI2_K>;
-      resets = <&rcc SPI2_R>;
-      dmas = <&dmamux1 0 39 0x400 0x05>,
-             <&dmamux1 1 40 0x400 0x05>;
-      dma-names = "rx", "tx";
-      cs-gpios = <&gpioa 11 0>;
-
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "st,stm32h7-spi";
+        reg = <0x4000b000 0x400>;
+        interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&rcc SPI2_K>;
+        resets = <&rcc SPI2_R>;
+        dmas = <&dmamux1 0 39 0x400 0x05>,
+               <&dmamux1 1 40 0x400 0x05>;
+        dma-names = "rx", "tx";
+        cs-gpios = <&gpioa 11 0>;
     };
 
 ...
-- 
2.34.1

