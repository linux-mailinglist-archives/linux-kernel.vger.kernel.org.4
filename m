Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627526722CC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjARQSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjARQRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:17:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CB79EF2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:12:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B196EB81D7A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 16:12:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702BBC433D2;
        Wed, 18 Jan 2023 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674058365;
        bh=8cChsv74pYJOfcjtONuonGjh4UJndDRCDERVcmwltLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJ5KtuAXOH316tSrgSNn6b8gq5MCYj0z0J+xThfFP72otWnHh0r1VmuOApvAXoCUr
         PG1a0KG4zAl6fL6MXUTy9rJseNw+H6F24mjOf9BaROeVSCRIZ0u7Ds8RkPN+vDTUyT
         hLVgDtHV91FGhg9LcpprKNIVDAAc9tvrak0cCtVY3GzdP7ED1RbEVREzIG1s/bmEuk
         GBzzeR2QxsxddC9iLeSD9YIEN7/n+rWo0nbCj+GKMVN/Ccky+Pq/cUI2MqlT+XKJW+
         NNlyht4DtVDNa4UD2mRlpj1l4kgAkfxnITqqTkV5U7LV7J7NoruaTnsgWGm4iKhO3Z
         T/9cwCxSiavPQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ASoC: remove snd_dmaengine_pcm_config->compat_request_channel
Date:   Wed, 18 Jan 2023 17:10:49 +0100
Message-Id: <20230118161110.521504-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118161110.521504-1-arnd@kernel.org>
References: <20230118161110.521504-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The last reference to this struct member is gone, so the caller
can be removed as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/sound/dmaengine_pcm.h         | 13 ++-----------
 sound/soc/soc-generic-dmaengine-pcm.c |  3 ---
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index a497d1f81cab..9965d59ff8f0 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -93,8 +93,8 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 	struct dma_chan *chan);
 
 /*
- * Try to request the DMA channel using compat_request_channel or
- * compat_filter_fn if it couldn't be requested through devicetree.
+ * Try to request the DMA channel using compat_filter_fn if it
+ * couldn't be requested through devicetree.
  */
 #define SND_DMAENGINE_PCM_FLAG_COMPAT BIT(0)
 /*
@@ -112,8 +112,6 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
  * struct snd_dmaengine_pcm_config - Configuration data for dmaengine based PCM
  * @prepare_slave_config: Callback used to fill in the DMA slave_config for a
  *   PCM substream. Will be called from the PCM drivers hwparams callback.
- * @compat_request_channel: Callback to request a DMA channel for platforms
- *   which do not use devicetree.
  * @process: Callback used to apply processing on samples transferred from/to
  *   user space.
  * @compat_filter_fn: Will be used as the filter function when requesting a
@@ -126,18 +124,11 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
  * @pcm_hardware: snd_pcm_hardware struct to be used for the PCM.
  * @prealloc_buffer_size: Size of the preallocated audio buffer.
  *
- * Note: If both compat_request_channel and compat_filter_fn are set
- * compat_request_channel will be used to request the channel and
- * compat_filter_fn will be ignored. Otherwise the channel will be requested
- * using dma_request_channel with compat_filter_fn as the filter function.
  */
 struct snd_dmaengine_pcm_config {
 	int (*prepare_slave_config)(struct snd_pcm_substream *substream,
 			struct snd_pcm_hw_params *params,
 			struct dma_slave_config *slave_config);
-	struct dma_chan *(*compat_request_channel)(
-			struct snd_soc_pcm_runtime *rtd,
-			struct snd_pcm_substream *substream);
 	int (*process)(struct snd_pcm_substream *substream,
 		       int channel, unsigned long hwoff,
 		       void *buf, unsigned long bytes);
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 3b99f619e37e..a3d92eb645f2 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -190,9 +190,6 @@ static struct dma_chan *dmaengine_pcm_compat_request_channel(
 	if ((pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX) && pcm->chan[0])
 		return pcm->chan[0];
 
-	if (pcm->config->compat_request_channel)
-		return pcm->config->compat_request_channel(rtd, substream);
-
 	return snd_dmaengine_pcm_request_channel(pcm->config->compat_filter_fn,
 						 dma_data->filter_data);
 }
-- 
2.39.0

