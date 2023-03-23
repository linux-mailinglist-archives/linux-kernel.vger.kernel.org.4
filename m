Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F49E6C6E06
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbjCWQpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjCWQpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:45:04 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0649FC14B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:44:20 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b20so56541849edd.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679589858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ylgpuVGeZBO2/cPigFjTck4l8oNGf5kwYVPeLJ7mYo=;
        b=dacXY7BgXtYyAS8zIpvXAvcqNaLtsWu7+lJTg+KFrpJT1Z5K5gYJ6Y4K6BD2huGCa9
         5vhnXieE415UGVwoecZOfFSqsXshhfWe0aJYOC40tSvBgxuWU7W7QimqqscSY0hOKA1C
         f6B73Y3wVgs2Ck9zYnrKTG9/A2JgGhG/WfrOGxzOUzclZKUb9GAOC0mSYqjcjbWB54IR
         v5g1bq5pz25hcf0I0nckMSeP97SFjcdBMrvximAgZa4ZNKFcCC4KOZgOv1zRYkk2ZEIx
         lofDYwd6dqtHaVtcjzex+63NchJQ9oGh/C9orGbqSyPyTwEX21yljYRSH/KlBeg0JoWE
         HiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679589858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ylgpuVGeZBO2/cPigFjTck4l8oNGf5kwYVPeLJ7mYo=;
        b=qXj9KvQo4/UnsGYYC8U5zOtHDHFqCbnbbIv7YkoGNI6TpdEV9qak5xRuz1RpWxcxIX
         ZU91X4mWjs86GMSgfeEwBChTj6WlteQFxiOSuUo8H9RohRIaInUNJdiP0NNOg0nlL2qe
         vbGKIDqSedGe7gKXa6UJbkro4ug3EJDZrHiTv/FtP2jIT6BHNlSZ0JDCLEZ5vRgHlIRe
         8dcu+XdfuTfsuAVm9IcR5CwCJhA/VlJo1zSUQNoDcqU8bKjPhrjLqngRJdmljQuLgTtH
         CLgNqaDXqRiK7i/8j+ctkfUEYCJ837r4HW844CwgSLFCPU0Iw/ubQrMspy7sUHzb0agl
         Tnmw==
X-Gm-Message-State: AO0yUKWIhR/QeHS1Uc2YOzktqhkooiwbfAvv0+Y9euY3uEzzfaaptyV/
        hbavBRooAbSDdGdNcqw537PtTg==
X-Google-Smtp-Source: AK7set8PJ6DrVeZ74exAstkDNXg0vgDtpg5//VFYMzxKWQ4tvmjHT43tXBzHbo9OovNiaKw/g+ELLw==
X-Received: by 2002:a17:906:b0b:b0:930:f149:7865 with SMTP id u11-20020a1709060b0b00b00930f1497865mr10714465ejg.21.1679589858511;
        Thu, 23 Mar 2023 09:44:18 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id m10-20020a50998a000000b004e48f8df7e2sm9542187edb.72.2023.03.23.09.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 09:44:16 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        johan+linaro@kernel.org, steev@kali.org,
        dmitry.baryshkov@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/4] ASoC: codecs: wsa883x: mute/unmute PA in correct sequence
Date:   Thu, 23 Mar 2023 16:44:02 +0000
Message-Id: <20230323164403.6654-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
References: <20230323164403.6654-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current setup the PA is left unmuted even when the
Soundwire ports are not started streaming. This can lead to click
and pop sounds during start.
There is a same issue in the reverse order where in the PA is
left unmute even after the data stream is stopped, the time
between data stream stopping and port closing is long enough
to accumulate DC on the line resulting in Click/Pop noise
during end of stream.

Moving the mute/unmute to trigger stop/start respectively seems to
help a lot with this Click/Pop issues reported on this Codec.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index c609cb63dae6..b83b5b0d4bab 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1204,9 +1204,6 @@ static int wsa883x_spkr_event(struct snd_soc_dapm_widget *w,
 			break;
 		}
 
-		snd_soc_component_write_field(component, WSA883X_DRE_CTL_1,
-					      WSA883X_DRE_GAIN_EN_MASK,
-					      WSA883X_DRE_GAIN_FROM_CSR);
 		if (wsa883x->port_enable[WSA883X_PORT_COMP])
 			snd_soc_component_write_field(component, WSA883X_DRE_CTL_0,
 						      WSA883X_DRE_OFFSET_MASK,
@@ -1219,9 +1216,6 @@ static int wsa883x_spkr_event(struct snd_soc_dapm_widget *w,
 		snd_soc_component_write_field(component, WSA883X_PDM_WD_CTL,
 					      WSA883X_PDM_EN_MASK,
 					      WSA883X_PDM_ENABLE);
-		snd_soc_component_write_field(component, WSA883X_PA_FSM_CTL,
-					      WSA883X_GLOBAL_PA_EN_MASK,
-					      WSA883X_GLOBAL_PA_ENABLE);
 
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
@@ -1341,10 +1335,38 @@ static int wsa883x_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
 	return 0;
 }
 
+static int wsa883x_trigger(struct snd_pcm_substream *s, int cmd,
+			   struct snd_soc_dai *dai)
+{
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		wsa883x_digital_mute(dai, false, 0);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		wsa883x_digital_mute(dai, true, 0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int wsa883x_startup(struct snd_pcm_substream *stream,
+			   struct snd_soc_dai *dai)
+{
+	return wsa883x_digital_mute(dai, true, 0);
+}
+
 static const struct snd_soc_dai_ops wsa883x_dai_ops = {
+	.startup = wsa883x_startup,
 	.hw_params = wsa883x_hw_params,
 	.hw_free = wsa883x_hw_free,
-	.mute_stream = wsa883x_digital_mute,
+	.trigger = wsa883x_trigger,
 	.set_stream = wsa883x_set_sdw_stream,
 };
 
-- 
2.21.0

