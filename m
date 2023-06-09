Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9585729D85
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbjFIO4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241673AbjFIO41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:56:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821193A84
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:56:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f7f6341bf9so18355205e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686322545; x=1688914545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceveTfOufM41Yk46cZA2HP7pP/eOM7y2Ye/vu65mbBg=;
        b=wGdDdU1WbBehr6YeSjJKJn2UicuWUB0ZAFeXWFhjulmN7L79cudbUKwhzTXhSnQlQT
         5OtYwrDbnPzojxezVf7Nb+lDxIKdUzmoixPSzbd/BE55bL0rHwk0ibyDuDkvrK2+c5yZ
         ogHLqsEysKwz0f8Dw5JxGnyLcRHdHCb81BGP9H8WwEz/Rv/u+2PUMIG91z1HNx9JzjEq
         H3+T6KT7Roh0qPnWvFCrGkkFeyZK7LH0cDSTzbmCkrDLd9N8mPami5oHqSiooVvp1UUz
         8PvZynmeITTUIV0GtWt17uKYjSZKFWT4c8iQxCUWtngcNNwih7RPKHqqTMxhG0KBtsqN
         42jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322545; x=1688914545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceveTfOufM41Yk46cZA2HP7pP/eOM7y2Ye/vu65mbBg=;
        b=iEj6BbmSSUJ817Dqs252WPy/U6Ys5OB8MHAJyyxTmWcEUqFVpLZ0RXD710tV2KmMFY
         ZHJp0J0uF171fRnZmVMenpNqoOU0wjqjqIT+f2PDBczuyLCj9za77QkcPXOWPfbKF0CM
         QI1zrUjp5AR55W783VpEtFFFRFQVBnmoVggZRdaEds6X0SzpNOOeR01iz7jAHbwtCLnw
         HyA1LS85zI3hBfQHwxwnhe2sr4EFEDdOkZbUV7uAl9xh9riLmyVzUJopHPIZkuLaGJ4y
         5hR0emF0BTl23ZXTDirSphCK2NVL85dT9/5Po2db4U4c8o6b3NsNhGFCiRLTMH4UYtWr
         0Ryw==
X-Gm-Message-State: AC+VfDzSc0V+WDCkJ64LgU9E9hbELgUCsaKWv8mJHA4cIg0Z8XRliQQV
        3fRuyulwlPvZdRIQDCt5lyT/VA==
X-Google-Smtp-Source: ACHHUZ4+xaJJt8ykggKW0Xc2YkxZCEXG9THMCFctHSJ1eSFC1V4U97xkSNUdkLqQXEYF4N2d4JWOPg==
X-Received: by 2002:a05:600c:2901:b0:3f6:d2c:13f2 with SMTP id i1-20020a05600c290100b003f60d2c13f2mr1453507wmd.41.1686322545323;
        Fri, 09 Jun 2023 07:55:45 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003f7310a3ffasm2946632wmr.2.2023.06.09.07.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:55:44 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v2 09/11] ASoC: q6dsp: q6apm-dai: Add trigger/pointer compress DAI callbacks
Date:   Fri,  9 Jun 2023 15:54:05 +0100
Message-Id: <20230609145407.18774-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230609145407.18774-1-srinivas.kandagatla@linaro.org>
References: <20230609145407.18774-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add q6apm trigger and pointer compress DAI callbacks to support
compress offload playback.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 67 ++++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6apm.h     |  1 +
 2 files changed, 68 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index d43705bf523a..9543b79ce83d 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -568,11 +568,78 @@ static int q6apm_dai_compr_get_codec_caps(struct snd_soc_component *component,
 
 	return 0;
 }
+
+static int q6apm_dai_compr_pointer(struct snd_soc_component *component,
+				   struct snd_compr_stream *stream,
+				   struct snd_compr_tstamp *tstamp)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6apm_dai_rtd *prtd = runtime->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&prtd->lock, flags);
+	tstamp->copied_total = prtd->copied_total;
+	tstamp->byte_offset = prtd->copied_total % prtd->pcm_size;
+	spin_unlock_irqrestore(&prtd->lock, flags);
+
+	return 0;
+}
+
+static int q6apm_dai_compr_trigger(struct snd_soc_component *component,
+			    struct snd_compr_stream *stream, int cmd)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6apm_dai_rtd *prtd = runtime->private_data;
+	int ret = 0;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		ret = q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, NO_TIMESTAMP);
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		break;
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		break;
+	case SND_COMPR_TRIGGER_NEXT_TRACK:
+		prtd->next_track = true;
+		break;
+	case SND_COMPR_TRIGGER_DRAIN:
+	case SND_COMPR_TRIGGER_PARTIAL_DRAIN:
+		prtd->notify_on_drain = true;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int q6apm_dai_compr_ack(struct snd_soc_component *component, struct snd_compr_stream *stream,
+			size_t count)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6apm_dai_rtd *prtd = runtime->private_data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&prtd->lock, flags);
+	prtd->bytes_received += count;
+	spin_unlock_irqrestore(&prtd->lock, flags);
+
+	return count;
+}
+
 static const struct snd_compress_ops q6apm_dai_compress_ops = {
 	.open		= q6apm_dai_compr_open,
 	.free		= q6apm_dai_compr_free,
 	.get_caps	= q6apm_dai_compr_get_caps,
 	.get_codec_caps	= q6apm_dai_compr_get_codec_caps,
+	.pointer	= q6apm_dai_compr_pointer,
+	.trigger	= q6apm_dai_compr_trigger,
+	.ack		= q6apm_dai_compr_ack,
 };
 
 static const struct snd_soc_component_driver q6apm_fe_dai_component = {
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index d187d88c0a8c..8ee40732ce9e 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -46,6 +46,7 @@
 
 #define APM_MAX_SESSIONS			8
 #define APM_LAST_BUFFER_FLAG			BIT(30)
+#define NO_TIMESTAMP				0xFF00
 
 struct q6apm {
 	struct device *dev;
-- 
2.21.0

