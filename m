Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CF962D56C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbiKQIsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239556AbiKQIr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:47:57 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF1F140C9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:47:55 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 21so1548882edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idox2DWf9CfxY6np+xVajajSNgisazAtYo+m3/oXIzQ=;
        b=YJtoDwNevsDYE56TfvpY13pJKKdr1ptUtkThXpzJvzyqFNfQ0lQAYsHeD/G6ijoQb9
         FzNX3VDp0JST+f3q3q97kt/nU09VpZOu7LMruQ2aOWiPdjy515rP0ho3XAzk1xer9fUN
         oo8Xij8p06FD8ZWJk/LZaY9rS8uvkmH0Z1QGAUQbauZoRhXRKl8mkUxO/VfQ94d/bxDO
         0PA707ZmvAL0b7U1IDRpV2graHjHktcAA/oqFa82GZMPJbLgLQQ8+eIAE7kVfLldaMqZ
         ih7RbpltfyVp99rBOpxzOCYnMi64Up3c/VX8yVq0MmjyQIqG90pWGWBylHcJm+0gLN/P
         +P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idox2DWf9CfxY6np+xVajajSNgisazAtYo+m3/oXIzQ=;
        b=a3fXgH0qNsGPMXqJp/M89tqtJRSp46aWvzjjKnLLVfRgKSGyPXreeaQZF7s+3PT9u1
         l9nqeITPdLZXpzTTooLSMnBRssJ7pVxJOFXWcINoF9S8j0YyaEWX9YNgwRU8ciSWgW+3
         WJ6n0tJJEfuPQVwC2KHAoAGVbZJlRNhzbZn7zcwF+mamSc2Z25tct62+w4xbwdzeAauq
         rVdhDNaDYdUW+dyrVYHj1p3Ylmsx2IGn0KcYU422v+Eg6ZRMUCldpmhhZzB+mhCyLF60
         H2kB1mf49q2hvpFWbixLYHoNBS6IHX56naAdAB2XvLHNTjoXt/+yxW7vWAUGkXKKhCke
         HS2g==
X-Gm-Message-State: ANoB5pnvpVUoS6ESA/K3yaUHwSrPNhqz1BYS/GzrNLgopYSTsm1H5LII
        bDKUgwk/dtD9jRwFmQoYDIY77g==
X-Google-Smtp-Source: AA0mqf4yWjrqIlKEjUvVEQZBYNp9Cyg1fui9YTk3qSoXBiIO38liYCs7aLKXOQNddd4uvH2WBxvUEA==
X-Received: by 2002:a05:6402:3707:b0:467:6847:83d3 with SMTP id ek7-20020a056402370700b00467684783d3mr1257987edb.247.1668674874355;
        Thu, 17 Nov 2022 00:47:54 -0800 (PST)
Received: from [127.0.1.1] ([2a0e:41a:894f:0:7a60:27eb:954c:5ab1])
        by smtp.gmail.com with ESMTPSA id s22-20020a1709067b9600b0077205dd15basm77332ejo.66.2022.11.17.00.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 00:47:54 -0800 (PST)
From:   Carlo Caione <ccaione@baylibre.com>
Date:   Thu, 17 Nov 2022 09:47:41 +0100
Subject: [PATCH 3/3] spi: meson-spicc: Lower CS between bursts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221116-s905x_spi_ili9486-v1-3-630401cb62d5@baylibre.com>
References: <20221116-s905x_spi_ili9486-v1-0-630401cb62d5@baylibre.com>
In-Reply-To: <20221116-s905x_spi_ili9486-v1-0-630401cb62d5@baylibre.com>
To:     Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        David Airlie <airlied@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some hardware (reproduced on S905X) when a large payload is
transmitted over SPI in bursts at the end of each burst, the clock line
briefly fluctuates creating spurious clock transitions that are being
recognised by the connected device as a genuine pulses, creating an
offset in the data being transmitted.

Lower the GPIO CS between bursts to avoid the clock being interpreted as
valid.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/spi/spi-meson-spicc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index d47f2623a60f..af8d74b53519 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -291,6 +291,10 @@ static inline void meson_spicc_setup_burst(struct meson_spicc_device *spicc)
 static irqreturn_t meson_spicc_irq(int irq, void *data)
 {
 	struct meson_spicc_device *spicc = (void *) data;
+	struct spi_device *spi_dev;
+
+	spi_dev = spicc->message->spi;
+	gpiod_set_value(spi_dev->cs_gpiod, 0);
 
 	writel_bits_relaxed(SPICC_TC, SPICC_TC, spicc->base + SPICC_STATREG);
 
@@ -309,6 +313,8 @@ static irqreturn_t meson_spicc_irq(int irq, void *data)
 	/* Setup burst */
 	meson_spicc_setup_burst(spicc);
 
+	gpiod_set_value(spi_dev->cs_gpiod, 1);
+
 	/* Start burst */
 	writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + SPICC_CONREG);
 

-- 
b4 0.10.1
