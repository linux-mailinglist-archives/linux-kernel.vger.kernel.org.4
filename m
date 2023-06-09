Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4762B729D83
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241749AbjFIO4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241682AbjFIO42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:56:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B623A87
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:56:01 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f732d37d7cso18368645e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686322548; x=1688914548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivatK82mIE79m2bjB3shZCKbThxgPNsfOJBEjwu6Sbk=;
        b=g3gqEel5hZ91PR/5WW666p6143wPgKRHct1WMme18BZDzpj1ossV6woI7s33X9jido
         Ajp+7zCIcWK7Vh5GmcEekrzFbIh1m9cpANsrA3cjcqJGDzXvs+GHN3IZR4VFeNdKslbf
         3muw4ZeDeOb6EYekdgYBPdUWkzaPper537/n0PxFOzvAdZGuycHXokHOXDrXJq5pAOJy
         nbpT6TRUTWWKhabLVardlHjjd2xIbOQa0g7DfN7tkjEey/0tlC4HGFBCFCDFS1CfXDdJ
         4sizJSD5w9eJKqODGMonOLTY/tGoQNnY/WX05cDC4HjxuyNHzFc3Rrk43ZQdoAZMfJcq
         V51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322548; x=1688914548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivatK82mIE79m2bjB3shZCKbThxgPNsfOJBEjwu6Sbk=;
        b=ZtOnEH0/lxWW+QnujKGR4+VGfegs8U/bfaWf97XdVVdICvKNt2c95zA9mbHuOnov+j
         FF7FpAAgcptA1CkBgz/QCE1C8FCZbAiSDlTYqlEB6CQfD4SfxDSh7TFjhZ6dexCTp9HY
         TWF5Qauhe0521rPISvkRw38dMcVZn17+7b+7y+GmuXXYZ4oWHXccnx0tjmasmqv+6cEN
         5hPWRJOsrI/e8TSBXU5vS6uHl/ZQTGmNJNmJ5hmI2MxJpVFIoGgb3ZK/XIaoD7LvQh0Y
         thELPx4iJDSQ4TGmy0TjEfDhhtzLVmVv2lVC5tUBoVrS6aAgHpWxbKOobIVMms6rKg3p
         sZUg==
X-Gm-Message-State: AC+VfDyIA0sH1HUgiNkNJIh+Bh70t3dS/25obqJkyOW9oDavlvHEzlfE
        6bq7ADDwdcezd1UM+TEe3l6i/A==
X-Google-Smtp-Source: ACHHUZ5dWz0dRCo8oE+uEbyqJqzKGnyMC9AFlnm0/AaLeKxls87+Rx6ZuPcuzqiz8ZR1mbhPI1g80Q==
X-Received: by 2002:a05:600c:290:b0:3f7:f7d5:a07f with SMTP id 16-20020a05600c029000b003f7f7d5a07fmr1421885wmk.17.1686322548271;
        Fri, 09 Jun 2023 07:55:48 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c21-20020a05600c0ad500b003f7310a3ffasm2946632wmr.2.2023.06.09.07.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 07:55:47 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: [PATCH v2 11/11] ASoC: q6dsp: q6apm-dai: Add mmap and copy compress DAI callbacks
Date:   Fri,  9 Jun 2023 15:54:07 +0100
Message-Id: <20230609145407.18774-12-srinivas.kandagatla@linaro.org>
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

Add q6apm mmap and copy compress DAI callbacks to support compress
offload playback.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
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

