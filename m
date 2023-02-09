Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2212A6908C3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjBIM2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjBIM2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:28:20 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B109274B9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:28:19 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ba1so1594692wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 04:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JongRsuVGtYNajpohdC5ZEm05+E/44o4yeTIeuBWqPg=;
        b=alMmw7K9GMnEn1dIokLBXd4VnAN2PqcPqLeYDOvmAEvT+atiV99OFPdGXozBSW1ssj
         ccORQTeZzjA8aLRxMsj+skj1xDRSXVIxjBTUzh/apuAPqn3ele+M/sugsW1C8k03X4tq
         YEdEGEkEY0o6n2vIisvGuacfKbPSLlHmbGSqDowpOOmRMEwfTxvAZlQocUX5x+u1kCzO
         FlguWkcJCItO/oGT/y3ZoY6MzZrV7rX4TJjuDtvzTQtG6M1zMIj58VTStQDka8oVsu6l
         vxSOHg31mXv1kY4gERgMIEM5NUEpTNpfzi4iQAkFWsF2FXAteACyABSGiHPdHEsbptBC
         nk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JongRsuVGtYNajpohdC5ZEm05+E/44o4yeTIeuBWqPg=;
        b=dgM/jattlhtloyVGd/mxvv7IITqq6v3ufAiB08d03VQ+TZ0MS/fOviemV+qWOuC20s
         Uw5kfdcNnOkIRA0wteikFO9TwBb+aVlifh6MKnEcJLpT7LTmvym4bNTIBna0C03Sgo6X
         vE+hbMwmlf6EncVdzZIKzR2TpjFXkCpA3XkHtmRkoRROmprzpZXLjopi/0XQccq3ncDM
         BN+6/Nrj+o496GIs/4ulYuBQpIH982KMwHT7yaoAA3PN0Zwm9JodY9r1UXyvjmMtUtG9
         wOmjhiYGzAK5KMncCqNqIfjpohbBKh+LNtutO9SFm5LvVJr3hH0/GVillVm1JjPYxxSH
         GkjQ==
X-Gm-Message-State: AO0yUKWD0Ew14Pia1Z5Aqh/9lTO1wvzdSUd/BRTafaSebd9o1lWDSlZM
        E0IFjBKTbVZzEX3T60wYGwQKgQ==
X-Google-Smtp-Source: AK7set8SioHyugKUVRQMPGwHDkqYTiDLPA9qpldsYrSbri1MnKs3q0k8fi7Ii5vdS25u7FD8u9iJ2g==
X-Received: by 2002:a05:6000:8:b0:2c2:ad22:40ba with SMTP id h8-20020a056000000800b002c2ad2240bamr10493326wrx.68.1675945697850;
        Thu, 09 Feb 2023 04:28:17 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o8-20020a5d58c8000000b002c3f0a4ce98sm1134763wrf.98.2023.02.09.04.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 04:28:17 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        steev@kali.org, johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/8] ASoC: qcom: q6apm-dai: fix race condition while updating the position pointer
Date:   Thu,  9 Feb 2023 12:28:00 +0000
Message-Id: <20230209122806.18923-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230209122806.18923-1-srinivas.kandagatla@linaro.org>
References: <20230209122806.18923-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is noticed that the position pointer value seems to get a get corrupted
due to missing locking between updating and reading.

Fix this by adding a spinlock around the position pointer.

Fixes: 9b4fe0f1cd79 ("ASoC: qdsp6: audioreach: add q6apm-dai support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index ee59ef36b85a..bd35067a4052 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -8,6 +8,7 @@
 #include <linux/slab.h>
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <linux/spinlock.h>
 #include <sound/pcm.h>
 #include <asm/dma.h>
 #include <linux/dma-mapping.h>
@@ -53,6 +54,7 @@ struct q6apm_dai_rtd {
 	uint16_t session_id;
 	enum stream_state state;
 	struct q6apm_graph *graph;
+	spinlock_t lock;
 };
 
 struct q6apm_dai_data {
@@ -99,20 +101,25 @@ static void event_handler(uint32_t opcode, uint32_t token, uint32_t *payload, vo
 {
 	struct q6apm_dai_rtd *prtd = priv;
 	struct snd_pcm_substream *substream = prtd->substream;
+	unsigned long flags;
 
 	switch (opcode) {
 	case APM_CLIENT_EVENT_CMD_EOS_DONE:
 		prtd->state = Q6APM_STREAM_STOPPED;
 		break;
 	case APM_CLIENT_EVENT_DATA_WRITE_DONE:
+	        spin_lock_irqsave(&prtd->lock, flags);
 		prtd->pos += prtd->pcm_count;
+		spin_unlock_irqrestore(&prtd->lock, flags);
 		snd_pcm_period_elapsed(substream);
 		if (prtd->state == Q6APM_STREAM_RUNNING)
 			q6apm_write_async(prtd->graph, prtd->pcm_count, 0, 0, 0);
 
 		break;
 	case APM_CLIENT_EVENT_DATA_READ_DONE:
+	        spin_lock_irqsave(&prtd->lock, flags);
 		prtd->pos += prtd->pcm_count;
+		spin_unlock_irqrestore(&prtd->lock, flags);
 		snd_pcm_period_elapsed(substream);
 		if (prtd->state == Q6APM_STREAM_RUNNING)
 			q6apm_read(prtd->graph);
@@ -253,6 +260,7 @@ static int q6apm_dai_open(struct snd_soc_component *component,
 	if (prtd == NULL)
 		return -ENOMEM;
 
+	spin_lock_init(&prtd->lock);
 	prtd->substream = substream;
 	prtd->graph = q6apm_graph_open(dev, (q6apm_cb)event_handler, prtd, graph_id);
 	if (IS_ERR(prtd->graph)) {
@@ -332,11 +340,17 @@ static snd_pcm_uframes_t q6apm_dai_pointer(struct snd_soc_component *component,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct q6apm_dai_rtd *prtd = runtime->private_data;
+	snd_pcm_uframes_t ptr;
+	unsigned long flags;
 
+	spin_lock_irqsave(&prtd->lock, flags);
 	if (prtd->pos == prtd->pcm_size)
 		prtd->pos = 0;
 
-	return bytes_to_frames(runtime, prtd->pos);
+	ptr =  bytes_to_frames(runtime, prtd->pos);
+	spin_unlock_irqrestore(&prtd->lock, flags);
+
+	return ptr;
 }
 
 static int q6apm_dai_hw_params(struct snd_soc_component *component,
-- 
2.21.0

