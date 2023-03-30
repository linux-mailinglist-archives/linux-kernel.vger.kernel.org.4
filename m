Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532F36D0FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjC3UFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjC3UFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:05:30 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9233BE050;
        Thu, 30 Mar 2023 13:05:27 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id bj20so15118119oib.3;
        Thu, 30 Mar 2023 13:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680206727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KiMvNQcyZnd9TUPhF68UxGP6xQ/mFC+IWGdSvNvmMD8=;
        b=xgE6sfTNWhMIx3haFE59z05l4opbn7zkxHAfYkf8a7oRrH0pmHZbyce1OpFTpvUtxu
         ojAvZVg9pJyJFNjYPovZLjZePsL1XwZ/6lZGNqCxzmdx03wAKJ1Y1Iuu68VCW3gvy8M6
         /V8MacY2pr5h8LmqgX5W+Jj3J4AizV+II+wF7efpjIUyGP5G8BHkKIhL0Bhv3V39oOiB
         DH54ATw8KcdYmEem0gvfXIHbclkhBTBTbNJwqBrP7PWjaJ1X3j7vHesIzBlnKFGoxfhr
         rhfAsoq8k24y82Q47RjBBROwsBFKEJyZ++1Fo0DHfGvJUo5t1w6fEBubpbOpYWjLwcWP
         KF2g==
X-Gm-Message-State: AO0yUKWls2dvIIPaHZi/HagDtoSVvnXYAQci54pu2cbd6FBHYSL+qAvt
        POEPyPl/Udp48NPBdSinEw==
X-Google-Smtp-Source: AK7set9uB43EiU3mlS0AsgQ3nzU22V2Vk9f34J8KLofKoQXvTI7sZ5znPOy8+WtYoZ87FUnkoRakIA==
X-Received: by 2002:a05:6808:2d3:b0:386:8c30:6e92 with SMTP id a19-20020a05680802d300b003868c306e92mr8002325oid.14.1680206726520;
        Thu, 30 Mar 2023 13:05:26 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i185-20020aca3bc2000000b003848dbe505fsm232370oia.57.2023.03.30.13.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 13:05:26 -0700 (PDT)
Received: (nullmailer pid 2733505 invoked by uid 1000);
        Thu, 30 Mar 2023 20:05:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Dvorkin Dmitry <dvorkin@tibbo.com>,
        Wells Lu <wellslutw@gmail.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Michal Simek <michal.simek@xilinx.com>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?Q?Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        - <patches@opensource.cirrus.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Peng Fan <peng.fan@nxp.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Drew Fustini <drew@beagleboard.org>,
        Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, asahi@lists.linux.dev,
        linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2] dt-bindings: pinctrl: Drop unneeded quotes
Date:   Thu, 30 Mar 2023 15:03:58 -0500
Message-Id: <20230330200402.2731992-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Hector Martin <marcan@marcan.st>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de> #rockchip
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - Rebase on pinctrl tree
---
 .../bindings/pinctrl/actions,s500-pinctrl.yaml         |  2 +-
 .../bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |  2 +-
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml     |  2 +-
 .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml       |  4 ++--
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml       |  4 ++--
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml       |  6 +++---
 .../bindings/pinctrl/brcm,bcm6318-pinctrl.yaml         |  2 +-
 .../bindings/pinctrl/brcm,bcm63268-pinctrl.yaml        |  2 +-
 .../bindings/pinctrl/brcm,bcm6328-pinctrl.yaml         |  2 +-
 .../bindings/pinctrl/brcm,bcm6358-pinctrl.yaml         |  2 +-
 .../bindings/pinctrl/brcm,bcm6362-pinctrl.yaml         |  2 +-
 .../bindings/pinctrl/brcm,bcm6368-pinctrl.yaml         |  2 +-
 .../devicetree/bindings/pinctrl/brcm,ns-pinmux.yaml    |  2 +-
 .../devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml |  2 +-
 .../devicetree/bindings/pinctrl/cirrus,lochnagar.yaml  |  2 +-
 .../devicetree/bindings/pinctrl/cirrus,madera.yaml     |  4 ++--
 .../devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml  |  2 +-
 .../devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml |  2 +-
 .../devicetree/bindings/pinctrl/fsl,imx8m-pinctrl.yaml |  2 +-
 .../bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml          |  2 +-
 .../devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml |  2 +-
 .../devicetree/bindings/pinctrl/ingenic,pinctrl.yaml   |  2 +-
 .../devicetree/bindings/pinctrl/intel,lgm-io.yaml      |  2 +-
 .../bindings/pinctrl/marvell,ac5-pinctrl.yaml          |  4 ++--
 .../bindings/pinctrl/mscc,ocelot-pinctrl.yaml          |  6 +++---
 .../devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml    |  4 ++--
 .../devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml     |  4 ++--
 .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml         |  2 +-
 .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml         |  2 +-
 .../devicetree/bindings/pinctrl/qcom,tlmm-common.yaml  |  2 +-
 .../devicetree/bindings/pinctrl/renesas,pfc.yaml       |  2 +-
 .../bindings/pinctrl/renesas,rza1-ports.yaml           |  2 +-
 .../bindings/pinctrl/renesas,rza2-pinctrl.yaml         |  2 +-
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml        |  2 +-
 .../bindings/pinctrl/renesas,rzn1-pinctrl.yaml         |  2 +-
 .../bindings/pinctrl/renesas,rzv2m-pinctrl.yaml        |  2 +-
 .../devicetree/bindings/pinctrl/rockchip,pinctrl.yaml  | 10 +++++-----
 .../devicetree/bindings/pinctrl/samsung,pinctrl.yaml   |  2 +-
 .../devicetree/bindings/pinctrl/semtech,sx1501q.yaml   |  6 +++---
 .../bindings/pinctrl/socionext,uniphier-pinctrl.yaml   |  2 +-
 .../devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml  | 10 +++++-----
 .../bindings/pinctrl/starfive,jh7100-pinctrl.yaml      |  6 +++---
 .../bindings/pinctrl/sunplus,sp7021-pinctrl.yaml       |  6 +++---
 .../bindings/pinctrl/toshiba,visconti-pinctrl.yaml     |  8 ++++----
 .../devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml |  2 +-
 45 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/actions,s500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/actions,s500-pinctrl.yaml
index fb0f69ce9c16..7cb8a747feee 100644
--- a/Documentation/devicetree/bindings/pinctrl/actions,s500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/actions,s500-pinctrl.yaml
@@ -185,7 +185,7 @@ patternProperties:
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
index 1e3c8de6cae1..467016cbb037 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml
@@ -142,7 +142,7 @@ allOf:
   # boards are defining it at the moment so it would generate a lot of
   # warnings.
 
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
   - if:
       not:
         properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
index d3b11351ca45..9b4e0ae61ffe 100644
--- a/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
@@ -73,7 +73,7 @@ patternProperties:
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
index f4f1ee6b116e..bef85c25cdef 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml
@@ -32,7 +32,7 @@ patternProperties:
     then:
       patternProperties:
         "^function|groups$":
-          $ref: "/schemas/types.yaml#/definitions/string"
+          $ref: /schemas/types.yaml#/definitions/string
           enum: [ ACPI, ADC0, ADC1, ADC10, ADC11, ADC12, ADC13, ADC14, ADC15,
                   ADC2, ADC3, ADC4, ADC5, ADC6, ADC7, ADC8, ADC9, BMCINT, DDCCLK, DDCDAT,
                   EXTRST, FLACK, FLBUSY, FLWP, GPID, GPID0, GPID2, GPID4, GPID6, GPIE0,
@@ -51,7 +51,7 @@ patternProperties:
                   VGAHS, VGAVS, VPI18, VPI24, VPI30, VPO12, VPO24, WDTRST1, WDTRST2]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
index 8168f0088471..14c391f16899 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml
@@ -44,7 +44,7 @@ patternProperties:
     then:
       patternProperties:
         "^function|groups$":
-          $ref: "/schemas/types.yaml#/definitions/string"
+          $ref: /schemas/types.yaml#/definitions/string
           enum: [ ACPI, ADC0, ADC1, ADC10, ADC11, ADC12, ADC13, ADC14, ADC15,
                   ADC2, ADC3, ADC4, ADC5, ADC6, ADC7, ADC8, ADC9, BMCINT, DDCCLK, DDCDAT,
                   ESPI, FWSPICS1, FWSPICS2, GPID0, GPID2, GPID4, GPID6, GPIE0, GPIE2,
@@ -65,7 +65,7 @@ patternProperties:
                   VGAVS, VPI24, VPO, WDTRST1, WDTRST2]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
index 62424c42c981..859a1889dc1e 100644
--- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml
@@ -30,7 +30,7 @@ patternProperties:
     then:
       properties:
         function:
-          $ref: "/schemas/types.yaml#/definitions/string"
+          $ref: /schemas/types.yaml#/definitions/string
           enum: [ ADC0, ADC1, ADC10, ADC11, ADC12, ADC13, ADC14, ADC15, ADC2,
                   ADC3, ADC4, ADC5, ADC6, ADC7, ADC8, ADC9, BMCINT, EMMC, ESPI, ESPIALT,
                   FSI1, FSI2, FWQSPI, FWSPIABR, FWSPID, FWSPIWP, GPIT0, GPIT1, GPIT2, GPIT3,
@@ -55,7 +55,7 @@ patternProperties:
                   USB2BD, USB2BH, VB, VGAHS, VGAVS, WDTRST1, WDTRST2, WDTRST3, WDTRST4 ]
 
         groups:
-          $ref: "/schemas/types.yaml#/definitions/string"
+          $ref: /schemas/types.yaml#/definitions/string
           enum: [ ADC0, ADC1, ADC10, ADC11, ADC12, ADC13, ADC14, ADC15, ADC2,
                   ADC3, ADC4, ADC5, ADC6, ADC7, ADC8, ADC9, BMCINT, EMMCG1, EMMCG4,
                   EMMCG8, ESPI, ESPIALT, FSI1, FSI2, FWQSPI, FWSPIABR, FWSPID, FWSPIWP,
@@ -84,7 +84,7 @@ patternProperties:
                   WDTRST3, WDTRST4]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml
index ab019a1998e8..4478a76171f7 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6318-pinctrl.yaml
@@ -38,7 +38,7 @@ patternProperties:
                 gpio8, gpio9, gpio10, gpio11, gpio12, gpio13, gpio40 ]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml
index 8c9d4668c8c4..73e1caa7c011 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm63268-pinctrl.yaml
@@ -42,7 +42,7 @@ patternProperties:
                 vdsl_phy_override_3_grp, dsl_gpio8, dsl_gpio9 ]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml
index a8e22ec02215..2750ba42aeb8 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6328-pinctrl.yaml
@@ -37,7 +37,7 @@ patternProperties:
                 usb_port1 ]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml
index 35867355a47a..2f6c540498bc 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6358-pinctrl.yaml
@@ -35,7 +35,7 @@ patternProperties:
                 led_grp, spi_cs_grp, utopia_grp, pwm_syn_clk, sys_irq_grp ]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml
index b584d4b27223..b3044f805753 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6362-pinctrl.yaml
@@ -42,7 +42,7 @@ patternProperties:
                 gpio22, gpio23, gpio24, gpio25, gpio26, gpio27, nand_grp ]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml
index 229323d9237d..3236871827df 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm6368-pinctrl.yaml
@@ -43,7 +43,7 @@ patternProperties:
                 gpio31, uart1_grp ]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.yaml
index 8d1e5b1cdd5f..0a39dd26ee1a 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.yaml
@@ -53,7 +53,7 @@ patternProperties:
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml b/Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml
index a78cb2796001..7f4f36a58e56 100644
--- a/Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/canaan,k210-fpioa.yaml
@@ -144,7 +144,7 @@ patternProperties:
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
index 5cd512b7d5ba..5e000b3fadde 100644
--- a/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.yaml
@@ -173,7 +173,7 @@ properties:
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
index 6bd42e43cdab..bb61a30321a1 100644
--- a/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/cirrus,madera.yaml
@@ -40,8 +40,8 @@ properties:
       '-pins$':
         type: object
         allOf:
-          - $ref: "pincfg-node.yaml#"
-          - $ref: "pinmux-node.yaml#"
+          - $ref: pincfg-node.yaml#
+          - $ref: pinmux-node.yaml#
         properties:
           groups:
             description:
diff --git a/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml b/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
index 915cbbcc3555..222d57541b65 100644
--- a/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
@@ -109,7 +109,7 @@ required:
 additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml
index 621038662188..7bd723ab1281 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml
@@ -68,7 +68,7 @@ patternProperties:
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8m-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8m-pinctrl.yaml
index 7ae084397258..6068be11dfe2 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8m-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8m-pinctrl.yaml
@@ -65,7 +65,7 @@ patternProperties:
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml
index 693398d88223..7dcf681271d3 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml
@@ -57,7 +57,7 @@ patternProperties:
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
index 66baa6082a4f..2f2405102996 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
@@ -14,7 +14,7 @@ description:
   for common binding part and usage.
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.yaml
index a4397930e0e8..35723966b70a 100644
--- a/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/ingenic,pinctrl.yaml
@@ -119,7 +119,7 @@ patternProperties:
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml b/Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml
index ca0fef6e535e..1144ca2896e3 100644
--- a/Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/intel,lgm-io.yaml
@@ -48,7 +48,7 @@ patternProperties:
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
index 491f67e7cc4f..afea9424c7e1 100644
--- a/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/marvell,ac5-pinctrl.yaml
@@ -28,7 +28,7 @@ patternProperties:
 
     properties:
       marvell,function:
-        $ref: "/schemas/types.yaml#/definitions/string"
+        $ref: /schemas/types.yaml#/definitions/string
         description:
           Indicates the function to select.
         enum: [ dev_init_done, ge, gpio, i2c0, i2c1, int_out, led, nand, pcie, ptp, sdio,
@@ -47,7 +47,7 @@ patternProperties:
                   mpp40, mpp41, mpp42, mpp43, mpp44, mpp45 ]
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
index 98d547c34ef3..dbb3e1bd58c1 100644
--- a/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
@@ -54,8 +54,8 @@ patternProperties:
   '-pins$':
     type: object
     allOf:
-      - $ref: "pinmux-node.yaml"
-      - $ref: "pincfg-node.yaml"
+      - $ref: pinmux-node.yaml
+      - $ref: pincfg-node.yaml
 
     properties:
       function: true
@@ -78,7 +78,7 @@ required:
   - gpio-ranges
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
index db505fdeac86..1096655961f7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
@@ -395,8 +395,8 @@ $defs:
   qcom-pmic-gpio-state:
     type: object
     allOf:
-      - $ref: "pinmux-node.yaml"
-      - $ref: "pincfg-node.yaml"
+      - $ref: pinmux-node.yaml
+      - $ref: pincfg-node.yaml
     properties:
       pins:
         description:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
index 9412b9362328..c91d3e3a094b 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
@@ -82,8 +82,8 @@ $defs:
   qcom-pmic-mpp-state:
     type: object
     allOf:
-      - $ref: "pinmux-node.yaml"
-      - $ref: "pincfg-node.yaml"
+      - $ref: pinmux-node.yaml
+      - $ref: pincfg-node.yaml
     properties:
       pins:
         description:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
index e51feb4c0700..fa51fa9536f7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
@@ -50,7 +50,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "/schemas/pinctrl/pincfg-node.yaml"
+    $ref: /schemas/pinctrl/pincfg-node.yaml
 
     properties:
       pins:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
index de9d8854c690..4b4be7efc150 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml
@@ -55,7 +55,7 @@ $defs:
     description:
       Pinctrl node's client devices use subnodes for desired pin configuration.
       Client device subnodes use below standard properties.
-    $ref: "/schemas/pinctrl/pincfg-node.yaml"
+    $ref: /schemas/pinctrl/pincfg-node.yaml
 
     properties:
       pins:
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
index cb5ba1bd6f8d..2da1437358b7 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,tlmm-common.yaml
@@ -52,7 +52,7 @@ properties:
       information.
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - interrupts
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
index 4fc758fea7e6..0fc3c0f52c19 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
@@ -73,7 +73,7 @@ properties:
     maxItems: 1
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml
index 9083040c996a..83800fcf0ce4 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml
@@ -32,7 +32,7 @@ properties:
     maxItems: 1
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml
index d761fddc2206..37173a64fed2 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.yaml
@@ -73,7 +73,7 @@ patternProperties:
       additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
index f081acb7ba04..9ce1a07fc015 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -113,7 +113,7 @@ additionalProperties:
         $ref: "#/additionalProperties/anyOf/0"
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml
index 70b1788ab594..f3b85b7eae31 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml
@@ -32,7 +32,7 @@ properties:
       The bus clock, sometimes described as pclk, for register accesses.
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
index eac6245db7dc..03f084292d68 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
@@ -94,7 +94,7 @@ additionalProperties:
         $ref: "#/additionalProperties/anyOf/0"
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
index 45b767986a87..10c335efe619 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
@@ -50,12 +50,12 @@ properties:
       - rockchip,rv1126-pinctrl
 
   rockchip,grf:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
     description:
       The phandle of the syscon node for the GRF registers.
 
   rockchip,pmu:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
     description:
       The phandle of the syscon node for the PMU registers,
       as some SoCs carry parts of the iomux controller registers there.
@@ -71,7 +71,7 @@ properties:
   ranges: true
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
@@ -81,7 +81,7 @@ patternProperties:
   "gpio@[0-9a-f]+$":
     type: object
 
-    $ref: "/schemas/gpio/rockchip,gpio-bank.yaml#"
+    $ref: /schemas/gpio/rockchip,gpio-bank.yaml#
     deprecated: true
 
     unevaluatedProperties: false
@@ -117,7 +117,7 @@ additionalProperties:
     type: object
     properties:
       rockchip,pins:
-        $ref: "/schemas/types.yaml#/definitions/uint32-matrix"
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
         minItems: 1
         items:
           items:
diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
index eb2b2692607d..26614621774a 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl.yaml
@@ -117,7 +117,7 @@ required:
   - reg
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml b/Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml
index 0719c03d6f4b..4214d7311f6b 100644
--- a/Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/semtech,sx1501q.yaml
@@ -62,8 +62,8 @@ patternProperties:
       - pins
 
     allOf:
-      - $ref: "pincfg-node.yaml#"
-      - $ref: "pinmux-node.yaml#"
+      - $ref: pincfg-node.yaml#
+      - $ref: pinmux-node.yaml#
       - if:
           properties:
             pins:
@@ -86,7 +86,7 @@ required:
   - gpio-controller
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
   - if:
       not:
         properties:
diff --git a/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
index bc34e2c872bc..a6f34df82e90 100644
--- a/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/socionext,uniphier-pinctrl.yaml
@@ -61,7 +61,7 @@ additionalProperties:
     unevaluatedProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
index eeb29b4ad4d1..1ab0f8dde477 100644
--- a/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml
@@ -44,7 +44,7 @@ properties:
 
   st,syscfg:
     description: Phandle+args to the syscon node which includes IRQ mux selection.
-    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     items:
       - items:
           - description: syscon node which includes IRQ mux selection
@@ -89,7 +89,7 @@ patternProperties:
       st,bank-name:
         description:
           Should be a name string for this bank as specified in the datasheet.
-        $ref: "/schemas/types.yaml#/definitions/string"
+        $ref: /schemas/types.yaml#/definitions/string
         enum:
           - GPIOA
           - GPIOB
@@ -108,7 +108,7 @@ patternProperties:
         description:
           Should correspond to the EXTI IOport selection (EXTI line used
           to select GPIOs as interrupts).
-        $ref: "/schemas/types.yaml#/definitions/uint32"
+        $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 11
 
@@ -140,7 +140,7 @@ patternProperties:
           configuration, pullups, drive, output high/low and output speed.
         properties:
           pinmux:
-            $ref: "/schemas/types.yaml#/definitions/uint32-array"
+            $ref: /schemas/types.yaml#/definitions/uint32-array
             description: |
               Integer array, represents gpio pin number and mux setting.
               Supported pin number and mux varies for different SoCs, and are
@@ -201,7 +201,7 @@ patternProperties:
           - pinmux
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
index 69c0dd9998ea..27eff891685b 100644
--- a/Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
@@ -111,7 +111,7 @@ patternProperties:
           pins it needs, and how they should be configured, with regard to
           muxer configuration, bias, input enable/disable, input schmitt
           trigger enable/disable, slew-rate and drive strength.
-        $ref: "/schemas/pinctrl/pincfg-node.yaml"
+        $ref: /schemas/pinctrl/pincfg-node.yaml
 
         properties:
           pins:
@@ -120,14 +120,14 @@ patternProperties:
               This should be set using either the PAD_GPIO or PAD_FUNC_SHARE
               macros.
               Either this or "pinmux" has to be specified, but not both.
-            $ref: "/schemas/pinctrl/pinmux-node.yaml#/properties/pins"
+            $ref: /schemas/pinctrl/pinmux-node.yaml#/properties/pins
 
           pinmux:
             description: |
               The list of GPIOs and their mux settings that properties in the
               node apply to. This should be set using the GPIOMUX macro.
               Either this or "pins" has to be specified, but not both.
-            $ref: "/schemas/pinctrl/pinmux-node.yaml#/properties/pinmux"
+            $ref: /schemas/pinctrl/pinmux-node.yaml#/properties/pinmux
 
           bias-disable: true
 
diff --git a/Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml
index 347061eece9e..94b868c7ceb1 100644
--- a/Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/sunplus,sp7021-pinctrl.yaml
@@ -138,7 +138,7 @@ patternProperties:
         description: |
           Define pin-function which is used by pinctrl node's client device.
           The name should be one of string in the following enumeration.
-        $ref: "/schemas/types.yaml#/definitions/string"
+        $ref: /schemas/types.yaml#/definitions/string
         enum: [ SPI_FLASH, SPI_FLASH_4BIT, SPI_NAND, CARD0_EMMC, SD_CARD,
                 UA0, FPGA_IFX, HDMI_TX, LCDIF, USB0_OTG, USB1_OTG ]
 
@@ -146,7 +146,7 @@ patternProperties:
         description: |
           Define pin-group in a specified pin-function.
           The name should be one of string in the following enumeration.
-        $ref: "/schemas/types.yaml#/definitions/string"
+        $ref: /schemas/types.yaml#/definitions/string
         enum: [ SPI_FLASH1, SPI_FLASH2, SPI_FLASH_4BIT1, SPI_FLASH_4BIT2,
                 SPI_NAND, CARD0_EMMC, SD_CARD, UA0, FPGA_IFX, HDMI_TX1,
                 HDMI_TX2, HDMI_TX3, LCDIF, USB0_OTG, USB1_OTG ]
@@ -289,7 +289,7 @@ required:
 additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
index 98b4663f9766..19d47fd414bc 100644
--- a/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
@@ -21,7 +21,7 @@ properties:
     maxItems: 1
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
@@ -35,14 +35,14 @@ patternProperties:
       pinctrl groups available on the machine. Each subnode will list the
       pins it needs, and how they should be configured, with regard to muxer
       configuration, pullups, drive strength.
-    $ref: "pinmux-node.yaml"
+    $ref: pinmux-node.yaml
     additionalProperties: false
 
     properties:
       function:
         description:
           Function to mux.
-        $ref: "/schemas/types.yaml#/definitions/string"
+        $ref: /schemas/types.yaml#/definitions/string
         enum: [i2c0, i2c1, i2c2, i2c3, i2c4, i2c5, i2c6, i2c7, i2c8,
                spi0, spi1, spi2, spi3, spi4, spi5, spi6,
                uart0, uart1, uart2, uart3, pwm, pcmif_out, pcmif_in]
@@ -50,7 +50,7 @@ patternProperties:
       groups:
         description:
           Name of the pin group to use for the functions.
-        $ref: "/schemas/types.yaml#/definitions/string"
+        $ref: /schemas/types.yaml#/definitions/string
         enum: [i2c0_grp, i2c1_grp, i2c2_grp, i2c3_grp, i2c4_grp,
                i2c5_grp, i2c6_grp, i2c7_grp, i2c8_grp,
                spi0_grp, spi0_cs0_grp, spi0_cs1_grp, spi0_cs2_grp,
diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml
index cfd0cc549a7b..598a042850b8 100644
--- a/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml
@@ -168,7 +168,7 @@ patternProperties:
     additionalProperties: false
 
 allOf:
-  - $ref: "pinctrl.yaml#"
+  - $ref: pinctrl.yaml#
 
 required:
   - compatible
-- 
2.39.2

