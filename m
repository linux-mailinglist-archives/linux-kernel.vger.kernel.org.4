Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3291A70D650
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbjEWH5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbjEWH4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:56:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F95A10E2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 00:55:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 68B942040D;
        Tue, 23 May 2023 07:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1684828447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TygGfmhyxHyXtO48ucZvDwYqdaCkFLRB2qITd7bHM2E=;
        b=spLCdVUSBOL1ydTQEo23AMV6VgxobeyHa2dCzCjAVgnS8XxN9lVMXGkNGIc7hxQvE8XguZ
        eseQ4BEd/mqqoyyem53sqj3iyE+eIuBl5flVzN75+V09d8BR8Tl1lGXiuFYBSxvvR9moBA
        UIKXMpCDPnrPd4AC/ZC5ke5j4yF8/8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1684828447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TygGfmhyxHyXtO48ucZvDwYqdaCkFLRB2qITd7bHM2E=;
        b=cvLknQse9tQL16PGNajENYNTBkDL3gHpSCpwsYdEDQsOyn/nArxG+eEgWiwpbWjsO/vHhq
        HJXZ5lBOfsIWERBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2944B13A1A;
        Tue, 23 May 2023 07:54:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SCYhBx9xbGT4KgAAMHmgww
        (envelope-from <tiwai@suse.de>); Tue, 23 May 2023 07:54:07 +0000
From:   Takashi Iwai <tiwai@suse.de>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/37] ALSA: usb-audio: Enable the legacy raw MIDI support
Date:   Tue, 23 May 2023 09:53:36 +0200
Message-Id: <20230523075358.9672-16-tiwai@suse.de>
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

Attach the legacy rawmidi devices when enabled in Kconfig accordingly.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/midi2.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/sound/usb/midi2.c b/sound/usb/midi2.c
index 7e849b2384ee..f3fba8b07cb3 100644
--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -857,6 +857,25 @@ static int create_blocks_from_gtb(struct snd_usb_midi2_interface *umidi)
 	return 0;
 }
 
+/* attach legacy rawmidis */
+static int attach_legacy_rawmidi(struct snd_usb_midi2_interface *umidi)
+{
+#if IS_ENABLED(CONFIG_SND_UMP_LEGACY_RAWMIDI)
+	struct snd_usb_midi2_ump *rmidi;
+	int err;
+
+	list_for_each_entry(rmidi, &umidi->rawmidi_list, list) {
+		err = snd_ump_attach_legacy_rawmidi(rmidi->ump,
+						    "Legacy MIDI",
+						    umidi->chip->num_rawmidis);
+		if (err < 0)
+			return err;
+		umidi->chip->num_rawmidis++;
+	}
+#endif
+	return 0;
+}
+
 static void snd_usb_midi_v2_free(struct snd_usb_midi2_interface *umidi)
 {
 	free_all_midi2_endpoints(umidi);
@@ -922,7 +941,7 @@ static int parse_midi_2_0(struct snd_usb_midi2_interface *umidi)
 		}
 	}
 
-	return 0;
+	return attach_legacy_rawmidi(umidi);
 }
 
 /* is the given interface for MIDI 2.0? */
@@ -991,6 +1010,12 @@ static void set_fallback_rawmidi_names(struct snd_usb_midi2_interface *umidi)
 			usb_string(dev, dev->descriptor.iSerialNumber,
 				   ump->info.product_id,
 				   sizeof(ump->info.product_id));
+#if IS_ENABLED(CONFIG_SND_UMP_LEGACY_RAWMIDI)
+		if (ump->legacy_rmidi && !*ump->legacy_rmidi->name)
+			snprintf(ump->legacy_rmidi->name,
+				 sizeof(ump->legacy_rmidi->name),
+				 "%s (MIDI 1.0)", ump->info.name);
+#endif
 	}
 }
 
-- 
2.35.3

