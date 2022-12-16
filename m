Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779C864EF5A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiLPQig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbiLPQi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:38:29 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8961FF9C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:38:24 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id h10so2693181ljk.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeRZHpL3z8Czuw7XUKncujiKAWhvvLpXU0Ou/Uo+dho=;
        b=NKHrGUvotqOH6QUno+HUrJbKbiZ4zTpQmCsGUKH445FrNYpSfmUzmydDaa/FDKzL1R
         68Dp5XdMW4iDkXCL0SlS7oWL0ZV1qhr+QnlipyqwD8iVam4lX0JPBr55LiZOi2/+dBYQ
         +ey6n13rnjWOPyYrmnBwDAdsglMsya3LqZv3wCX1nDb7TPYGKbQ1GnYjCvCFQSZF7hcw
         uXFRQigS4ru4zOE9Lwwv1ID7B50S8EO2OSM+klGqvb12vkN3mDA6RdvoR47qcqp2kfLn
         UIHpvoFJw5TrMLiwZ/OcsaNI70V62ZBNWkCR1CkTaKIdWXsSeqRSBTSl0rfvDuSpsRhK
         ZlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeRZHpL3z8Czuw7XUKncujiKAWhvvLpXU0Ou/Uo+dho=;
        b=X4RMASFtBzr50nt71pTvZn7P45uVZ5gkz4NeTz9rMZDCcigPOGpkqcgWfbO35TJyrO
         4uTZdUJbaOSWbqpkeqXUCiib3joxNJbVwJYEqBjKP21X6r4YUCWa8SJQBpvC51gcbTev
         aqUFGHTp6aFkOYVXlhtz91+L+7ls+a77mCloXvjinSNQMpnjlQcxFb+saeRBUVXAJkI5
         130gfzMf919QW1lKPCJluPizFF7OX6ArCfA33mzvoLqfWA9AuXwg+qEQPV3UDgpSayOv
         dXLIb3OLfZ3sK3T3CanA8ER8DumbIVdiDDVNWtJ+tVojh8XgSb5FvOYR5B7LF9YxsJQs
         2Zmw==
X-Gm-Message-State: ANoB5pkaEjsYGCvTtoRv7BXKZGw+MMHUcvkOEZOJDvlRY4h/WCKXrtbs
        esI5wHlOPZ9wPFIhrCq+93jqiA==
X-Google-Smtp-Source: AA0mqf4d9XGo3FcC2DGaowjgRTNCmV8zUuin9lUO4aJqNMYcXzXVJyko9jASjZJf2KNNfwjCxxLDUA==
X-Received: by 2002:a05:651c:178d:b0:26f:e87b:d3bd with SMTP id bn13-20020a05651c178d00b0026fe87bd3bdmr11099095ljb.39.1671208702861;
        Fri, 16 Dec 2022 08:38:22 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p10-20020a2eba0a000000b0026fc79fd67dsm193930lja.74.2022.12.16.08.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:38:22 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sebastian Reichel <sre@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v3 1/9] dt-bindings: drop redundant part of title of shared bindings
Date:   Fri, 16 Dec 2022 17:38:07 +0100
Message-Id: <20221216163815.522628-2-krzysztof.kozlowski@linaro.org>
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
it is a "binding", but instead just describe the hardware.  For shared
(re-usable) schemas, name them all as "common properties".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Guenter Roeck <linux@roeck-us.net> # watchdog
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # IIO
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # MMC
Acked-by: Stephen Boyd <sboyd@kernel.org> # clk
Acked-by: Vinod Koul <vkoul@kernel.org> # dma
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl> # media
Acked-by: Sebastian Reichel <sre@kernel.org> # power
Acked-by: Viresh Kumar <viresh.kumar@linaro.org> # opp
---
 Documentation/devicetree/bindings/clock/qcom,gcc.yaml           | 2 +-
 Documentation/devicetree/bindings/dma/dma-common.yaml           | 2 +-
 Documentation/devicetree/bindings/dma/dma-controller.yaml       | 2 +-
 Documentation/devicetree/bindings/dma/dma-router.yaml           | 2 +-
 Documentation/devicetree/bindings/iio/adc/adc.yaml              | 2 +-
 Documentation/devicetree/bindings/input/input.yaml              | 2 +-
 .../devicetree/bindings/media/video-interface-devices.yaml      | 2 +-
 Documentation/devicetree/bindings/media/video-interfaces.yaml   | 2 +-
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml       | 2 +-
 Documentation/devicetree/bindings/mtd/nand-chip.yaml            | 2 +-
 Documentation/devicetree/bindings/mtd/nand-controller.yaml      | 2 +-
 .../devicetree/bindings/net/bluetooth/bluetooth-controller.yaml | 2 +-
 Documentation/devicetree/bindings/net/can/can-controller.yaml   | 2 +-
 Documentation/devicetree/bindings/net/ethernet-controller.yaml  | 2 +-
 Documentation/devicetree/bindings/net/ethernet-phy.yaml         | 2 +-
 Documentation/devicetree/bindings/net/mdio.yaml                 | 2 +-
 Documentation/devicetree/bindings/opp/opp-v2-base.yaml          | 2 +-
 Documentation/devicetree/bindings/rtc/rtc.yaml                  | 2 +-
 .../devicetree/bindings/soundwire/soundwire-controller.yaml     | 2 +-
 Documentation/devicetree/bindings/spi/spi-controller.yaml       | 2 +-
 Documentation/devicetree/bindings/watchdog/watchdog.yaml        | 2 +-
 21 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
index 1ab416c83c8d..7129fbcf2b6c 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/qcom,gcc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm Global Clock & Reset Controller Common Bindings
+title: Qualcomm Global Clock & Reset Controller Common Properties
 
 maintainers:
   - Stephen Boyd <sboyd@kernel.org>
diff --git a/Documentation/devicetree/bindings/dma/dma-common.yaml b/Documentation/devicetree/bindings/dma/dma-common.yaml
index ad06d36af208..ea700f8ee6c6 100644
--- a/Documentation/devicetree/bindings/dma/dma-common.yaml
+++ b/Documentation/devicetree/bindings/dma/dma-common.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/dma/dma-common.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: DMA Engine Generic Binding
+title: DMA Engine Common Properties
 
 maintainers:
   - Vinod Koul <vkoul@kernel.org>
diff --git a/Documentation/devicetree/bindings/dma/dma-controller.yaml b/Documentation/devicetree/bindings/dma/dma-controller.yaml
index 6d3727267fa8..538ebadff652 100644
--- a/Documentation/devicetree/bindings/dma/dma-controller.yaml
+++ b/Documentation/devicetree/bindings/dma/dma-controller.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/dma/dma-controller.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: DMA Controller Generic Binding
+title: DMA Controller Common Properties
 
 maintainers:
   - Vinod Koul <vkoul@kernel.org>
diff --git a/Documentation/devicetree/bindings/dma/dma-router.yaml b/Documentation/devicetree/bindings/dma/dma-router.yaml
index 4b817f5dc30e..f8d8c3c88bcc 100644
--- a/Documentation/devicetree/bindings/dma/dma-router.yaml
+++ b/Documentation/devicetree/bindings/dma/dma-router.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/dma/dma-router.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: DMA Router Generic Binding
+title: DMA Router Common Properties
 
 maintainers:
   - Vinod Koul <vkoul@kernel.org>
diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index db348fcbb52c..261601729745 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/adc/adc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Generic IIO bindings for ADC channels
+title: IIO Common Properties for ADC Channels
 
 maintainers:
   - Jonathan Cameron <jic23@kernel.org>
diff --git a/Documentation/devicetree/bindings/input/input.yaml b/Documentation/devicetree/bindings/input/input.yaml
index 17512f4347fd..94f7942189e8 100644
--- a/Documentation/devicetree/bindings/input/input.yaml
+++ b/Documentation/devicetree/bindings/input/input.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/input/input.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Common input schema binding
+title: Input Devices Common Properties
 
 maintainers:
   - Dmitry Torokhov <dmitry.torokhov@gmail.com>
diff --git a/Documentation/devicetree/bindings/media/video-interface-devices.yaml b/Documentation/devicetree/bindings/media/video-interface-devices.yaml
index 4527f56a5a6e..cf7712ad297c 100644
--- a/Documentation/devicetree/bindings/media/video-interface-devices.yaml
+++ b/Documentation/devicetree/bindings/media/video-interface-devices.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/media/video-interface-devices.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Common bindings for video receiver and transmitter devices
+title: Common Properties for Video Receiver and Transmitter Devices
 
 maintainers:
   - Jacopo Mondi <jacopo@jmondi.org>
diff --git a/Documentation/devicetree/bindings/media/video-interfaces.yaml b/Documentation/devicetree/bindings/media/video-interfaces.yaml
index 34bdad028180..a211d49dc2ac 100644
--- a/Documentation/devicetree/bindings/media/video-interfaces.yaml
+++ b/Documentation/devicetree/bindings/media/video-interfaces.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/media/video-interfaces.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Common bindings for video receiver and transmitter interface endpoints
+title: Common Properties for Video Receiver and Transmitter Interface Endpoints
 
 maintainers:
   - Sakari Ailus <sakari.ailus@linux.intel.com>
diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index e82c00368088..86c73fd825fd 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mmc/mmc-controller.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: MMC Controller Generic Binding
+title: MMC Controller Common Properties
 
 maintainers:
   - Ulf Hansson <ulf.hansson@linaro.org>
diff --git a/Documentation/devicetree/bindings/mtd/nand-chip.yaml b/Documentation/devicetree/bindings/mtd/nand-chip.yaml
index 6e2dc025d694..33d079f76c05 100644
--- a/Documentation/devicetree/bindings/mtd/nand-chip.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-chip.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mtd/nand-chip.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: NAND Chip and NAND Controller Generic Binding
+title: NAND Chip Common Properties
 
 maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
index 220aa2c8c0b5..efcd415f8641 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: NAND Chip and NAND Controller Generic Binding
+title: NAND Controller Common Properties
 
 maintainers:
   - Miquel Raynal <miquel.raynal@bootlin.com>
diff --git a/Documentation/devicetree/bindings/net/bluetooth/bluetooth-controller.yaml b/Documentation/devicetree/bindings/net/bluetooth/bluetooth-controller.yaml
index 9309dc40f54f..59bb0d7e8ab3 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/bluetooth-controller.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/bluetooth-controller.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/net/bluetooth/bluetooth-controller.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Bluetooth Controller Generic Binding
+title: Bluetooth Controller Common Properties
 
 maintainers:
   - Marcel Holtmann <marcel@holtmann.org>
diff --git a/Documentation/devicetree/bindings/net/can/can-controller.yaml b/Documentation/devicetree/bindings/net/can/can-controller.yaml
index 1f0e98051074..217be90960e8 100644
--- a/Documentation/devicetree/bindings/net/can/can-controller.yaml
+++ b/Documentation/devicetree/bindings/net/can/can-controller.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/net/can/can-controller.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: CAN Controller Generic Binding
+title: CAN Controller Common Properties
 
 maintainers:
   - Marc Kleine-Budde <mkl@pengutronix.de>
diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 3aef506fa158..00be387984ac 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/net/ethernet-controller.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Ethernet Controller Generic Binding
+title: Ethernet Controller Common Properties
 
 maintainers:
   - David S. Miller <davem@davemloft.net>
diff --git a/Documentation/devicetree/bindings/net/ethernet-phy.yaml b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
index ad808e9ce5b9..1327b81f15a2 100644
--- a/Documentation/devicetree/bindings/net/ethernet-phy.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-phy.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/net/ethernet-phy.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Ethernet PHY Generic Binding
+title: Ethernet PHY Common Properties
 
 maintainers:
   - Andrew Lunn <andrew@lunn.ch>
diff --git a/Documentation/devicetree/bindings/net/mdio.yaml b/Documentation/devicetree/bindings/net/mdio.yaml
index b5706d4e7e38..a266ade918ca 100644
--- a/Documentation/devicetree/bindings/net/mdio.yaml
+++ b/Documentation/devicetree/bindings/net/mdio.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/net/mdio.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: MDIO Bus Generic Binding
+title: MDIO Bus Common Properties
 
 maintainers:
   - Andrew Lunn <andrew@lunn.ch>
diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
index cf9c2f7bddc2..47e6f36b7637 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/opp/opp-v2-base.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Generic OPP (Operating Performance Points) Common Binding
+title: Generic OPP (Operating Performance Points) Common Properties
 
 maintainers:
   - Viresh Kumar <viresh.kumar@linaro.org>
diff --git a/Documentation/devicetree/bindings/rtc/rtc.yaml b/Documentation/devicetree/bindings/rtc/rtc.yaml
index 0ec3551f12dd..c6fff5486fe6 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/rtc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/rtc/rtc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: RTC Generic Binding
+title: Real Time Clock Common Properties
 
 maintainers:
   - Alexandre Belloni <alexandre.belloni@bootlin.com>
diff --git a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
index 4aad121eff3f..fdeb8af417d7 100644
--- a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
+++ b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/soundwire/soundwire-controller.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: SoundWire Controller Generic Binding
+title: SoundWire Controller Common Properties
 
 maintainers:
   - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 01042a7f382e..5a7c72cadf76 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/spi/spi-controller.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: SPI Controller Generic Binding
+title: SPI Controller Common Properties
 
 maintainers:
   - Mark Brown <broonie@kernel.org>
diff --git a/Documentation/devicetree/bindings/watchdog/watchdog.yaml b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
index e3dfb02f0ca5..fccae0d00110 100644
--- a/Documentation/devicetree/bindings/watchdog/watchdog.yaml
+++ b/Documentation/devicetree/bindings/watchdog/watchdog.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/watchdog/watchdog.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Watchdog Generic Bindings
+title: Watchdog Common Properties
 
 maintainers:
   - Guenter Roeck <linux@roeck-us.net>
-- 
2.34.1

