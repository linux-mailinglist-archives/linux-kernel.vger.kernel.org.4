Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A218C5F41B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJDLL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiJDLLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:11:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F51656BA5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:11:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 130-20020a1c0288000000b003b494ffc00bso10091464wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 04:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UJJeF3sZho4I3jRzyDgsCpW+xzw8EC4+Woo4EIRjhI=;
        b=KHLlACe35Mt0YeI5e0xlhWAhl2sdUfS56qWu5smFZ4A68YYNa4E61YRaBQtFSrAEXY
         yyh6xYRXK4APj0XRiQJvvhee9i1zHNJDqEtVZpZfDBd8lz52N7J2vk1GUeOYgjeP/2dn
         wQuXDFJuH8zp9ujEVAB83+I1eTbBpsQYE/yB3U76hnYJdxYS6q+NCWRH76b6frzVzgQz
         +k9UFPJSsLjax5MtvJuMlqz/4RPhQ2gVWaiCqFM1WltK9j9J+Tj5YdJx4QB9w7cvtlmF
         1+k6bFa43fbpFS4vzjZWBHularItcdxR4osuQrkGJUV8ypb06XAX72nurvhEWZ8nHneq
         Rx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9UJJeF3sZho4I3jRzyDgsCpW+xzw8EC4+Woo4EIRjhI=;
        b=0DeHMwmqBw9izL5juySSK21KUJ0LU7cUNNqeLGW7YT39XzIsv7wBKenxliQdXdobbE
         WbYxSlaglAdQRfIOk7P4/QE9oxOuZSkFz3bwssYO5DzyB0ukGcxx7uEpOC4ainCRAc74
         zOmVyFnLdShPXLhCVG960flUtwNYDahnNFa73Ykf8f4NCR/2ptCK5Kwdnw/DUuvNqr2q
         WG9QoAn/JUAH0Yx1wZnkDcTURJkV9DImFLdn9W99FihDnYWNU5jDpuea5oM11JrGrxHK
         AlL6NSOwEFpXjUVXzgqgBYKY0xndnH3M0leBRKFn4urpSDQ/YN8qGYWZS+7k2WjyF7mi
         Jjlw==
X-Gm-Message-State: ACrzQf2Gk1ukOzVcn1Z0MJGwvJLPgwY6Qx0BbM0OtpUw4CVg4PCLBmUo
        8/MAVBJq+SOeIhCDrXntSFmJHQ==
X-Google-Smtp-Source: AMsMyM4lprZEpHTZymzZDyAyeL37GQbNRWZDIhkLoxsLstNxTH5VirriI4pGn0cdfLfduLDfEj2H3w==
X-Received: by 2002:a05:600c:1f06:b0:3b4:86e8:bd21 with SMTP id bd6-20020a05600c1f0600b003b486e8bd21mr10028543wmb.7.1664881890873;
        Tue, 04 Oct 2022 04:11:30 -0700 (PDT)
Received: from [127.0.1.1] (210.145.15.109.rev.sfr.net. [109.15.145.210])
        by smtp.googlemail.com with ESMTPSA id j2-20020adfd202000000b002285f73f11dsm15361698wrh.81.2022.10.04.04.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 04:11:30 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Tue, 04 Oct 2022 13:10:37 +0200
Subject: [PATCH v2 2/2] spi: meson-spicc: Use pinctrl to drive CLK line when idle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221004-up-aml-fix-spi-v2-2-3e8ae91a1925@baylibre.com>
References: <20221004-up-aml-fix-spi-v2-0-3e8ae91a1925@baylibre.com>
In-Reply-To: <20221004-up-aml-fix-spi-v2-0-3e8ae91a1925@baylibre.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Da Xue <da@libre.computer>, linux-kernel@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1664881888; l=4316;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=nQpkgGjqWbrM00eFiyFqQsdlJkaQwuIgVz9GJtl+aH8=;
 b=l2gvdzyi3u1EecI5XIadzmWGWdV37GSawLpg4eQliIlv74HpWJ8aYWZjLW4I8iU8mgyE0FCBBwH3
 7FR3jqPEDOVxf7WWD7pWTVmbV1IXXGNAk+3hjfEnoMJ/h/hKrZhS
X-Developer-Key: i=aouledameur@baylibre.com; a=ed25519;
 pk=HgYWawSL4qLGPx+RzJ+Cuu+V8Pi/KQnDDm1wjWPMOFE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Between SPI transactions, all SPI pins are in HiZ state. When using the SS
signal from the SPICC controller it's not an issue because when the
transaction resumes all pins come back to the right state at the same time
as SS.

The problem is when we use CS as a GPIO. In fact, between the GPIO CS
state change and SPI pins state change from idle, you can have a missing or
spurious clock transition.

Set a bias on the clock depending on the clock polarity requested before CS
goes active, by passing a special "idle-low" and "idle-high" pinctrl state
and setting the right state at a start of a message

Reported-by: Da Xue <da@libre.computer>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 14 +++++++++++
 drivers/spi/spi-meson-spicc.c              | 39 +++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index c3ac531c4f84..04e9d0f1bde0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -429,6 +429,20 @@ mux {
 			};
 		};
 
+		spi_idle_high_pins: spi-idle-high-pins {
+			mux {
+				groups = "spi_sclk";
+				bias-pull-up;
+			};
+		};
+
+		spi_idle_low_pins: spi-idle-low-pins {
+			mux {
+				groups = "spi_sclk";
+				bias-pull-down;
+			};
+		};
+
 		spi_ss0_pins: spi-ss0 {
 			mux {
 				groups = "spi_ss0";
diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index e4cb52e1fe26..de89577319ec 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/reset.h>
+#include <linux/pinctrl/consumer.h>
 
 /*
  * The Meson SPICC controller could support DMA based transfers, but is not
@@ -167,6 +168,9 @@ struct meson_spicc_device {
 	unsigned long			tx_remain;
 	unsigned long			rx_remain;
 	unsigned long			xfer_remain;
+	struct pinctrl			*pinctrl;
+	struct pinctrl_state		*pins_idle_high;
+	struct pinctrl_state		*pins_idle_low;
 };
 
 #define pow2_clk_to_spicc(_div) container_of(_div, struct meson_spicc_device, pow2_div)
@@ -175,8 +179,22 @@ static void meson_spicc_oen_enable(struct meson_spicc_device *spicc)
 {
 	u32 conf;
 
-	if (!spicc->data->has_oen)
+	if (!spicc->data->has_oen) {
+		/* Try to get pinctrl states for idle high/low */
+		spicc->pins_idle_high = pinctrl_lookup_state(spicc->pinctrl,
+							     "idle-high");
+		if (IS_ERR(spicc->pins_idle_high)) {
+			dev_warn(&spicc->pdev->dev, "can't get idle-high pinctrl\n");
+			spicc->pins_idle_high = NULL;
+		}
+		spicc->pins_idle_low = pinctrl_lookup_state(spicc->pinctrl,
+							     "idle-low");
+		if (IS_ERR(spicc->pins_idle_low)) {
+			dev_warn(&spicc->pdev->dev, "can't get idle-low pinctrl\n");
+			spicc->pins_idle_low = NULL;
+		}
 		return;
+	}
 
 	conf = readl_relaxed(spicc->base + SPICC_ENH_CTL0) |
 		SPICC_ENH_MOSI_OEN | SPICC_ENH_CLK_OEN | SPICC_ENH_CS_OEN;
@@ -441,6 +459,16 @@ static int meson_spicc_prepare_message(struct spi_master *master,
 	else
 		conf &= ~SPICC_POL;
 
+	if (!spicc->data->has_oen) {
+		if (spi->mode & SPI_CPOL) {
+			if (spicc->pins_idle_high)
+				pinctrl_select_state(spicc->pinctrl, spicc->pins_idle_high);
+		} else {
+			if (spicc->pins_idle_low)
+				pinctrl_select_state(spicc->pinctrl, spicc->pins_idle_low);
+		}
+	}
+
 	if (spi->mode & SPI_CPHA)
 		conf |= SPICC_PHA;
 	else
@@ -487,6 +515,9 @@ static int meson_spicc_unprepare_transfer(struct spi_master *master)
 	/* Set default configuration, keeping datarate field */
 	writel_relaxed(conf, spicc->base + SPICC_CONREG);
 
+	if (!spicc->data->has_oen)
+		pinctrl_select_default_state(&spicc->pdev->dev);
+
 	return 0;
 }
 
@@ -798,6 +829,12 @@ static int meson_spicc_probe(struct platform_device *pdev)
 		goto out_core_clk;
 	}
 
+	spicc->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (IS_ERR(spicc->pinctrl)) {
+		ret = PTR_ERR(spicc->pinctrl);
+		goto out_clk;
+	}
+
 	device_reset_optional(&pdev->dev);
 
 	master->num_chipselect = 4;

-- 
b4 0.10.1
