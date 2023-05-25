Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255B87116B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243617AbjEYTBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243949AbjEYTAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:00:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF5F619F;
        Thu, 25 May 2023 11:49:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34DAC649BB;
        Thu, 25 May 2023 18:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C91C43322;
        Thu, 25 May 2023 18:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040372;
        bh=+KXX0pkDVrwxls1xANPzrragmwSQkYYEJj7K5lltQSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZWd6FUSsNqYisca1kGjMd2YvoIVxfPNAvRUSA14tzga8Itxa1S2CBSjDHdJBM45c
         cVQzAx3t/QuMwx9TYmur+FPAtIOaHHwJGWePfslmx4/kWIHevwJqHE/1G8eScQ+Zjr
         bX2BnqFWNumwPJc43QfmhWstw3FCANdFk45+m1Nh0E+HG+DUJMAwXmddJwv5AjnwAk
         a22GtCQVtkFIhtjHSWq+WFU1rVbOCmcK/9MYbQF5dSMWOSzV77Py/QUu3nMAAr1sZ7
         ehOOXOGNX6o61E0UKSZZED7S5CFpEJkw9BAWwD6/3wM/oea0J8gOY+HFd1M8ddU9Fs
         vz2BB3jPcmmAw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.14 18/20] ALSA: oss: avoid missing-prototype warnings
Date:   Thu, 25 May 2023 14:45:14 -0400
Message-Id: <20230525184520.2004878-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184520.2004878-1-sashal@kernel.org>
References: <20230525184520.2004878-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 040b5a046a9e18098580d3ccd029e2318fca7859 ]

Two functions are defined and used in pcm_oss.c but also optionally
used from io.c, with an optional prototype. If CONFIG_SND_PCM_OSS_PLUGINS
is disabled, this causes a warning as the functions are not static
and have no prototype:

sound/core/oss/pcm_oss.c:1235:19: error: no previous prototype for 'snd_pcm_oss_write3' [-Werror=missing-prototypes]
sound/core/oss/pcm_oss.c:1266:19: error: no previous prototype for 'snd_pcm_oss_read3' [-Werror=missing-prototypes]

Avoid this by making the prototypes unconditional.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20230516195046.550584-2-arnd@kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/oss/pcm_plugin.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/core/oss/pcm_plugin.h b/sound/core/oss/pcm_plugin.h
index c9cd29d86efda..64a2057aa0610 100644
--- a/sound/core/oss/pcm_plugin.h
+++ b/sound/core/oss/pcm_plugin.h
@@ -156,6 +156,14 @@ int snd_pcm_area_copy(const struct snd_pcm_channel_area *src_channel,
 
 void *snd_pcm_plug_buf_alloc(struct snd_pcm_substream *plug, snd_pcm_uframes_t size);
 void snd_pcm_plug_buf_unlock(struct snd_pcm_substream *plug, void *ptr);
+#else
+
+static inline snd_pcm_sframes_t snd_pcm_plug_client_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t drv_size) { return drv_size; }
+static inline snd_pcm_sframes_t snd_pcm_plug_slave_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t clt_size) { return clt_size; }
+static inline int snd_pcm_plug_slave_format(int format, const struct snd_mask *format_mask) { return format; }
+
+#endif
+
 snd_pcm_sframes_t snd_pcm_oss_write3(struct snd_pcm_substream *substream,
 				     const char *ptr, snd_pcm_uframes_t size,
 				     int in_kernel);
@@ -166,14 +174,6 @@ snd_pcm_sframes_t snd_pcm_oss_writev3(struct snd_pcm_substream *substream,
 snd_pcm_sframes_t snd_pcm_oss_readv3(struct snd_pcm_substream *substream,
 				     void **bufs, snd_pcm_uframes_t frames);
 
-#else
-
-static inline snd_pcm_sframes_t snd_pcm_plug_client_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t drv_size) { return drv_size; }
-static inline snd_pcm_sframes_t snd_pcm_plug_slave_size(struct snd_pcm_substream *handle, snd_pcm_uframes_t clt_size) { return clt_size; }
-static inline int snd_pcm_plug_slave_format(int format, const struct snd_mask *format_mask) { return format; }
-
-#endif
-
 #ifdef PLUGIN_DEBUG
 #define pdprintf(fmt, args...) printk(KERN_DEBUG "plugin: " fmt, ##args)
 #else
-- 
2.39.2

