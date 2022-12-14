Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA7464D24B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLNWUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLNWUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:20:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D64D45ED2;
        Wed, 14 Dec 2022 14:20:29 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so514143wms.2;
        Wed, 14 Dec 2022 14:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPREbJk824mHynEMZOnSi0K0a5V18kJznKBGD4RRywY=;
        b=l66GEwC5C6VAS63K9J3rZjKXv9Ah6JEmGkuUGTVHgliCPY1cXbu5ewkG01mSuzfOXD
         tDbxZKkVQiouTZLeMmdg8ADhLgjvkP2wFX/bPfh+phz68l/x5yxvzk2PuceUI81df6Wn
         cOjmzuKX0dQJMpWSv6CzEZySAEl9bbDI5wBAt9rXkH0czm+jeEvmQg+aLeZ8gYzFAYD6
         mV29/0ZPxC6sI/8oT/T2Cc3aUQw6lvAFKYpQrlfEFWIQPSTMebp8pO0puAK+W6JX1SPO
         8Bgo844ywOv1nreOSxlJtW45S4yK6i7govngZIKnx73r0zaR33+EmSbRLTWrl8pAEcue
         gQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPREbJk824mHynEMZOnSi0K0a5V18kJznKBGD4RRywY=;
        b=2xCP8VQrXdR9Nx0hw1Ef904S7NwyZcD1qXs50d6g1LPq87yc7odgwN2vJhOuTws7cn
         pxDYb7s5j24J66Itwbixd1FfGzW6H6FjmIqRJZ84tNn43pl/4USEd/sJ4VpXcOZ1edWB
         Fjrgc11RBPlKBewNPS6s5IxqeTeg8Ca++sRBcMV4cjaMFVNtOpc8KTKEFx7mqj3mM4c1
         KxOZ/P4A0pRRfVyaoPe3e8RVQOZu6CXwLHJ6MO+B3ompRAn0S7F/3Pk17h6aEJqN9OAn
         3LUQahpLJlXJx5ivoXJTnKswz6qVKp121ZTkrVxeAGy7Hf8jJsmPE/67vqn4xsNVQRBk
         CeFg==
X-Gm-Message-State: ANoB5plggdx7dV0V06ZBzJ5ngPBlrzlM8tfUyj0T5TeJlPScp8iChJ3D
        91wzM6gjj0WQ1PplXK3hvGeaV/HAH04P7w==
X-Google-Smtp-Source: AA0mqf5Ji4XUil9erQ2oeZMLnbnZyZcIGBqTvrqtrXfVbfgMHW3zGU9xw1FA1j3kxScoRn5UhzdNJA==
X-Received: by 2002:a05:600c:1d98:b0:3cf:74b4:c3c8 with SMTP id p24-20020a05600c1d9800b003cf74b4c3c8mr20435849wms.17.1671056428101;
        Wed, 14 Dec 2022 14:20:28 -0800 (PST)
Received: from localhost ([2a02:1210:8629:800:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with UTF8SMTPSA id w23-20020a05600c099700b003d1de805de5sm3512107wmp.16.2022.12.14.14.20.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 14:20:27 -0800 (PST)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: ep93xx: Add OF support
Date:   Wed, 14 Dec 2022 23:20:24 +0100
Message-Id: <20221214222024.951984-2-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221214222024.951984-1-alexander.sverdlin@gmail.com>
References: <20221214222024.951984-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for EP93xx conversion to DT.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/iio/adc/ep93xx_adc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
index fd5a9404c8dc..e530a37180e1 100644
--- a/drivers/iio/adc/ep93xx_adc.c
+++ b/drivers/iio/adc/ep93xx_adc.c
@@ -21,6 +21,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 /*
  * This code could benefit from real HR Timers, but jiffy granularity would
@@ -227,9 +228,18 @@ static int ep93xx_adc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id ep93xx_adc_of_ids[] = {
+	{ .compatible = "cirrus,ep9301-adc" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ep93xx_adc_of_ids);
+#endif
+
 static struct platform_driver ep93xx_adc_driver = {
 	.driver = {
 		.name = "ep93xx-adc",
+		.of_match_table = of_match_ptr(ep93xx_adc_of_ids),
 	},
 	.probe = ep93xx_adc_probe,
 	.remove = ep93xx_adc_remove,
-- 
2.37.3

