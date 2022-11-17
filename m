Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8D862D567
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbiKQIr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239338AbiKQIry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:47:54 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA662DCC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:47:54 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x102so1607328ede.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kplxU2lR5aG0mBiBv43tp2KK14DvgQ3747TCEeV3JMg=;
        b=JJZviyNTe3aoLaHC8gnS2B6ZcTQTNzqCo1CNL5fhLhh/Q21pISItv3OuImIZPearuW
         bcPv8/v3zDuo0hQF1Lxl2dF61VnCzkP4spsZMx9z8F5hpwlR6u9zM/SndG3dLHBBLnY0
         k6htMUas9GgLlqwNVv8haDJ1k1sKtjozX77I+aljOtKJKGPtB+BuHZSWCo+mN29Ll9Qi
         CRzV4Z8IPLuKuq3E4NgPh9PssxWg2C/4fGnvj7vEgj1k5ujzzy4ewWa9SM19CUNImdn/
         LvG4iiIh9BzZTOLPVDG0udI2RexERIauevvSdRle0EGIrUaKj+OeJ5HOXjqL5Qsc/vat
         CR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kplxU2lR5aG0mBiBv43tp2KK14DvgQ3747TCEeV3JMg=;
        b=pe+k9ki4/If9vNG5ITsm7BMRRsHk8aWfnPFIwh2rn2mYGNGgPlf8gbzqs1vuWwa86N
         zWtXK+ntuotBp2GLH06SSSKPIz7AkLjS9iMHX4CVQWWmzpy8Kml3658U8s4c7enI17eF
         9hiNBJnR7S2K88VS2831f/i9W0ETlb6b+1xih+Rz7P2WyzMpCXCzrag8ASyBX/p7SRgG
         H1UE6kygdoFaD+PxuMXxK7LXVL6GpwTJh3zt9jGhC1ae7uRYcEfI1mCeIyF4vPSWdgd5
         jmLSrx36HdglpCDysaY8VwR2heFa2uxE6RPVmG0XR7yczEHjerD+hurtBPZhO94LioIN
         trKA==
X-Gm-Message-State: ANoB5pmUINXTCCuwuX/mVYTm7YyOvo16du/qmrmfnfYnvwZ/38keLM+a
        lU47ojRbfexj2Yl+hVG/fgTiXQ==
X-Google-Smtp-Source: AA0mqf6g15i8zsDuyqA55ZoKaief9KDXNvdMbq3LIDvKdQEDkFEbkFvIVViVnfvYrya19LRO4KeNXQ==
X-Received: by 2002:a05:6402:4d6:b0:458:789b:c1b0 with SMTP id n22-20020a05640204d600b00458789bc1b0mr1277535edw.89.1668674872601;
        Thu, 17 Nov 2022 00:47:52 -0800 (PST)
Received: from [127.0.1.1] ([2a0e:41a:894f:0:7a60:27eb:954c:5ab1])
        by smtp.gmail.com with ESMTPSA id s22-20020a1709067b9600b0077205dd15basm77332ejo.66.2022.11.17.00.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 00:47:52 -0800 (PST)
From:   Carlo Caione <ccaione@baylibre.com>
Date:   Thu, 17 Nov 2022 09:47:39 +0100
Subject: [PATCH 1/3] drm/tiny: rpi-lcd-35: Enable driver module autoloading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221116-s905x_spi_ili9486-v1-1-630401cb62d5@baylibre.com>
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

SPI devices use the spi_device_id for module autoloading even on
systems using device tree.

Add the spi_device_id entry to enable autoloading for the 3.5inch RPi
Display (rpi-lcd-35).

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/gpu/drm/tiny/ili9486.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
index 1bb847466b10..bd37dfe8dd05 100644
--- a/drivers/gpu/drm/tiny/ili9486.c
+++ b/drivers/gpu/drm/tiny/ili9486.c
@@ -183,6 +183,7 @@ MODULE_DEVICE_TABLE(of, ili9486_of_match);
 
 static const struct spi_device_id ili9486_id[] = {
 	{ "ili9486", 0 },
+	{ "rpi-lcd-35", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ili9486_id);

-- 
b4 0.10.1
