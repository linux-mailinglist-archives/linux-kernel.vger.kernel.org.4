Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175207351CA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjFSKR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjFSKRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:17:13 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2410E42
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:17:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30fcda210cfso2969050f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687169824; x=1689761824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMcEeKE/zt6hoVJVRWuQqq+48i5b+sqdr7X7eIAAcGg=;
        b=QDdlGZ1aLNOvrp+Kp76+3dNFfPuDAD7U4F+Ntjz4V6auxuVtZVZm3cqdvhGqEYMEp4
         N70dxOuyIG0/CAWdC1epI10DAbqIb6UcDPPauJVaRS5+LnWUCnIzdJli5z6OeMdzAyVp
         rhVgXHkvNdh/2Sr0Hv0WwvHKeGAGTtPZ0kOmPTu8ku83aMbhJTexKQMtlNQZiPhRX+mW
         qTIK5Sgy8SvACZB8OFkHDjeZ2ypI8I6nU6bLFyi+7svuvAzZQbyYdev0N31s1ajuafR+
         hMbig0G8q/Eo0CaXjBJyj8Gm0PAfcVkJjcOMjVoyo3cTWK0bdTxdEvplFEVVYp4Fx0d8
         PkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687169824; x=1689761824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMcEeKE/zt6hoVJVRWuQqq+48i5b+sqdr7X7eIAAcGg=;
        b=f2oHexjtDjDBBkK+MxLQgcWl/AGvTvGelEasAhZBw9xTcnqCusDHLWraIvP0owqJuy
         b9eOt0wNmxf6xHBT0Nq3a9JuRf04oUK5+80p0LobkKmM2mDx2PVUKw/PF/i5ICt5+S9X
         Zu0cUMRKJWf1APcNSWKI/GgPQ4nihml9k1yQOS7yd6cX5yGa18aG7YkD3lNIoNidZaFi
         yn1FxQZVw3EaP4zWL1igT975Tu7Sy4xrePjGZns+RerGSjeXjN1xNxfHCHef4+tHr8kk
         /gsLdzicxlFvcNOw2plTyWn/lp5cq6/Y5L5/M4V36iaIZUTy+F2sYaBfwEKIS3fTN4dS
         Am2g==
X-Gm-Message-State: AC+VfDydosBdgn1VX6XMAhuebCRxKOiANuYcOLNQ+hWfhsPzpjvxb1j0
        I7dX10cad6qFyH9mKOE7CE0oog==
X-Google-Smtp-Source: ACHHUZ4xptSZCqArQdHo4ETHPsMwGa11iEWiGEWbrCSQCS4eIneS6KOqCdUhqKZQz3n5Oo6jK1rUNw==
X-Received: by 2002:a5d:63c5:0:b0:30f:cf93:4bb8 with SMTP id c5-20020a5d63c5000000b0030fcf934bb8mr6601009wrw.57.1687169824292;
        Mon, 19 Jun 2023 03:17:04 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d5282000000b002fae7408544sm31146922wrv.108.2023.06.19.03.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:17:03 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v3 07/11] ASoC: q6dsp: q6apm-dai: Add open/free compress DAI callbacks
Date:   Mon, 19 Jun 2023 11:16:49 +0100
Message-Id: <20230619101653.9750-8-srinivas.kandagatla@linaro.org>
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

Add q6apm open and free compress DAI callbacks to support compress
offload playback.
Include compress event handler callback also.

Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 136 +++++++++++++++++++++++++++++++
 sound/soc/qcom/qdsp6/q6apm.h     |   1 +
 2 files changed, 137 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 9fff41ee98eb..32df5db014d3 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -28,6 +28,8 @@
 #define CAPTURE_MIN_PERIOD_SIZE		320
 #define BUFFER_BYTES_MAX (PLAYBACK_MAX_NUM_PERIODS * PLAYBACK_MAX_PERIOD_SIZE)
 #define BUFFER_BYTES_MIN (PLAYBACK_MIN_NUM_PERIODS * PLAYBACK_MIN_PERIOD_SIZE)
+#define COMPR_PLAYBACK_MAX_FRAGMENT_SIZE (128 * 1024)
+#define COMPR_PLAYBACK_MAX_NUM_FRAGMENTS (16 * 4)
 #define SID_MASK_DEFAULT	0xF
 
 enum stream_state {
@@ -55,6 +57,7 @@ struct q6apm_dai_rtd {
 	enum stream_state state;
 	struct q6apm_graph *graph;
 	spinlock_t lock;
+	bool notify_on_drain;
 };
 
 struct q6apm_dai_data {
@@ -132,6 +135,69 @@ static void event_handler(uint32_t opcode, uint32_t token, uint32_t *payload, vo
 	}
 }
 
+static void event_handler_compr(uint32_t opcode, uint32_t token,
+				uint32_t *payload, void *priv)
+{
+	struct q6apm_dai_rtd *prtd = priv;
+	struct snd_compr_stream *substream = prtd->cstream;
+	unsigned long flags;
+	uint32_t wflags = 0;
+	uint64_t avail;
+	uint32_t bytes_written, bytes_to_write;
+	bool is_last_buffer = false;
+
+	switch (opcode) {
+	case APM_CLIENT_EVENT_CMD_EOS_DONE:
+		spin_lock_irqsave(&prtd->lock, flags);
+		if (prtd->notify_on_drain) {
+			snd_compr_drain_notify(prtd->cstream);
+			prtd->notify_on_drain = false;
+		} else {
+			prtd->state = Q6APM_STREAM_STOPPED;
+		}
+		spin_unlock_irqrestore(&prtd->lock, flags);
+		break;
+	case APM_CLIENT_EVENT_DATA_WRITE_DONE:
+		spin_lock_irqsave(&prtd->lock, flags);
+		bytes_written = token >> APM_WRITE_TOKEN_LEN_SHIFT;
+		prtd->copied_total += bytes_written;
+		snd_compr_fragment_elapsed(substream);
+
+		if (prtd->state != Q6APM_STREAM_RUNNING) {
+			spin_unlock_irqrestore(&prtd->lock, flags);
+			break;
+		}
+
+		avail = prtd->bytes_received - prtd->bytes_sent;
+
+		if (avail > prtd->pcm_count) {
+			bytes_to_write = prtd->pcm_count;
+		} else {
+			if (substream->partial_drain || prtd->notify_on_drain)
+				is_last_buffer = true;
+			bytes_to_write = avail;
+		}
+
+		if (bytes_to_write) {
+			if (substream->partial_drain && is_last_buffer)
+				wflags |= APM_LAST_BUFFER_FLAG;
+
+			q6apm_write_async(prtd->graph,
+						bytes_to_write, 0, 0, wflags);
+
+			prtd->bytes_sent += bytes_to_write;
+
+			if (prtd->notify_on_drain && is_last_buffer)
+				audioreach_shared_memory_send_eos(prtd->graph);
+		}
+
+		spin_unlock_irqrestore(&prtd->lock, flags);
+		break;
+	default:
+		break;
+	}
+}
+
 static int q6apm_dai_prepare(struct snd_soc_component *component,
 			     struct snd_pcm_substream *substream)
 {
@@ -387,6 +453,75 @@ static int q6apm_dai_pcm_new(struct snd_soc_component *component, struct snd_soc
 	return snd_pcm_set_fixed_buffer_all(rtd->pcm, SNDRV_DMA_TYPE_DEV, component->dev, size);
 }
 
+static int q6apm_dai_compr_open(struct snd_soc_component *component,
+				struct snd_compr_stream *stream)
+{
+	struct snd_soc_pcm_runtime *rtd = stream->private_data;
+	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6apm_dai_rtd *prtd;
+	struct q6apm_dai_data *pdata;
+	struct device *dev = component->dev;
+	int ret, size;
+	int graph_id;
+
+	graph_id = cpu_dai->driver->id;
+	pdata = snd_soc_component_get_drvdata(component);
+	if (!pdata)
+		return -EINVAL;
+
+	prtd = kzalloc(sizeof(*prtd), GFP_KERNEL);
+	if (prtd == NULL)
+		return -ENOMEM;
+
+	prtd->cstream = stream;
+	prtd->graph = q6apm_graph_open(dev, (q6apm_cb)event_handler_compr, prtd, graph_id);
+	if (IS_ERR(prtd->graph)) {
+		ret = PTR_ERR(prtd->graph);
+		kfree(prtd);
+		return ret;
+	}
+
+	runtime->private_data = prtd;
+	runtime->dma_bytes = BUFFER_BYTES_MAX;
+	size = COMPR_PLAYBACK_MAX_FRAGMENT_SIZE * COMPR_PLAYBACK_MAX_NUM_FRAGMENTS;
+	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, dev, size, &prtd->dma_buffer);
+	if (ret)
+		return ret;
+
+	if (pdata->sid < 0)
+		prtd->phys = prtd->dma_buffer.addr;
+	else
+		prtd->phys = prtd->dma_buffer.addr | (pdata->sid << 32);
+
+	snd_compr_set_runtime_buffer(stream, &prtd->dma_buffer);
+	spin_lock_init(&prtd->lock);
+
+	q6apm_enable_compress_module(dev, prtd->graph, true);
+	return 0;
+}
+
+static int q6apm_dai_compr_free(struct snd_soc_component *component,
+				struct snd_compr_stream *stream)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6apm_dai_rtd *prtd = runtime->private_data;
+
+	q6apm_graph_stop(prtd->graph);
+	q6apm_unmap_memory_regions(prtd->graph, SNDRV_PCM_STREAM_PLAYBACK);
+	q6apm_graph_close(prtd->graph);
+	snd_dma_free_pages(&prtd->dma_buffer);
+	prtd->graph = NULL;
+	kfree(prtd);
+	runtime->private_data = NULL;
+
+	return 0;
+}
+static const struct snd_compress_ops q6apm_dai_compress_ops = {
+	.open		= q6apm_dai_compr_open,
+	.free		= q6apm_dai_compr_free,
+};
+
 static const struct snd_soc_component_driver q6apm_fe_dai_component = {
 	.name		= DRV_NAME,
 	.open		= q6apm_dai_open,
@@ -396,6 +531,7 @@ static const struct snd_soc_component_driver q6apm_fe_dai_component = {
 	.hw_params	= q6apm_dai_hw_params,
 	.pointer	= q6apm_dai_pointer,
 	.trigger	= q6apm_dai_trigger,
+	.compress_ops	= &q6apm_dai_compress_ops,
 };
 
 static int q6apm_dai_probe(struct platform_device *pdev)
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index 87d67faf5f1a..d187d88c0a8c 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -45,6 +45,7 @@
 #define APM_WRITE_TOKEN_LEN_SHIFT              16
 
 #define APM_MAX_SESSIONS			8
+#define APM_LAST_BUFFER_FLAG			BIT(30)
 
 struct q6apm {
 	struct device *dev;
-- 
2.21.0

