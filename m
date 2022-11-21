Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A24631D11
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKUJm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiKUJmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:42:47 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0110F655A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:42:43 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id f27so27241997eje.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hu5U86ige5HyMDl6UUjo7RBdCuH6co9yADRt72Y/8MY=;
        b=hA9fcWmto4ybP9K5GSKv+Pfqt4s/xOpxBEdTWZGxoXk6kt2zLckX/Yk82YP6m+DRQH
         sIF9hMmmAMqBUceUi3M1Z/0jgaKEQAGWC0QiBrGojCm9mqwLy8C3CThNtvEkPyHQJcjW
         4xKF6ACJiKqPomEiYRKmMCyDNJSNXrdq9bFaNJbmXHgXIeBGD5jZ5z4ORQ7jgp1Kw6VI
         /b19SKnEYkxN5X1LFi3izAJW23uJ9NO5iJuVGGA2PTfj9oAlSXXN9j4ewaG37Vjeic6s
         99UtizGD47CZl7b9UFTfW2JeHkMp208v3pRhlTmm6YlX3PeDAT60zsSPk5xRzaFPIcHj
         d3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hu5U86ige5HyMDl6UUjo7RBdCuH6co9yADRt72Y/8MY=;
        b=mya4LcMpzKuhy/ZlNqQ54mu8pUb3ZgVQU0HfSbbM1lMzt4vmdn1LJlOfJel+T+6Esp
         qJdNZRDURSpzALSt4USFFIC5aOf1QLVQMbfrdsC8Q8PyV7NZzdyv6IaDkca8b4nZXSYc
         hjMphesxsylcnDUa8T94/eyIkXWTOm2FAzAqm/RybU0E/mKtAgtiUoVC5SFf8lrOIGv8
         u0uGmD3tmlmv97rLCPMuFfH+a3xxLRV9NbkpL1aN8aN8m/r23Z2d0r4N3B0xB5GOYWIB
         HCQbaTRz7v6fDqXYMGJRD6uizIirPS7bc88Plth7iwwC8Dpd3ANbJ7+bCbL4iOQHH0lQ
         Tt9Q==
X-Gm-Message-State: ANoB5pkjQiAbR0mFPGkQOUSIw+/5Da9ZO1u+dphVoLMOkOeLqFAlx2OW
        EUCaSSRd5Ovd1oAHd+GnsEBmaA==
X-Google-Smtp-Source: AA0mqf7R80CBcgut7WKoqa2UyoJjTe+iSCNXbGx9E8tOfUa5mUdWN2uLlo6XvJ+69OMC/vUzYl5ZwQ==
X-Received: by 2002:a17:907:986b:b0:7ad:b7c2:a2f7 with SMTP id ko11-20020a170907986b00b007adb7c2a2f7mr14848367ejc.227.1669023761673;
        Mon, 21 Nov 2022 01:42:41 -0800 (PST)
Received: from [127.0.1.1] ([2a0e:41a:894f:0:c97f:bc5d:82d3:1a3b])
        by smtp.gmail.com with ESMTPSA id k11-20020a17090632cb00b0078d3f96d293sm4822240ejk.30.2022.11.21.01.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 01:42:41 -0800 (PST)
From:   Carlo Caione <ccaione@baylibre.com>
Date:   Mon, 21 Nov 2022 10:42:31 +0100
Subject: [PATCH v2 2/2] drm/tiny: ili9486: Do not assume 8-bit only SPI controllers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221116-s905x_spi_ili9486-v2-2-084c6e3cd930@baylibre.com>
References: <20221116-s905x_spi_ili9486-v2-0-084c6e3cd930@baylibre.com>
In-Reply-To: <20221116-s905x_spi_ili9486-v2-0-084c6e3cd930@baylibre.com>
To:     Mark Brown <broonie@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pixel data for the ILI9486 is always 16-bits wide and it must be
sent over the SPI bus. When the controller is only able to deal with
8-bit transfers, this 16-bits data needs to be swapped before the
sending to account for the big endian bus, this is on the contrary not
needed when the SPI controller already supports 16-bits transfers.

The decision about swapping the pixel data or not is taken in the MIPI
DBI code by probing the controller capabilities: if the controller only
suppors 8-bit transfers the data is swapped, otherwise it is not.

This swapping/non-swapping is relying on the assumption that when the
controller does support 16-bit transactions then the data is sent
unswapped in 16-bits-per-word over SPI.

The problem with the ILI9486 driver is that it is forcing 8-bit
transactions also for controllers supporting 16-bits, violating the
assumption and corrupting the pixel data.

Align the driver to what is done in the MIPI DBI code by adjusting the
tranfer size to the maximum allowed by the SPI controller.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/gpu/drm/tiny/ili9486.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
index bd37dfe8dd05..4d80a413338f 100644
--- a/drivers/gpu/drm/tiny/ili9486.c
+++ b/drivers/gpu/drm/tiny/ili9486.c
@@ -43,6 +43,7 @@ static int waveshare_command(struct mipi_dbi *mipi, u8 *cmd, u8 *par,
 			     size_t num)
 {
 	struct spi_device *spi = mipi->spi;
+	unsigned int bpw = 8;
 	void *data = par;
 	u32 speed_hz;
 	int i, ret;
@@ -56,8 +57,6 @@ static int waveshare_command(struct mipi_dbi *mipi, u8 *cmd, u8 *par,
 	 * The displays are Raspberry Pi HATs and connected to the 8-bit only
 	 * SPI controller, so 16-bit command and parameters need byte swapping
 	 * before being transferred as 8-bit on the big endian SPI bus.
-	 * Pixel data bytes have already been swapped before this function is
-	 * called.
 	 */
 	buf[0] = cpu_to_be16(*cmd);
 	gpiod_set_value_cansleep(mipi->dc, 0);
@@ -71,12 +70,18 @@ static int waveshare_command(struct mipi_dbi *mipi, u8 *cmd, u8 *par,
 		for (i = 0; i < num; i++)
 			buf[i] = cpu_to_be16(par[i]);
 		num *= 2;
-		speed_hz = mipi_dbi_spi_cmd_max_speed(spi, num);
 		data = buf;
 	}
 
+	/*
+	 * Check whether pixel data bytes needs to be swapped or not
+	 */
+	if (*cmd == MIPI_DCS_WRITE_MEMORY_START && !mipi->swap_bytes)
+		bpw = 16;
+
 	gpiod_set_value_cansleep(mipi->dc, 1);
-	ret = mipi_dbi_spi_transfer(spi, speed_hz, 8, data, num);
+	speed_hz = mipi_dbi_spi_cmd_max_speed(spi, num);
+	ret = mipi_dbi_spi_transfer(spi, speed_hz, bpw, data, num);
  free:
 	kfree(buf);
 

-- 
b4 0.10.1
