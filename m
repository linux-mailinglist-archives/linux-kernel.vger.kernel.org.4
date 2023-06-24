Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B0D73CBF1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 19:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjFXRAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 13:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjFXRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 13:00:09 -0400
Received: from mail.horus.com (mail.horus.com [78.46.148.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD37313E
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 10:00:07 -0700 (PDT)
Received: from [192.168.1.22] (193-81-115-8.adsl.highway.telekom.at [193.81.115.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.horus.com (Postfix) with ESMTPSA id 4DDEB640B6;
        Sat, 24 Jun 2023 18:52:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=horus.com;
        s=20180324; t=1687625547;
        bh=yKLKHJ/8mLJlQ9DofIA55oqKk8gNefn90/tKRkXoatA=;
        h=From:To:Cc:Subject:Date:From;
        b=ubznO/wocpWTQ6NvPMKjHd3Fdh0GEFsRWU0PaSuZ4n5XJDHLAW+8A6xTO1x+FsL7x
         RggeXj/8TEaB7TUwarYSgS/3cr7BRY5k72tE2puUY/QNMLG/a4nAiB6skJGaG1tnhU
         SL7HZSdTk9yR+CAqas2xJpuaPDD+w4N9r0GfKqUg=
Received: by camel3.lan (Postfix, from userid 1000)
        id B8ACA540544; Sat, 24 Jun 2023 18:52:26 +0200 (CEST)
From:   Matthias Reichl <hias@horus.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Matthias Reichl <hias@horus.com>,
        Dom Cobley <popcornmix@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: pcm: fix ELD constraints for (E)AC3, DTS(-HD) and MLP formats
Date:   Sat, 24 Jun 2023 18:52:16 +0200
Message-Id: <20230624165216.5719-1-hias@horus.com>
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

The SADs of compressed formats contain the channel and sample rate
info of the audio data inside the compressed stream, but when
building constraints we must use the rates and channels used to
transport the compressed streams.

eg 48kHz 6ch EAC3 needs to be transmitted as a 2ch 192kHz stream.

This patch fixes the constraints for the common AC3 and DTS formats,
the constraints for the less common MPEG, DSD etc formats are copied
directly from the info in the SADs as before as I don't have the specs
and equipment to test those.

Signed-off-by: Matthias Reichl <hias@horus.com>
---
 sound/core/pcm_drm_eld.c | 73 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_drm_eld.c b/sound/core/pcm_drm_eld.c
index 4b5faae5d16e5..07075071972dd 100644
--- a/sound/core/pcm_drm_eld.c
+++ b/sound/core/pcm_drm_eld.c
@@ -2,11 +2,25 @@
 /*
  *  PCM DRM helpers
  */
+#include <linux/bitfield.h>
 #include <linux/export.h>
+#include <linux/hdmi.h>
 #include <drm/drm_edid.h>
 #include <sound/pcm.h>
 #include <sound/pcm_drm_eld.h>
 
+#define SAD0_CHANNELS_MASK	GENMASK(2, 0) /* max number of channels - 1 */
+#define SAD0_FORMAT_MASK	GENMASK(6, 3) /* audio format */
+
+#define SAD1_RATE_MASK		GENMASK(6, 0) /* bitfield of supported rates */
+#define SAD1_RATE_32000_MASK	BIT(0)
+#define SAD1_RATE_44100_MASK	BIT(1)
+#define SAD1_RATE_48000_MASK	BIT(2)
+#define SAD1_RATE_88200_MASK	BIT(3)
+#define SAD1_RATE_96000_MASK	BIT(4)
+#define SAD1_RATE_176400_MASK	BIT(5)
+#define SAD1_RATE_192000_MASK	BIT(6)
+
 static const unsigned int eld_rates[] = {
 	32000,
 	44100,
@@ -17,9 +31,62 @@ static const unsigned int eld_rates[] = {
 	192000,
 };
 
+static unsigned int map_rate_families(const u8 *sad,
+				      unsigned int mask_32000,
+				      unsigned int mask_44100,
+				      unsigned int mask_48000)
+{
+	unsigned int rate_mask = 0;
+
+	if (sad[1] & SAD1_RATE_32000_MASK)
+		rate_mask |= mask_32000;
+	if (sad[1] & (SAD1_RATE_44100_MASK | SAD1_RATE_88200_MASK | SAD1_RATE_176400_MASK))
+		rate_mask |= mask_44100;
+	if (sad[1] & (SAD1_RATE_48000_MASK | SAD1_RATE_96000_MASK | SAD1_RATE_192000_MASK))
+		rate_mask |= mask_48000;
+	return rate_mask;
+}
+
+static unsigned int sad_rate_mask(const u8 *sad)
+{
+	switch (FIELD_GET(SAD0_FORMAT_MASK, sad[0])) {
+	case HDMI_AUDIO_CODING_TYPE_PCM:
+		return sad[1] & SAD1_RATE_MASK;
+	case HDMI_AUDIO_CODING_TYPE_AC3:
+	case HDMI_AUDIO_CODING_TYPE_DTS:
+		return map_rate_families(sad,
+					 SAD1_RATE_32000_MASK,
+					 SAD1_RATE_44100_MASK,
+					 SAD1_RATE_48000_MASK);
+	case HDMI_AUDIO_CODING_TYPE_EAC3:
+	case HDMI_AUDIO_CODING_TYPE_DTS_HD:
+	case HDMI_AUDIO_CODING_TYPE_MLP:
+		return map_rate_families(sad,
+					 0,
+					 SAD1_RATE_176400_MASK,
+					 SAD1_RATE_192000_MASK);
+	default:
+		/* TODO adjust for other compressed formats as well */
+		return sad[1] & SAD1_RATE_MASK;
+	}
+}
+
 static unsigned int sad_max_channels(const u8 *sad)
 {
-	return 1 + (sad[0] & 7);
+	switch (FIELD_GET(SAD0_FORMAT_MASK, sad[0])) {
+	case HDMI_AUDIO_CODING_TYPE_PCM:
+		return 1 + FIELD_GET(SAD0_CHANNELS_MASK, sad[0]);
+	case HDMI_AUDIO_CODING_TYPE_AC3:
+	case HDMI_AUDIO_CODING_TYPE_DTS:
+	case HDMI_AUDIO_CODING_TYPE_EAC3:
+		return 2;
+	case HDMI_AUDIO_CODING_TYPE_DTS_HD:
+	case HDMI_AUDIO_CODING_TYPE_MLP:
+		return 8;
+	default:
+		/* TODO adjust for other compressed formats as well */
+		return 1 + FIELD_GET(SAD0_CHANNELS_MASK, sad[0]);
+	}
 }
 
 static int eld_limit_rates(struct snd_pcm_hw_params *params,
@@ -42,7 +109,7 @@ static int eld_limit_rates(struct snd_pcm_hw_params *params,
 			 * requested number of channels.
 			 */
 			if (c->min <= max_channels)
-				rate_mask |= sad[1];
+				rate_mask |= sad_rate_mask(sad);
 		}
 	}
 
@@ -70,7 +137,7 @@ static int eld_limit_channels(struct snd_pcm_hw_params *params,
 				rate_mask |= BIT(i);
 
 		for (i = drm_eld_sad_count(eld); i > 0; i--, sad += 3)
-			if (rate_mask & sad[1])
+			if (rate_mask & sad_rate_mask(sad))
 				t.max = max(t.max, sad_max_channels(sad));
 	}
 
-- 
2.39.2

