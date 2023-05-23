Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C700870D633
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjEWH4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbjEWHy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:54:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E001D10F8
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:54:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C495C20409;
        Tue, 23 May 2023 07:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DsZiH7AE6CokpKw2dE4gaR8qL2hUFyIdDhBwv7w0K4s=;
        b=y3bhBJashklzYYiMWEd7PtXwL1khNccdDUPp3ZAus6lOVF6iwCpNI2KfRXHTz1baCYl4HY
        u490oHqi3Wd0xTDxKo55KpjcVMiAKmxahlhRAEQntTHD0Q1z7gZsqyNfV/iwC1fPR/yVYH
        DnOMPbTeCjV7PNEpyYCZl9J5G2LvaHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828444;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DsZiH7AE6CokpKw2dE4gaR8qL2hUFyIdDhBwv7w0K4s=;
        b=myq9CoN4kIrOtkN/IHg5IWuKRzFSYPRayDoMRA4YZX5J+6XQr0ayzE1v72jCADQVc4mHGf
        TTNOLmh5/f5OlpCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4028A13A1A;
        Tue, 23 May 2023 07:54:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QCELDBxxbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:04 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/37] ALSA: usb-audio: Manage number of rawmidis globally
Date:   Tue, 23 May 2023 09:53:28 +0200
Message-Id: <20230523075358.9672-8-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230523075358.9672-1-tiwai@suse.de>
References: <20230523075358.9672-1-tiwai@suse.de>
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

We're going to create rawmidi objects for MIDI 2.0 in a different code
from the current code for USB-MIDI 1.0.  As a preliminary work, this
patch adds the number of rawmidi objects to keep globally in a
USB-audio card instance, so that it can be referred from both MIDI 1.0
and 2.0 code.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c     | 5 +++--
 sound/usb/midi.c     | 7 ++++++-
 sound/usb/midi.h     | 5 +++--
 sound/usb/quirks.c   | 5 +++--
 sound/usb/usbaudio.h | 1 +
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index f6e99ced8068..bd051e634516 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -179,8 +179,9 @@ static int snd_usb_create_stream(struct snd_usb_audio *chip, int ctrlif, int int
 	     altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC) &&
 	    altsd->bInterfaceSubClass == USB_SUBCLASS_MIDISTREAMING) {
 		int err = __snd_usbmidi_create(chip->card, iface,
-					     &chip->midi_list, NULL,
-					     chip->usb_id);
+					       &chip->midi_list, NULL,
+					       chip->usb_id,
+					       &chip->num_rawmidis);
 		if (err < 0) {
 			dev_err(&dev->dev,
 				"%u:%d: cannot create sequencer device\n",
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 2839f6b6f09b..6b0993258e03 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -2461,7 +2461,8 @@ int __snd_usbmidi_create(struct snd_card *card,
 			 struct usb_interface *iface,
 			 struct list_head *midi_list,
 			 const struct snd_usb_audio_quirk *quirk,
-			 unsigned int usb_id)
+			 unsigned int usb_id,
+			 unsigned int *num_rawmidis)
 {
 	struct snd_usb_midi *umidi;
 	struct snd_usb_midi_endpoint_info endpoints[MIDI_MAX_ENDPOINTS];
@@ -2476,6 +2477,8 @@ int __snd_usbmidi_create(struct snd_card *card,
 	umidi->iface = iface;
 	umidi->quirk = quirk;
 	umidi->usb_protocol_ops = &snd_usbmidi_standard_ops;
+	if (num_rawmidis)
+		umidi->next_midi_device = *num_rawmidis;
 	spin_lock_init(&umidi->disc_lock);
 	init_rwsem(&umidi->disc_rwsem);
 	mutex_init(&umidi->mutex);
@@ -2595,6 +2598,8 @@ int __snd_usbmidi_create(struct snd_card *card,
 	usb_autopm_get_interface_no_resume(umidi->iface);
 
 	list_add_tail(&umidi->list, midi_list);
+	if (num_rawmidis)
+		*num_rawmidis = umidi->next_midi_device;
 	return 0;
 
 free_midi:
diff --git a/sound/usb/midi.h b/sound/usb/midi.h
index 3f153195c841..2100f1486b03 100644
--- a/sound/usb/midi.h
+++ b/sound/usb/midi.h
@@ -46,14 +46,15 @@ int __snd_usbmidi_create(struct snd_card *card,
 			 struct usb_interface *iface,
 			 struct list_head *midi_list,
 			 const struct snd_usb_audio_quirk *quirk,
-			 unsigned int usb_id);
+			 unsigned int usb_id,
+			 unsigned int *num_rawmidis);
 
 static inline int snd_usbmidi_create(struct snd_card *card,
 		       struct usb_interface *iface,
 		       struct list_head *midi_list,
 		       const struct snd_usb_audio_quirk *quirk)
 {
-	return __snd_usbmidi_create(card, iface, midi_list, quirk, 0);
+	return __snd_usbmidi_create(card, iface, midi_list, quirk, 0, NULL);
 }
 
 void snd_usbmidi_input_stop(struct list_head *p);
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 3ecd1ba7fd4b..1cabe4cc019f 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -436,8 +436,9 @@ static int create_uaxx_quirk(struct snd_usb_audio *chip,
 			chip->usb_id == USB_ID(0x0582, 0x002b)
 			? &ua700_quirk : &uaxx_quirk;
 		return __snd_usbmidi_create(chip->card, iface,
-					  &chip->midi_list, quirk,
-					  chip->usb_id);
+					    &chip->midi_list, quirk,
+					    chip->usb_id,
+					    &chip->num_rawmidis);
 	}
 
 	if (altsd->bNumEndpoints != 1)
diff --git a/sound/usb/usbaudio.h b/sound/usb/usbaudio.h
index 38a85b2c9a73..b1fa0a377866 100644
--- a/sound/usb/usbaudio.h
+++ b/sound/usb/usbaudio.h
@@ -49,6 +49,7 @@ struct snd_usb_audio {
 	struct list_head clock_ref_list; /* list of clock refcounts */
 	int pcm_devs;
 
+	unsigned int num_rawmidis;	/* number of created rawmidi devices */
 	struct list_head midi_list;	/* list of midi interfaces */
 
 	struct list_head mixer_list;	/* list of mixer interfaces */
-- 
2.35.3

