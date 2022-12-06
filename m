Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E93643EB5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiLFIeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiLFIeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:34:11 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CDFFE9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:34:10 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id x22so4351981ejs.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BPaUYtbAIV1BLKNgYdAozqHw0R4+q9lV2NZg2CpgKo=;
        b=H2H7JKYXXvAfClM3nA4go1vg+3MHl1e/2zDDCysrg3tEabCsIvKnRzv0Wvtb2s10VN
         304O8iUaaCjy+dnUF4jp5tvxQ7MKMC2YGkV23TPpDOStSB2Upw0HDsdfWJMs2ioAEOrO
         fhKRJupDAIl1fLdC4rmrOPBhagh95bOmoINpnJ0Zam1PJQYxiVWiFMx4uAO8/VhJige/
         q5RIt7kTTdZLXfDSogK4wYnAWCRuJIegjkPjFnq6DxnHXIQKAcCVC2EWQgKtVEUTgRU7
         MuUyGBNerPFdl7BnbM83N10a7qTIxPVwG7X9BJpk4AcHrfhY18IPOxuXDtofPfhLSKvV
         XlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BPaUYtbAIV1BLKNgYdAozqHw0R4+q9lV2NZg2CpgKo=;
        b=OeuWHlmN0zmWH1OIgTn1MEBLqSGuaQmgZ+UqLrrz2rCKmVXn6eHvYCRKDSNzKDbA6f
         lYBq9tfs+5Oo3jzRd2yVOTAsYDHO9+GDejko4RrvBRX9OrXfHdTUVwTgxLxeWdDxgO4q
         U8EvqGUG1CkdZ4uRTaveFwA7YSnRjWQG2OdaMcsiQ3k++4N3VzdDy8dfmxOWNAklrvQn
         oyZhAQt+P1lhXh2fTAZpovR0MbmHedTW01NiIejf+pZ8dCOTe5FV0UNhnYEDDHRtYDSz
         ievtkz7ow3m+zviEFJerZrscMa+yCfwB6OGEqW/iSdPrAt7XbtuVb0xIZZucavH7w/gQ
         a9Wg==
X-Gm-Message-State: ANoB5pniT1TDQQ8N54KKD8ExbW9zrYj1CqMDysfop090KC6esvl3T0+u
        hddhmcMtW9Fhp0AvND+3TiyF4w==
X-Google-Smtp-Source: AA0mqf5Pz039HsSECacZv7n6SegwyteVoV+SG8Cjh+HO/AU52+pi8GERHDDdw5tp9McDI8DIbvAY2w==
X-Received: by 2002:a17:907:2c75:b0:7c0:bbab:a550 with SMTP id ib21-20020a1709072c7500b007c0bbaba550mr14397235ejc.168.1670315649259;
        Tue, 06 Dec 2022 00:34:09 -0800 (PST)
Received: from [127.0.1.1] ([2a0e:41a:894f:0:2017:359e:18ef:1c49])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b0078d9b967962sm7019390eja.65.2022.12.06.00.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 00:34:08 -0800 (PST)
From:   Carlo Caione <ccaione@baylibre.com>
Date:   Tue, 06 Dec 2022 09:34:01 +0100
Subject: [PATCH v3 1/3] drm/tiny: ili9486: Enable driver module autoloading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221116-s905x_spi_ili9486-v3-1-59c6b58cbfe3@baylibre.com>
References: <20221116-s905x_spi_ili9486-v3-0-59c6b58cbfe3@baylibre.com>
In-Reply-To: <20221116-s905x_spi_ili9486-v3-0-59c6b58cbfe3@baylibre.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Jerome Brunet <jbrunet@baylibre.com>,
        David Airlie <airlied@gmail.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        Carlo Caione <ccaione@baylibre.com>,
        linux-kernel@vger.kernel.org
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
Display (rpi-lcd-35 and piscreen).

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/gpu/drm/tiny/ili9486.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
index c80028bb1d11..2ca7c59771f3 100644
--- a/drivers/gpu/drm/tiny/ili9486.c
+++ b/drivers/gpu/drm/tiny/ili9486.c
@@ -183,6 +183,8 @@ MODULE_DEVICE_TABLE(of, ili9486_of_match);
 
 static const struct spi_device_id ili9486_id[] = {
 	{ "ili9486", 0 },
+	{ "rpi-lcd-35", 0 },
+	{ "piscreen", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ili9486_id);

-- 
b4 0.10.1
