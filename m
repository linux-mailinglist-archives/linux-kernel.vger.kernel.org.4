Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711E36508FE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiLSJC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiLSJCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:02:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7205FBD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 01:02:51 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id b69so11894662edf.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 01:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaVNFQLQjvu/mR/33Qvn+CT5WA+rfSMQXLgBgZ4bdDM=;
        b=A1Zy6qoRVzqAGOFB96J1pF4ERIgoQXgHOFDmK4xgQnMA9IByu4kjh3dXqg9SDx0768
         9eOIKZvrDVcu1Lr5SDz6I4UX/uAxyFhNWxM+FHxQkA2sCr6dltN3cwp60irQx8HJtWm7
         1sGD1oV7eWyavHo4ijHytLcjchBuWv7EQj5AOSl3BmXFm10kcICy27AaZ+GL395V1wcD
         tRfxLexYrV9XfMDzIUGo6adh4OzxfZ9/V/EQJ+0QUZCnJ3A8IMvwPfAjiNdEh4Q7t6NK
         YxVD+9+UElauhoHi6RnNG91uqksaE0D+JEe1kGZBHjAFGJE/N3MFoTWOig+xWpIqZiXl
         c1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaVNFQLQjvu/mR/33Qvn+CT5WA+rfSMQXLgBgZ4bdDM=;
        b=CNvsHm7TKyR5diuAFlNnEgBPw6PYB0nAfRwLnHOMBlL/wD3VGfiMRf7x1GnXX2htb+
         Ip7Z8YWhk8sruqQCwj4HnqJ86zDgrPI2z8vGgswQ3F9xKnEyFgijqqGnCo//8HTpBP1v
         KvUW4oWK3TkJX2uNr9OwpS2KJGGwmegIDM5ZIin5H508VR1+V0MOzbKA0nrmelH+KMlf
         gRHMI6WW+/oKdNjtTyjSiT1xKAF0+6AVtr24aXs7czokhaM45Ud4N8wMu7pfnze8uv0q
         0AzxjDSiuN/oiEsM92NazkAIPCbmIXqtXiPP6EobwdlBHK5MxhG+yV0PrmHHxV3tBv/o
         wEug==
X-Gm-Message-State: AFqh2krLLOXZ6bZ7b+iFMLBJjrXzRqHbzV30ul+0HIpH/WaLgZemhz64
        pJV4OyVgVob/4QdELXahKJs8eSNMXrtGSq/k5fI=
X-Google-Smtp-Source: AMrXdXvmKZdR1xqWjHm/Mr9GhLjb73U4gYdCZ+DsGSdF0LkhCf8Hqf8o1AVqcBklR1QtE2zrDB9YuA==
X-Received: by 2002:a50:ed81:0:b0:477:ff25:867a with SMTP id h1-20020a50ed81000000b00477ff25867amr8453170edr.12.1671440569906;
        Mon, 19 Dec 2022 01:02:49 -0800 (PST)
Received: from [127.0.1.1] ([2001:b07:5d39:f336:a0ba:cfa5:2107:c2c4])
        by smtp.gmail.com with ESMTPSA id u11-20020a170906b10b00b00781dbdb292asm4082721ejy.155.2022.12.19.01.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 01:02:49 -0800 (PST)
From:   Carlo Caione <ccaione@baylibre.com>
Date:   Mon, 19 Dec 2022 10:02:37 +0100
Subject: [PATCH v4 1/2] drm/tiny: ili9486: Enable driver module autoloading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221116-s905x_spi_ili9486-v4-1-f86b4463b9e4@baylibre.com>
References: <20221116-s905x_spi_ili9486-v4-0-f86b4463b9e4@baylibre.com>
In-Reply-To: <20221116-s905x_spi_ili9486-v4-0-f86b4463b9e4@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Carlo Caione <ccaione@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
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
index 1bb847466b10..8bf0dca0b05d 100644
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
