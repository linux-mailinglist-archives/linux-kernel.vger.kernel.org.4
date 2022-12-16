Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDC364EF85
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiLPQjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiLPQit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:38:49 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8406B53EF4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:38:31 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id l8so2685845ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxtsg45EtvhiTXQMjubjcSPDW2o608qZyWiPSJFemPs=;
        b=hiHwQKfHY/Xz59W6Hk6qQsvr9jGHeBNlNIJ4bb6swjvCCkIoIK1JpsU3OkGABFfojQ
         XfUQo5Tj+9iXkEkgzgYllbEttWdxQGPQQtwpiCg6xEBe5l5rc3I3HY2zn3pSpJJpHMml
         j5CNcP0O/qWBnTvZ1n2xWIl73Sd7N1Kcw5gU7CFxbmkn55XtjChrCCL7yBOGl9lYv7Ye
         LG2ux7wZ90GPJ9grIrv+FlQuWxTc+b48lkv9LAacwNEcPUAQlsDB8kREu26BXgvs3i2l
         PAR3Rha8ZXDMVzDR0oIXgufTRShd1kLKNXMfTxNuvELFl9WTesRyXdbU2P1Nb69Y1Pgn
         iB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxtsg45EtvhiTXQMjubjcSPDW2o608qZyWiPSJFemPs=;
        b=kCYE2BfexOxCi6jRHAabq2QlgulelnDgN+f0MN9zR7+3CjhWw8jCtyu2Dnz0+qQ7Wd
         NDNZF4Wexk2afED9orNLeYiIIp5u4b+CeSPs7UwfP15XNNtZq/DhCXaVVnFgN1DrXYYM
         dn4ffK0zT6B5o3Nr+9wGSh2kWa7RfrHLOl+OFxA+O65zXCaX7lrPWIt72KAylMJvHEyi
         duK4A5q7FAF/NyN1t3ftrKIvLLcu+yJim+9Vjm3WZODnnI+ko/Ay96k1J+ge4iGPY4ab
         oTpFPVgL7qfSwjKH2NwbIRn8iwzHAekl8CNeZogwNzM+JfmXwbvJxzo4qlSii/4MYB18
         Ju5Q==
X-Gm-Message-State: ANoB5pmAh0fcK3MbTI65hABW3oEGyVMSk0dNxEZ5nynx7IHtOB1iODTg
        XWteRgZwkinGcbolxVb1aoD7Wg==
X-Google-Smtp-Source: AA0mqf4lr8s3/ul7rUWjmeEVpBJm3i6jBHN+kBYULEAJAE0InXshZS2oBuXeGNIvRiIOXavvTRyNxw==
X-Received: by 2002:a05:651c:1792:b0:277:9b1:7515 with SMTP id bn18-20020a05651c179200b0027709b17515mr11151326ljb.6.1671208710941;
        Fri, 16 Dec 2022 08:38:30 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p10-20020a2eba0a000000b0026fc79fd67dsm193930lja.74.2022.12.16.08.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:38:30 -0800 (PST)
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
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v3 7/9] dt-bindings: drop redundant part of title (beginning)
Date:   Fri, 16 Dec 2022 17:38:13 +0100
Message-Id: <20221216163815.522628-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221216163815.522628-1-krzysztof.kozlowski@linaro.org>
References: <20221216163815.522628-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
it is a "Devicetree binding", but instead just describe the hardware.

Drop beginning "Devicetree bindings" in various forms:

  find Documentation/devicetree/bindings/ -type f -name '*.yaml' \
    -exec sed -i -e 's/^title: [dD]evice[ -]\?[tT]ree [bB]indings\? for \([tT]he \)\?\(.*\)$/title: \u\2/' {} \;

  find Documentation/devicetree/bindings/ -type f -name '*.yaml' \
    -exec sed -i -e 's/^title: [bB]indings\? for \([tT]he \)\?\(.*\)$/title: \u\2/' {} \;

  find Documentation/devicetree/bindings/ -type f -name '*.yaml' \
    -exec sed -i -e 's/^title: [dD][tT] [bB]indings\? for \([tT]he \)\?\(.*\)$/title: \u\2/' {} \;

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # MMC
Acked-by: Stephen Boyd <sboyd@kernel.org> # clk
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # input
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Sebastian Reichel <sre@kernel.org> # power
---
 Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml     | 2 +-
 Documentation/devicetree/bindings/clock/fixed-clock.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml | 2 +-
 Documentation/devicetree/bindings/clock/fixed-mmio-clock.yaml   | 2 +-
 Documentation/devicetree/bindings/clock/idt,versaclock5.yaml    | 2 +-
 Documentation/devicetree/bindings/clock/renesas,9series.yaml    | 2 +-
 Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml       | 2 +-
 .../devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml | 2 +-
 .../devicetree/bindings/display/bridge/intel,keembay-dsi.yaml   | 2 +-
 .../devicetree/bindings/display/intel,keembay-display.yaml      | 2 +-
 .../devicetree/bindings/display/intel,keembay-msscam.yaml       | 2 +-
 Documentation/devicetree/bindings/display/msm/gmu.yaml          | 2 +-
 Documentation/devicetree/bindings/display/msm/gpu.yaml          | 2 +-
 .../devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml | 2 +-
 .../devicetree/bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml   | 2 +-
 .../devicetree/bindings/gpu/host1x/nvidia,tegra210-nvenc.yaml   | 2 +-
 .../devicetree/bindings/gpu/host1x/nvidia,tegra210-nvjpg.yaml   | 2 +-
 .../devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml   | 2 +-
 Documentation/devicetree/bindings/i2c/i2c-gpio.yaml             | 2 +-
 Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml         | 2 +-
 .../devicetree/bindings/iio/adc/sigma-delta-modulator.yaml      | 2 +-
 Documentation/devicetree/bindings/input/gpio-keys.yaml          | 2 +-
 Documentation/devicetree/bindings/input/microchip,cap11xx.yaml  | 2 +-
 .../devicetree/bindings/interrupt-controller/renesas,irqc.yaml  | 2 +-
 Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml | 2 +-
 Documentation/devicetree/bindings/leds/register-bit-led.yaml    | 2 +-
 Documentation/devicetree/bindings/leds/regulator-led.yaml       | 2 +-
 Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml         | 2 +-
 Documentation/devicetree/bindings/net/ingenic,mac.yaml          | 2 +-
 Documentation/devicetree/bindings/power/supply/bq2415x.yaml     | 2 +-
 Documentation/devicetree/bindings/power/supply/bq24190.yaml     | 2 +-
 Documentation/devicetree/bindings/power/supply/bq24257.yaml     | 2 +-
 Documentation/devicetree/bindings/power/supply/bq24735.yaml     | 2 +-
 Documentation/devicetree/bindings/power/supply/bq25890.yaml     | 2 +-
 Documentation/devicetree/bindings/power/supply/isp1704.yaml     | 2 +-
 .../devicetree/bindings/power/supply/lltc,ltc294x.yaml          | 2 +-
 .../devicetree/bindings/power/supply/richtek,rt9455.yaml        | 2 +-
 Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml   | 2 +-
 Documentation/devicetree/bindings/regulator/pwm-regulator.yaml  | 2 +-
 Documentation/devicetree/bindings/rng/ingenic,rng.yaml          | 2 +-
 Documentation/devicetree/bindings/rng/ingenic,trng.yaml         | 2 +-
 Documentation/devicetree/bindings/serial/8250_omap.yaml         | 2 +-
 Documentation/devicetree/bindings/serio/ps2-gpio.yaml           | 2 +-
 Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml       | 2 +-
 Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml   | 2 +-
 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml       | 2 +-
 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml       | 2 +-
 Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml       | 2 +-
 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml     | 2 +-
 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml    | 2 +-
 Documentation/devicetree/bindings/usb/realtek,rts5411.yaml      | 2 +-
 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml         | 2 +-
 Documentation/devicetree/bindings/usb/ti,usb8041.yaml           | 2 +-
 53 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
index 983033fe5b17..5e942bccf277 100644
--- a/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
+++ b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/adi,axi-clkgen.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for Analog Devices AXI clkgen pcore clock generator
+title: Analog Devices AXI clkgen pcore clock generator
 
 maintainers:
   - Lars-Peter Clausen <lars@metafoo.de>
diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
index b657ecd0ef1c..b0a4fb8256e2 100644
--- a/Documentation/devicetree/bindings/clock/fixed-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for simple fixed-rate clock sources
+title: Simple fixed-rate clock sources
 
 maintainers:
   - Michael Turquette <mturquette@baylibre.com>
diff --git a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
index 0b02378a3a0c..8f71ab300470 100644
--- a/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/fixed-factor-clock.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for simple fixed factor rate clock sources
+title: Simple fixed factor rate clock sources
 
 maintainers:
   - Michael Turquette <mturquette@baylibre.com>
diff --git a/Documentation/devicetree/bindings/clock/fixed-mmio-clock.yaml b/Documentation/devicetree/bindings/clock/fixed-mmio-clock.yaml
index 1453ac849a65..e22fc272d023 100644
--- a/Documentation/devicetree/bindings/clock/fixed-mmio-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/fixed-mmio-clock.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/fixed-mmio-clock.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for simple memory mapped IO fixed-rate clock sources
+title: Simple memory mapped IO fixed-rate clock sources
 
 description:
   This binding describes a fixed-rate clock for which the frequency can
diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
index f9ba9864d8b5..61b246cf5e72 100644
--- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
+++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/idt,versaclock5.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for IDT VersaClock 5 and 6 programmable I2C clock generators
+title: IDT VersaClock 5 and 6 programmable I2C clock generators
 
 description: |
   The IDT VersaClock 5 and VersaClock 6 are programmable I2C
diff --git a/Documentation/devicetree/bindings/clock/renesas,9series.yaml b/Documentation/devicetree/bindings/clock/renesas,9series.yaml
index 102eb95cb3fc..6b6cec3fba52 100644
--- a/Documentation/devicetree/bindings/clock/renesas,9series.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,9series.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/renesas,9series.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for Renesas 9-series I2C PCIe clock generators
+title: Renesas 9-series I2C PCIe clock generators
 
 description: |
   The Renesas 9-series are I2C PCIe clock generators providing
diff --git a/Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml b/Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml
index c56f911fff47..d525f96cf244 100644
--- a/Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml
+++ b/Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/ti/ti,clksel.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for TI clksel clock
+title: TI clksel clock
 
 maintainers:
   - Tony Lindgren <tony@atomide.com>
diff --git a/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
index 89490fdffeb0..0b27df429bdc 100644
--- a/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ingenic,jz4780-hdmi.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/display/bridge/ingenic,jz4780-hdmi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bindings for Ingenic JZ4780 HDMI Transmitter
+title: Ingenic JZ4780 HDMI Transmitter
 
 maintainers:
   - H. Nikolaus Schaller <hns@goldelico.com>
diff --git a/Documentation/devicetree/bindings/display/bridge/intel,keembay-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/intel,keembay-dsi.yaml
index dcb1336ee2a5..958a073f4ff7 100644
--- a/Documentation/devicetree/bindings/display/bridge/intel,keembay-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/intel,keembay-dsi.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/display/bridge/intel,keembay-dsi.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Devicetree bindings for Intel Keem Bay mipi dsi controller
+title: Intel Keem Bay mipi dsi controller
 
 maintainers:
   - Anitha Chrisanthus <anitha.chrisanthus@intel.com>
diff --git a/Documentation/devicetree/bindings/display/intel,keembay-display.yaml b/Documentation/devicetree/bindings/display/intel,keembay-display.yaml
index bc6622b010ca..2cf54ecc707a 100644
--- a/Documentation/devicetree/bindings/display/intel,keembay-display.yaml
+++ b/Documentation/devicetree/bindings/display/intel,keembay-display.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/display/intel,keembay-display.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Devicetree bindings for Intel Keem Bay display controller
+title: Intel Keem Bay display controller
 
 maintainers:
   - Anitha Chrisanthus <anitha.chrisanthus@intel.com>
diff --git a/Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml b/Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml
index a222b52d8b8f..cc7e1f318fe4 100644
--- a/Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml
+++ b/Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/display/intel,keembay-msscam.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Devicetree bindings for Intel Keem Bay MSSCAM
+title: Intel Keem Bay MSSCAM
 
 maintainers:
   - Anitha Chrisanthus <anitha.chrisanthus@intel.com>
diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 67fdeeabae0c..ab14e81cb050 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -6,7 +6,7 @@
 $id: "http://devicetree.org/schemas/display/msm/gmu.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Devicetree bindings for the GMU attached to certain Adreno GPUs
+title: GMU attached to certain Adreno GPUs
 
 maintainers:
   - Rob Clark <robdclark@gmail.com>
diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index ec4b1a75f46a..c5f49842dc7b 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -5,7 +5,7 @@
 $id: "http://devicetree.org/schemas/display/msm/gpu.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Devicetree bindings for the Adreno or Snapdragon GPUs
+title: Adreno or Snapdragon GPUs
 
 maintainers:
   - Rob Clark <robdclark@gmail.com>
diff --git a/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
index 2329d9610f83..9f97598efdfa 100644
--- a/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
+++ b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/display/panel/olimex,lcd-olinuxino.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for Olimex Ltd. LCD-OLinuXino bridge panel.
+title: Olimex Ltd. LCD-OLinuXino bridge panel.
 
 maintainers:
   - Stefan Mavrodiev <stefan@olimex.com>
diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml
index 3cf862976448..ed9554c837ef 100644
--- a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml
+++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml
@@ -4,7 +4,7 @@
 $id: "http://devicetree.org/schemas/gpu/host1x/nvidia,tegra210-nvdec.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Device tree binding for NVIDIA Tegra NVDEC
+title: NVIDIA Tegra NVDEC
 
 description: |
   NVDEC is the hardware video decoder present on NVIDIA Tegra210
diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvenc.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvenc.yaml
index e63ae1a00818..8199e5fa8211 100644
--- a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvenc.yaml
+++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvenc.yaml
@@ -4,7 +4,7 @@
 $id: "http://devicetree.org/schemas/gpu/host1x/nvidia,tegra210-nvenc.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Device tree binding for NVIDIA Tegra NVENC
+title: NVIDIA Tegra NVENC
 
 description: |
   NVENC is the hardware video encoder present on NVIDIA Tegra210
diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvjpg.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvjpg.yaml
index 8647404d67e4..895fb346ac72 100644
--- a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvjpg.yaml
+++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvjpg.yaml
@@ -4,7 +4,7 @@
 $id: "http://devicetree.org/schemas/gpu/host1x/nvidia,tegra210-nvjpg.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Device tree binding for NVIDIA Tegra NVJPG
+title: NVIDIA Tegra NVJPG
 
 description: |
   NVJPG is the hardware JPEG decoder and encoder present on NVIDIA Tegra210
diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
index 7cc2dd525a96..4bdc19a2bccf 100644
--- a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
+++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
@@ -4,7 +4,7 @@
 $id: "http://devicetree.org/schemas/gpu/host1x/nvidia,tegra234-nvdec.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Device tree binding for NVIDIA Tegra234 NVDEC
+title: NVIDIA Tegra234 NVDEC
 
 description: |
   NVDEC is the hardware video decoder present on NVIDIA Tegra210
diff --git a/Documentation/devicetree/bindings/i2c/i2c-gpio.yaml b/Documentation/devicetree/bindings/i2c/i2c-gpio.yaml
index fd040284561f..e0d76d5eb103 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-gpio.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-gpio.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/i2c/i2c-gpio.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bindings for GPIO bitbanged I2C
+title: GPIO bitbanged I2C
 
 maintainers:
   - Wolfram Sang <wsa@kernel.org>
diff --git a/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml b/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
index db0843be91c5..781108ae1ce3 100644
--- a/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/i2c/ti,omap4-i2c.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bindings for I2C controllers on TI's OMAP and K3 SoCs
+title: I2C controllers on TI's OMAP and K3 SoCs
 
 maintainers:
   - Vignesh Raghavendra <vigneshr@ti.com>
diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
index 2287697f1f61..cab0d425eaa4 100644
--- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/adc/sigma-delta-modulator.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Device-Tree bindings for sigma delta modulator
+title: Sigma delta modulator
 
 maintainers:
   - Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
index 17ac9dff7972..159cd9d9fe57 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
+++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/input/gpio-keys.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Device-Tree bindings for GPIO attached keys
+title: GPIO attached keys
 
 maintainers:
   - Rob Herring <robh@kernel.org>
diff --git a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
index 96358b12f9b2..67d4d8f86a2d 100644
--- a/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
+++ b/Documentation/devicetree/bindings/input/microchip,cap11xx.yaml
@@ -4,7 +4,7 @@
 $id: "http://devicetree.org/schemas/input/microchip,cap11xx.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Device tree bindings for Microchip CAP11xx based capacitive touch sensors
+title: Microchip CAP11xx based capacitive touch sensors
 
 description: |
   The Microchip CAP1xxx Family of RightTouchTM multiple-channel capacitive
diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
index 62fd47c88275..95033cb514fb 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/interrupt-controller/renesas,irqc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: DT bindings for the R-Mobile/R-Car/RZ/G interrupt controller
+title: R-Mobile/R-Car/RZ/G interrupt controller
 
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
diff --git a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
index 4c15693f7a01..9acdb7895514 100644
--- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
+++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/leds/backlight/qcom-wled.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for Qualcomm Technologies, Inc. WLED driver
+title: Qualcomm Technologies, Inc. WLED driver
 
 maintainers:
   - Bjorn Andersson <bjorn.andersson@linaro.org>
diff --git a/Documentation/devicetree/bindings/leds/register-bit-led.yaml b/Documentation/devicetree/bindings/leds/register-bit-led.yaml
index 79b8fc0f9d23..ed26ec19ecbd 100644
--- a/Documentation/devicetree/bindings/leds/register-bit-led.yaml
+++ b/Documentation/devicetree/bindings/leds/register-bit-led.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/leds/register-bit-led.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Device Tree Bindings for Register Bit LEDs
+title: Register Bit LEDs
 
 maintainers:
   - Linus Walleij <linus.walleij@linaro.org>
diff --git a/Documentation/devicetree/bindings/leds/regulator-led.yaml b/Documentation/devicetree/bindings/leds/regulator-led.yaml
index 3e020d700c00..4ef7b96e9a08 100644
--- a/Documentation/devicetree/bindings/leds/regulator-led.yaml
+++ b/Documentation/devicetree/bindings/leds/regulator-led.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/leds/regulator-led.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Device Tree Bindings for Regulator LEDs
+title: Regulator LEDs
 
 maintainers:
   - Linus Walleij <linus.walleij@linaro.org>
diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
index 83be9e93d221..4053de758db6 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
@@ -4,7 +4,7 @@
 $id: "http://devicetree.org/schemas/mmc/arasan,sdhci.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Device Tree Bindings for the Arasan SDHCI Controller
+title: Arasan SDHCI Controller
 
 maintainers:
   - Adrian Hunter <adrian.hunter@intel.com>
diff --git a/Documentation/devicetree/bindings/net/ingenic,mac.yaml b/Documentation/devicetree/bindings/net/ingenic,mac.yaml
index 93b3e991d209..bdea101c2f75 100644
--- a/Documentation/devicetree/bindings/net/ingenic,mac.yaml
+++ b/Documentation/devicetree/bindings/net/ingenic,mac.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/net/ingenic,mac.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bindings for MAC in Ingenic SoCs
+title: MAC in Ingenic SoCs
 
 maintainers:
   - 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
diff --git a/Documentation/devicetree/bindings/power/supply/bq2415x.yaml b/Documentation/devicetree/bindings/power/supply/bq2415x.yaml
index a3c00e078918..f7287ffd4b12 100644
--- a/Documentation/devicetree/bindings/power/supply/bq2415x.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq2415x.yaml
@@ -5,7 +5,7 @@
 $id: http://devicetree.org/schemas/power/supply/bq2415x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for TI bq2415x Li-Ion Charger
+title: TI bq2415x Li-Ion Charger
 
 maintainers:
   - Sebastian Reichel <sre@kernel.org>
diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
index 4884ec90e2b8..001c0ffb408d 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
@@ -5,7 +5,7 @@
 $id: http://devicetree.org/schemas/power/supply/bq24190.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for TI BQ2419x Li-Ion Battery Charger
+title: TI BQ2419x Li-Ion Battery Charger
 
 maintainers:
   - Sebastian Reichel <sre@kernel.org>
diff --git a/Documentation/devicetree/bindings/power/supply/bq24257.yaml b/Documentation/devicetree/bindings/power/supply/bq24257.yaml
index c7406bef0fa8..cc45939d385b 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24257.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24257.yaml
@@ -5,7 +5,7 @@
 $id: http://devicetree.org/schemas/power/supply/bq24257.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for bq24250, bq24251 and bq24257 Li-Ion Charger
+title: Bq24250, bq24251 and bq24257 Li-Ion Charger
 
 maintainers:
   - Sebastian Reichel <sre@kernel.org>
diff --git a/Documentation/devicetree/bindings/power/supply/bq24735.yaml b/Documentation/devicetree/bindings/power/supply/bq24735.yaml
index dd9176ce71b3..388ee16f8a1e 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24735.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24735.yaml
@@ -5,7 +5,7 @@
 $id: http://devicetree.org/schemas/power/supply/bq24735.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for TI BQ24735 Li-Ion Battery Charger
+title: TI BQ24735 Li-Ion Battery Charger
 
 maintainers:
   - Sebastian Reichel <sre@kernel.org>
diff --git a/Documentation/devicetree/bindings/power/supply/bq25890.yaml b/Documentation/devicetree/bindings/power/supply/bq25890.yaml
index 204c0147188f..6273b1c5412b 100644
--- a/Documentation/devicetree/bindings/power/supply/bq25890.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq25890.yaml
@@ -5,7 +5,7 @@
 $id: http://devicetree.org/schemas/power/supply/bq25890.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for bq25890, bq25892, bq25895 and bq25896 Li-Ion Charger
+title: Bq25890, bq25892, bq25895 and bq25896 Li-Ion Charger
 
 maintainers:
   - Sebastian Reichel <sre@kernel.org>
diff --git a/Documentation/devicetree/bindings/power/supply/isp1704.yaml b/Documentation/devicetree/bindings/power/supply/isp1704.yaml
index 7e3449ed70d4..fb3a812aa5a9 100644
--- a/Documentation/devicetree/bindings/power/supply/isp1704.yaml
+++ b/Documentation/devicetree/bindings/power/supply/isp1704.yaml
@@ -5,7 +5,7 @@
 $id: http://devicetree.org/schemas/power/supply/isp1704.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for NXP ISP1704 USB Charger Detection
+title: NXP ISP1704 USB Charger Detection
 
 maintainers:
   - Sebastian Reichel <sre@kernel.org>
diff --git a/Documentation/devicetree/bindings/power/supply/lltc,ltc294x.yaml b/Documentation/devicetree/bindings/power/supply/lltc,ltc294x.yaml
index 109b41a0d56c..774582cd3a2c 100644
--- a/Documentation/devicetree/bindings/power/supply/lltc,ltc294x.yaml
+++ b/Documentation/devicetree/bindings/power/supply/lltc,ltc294x.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/power/supply/lltc,ltc294x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for LTC2941, LTC2942, LTC2943 and LTC2944 battery fuel gauges
+title: LTC2941, LTC2942, LTC2943 and LTC2944 battery fuel gauges
 
 description: |
   All chips measure battery capacity.
diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml
index bce15101318e..27bebc1757ba 100644
--- a/Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml
+++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/power/supply/richtek,rt9455.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for Richtek rt9455 battery charger
+title: Richtek rt9455 battery charger
 
 maintainers:
   - Sebastian Reichel <sre@kernel.org>
diff --git a/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml b/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml
index 93654e732cda..ce6fbdba8f6b 100644
--- a/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml
+++ b/Documentation/devicetree/bindings/power/supply/ti,lp8727.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/power/supply/ti,lp8727.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for TI/National Semiconductor LP8727 Charger
+title: TI/National Semiconductor LP8727 Charger
 
 maintainers:
   - Sebastian Reichel <sre@kernel.org>
diff --git a/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml b/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
index 82b6f2fde422..7e58471097f8 100644
--- a/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/pwm-regulator.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/regulator/pwm-regulator.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bindings for the Generic PWM Regulator
+title: Generic PWM Regulator
 
 maintainers:
   - Brian Norris <briannorris@chromium.org>
diff --git a/Documentation/devicetree/bindings/rng/ingenic,rng.yaml b/Documentation/devicetree/bindings/rng/ingenic,rng.yaml
index b2e4a6a7f93a..79a023cbfdba 100644
--- a/Documentation/devicetree/bindings/rng/ingenic,rng.yaml
+++ b/Documentation/devicetree/bindings/rng/ingenic,rng.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/rng/ingenic,rng.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bindings for RNG in Ingenic SoCs
+title: RNG in Ingenic SoCs
 
 maintainers:
   - 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
diff --git a/Documentation/devicetree/bindings/rng/ingenic,trng.yaml b/Documentation/devicetree/bindings/rng/ingenic,trng.yaml
index 044d9a065650..acaeb63caf24 100644
--- a/Documentation/devicetree/bindings/rng/ingenic,trng.yaml
+++ b/Documentation/devicetree/bindings/rng/ingenic,trng.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/rng/ingenic,trng.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bindings for DTRNG in Ingenic SoCs
+title: DTRNG in Ingenic SoCs
 
 maintainers:
   - 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
diff --git a/Documentation/devicetree/bindings/serial/8250_omap.yaml b/Documentation/devicetree/bindings/serial/8250_omap.yaml
index 7b34ec8fa90e..53dc1212ad2e 100644
--- a/Documentation/devicetree/bindings/serial/8250_omap.yaml
+++ b/Documentation/devicetree/bindings/serial/8250_omap.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/serial/8250_omap.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bindings for 8250 compliant UARTs on TI's OMAP2+ and K3 SoCs
+title: 8250 compliant UARTs on TI's OMAP2+ and K3 SoCs
 
 maintainers:
   - Vignesh Raghavendra <vigneshr@ti.com>
diff --git a/Documentation/devicetree/bindings/serio/ps2-gpio.yaml b/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
index a63d9172346f..99848bc34f6e 100644
--- a/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
+++ b/Documentation/devicetree/bindings/serio/ps2-gpio.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/serio/ps2-gpio.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bindings for GPIO based PS/2
+title: GPIO based PS/2
 
 maintainers:
   - Danilo Krummrich <danilokrummrich@dk-develop.de>
diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
index 8ca19f2b0b3d..184e8ccbdd13 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/sound/qcom,wcd934x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bindings for Qualcomm WCD9340/WCD9341 Audio Codec
+title: Qualcomm WCD9340/WCD9341 Audio Codec
 
 maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
index 49a267b306f6..b430dd3e1841 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/sound/qcom,wcd938x-sdw.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bindings for Qualcomm SoundWire Slave devices on WCD9380/WCD9385
+title: Qualcomm SoundWire Slave devices on WCD9380/WCD9385
 
 maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
index 67d84463eaeb..018565793a3e 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/sound/qcom,wcd938x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bindings for Qualcomm WCD9380/WCD9385 Audio Codec
+title: Qualcomm WCD9380/WCD9385 Audio Codec
 
 maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
index ea44d03e58ca..d702b489320f 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/sound/qcom,wsa881x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bindings for Qualcomm WSA8810/WSA8815 Class-D Smart Speaker Amplifier
+title: Qualcomm WSA8810/WSA8815 Class-D Smart Speaker Amplifier
 
 maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
index 65b0e67f82a3..ba572a7f4f3c 100644
--- a/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/sound/qcom,wsa883x.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bindings for The Qualcomm WSA8830/WSA8832/WSA8835
+title: Qualcomm WSA8830/WSA8832/WSA8835
   smart speaker amplifier
 
 maintainers:
diff --git a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
index 98648bf9e151..bdc82d8bce0e 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
+++ b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/timer/ingenic,sysost.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bindings for SYSOST in Ingenic XBurst family SoCs
+title: SYSOST in Ingenic XBurst family SoCs
 
 maintainers:
   - 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
index fd6e7c81426e..f6cb19efd98b 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
@@ -4,7 +4,7 @@
 $id: "http://devicetree.org/schemas/usb/nvidia,tegra-xudc.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Device tree binding for NVIDIA Tegra XUSB device mode controller (XUDC)
+title: NVIDIA Tegra XUSB device mode controller (XUDC)
 
 description:
   The Tegra XUDC controller supports both USB 2.0 HighSpeed/FullSpeed and
diff --git a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
index 50f2b505bdeb..623d04a88a81 100644
--- a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
+++ b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/usb/realtek,rts5411.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for the Realtek RTS5411 USB 3.0 hub controller
+title: Realtek RTS5411 USB 3.0 hub controller
 
 maintainers:
   - Matthias Kaehlcke <mka@chromium.org>
diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
index eedde385d299..f81ba3e90297 100644
--- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -4,7 +4,7 @@
 $id: "http://devicetree.org/schemas/usb/ti,j721e-usb.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Bindings for the TI wrapper module for the Cadence USBSS-DRD controller
+title: TI wrapper module for the Cadence USBSS-DRD controller
 
 maintainers:
   - Roger Quadros <rogerq@kernel.org>
diff --git a/Documentation/devicetree/bindings/usb/ti,usb8041.yaml b/Documentation/devicetree/bindings/usb/ti,usb8041.yaml
index e04fbd8ab0b7..88ea6c952c66 100644
--- a/Documentation/devicetree/bindings/usb/ti,usb8041.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,usb8041.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/usb/ti,usb8041.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Binding for the TI USB8041 USB 3.0 hub controller
+title: TI USB8041 USB 3.0 hub controller
 
 maintainers:
   - Alexander Stein <alexander.stein@ew.tq-group.com>
-- 
2.34.1

