Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19ADD6FC710
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjEIMvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEIMvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:51:42 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DAD4EF1;
        Tue,  9 May 2023 05:51:39 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f41d087b24so22201955e9.1;
        Tue, 09 May 2023 05:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683636698; x=1686228698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X1/XE53ZAzVzbWxt1L6Fngf/VAFFM7pHgdppOQGD8ZQ=;
        b=eFnLKpkN/MCUppT/fEZ7DQBH2Rr2kQRkkDgWCcXgKfAL2wSTwu2N7c6D1g6kiylfaq
         i6SSb/WA0cL+9AHuFkMNOy/Y3tewLZgcp0G8u1BDIPHRjxPRikBc8nlcULr4JeistBnn
         N0h1hYUFosD/LcZ0n1Odj68K0ppOjTW8ihDvENFpW6zg+bKdVAhGG9c6zNCz+W/PPqDL
         jT6+EqEYFdPrL3U8A6dRP0s45ggv25Fhrm0wkrCozbxn2qjSB492UcPIQmx51V9Jn55c
         fE28+r3NROLHAvARCZLiUZvOtPAcNs+RyImn1AmTqfl96c6lSiqky7eaChsZcxCDINiD
         6SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683636698; x=1686228698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X1/XE53ZAzVzbWxt1L6Fngf/VAFFM7pHgdppOQGD8ZQ=;
        b=HZQ54PdLUoo9+d5/qSBZKkpw9SwUYRJ1O1IMZPZiwBqATRtjJRATl6+EA2nDEmHmZD
         dz/Xe3CeE82XcJnhLQPaAYJu1zxZZ/ReT2GLFOOlGXqPYQ19dVz631T6IJ3r465t1mQd
         aA5/6QORS31gN0xMWq7wmf+KJ3i/btQMm3E/xDWoXumpYnkFq5leAn2kYZl/nGEkk/K+
         PmAnaO3alrP2Yi5/IlQevi6xsWyH0Rq5b56Xf/uHJesAYylpBncSYmn9hrwTssoZghsg
         6D4vteEjbm8tsdNFF9rwfREwKNaSWX5n5fK4axNStmU3BHxtv8il4oI/n8Mic246VxV+
         upzw==
X-Gm-Message-State: AC+VfDyc44MijDQmZ+5txaOgXsv7UU3VVDmp3AP86GjxjljaKOkx+Rk8
        k1CJOlssoXf8vDmUT2UMGa8=
X-Google-Smtp-Source: ACHHUZ50PgWu8QVhLMHOqfsQn+1urSHwnstxa95vNIKo9GS/JNUp0jqI1TRGORpE/pRnnpVdY2NPWA==
X-Received: by 2002:a5d:61ce:0:b0:306:30ea:a072 with SMTP id q14-20020a5d61ce000000b0030630eaa072mr10446235wrv.53.1683636697736;
        Tue, 09 May 2023 05:51:37 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id q6-20020adff946000000b003078cd719ffsm9340948wrr.95.2023.05.09.05.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 05:51:37 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] ASoC: jz4740-i2s: Make I2S divider calculations more robust
Date:   Tue,  9 May 2023 13:51:34 +0100
Message-Id: <20230509125134.208129-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the CPU supplies bit/frame clocks, the system clock (clk_i2s)
is divided to produce the bit clock. This is a simple 1/N divider
with a fairly limited range, so for a given system clock frequency
only a few sample rates can be produced. Usually a wider range of
sample rates is supported by varying the system clock frequency.

The old calculation method was not very robust and could easily
produce the wrong clock rate, especially with non-standard rates.
For example, if the system clock is 1.99x the target bit clock
rate, the divider would be calculated as 1 instead of the more
accurate 2.

Instead, use a more accurate method that considers two adjacent
divider settings and selects the one that produces the least error
versus the requested rate. If the error is 5% or higher then the
rate setting is rejected to prevent garbled audio.

Skip divider calculation when the codec is supplying both the bit
and frame clock; in that case, the divider outputs are unused and
we don't want to constrain the sample rate.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 54 ++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 6d9cfe0a5041..d0f6c945d9ae 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -218,18 +218,48 @@ static int jz4740_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	return 0;
 }
 
+static int jz4740_i2s_get_i2sdiv(unsigned long mclk, unsigned long rate,
+				 unsigned long i2sdiv_max)
+{
+	unsigned long div, rate1, rate2, err1, err2;
+
+	div = mclk / (64 * rate);
+	if (div == 0)
+		div = 1;
+
+	rate1 = mclk / (64 * div);
+	rate2 = mclk / (64 * (div + 1));
+
+	err1 = abs(rate1 - rate);
+	err2 = abs(rate2 - rate);
+
+	/*
+	 * Choose the divider that produces the smallest error in the
+	 * output rate and reject dividers with a 5% or higher error.
+	 * In the event that both dividers are outside the acceptable
+	 * error margin, reject the rate to prevent distorted audio.
+	 * (The number 5% is arbitrary.)
+	 */
+	if (div <= i2sdiv_max && err1 <= err2 && err1 < rate/20)
+		return div;
+	if (div < i2sdiv_max && err2 < rate/20)
+		return div + 1;
+
+	return -EINVAL;
+}
+
 static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	struct regmap_field *div_field;
+	unsigned long i2sdiv_max;
 	unsigned int sample_size;
-	uint32_t ctrl;
-	int div;
+	uint32_t ctrl, conf;
+	int div = 1;
 
 	regmap_read(i2s->regmap, JZ_REG_AIC_CTRL, &ctrl);
-
-	div = clk_get_rate(i2s->clk_i2s) / (64 * params_rate(params));
+	regmap_read(i2s->regmap, JZ_REG_AIC_CONF, &conf);
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S8:
@@ -258,11 +288,27 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 			ctrl &= ~JZ_AIC_CTRL_MONO_TO_STEREO;
 
 		div_field = i2s->field_i2sdiv_playback;
+		i2sdiv_max = GENMASK(i2s->soc_info->field_i2sdiv_playback.msb,
+				     i2s->soc_info->field_i2sdiv_playback.lsb);
 	} else {
 		ctrl &= ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE;
 		ctrl |= FIELD_PREP(JZ_AIC_CTRL_INPUT_SAMPLE_SIZE, sample_size);
 
 		div_field = i2s->field_i2sdiv_capture;
+		i2sdiv_max = GENMASK(i2s->soc_info->field_i2sdiv_capture.msb,
+				     i2s->soc_info->field_i2sdiv_capture.lsb);
+	}
+
+	/*
+	 * Only calculate I2SDIV if we're supplying the bit or frame clock.
+	 * If the codec is supplying both clocks then the divider output is
+	 * unused, and we don't want it to limit the allowed sample rates.
+	 */
+	if (conf & (JZ_AIC_CONF_BIT_CLK_MASTER | JZ_AIC_CONF_SYNC_CLK_MASTER)) {
+		div = jz4740_i2s_get_i2sdiv(clk_get_rate(i2s->clk_i2s),
+					    params_rate(params), i2sdiv_max);
+		if (div < 0)
+			return div;
 	}
 
 	regmap_write(i2s->regmap, JZ_REG_AIC_CTRL, ctrl);
-- 
2.39.2

