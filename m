Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556E97183F6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbjEaNyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237524AbjEaNuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:50:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7981B35B7;
        Wed, 31 May 2023 06:46:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF02A63B84;
        Wed, 31 May 2023 13:44:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530B2C433D2;
        Wed, 31 May 2023 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540674;
        bh=HVFzA5/xpPgFBqpHQHkv/BgPv5Wfc3xZi5LakHxOE1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NsiwJP7aM88UHBoohtu87dqi4Na1c3X2cA8vnZqjvhR4zq7e03oU73DXMuOq9pXsS
         suV6kEe4LqKu331f99CUGYkTge8O3nXEzliABqedoKn9WQ6H5DPaahHqOrqASRT1zr
         E/9KMvbCz0uA1Hu1go8CeGUh1b3idIdHLN5NkWKDNbGiHtX8AFALW41izTO6E83rjA
         QndQqNP22lTKZWROxG3WNETx2IySRrGIS2eBtj+u+2W6MFIDC5veIs7MngvhksUtl4
         TzNKUOYeS6Ql+eAzIaH9rFu7bxhGst5Kz4cHLChD3hFBABGkyl3ejE5KyQ2Lq67/Nb
         bntTrUuapEuKQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.10 13/21] ASoC: soc-pcm: test if a BE can be prepared
Date:   Wed, 31 May 2023 09:44:06 -0400
Message-Id: <20230531134415.3384458-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134415.3384458-1-sashal@kernel.org>
References: <20230531134415.3384458-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit e123036be377ddf628226a7c6d4f9af5efd113d3 ]

In the BE hw_params configuration, the existing code checks if any of the
existing FEs are prepared, running, paused or suspended - and skips the
configuration in those cases. This allows multiple calls of hw_params
which the ALSA state machine supports.

This check is not handled for the prepare stage, which can lead to the
same BE being prepared multiple times. This patch adds a check similar to
that of the hw_params, with the main difference being that the suspended
state is allowed: the ALSA state machine allows a transition from
suspended to prepared with hw_params skipped.

This problem was detected on Intel IPC4/SoundWire devices, where the BE
dailink .prepare stage is used to configure the SoundWire stream with a
bank switch. Multiple .prepare calls lead to conflicts with the .trigger
operation with IPC4 configurations. This problem was not detected earlier
on Intel devices, HDaudio BE dailinks detect that the link is already
prepared and skip the configuration, and for IPC3 devices there is no BE
trigger.

Link: https://github.com/thesofproject/sof/issues/7596
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com
Link: https://lore.kernel.org/r/20230517185731.487124-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/sound/soc-dpcm.h |  4 ++++
 sound/soc/soc-pcm.c      | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 0f6c50b17bba8..bd8795198a7d6 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -121,6 +121,10 @@ int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 		struct snd_soc_pcm_runtime *be, int stream);
 
+/* can this BE perform prepare */
+int snd_soc_dpcm_can_be_prepared(struct snd_soc_pcm_runtime *fe,
+				 struct snd_soc_pcm_runtime *be, int stream);
+
 /* is the current PCM operation for this FE ? */
 int snd_soc_dpcm_fe_can_update(struct snd_soc_pcm_runtime *fe, int stream);
 
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index fb874f924bbe3..e52c030bd17a2 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2332,6 +2332,9 @@ int dpcm_be_dai_prepare(struct snd_soc_pcm_runtime *fe, int stream)
 		if (!snd_soc_dpcm_be_can_update(fe, be, stream))
 			continue;
 
+		if (!snd_soc_dpcm_can_be_prepared(fe, be, stream))
+			continue;
+
 		if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_HW_PARAMS) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
 		    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND) &&
@@ -2972,3 +2975,20 @@ int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 	return snd_soc_dpcm_check_state(fe, be, stream, state, ARRAY_SIZE(state));
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_params);
+
+/*
+ * We can only prepare a BE DAI if any of it's FE are not prepared,
+ * running or paused for the specified stream direction.
+ */
+int snd_soc_dpcm_can_be_prepared(struct snd_soc_pcm_runtime *fe,
+				 struct snd_soc_pcm_runtime *be, int stream)
+{
+	const enum snd_soc_dpcm_state state[] = {
+		SND_SOC_DPCM_STATE_START,
+		SND_SOC_DPCM_STATE_PAUSED,
+		SND_SOC_DPCM_STATE_PREPARE,
+	};
+
+	return snd_soc_dpcm_check_state(fe, be, stream, state, ARRAY_SIZE(state));
+}
+EXPORT_SYMBOL_GPL(snd_soc_dpcm_can_be_prepared);
-- 
2.39.2

