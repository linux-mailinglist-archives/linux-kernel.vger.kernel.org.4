Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2918060C061
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJYBE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiJYBDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:03:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAFB5F62
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:03:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F19861632
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5C2C433D7;
        Tue, 25 Oct 2022 00:03:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WD+MrOqf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666656209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mM/8UIZQ6LYQtk+8TLtw6u3mXtNCLZf8tJ3WoqaQvII=;
        b=WD+MrOqf7XKVcr3T+DQ1LWtnfaYDnq4liAnsPnLb/StyoFw+C2DjcpJ+lRslpib/E/4s80
        QwEkUwshOR8odApb8B77H2aLMouBdQ9fvx56v6ZdqwmdcKAxblryaNQeYMSJQ7vQDjRC+x
        4v0YY7f+YRZ90ul7oM1dDbx6GJy+qoo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7d2b3757 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 25 Oct 2022 00:03:29 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v2] ALSA: rme9652: use explicitly signed char
Date:   Tue, 25 Oct 2022 02:03:13 +0200
Message-Id: <20221025000313.546261-1-Jason@zx2c4.com>
In-Reply-To: <202210250456.vKv5zoLb-lkp@intel.com>
References: <202210250456.vKv5zoLb-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With char becoming unsigned by default, and with `char` alone being
ambiguous and based on architecture, signed chars need to be marked
explicitly as such. This fixes warnings like:

sound/pci/rme9652/hdsp.c:3953 hdsp_channel_buffer_location() warn: 'hdsp->channel_map[channel]' is unsigned
sound/pci/rme9652/hdsp.c:4153 snd_hdsp_channel_info() warn: impossible condition '(hdsp->channel_map[channel] < 0) => (0-255 < 0)'
sound/pci/rme9652/rme9652.c:1833 rme9652_channel_buffer_location() warn: 'rme9652->channel_map[channel]' is unsigned

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 sound/pci/rme9652/hdsp.c    | 26 +++++++++++++-------------
 sound/pci/rme9652/rme9652.c | 22 +++++++++++-----------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index dcc43a81ae0e..65add92c88aa 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -433,7 +433,7 @@ struct hdsp_midi {
     struct snd_rawmidi           *rmidi;
     struct snd_rawmidi_substream *input;
     struct snd_rawmidi_substream *output;
-    char                     istimer; /* timer in use */
+    signed char		     istimer; /* timer in use */
     struct timer_list	     timer;
     spinlock_t               lock;
     int			     pending;
@@ -480,7 +480,7 @@ struct hdsp {
 	pid_t                 playback_pid;
 	int                   running;
 	int                   system_sample_rate;
-	const char           *channel_map;
+	const signed char    *channel_map;
 	int                   dev;
 	int                   irq;
 	unsigned long         port;
@@ -502,7 +502,7 @@ struct hdsp {
    where the data for that channel can be read/written from/to.
 */
 
-static const char channel_map_df_ss[HDSP_MAX_CHANNELS] = {
+static const signed char channel_map_df_ss[HDSP_MAX_CHANNELS] = {
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
 	18, 19, 20, 21, 22, 23, 24, 25
 };
@@ -517,7 +517,7 @@ static const char channel_map_mf_ss[HDSP_MAX_CHANNELS] = { /* Multiface */
 	-1, -1, -1, -1, -1, -1, -1, -1
 };
 
-static const char channel_map_ds[HDSP_MAX_CHANNELS] = {
+static const signed char channel_map_ds[HDSP_MAX_CHANNELS] = {
 	/* ADAT channels are remapped */
 	1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23,
 	/* channels 12 and 13 are S/PDIF */
@@ -526,7 +526,7 @@ static const char channel_map_ds[HDSP_MAX_CHANNELS] = {
 	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
 };
 
-static const char channel_map_H9632_ss[HDSP_MAX_CHANNELS] = {
+static const signed char channel_map_H9632_ss[HDSP_MAX_CHANNELS] = {
 	/* ADAT channels */
 	0, 1, 2, 3, 4, 5, 6, 7,
 	/* SPDIF */
@@ -540,7 +540,7 @@ static const char channel_map_H9632_ss[HDSP_MAX_CHANNELS] = {
 	-1, -1
 };
 
-static const char channel_map_H9632_ds[HDSP_MAX_CHANNELS] = {
+static const signed char channel_map_H9632_ds[HDSP_MAX_CHANNELS] = {
 	/* ADAT */
 	1, 3, 5, 7,
 	/* SPDIF */
@@ -554,7 +554,7 @@ static const char channel_map_H9632_ds[HDSP_MAX_CHANNELS] = {
 	-1, -1, -1, -1, -1, -1
 };
 
-static const char channel_map_H9632_qs[HDSP_MAX_CHANNELS] = {
+static const signed char channel_map_H9632_qs[HDSP_MAX_CHANNELS] = {
 	/* ADAT is disabled in this mode */
 	/* SPDIF */
 	8, 9,
@@ -3939,7 +3939,7 @@ static snd_pcm_uframes_t snd_hdsp_hw_pointer(struct snd_pcm_substream *substream
 	return hdsp_hw_pointer(hdsp);
 }
 
-static char *hdsp_channel_buffer_location(struct hdsp *hdsp,
+static signed char *hdsp_channel_buffer_location(struct hdsp *hdsp,
 					     int stream,
 					     int channel)
 
@@ -3964,7 +3964,7 @@ static int snd_hdsp_playback_copy(struct snd_pcm_substream *substream,
 				  void __user *src, unsigned long count)
 {
 	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
-	char *channel_buf;
+	signed char *channel_buf;
 
 	if (snd_BUG_ON(pos + count > HDSP_CHANNEL_BUFFER_BYTES))
 		return -EINVAL;
@@ -3982,7 +3982,7 @@ static int snd_hdsp_playback_copy_kernel(struct snd_pcm_substream *substream,
 					 void *src, unsigned long count)
 {
 	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
-	char *channel_buf;
+	signed char *channel_buf;
 
 	channel_buf = hdsp_channel_buffer_location(hdsp, substream->pstr->stream, channel);
 	if (snd_BUG_ON(!channel_buf))
@@ -3996,7 +3996,7 @@ static int snd_hdsp_capture_copy(struct snd_pcm_substream *substream,
 				 void __user *dst, unsigned long count)
 {
 	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
-	char *channel_buf;
+	signed char *channel_buf;
 
 	if (snd_BUG_ON(pos + count > HDSP_CHANNEL_BUFFER_BYTES))
 		return -EINVAL;
@@ -4014,7 +4014,7 @@ static int snd_hdsp_capture_copy_kernel(struct snd_pcm_substream *substream,
 					void *dst, unsigned long count)
 {
 	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
-	char *channel_buf;
+	signed char *channel_buf;
 
 	channel_buf = hdsp_channel_buffer_location(hdsp, substream->pstr->stream, channel);
 	if (snd_BUG_ON(!channel_buf))
@@ -4028,7 +4028,7 @@ static int snd_hdsp_hw_silence(struct snd_pcm_substream *substream,
 			       unsigned long count)
 {
 	struct hdsp *hdsp = snd_pcm_substream_chip(substream);
-	char *channel_buf;
+	signed char *channel_buf;
 
 	channel_buf = hdsp_channel_buffer_location (hdsp, substream->pstr->stream, channel);
 	if (snd_BUG_ON(!channel_buf))
diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 1d614fe89a6a..e7c320afefe8 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -230,7 +230,7 @@ struct snd_rme9652 {
 	int last_spdif_sample_rate;	/* so that we can catch externally ... */
 	int last_adat_sample_rate;	/* ... induced rate changes            */
 
-	const char *channel_map;
+	const signed char *channel_map;
 
 	struct snd_card *card;
 	struct snd_pcm *pcm;
@@ -247,12 +247,12 @@ struct snd_rme9652 {
    where the data for that channel can be read/written from/to.
 */
 
-static const char channel_map_9652_ss[26] = {
+static const signed char channel_map_9652_ss[26] = {
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17,
 	18, 19, 20, 21, 22, 23, 24, 25
 };
 
-static const char channel_map_9636_ss[26] = {
+static const signed char channel_map_9636_ss[26] = {
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 
 	/* channels 16 and 17 are S/PDIF */
 	24, 25,
@@ -260,7 +260,7 @@ static const char channel_map_9636_ss[26] = {
 	-1, -1, -1, -1, -1, -1, -1, -1
 };
 
-static const char channel_map_9652_ds[26] = {
+static const signed char channel_map_9652_ds[26] = {
 	/* ADAT channels are remapped */
 	1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23,
 	/* channels 12 and 13 are S/PDIF */
@@ -269,7 +269,7 @@ static const char channel_map_9652_ds[26] = {
 	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
 };
 
-static const char channel_map_9636_ds[26] = {
+static const signed char channel_map_9636_ds[26] = {
 	/* ADAT channels are remapped */
 	1, 3, 5, 7, 9, 11, 13, 15,
 	/* channels 8 and 9 are S/PDIF */
@@ -1819,7 +1819,7 @@ static snd_pcm_uframes_t snd_rme9652_hw_pointer(struct snd_pcm_substream *substr
 	return rme9652_hw_pointer(rme9652);
 }
 
-static char *rme9652_channel_buffer_location(struct snd_rme9652 *rme9652,
+static signed char *rme9652_channel_buffer_location(struct snd_rme9652 *rme9652,
 					     int stream,
 					     int channel)
 
@@ -1847,7 +1847,7 @@ static int snd_rme9652_playback_copy(struct snd_pcm_substream *substream,
 				     void __user *src, unsigned long count)
 {
 	struct snd_rme9652 *rme9652 = snd_pcm_substream_chip(substream);
-	char *channel_buf;
+	signed char *channel_buf;
 
 	if (snd_BUG_ON(pos + count > RME9652_CHANNEL_BUFFER_BYTES))
 		return -EINVAL;
@@ -1867,7 +1867,7 @@ static int snd_rme9652_playback_copy_kernel(struct snd_pcm_substream *substream,
 					    void *src, unsigned long count)
 {
 	struct snd_rme9652 *rme9652 = snd_pcm_substream_chip(substream);
-	char *channel_buf;
+	signed char *channel_buf;
 
 	channel_buf = rme9652_channel_buffer_location(rme9652,
 						      substream->pstr->stream,
@@ -1883,7 +1883,7 @@ static int snd_rme9652_capture_copy(struct snd_pcm_substream *substream,
 				    void __user *dst, unsigned long count)
 {
 	struct snd_rme9652 *rme9652 = snd_pcm_substream_chip(substream);
-	char *channel_buf;
+	signed char *channel_buf;
 
 	if (snd_BUG_ON(pos + count > RME9652_CHANNEL_BUFFER_BYTES))
 		return -EINVAL;
@@ -1903,7 +1903,7 @@ static int snd_rme9652_capture_copy_kernel(struct snd_pcm_substream *substream,
 					   void *dst, unsigned long count)
 {
 	struct snd_rme9652 *rme9652 = snd_pcm_substream_chip(substream);
-	char *channel_buf;
+	signed char *channel_buf;
 
 	channel_buf = rme9652_channel_buffer_location(rme9652,
 						      substream->pstr->stream,
@@ -1919,7 +1919,7 @@ static int snd_rme9652_hw_silence(struct snd_pcm_substream *substream,
 				  unsigned long count)
 {
 	struct snd_rme9652 *rme9652 = snd_pcm_substream_chip(substream);
-	char *channel_buf;
+	signed char *channel_buf;
 
 	channel_buf = rme9652_channel_buffer_location (rme9652,
 						       substream->pstr->stream,
-- 
2.38.1

