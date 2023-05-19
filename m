Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7811C70931A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjESJbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjESJbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:31:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B199019F
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:31:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA4CC222AD;
        Fri, 19 May 2023 09:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684488689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zon1yFnd9RH3Y9u315SCPy4ZtEA2xMOWjfsKCVt5to0=;
        b=lTk1PzNng2x+hVDH+tEiUZjrjLESHNXknhaorfMeTmI9zPkAGQwhPKOI5lb6J3DH0HRe1f
        esDHJvt1qAFJdIHYFCHwNlam304/Kljg8Nbfrv+MoLzih4/2c4e08vJ5CLCBc7u9qBs/9G
        QI8iQSFtiFBJOZLJEGjKuJPj6LsKVu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684488689;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zon1yFnd9RH3Y9u315SCPy4ZtEA2xMOWjfsKCVt5to0=;
        b=K6lUm1UgANSZVpNkO+7hm6zT2MkTHcWStiW7jcon+GWAKsnLKwcD0F0omFiRVY8JkueKAc
        VrMyYyQBX20d9qAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B927413A12;
        Fri, 19 May 2023 09:31:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qHcYLPFBZ2RXJAAAMHmgww
        (envelope-from <tiwai@suse.de>); Fri, 19 May 2023 09:31:29 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 01/36] ALSA: rawmidi: Pass rawmidi directly to snd_rawmidi_kernel_open()
Date:   Fri, 19 May 2023 11:30:39 +0200
Message-Id: <20230519093114.28813-2-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230519093114.28813-1-tiwai@suse.de>
References: <20230519093114.28813-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_rawmidi_kernel_open() is used only internally from ALSA sequencer,
so far, and parsing the card / device matching table at each open is
redundant, as each sequencer client already gets the rawmidi object
beforehand.

This patch optimizes the path by passing the rawmidi object directly
at snd_rawmidi_kernel_open().  This is also a preparation for the
upcoming UMP rawmidi I/O support.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/rawmidi.h   |  2 +-
 sound/core/rawmidi.c      | 17 ++++-------------
 sound/core/seq/seq_midi.c |  8 ++++----
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/include/sound/rawmidi.h b/include/sound/rawmidi.h
index e1f59b2940af..52b1cbfb2526 100644
--- a/include/sound/rawmidi.h
+++ b/include/sound/rawmidi.h
@@ -161,7 +161,7 @@ int snd_rawmidi_proceed(struct snd_rawmidi_substream *substream);
 /* main midi functions */
 
 int snd_rawmidi_info_select(struct snd_card *card, struct snd_rawmidi_info *info);
-int snd_rawmidi_kernel_open(struct snd_card *card, int device, int subdevice,
+int snd_rawmidi_kernel_open(struct snd_rawmidi *rmidi, int subdevice,
 			    int mode, struct snd_rawmidi_file *rfile);
 int snd_rawmidi_kernel_release(struct snd_rawmidi_file *rfile);
 int snd_rawmidi_output_params(struct snd_rawmidi_substream *substream,
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 7147fda66d93..589b75087d27 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -406,24 +406,15 @@ static int rawmidi_open_priv(struct snd_rawmidi *rmidi, int subdevice, int mode,
 }
 
 /* called from sound/core/seq/seq_midi.c */
-int snd_rawmidi_kernel_open(struct snd_card *card, int device, int subdevice,
+int snd_rawmidi_kernel_open(struct snd_rawmidi *rmidi, int subdevice,
 			    int mode, struct snd_rawmidi_file *rfile)
 {
-	struct snd_rawmidi *rmidi;
-	int err = 0;
+	int err;
 
 	if (snd_BUG_ON(!rfile))
 		return -EINVAL;
-
-	mutex_lock(&register_mutex);
-	rmidi = snd_rawmidi_search(card, device);
-	if (!rmidi)
-		err = -ENODEV;
-	else if (!try_module_get(rmidi->card->module))
-		err = -ENXIO;
-	mutex_unlock(&register_mutex);
-	if (err < 0)
-		return err;
+	if (!try_module_get(rmidi->card->module))
+		return -ENXIO;
 
 	mutex_lock(&rmidi->open_mutex);
 	err = rawmidi_open_priv(rmidi, subdevice, mode, rfile);
diff --git a/sound/core/seq/seq_midi.c b/sound/core/seq/seq_midi.c
index 4589aac09154..2b5fff80de58 100644
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -38,6 +38,7 @@ MODULE_PARM_DESC(input_buffer_size, "Input buffer size in bytes.");
 /* data for this midi synth driver */
 struct seq_midisynth {
 	struct snd_card *card;
+	struct snd_rawmidi *rmidi;
 	int device;
 	int subdevice;
 	struct snd_rawmidi_file input_rfile;
@@ -168,8 +169,7 @@ static int midisynth_subscribe(void *private_data, struct snd_seq_port_subscribe
 	struct snd_rawmidi_params params;
 
 	/* open midi port */
-	err = snd_rawmidi_kernel_open(msynth->card, msynth->device,
-				      msynth->subdevice,
+	err = snd_rawmidi_kernel_open(msynth->rmidi, msynth->subdevice,
 				      SNDRV_RAWMIDI_LFLG_INPUT,
 				      &msynth->input_rfile);
 	if (err < 0) {
@@ -212,8 +212,7 @@ static int midisynth_use(void *private_data, struct snd_seq_port_subscribe *info
 	struct snd_rawmidi_params params;
 
 	/* open midi port */
-	err = snd_rawmidi_kernel_open(msynth->card, msynth->device,
-				      msynth->subdevice,
+	err = snd_rawmidi_kernel_open(msynth->rmidi, msynth->subdevice,
 				      SNDRV_RAWMIDI_LFLG_OUTPUT,
 				      &msynth->output_rfile);
 	if (err < 0) {
@@ -328,6 +327,7 @@ snd_seq_midisynth_probe(struct device *_dev)
 
 	for (p = 0; p < ports; p++) {
 		ms = &msynth[p];
+		ms->rmidi = rmidi;
 
 		if (snd_seq_midisynth_new(ms, card, device, p) < 0)
 			goto __nomem;
-- 
2.35.3

