Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5522C73CBF0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 19:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbjFXRAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 13:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjFXRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 13:00:09 -0400
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 24 Jun 2023 10:00:07 PDT
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62B6B8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 10:00:07 -0700 (PDT)
Received: from [192.168.1.22] (193-81-115-8.adsl.highway.telekom.at [193.81.115.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by mail.horus.com (Postfix) with ESMTPSA id 5C0CE640B9;
        Sat, 24 Jun 2023 18:52:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1687625556;
        bh=WtkqfvRALn1bU+9oyk67tSfwogR+x0hk//0QW6Ye3lc=;
        h=From:To:Cc:Subject:Date:From;
        b=CyKtLNmVn7OgpUcXinRA7sKPvKmk80wk/j+yYdnysvYVXysd8qyPplADzEdgU2Qse
         nv91Xo/rWj5dACyq9YH/flA6/cyG9e8tbiHaIZon8SkpYBuKsMVZsIEO+EyV8Nqxdc
         Fu2jTJcRkZgXkmkzktgx25ELQ9r9RPWZbwTcYft8=
Received: by camel3.lan (Postfix, from userid 1000)
        id 047F8540544; Sat, 24 Jun 2023 18:52:35 +0200 (CEST)
From:   Matthias Reichl <hias@horus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Matthias Reichl <hias@horus.com>,
        Dom Cobley <popcornmix@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: hdmi-codec: fix channel info for compressed formats
Date:   Sat, 24 Jun 2023 18:52:32 +0200
Message-Id: <20230624165232.5751-1-hias@horus.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to CTA 861 the channel/speaker allocation info in the
audio infoframe only applies to uncompressed (PCM) audio streams.

The channel count info should indicate the number of channels
in the transmitted audio, which usually won't match the number of
channels used to transmit the compressed bitstream.

Some devices (eg some Sony TVs) will refuse to decode compressed
audio if these values are not set correctly.

To fix this we can simply set the channel count to 0 (which means
"refer to stream header") and set the channel/speaker allocation to 0
as well (which would mean stereo FL/FR for PCM, a safe value all sinks
will support) when transmitting compressed audio.

Signed-off-by: Matthias Reichl <hias@horus.com>
---
 sound/soc/codecs/hdmi-codec.c | 36 +++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 6d980fbc42077..d21f69f053422 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -495,31 +495,43 @@ static int hdmi_codec_fill_codec_params(struct snd_soc_dai *dai,
 					struct hdmi_codec_params *hp)
 {
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
-	int idx;
-
-	/* Select a channel allocation that matches with ELD and pcm channels */
-	idx = hdmi_codec_get_ch_alloc_table_idx(hcp, channels);
-	if (idx < 0) {
-		dev_err(dai->dev, "Not able to map channels to speakers (%d)\n",
-			idx);
-		hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
-		return idx;
+	int idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
+	u8 ca_id = 0;
+	bool pcm_audio = !(hcp->iec_status[0] & IEC958_AES0_NONAUDIO);
+
+	if (pcm_audio) {
+		/* Select a channel allocation that matches with ELD and pcm channels */
+		idx = hdmi_codec_get_ch_alloc_table_idx(hcp, channels);
+
+		if (idx < 0) {
+			dev_err(dai->dev, "Not able to map channels to speakers (%d)\n",
+				idx);
+			hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
+			return idx;
+		}
+
+		ca_id = hdmi_codec_channel_alloc[idx].ca_id;
 	}
 
 	memset(hp, 0, sizeof(*hp));
 
 	hdmi_audio_infoframe_init(&hp->cea);
-	hp->cea.channels = channels;
+
+	if (pcm_audio)
+		hp->cea.channels = channels;
+	else
+		hp->cea.channels = 0;
+
 	hp->cea.coding_type = HDMI_AUDIO_CODING_TYPE_STREAM;
 	hp->cea.sample_size = HDMI_AUDIO_SAMPLE_SIZE_STREAM;
 	hp->cea.sample_frequency = HDMI_AUDIO_SAMPLE_FREQUENCY_STREAM;
-	hp->cea.channel_allocation = hdmi_codec_channel_alloc[idx].ca_id;
+	hp->cea.channel_allocation = ca_id;
 
 	hp->sample_width = sample_width;
 	hp->sample_rate = sample_rate;
 	hp->channels = channels;
 
-	hcp->chmap_idx = hdmi_codec_channel_alloc[idx].ca_id;
+	hcp->chmap_idx = idx;
 
 	return 0;
 }
-- 
2.39.2

