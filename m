Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583ED60491D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 16:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiJSOWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 10:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiJSOV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 10:21:27 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEA9138B9C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:05:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso65281wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZgwfLubP2W/1t0/FaJA376eh/Hnps387U4J2IjbH+Q=;
        b=u/rHqaVSXAtf44+agVTaE7rGMxdiAM9mO+71rH0zJ13C+ops+wfxsALrLi/qTcHLo2
         Ev9tB/jp7LpRZrpDHe+l83Ad3mBJ2dKF4iB6mppCyruY6ljkZZUK6lCRy7Ing4rcvvER
         Zj/PzLkyiUQv6AgvOqL2zNCF9C8AoGVdGkNgWTSsWTe00yYumXkM2MceEQazBiKqE3jl
         KjZzDc8RXzZ4mZcyAV2kNLiHjgklBvH5uBSWHKUc3IosI9qDvLSiwftNVI92bOBCdG/0
         8Urw1OrJdT28AjBHu9avIBYu4AkAcdhPIF4Udczs8XDQNxnna8i6A9pc6rQnj5gVoJ7J
         5JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZgwfLubP2W/1t0/FaJA376eh/Hnps387U4J2IjbH+Q=;
        b=IXZ9MjLJEKz+4ysZfHtpQoh48oCHoQ//IMj6ixQkj9J1Un1+Bks083z7IUdP/xtjs2
         U3XCW/41rQbDhHJp0FysbqWQn1srUQ2vASGfyuOxiDLsf4AJbD5jiAs4ZS/WRgo6T1EP
         awQcgQP1+lENIBOlkaxLqMc7vwxcWIdzTY4o5Z8jkrfVBdMhHcFIUDxSbZeTJzqZoM0S
         4u5ZfiIhfEtaqfwWS1shOqj4raxH+eJaj7ep7YtXAmTa4qZm1OOiMNgEILuiwD82D228
         PiTVQx5ogoizIr4i39B4kUCpAoyFW03ZSM4J/hkpwFYHQxois0xupwqvzcf0Uz/Qi7HW
         IkHw==
X-Gm-Message-State: ACrzQf3r3FFDYi4C5IcoenUnYLylb1rpQRRkw/L+x1m2yVCcQ6YUCYK8
        LE0r7iwk9WUzBXHl9O7p/1yWgw==
X-Google-Smtp-Source: AMsMyM4k2lIu5FtcD+oSZfD3YSgbmUclwlgXE3MZJDzEiIqjqYmYHAetaHQWtEDUAoC/OeKJuPuMjQ==
X-Received: by 2002:a05:600c:4e47:b0:3c6:fc59:5eff with SMTP id e7-20020a05600c4e4700b003c6fc595effmr6918684wmq.18.1666188199567;
        Wed, 19 Oct 2022 07:03:19 -0700 (PDT)
Received: from [127.0.1.1] (rtr.23.90.200.126.unyc.it. [23.90.200.126])
        by smtp.googlemail.com with ESMTPSA id o5-20020a5d62c5000000b00228cbac7a25sm13998628wrv.64.2022.10.19.07.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:03:19 -0700 (PDT)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Wed, 19 Oct 2022 16:01:04 +0200
Subject: [PATCH v3 2/2] spi: meson-spicc: Use pinctrl to drive CLK line when idle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221004-up-aml-fix-spi-v3-2-89de126fd163@baylibre.com>
References: <20221004-up-aml-fix-spi-v3-0-89de126fd163@baylibre.com>
In-Reply-To: <20221004-up-aml-fix-spi-v3-0-89de126fd163@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Da Xue <da@libre.computer>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1666188196; l=4316;
 i=aouledameur@baylibre.com; s=20220920; h=from:subject:message-id;
 bh=dN6XmPpYO7Ty0vQSXH4eMp49Nq2iRF2CEqKZcOspWpI=;
 b=vviwObwJxuPYh/ZZNDCsfx7v9An1mgI8ZqaQQkOEPhpUcxtNrkB4V7dyqhh3eHnJUsX9mrUCOAxn
 oyRtrThBCRUCQgrksHjC40en6/dPJsjPNI8IfERp46vdxVdELtM6
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
index bad201510a99..ffea38e2339c 100644
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
