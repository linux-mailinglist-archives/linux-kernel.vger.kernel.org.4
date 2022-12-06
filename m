Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0956E643EB8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiLFIeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiLFIeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:34:14 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA30F6E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 00:34:12 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qk9so4427391ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 00:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcRZDjg3O3q6T3Sk5c09WrJuoI7e4rWvSzYj/Z5H43A=;
        b=4WirXC4jMxNwlMz6xJ0Jso5tI43SM73m6Z9nAG5UcC6cra+AVeRVqQ34JVt6DgZKgV
         c9hIcYbA/AvXNIM6RMGCohkjPKGrjCTBPl9oU3bNjAjQ/umGlKZLpggA155FB0vJk6Ct
         rVcHJ0ILj6BY4HBabqfD7FJVizZkw3Ldgd5e3xJbSInv7XpX/wYG6HZCmV7RsRmxhpIu
         XkwElGUBdmrQGgZBpaz/Yd6JEAvU7fw8grj8BxnZf8UlHql26r0u8WY4z+Mv4oLZ0koR
         xQtcD4jBbiBlgU3ycjVbJlgfX5rdOKY5JE6tHR1X8QYJktlo5P4BCCoaT1FmCpd7wM9l
         2tgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcRZDjg3O3q6T3Sk5c09WrJuoI7e4rWvSzYj/Z5H43A=;
        b=fiTVEqDoF7wevulIc3WFQYnvNe8kewfTrTH/u/lT+PzNmQOqeucpNSdKdhECfKz6wr
         NHqFaQGsPdP9fUml8C+wiVkVv0ld6GYHWxa9eC/LyHKVtgnPU0DI40+7xou6p12ZGHaG
         5/cUUrZh9H0d94xRzKMDoA/zZbL1HoEb4LeBPxk6XubOBT8u2sVC4vCrR2okPyMtwgoo
         FmnhfnbS2YyaaXqO3Q3WOWeG/B69S3d3UC/K4RWDeyMrCwHppiskvmI7SM5BQi4WWgIb
         kG3zZXsf8yDR9kFVLetAZXxqGe27hlRl4cbf1ZS+gnCBrZOsFLm7FcU6Mb3VLPOYsFHT
         N9wQ==
X-Gm-Message-State: ANoB5plvbDA59JjYVx2R2+1vc4a5MGLOmhgdumnlLK3+Tnmx3hwyiK+T
        3p064xxAipwS1DhAs5j7spqqjw==
X-Google-Smtp-Source: AA0mqf5gb/HnDPmrEu015wzGjESF27vgWXcc+GMbiF/NffvzbIeSzlwquLLovFxqS8JOcTBj9/5vKQ==
X-Received: by 2002:a17:906:164d:b0:7c0:b602:f9a1 with SMTP id n13-20020a170906164d00b007c0b602f9a1mr17569290ejd.88.1670315651166;
        Tue, 06 Dec 2022 00:34:11 -0800 (PST)
Received: from [127.0.1.1] ([2a0e:41a:894f:0:2017:359e:18ef:1c49])
        by smtp.gmail.com with ESMTPSA id g18-20020a17090604d200b0078d9b967962sm7019390eja.65.2022.12.06.00.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 00:34:10 -0800 (PST)
From:   Carlo Caione <ccaione@baylibre.com>
Date:   Tue, 06 Dec 2022 09:34:03 +0100
Subject: [PATCH v3 3/3] drm/tiny: ili9486: remove conflicting framebuffers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221116-s905x_spi_ili9486-v3-3-59c6b58cbfe3@baylibre.com>
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

For platforms using simplefb / efifb, call
drm_aperture_remove_framebuffers() to remove the conflicting
framebuffer.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/gpu/drm/tiny/ili9486.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
index 14a9e6ad2d15..6fd4d42437fd 100644
--- a/drivers/gpu/drm/tiny/ili9486.c
+++ b/drivers/gpu/drm/tiny/ili9486.c
@@ -14,6 +14,7 @@
 
 #include <video/mipi_display.h>
 
+#include <drm/drm_aperture.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_fb_helper.h>
@@ -238,6 +239,10 @@ static int ili9486_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = drm_aperture_remove_framebuffers(false, &ili9486_driver);
+	if (ret)
+		return ret;
+
 	drm_mode_config_reset(drm);
 
 	ret = drm_dev_register(drm, 0);

-- 
b4 0.10.1
