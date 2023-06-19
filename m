Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10EAF7351D0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjFSKRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjFSKRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:17:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6859A10D2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:17:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-311275efaf8so1929119f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687169829; x=1689761829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7txYCxaVdCIzUmWm+LpJfmUPkElgoh9gHNmxHigBQcU=;
        b=nRWtKAtYtZwQ37U5rmUB4JNSYm73slYhfU2qV3poD/fHYVfbfqiULogkJ5BqgcNKyl
         yXBVtAri2IGb8PQkNptDRAnrAXe/9VD9FoT0zsWCTvzfOA8wc3qujmcHOfgn2SLYmvUE
         KgkJUqkq2+EnNSKjM5ofw35CVs6/n2NL42/2VWHowCJ6dEMGQY8ONpa0D7RNLj6xXFTu
         jP0a5dxRzZJUd2kFRUUkBVQyIr3gfjJif1S3pCgT1UIaFR/DlgSnKEpqnESDergK59S9
         sSZSH2JX2+HBxGpuw6THiYPOn6YYPD/MeLWR2x5Pbkxbiw7Ax8BrYeAoVH5OUK3DKvk9
         JPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687169829; x=1689761829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7txYCxaVdCIzUmWm+LpJfmUPkElgoh9gHNmxHigBQcU=;
        b=CCbYWngYBHlij3mTRonYZIoEutj2aE1AS+XEViJzGAMOxGesYwxUjLjyVUrtG6Hbpz
         rP4cGAI6Qy5+kDUPQWLVOg2URC0h8dOoEpYmvcMHmUMxOhtde/IbpxJ3+T0QXOzOZ1Pe
         zRy0M1ZCPpRHdQRMTtKxdefwDIy3snUt0z2YZD7M+nneU46XOcv/ds+zY1DaWygHfOeU
         nb2Wxaa2CRzB9H6wRELLFlExBOKdN7LY5SsCYOawGXBxvTnkT/cwMhHHyd1QZ8p1Tl95
         QMZ9OjO3xZxXzzoop6DyO6gEHQdEPIqa2SZoxHBVToG22r5dYVNcNgJ9ekNvFZd9X8bt
         Gs3Q==
X-Gm-Message-State: AC+VfDwd8qQ2SG5e3h05h9dhxmH0qjfaSHPzG33Ka37TdYsd82zhDxI3
        lfYK57pB3sCixgYDYlclsd4kYw==
X-Google-Smtp-Source: ACHHUZ62UqNE78KOzcO6WZERXpwNqPBVI+AS7V7RFiGFsoO6+/Yt0jcotfsbe2XHpKTG089aTTCDeg==
X-Received: by 2002:a5d:6e42:0:b0:306:31fb:1c3e with SMTP id j2-20020a5d6e42000000b0030631fb1c3emr5220830wrz.26.1687169828987;
        Mon, 19 Jun 2023 03:17:08 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm31146922wrv.108.2023.06.19.03.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:17:08 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v3 11/11] ASoC: q6dsp: q6apm-dai: Add mmap and copy compress DAI callbacks
Date:   Mon, 19 Jun 2023 11:16:53 +0100
Message-Id: <20230619101653.9750-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230619101653.9750-1-srinivas.kandagatla@linaro.org>
References: <20230619101653.9750-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
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

Add q6apm mmap and copy compress DAI callbacks to support compress
offload playback.

Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 81 ++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index c67147e5388b..5eb0b864c740 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -737,6 +737,85 @@ static int q6apm_dai_compr_set_metadata(struct snd_soc_component *component,
 	return ret;
 }
 
+static int q6apm_dai_compr_mmap(struct snd_soc_component *component,
+				struct snd_compr_stream *stream,
+				struct vm_area_struct *vma)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6apm_dai_rtd *prtd = runtime->private_data;
+	struct device *dev = component->dev;
+
+	return dma_mmap_coherent(dev, vma, prtd->dma_buffer.area, prtd->dma_buffer.addr,
+				 prtd->dma_buffer.bytes);
+}
+
+static int q6apm_compr_copy(struct snd_soc_component *component,
+			    struct snd_compr_stream *stream, char __user *buf,
+			    size_t count)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6apm_dai_rtd *prtd = runtime->private_data;
+	void *dstn;
+	unsigned long flags;
+	size_t copy;
+	u32 wflags = 0;
+	u32 app_pointer;
+	u32 bytes_received;
+	uint32_t bytes_to_write;
+	int avail, bytes_in_flight = 0;
+
+	bytes_received = prtd->bytes_received;
+
+	/**
+	 * Make sure that next track data pointer is aligned at 32 bit boundary
+	 * This is a Mandatory requirement from DSP data buffers alignment
+	 */
+	if (prtd->next_track)
+		bytes_received = ALIGN(prtd->bytes_received, prtd->pcm_count);
+
+	app_pointer = bytes_received/prtd->pcm_size;
+	app_pointer = bytes_received -  (app_pointer * prtd->pcm_size);
+	dstn = prtd->dma_buffer.area + app_pointer;
+
+	if (count < prtd->pcm_size - app_pointer) {
+		if (copy_from_user(dstn, buf, count))
+			return -EFAULT;
+	} else {
+		copy = prtd->pcm_size - app_pointer;
+		if (copy_from_user(dstn, buf, copy))
+			return -EFAULT;
+		if (copy_from_user(prtd->dma_buffer.area, buf + copy, count - copy))
+			return -EFAULT;
+	}
+
+	spin_lock_irqsave(&prtd->lock, flags);
+	bytes_in_flight = prtd->bytes_received - prtd->copied_total;
+
+	if (prtd->next_track) {
+		prtd->next_track = false;
+		prtd->copied_total = ALIGN(prtd->copied_total, prtd->pcm_count);
+		prtd->bytes_sent = ALIGN(prtd->bytes_sent, prtd->pcm_count);
+	}
+
+	prtd->bytes_received = bytes_received + count;
+
+	/* Kick off the data to dsp if its starving!! */
+	if (prtd->state == Q6APM_STREAM_RUNNING && (bytes_in_flight == 0)) {
+		bytes_to_write = prtd->pcm_count;
+		avail = prtd->bytes_received - prtd->bytes_sent;
+
+		if (avail < prtd->pcm_count)
+			bytes_to_write = avail;
+
+		q6apm_write_async(prtd->graph, bytes_to_write, 0, 0, wflags);
+		prtd->bytes_sent += bytes_to_write;
+	}
+
+	spin_unlock_irqrestore(&prtd->lock, flags);
+
+	return count;
+}
+
 static const struct snd_compress_ops q6apm_dai_compress_ops = {
 	.open		= q6apm_dai_compr_open,
 	.free		= q6apm_dai_compr_free,
@@ -747,6 +826,8 @@ static const struct snd_compress_ops q6apm_dai_compress_ops = {
 	.ack		= q6apm_dai_compr_ack,
 	.set_params	= q6apm_dai_compr_set_params,
 	.set_metadata	= q6apm_dai_compr_set_metadata,
+	.mmap		= q6apm_dai_compr_mmap,
+	.copy		= q6apm_compr_copy,
 };
 
 static const struct snd_soc_component_driver q6apm_fe_dai_component = {
-- 
2.21.0

