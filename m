Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B1D6722C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjARQRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjARQQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:16:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694375CE78
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 08:12:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75C5F618A9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 16:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180ECC433D2;
        Wed, 18 Jan 2023 16:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674058309;
        bh=hfA2eXgm6COXrjgq0eXTI7FELNoNzfagIjCDGXpAipY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ivc0SazkaMpDaLRHVArm23f6+rwNgRkiIfG9MwhAW7qvfmEaAYeDraa6/XCaDxrJ1
         s42Fqalv3DxyTCHjVmgR8W32HF/qP6/Dx61YFXpEaOP8tn2Gr1Fh7eHREZwxxm7K54
         fZy5Z9xLEZA+VzFAFTeaIIvCY0qkmPpqf6N0sNFbxZhX6PWWIg3LNKLNnP1nLvsw+N
         Zd76G5DoooNgMXU4IQNxTLAIUJwHq/J4RYM3kl2VbBPz7kM5ZNGjaeLYwubohztVLT
         sjXcrSSe5mXmWxmBmUeeg9JSPgB99Eonvxw15xGm4MVLv9Lpi5P+Fa6h+OZ0JZQ6ac
         d0Gdcn5OqDrYw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Andreas Pape <apape@de.adit-jv.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ASoC: pxa: remove snd_dmaengine_pcm_open_request_chan()
Date:   Wed, 18 Jan 2023 17:10:46 +0100
Message-Id: <20230118161110.521504-2-arnd@kernel.org>
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

The last caller was removed, so there is no longer a need for
this function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/sound/dmaengine_pcm.h |  2 --
 sound/core/pcm_dmaengine.c    | 21 ---------------------
 2 files changed, 23 deletions(-)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 2df54cf02cb3..a497d1f81cab 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -37,8 +37,6 @@ int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 	struct dma_chan *chan);
 int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream);
 
-int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
-	dma_filter_fn filter_fn, void *filter_data);
 int snd_dmaengine_pcm_close_release_chan(struct snd_pcm_substream *substream);
 
 struct dma_chan *snd_dmaengine_pcm_request_channel(dma_filter_fn filter_fn,
diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 494ec0c207fa..9f4120f020d8 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -328,27 +328,6 @@ int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open);
 
-/**
- * snd_dmaengine_pcm_open_request_chan - Open a dmaengine based PCM substream and request channel
- * @substream: PCM substream
- * @filter_fn: Filter function used to request the DMA channel
- * @filter_data: Data passed to the DMA filter function
- *
- * This function will request a DMA channel using the passed filter function and
- * data. The function should usually be called from the pcm open callback. Note
- * that this function will use private_data field of the substream's runtime. So
- * it is not available to your pcm driver implementation.
- *
- * Return: 0 on success, a negative error code otherwise
- */
-int snd_dmaengine_pcm_open_request_chan(struct snd_pcm_substream *substream,
-	dma_filter_fn filter_fn, void *filter_data)
-{
-	return snd_dmaengine_pcm_open(substream,
-		    snd_dmaengine_pcm_request_channel(filter_fn, filter_data));
-}
-EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open_request_chan);
-
 /**
  * snd_dmaengine_pcm_close - Close a dmaengine based PCM substream
  * @substream: PCM substream
-- 
2.39.0

