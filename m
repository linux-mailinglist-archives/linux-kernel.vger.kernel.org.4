Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B963608F25
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 21:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJVTNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 15:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJVTN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 15:13:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C00176528;
        Sat, 22 Oct 2022 12:13:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a10so9175616wrm.12;
        Sat, 22 Oct 2022 12:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yagE6PfAWV1c7o+BEcxE7EzZidDlQUomGLf1in/WfkM=;
        b=igPE6EXXqC7kFlmkXEmC/XA3D6fjwNngG/sJy9Ww2Pw5nOMZBTEUerkWl6cSse8UFr
         jpZJVxD4WNjPBfvwtJzGgbVEbOj0/a4CJ+vP7vJvzCPRdvXxWxLvBnilZYa+fTg2/fwx
         5MZUASlmGyWW3/FUX+gl+TsIapnG7Bg7xg0MGWjCxjzbOhP249izykhf7BQO59HzyJ02
         admKo1QbvThGk6DGFALBiTuHfmBojt1pT2nmafscQ69D6dvHUWX5Vw60Kb1moBUs9kjP
         RvDcAa8g5IyyEpHmAD1pNOo3wG93xdF8Kq6VdYQGSDzdexQP/FCxwWqWR9zfymybQr/+
         qEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yagE6PfAWV1c7o+BEcxE7EzZidDlQUomGLf1in/WfkM=;
        b=NFShvt+HImnn4xf0K4L85A+g+jk+eM5hUmsnc4ap5XGBRhr31V321YkFvNPLU3Ae2/
         3yg75q3/ad4kaU8Kz7M0nOJawcnDoHzintSW8Gi5nygjtS72CRhisJ+G9a18rxllpZ7J
         aSItS8JZ236Av+UDzOwymbjeAcKKnjinXWoeOaem/FpoJqZPvUVYQK3Od8dRDoPy9Pur
         SWeapUhvvRFQ3iPuZF6XNubvc8olIpaBanXsEG66rW1GyHdeIRDNrcw20Fia2vE9mzTF
         21zDTlaFvbmRE2yxvXwSaJmBrYP3XLv/Wd5DEUhORQpx5Dvlzm6kX/3w0C3GbiMFnhQa
         ANFg==
X-Gm-Message-State: ACrzQf0TP54UWpO6Lb9cIvHt6xt2VmTU6Gzu7jaA4MiN7a/2SNMfEk07
        LXV7hGoqD8vc3fbBAdupj+U=
X-Google-Smtp-Source: AMsMyM7S/Yab6rkdTXlQtmV3AMKRUInnlygeH8fTYhv1/JEeIam1Os4D5l76uQtzpq8qkakhbMq+pA==
X-Received: by 2002:a05:6000:1f9e:b0:22e:61fa:3f1c with SMTP id bw30-20020a0560001f9e00b0022e61fa3f1cmr15908220wrb.546.1666466006048;
        Sat, 22 Oct 2022 12:13:26 -0700 (PDT)
Received: from localhost (94.197.1.68.threembb.co.uk. [94.197.1.68])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6acc000000b0022ae0965a8asm21417358wrw.24.2022.10.22.12.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 12:13:25 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/9] ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
Date:   Sat, 22 Oct 2022 20:13:03 +0100
Message-Id: <20221022191308.82348-5-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
References: <20221022191308.82348-1-aidanmacdonald.0x0@gmail.com>
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

Get rid of a couple of macros and improve readability by using
FIELD_PREP() and GENMASK() for the sample size setting.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index b0bbcd025241..4767abea425f 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -3,6 +3,7 @@
  *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/bitfield.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -42,8 +43,8 @@
 #define JZ_AIC_CONF_SYNC_CLK_MASTER BIT(1)
 #define JZ_AIC_CONF_ENABLE BIT(0)
 
-#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK (0x7 << 19)
-#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK (0x7 << 16)
+#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE GENMASK(21, 19)
+#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE GENMASK(18, 16)
 #define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
 #define JZ_AIC_CTRL_ENABLE_TX_DMA BIT(14)
 #define JZ_AIC_CTRL_MONO_TO_STEREO BIT(11)
@@ -59,9 +60,6 @@
 #define JZ_AIC_CTRL_ENABLE_PLAYBACK BIT(1)
 #define JZ_AIC_CTRL_ENABLE_CAPTURE BIT(0)
 
-#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET 19
-#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
-
 #define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK BIT(12)
 #define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK BIT(13)
 #define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK BIT(4)
@@ -249,8 +247,9 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		ctrl &= ~JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK;
-		ctrl |= sample_size << JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET;
+		ctrl &= ~JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE;
+		ctrl |= FIELD_PREP(JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE, sample_size);
+
 		if (params_channels(params) == 1)
 			ctrl |= JZ_AIC_CTRL_MONO_TO_STEREO;
 		else
@@ -258,8 +257,8 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 
 		div_field = i2s->field_i2sdiv_playback;
 	} else {
-		ctrl &= ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK;
-		ctrl |= sample_size << JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET;
+		ctrl &= ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE;
+		ctrl |= FIELD_PREP(JZ_AIC_CTRL_INPUT_SAMPLE_SIZE, sample_size);
 
 		div_field = i2s->field_i2sdiv_capture;
 	}
-- 
2.38.1

