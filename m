Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776D062D56A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbiKQIsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbiKQIr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:47:56 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45E9101F0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:47:54 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id a5so1501260edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90zm8/9EgVKMcm+GcVTwlECGEPSG+I41CMXM1RTutaE=;
        b=UnkavLeF63kWpP4dt3DH3oo2hhLFs7VsnslG4t92oUQapu5uMsW0U6XFO9MEi+swRX
         /ohsTvFbJwQ0scQ1IYNcwQ/z036JyCSL0TqusFH7ceidILUrvk9jSNNs0P9hFMLeNW+V
         FGnwjC0/0OhODR4CMHeGQJEp+HL0G5XlSqf8wbQ4bMqMUukKA+CgfLE/W1wbO98Xf7iN
         k06oxVsEINbbzZzifkn9cqEmMGs7wwacRRZd+8Ve+L2FKO7hiz1X87dxyTl4uoSBMU72
         YNLwzVDpkjjxtc3OOUB8AyHI7mAPRzIMpufnKutmnF3+8449KHQfp5KX81vW6GMUPufg
         IU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90zm8/9EgVKMcm+GcVTwlECGEPSG+I41CMXM1RTutaE=;
        b=rBdN8QRBbWRxqa3XmvqVC9sUn8TU+6dsITy6/mpq3YnUO234PlcrmN/V/qx8+z8tPV
         JfXeRKR8f8HD0xrkfP/KGt0XGeqWwuzur4/DgLHC7xEd7OgXSTumkbQYWg3vfo8Qpqt+
         XK7AQ+9F3lvD8gxEwU1bOjKytUgDpexBn/b31KCqfp0+f2oR+8aiLAvRF830OgsFE5JT
         5I3YRUCQwnhGKMLlyvtjk9kZc+2RubjJHf+FhT6+QU8t667FZ96I17q6hLob8W2kHoWC
         6so6roc/TnHQHd8kPKFxdrMziGJFC7QYnhs8McAaN19tZWuJwhbuCMr0o7jzdEG51dZ7
         9HZw==
X-Gm-Message-State: ANoB5pnOr7wAL1JeRFAbJz9tUXGbi+Y1loycTArH+WQBlZQgUOJI1NcM
        fbjlwbGq0cfw/BjUrkSN6CUERg==
X-Google-Smtp-Source: AA0mqf62OFgXu+YnjTocaXwjywIf8zuYGwGTL2hEIk6+Tn1N0UikQX9Em/Xzv0xyvJ8QZXrsGxenHw==
X-Received: by 2002:aa7:d1c5:0:b0:461:dd11:c1bd with SMTP id g5-20020aa7d1c5000000b00461dd11c1bdmr1207044edp.406.1668674873463;
        Thu, 17 Nov 2022 00:47:53 -0800 (PST)
Received: from [127.0.1.1] ([2a0e:41a:894f:0:7a60:27eb:954c:5ab1])
        by smtp.gmail.com with ESMTPSA id s22-20020a1709067b9600b0077205dd15basm77332ejo.66.2022.11.17.00.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 00:47:53 -0800 (PST)
From:   Carlo Caione <ccaione@baylibre.com>
Date:   Thu, 17 Nov 2022 09:47:40 +0100
Subject: [PATCH 2/3] drm/tiny: ili9486: Do not assume 8-bit only SPI controllers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221116-s905x_spi_ili9486-v1-2-630401cb62d5@baylibre.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ILI9486 driver is wrongly assuming that the SPI panel is interfaced
only with 8-bit SPI controllers and consequently that the pixel data
passed by the MIPI DBI subsystem are already swapped before being sent
over SPI using 8 bits-per-word.

This is not always true for all the SPI controllers.

Make the command function more general to not only support 8-bit only
SPI controllers and support sending un-swapped data over SPI using 16
bits-per-word when dealing with pixel data.

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
