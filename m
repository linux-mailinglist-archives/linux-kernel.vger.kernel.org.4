Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318766093F1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiJWOd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiJWOdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:33:45 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43DD61D65;
        Sun, 23 Oct 2022 07:33:41 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so8348950wms.0;
        Sun, 23 Oct 2022 07:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvKXzpxFzZWAwh4ulfZ9nH6QQVrhwgz8YLgYLKE7oQk=;
        b=MiAv+zhVnlxmLdsRupQuYxZ+FUIDw9Fj/el8pUwCqfG4qpwFptaKXOgIZ3I2VqjkjZ
         biPuyIRR20VekRI4LcN+B89C4XYiGOmLicys+PnEUSFspnnqkDUJiK5yW8GhA1GPe0SV
         xkQsFftWaV3+6oOAvUIqUqJLlinN2RypA76M9QbkIo/regxEFAyvc35MIatgg0kR8tLf
         PxNpcjmFvCbtn1avOhGUn3eam5WA9Yf3TlUdKoLQXIxkrBUZoJBnqQKCJoQ1bO/8b6N8
         JgiWjxgbJ5kvOxcHUUUDO7ul8vG87dAiK7hptPQe1rovWUJBRHa8iXzcyCGhdkfMps26
         j9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvKXzpxFzZWAwh4ulfZ9nH6QQVrhwgz8YLgYLKE7oQk=;
        b=mcs9S2hr34bVlIdaBgOeqZsGeKdduXgXFNRHEzznOrLzOD75LGjDGZn3eqroraM6Nc
         VrgHkCSsRJDwcq9bTim0hI+j8qdrsooDsYaGMYw19qaTUs3FYN+9l2O1fFLwIhTkvD6z
         oyJTKjUVhszqwDztkoZ4SnoaCwe41Xs5TitkIXZetuXgstLwTkhmJDzdQnsamZS9zdrs
         fsU8g3fau4n4HSmwXazMZrj6VbrRYwpK5KKwHRyK31uLi4zIbWasof3VI3FYUQ0l833s
         7ZGqBGiy5loptNW5C2oxubwWqLhk5EvEjjTgwGh6FFEe2hzS/p2Z1mmuBPy8VEVWp4BL
         ziSw==
X-Gm-Message-State: ACrzQf3C7mzFvvKAC8W/TmgEAFMb+/4jyUBtD0eQdJScVqVSaCqhLbhK
        9B581JyRJgM9Cr39t23DGeIDh2vYLTo=
X-Google-Smtp-Source: AMsMyM4Jr8bpSn4dBiYu8xvawkAvOdkOXBkSzIVXVHX5h6ly2AgTR60eJ8BpaVu5+s3ByLfKeFZqXg==
X-Received: by 2002:a05:600c:358f:b0:3c6:da94:66f9 with SMTP id p15-20020a05600c358f00b003c6da9466f9mr18888398wmq.142.1666535620335;
        Sun, 23 Oct 2022 07:33:40 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
        by smtp.gmail.com with ESMTPSA id l24-20020a1c7918000000b003b50428cf66sm8463974wme.33.2022.10.23.07.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:33:39 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/9] ASoC: jz4740-i2s: Support continuous sample rate
Date:   Sun, 23 Oct 2022 15:33:26 +0100
Message-Id: <20221023143328.160866-8-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221023143328.160866-1-aidanmacdonald.0x0@gmail.com>
References: <20221023143328.160866-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2S controller on JZ47xx SoCs doesn't impose restrictions on
sample rate and the driver doesn't make any assumptions about it,
so the DAI should advertise a continuous sample rate range.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index fd35a8a51f60..201368f828ff 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -390,13 +390,13 @@ static struct snd_soc_dai_driver jz4740_i2s_dai = {
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.capture = {
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.symmetric_rate = 1,
@@ -426,13 +426,13 @@ static struct snd_soc_dai_driver jz4770_i2s_dai = {
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.capture = {
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.ops = &jz4740_i2s_dai_ops,
-- 
2.38.1

