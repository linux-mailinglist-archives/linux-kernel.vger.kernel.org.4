Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5AD6E2519
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjDNODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDNODn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:03:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C42C211F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:03:03 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id n22so17290597ljq.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1681480971; x=1684072971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l00HAAnjKLxvI4M71LWAa1g6hA4VFu1YZpxf8JORAUs=;
        b=JzlusrDNdzUZCKHh7U6SmI+KlP/mVczAn9Xb3MZfbiz5r8m1L0lqAf9Z0JgZD3Tqxx
         X/DTdKdcVdFoEc02n65cBpez+thdu+oE08qMKBCO03cEzFiculVhVRZbG5DLG4CFH5bk
         EuymseLwwLz74StstE7lynJG+54dZLY4rdi+sSD39UBUKIAUmFkdUUPAgn0+lE7xe9xI
         aXGxbRy0yeAy20z1zjWdIESJpZ63qTDpzC6yhXnOVrFJUvqPVIkSeblw+Zm3H288fGw7
         1AGJlriLqc33CclcKMinnVNJN0MwG6Pgb1IsmYYrXUCl7cZ0DdbTtOPnhdownoKzOkWs
         bywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480971; x=1684072971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l00HAAnjKLxvI4M71LWAa1g6hA4VFu1YZpxf8JORAUs=;
        b=Th1L7dvCDgZ/g7/ffOCBEwCFE31ln1YYW9LQWi1Uk0Lr7SZYr1skxPBrus+J5ZRuPR
         SYXhtbZDCopIGCYCg125tF/E/x30ro1D1iBxQh3pEkgAXMXwjYLftkkAcOsxfbeXcrW/
         DThRIoB0M6XM6sGz+Vx5MKXzzVT/Qg6fwsbxwX9nU07TeDNabnelFEUt7I9Qi+Tj0vua
         1nJowcj+XaDhel55DYEughiYaE76rpmSZAcbkLY1EOPaGnzPfWe5ebafU1Gp8QzgmFqX
         +xkxjTr/3f4GkdNEA8ahSITFg8+E7A5KYUPCDhthudZRNnwwD96E6nAvEuoHxxe2nSCv
         AhMQ==
X-Gm-Message-State: AAQBX9eSWQMNQ8vr9qTSczge9w+MI+koeKHVt58emKuJfPgCr8DY2a+p
        6HU0jfCyayZwUl1+yNJxZ1kr8A==
X-Google-Smtp-Source: AKy350ZxhF8jz5Saa4u19lC/KyENjhrRMahkQQL0VeYcZWqgqY9MaL+3miI6fzj/xv1zhuIzYZZSRw==
X-Received: by 2002:a2e:99d2:0:b0:2a7:ace8:e0ba with SMTP id l18-20020a2e99d2000000b002a7ace8e0bamr2212415ljj.42.1681480971325;
        Fri, 14 Apr 2023 07:02:51 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-201-26.toya.net.pl. [31.182.201.26])
        by smtp.gmail.com with ESMTPSA id 15-20020a2eb2cf000000b002a76e2dedbcsm828684ljz.139.2023.04.14.07.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 07:02:51 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dinguyen@kernel.org,
        lars@metafoo.de, nuno.sa@analog.com, upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH 7/9] ASoC: ssm2602: Add mute gpio
Date:   Fri, 14 Apr 2023 16:02:01 +0200
Message-ID: <20230414140203.707729-8-pan@semihalf.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230414140203.707729-1-pan@semihalf.com>
References: <20230414140203.707729-1-pan@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SSM2603 has a hardware mute pin. Add an optional mute gpio to
control it.

Signed-off-by: Paweł Anikiel <pan@semihalf.com>
---
 sound/soc/codecs/ssm2602.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 35c4743e756e..dd81e62d7a3b 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 
 #include <sound/pcm.h>
@@ -32,6 +33,8 @@ struct ssm2602_priv {
 
 	enum ssm2602_type type;
 	unsigned int clk_out_pwr;
+
+	struct gpio_desc *mute_gpiod;
 };
 
 /*
@@ -352,6 +355,10 @@ static int ssm2602_mute(struct snd_soc_dai *dai, int mute, int direction)
 	else
 		regmap_update_bits(ssm2602->regmap, SSM2602_APDIGI,
 				    APDIGI_ENABLE_DAC_MUTE, 0);
+
+	if (ssm2602->mute_gpiod)
+		gpiod_set_value_cansleep(ssm2602->mute_gpiod, mute);
+
 	return 0;
 }
 
@@ -680,6 +687,10 @@ int ssm2602_probe(struct device *dev, enum ssm2602_type type,
 	ssm2602->type = type;
 	ssm2602->regmap = regmap;
 
+	ssm2602->mute_gpiod = devm_gpiod_get_optional(dev, "mute", GPIOD_OUT_LOW);
+	if (IS_ERR(ssm2602->mute_gpiod))
+		return PTR_ERR(ssm2602->mute_gpiod);
+
 	return devm_snd_soc_register_component(dev, &soc_component_dev_ssm2602,
 		&ssm2602_dai, 1);
 }
-- 
2.40.0.634.g4ca3ef3211-goog

