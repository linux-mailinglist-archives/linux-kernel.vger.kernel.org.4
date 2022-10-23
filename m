Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E803D6093EA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiJWOdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJWOdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:33:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143F061B39;
        Sun, 23 Oct 2022 07:33:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bu30so11848062wrb.8;
        Sun, 23 Oct 2022 07:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yagE6PfAWV1c7o+BEcxE7EzZidDlQUomGLf1in/WfkM=;
        b=Zy8H6eKZB+FQ4I7VGkb+tY3m9TLER0iULJcO2taPxrxxwuUJaQLZ/wez+a11a5aZCZ
         sCV/ScsX03su9YQBJwbBw9XCFOnpkeHtDGPqSQ3GVWi02F4V7jFRDkkejzug5nlDOsFq
         Td1DG19OibxKTK52pcQyysCuqlFz05kzHv0iT7ufJERlUd36HZwQTGRPpgTxS1GrLl8U
         U+KXZQPew75mQKQ+R0yZ7hiv1/QuePiZI4ol59bRHJ+IXXf8fYMrk/tAQKXns0Zk3IWJ
         bvWL23Ife3D39mF/Nl+KVWbfUcLIm7GRSY+UcG+AcaTYgHrUYSGwzpFL9nECiQG6mum7
         dZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yagE6PfAWV1c7o+BEcxE7EzZidDlQUomGLf1in/WfkM=;
        b=gCz8SpKQgJ3NyXutPuCX6YzI+5Xc7Rvjjl5lXNtwRP9jDL+n3QuOuiW9GrakP/TSSv
         FgdNOhEm/qSZt0SqQfgCMYgI2xdyN0aFL1nk1fe2f2vkYhCaVmNILaG3Aqwa4oQ/Zymj
         KMb3vwfI34j8esSHDSRgH++G7gpNc0qVwPgySkrVnQvSvoInkMnBOMLjQqpIH2uN2Frj
         Iz7JF1qt6zAGSh4BCB8tZNG3vslGUY2y9m+/GUNBwiYbI6EjPPYoVudr8TcP4vLgV+v2
         H0AuVIBn+f6+rZ0uqNVf3XSxqhEh5mld4dLuXPaPQ+06Tf4t9Ko5zRCmfguUOKGAA5KC
         1/nA==
X-Gm-Message-State: ACrzQf2JiBTuN1fCmX15W679V2vMBVv2jdP8fVOtbogKCeG1z7byk/3b
        W7PxOoU+HTVxjnXhJAnd+ew=
X-Google-Smtp-Source: AMsMyM5pk4MuHnfsYjbYLcyZqpaLGd5WxlRnDn1uk1NivJVgywuBaTw9dWBYZgykPuKT1IBA5L4DMA==
X-Received: by 2002:a05:6000:50a:b0:225:210c:a7e4 with SMTP id a10-20020a056000050a00b00225210ca7e4mr18207884wrf.704.1666535616636;
        Sun, 23 Oct 2022 07:33:36 -0700 (PDT)
Received: from localhost (94.197.10.75.threembb.co.uk. [94.197.10.75])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d4cd1000000b002362f6fcaf5sm2925381wrt.48.2022.10.23.07.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 07:33:36 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     zhouyu@wanyeetech.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/9] ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
Date:   Sun, 23 Oct 2022 15:33:23 +0100
Message-Id: <20221023143328.160866-5-aidanmacdonald.0x0@gmail.com>
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

