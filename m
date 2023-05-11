Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7DC46FF129
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbjEKMKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbjEKMKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:10:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6E8D053
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:09:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba69d93a6b5so1966848276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 05:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683806973; x=1686398973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XPzNid5gFkEdV46hZfBaNY8C9ibiypdAE09EY9qCMiM=;
        b=FTjyNd5o/ZPhnqTxuIjaMOuIKr0bPgqlmCD27VEg29Us81kFdgS2chf/kuRZIkHZnR
         08fY6oknRR4XT12Jco+PYRooLlFiUwKKiDZRCBQC2rAHvImaGCUvDb/jzYXiy10iKLPp
         9maFIN+7EJu7YMvS+No4g4fx4Pg209K8NmepG8w1hKOFhT5TeV0/Fsyckne13qVsFN5K
         EYwhUX1k14BJtWLDQPam0cwZ6XyDsEy9JPXHiFeuxJzMWQnzAC5fLU2Dp0RYKmlkaexj
         OJrfAl4riB1rBcINA7deGx3JWhU4bkPk+77tRV+dr5AbxqZcoO/fVBjuFXo16hc/2ByL
         64VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683806973; x=1686398973;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XPzNid5gFkEdV46hZfBaNY8C9ibiypdAE09EY9qCMiM=;
        b=JFVnT8a7E94IF5zdQ1sSx5zXdVGqtfF2xLqcBbZkGO1pcH0v8L30UCdLFf5zmkg2hj
         vzaLZKeNUHIPMjV7sdblEwHMpXX9GgR28TFlWk3NwC4EerGxBGoxWtTPZwN07gtO2fo0
         h2xkgqamD5ZRsInT9g5XZviZaJBgD8/22QCaMAcvePHBKyK6iwNYvpwRJAyoy1KwgcJg
         xi/3BduDNfv5zB2J1w+PoBI9znw+q3jFzUS3LiDwMw/6Qo9OT2Y0hWXs1rwpowalQnxL
         B87BLFYmy60er60rfEZYj4rGl+ePhkR2NvxnCHChbBkR+lkRSJXBAC50Ka0661FRlPgq
         iBEw==
X-Gm-Message-State: AC+VfDwzBOLVQOtEMevoRPuzkm23y9/pnXQFKsjPZ8ftwgbUdDDp61+x
        qDysdmTX2Rxd8Vz4iv2Y5t9964lB6QaFV3y4qw==
X-Google-Smtp-Source: ACHHUZ5M7lalg3R0OTBFOw7aw1K392RqKR/D3Vgq7TGontZQbwpIRCkOfvqz8tsJVMK07+Y0NDyGiuFN0IO3Ir5NIw==
X-Received: from yixuanjiang.ntc.corp.google.com ([2401:fa00:fc:202:6c9a:64c9:7e44:6b1d])
 (user=yixuanjiang job=sendgmr) by 2002:a25:6542:0:b0:b95:4128:bff6 with SMTP
 id z63-20020a256542000000b00b954128bff6mr12771743ybb.1.1683806972993; Thu, 11
 May 2023 05:09:32 -0700 (PDT)
Date:   Thu, 11 May 2023 20:08:39 +0800
In-Reply-To: <20230511120841.2096524-1-yixuanjiang@google.com>
Mime-Version: 1.0
References: <20230511120841.2096524-1-yixuanjiang@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230511120841.2096524-5-yixuanjiang@google.com>
Subject: [PATCH 4/6] ASoC: soc-pcm: serialize BE triggers
From:   yixuanjiang <yixuanjiang@google.com>
To:     tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Yixuan Jiang <yixuanjiang@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit b2ae80663008a7662febe7d13f14ea1b2eb0cd51 ]

When more than one FE is connected to a BE, e.g. in a mixing use case,
the BE can be triggered multiple times when the FE are opened/started
concurrently. This race condition is problematic in the case of
SoundWire BE dailinks, and this is not desirable in a general
case.

This patch relies on the existing BE PCM lock, which takes atomicity into
account. The locking model assumes that all interactions start with
the FE, so that there is no deadlock between FE and BE locks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
[test, checkpatch fix and clarification of commit message by plbossart]
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20211207173745.15850-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Fixes: aa9ff6a4955f ("ASoC: soc-compress: Reposition and add pcm_mutex")
Signed-off-by: Yixuan Jiang <yixuanjiang@google.com>
Cc: stable@vger.kernel.org # 5.15+
---
 sound/soc/soc-pcm.c | 46 ++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index a9869203804e7..7903516c89a6a 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -46,12 +46,18 @@ static inline void snd_soc_dpcm_stream_lock_irq(struct snd_soc_pcm_runtime *rtd,
 	snd_pcm_stream_lock_irq(snd_soc_dpcm_get_substream(rtd, stream));
 }
 
+#define snd_soc_dpcm_stream_lock_irqsave(rtd, stream, flags) \
+	snd_pcm_stream_lock_irqsave(snd_soc_dpcm_get_substream(rtd, stream), flags)
+
 static inline void snd_soc_dpcm_stream_unlock_irq(struct snd_soc_pcm_runtime *rtd,
 						  int stream)
 {
 	snd_pcm_stream_unlock_irq(snd_soc_dpcm_get_substream(rtd, stream));
 }
 
+#define snd_soc_dpcm_stream_unlock_irqrestore(rtd, stream, flags) \
+	snd_pcm_stream_unlock_irqrestore(snd_soc_dpcm_get_substream(rtd, stream), flags)
+
 #define DPCM_MAX_BE_USERS	8
 
 static inline const char *soc_cpu_dai_name(struct snd_soc_pcm_runtime *rtd)
@@ -2090,6 +2096,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 {
 	struct snd_soc_pcm_runtime *be;
 	struct snd_soc_dpcm *dpcm;
+	unsigned long flags;
 	int ret = 0;
 
 	for_each_dpcm_be(fe, stream, dpcm) {
@@ -2098,9 +2105,11 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 		be = dpcm->be;
 		be_substream = snd_soc_dpcm_get_substream(be, stream);
 
+		snd_soc_dpcm_stream_lock_irqsave(be, stream, flags);
+
 		/* is this op for this BE ? */
 		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
-			continue;
+			goto next;
 
 		dev_dbg(be->dev, "ASoC: trigger BE %s cmd %d\n",
 			be->dai_link->name, cmd);
@@ -2110,77 +2119,80 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_RESUME:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_STOP:
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
-				continue;
+				goto next;
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
 			break;
 		case SNDRV_PCM_TRIGGER_SUSPEND:
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
-				continue;
+				goto next;
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_SUSPEND;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
-				continue;
+				goto next;
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
-				continue;
+				goto next;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
 			if (ret)
-				goto end;
+				goto next;
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
 			break;
 		}
+next:
+		snd_soc_dpcm_stream_unlock_irqrestore(be, stream, flags);
+		if (ret)
+			break;
 	}
-end:
 	if (ret < 0)
 		dev_err(fe->dev, "ASoC: %s() failed at %s (%d)\n",
 			__func__, be->dai_link->name, ret);
-- 
2.40.1.521.gf1e218fcd8-goog

