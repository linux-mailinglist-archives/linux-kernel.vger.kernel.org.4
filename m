Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5E064EF8C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiLPQjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiLPQiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:38:55 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526AD6151F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:38:35 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a19so2774010ljk.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GASykMV4cCpZStLintKIDpSFBGBiU1f5K8hR+eIfjC4=;
        b=uluaCmc92as0ROMeLJQvKKQopo3a81DSD1Q9s38WFNGBwbWn7gRmLBjaNeCfMPbu6W
         JbdP9c6x3wNuUU+47LTzynZvABpyYOqEbjl0gCW6u0h+l/7kQeoBr8k1NJnyx6xsTa2Z
         aN3Tfl2rFI8K6RnzeadX3hZte9/hqXLX4it4cT/vY47Mm0oraRTYiTgA8mj1wJRWDwWT
         mE7WAuVwkDGbBoG81amHylNMfFzPbbPjhXNrBMu6O2RrqpY+FOE/wHWCCU3q4lBKArIb
         zECa2dbLJDn0xm5NBtcBUPaZ6iod2DXSrMn6qNmcTZTAno8embZSoZ1vZRzVFBlS9g6B
         0J/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GASykMV4cCpZStLintKIDpSFBGBiU1f5K8hR+eIfjC4=;
        b=VbKibIVya0Bz4+ODuV7sCcC9z9GWmEDmXbHnTaf6vOT4E9QVFVQNuYEk7CDNaxOwLF
         8mzFxWME9OeRD3F9cQkl7TIbgskjQw6ssL2MNrK3Qts5SMODQgZew+uoQr16omgR07sI
         uo59IJdyWu60Yd361z5rZem3aosLOXTDnPjLRsR47koqvZt7dVsSstbgRURKxt7EsEN9
         QwSjcF7rDUDlbAbCSeUGt2rNz+J4WnbbPWQ/rIXKRUTtvsAIRNyTznMOzFNsYtRYtZEi
         NX8YX5F6Vc5V5jnZJFedSvmlfrpv3fitsya7pFXwgXQlHR2QcNViFZQP3a0SnofiB63G
         cBDg==
X-Gm-Message-State: ANoB5plogKWBEl4y1xBcuEDyHjVdQPoJabK09xFKwdxaDuMV42DKO5Dr
        c7syYmvMflkP8BlqdfEStk87mw==
X-Google-Smtp-Source: AA0mqf5yembx8A63MFGl01yKvBP8SaW7SfglNcsz4t1Nut7iT4Tbba9rWs4qyI7+UEIf38q8Zx5+Mg==
X-Received: by 2002:a2e:a885:0:b0:26f:db34:b386 with SMTP id m5-20020a2ea885000000b0026fdb34b386mr8240789ljq.2.1671208713396;
        Fri, 16 Dec 2022 08:38:33 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p10-20020a2eba0a000000b0026fc79fd67dsm193930lja.74.2022.12.16.08.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:38:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v3 9/9] dt-bindings: drop redundant part of title (manual)
Date:   Fri, 16 Dec 2022 17:38:15 +0100
Message-Id: <20221216163815.522628-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221216163815.522628-1-krzysztof.kozlowski@linaro.org>
References: <20221216163815.522628-1-krzysztof.kozlowski@linaro.org>
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

The Devicetree bindings document does not have to say in the title that
it is a "Devicetree binding" or a "schema", but instead just describe
the hardware.

Manual updates to various binding titles, including capitalizing them.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # MMC
Acked-by: Stephen Boyd <sboyd@kernel.org> # clk
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # input
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org> # opp
---
 Documentation/devicetree/bindings/clock/cirrus,cs2000-cp.yaml   | 2 +-
 Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml        | 2 +-
 .../devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml         | 2 +-
 Documentation/devicetree/bindings/example-schema.yaml           | 2 +-
 Documentation/devicetree/bindings/input/fsl,scu-key.yaml        | 2 +-
 Documentation/devicetree/bindings/input/matrix-keymap.yaml      | 2 +-
 Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml     | 2 +-
 Documentation/devicetree/bindings/net/asix,ax88178.yaml         | 2 +-
 Documentation/devicetree/bindings/net/microchip,lan95xx.yaml    | 2 +-
 Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml      | 2 +-
 Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml    | 2 +-
 Documentation/devicetree/bindings/pci/pci-ep.yaml               | 2 +-
 Documentation/devicetree/bindings/phy/calxeda-combophy.yaml     | 2 +-
 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml  | 2 +-
 Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml      | 2 +-
 Documentation/devicetree/bindings/pinctrl/pinmux-node.yaml      | 2 +-
 Documentation/devicetree/bindings/power/fsl,scu-pd.yaml         | 2 +-
 Documentation/devicetree/bindings/riscv/cpus.yaml               | 2 +-
 Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml          | 2 +-
 Documentation/devicetree/bindings/spi/omap-spi.yaml             | 2 +-
 Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml  | 2 +-
 Documentation/devicetree/bindings/usb/usb-device.yaml           | 2 +-
 Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml     | 2 +-
 23 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/cirrus,cs2000-cp.yaml b/Documentation/devicetree/bindings/clock/cirrus,cs2000-cp.yaml
index 82836086cac1..d416c374e853 100644
--- a/Documentation/devicetree/bindings/clock/cirrus,cs2000-cp.yaml
+++ b/Documentation/devicetree/bindings/clock/cirrus,cs2000-cp.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/cirrus,cs2000-cp.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding CIRRUS LOGIC Fractional-N Clock Synthesizer & Clock Multiplier
+title: CIRRUS LOGIC Fractional-N Clock Synthesizer & Clock Multiplier
 
 maintainers:
   - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
diff --git a/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
index f2c48460a399..36d4cfc3c2f8 100644
--- a/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
+++ b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/fsl,scu-clk.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: i.MX SCU Client Device Node - Clock bindings based on SCU Message Protocol
+title: i.MX SCU Client Device Node - Clock Controller Based on SCU Message Protocol
 
 maintainers:
   - Abel Vesa <abel.vesa@nxp.com>
diff --git a/Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml b/Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
index 28c13237059f..3cb996b2c9d5 100644
--- a/Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,dispcc-sc8280xp.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/qcom,dispcc-sc8280xp.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Display Clock & Reset Controller Binding for SC8280XP
+title: Qualcomm Display Clock & Reset Controller on SC8280XP
 
 maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
diff --git a/Documentation/devicetree/bindings/example-schema.yaml b/Documentation/devicetree/bindings/example-schema.yaml
index 8e1a8b19d429..dfcf4c27d44a 100644
--- a/Documentation/devicetree/bindings/example-schema.yaml
+++ b/Documentation/devicetree/bindings/example-schema.yaml
@@ -11,7 +11,7 @@ $id: http://devicetree.org/schemas/example-schema.yaml#
 # $schema is the meta-schema this schema should be validated with.
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: An example schema annotated with jsonschema details
+title: An Example Device
 
 maintainers:
   - Rob Herring <robh@kernel.org>
diff --git a/Documentation/devicetree/bindings/input/fsl,scu-key.yaml b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
index e6266d188266..e5a3c355ee1f 100644
--- a/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
+++ b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/input/fsl,scu-key.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: i.MX SCU Client Device Node - SCU key bindings based on SCU Message Protocol
+title: i.MX SCU Client Device Node - SCU Key Based on SCU Message Protocol
 
 maintainers:
   - Dong Aisheng <aisheng.dong@nxp.com>
diff --git a/Documentation/devicetree/bindings/input/matrix-keymap.yaml b/Documentation/devicetree/bindings/input/matrix-keymap.yaml
index 6699d5e32dca..4d6dbe91646d 100644
--- a/Documentation/devicetree/bindings/input/matrix-keymap.yaml
+++ b/Documentation/devicetree/bindings/input/matrix-keymap.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/input/matrix-keymap.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Common key matrices binding for matrix-connected key boards
+title: Common Key Matrices on Matrix-connected Key Boards
 
 maintainers:
   - Olof Johansson <olof@lixom.net>
diff --git a/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
index 2929382625b6..d1b01bae9f63 100644
--- a/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
+++ b/Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/leds/issi,is31fl319x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: ISSI LED controllers bindings for IS31FL319{0,1,3,6,9}
+title: ISSI LED Controllers for IS31FL319{0,1,3,6,9}
 
 maintainers:
   - Vincent Knecht <vincent.knecht@mailoo.org>
diff --git a/Documentation/devicetree/bindings/net/asix,ax88178.yaml b/Documentation/devicetree/bindings/net/asix,ax88178.yaml
index a81dbc4792f6..768504ccbf74 100644
--- a/Documentation/devicetree/bindings/net/asix,ax88178.yaml
+++ b/Documentation/devicetree/bindings/net/asix,ax88178.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/net/asix,ax88178.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: The device tree bindings for the USB Ethernet controllers
+title: ASIX AX88172/AX88772 USB Ethernet Controllers
 
 maintainers:
   - Oleksij Rempel <o.rempel@pengutronix.de>
diff --git a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
index 3715c5f8f0e0..0b97e14d947f 100644
--- a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/net/microchip,lan95xx.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: The device tree bindings for the USB Ethernet controllers
+title: Microchip SMSC9500/LAN9530/LAN9730 USB Ethernet Controllers
 
 maintainers:
   - Oleksij Rempel <o.rempel@pengutronix.de>
diff --git a/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
index 682688299b26..f0a49283649d 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/nvmem/fsl,scu-ocotp.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: i.MX SCU Client Device Node - OCOTP bindings based on SCU Message Protocol
+title: i.MX SCU Client Device Node - OCOTP Based on SCU Message Protocol
 
 maintainers:
   - Dong Aisheng <aisheng.dong@nxp.com>
diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
index df8442fb11f0..b9ce2e099ce9 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/opp/opp-v2-qcom-level.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm OPP bindings to describe OPP nodes.
+title: Qualcomm OPP
 
 maintainers:
   - Niklas Cassel <nks@flawful.org>
diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
index ccec51ab5247..d1eef4825207 100644
--- a/Documentation/devicetree/bindings/pci/pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/pci/pci-ep.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: PCI Endpoint Controller Schema
+title: PCI Endpoint Controller
 
 description: |
   Common properties for PCI Endpoint Controller Nodes.
diff --git a/Documentation/devicetree/bindings/phy/calxeda-combophy.yaml b/Documentation/devicetree/bindings/phy/calxeda-combophy.yaml
index 41ee16e21f8d..d05a7c793035 100644
--- a/Documentation/devicetree/bindings/phy/calxeda-combophy.yaml
+++ b/Documentation/devicetree/bindings/phy/calxeda-combophy.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/phy/calxeda-combophy.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Calxeda Highbank Combination PHYs binding for SATA
+title: Calxeda Highbank Combination PHYs for SATA
 
 description: |
   The Calxeda Combination PHYs connect the SoC to the internal fabric
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
index 45ea565ce238..fcd729afeee1 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/pinctrl/fsl,scu-pinctrl.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: i.MX SCU Client Device Node - Pinctrl bindings based on SCU Message Protocol
+title: i.MX SCU Client Device Node - Pinctrl Based on SCU Message Protocol
 
 maintainers:
   - Dong Aisheng <aisheng.dong@nxp.com>
diff --git a/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml b/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
index f5a121311f61..be81ed22a036 100644
--- a/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pincfg-node.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/pinctrl/pincfg-node.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Generic pin configuration node schema
+title: Generic Pin Configuration Node
 
 maintainers:
   - Linus Walleij <linus.walleij@linaro.org>
diff --git a/Documentation/devicetree/bindings/pinctrl/pinmux-node.yaml b/Documentation/devicetree/bindings/pinctrl/pinmux-node.yaml
index 551df3d9b809..008c3ab7f1bb 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinmux-node.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinmux-node.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/pinctrl/pinmux-node.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Generic pin multiplexing node schema
+title: Generic Pin Multiplexing Node
 
 maintainers:
   - Linus Walleij <linus.walleij@linaro.org>
diff --git a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
index 1f72b18ca0fc..407b7cfec783 100644
--- a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/power/fsl,scu-pd.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: i.MX SCU Client Device Node - Power domain bindings based on SCU Message Protocol
+title: i.MX SCU Client Device Node - Power Domain Based on SCU Message Protocol
 
 maintainers:
   - Dong Aisheng <aisheng.dong@nxp.com>
diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index 83ad177a9043..c6720764e765 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/riscv/cpus.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: RISC-V bindings for 'cpus' DT nodes
+title: RISC-V CPUs
 
 maintainers:
   - Paul Walmsley <paul.walmsley@sifive.com>
diff --git a/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
index 8c102b70d735..dd1b1abf1e1b 100644
--- a/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/rtc/fsl,scu-rtc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: i.MX SCU Client Device Node - RTC bindings based on SCU Message Protocol
+title: i.MX SCU Client Device Node - RTC Based on SCU Message Protocol
 
 maintainers:
   - Dong Aisheng <aisheng.dong@nxp.com>
diff --git a/Documentation/devicetree/bindings/spi/omap-spi.yaml b/Documentation/devicetree/bindings/spi/omap-spi.yaml
index 9952199cae11..352affa4b7f8 100644
--- a/Documentation/devicetree/bindings/spi/omap-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/omap-spi.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/spi/omap-spi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: SPI controller bindings for OMAP and K3 SoCs
+title: SPI Controller on OMAP and K3 SoCs
 
 maintainers:
   - Aswath Govindraju <a-govindraju@ti.com>
diff --git a/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml b/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
index f9e4b3c8d0ee..3721c8c8ec64 100644
--- a/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/thermal/fsl,scu-thermal.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: i.MX SCU Client Device Node - Thermal bindings based on SCU Message Protocol
+title: i.MX SCU Client Device Node - Thermal Based on SCU Message Protocol
 
 maintainers:
   - Dong Aisheng <aisheng.dong@nxp.com>
diff --git a/Documentation/devicetree/bindings/usb/usb-device.yaml b/Documentation/devicetree/bindings/usb/usb-device.yaml
index b77960a7a37b..7a771125ec76 100644
--- a/Documentation/devicetree/bindings/usb/usb-device.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-device.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/usb/usb-device.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: The device tree bindings for the Generic USB Device
+title: Generic USB Device
 
 maintainers:
   - Greg Kroah-Hartman <gregkh@linuxfoundation.org>
diff --git a/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
index f84c45d687d7..47701248cd8d 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/watchdog/fsl,scu-wdt.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: i.MX SCU Client Device Node - Watchdog bindings based on SCU Message Protocol
+title: i.MX SCU Client Device Node - Watchdog Based on SCU Message Protocol
 
 maintainers:
   - Dong Aisheng <aisheng.dong@nxp.com>
-- 
2.34.1

